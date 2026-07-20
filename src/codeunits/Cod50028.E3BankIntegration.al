codeunit 50028 "E3 Bank Integration"
{
    Permissions = tabledata "Bank Account Ledger Entry" = RIM,
    Tabledata "Detailed Vendor Ledg. Entry" = RIM;
    procedure CheckTemplateName(CurrentJnlTemplateName: Code[10]; var CurrentJnlBatchName: Code[10])
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        GenJnlBatch: Record "Gen. Journal Batch";
    begin
        GenJnlBatch.SetRange("Journal Template Name", CurrentJnlTemplateName);
        if not GenJnlBatch.Get(CurrentJnlTemplateName, CurrentJnlBatchName) then begin
            if not GenJnlBatch.FindFirst() then begin
                GenJnlBatch.Init();
                GenJnlBatch."Journal Template Name" := CurrentJnlTemplateName;
                GenJnlBatch.SetupNewBatch();
                GenJnlBatch.Name := Text004Lbl;
                GenJnlBatch.Description := Text005Lbl;
                GenJnlBatch.Insert(true);
                Commit();
            end;
            CurrentJnlBatchName := GenJnlBatch.Name
        end;
    end;

    procedure TemplateSelectionSimple(var GenJnlTemplate: Record "Gen. Journal Template"; TemplateType: Enum "Gen. Journal Template Type"; RecurringJnl: Boolean): Boolean
    begin
        GenJnlTemplate.Reset();
        GenJnlTemplate.SetRange(Type, TemplateType);
        GenJnlTemplate.SetRange(Recurring, RecurringJnl);
        exit(FindTemplateFromSelection(GenJnlTemplate, TemplateType, RecurringJnl));
    end;

    local procedure FindTemplateFromSelection(var GenJnlTemplate: Record "Gen. Journal Template"; TemplateType: Enum "Gen. Journal Template Type"; RecurringJnl: Boolean) TemplateSelected: Boolean
    begin
        TemplateSelected := true;
        case GenJnlTemplate.Count of
            0:
                begin
                    GenJnlTemplate.Init();
                    GenJnlTemplate.Type := TemplateType;
                    GenJnlTemplate.Recurring := RecurringJnl;
                    if not RecurringJnl then begin
                        GenJnlTemplate.Name := GetAvailableGeneralJournalTemplateName(Format(GenJnlTemplate.Type, MaxStrLen(GenJnlTemplate.Name)));
                        if TemplateType = GenJnlTemplate.Type::Assets then
                            GenJnlTemplate.Description := Text000Lbl
                        else
                            GenJnlTemplate.Description := StrSubstNo(Text001Lbl, GenJnlTemplate.Type);
                    end
                    else begin
                        GenJnlTemplate.Name := Text002Lbl;
                        GenJnlTemplate.Description := Text003Lbl;
                    end;
                    GenJnlTemplate.Validate(Type);
                    OnFindTemplateFromSelectionOnBeforeGenJnlTemplateInsert(GenJnlTemplate);
                    GenJnlTemplate.Insert();
                    Commit();
                end;
            1:
                GenJnlTemplate.FindFirst();
            else
                TemplateSelected := PAGE.RunModal(0, GenJnlTemplate) = ACTION::LookupOK;
        end;
    end;

    procedure GetAvailableGeneralJournalTemplateName(TemplateName: Code[10]): Code[10]
    var
        GenJnlTemplate: Record "Gen. Journal Template";
        PotentialTemplateName: Code[10];
        PotentialTemplateNameIncrement: Integer;
    begin
        // Make sure proposed value + incrementer will fit in Name field
        if StrLen(TemplateName) > 9 then TemplateName := Format(TemplateName, 9);
        GenJnlTemplate.Init();
        PotentialTemplateName := TemplateName;
        PotentialTemplateNameIncrement := 0;
        // Expecting few naming conflicts, but limiting to 10 iterations to avoid possible infinite loop.
        while PotentialTemplateNameIncrement < 10 do begin
            GenJnlTemplate.SetFilter(Name, PotentialTemplateName);
            if GenJnlTemplate.Count = 0 then exit(PotentialTemplateName);
            PotentialTemplateNameIncrement := PotentialTemplateNameIncrement + 1;
            PotentialTemplateName := TemplateName + Format(PotentialTemplateNameIncrement);
        end;
    end;

    local procedure OnFindTemplateFromSelectionOnBeforeGenJnlTemplateInsert(var GenJnlTemplate: Record "Gen. Journal Template")
    begin
    end;

    procedure SCExportTransactionRequestFile(var TempBankAccountLedgerEntry: Record 271 temporary)
    var
        BankIntegrationTable: Record "E3 Bank Integration";
        BankAccountLedgerEntry: Record 271;
        PPsetup: Record "Purchases & Payables Setup";
        NoSeriesLine: Record "No. Series Line";
        BankAccountTable: Record "Bank Account";
        NoSeriesMgmt: Codeunit "No. Series";
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        BeneficiaryName: Text[100];
        TextBuilder: TextBuilder;
        OutStream: OutStream;
        i: Integer;
        c: Char;
        CleanBeneficiaryName: Text[100];
        BeneficiaryAccNo: Text[50];
        CurrentDate: Date;
        DayTxt: Text[2];
        MonthTxt: Text[2];
        CurrentValue: Code[20];
        NextEntryNo: Integer;

    begin

        NextEntryNo := 0;
        BankIntegrationTable.SetCurrentKey(EntryNo);
        if BankIntegrationTable.FindLast() then
            NextEntryNo := BankIntegrationTable.EntryNo;

        //File Name
        CurrentDate := Today();
        DayTxt := Format(Date2DMY(CurrentDate, 1));   // day 1..31
        if StrLen(DayTxt) = 1 then
            DayTxt := '0' + DayTxt;

        MonthTxt := Format(Date2DMY(CurrentDate, 2)); // month 1..12
        if StrLen(MonthTxt) = 1 then
            MonthTxt := '0' + MonthTxt;
        PPSetup.Get();
        NoSeriesLine.Reset();
        NoSeriesLine.SetRange("Series Code", PPSetup."Bank File Series");
        if NoSeriesLine.FindFirst() then begin

            if NoSeriesLine."Last Date Used" <> CurrentDate then //begin
                                                                 // reset no series to start no.
                NoSeriesLine."Last No. Used" := NoSeriesLine."Starting No.";
            NoSeriesLine."Last Date Used" := CurrentDate;
            NoSeriesLine.Modify(true);
        end;
        //end;
        CurrentValue := NoSeriesMgmt.GetNextNo(PPSetup."Bank File Series", CurrentDate, true);


        BankAccountTable.Reset();
        BankAccountTable.SetRange("No.", TempBankAccountLedgerEntry."Bank Account No.");
        if BankAccountTable.find('-') then;

        FileName := StrSubstNo('%1_%2_%3%4%5.%6', BankAccountTable."Server Code", BankAccountTable."Client Code", BankAccountTable."Client Code 1", DayTxt, MonthTxt, CurrentValue);

        //  FileName := StrSubstNo('H2HCBX_RBINE_RBINE%1%2.%3', DayTxt, MonthTxt, CurrentValue);


        WITH TempBankAccountLedgerEntry DO BEGIN
            TempBankAccountLedgerEntry.SETRANGE("Bank Transaction Status", TempBankAccountLedgerEntry."Bank Transaction Status"::" ");
            IF FINDSET THEN
                repeat
                    Vendor.Reset();
                    Vendor.SetRange("No.", "Bal. Account No.");
                    if Vendor.find('-') then;
                    BeneficiaryName := CopyStr(Vendor.Name, 1, 40);
                    Beneficiaryemailid := Vendor."E-Mail";
                    BeneAddress1 := DelChr(Vendor.Address, '=', ',');
                    BeneAddress2 := DelChr(Vendor."Address 2", '=', ',');
                    BeneAddress3 := Vendor.City;

                    CleanBeneficiaryName := '';
                    for i := 1 to StrLen(BeneficiaryName) do begin
                        c := BeneficiaryName[i];
                        if (c in ['A' .. 'Z']) or (c in ['a' .. 'z']) or (c in ['0' .. '9']) or (c = ' ') then
                            CleanBeneficiaryName += c
                        else
                            CleanBeneficiaryName += ' ';
                    end;

                    // Clean Address 1 (Max 70 chars)
                    BeneAddress1 := '';
                    for i := 1 to StrLen(BeneAddress1) do begin
                        c := BeneAddress1[i];
                        if (c in ['A' .. 'Z']) or (c in ['a' .. 'z']) or (c in ['0' .. '9']) or (c = ' ') then
                            BeneAddress1 += c
                        else
                            BeneAddress1 += ' ';
                    end;
                    BeneAddress1 := CopyStr(BeneAddress1, 1, 50);

                    // Clean Address 2 (Max 70 chars)
                    BeneAddress2 := '';
                    for i := 1 to StrLen(BeneAddress2) do begin
                        c := BeneAddress2[i];
                        if (c in ['A' .. 'Z']) or (c in ['a' .. 'z']) or (c in ['0' .. '9']) or (c = ' ') then
                            BeneAddress2 += c
                        else
                            BeneAddress2 += ' ';
                    end;
                    BeneAddress2 := CopyStr(BeneAddress2, 1, 20);


                    // Optional: collapse multiple spaces into single space
                    while StrPos(CleanBeneficiaryName, '  ') > 0 do
                        CleanBeneficiaryName := DelStr(CleanBeneficiaryName, StrPos(CleanBeneficiaryName, '  '), 1);

                    BeneficiaryName := CleanBeneficiaryName;

                    // Only prints if BeneficiaryAccNo starts with HDFC
                    if CopyStr(TempBankAccountLedgerEntry."Recipient Bank IFSC Code", 1, 4) = 'HDFC' then
                        BeneficiaryAccNo := TempBankAccountLedgerEntry."Recipient Bank Account"
                    else
                        BeneficiaryAccNo := '';

                    VenBank.Reset();
                    VenBank.SetRange("Vendor No.", "Bal. Account No.");
                    if VenBank.Find('-') then
                        BeneBankName := VenBank.Name;
                    BeneBankBranchName := VenBank."Bank Branch No.";


                    if CopyStr(TempBankAccountLedgerEntry."Recipient Bank IFSC Code", 1, 4) = 'HDFC' then
                        PaymentTy := 'I'
                    else
                        if (CopyStr(TempBankAccountLedgerEntry."Recipient Bank IFSC Code", 1, 4) <> 'HDFC') then
                            if (Abs(TempBankAccountLedgerEntry.Amount) <= 200000) then
                                PaymentTy := 'N'
                            else
                                PaymentTy := 'R';

                    TextBuilder.AppendLine(
                        PaymentTy + ',' +
                        BeneficiaryAccNo + ',' +
                        TempBankAccountLedgerEntry."Recipient Bank Account" + ',' +
                        DelChr(DelChr(Format(TempBankAccountLedgerEntry.Amount, 0, 1), '=', ','), '=', '-') + ',' +
                        BeneficiaryName + ',' +
                        DraweeLocation + ',' +
                        PrintLocation + ',' +
                        BeneAddress1 + ',' +
                        BeneAddress2 + ',' +
                        BeneAddress3 + ',' +
                        BeneAddress4 + ',' +
                        BeneAddress5 + ',' +
                        TempBankAccountLedgerEntry."Bal. Account No." + ',' +
                        TempBankAccountLedgerEntry."Document No." + ',' +
                        Paymentdetails1 + ',' +
                        Paymentdetails2 + ',' +
                        Paymentdetails3 + ',' +
                        Paymentdetails4 + ',' +
                        Paymentdetails5 + ',' +
                        Paymentdetails6 + ',' +
                        Paymentdetails7 + ',' +
                        TempBankAccountLedgerEntry."Cheque No." + ',' +
                        Format(TempBankAccountLedgerEntry."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>') + ',' +
                        MICRNumber + ',' +
                        TempBankAccountLedgerEntry."Recipient Bank IFSC Code" + ',' +
                        TempBankAccountLedgerEntry."Recipient Bank Name" + ',' +
                        TempBankAccountLedgerEntry."Recipient Branch Name" + ',' +
                        Beneficiaryemailid
                        //TempBankAccountLedgerEntry."Global Dimension 1 Code"

                        );
                    // code to insert data in table  //sandeep
                    BankIntegrationTable.Init();
                    NextEntryNo += 1;
                    BankIntegrationTable.EntryNo := NextEntryNo;
                    BankIntegrationTable.PaymentTy := PaymentTy;
                    BankIntegrationTable.BeneficiaryAccNo := BeneficiaryAccNo;
                    BankIntegrationTable."Recipient Bank Account" := TempBankAccountLedgerEntry."Recipient Bank Account";
                    BankIntegrationTable.Amount := TempBankAccountLedgerEntry.Amount;
                    BankIntegrationTable.BeneficiaryName := BeneficiaryName;
                    BankIntegrationTable.DraweeLocation := DraweeLocation;
                    BankIntegrationTable.PrintLocation := PrintLocation;
                    BankIntegrationTable.BeneAddress1 := BeneAddress1;
                    BankIntegrationTable.BeneAddress2 := BeneAddress2;
                    BankIntegrationTable.BeneAddress3 := BeneAddress3;
                    BankIntegrationTable.BeneAddress4 := BeneAddress4;
                    BankIntegrationTable.BeneAddress5 := BeneAddress5;
                    BankIntegrationTable."Bal. Account No." := TempBankAccountLedgerEntry."Bal. Account No.";
                    BankIntegrationTable."Document No." := TempBankAccountLedgerEntry."Document No.";
                    BankIntegrationTable.Paymentdetails1 := Paymentdetails1;
                    BankIntegrationTable.Paymentdetails2 := Paymentdetails2;
                    BankIntegrationTable.Paymentdetails3 := Paymentdetails3;
                    BankIntegrationTable.Paymentdetails4 := Paymentdetails4;
                    BankIntegrationTable.Paymentdetails5 := Paymentdetails5;
                    BankIntegrationTable.Paymentdetails6 := Paymentdetails6;
                    BankIntegrationTable.Paymentdetails7 := Paymentdetails7;
                    BankIntegrationTable."Cheque No." := TempBankAccountLedgerEntry."Cheque No.";
                    BankIntegrationTable."Posting Date" := TempBankAccountLedgerEntry."Posting Date";
                    BankIntegrationTable.MICRNumber := MICRNumber;
                    BankIntegrationTable."Recipient Bank IFSC Code" := TempBankAccountLedgerEntry."Recipient Bank IFSC Code";
                    BankIntegrationTable."Recipient Bank Name" := TempBankAccountLedgerEntry."Recipient Bank Name";
                    BankIntegrationTable."Recipient Branch Name" := TempBankAccountLedgerEntry."Recipient Branch Name";
                    BankIntegrationTable.Beneficiaryemailid := Beneficiaryemailid;
                    BankIntegrationTable."Unit Code" := TempBankAccountLedgerEntry."Global Dimension 1 Code";
                    BankIntegrationTable."File Name" := FileName;
                    BankIntegrationTable."Bank Account Ledger Entry No." := TempBankAccountLedgerEntry."Entry No.";
                    BankIntegrationTable.Insert();
                // code to insert data in table // sandeep 

                until Next() = 0;

            TempBlob.CreateOutStream(OutStream);
            OutStream.WriteText(TextBuilder.ToText());

            // Download file
            FileName := (FileName + '');
            DownloadFromStream(TempBlob.CreateInStream(), '', '', '', FileName);
            IF FINDFIRST() THEN
                REPEAT
                    BankAccountLedgerEntry.GET("Entry No.");
                    BankAccountLedgerEntry."Bank Transaction Status" := BankAccountLedgerEntry."Bank Transaction Status"::"File Exported";
                    BankAccountLedgerEntry.MODIFY();
                UNTIL NEXT() = 0;
        end;
    end;

    var
        Vendor: Record Vendor;
        VenBank: Record "Vendor Bank Account";
        Text000Lbl: Label 'Fixed Asset G/L Journal';
#pragma warning disable AA0470
        Text001Lbl: Label '%1 journal';
#pragma warning restore AA0470
        Text002Lbl: Label 'RECURRING';
        Text003Lbl: Label 'Recurring General Journal';
        Text004Lbl: Label 'DEFAULT';
        Text005Lbl: Label 'Default Journal';

        PaymentTy: Text[1];
        DraweeLocation: Text[20];
        PrintLocation: Text[20];
        BeneAddress1: Text[100];
        BeneAddress2: Text[50];
        BeneAddress3: Text[50];
        BeneAddress4: Text[50];
        BeneAddress5: Text[50];
        Paymentdetails1: Text[50];
        Paymentdetails2: Text[50];
        Paymentdetails3: Text[50];
        Paymentdetails4: Text[50];
        Paymentdetails5: Text[50];
        Paymentdetails6: Text[50];
        Paymentdetails7: Text[50];
        MICRNumber: Text[30];
        BeneBankName: Text[100];
        BeneBankBranchName: Text[50];
        Beneficiaryemailid: Text[100];


}
