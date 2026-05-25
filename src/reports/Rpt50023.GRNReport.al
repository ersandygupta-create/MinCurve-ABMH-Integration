report 50023 "GRN Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Goods Receipt Register';

    dataset
    {
        dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Quantity = FILTER(<> 0), "No." = FILTER(<> ''));

            trigger OnAfterGetRecord()
            begin
                UserName := '';
                if Users.get(SystemCreatedBy) then
                    UserName := Users."User Name";

                if blnExportToExcel then
                    MakeExcelDataBody
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Order Date", StartDate, EndDate);

                Counter := 1;
                if GSTINNo <> '' then begin
                    LocationRec.Reset;
                    LocationRec.SetFilter(LocationRec."GST Registration No.", GSTINNo);
                    if LocationRec.FindFirst then
                        repeat
                            if Counter = 1 then
                                VarLocCode := LocationRec.Code
                            else
                                VarLocCode += '|' + LocationRec.Code;
                            Counter += 1;
                        until LocationRec.Next = 0;
                end;

                if VarLocCode <> '' then
                    LocationCode := LocationCode;

                if LocationCode <> '' then
                    SetFilter("Location Code", LocationCode);


                if DivisionCode <> '' then
                    SetFilter("Shortcut Dimension 1 Code", DivisionCode);

                if BranchCode <> '' then
                    SetFilter("Shortcut Dimension 2 Code", BranchCode);

                if ItemCode <> '' then
                    SetFilter("No.", ItemCode);

                if VendorCode <> '' then
                    SetFilter("Buy-from Vendor No.", VendorCode);

                if GLAccountNo <> '' then
                    SetFilter("No.", GLAccountNo);
            end;
        }

    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("From Date"; StartDate)
                {
                    ApplicationArea = All;
                }
                field("To Date"; EndDate)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; LocationCode)
                {
                    TableRelation = Location;
                    ApplicationArea = All;
                }
                field("Unit Code"; DivisionCode)
                {
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    ApplicationArea = All;
                }
                field("Department Code"; BranchCode)
                {
                    ApplicationArea = All;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
                }
                field(Item; ItemCode)
                {
                    TableRelation = Item;
                    ApplicationArea = All;
                }

                field("GSTIN No."; GSTINNo)
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        GSTRegistrationNosPage: Page "GST Registration Nos.";
                    begin
                        Clear(GSTRegistrationNos);
                        GSTRegistrationNos.Reset;
                        if GSTRegistrationNos.FindFirst then begin
                            GSTRegistrationNosPage.LookupMode(true);
                            GSTRegistrationNosPage.SetTableView(GSTRegistrationNos);
                            if GSTRegistrationNosPage.RunModal = ACTION::LookupOK then begin
                                GSTRegistrationNosPage.GetRecord(GSTRegistrationNos);
                                GSTINNo := GSTRegistrationNos.Code;
                            end;
                        end;
                    end;
                }
                field("Vendor Code"; VendorCode)
                {
                    ApplicationArea = All;
                    TableRelation = Vendor;

                }

                field("Export to Excel"; blnExportToExcel)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            blnExportToExcel := true;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        if blnExportToExcel then
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        if (StartDate = 0D) and (EndDate = 0D) then
            Error('Please check Date Filter');


        Month := Date2DMY(EndDate, 2);
        case Month of
            1 .. 3:
                txtQuarter := 'Q4';
            4 .. 6:
                txtQuarter := 'Q1';
            7 .. 9:
                txtQuarter := 'Q2';
            else
                txtQuarter := 'Q3';
        end;

        if blnExportToExcel then
            MakeExcelInfo;
    end;

    var
        StartDate: Date;
        EndDate: Date;
        CompanyInformation: Record "Company Information";
        ExcelBuf: Record "Excel Buffer" temporary;
        blnExportToExcel: Boolean;
        CessAmount: Decimal;
        CessRate: Decimal;
        Text001: Label 'GRN Report';
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        State: Record State;
        GenProductPostingGroup: Record "Gen. Product Posting Group";
        GenPostingSetup: Record "General Posting Setup";
        Location: Record Location;
        ShiptoAddress: Record "Ship-to Address";
        Vendor: Record Customer;
        FiscalYearStartDate: Date;
        FiscalYearEndDate: Date;
        LastYearStartDate: Date;
        LastYearEndDate: Date;
        Month: Integer;
        txtQuarter: Text;
        PurchInvHeader: Record "Sales Invoice Header";
        txtLedgerDescription: Text[200];
        CGSTRate: Decimal;
        CGSTAmount: Decimal;
        IGSTRate: Decimal;
        IGSTAmount: Decimal;
        SGSTRate: Decimal;
        SGSTAmount: Decimal;
        UTSTRate: Decimal;
        UTSTAmount: Decimal;
        LocationCode: Text;
        GSTINNo: Text;
        GSTRegistrationNos: Record "GST Registration Nos.";
        Counter: Integer;
        LocationRec: Record Location;
        VarLocCode: Text;
        DivisionCode: Text;
        BranchCode: Text;
        DimensionValue: Record "Dimension Value";
        DimensionValuesPage: Page "Dimension Values";
        OrigianlDocDate: Date;
        OrigianlDocNo: Code[30];
        ChrItemNo: Code[20];
        cdVendorReferenceNo: Text;
        HisPurchSalesHeader: Record "E3 HIS Purchase Header";
        cdVendorInvoiceNo: Text;
        cdVendorInvoiceDate: Date;
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        dtDocumentDate: Date;
        ItemCode: Text;
        VendorCode: Text;
        DocumentType: Option " ",INVOICE,"CREDIT NOTE";
        GLAccountNo: Text;
        PurchRecHeader: Record "Purch. Rcpt. Header";
        PurchRecLine: Record "Purch. Rcpt. Line";
        Users: Record User;
        UserName: Text;
        UserSetup: Record "User Setup";

    procedure MakeExcelInfo()
    begin
        /*
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddColumn('Date From' + ':' + Format(StartDate), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Date To' + ':' + Format(EndDate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        CompanyInformation.Get();
        ExcelBuf.AddColumn('Company:' + CompanyInformation.Name, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('ReportName:' + 'Purchase Tax Register', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Unit Code:' + BranchCode, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Department Code:' + DivisionCode, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('GST No:' + GSTINNo, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('LayoutName:' + 'F-Purchase Tax Register -2 ', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Report Generation Date:' + Format(Today), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.ClearNewRow;
        */
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Vendor Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Seller GST No
        ExcelBuf.AddColumn('Vendor Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Company
        ExcelBuf.AddColumn('Vendor GSTIN No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Department Code
        ExcelBuf.AddColumn('State', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Unit Code
        ExcelBuf.AddColumn('Order No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Financial Quarter
        ExcelBuf.AddColumn('Order Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Transaction Type
        ExcelBuf.AddColumn('GRN No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Financial Year
        ExcelBuf.AddColumn('GRN Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Transaction Type
        ExcelBuf.AddColumn('Invoice No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Financial Quarter
        ExcelBuf.AddColumn('Invoice Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Transaction Type
        ExcelBuf.AddColumn('Business Unit', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Type of Document
        ExcelBuf.AddColumn('Posting Description', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Posting Description
        ExcelBuf.AddColumn('Department Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Dept Name
        ExcelBuf.AddColumn('Item Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Type
        ExcelBuf.AddColumn('Item Description', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Invoice No./Original Invoice No. 
        ExcelBuf.AddColumn('Ordered Qty', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Invoice Date/ Original Invoice Date
        ExcelBuf.AddColumn('UOM', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//UOM
        ExcelBuf.AddColumn('Received Qty', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Credit/Debit Note/Refund/Sales Return Voucher Number
        ExcelBuf.AddColumn('Invoiced Qty', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Credit/Debit Note/Refund/Sales Return Voucher Number                                                                                                 //ExcelBuf.AddColumn('Pending Quantity', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Credit/Debit Note/Refund/Sales Return Voucher Date 
        // ExcelBuf.AddColumn('Pending Invoice Quantity', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Credit/Debit Note/Refund/Sales Return Voucher Date 
        ExcelBuf.AddColumn('Unit Price', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Item Category Code
        ExcelBuf.AddColumn('GST Group', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Reference Invoice Date
        ExcelBuf.AddColumn('HSN Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Sales Shipment / Sales Receipt No
        ExcelBuf.AddColumn('GRN Value', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Item Category Code
        //ExcelBuf.AddColumn('Vendor Invoice date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Gen_ Prod_ Posting Group
        ExcelBuf.AddColumn('Created by', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Product Group Code		
        ExcelBuf.AddColumn('Creation date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Customer No

    end;

    procedure MakeExcelDataBody()
    var
        PurchRecHeader: Record "Purch. Rcpt. Header";
        Vendor: Record Vendor;
        State: Record State;
        intPrCount: Integer;
        TaxTransactionValue: Record "Tax Transaction Value";
        PurchReceiptHeader: Record "Purch. Rcpt. Header";
        Users: Record User;
        ApprovalEntries: Record "Approval Entry";
        PurchaseHeader: Record "Purchase Header";
        DeptName: Text[100];
    begin
        ExcelBuf.NewRow;
        PurchRecHeader.Reset();
        //PurchRecHeader.SetRange(DocumentType, PurchRecLine."Document No.");
        PurchRecHeader.SetRange("No.", "Purch. Rcpt. Line"."Document No.");
        IF PurchRecHeader.FindFirst() then;
        ExcelBuf.AddColumn(PurchRecHeader."Buy-from Vendor No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchRecHeader."Buy-from Vendor Name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchRecHeader."Vendor GST Reg. No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        if Vendor.Get(PurchRecHeader."Buy-from Vendor No.") then;
        if State.Get(Vendor."State Code") then;
        IF State.Description <> '' then
            ExcelBuf.AddColumn(State.Description, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchRecHeader."Order No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchRecHeader."Order Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchRecHeader."No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchRecHeader."Posting Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("No.", PurchRecHeader."Order No.");
        if PurchaseHeader.FindFirst() then;
        ExcelBuf.AddColumn(PurchaseHeader."Vendor Invoice No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchaseHeader."Document Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchRecHeader."Shortcut Dimension 1 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchRecHeader."Posting Description", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Posting Description
        DimensionValue.Reset();
        DimensionValue.SetRange(Code, PurchRecHeader."Shortcut Dimension 2 Code");
        IF DimensionValue.Find('-') then
            DeptName := DimensionValue.Name;
        ExcelBuf.AddColumn(DeptName, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//DEPT Name
        ExcelBuf.AddColumn("Purch. Rcpt. Line"."No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn("Purch. Rcpt. Line".Description, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn("Purch. Rcpt. Line".Quantity, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//company
        ExcelBuf.AddColumn("Purch. Rcpt. Line"."Unit of Measure Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UOM
        ExcelBuf.AddColumn("Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//company
        //ExcelBuf.AddColumn("Purch. Rcpt. Line"."Quantity (Base)", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//company
        ExcelBuf.AddColumn("Purch. Rcpt. Line"."Quantity Invoiced", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//company
        ExcelBuf.AddColumn("Purch. Rcpt. Line"."Direct Unit Cost", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//company
        ExcelBuf.AddColumn("Purch. Rcpt. Line"."GST Group Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn("Purch. Rcpt. Line"."HSN/SAC Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(("Purch. Rcpt. Line"."Direct Unit Cost") * ("Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced"), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//company
        ExcelBuf.AddColumn(UserName, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchRecHeader.SystemCreatedAt, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
    end;



    procedure CreateExcelbook()
    begin
        // ExcelBuf.CreateBookAndOpenExcel('', Text001, '', CompanyName, UserId);
        // Error('');
        ExcelBuf.CreateNewBook(Text001);
        ExcelBuf.WriteSheet(Text001, CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(Text001);
        ExcelBuf.OpenExcel();
    end;
}

