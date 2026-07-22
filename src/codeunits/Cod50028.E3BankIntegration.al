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
                    "Email ID" := Vendor."E-Mail";
                    BeneficiaryAdd1 := DelChr(Vendor.Address, '=', ',');
                    BeneficiaryAdd2 := DelChr(Vendor."Address 2", '=', ',');
                    BeneficiaryAdd3 := Vendor.City;

                    CleanBeneficiaryName := '';
                    for i := 1 to StrLen(BeneficiaryName) do begin
                        c := BeneficiaryName[i];
                        if (c in ['A' .. 'Z']) or (c in ['a' .. 'z']) or (c in ['0' .. '9']) or (c = ' ') then
                            CleanBeneficiaryName += c
                        else
                            CleanBeneficiaryName += ' ';
                    end;

                    // Clean Address 1 (Max 70 chars)
                    BeneficiaryAdd1 := DelChr(Vendor.Address, '=', ',');
                    CleanAddress1 := '';

                    for i := 1 to StrLen(BeneficiaryAdd1) do begin
                        c := BeneficiaryAdd1[i];
                        if (c in ['A' .. 'Z']) or (c in ['a' .. 'z']) or
                           (c in ['0' .. '9']) or (c = ' ') then
                            CleanAddress1 += c
                        else
                            CleanAddress1 += ' ';
                    end;

                    BeneficiaryAdd1 := CopyStr(CleanAddress1, 1, 50);

                    // Clean Address 2 (Max 70 chars)
                    BeneficiaryAdd2 := DelChr(Vendor."Address 2", '=', ',');
                    CleanAddress2 := '';

                    for i := 1 to StrLen(BeneficiaryAdd2) do begin
                        c := BeneficiaryAdd2[i];
                        if (c in ['A' .. 'Z']) or (c in ['a' .. 'z']) or
                           (c in ['0' .. '9']) or (c = ' ') then
                            CleanAddress2 += c
                        else
                            CleanAddress2 += ' ';
                    end;

                    BeneficiaryAdd2 := CopyStr(CleanAddress2, 1, 20);


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
                        "Beneficiary Bank Name" := VenBank.Name;
                    "Recipient Branch Name" := VenBank."Bank Branch No.";


                    if CopyStr(TempBankAccountLedgerEntry."Recipient Bank IFSC Code", 1, 4) = 'ICICI' then
                        "Record Identifier" := 'I'
                    else
                        if (CopyStr(TempBankAccountLedgerEntry."Recipient Bank IFSC Code", 1, 4) <> 'ICICI') then
                            if (Abs(TempBankAccountLedgerEntry.Amount) <= 200000) then
                                "Record Identifier" := 'N'
                            else
                                "Record Identifier" := 'R';

                    if CopyStr(TempBankAccountLedgerEntry."Recipient Bank IFSC Code", 1, 4) = 'ICICI' then
                        "Payment Indicator" := 'I'
                    else
                        if (CopyStr(TempBankAccountLedgerEntry."Recipient Bank IFSC Code", 1, 4) <> 'ICICI') then
                            if (Abs(TempBankAccountLedgerEntry.Amount) <= 200000) then
                                "Payment Indicator" := 'N'
                            else
                                "Payment Indicator" := 'R';

                    TextBuilder.AppendLine(
                        "Record Identifier" + '|' +
                        "Payment Indicator" + '|' +
                        TempBankAccountLedgerEntry."Document No." + '|' +
                        TempBankAccountLedgerEntry."Bal. Account No." + '|' +
                        BeneficiaryName + '|' +
                        DelChr(DelChr(Format(TempBankAccountLedgerEntry.Amount, 0, 1), '=', ','), '=', '-') + '|' +
                        Format(TempBankAccountLedgerEntry."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>') + '|' +
                        TempBankAccountLedgerEntry."Cheque No." + '|' +
                        "Debit Account No." + '|' +
                        TempBankAccountLedgerEntry."Recipient Bank Account" + '|' +
                        TempBankAccountLedgerEntry."Recipient Bank IFSC Code" + ',' +
                        TempBankAccountLedgerEntry."Recipient Bank Name" + '|' +
                        BeneficiaryAdd1 + '|' +
                        BeneficiaryAdd2 + '|' +
                        BeneficiaryAdd3 + '|' +
                        "Beneficiary Add 4" + '|' +
                        "Beneficiary Zip" + '|' +
                        "Debit Narration" + '|' +
                        "Print Location" + '|' +
                        "Payable Location" + '|' +
                        "Fiscal Year" + '|' +
                        "Company Code" + '|' +
                        "Email ID" + '|' +
                        "Mobile Number" + '|' +
                        "AADHAR Number" + '|' +
                        "Bene LEI Number" + '|' +
                        Format("Bene LEI Expiry Date", 0, '<Day,2>-<Month,2>-<Year4>') + '|' +
                        "Duplicate Validation Field"


                        );
                    // code to insert data in table  //sandeep
                    BankIntegrationTable.Init();
                    NextEntryNo += 1;
                    BankIntegrationTable.EntryNo := NextEntryNo;
                    BankIntegrationTable."Record Identifier" := "Record Identifier";
                    BankIntegrationTable."Payment Indicator" := "Payment Indicator";
                    BankIntegrationTable."SAP Document Number" := "SAP Document Number";
                    BankIntegrationTable."Vendor / Beneficiary Code" := "Vendor / Beneficiary Code";
                    BankIntegrationTable."Name of Beneficiary" := "Name of Beneficiary";
                    BankIntegrationTable."Instrument Amount" := "Instrument Amount";
                    BankIntegrationTable."Payment Date" := "Payment Date";
                    BankIntegrationTable."Cheque Number" := "Cheque Number";
                    BankIntegrationTable."Debit Account No." := "Debit Account No.";
                    BankIntegrationTable."Beneficiary Bank A/c No" := "Beneficiary Bank A/c No";
                    BankIntegrationTable."IFSC Code" := "IFSC Code";
                    BankIntegrationTable."Beneficiary Bank Name" := "Beneficiary Bank Name";
                    BankIntegrationTable."Beneficiary Add1" := BeneficiaryAdd1;
                    BankIntegrationTable."Beneficiary Add 2" := BeneficiaryAdd2;
                    BankIntegrationTable."Beneficiary Add 3" := BeneficiaryAdd3;
                    BankIntegrationTable."Beneficiary Add 4" := "Beneficiary Add 4";
                    BankIntegrationTable."Beneficiary Zip" := "Beneficiary Zip";
                    BankIntegrationTable."Debit Narration" := "Debit Narration";
                    BankIntegrationTable."Print Location" := "Print Location";
                    BankIntegrationTable."Payable Location" := "Payable Location";
                    BankIntegrationTable."Fiscal Year" := "Fiscal Year";
                    BankIntegrationTable."Company Code" := "Company Code";
                    BankIntegrationTable."Email ID" := "Email ID";
                    BankIntegrationTable."Mobile Number" := "Mobile Number";
                    BankIntegrationTable."AADHAR Number" := "AADHAR Number";
                    BankIntegrationTable."Bene LEI Number" := "Bene LEI Number";
                    BankIntegrationTable."Bene LEI Expiry Date" := "Bene LEI Expiry Date";
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
        CleanAddress1: Text[100];
        CleanAddress2: Text[100];
        "Record Identifier": Text[1];
        "Payment Indicator": Text[1];
        "SAP Document Number": Code[20];
        "Vendor / Beneficiary Code": Code[20];
        "Name of Beneficiary": Text[150];
        "Instrument Amount": Decimal;
        "Payment Date": Date;
        "Cheque Number": Code[6];
        "Debit Account No.": Code[12];
        "Beneficiary Bank A/c No": Code[30];
        "IFSC Code": Code[11];
        "Beneficiary Bank Name": Text[150];
        BeneficiaryAdd1: Text[100];
        BeneficiaryAdd2: Text[100];
        BeneficiaryAdd3: Text[100];
        "Beneficiary Add 4": Text[100];
        "Beneficiary Zip": Code[6];
        "Debit Narration": Text[28];
        "Print Location": Text[150];
        "Payable Location": Text[150];
        "Fiscal Year": Code[20];
        "Company Code": Label 'ABMH';
        "Email ID": Text[100];
        "Mobile Number": Code[10];
        "AADHAR Number": Code[12];
        "Bene LEI Number": Code[30];
        "Bene LEI Expiry Date": Date;
        "Duplicate Validation Field": Text[100];

}
