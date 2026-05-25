report 50044 "Vendor Invoice To Payment"
{
    Caption = 'Vendor Invoice To Payment';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            RequestFilterFields = "Posting Date", "Global Dimension 1 Code", "Vendor No.";
            trigger OnPreDataItem()
            begin
                SetFilter("Document Type", '%1', "Vendor Ledger Entry"."Document Type"::Invoice);
            end;

            trigger OnAfterGetRecord()
            begin
                CalcFields("Original Amount");
                MakeExcelDataBody();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field("Export to Excel"; blnExportToExcel)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
            }
        }

        trigger OnInit()
        begin
            blnExportToExcel := true;
        end;
    }

    trigger OnPreReport()
    begin
        if blnExportToExcel then begin
            ExcelBuf.DeleteAll();
            MakeExcelDataHeader();
        end;
    end;

    trigger OnPostReport()
    begin
        if blnExportToExcel then
            CreateExcelBook();
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        VendorRec: Record Vendor;
        CompanyInfo: Record "Company Information";
        blnExportToExcel: Boolean;
        ReportTitle: Label 'Vendor Invoice To Payment';

        DVLE: Record "Detailed Vendor Ledg. Entry";
        VLE_Payment: Record "Vendor Ledger Entry";

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Unit Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Document No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('Invoice No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('Invoice Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Payment Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('Payment Document No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Payment Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('UTR No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
    end;

    local procedure MakeExcelDataBody()
    var
        VendorName: Text[100];
        HasApplied: Boolean;
        ReTrigger: Integer;
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
    begin
        // Vendor Name from Vendor Master
        VendorName := '';
        if VendorRec.Get("Vendor Ledger Entry"."Vendor No.") then
            VendorName := VendorRec.Name;

        // Invoice Row
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn("Vendor Ledger Entry"."Global Dimension 1 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Vendor Ledger Entry"."Vendor No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(VendorName, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Vendor Ledger Entry"."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Vendor Ledger Entry"."Posting Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn("Vendor Ledger Entry"."External Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Vendor Ledger Entry"."Document Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn("Vendor Ledger Entry"."Original Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        // Loop Detailed Vendor Ledg Entries to find applied Payments
        DVLE.Reset();
        DVLE.SetRange("Vendor Ledger Entry No.", "Vendor Ledger Entry"."Entry No.");
        DVLE.SETFILTER("Entry Type", '%1', "Detailed CV Ledger Entry Type"::Application);
        DVLE.SetRange(Unapplied, false);
        HasApplied := DVLE.FindSet();

        ReTrigger := 0;
        while HasApplied do begin
            //  ExcelBuf.NewRow();
            // Payment fields
            BankAccLedgEntry.Reset();
            BankAccLedgEntry.SetRange("Document No.", DVLE."Document No.");
            if BankAccLedgEntry.Find('-') then;
            if ReTrigger > 0 then begin
                ExcelBuf.NewRow();
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(DVLE."Posting Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);
                ExcelBuf.AddColumn(DVLE."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Abs(DVLE.Amount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                // UTR placeholder (blank unless you store UTR somewhere)
                ExcelBuf.AddColumn(BankAccLedgEntry."EDC UTR No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

            end else begin
                ExcelBuf.AddColumn(DVLE."Posting Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);
                ExcelBuf.AddColumn(DVLE."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Abs(DVLE.Amount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                // UTR placeholder (blank unless you store UTR somewhere)
                ExcelBuf.AddColumn(BankAccLedgEntry."EDC UTR No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ReTrigger := 1
            end;
            HasApplied := DVLE.Next() <> 0;
        end;
    end;

    local procedure CreateExcelBook()
    begin
        CompanyInfo.Get();
        ExcelBuf.CreateNewBook(ReportTitle);
        ExcelBuf.WriteSheet(ReportTitle, CompanyInfo.Name, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename('Vendor_Invoice_To_Payment.xlsx');
        ExcelBuf.OpenExcel();
    end;
}
