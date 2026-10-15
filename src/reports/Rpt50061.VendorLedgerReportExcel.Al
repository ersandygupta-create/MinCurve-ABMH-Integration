report 50061 "Vendor Ledger Report Excel"
{
    Caption = 'Vendor Ledger Report Excel';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.", "Date Filter";

            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                CalcFields = "Amount (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)", "Remaining Amt. (LCY)";
                DataItemLink = "Vendor No." = FIELD("No."),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code") ORDER(Ascending);

                trigger OnPreDataItem()
                begin
                    if VENDORpOSTINGgRP <> '' then
                        SetRange("Vendor Posting Group", VENDORpOSTINGgRP);
                    if GlobalDim <> '' then
                        SetRange("Global Dimension 1 Code", GlobalDim);
                    SetRange("Posting Date", StartDate, EndDate);

                    RunningBal := OpenBal;
                    SRNo := 0;
                    TotalCreditAmt := 0;
                    TotalDebitAmt := 0;

                    FromDate := GetRangeMin("Posting Date");
                    ToDate := GetRangeMax("Posting Date");
                end;

                trigger OnAfterGetRecord()
                begin
                    SRNo += 1;

                    vendpostinggroup.Reset();
                    if VENDORpOSTINGgRP <> '' then
                        vendpostinggroup.SetRange(Code, VENDORpOSTINGgRP)
                    else
                        vendpostinggroup.SetRange(Code, "Vendor Posting Group");
                    if vendpostinggroup.FindFirst() then
                        vendposgrpdesc := vendpostinggroup.Description;

                    Clear(LineNarrationValue);
                    Clear(VendInvNo);
                    Clear(VendInvDate);
                    Clear(RunningBalanceCRorDR);

                    // Fetch External Bill No / Document Date details
                    if T122.Get("Document No.") then begin
                        LineNarrationValue := T122."Posting Description";
                        VendInvNo := T122."Vendor Invoice No.";
                        VendInvDate := T122."Document Date";
                    end else
                        if T124.Get("Document No.") then begin
                            VendInvNo := T124."Vendor Cr. Memo No.";
                            LineNarrationValue := T124."Posting Description";
                            VendInvDate := T124."Document Date";
                        end;

                    Temp17.DeleteAll();
                    TempGL.DeleteAll();
                    T17.Reset();
                    T17.SetRange("Document No.", "Document No.");
                    if Vendor.GetFilter("Global Dimension 1 Filter") <> '' then
                        T17.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                    if Vendor.GetFilter("Global Dimension 2 Filter") <> '' then
                        T17.SetRange("Global Dimension 2 Code", "Global Dimension 2 Code");
                    T17.SetRange("Posting Date", "Posting Date");
                    if T17.FindSet() then begin
                        repeat
                            if T17."Entry No." = "Entry No." then begin
                                RunningBal := ((RunningBal + "Debit Amount (LCY)") - "Credit Amount (LCY)");
                                Clear(LineNarration);
                                LineNarration := T17."External Document No.";
                            end;
                        until T17.Next() = 0;
                    end else
                        CurrReport.Skip();

                    if LineNarrationValue = '' then
                        LineNarrationValue := LineNarration;

                    if RunningBal <> 0 then begin
                        if RunningBal > 0 then
                            RunningBalanceCRorDR := 'Dr'
                        else
                            RunningBalanceCRorDR := 'Cr';
                    end;

                    RunningBal1 := Abs(RunningBal);
                    TotalDebitAmt += "Vendor Ledger Entry"."Debit Amount (LCY)";
                    TotalCreditAmt += "Vendor Ledger Entry"."Credit Amount (LCY)";

                    // Fetch Cheque No and Cheque Date
                    txtChequeNo := '';
                    dtChequeDate := 0D;
                    recBankAccountLedgerEntry.Reset();
                    recBankAccountLedgerEntry.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
                    recBankAccountLedgerEntry.SetRange("Posting Date", "Vendor Ledger Entry"."Posting Date");
                    if recBankAccountLedgerEntry.FindFirst() then begin
                        txtChequeNo := recBankAccountLedgerEntry."Cheque No.";
                        dtChequeDate := recBankAccountLedgerEntry."Cheque Date";
                    end;
                    "Vendor Ledger Entry".CalcFields("E3 Narration");
                    // Fetch TDS Information
                    decTDSBaseAmount := 0;
                    decTDSAmount := 0;
                    cdAssessCode := '';
                    TDSEntry.Reset();
                    TDSEntry.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
                    TDSEntry.SetRange("Vendor No.", "Vendor Ledger Entry"."Vendor No.");
                    TDSEntry.SetRange("Transaction No.", "Vendor Ledger Entry"."Transaction No.");
                    if TDSEntry.FindFirst() then begin
                        decTDSBaseAmount := TDSEntry."TDS Base Amount";
                        decTDSAmount := TDSEntry."TDS Amount";
                        cdAssessCode := TDSEntry."Assessee Code";
                    end;

                    // Write 1 Single Excel Row matching the SSRS report columns
                    ExcelBuf.NewRow();
                    ExcelBuf.AddColumn("Posting Date", false, '', false, false, false, 'yyyy-mm-dd', ExcelBuf."Cell Type"::Date);
                    ExcelBuf.AddColumn("Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Document Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(VendInvNo, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

                    ExcelBuf.AddColumn("Document Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Vendor Ledger Entry"."E3 Narration", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    // ExcelBuf.AddColumn(txtChequeNo, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(cdAssessCode, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(decTDSBaseAmount, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(decTDSAmount, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn("Debit Amount (LCY)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn("Credit Amount (LCY)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn("Remaining Amt. (LCY)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    // Fixed Running Balance Display
                    ExcelBuf.AddColumn(RunningBal1, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(RunningBalanceCRorDR, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                end;
            }

            trigger OnPreDataItem()
            begin
                if GetFilter("Date Filter") = '' then
                    Error('Please Enter the Date Filter.');
                StartDate := GetRangeMin("Date Filter");
                EndDate := GetRangeMax("Date Filter");

                // Print Company Information Header at the top
                MakeCompanyHeader();
            end;

            trigger OnAfterGetRecord()
            var
                VendorLedgEntryCheck: Record "Vendor Ledger Entry";
                HasEntries: Boolean;
            begin
                Clear(OpenBal);
                Clear(CloseBal);

                // Calculate Opening Balance
                T25.Reset();
                T25.SetRange("Vendor No.", "No.");
                T25.SetFilter("Posting Date", '<%1', GetRangeMin("Date Filter"));
                if VENDORpOSTINGgRP <> '' then
                    T25.SetFilter("Vendor Posting Group", VENDORpOSTINGgRP);
                if GlobalDim <> '' then
                    T25.SetFilter("Global Dimension 1 Code", GlobalDim);
                if GetFilter("Global Dimension 1 Filter") <> '' then
                    T25.SetFilter("Global Dimension 1 Code", '%1', GetFilter("Global Dimension 1 Filter"));
                if GetFilter(Vendor."Global Dimension 2 Filter") <> '' then
                    T25.SetFilter("Global Dimension 2 Code", '%1', GetFilter(Vendor."Global Dimension 2 Filter"));
                T25.SetAutoCalcFields("Amount (LCY)");
                if T25.FindSet() then
                    repeat
                        OpenBal := OpenBal + T25."Amount (LCY)";
                    until T25.Next() = 0;

                if OpenBal <> 0 then begin
                    if OpenBal > 0 then
                        OpeningDRorCR := 'Dr'
                    else
                        OpeningDRorCR := 'Cr';
                end;

                OpenBal1 := Abs(OpenBal);

                // Skip vendors with no entries and zero opening balance
                VendorLedgEntryCheck.Reset();
                VendorLedgEntryCheck.SetRange("Vendor No.", "No.");
                VendorLedgEntryCheck.SetRange("Posting Date", StartDate, EndDate);
                if VENDORpOSTINGgRP <> '' then
                    VendorLedgEntryCheck.SetRange("Vendor Posting Group", VENDORpOSTINGgRP);
                if GlobalDim <> '' then
                    VendorLedgEntryCheck.SetRange("Global Dimension 1 Code", GlobalDim);

                HasEntries := not VendorLedgEntryCheck.IsEmpty();

                if (not HasEntries) and (OpenBal = 0) then
                    CurrReport.Skip();

                // Calculate Closing Balance
                T25.Reset();
                T25.SetRange("Vendor No.", "No.");
                T25.SetFilter("Posting Date", '<=%1', GetRangeMax("Date Filter"));
                if VENDORpOSTINGgRP <> '' then
                    T25.SetFilter("Vendor Posting Group", VENDORpOSTINGgRP);
                if GlobalDim <> '' then
                    T25.SetFilter("Global Dimension 1 Code", GlobalDim);
                if GetFilter("Global Dimension 1 Filter") <> '' then
                    T25.SetFilter("Global Dimension 1 Code", '%1', GetFilter("Global Dimension 1 Filter"));
                if GetFilter(Vendor."Global Dimension 2 Filter") <> '' then
                    T25.SetFilter("Global Dimension 2 Code", '%1', GetFilter(Vendor."Global Dimension 2 Filter"));
                T25.SetAutoCalcFields("Amount (LCY)");
                if T25.FindSet() then
                    repeat
                        CloseBal := CloseBal + T25."Amount (LCY)";
                    until T25.Next() = 0;

                if CloseBal <> 0 then begin
                    if CloseBal > 0 then
                        ClosingDrorCR := 'Dr'
                    else
                        ClosingDrorCR := 'Cr';
                end;

                CloseBal1 := Abs(CloseBal);

                // Vendor Sub-Header block
                MakeVendorSubHeader();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(VENDORpOSTINGgRP; VENDORpOSTINGgRP)
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor Posting Group';
                        TableRelation = "Vendor Posting Group".Code;
                    }
                    field(GlobalDim; GlobalDim)
                    {
                        ApplicationArea = All;
                        Caption = 'Unit Code';
                        TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        AccountsFilter := '32011000000..32011888888|52000000000..52012999999|32014990000..32016888888|53012000000..53012888888|31011000000..31011188888';
        NoAccountsFilter := '<31011000000|>31011188888&<32011000000|>32011888888&<32014990000|>32016888888&<52000000000|>52012999999&<53012000000|>53012888888';
        VendorFilter := '32011000000..32011888888';
        ImprestFilter := '32014990000..32016888888|34011100019';
        CustomerFilter := '52000000000..52012999999';
        BankFilter := '53012000000..53012888888|31011000000..31011188888';

        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
        PrintedDateTime := CurrentDateTime();

        ExcelBuf.DeleteAll();
    end;

    trigger OnPostReport()
    begin
        ExcelBuf.CreateNewBook('Vendor Ledger');
        ExcelBuf.WriteSheet('Vendor Ledger', CompanyName, UserId);

        // Auto-fit column widths to prevent #### overflow errors in Excel
        ExcelBuf.SetFriendlyFilename('Vendor_Ledger_Report');

        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
    end;

    local procedure MakeCompanyHeader()
    begin
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(CompanyInformation.Name, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor Ledger', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(CompanyInformation.Address + ' ' + CompanyInformation."Address 2" + ' ' + CompanyInformation.City, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('PAN : ' + CompanyInformation."P.A.N. No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('GST No. : ' + CompanyInformation."GST Registration No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('From Date : ' + Format(StartDate, 0, '<Day,2>-<Month,2>-<Year4>'), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('To Date : ' + Format(EndDate, 0, '<Day,2>-<Month,2>-<Year4>'), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('UnitCode : ' + GlobalDim, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
    end;

    local procedure MakeVendorSubHeader()
    begin
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(Vendor."No." + ' : ' + Vendor.Name, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(Vendor.Address + ', ' + Vendor."Address 2" + ', ' + Vendor.City + ' ' + Vendor."Post Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Email : ' + Vendor."E-Mail", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('PAN : ' + Vendor."P.A.N. No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('GSTIN : ' + Vendor."GST Registration No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Opening Balance', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        // Pass OpenBal1 as Decimal Number instead of formatted String with text
        ExcelBuf.AddColumn(OpenBal1, false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(OpeningDRorCR, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow();
        // Matching Table Column Headers
        ExcelBuf.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Document No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Document Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Bill No', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Bill Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Narration', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('Cheque No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Assessee Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TDS Base Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TDS Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Debit Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Credit Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Remaining Amt LCY', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Running Balance', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Dr/Cr', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        T25: Record "Vendor Ledger Entry";
        CompanyInformation: Record "Company Information";
        OpenBal: Decimal;
        StartDate: Date;
        EndDate: Date;
        RunningBal: Decimal;
        VENDORpOSTINGgRP: Code[20];
        GlobalDim: Code[20];
        CloseBal: Decimal;
        LineNarration: Text;
        T17: Record "G/L Entry";
        Temp17: Record "G/L Entry" temporary;
        TempGL: Record "G/L Entry" temporary;
        GLAccNo: Code[20];
        T122: Record "Purch. Inv. Header";
        VendInvNo: Code[35];
        VendInvDate: Date;
        T124: Record "Purch. Cr. Memo Hdr.";
        AccountsFilter: Text[250];
        NoAccountsFilter: Text[250];
        VendorFilter: Text[250];
        CustomerFilter: Text[250];
        BankFilter: Text[250];
        ImprestFilter: Text[250];
        GLEntryRec: Record "G/L Entry";
        AccountNo: Code[20];
        AccountName: Text[50];
        T23: Record Vendor;
        T18: Record Customer;
        T270: Record "Bank Account";
        T480: Record "Dimension Set Entry";
        LineNarrationValue: Text;
        RunningBalanceCRorDR: Text;
        OpeningDRorCR: Text;
        ClosingDrorCR: Text;
        SRNo: Integer;
        RunningBal1: Decimal;
        OpenBal1: Decimal;
        CloseBal1: Decimal;
        TotalDebitAmt: Decimal;
        TotalCreditAmt: Decimal;
        vendpostinggroup: Record "Vendor Posting Group";
        vendposgrpdesc: Text[100];
        txtChequeNo: Text[40];
        dtChequeDate: Date;
        recBankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        cdAssessCode: Code[50];
        decTDSAmount: Decimal;
        decTDSBaseAmount: Decimal;
        TDSEntry: Record "TDS Entry";
        LocationAdd: Text[200];
        LocationAdd2: Text[200];
        LocCity: Text[30];
        LocPostCode: Text[20];
        FromDate: Date;
        ToDate: Date;
        PrintedDateTime: DateTime;
}