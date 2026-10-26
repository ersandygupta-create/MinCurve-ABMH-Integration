report 50063 "Customer Ledger Report - Excel"
{
    Caption = 'Customer Account Statement - Excel';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Location Code", "Customer Posting Group", "Date Filter";

            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter");
                DataItemTableView = SORTING("Customer No.", "Posting Date");
                RequestFilterFields = "Document No.";

                trigger OnPreDataItem()
                begin
                    CustLedgEntryExists := false;
                    SRNo := 0;
                    DataStartRow := ExcelRowNo;
                end;

                trigger OnAfterGetRecord()
                begin
                    SRNo += 1;
                    CalcFields(Amount, "Remaining Amount", "Amount (LCY)", "Original Amt. (LCY)", "Remaining Amt. (LCY)");
                    decCreditAmt := 0;
                    decDebitAmt := 0;
                    CustLedgEntryExists := true;

                    if ("Cust. Ledger Entry"."Original Amt. (LCY)" < 0) then
                        decCreditAmt := "Cust. Ledger Entry"."Original Amt. (LCY)"
                    else
                        decDebitAmt := "Cust. Ledger Entry"."Original Amt. (LCY)";

                    CustBalanceLCY := CustBalanceLCY + "Original Amt. (LCY)";

                    txtChequeNo := '';
                    dtChequeDate := 0D;
                    recBankAccountLedgerEntry.Reset();
                    recBankAccountLedgerEntry.SetRange("Document No.", "Document No.");
                    recBankAccountLedgerEntry.SetRange("Posting Date", "Posting Date");
                    recBankAccountLedgerEntry.SetRange("Transaction No.", "Transaction No.");
                    if recBankAccountLedgerEntry.FindFirst() then begin
                        txtChequeNo := recBankAccountLedgerEntry."Cheque No.";
                        dtChequeDate := recBankAccountLedgerEntry."Cheque Date";
                    end;

                    UTR := '';
                    recGLEntry.Reset();
                    recGLEntry.SetRange("Document No.", "Document No.");
                    recGLEntry.SetRange("Posting Date", "Posting Date");
                    recGLEntry.SetRange("Transaction No.", "Transaction No.");
                    if recGLEntry.FindFirst() then
                        UTR := recGLEntry."E3 UTR No.";

                    txtDescription := '';
                    if "Cust. Ledger Entry".Amount > 0 then begin
                        recGLEntry.Reset();
                        recGLEntry.SetRange("Document No.", "Cust. Ledger Entry"."Document No.");
                        recGLEntry.SetRange("Posting Date", "Cust. Ledger Entry"."Posting Date");
                        recGLEntry.SetFilter(Amount, '<0');
                        if recGLEntry.FindFirst() then;
                        if recGLEntry."Source Type" = recGLEntry."Source Type"::Vendor then begin
                            recVendor.Get(recGLEntry."Source No.");
                            txtDescription := recVendor.Name;
                        end else if recGLEntry."Source Type" = recGLEntry."Source Type"::"Bank Account" then begin
                            recBank.Get(recGLEntry."Source No.");
                            txtDescription := recBank.Name;
                        end else begin
                            if recGLAccount.Get(recGLEntry."G/L Account No.") then
                                txtDescription := recGLAccount.Name;
                        end;
                    end else begin
                        recGLEntry.Reset();
                        recGLEntry.SetRange("Document No.", "Cust. Ledger Entry"."Document No.");
                        recGLEntry.SetRange("Posting Date", "Cust. Ledger Entry"."Posting Date");
                        recGLEntry.SetFilter(Amount, '>0');
                        if recGLEntry.FindFirst() then;
                        if recGLEntry."Source Type" = recGLEntry."Source Type"::Vendor then begin
                            recVendor.Get(recGLEntry."Source No.");
                            txtDescription := recVendor.Name;
                        end else if recGLEntry."Source Type" = recGLEntry."Source Type"::"Bank Account" then begin
                            recBank.Get(recGLEntry."Source No.");
                            txtDescription := recBank.Name;
                        end else begin
                            if recGLAccount.Get(recGLEntry."G/L Account No.") then
                                txtDescription := recGLAccount.Name;
                        end;
                    end;

                    AddExcelRow(Format("Posting Date"), Format("Document Type"), "Document No.", txtDescription, "External Document No.", "E3 UHID", "E3 Patient Name", txtChequeNo + UTR, Format(dtChequeDate), decDebitAmt, decCreditAmt, CustBalanceLCY);
                end;

                trigger OnPostDataItem()
                begin
                    if SRNo > 0 then
                        AddExcelTotalRow();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                StartBalanceLCY := 0;
                CustBalanceLCY := 0;
                if CustDateFilter <> '' then begin
                    if GetRangeMin("Date Filter") <> 0D then begin
                        SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
                        CalcFields("Net Change (LCY)");
                        StartBalanceLCY := "Net Change (LCY)";
                    end;
                    SetFilter("Date Filter", CustDateFilter);
                    CalcFields("Net Change (LCY)");
                    StartBalanceLCY += "Net Change (LCY)";
                end;
                CustBalanceLCY := StartBalanceLCY;

                InitializeExcelCustomerBlock(Customer);
            end;

            trigger OnPreDataItem()
            begin
                FromDate := GetRangeMin("Date Filter");
                ToDate := GetRangeMax("Date Filter");
                InitializeExcelHeader();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ExcludeCustHaveaBalanceOnly; ExcludeBalanceOnly)
                    {
                        Caption = 'Exclude Customers That Have a Balance Only';
                        ApplicationArea = All;
                    }
                    field(PrintNarrationLine; PrintNarrationLine)
                    {
                        Caption = 'Print Narration';
                        ApplicationArea = All;
                    }
                    field("Not Show Item"; ShowItems)
                    {
                        Caption = 'Show Item';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        RecCompanyInfo.Get();
        RecCompanyInfo.CalcFields(RecCompanyInfo.Picture);
        CustDateFilter := Customer.GetFilter("Date Filter");
        if Customer.GetRangeMin("Date Filter") > Customer.GetRangeMax("Date Filter") then
            Error('Starting Date cannot be greater then Ending Date');
        TempExcelBuffer.DeleteAll();
    end;

    trigger OnPostReport()
    begin
        TempExcelBuffer.CreateNewBook('Customer Ledger');
        TempExcelBuffer.WriteSheet('Customer Ledger', RecCompanyInfo.Name, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.OpenExcel();
    end;

    var
        RecCompanyInfo: Record "Company Information";
        recBankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        recGLEntry: Record "G/L Entry";
        recVendor: Record "Vendor";
        recBank: Record "Bank Account";
        recGLAccount: Record "G/L Account";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        CustDateFilter: Text;
        FromDate: Date;
        ToDate: Date;
        ExcludeBalanceOnly: Boolean;
        PrintNarrationLine: Boolean;
        ShowItems: Boolean;
        CustLedgEntryExists: Boolean;
        StartBalanceLCY: Decimal;
        CustBalanceLCY: Decimal;
        decDebitAmt: Decimal;
        decCreditAmt: Decimal;
        txtDescription: Text[250];
        txtChequeNo: Text[50];
        dtChequeDate: Date;
        UTR: Text[50];
        ExcelRowNo: Integer;
        DataStartRow: Integer;
        SRNo: Integer;

    local procedure InitializeExcelHeader()
    begin
        ExcelRowNo := 1;
        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 1);
        TempExcelBuffer."Cell Value as Text" := RecCompanyInfo.Name;
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();
        ExcelRowNo += 1;

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 1);
        TempExcelBuffer."Cell Value as Text" := RecCompanyInfo.Address + ' ' + RecCompanyInfo."Address 2" + ', ' + RecCompanyInfo.City + '-' + RecCompanyInfo."Post Code";
        TempExcelBuffer.Insert();
        ExcelRowNo += 1;

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 1);
        TempExcelBuffer."Cell Value as Text" := 'Phone No. :' + RecCompanyInfo."Phone No." + ' | Email : ' + RecCompanyInfo."E-Mail" + ' | PAN : ' + RecCompanyInfo."P.A.N. No." + ' | GST No. : ' + RecCompanyInfo."GST Registration No.";
        TempExcelBuffer.Insert();
        ExcelRowNo += 2;

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 1);
        TempExcelBuffer."Cell Value as Text" := 'CUSTOMER ACCOUNT STATEMENT';
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();
        ExcelRowNo += 2;

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 1);
        TempExcelBuffer."Cell Value as Text" := 'From Date :';
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 2);
        TempExcelBuffer."Cell Value as Text" := Format(FromDate);
        TempExcelBuffer.Insert();

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 4);
        TempExcelBuffer."Cell Value as Text" := 'To Date :';
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 5);
        TempExcelBuffer."Cell Value as Text" := Format(ToDate);
        TempExcelBuffer.Insert();
        ExcelRowNo += 2;
    end;

    local procedure InitializeExcelCustomerBlock(Cust: Record Customer)
    begin
        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 1);
        TempExcelBuffer."Cell Value as Text" := 'Customer No. :';
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 2);
        TempExcelBuffer."Cell Value as Text" := Cust."No.";
        TempExcelBuffer.Insert();
        ExcelRowNo += 1;

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 1);
        TempExcelBuffer."Cell Value as Text" := 'Customer Name :';
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 2);
        TempExcelBuffer."Cell Value as Text" := Cust.Name;
        TempExcelBuffer.Insert();
        ExcelRowNo += 1;

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 1);
        TempExcelBuffer."Cell Value as Text" := 'Customer Address :';
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 2);
        TempExcelBuffer."Cell Value as Text" := Cust.Address + ', ' + Cust.City;
        TempExcelBuffer.Insert();
        ExcelRowNo += 1;

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 1);
        TempExcelBuffer."Cell Value as Text" := 'Customer Phone No. :';
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 2);
        TempExcelBuffer."Cell Value as Text" := Cust."Phone No.";
        TempExcelBuffer.Insert();
        ExcelRowNo += 1;

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 1);
        TempExcelBuffer."Cell Value as Text" := 'Customer E-Mail :';
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 2);
        TempExcelBuffer."Cell Value as Text" := Cust."E-Mail";
        TempExcelBuffer.Insert();
        ExcelRowNo += 1;

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 1);
        TempExcelBuffer."Cell Value as Text" := 'Customer PAN No. :';
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 2);
        TempExcelBuffer."Cell Value as Text" := Cust."P.A.N. No.";
        TempExcelBuffer.Insert();
        ExcelRowNo += 1;

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 1);
        TempExcelBuffer."Cell Value as Text" := 'Customer GSTIN :';
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 2);
        TempExcelBuffer."Cell Value as Text" := Cust."GST Registration No.";
        TempExcelBuffer.Insert();
        ExcelRowNo += 2;

        WriteHeaderColumns();
        ExcelRowNo += 1;

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 1);
        TempExcelBuffer."Cell Value as Text" := 'Opening Balance';
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 12);
        TempExcelBuffer."Cell Value as Text" := Format(StartBalanceLCY, 0, '<Precision,2:2><Standard Format,0>');
        TempExcelBuffer.Bold := true;
        TempExcelBuffer."Cell Type" := TempExcelBuffer."Cell Type"::Number;
        TempExcelBuffer.Insert();
        ExcelRowNo += 1;
    end;

    local procedure WriteHeaderColumns()
    begin
        WriteColHeader(1, 'Posting Date');
        WriteColHeader(2, 'Document Type');
        WriteColHeader(3, 'Document No.');
        WriteColHeader(4, 'Description');
        WriteColHeader(5, 'External Doc No.');
        WriteColHeader(6, 'UHID');
        WriteColHeader(7, 'Patient Name');
        WriteColHeader(8, 'Cheque No.');
        WriteColHeader(9, 'Cheque Date');
        WriteColHeader(10, 'Debit Amount');
        WriteColHeader(11, 'Credit Amount');
        WriteColHeader(12, 'Balance (LCY)');
    end;

    local procedure WriteColHeader(CNo: Integer; Title: Text)
    begin
        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", CNo);
        TempExcelBuffer."Cell Value as Text" := Title;
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();
    end;

    local procedure AddExcelRow(PDate: Text; DType: Text; DNo: Text; Dsc: Text; ExtDoc: Text; Uhid: Text; PatName: Text; ChqNo: Text; ChqDate: Text; DebAmt: Decimal; CredAmt: Decimal; BalAmt: Decimal)
    begin
        WriteCellText(1, PDate, false);
        WriteCellText(2, DType, false);
        WriteCellText(3, DNo, false);
        WriteCellText(4, Dsc, false);
        WriteCellText(5, ExtDoc, false);
        WriteCellText(6, Uhid, false);
        WriteCellText(7, PatName, false);
        WriteCellText(8, ChqNo, false);
        WriteCellText(9, ChqDate, false);

        if DebAmt <> 0 then
            WriteCellDecimal(10, DebAmt)
        else
            WriteCellText(10, '', false);

        if CredAmt <> 0 then
            WriteCellDecimal(11, CredAmt)
        else
            WriteCellText(11, '', false);

        WriteCellDecimal(12, BalAmt);
        ExcelRowNo += 1;
    end;

    local procedure WriteCellText(CNo: Integer; Val: Text; IsBold: Boolean)
    begin
        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", CNo);
        TempExcelBuffer."Cell Value as Text" := Val;
        TempExcelBuffer.Bold := IsBold;
        TempExcelBuffer.Insert();
    end;

    local procedure WriteCellDecimal(CNo: Integer; Val: Decimal)
    begin
        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", CNo);
        TempExcelBuffer."Cell Value as Text" := Format(Val, 0, '<Precision,2:2><Standard Format,0>');
        TempExcelBuffer.Bold := false;
        TempExcelBuffer."Cell Type" := TempExcelBuffer."Cell Type"::Number;
        TempExcelBuffer.Insert();
    end;

    local procedure AddExcelTotalRow()
    var
        DataEndRow: Integer;
    begin
        DataEndRow := ExcelRowNo - 1;
        if DataEndRow < DataStartRow then
            DataEndRow := DataStartRow;

        // 1. Write 'Total' label
        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 1);
        TempExcelBuffer."Cell Value as Text" := 'Total';
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();

        // 2. Debit Amount SUM Formula (Column 10 / J)
        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 10);
        TempExcelBuffer.Formula := '=SUM(J' + Format(DataStartRow) + ':J' + Format(DataEndRow) + ')';
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();

        // 3. Credit Amount SUM Formula (Column 11 / K)
        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 11);
        TempExcelBuffer.Formula := '=SUM(K' + Format(DataStartRow) + ':K' + Format(DataEndRow) + ')';
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();

        // 4. Balance Closing Reference (Column 12 / L)
        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", ExcelRowNo);
        TempExcelBuffer.Validate("Column No.", 12);
        TempExcelBuffer.Formula := '=L' + Format(DataEndRow);
        TempExcelBuffer.Bold := true;
        TempExcelBuffer.Insert();

        ExcelRowNo += 2;
    end;
}