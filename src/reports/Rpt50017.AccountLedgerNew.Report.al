report 50017 "Account Ledger Report Excel"
{
    Caption = 'Account Ledger Report';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("G/L Account No.", "Posting Date");
            RequestFilterFields = "Posting Date", "G/L Account No.";

            trigger OnAfterGetRecord()
            var
            begin

                MakeExcelDataBody_lFnc;
            end;

            trigger OnPreDataItem()
            begin
                TotalRecord_gInt := Count;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Window_gDlg.Close;
        CreateExcelBook_lFnc;
    end;

    trigger OnInitReport()
    begin
        Clear(ExcelBuffer_gRecTmp);
    end;

    trigger OnPreReport()

    begin
        Clear(ExcelBuffer_gRecTmp);
        ExcelBuffer_gRecTmp.DeleteAll();
        Commit();
        GLSetUp_gRec.Get;
        if "G/L Entry".GetFilter("Posting Date") = '' then
            Error(Text50002_gCtx);
        MakeExcelDataInfo_lFnc;
        Window_gDlg.Open(Text011 + Text012 + Text013);
    end;

    var
        PostedLineNaration_gRec: Record "Posted Narration";
        ExcelBuffer_gRecTmp: Record "Excel Buffer" temporary;
        Text50001_gCtx: Label 'Account Ledger';
        Text50002_gCtx: Label 'Please select date filer.';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        GLAccount_gRec: Record "G/L Account";
        RunningBal_gDec: Decimal;
        Narration_gTxt: Text;
        PreGLCode_gCod: Code[20];
        Text011: Label 'Export Data...\';
        Text012: Label 'Entry No. #1############\';
        Text013: Label '@2@@@@@@@@@@@@@@@@@';
        Window_gDlg: Dialog;
        TotalRecord_gInt: Integer;
        CurrRecord_gInt: Integer;
        GLSetUp_gRec: Record "General Ledger Setup";
        PurchCommentLine: Record "Purch. Comment Line";
        txtComment: Text;
        DimValue: Record "Dimension Value";
        DeptName: Text[50];
        OpeningBal: Decimal;
        ClosingBal: Decimal;

    local procedure MakeExcelDataInfo_lFnc()
    begin

        MakeExcelDataHeader_lFnc;
    end;

    local procedure MakeExcelDataHeader_lFnc()
    var
        GLAccount: Record "G/L Account";
        GLNo: Code[20];
        UnitCode: Code[20];
        PeriodTxt: Text[50];
        FromDate: Date;
        ToDate: Date;
        GLBalances: Dictionary of [Text, Decimal];
    begin

        GLNo := "G/L Entry".GetFilter("G/L Account No.");
        UnitCode := "G/L Entry".GetFilter("Global Dimension 1 Code");
        PeriodTxt := "G/L Entry".GetFilter("Posting Date");

        FromDate := "G/L Entry".GetRangeMin("Posting Date");
        ToDate := "G/L Entry".GetRangeMax("Posting Date");

        GLBalances := CalculateGLBalances(GLNo, FromDate, ToDate);
        OpeningBal := GLBalances.Get('OpeningBalance');
        ClosingBal := GLBalances.Get('ClosingBalance');

        ExcelBuffer_gRecTmp.NewRow;
        ExcelBuffer_gRecTmp.AddColumn('Account Ledger Report', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);

        ExcelBuffer_gRecTmp.NewRow;
        if GLNo <> '' then begin
            if GLAccount.Get(GLNo) then
                ExcelBuffer_gRecTmp.AddColumn('GL Name: ' + GLAccount.Name, false, '', true, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        end;

        ExcelBuffer_gRecTmp.NewRow;
        ExcelBuffer_gRecTmp.AddColumn('Unit: ' + UnitCode, false, '', true, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);

        ExcelBuffer_gRecTmp.NewRow;
        ExcelBuffer_gRecTmp.AddColumn('Period: ' + PeriodTxt, false, '', true, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);

        ExcelBuffer_gRecTmp.NewRow;
        ExcelBuffer_gRecTmp.AddColumn(StrSubstNo('Opening Balance: %1', Format(OpeningBal)), false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.NewRow;
        ExcelBuffer_gRecTmp.AddColumn(StrSubstNo('Closing Balance: %1', Format(ClosingBal)), false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.NewRow;

        ExcelBuffer_gRecTmp.NewRow;
        ExcelBuffer_gRecTmp.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Document Type', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Document No', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('G/L Account No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('G/L Account Name', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Vendor Name', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Payor Name', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Debit Amount', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Credit Amount', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('External Document No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Narration', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Voucher Narration', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('UTR No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('HIS Document Type', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Unit Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Dept Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Dept Name', false, '', true, false, true, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
    end;

    local procedure MakeExcelDataBody_lFnc()
    var
        BankAcc_lRec: Record "Bank Account";
        Vendor_lRec: Record Vendor;
        Customer_lRec: Record Customer;
        FixedAsset_lRec: Record "Fixed Asset";
        Settlement: Record "E3 HIS Settlement Staging";
    begin
        ExcelBuffer_gRecTmp.NewRow;
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."Posting Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Date);            //Posting Date
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."Document Type", false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);           //Document Type
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);            //Document No
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."G/L Account No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);
        "G/L Entry".CalcFields("G/L Account Name");
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."G/L Account Name", false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);               //Description
        if "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::"Bank Account" then begin
            if BankAcc_lRec.Get("G/L Entry"."Source No.") then
                ExcelBuffer_gRecTmp.AddColumn(BankAcc_lRec.Name, false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text)                    //Source Name
        end else
            if "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Vendor then begin
                if Vendor_lRec.Get("G/L Entry"."Source No.") then
                    ExcelBuffer_gRecTmp.AddColumn(Vendor_lRec.Name, false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text)                     //Source Name
            end else
                if "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Customer then begin
                    if Customer_lRec.Get("G/L Entry"."Source No.") then
                        ExcelBuffer_gRecTmp.AddColumn(Customer_lRec.Name, false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text)                   //Source Name
                end else
                    if "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::"Fixed Asset" then begin
                        if FixedAsset_lRec.Get("G/L Entry"."Source No.") then
                            ExcelBuffer_gRecTmp.AddColumn(FixedAsset_lRec.Description, false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text)          //Source Name
                    end else
                        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);                                    //Source Name
        Settlement.Reset();
        Settlement.SetRange("Document No.", "G/L Entry"."Document No.");
        if Settlement.FindFirst() then
            ExcelBuffer_gRecTmp.AddColumn(Settlement."Payer Name", false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text)
        else
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);//
        if "G/L Entry"."Debit Amount" <> 0 then
            ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."Debit Amount", false, '', false, false, false, '#,##0.00', ExcelBuffer_gRecTmp."Cell Type"::Number)  //Debit Amount
        else
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);                                   //Debit Amount

        if "G/L Entry"."Credit Amount" <> 0 then
            ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."Credit Amount", false, '', false, false, false, '#,##0.00', ExcelBuffer_gRecTmp."Cell Type"::Number)  //Credit Amount
        else
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);                                    //Credit Amount
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."External Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);   //External Document No.  

        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."E3 Narration", false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text); //Narration
        "G/L Entry".CalcFields("E3 Voucher Narration");
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."E3 Voucher Narration", false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text); //Voucher Narration
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."E3 UTR No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);           //Narration
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."E3 HIS Document Type", false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);       //Line Narration
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."Global Dimension 1 Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);               //Type
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."Global Dimension 2 Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);                //Source No.
        if "G/L Entry"."Global Dimension 2 Code" <> '' then
            DimValue.Reset();
        DimValue.SetRange(Code, "G/L Entry"."Global Dimension 2 Code");
        if DimValue.FindFirst() then
            DeptName := DimValue.Name;
        ExcelBuffer_gRecTmp.AddColumn(DeptName, false, '', false, false, false, '', ExcelBuffer_gRecTmp."Cell Type"::Text);                //Source No.        

    end;

    local procedure CreateExcelBook_lFnc()
    var
        ExcelFileNameLbl: Label 'AccountLedgerReport%1_%2', Comment = '%1= DateTime, %2 = UserID';
    begin
        ExcelBuffer_gRecTmp.CreateNewBook(Text50001_gCtx);
        ExcelBuffer_gRecTmp.WriteSheet(Text50001_gCtx, CompanyName, UserId);
        ExcelBuffer_gRecTmp.CloseBook();
        ExcelBuffer_gRecTmp.SetFriendlyFilename(StrSubstNo(ExcelFileNameLbl, CurrentDateTime, UserId));
        ExcelBuffer_gRecTmp.OpenExcel();
    end;

    procedure CalculateGLBalances(GLNo: Code[20]; StartDate: Date; EndDate: Date): Dictionary of [Text, Decimal]
    var
        GLEntry: Record "G/L Entry";
        OpeningBal: Decimal;
        PeriodBal: Decimal;
        ClosingBal: Decimal;
        Result: Dictionary of [Text, Decimal];
    begin
        // 🔹 Opening Balance (before start date)
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", GLNo);
        GLEntry.SetFilter("Posting Date", '..%1', CalcDate('<-1D>', StartDate)); // Before Start Date
        if GLEntry.FindSet() then
            repeat
                OpeningBal += GLEntry.Amount;
            until GLEntry.Next() = 0;

        // 🔹 Period Transactions (within start and end date)
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", GLNo);
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        if GLEntry.FindSet() then
            repeat
                PeriodBal += GLEntry.Amount;
            until GLEntry.Next() = 0;

        // 🔹 Closing Balance
        ClosingBal := OpeningBal + PeriodBal;

        // 🔹 Return Results in Dictionary
        Result.Add('OpeningBalance', OpeningBal);
        Result.Add('PeriodBalance', PeriodBal);
        Result.Add('ClosingBalance', ClosingBal);

        exit(Result);
    end;

}