report 50021 "Purchase Order Register"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'PO Register';

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Quantity = FILTER(<> 0), "No." = FILTER(<> ''));

            trigger OnAfterGetRecord()
            begin

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
                    ApplicationArea = All;
                    TableRelation = Location;

                }
                field("Unit Code"; DivisionCode)
                {
                    ApplicationArea = All;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

                }
                field("Department Code"; BranchCode)
                {
                    ApplicationArea = All;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
                }
                field(Item; ItemCode)
                {
                    ApplicationArea = All;
                    TableRelation = Item;

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
        Text001: Label 'Purchase Order Register';
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
        Users: Record User;

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
        ExcelBuf.AddColumn('Vendor Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Company
        ExcelBuf.AddColumn('Vendor Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Seller GST No
        ExcelBuf.AddColumn('State', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Unit Code
        ExcelBuf.AddColumn('Vendor GSTIN No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Department Code
        ExcelBuf.AddColumn('PO No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Financial Year
        ExcelBuf.AddColumn('Currency', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Financial Quarter
        ExcelBuf.AddColumn('PO Status', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Month Name
        ExcelBuf.AddColumn('Order Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Transaction Type
        ExcelBuf.AddColumn('Delivery time', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//GST Doc Type
        ExcelBuf.AddColumn('PO Expiry', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Invoice Type
        ExcelBuf.AddColumn('Business Unit', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Type of Document
        ExcelBuf.AddColumn('Item Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Type
        ExcelBuf.AddColumn('HSN Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Sales Shipment / Sales Receipt No
        ExcelBuf.AddColumn('Item Description', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Invoice No./Original Invoice No. 
        ExcelBuf.AddColumn('Ordered Qty', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Invoice Date/ Original Invoice Date
        ExcelBuf.AddColumn('UOM', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//UOM
        ExcelBuf.AddColumn('Received Qty', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Credit/Debit Note/Refund/Sales Return Voucher Number
        ExcelBuf.AddColumn('Pending Quantity', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Credit/Debit Note/Refund/Sales Return Voucher Date 
        ExcelBuf.AddColumn('Pending Invoice Quantity', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Credit/Debit Note/Refund/Sales Return Voucher Date 
        ExcelBuf.AddColumn('GST Group', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Reference Invoice Date
        ExcelBuf.AddColumn('Item Cost', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Sales Return Type
        ExcelBuf.AddColumn('GST', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//E-Way Bill No.
        ExcelBuf.AddColumn('Discount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//E-Way Bill Date
        ExcelBuf.AddColumn('Total cost', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Is Supply through e-Commerce
        ExcelBuf.AddColumn('GRN Count', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Type of Supply		
        ExcelBuf.AddColumn('Vendor Invoice  No', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Item Category Code
        ExcelBuf.AddColumn('Vendor Invoice date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Gen_ Prod_ Posting Group
        ExcelBuf.AddColumn('Created by', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Product Group Code		
        ExcelBuf.AddColumn('Creation date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Customer No
        ExcelBuf.AddColumn('Capex type ', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Type ', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Final approved by', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Customer Name
        ExcelBuf.AddColumn('Final approval date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Customer Type
        ExcelBuf.AddColumn('Approval Status ', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Customer Type
        ExcelBuf.AddColumn('Payment Terms', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Payment Terms
        ExcelBuf.AddColumn('Remarks ', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Comment
        ExcelBuf.AddColumn('Delivery Terms ', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Delivery Terms

    end;

    procedure MakeExcelDataBody()
    var
        PurchaseHeader: Record "Purchase Header";
        Vendor: Record Vendor;
        State: Record State;
        intPrCount: Integer;
        TaxTransactionValue: Record "Tax Transaction Value";
        PurchReceiptHeader: Record "Purch. Rcpt. Header";
        Users: Record User;
        ApprovalEntries: Record "Approval Entry";
        txtcommentNote: Text;
        PurchCommentLine: Record "Purch. Comment Line";
        PayTerms: Text;
        PaymentTerms: Record "Payment Terms";
    begin
        ExcelBuf.NewRow;
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("Document Type", "Purchase Line"."Document Type");
        PurchaseHeader.SetRange("No.", "Purchase Line"."Document No.");
        IF PurchaseHeader.FindFirst() then;
        ExcelBuf.AddColumn(PurchaseHeader."Buy-from Vendor Name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchaseHeader."Buy-from Vendor No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        if Vendor.Get(PurchaseHeader."Buy-from Vendor No.") then;
        if State.Get(Vendor."State Code") then;
        IF State.Description <> '' then
            ExcelBuf.AddColumn(State.Description, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchaseHeader."Vendor GST Reg. No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchaseHeader."No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchaseHeader."Currency Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchaseHeader.Status, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchaseHeader."Order Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchaseHeader."Shortcut Dimension 1 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn("Purchase Line"."No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn("Purchase Line"."HSN/SAC Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn("Purchase Line".Description, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn("Purchase Line".Quantity, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//company
        ExcelBuf.AddColumn("Purchase Line"."Unit of Measure Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UOM
        ExcelBuf.AddColumn("Purchase Line"."Qty. Received (Base)", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//company
        ExcelBuf.AddColumn("Purchase Line"."Outstanding Quantity", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//company
        ExcelBuf.AddColumn("Purchase Line"."Qty. Rcd. Not Invoiced (Base)", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//company
        ExcelBuf.AddColumn("Purchase Line"."GST Group Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn("Purchase Line"."Direct Unit Cost", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//company

        CGSTAmount := 0;
        SGSTAmount := 0;
        IGSTAmount := 0;
        TaxTransactionValue.Reset();
        TaxTransactionValue.SetRange("Tax Record ID", "Purchase Line".RecordId);
        TaxTransactionValue.SetRange("Tax Type", 'GST');
        IF TaxTransactionValue.FindFirst() then begin
            repeat
                case
                 TaxTransactionValue."Value ID" of
                    2:
                        CGSTAmount := TaxTransactionValue.Amount;
                    6:
                        SGSTAmount := TaxTransactionValue.Amount;
                    3:
                        IGSTAmount := TaxTransactionValue.Amount;
                end;
            until TaxTransactionValue.Next() = 0;
        end;
        IF (CGSTAmount + SGSTAmount + IGSTAmount) <> 0 then
            ExcelBuf.AddColumn(CGSTAmount + SGSTAmount + IGSTAmount, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number)//company
        else
            ExcelBuf.AddColumn(0, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//company
        ExcelBuf.AddColumn(("Purchase Line"."Line Discount Amount" + "Purchase Line"."Inv. Discount Amount"), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//company
        ExcelBuf.AddColumn(((("Purchase Line".Quantity * "Purchase Line"."Direct Unit Cost") + CGSTAmount + SGSTAmount + IGSTAmount) - ("Purchase Line"."Line Discount Amount" + "Purchase Line"."Inv. Discount Amount")), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//company

        PurchReceiptHeader.Reset();
        PurchReceiptHeader.SetRange("Order No.", "Purchase Line"."Document No.");
        IF PurchReceiptHeader.FindFirst() then
            intPrCount := PurchReceiptHeader.Count;

        IF intPrCount <> 0 then
            ExcelBuf.AddColumn(intPrCount, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//company
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company

        ExcelBuf.AddColumn(PurchaseHeader."Vendor Invoice No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchaseHeader."Document Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        Users.get(PurchaseHeader.SystemCreatedBy);
        ExcelBuf.AddColumn(Users."User Name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchaseHeader.SystemCreatedAt, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(PurchaseHeader."E3 Capex Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(PurchaseHeader."E3 Item Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ApprovalEntries.Reset();
        ApprovalEntries.SetRange("Document Type", "Purchase Line"."Document Type");
        ApprovalEntries.SetRange("Document No.", "Purchase Line"."Document No.");
        IF ApprovalEntries.FindFirst() then
            ExcelBuf.AddColumn(ApprovalEntries."Approver ID", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//company
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(ApprovalEntries."Date-Time Sent for Approval", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(ApprovalEntries.Status, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company

        PayTerms := '';
        PaymentTerms.SetRange(Code, PurchaseHeader."Payment Terms Code");
        if PaymentTerms.FindFirst() then begin
            repeat
                PayTerms += PaymentTerms.Description;
            until PaymentTerms.Next() = 0;
        end;

        ExcelBuf.AddColumn(PayTerms, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company

        txtcommentNote := '';
        PurchCommentLine.Reset();
        PurchCommentLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchCommentLine.SetRange("Document Line No.", PurchCommentLine."Document Line No.");
        PurchCommentLine.SetRange("No.", PurchaseHeader."No.");
        IF PurchCommentLine.FindSet() then begin
            txtcommentNote += PurchCommentLine.Comment;
        End;
        ExcelBuf.AddColumn(txtcommentNote, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        ExcelBuf.AddColumn(PurchaseHeader."E3 Delivery Terms", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Delivery terms

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

