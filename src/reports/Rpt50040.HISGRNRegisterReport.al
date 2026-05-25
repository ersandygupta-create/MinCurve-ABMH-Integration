report 50040 "HIS GRN Register Excel"
{
    Caption = 'Goods Receipt Register - HIS Data';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(HISPurchaseHeader; "E3 HIS Purchase Header")
        {
            DataItemTableView = SORTING("Entry No.");
            RequestFilterFields = "Posting Date", "Shortcut Dimension 1 Code";

            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            begin
                UserName := '';
                if Users.get(SystemCreatedBy) then
                    UserName := Users."User Name";
                MakeExcelDataBody;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                // field(FromDate; FromDate)
                // {
                //     ApplicationArea = All;
                // }
                // field(ToDate; ToDate)
                // {
                //     ApplicationArea = All;
                // }
                // field("Unit Code"; UnitCode)
                // {
                //     ApplicationArea = All;
                //     TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                // }
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

        trigger OnClosePage()
        begin
            if UnitCode <> '' then
                HISPurchaseHeader.SetRange("Shortcut Dimension 1 Code", UnitCode);
        end;
    }

    trigger OnPreReport()
    begin
        if blnExportToExcel then
            MakeExcelInfo;
    end;

    trigger OnPostReport()
    begin
        if blnExportToExcel then
            CreateExcelbook;
    end;

    var
        Text001: Label 'HIS GRN Register';
        ExcelBuf: Record "Excel Buffer" temporary;
        blnExportToExcel: Boolean;
        FromDate: Date;
        ToDate: Date;
        UnitCode: Code[10];
        PeriodTxt: Text[50];
        HISPurchLine: Record "E3 HIS Purchase Line";
        Users: Record User;
        UserName: Text;
        Vend: Record Vendor;
        VendorGST: Text;

    procedure MakeExcelInfo()
    begin
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('HIS GRN Register', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        UnitCode := HISPurchaseHeader.GetFilter("Shortcut Dimension 1 Code");
        PeriodTxt := HISPurchaseHeader.GetFilter("Posting Date");
        ExcelBuf.AddColumn('Unit : ' + UnitCode, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Period : ' + PeriodTxt, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Vendor Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor GSTIN No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('GRN No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('GRN Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('GRN Posting Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Business Unit', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('GL Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Description', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Category Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Store Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Ordered Qty', false, '', true, false, true, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Received Qty', false, '', true, false, true, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Invoiced Qty', false, '', true, false, true, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Unit Price', false, '', true, false, true, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Discount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('GST Group', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('HSN Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Created By', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Creation Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);


    end;

    procedure MakeExcelDataBody()
    begin
        HISPurchLine.Reset();
        HISPurchLine.SetRange("Document No.", HISPurchaseHeader."Document No.");

        if HISPurchLine.FindSet() then
            repeat
                ExcelBuf.NewRow;
                ExcelBuf.AddColumn(HISPurchaseHeader."Vendor No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchaseHeader."Vendor Name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                Vend.Reset();
                if Vend.Get(HISPurchaseHeader."Vendor No.") then
                    VendorGST := Vend."GST Registration No."
                else
                    VendorGST := '';
                ExcelBuf.AddColumn(VendorGST, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchLine."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchaseHeader."Document Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchaseHeader."Posting Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchaseHeader."Vendor Invoice No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchaseHeader."Vendor Invoice Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchaseHeader."Shortcut Dimension 1 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchLine."Purchase Account", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(HISPurchLine."Item Name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchLine."Item Category Name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchaseHeader."Store Name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchLine."Received Qty", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchLine."Unit Cost", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchLine.Discount, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchLine."GST Group Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchLine."HSN Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchLine.Amount, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(UserName, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(HISPurchLine.SystemCreatedAt, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

            until HISPurchLine.Next() = 0;
    end;

    procedure CreateExcelbook()
    begin
        ExcelBuf.CreateNewBook(Text001);
        ExcelBuf.WriteSheet(Text001, CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(Text001);
        ExcelBuf.OpenExcel();
    end;
}
