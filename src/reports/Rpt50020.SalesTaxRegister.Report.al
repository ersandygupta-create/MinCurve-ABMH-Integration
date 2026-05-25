report 50020 "Sales Tax Register"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Sales Tax Register';

    dataset
    {
        dataitem("Purch. Inv. Line"; "Sales Invoice Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Quantity = FILTER(<> 0), "No." = FILTER(<> ''));

            trigger OnAfterGetRecord()
            begin
                if DocumentType <> DocumentType::" " then begin
                    if (DocumentType = DocumentType::"CREDIT NOTE") then
                        CurrReport.Skip;
                end;

                if blnExportToExcel then
                    MakeExcelDataBody
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", StartDate, EndDate);

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
                    SetFilter("Sell-to Customer No.", VendorCode);

                if GLAccountNo <> '' then
                    SetFilter("No.", GLAccountNo);
            end;
        }
        dataitem("Purch. Cr. Memo Line"; "Sales Cr.Memo Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.") WHERE("No." = FILTER(<> ''), Quantity = FILTER(<> 0));

            trigger OnAfterGetRecord()
            begin
                if DocumentType <> DocumentType::" " then begin
                    if (DocumentType = DocumentType::INVOICE) then
                        CurrReport.Skip;
                end;


                if blnExportToExcel then
                    MakeExcelDataBody_Cr;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", StartDate, EndDate);

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
                    SetFilter("Sell-to Customer No.", VendorCode);

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
                field("Customer Code"; VendorCode)
                {
                    ApplicationArea = All;

                    TableRelation = Customer;

                }
                field("Document Type"; DocumentType)
                {
                    ApplicationArea = All;
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
        GSTSetup: Record "GST Setup";
        TDSLedgerEntry: Record "TDS Entry";
        CalculateStructure: Codeunit "Calculate Statistics";
        TCSEntries: Record "TCS Entry";
        GSTTCSLedgerEntry: Record "GST TDS/TCS Entry";
        CessAmount: Decimal;
        CessRate: Decimal;
        Text001: Label 'Sales Tax Register';
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
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
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
        HisPurchSalesHeader: Record "E3 HIS Revenue Header";
        cdVendorInvoiceNo: Text;
        cdVendorInvoiceDate: Date;
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        dtDocumentDate: Date;
        ItemCode: Text;
        VendorCode: Text;
        DocumentType: Option " ",INVOICE,"CREDIT NOTE";
        GLAccountNo: Text;

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
        ExcelBuf.AddColumn('Company', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Company
        ExcelBuf.AddColumn('Seller GST No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Seller GST No
        ExcelBuf.AddColumn('Unit Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Unit Code
        ExcelBuf.AddColumn('Department Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Department Code
        ExcelBuf.AddColumn('Financial Year', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Financial Year
        ExcelBuf.AddColumn('Financial Quarter', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Financial Quarter
        ExcelBuf.AddColumn('Month Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Month Name
        ExcelBuf.AddColumn('Transaction Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Transaction Type
        ExcelBuf.AddColumn('GST Doc Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//GST Doc Type
        ExcelBuf.AddColumn('Invoice Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Invoice Type
        ExcelBuf.AddColumn('Type of Document', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Type of Document
        ExcelBuf.AddColumn('Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Type
        ExcelBuf.AddColumn('Sales Shipment/Sales Receipt No', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Sales Shipment / Sales Receipt No
        ExcelBuf.AddColumn('Invoice No./Original Invoice No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Invoice No./Original Invoice No. 
        ExcelBuf.AddColumn('Invoice Date/ Original Invoice Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Invoice Date/ Original Invoice Date
        ExcelBuf.AddColumn('Credit/Debit Note/Refund/Sales Return Voucher Number', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Credit/Debit Note/Refund/Sales Return Voucher Number
        ExcelBuf.AddColumn('Credit/Debit Note/Refund/Sales Return Voucher Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Credit/Debit Note/Refund/Sales Return Voucher Date 
        ExcelBuf.AddColumn('Reference Invoice Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Reference Invoice Date
        ExcelBuf.AddColumn('Sales Return Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Sales Return Type
        ExcelBuf.AddColumn('E-Way Bill No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//E-Way Bill No.
        ExcelBuf.AddColumn('E-Way Bill Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//E-Way Bill Date
        ExcelBuf.AddColumn('Is Supply through e-Commerce', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Is Supply through e-Commerce
        ExcelBuf.AddColumn('E-Commerce GSTIN', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//E-Commerce GSTIN
        ExcelBuf.AddColumn('Type of Supply', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Type of Supply		
        ExcelBuf.AddColumn('Item Category Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Item Category Code
        ExcelBuf.AddColumn('Gen_ Prod_ Posting Group', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Gen_ Prod_ Posting Group
        ExcelBuf.AddColumn('Product Group Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Product Group Code		
        ExcelBuf.AddColumn('Name of Recipient/Buyer', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Customer No
        ExcelBuf.AddColumn('Customer Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Customer Name
        ExcelBuf.AddColumn('Customer Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Customer Type
        ExcelBuf.AddColumn('Customer Address', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Customer Address
        ExcelBuf.AddColumn('Place Of Supply', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Customer State Name
        ExcelBuf.AddColumn('Recipient /Buyer GST No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Customer GSTIN
        ExcelBuf.AddColumn('Counter Party Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//GST Customer Type	
        ExcelBuf.AddColumn('Gen_ Bus_ Posting Group', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Gen_ Bus_ Posting Group
        ExcelBuf.AddColumn('Item No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//ItemNo		
        ExcelBuf.AddColumn('Item Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//ItemName
        ExcelBuf.AddColumn('Unit of Measure', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Unit of Measure
        ExcelBuf.AddColumn('HSN_SAC Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//HSN_SAC Code
        ExcelBuf.AddColumn('GST Jurisdiction Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//GST Jurisdiction Type
        ExcelBuf.AddColumn('Is Reverse Charge Applicable', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Is Reverse Charge Applicable
        ExcelBuf.AddColumn('GST Group Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//GST Group Type
        ExcelBuf.AddColumn('Nature of Supply', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Nature of Supply
        ExcelBuf.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Quantity
        ExcelBuf.AddColumn('Cost Price ', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Cost Price 
        ExcelBuf.AddColumn('Unit Price Excl. GST', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Unit Price Excl. GST
        ExcelBuf.AddColumn('Discount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Discount
        ExcelBuf.AddColumn('GST Rate', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//GST Group Code
        ExcelBuf.AddColumn('Taxable Value of Invoice', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Tax Base Amount
        ExcelBuf.AddColumn('IGST %', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//IGST %
        ExcelBuf.AddColumn('IGST Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//IGST Amount
        ExcelBuf.AddColumn('CGST %', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//IGST %
        ExcelBuf.AddColumn('CGST Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//IGST Amount
        ExcelBuf.AddColumn('SGST %', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//IGST %
        ExcelBuf.AddColumn('SGST Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//IGST Amount
        ExcelBuf.AddColumn('UTGST %', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//IGST %
        ExcelBuf.AddColumn('UTGST Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//IGST Amount
        ExcelBuf.AddColumn('Cess %', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//IGST %
        ExcelBuf.AddColumn('Cess Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//IGST Amount
        ExcelBuf.AddColumn('Tax Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//IGST Amount
        ExcelBuf.AddColumn('Ledger Description', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//IGST Amount
        ExcelBuf.AddColumn('Total Invoice Value', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Total Invoice Value
        ExcelBuf.AddColumn('MRP Price', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//MRP Price
        ExcelBuf.AddColumn('TCS/TDS Base Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//TCS/TDS Base Amount
        ExcelBuf.AddColumn('TCS/TDS %', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//TCS/TDS %
        ExcelBuf.AddColumn('TCS/TDS Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//TCS/TDS Amount
        ExcelBuf.AddColumn('Exclude GST in TCS Base', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//TCS/TDS Amount


    end;

    procedure MakeExcelDataBody()
    var
        BlankFiller: Text[250];
        Item: Record Item;
        PurchInvHeader1: Record "Sales Invoice Header";
        cdPostedDocumentNo1: Text;
        cdReferenceNo1: Text;
        dtPostingDate1: Date;
        cdVendorReferenceNo1: Text;
        cdVendorInvoiceNo1: Text;
        cdVendorInvoiceDate1: Date;
        decTCSPer: Decimal;
        TCSBaseAmount: Decimal;
        decTCSAmount: Decimal;
    begin
        ExcelBuf.NewRow;
        CompanyInformation.Get();
        ExcelBuf.AddColumn(CompanyInformation.Name, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        PurchInvHeader.Get("Purch. Inv. Line"."Document No.");
        ExcelBuf.AddColumn(PurchInvHeader."Location GST Reg. No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Location  Reg_ No_
        ExcelBuf.AddColumn("Purch. Inv. Line"."Shortcut Dimension 1 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//unit Code
        ExcelBuf.AddColumn("Purch. Inv. Line"."Shortcut Dimension 2 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Department Code
        ExcelBuf.AddColumn(FiscalYearEndDate, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Department Code
        ExcelBuf.AddColumn(txtQuarter, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Financial Quarter
        ExcelBuf.AddColumn(FORMAT("Purch. Inv. Line"."Posting Date", 0, '<Month Text>'), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Month Name
        ExcelBuf.AddColumn('Sales', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Transaction Type
        ExcelBuf.AddColumn(PurchInvHeader."Invoice Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Doc Type
        ExcelBuf.AddColumn(PurchInvHeader."Invoice Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Doc Type
        ExcelBuf.AddColumn('Invoice', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Type of Document
        ExcelBuf.AddColumn("Purch. Inv. Line".Type, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Type
        ExcelBuf.AddColumn("Purch. Inv. Line"."Shipment No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Sales Shipment/Sales Receipt No
        ExcelBuf.AddColumn("Purch. Inv. Line"."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Sales Shipment/Sales Receipt No
        ExcelBuf.AddColumn("Purch. Inv. Line"."Posting Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);//Sales Shipment/Sales Receipt No
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Sales Shipment/Sales Receipt No
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);//Sales Shipment/Sales Receipt No
        HisPurchSalesHeader.Reset();
        HisPurchSalesHeader.SetRange("Record Type", HisPurchSalesHeader."Record Type"::Revenue);
        HisPurchSalesHeader.SetRange("Document Type", HisPurchSalesHeader."Document Type"::Invoice);
        HisPurchSalesHeader.SetRange("Document No.", "Purch. Inv. Line"."Document No.");
        IF HisPurchSalesHeader.FindFirst() then
            ExcelBuf.AddColumn(HisPurchSalesHeader."Document Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date)//Document Date
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn("Purch. Inv. Line"."Return Reason Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn(PurchInvHeader."E-Way Bill No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn(PurchInvHeader."Shipment Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);//Document Date
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date

        ExcelBuf.AddColumn(PurchInvHeader."Invoice Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn("Purch. Inv. Line"."Item Category Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn("Purch. Inv. Line"."Gen. Prod. Posting Group", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn("Purch. Inv. Line"."Sell-to Customer No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn(PurchInvHeader."Bill-to Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn(PurchInvHeader."Customer Posting Group", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn(PurchInvHeader."Sell-to Address" + '' + PurchInvHeader."Sell-to Address 2", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        Vendor.Get(PurchInvHeader."Sell-to Customer No.");
        IF State.Get(Vendor."State Code") then;
        IF State.Description <> '' then
            ExcelBuf.AddColumn(State.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)//Consignee Name
        else
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        IF PurchInvHeader."Customer GST Reg. No." <> '' then
            ExcelBuf.AddColumn(PurchInvHeader."Customer GST Reg. No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)//Consignee Name
        else
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn(PurchInvHeader."GST Customer Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn(PurchInvHeader."Gen. Bus. Posting Group", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn("Purch. Inv. Line"."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn("Purch. Inv. Line".Description + '' + "Purch. Inv. Line"."Description 2", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn("Purch. Inv. Line"."Unit of Measure", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn("Purch. Inv. Line"."HSN/SAC Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn("Purch. Inv. Line"."GST Jurisdiction Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn("Purch. Inv. Line"."GST Group Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn(PurchInvHeader."Nature of Supply", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn("Purch. Inv. Line".Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);//Consignee Name
        ExcelBuf.AddColumn("Purch. Inv. Line"."Unit Price Incl. of Tax", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);//Consignee Name
        ExcelBuf.AddColumn("Purch. Inv. Line"."Unit Price", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);//Consignee Name
        ExcelBuf.AddColumn(Abs("Purch. Inv. Line"."Line Discount Amount") + ABS("Purch. Inv. Line"."Inv. Discount Amount"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);//Consignee Name
        ExcelBuf.AddColumn("Purch. Inv. Line"."GST Group Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn("Purch. Inv. Line"."Line Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);//Consignee Name
        CGSTRate := 0;
        CGSTAmount := 0;
        IGSTRate := 0;
        IGSTAmount := 0;
        SGSTRate := 0;
        SGSTAmount := 0;
        UTSTRate := 0;
        UTSTAmount := 0;
        CessAmount := 0;
        CessRate := 0;

        DetailedGSTLedgerEntry.Reset;
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
        DetailedGSTLedgerEntry.SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
        DetailedGSTLedgerEntry.SetRange("Document No.", "Purch. Inv. Line"."Document No.");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", "Purch. Inv. Line"."Line No.");
        if DetailedGSTLedgerEntry.FindSet then begin
            repeat
                if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
                    CGSTRate := DetailedGSTLedgerEntry."GST %";
                    CGSTAmount += DetailedGSTLedgerEntry."GST Amount";
                end;
                if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
                    IGSTRate := DetailedGSTLedgerEntry."GST %";
                    IGSTAmount += DetailedGSTLedgerEntry."GST Amount";
                end;
                if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then begin
                    SGSTRate := DetailedGSTLedgerEntry."GST %";
                    SGSTAmount += DetailedGSTLedgerEntry."GST Amount";
                end;
                if DetailedGSTLedgerEntry."GST Component Code" = 'UTGST' then begin
                    UTSTRate := DetailedGSTLedgerEntry."GST %";
                    UTSTAmount += DetailedGSTLedgerEntry."GST Amount";
                end;
                GSTSetup.Get();
                if DetailedGSTLedgerEntry."GST Component Code" = GSTSetup."Cess Tax Type" then begin
                    CessRate := DetailedGSTLedgerEntry."GST %";
                    CessAmount += DetailedGSTLedgerEntry."GST Amount";
                end;
            until DetailedGSTLedgerEntry.Next = 0;
        end;

        ExcelBuf.AddColumn(Abs(IGSTRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//IGST %
        ExcelBuf.AddColumn(Abs(IGSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//IGST Amount
        ExcelBuf.AddColumn(Abs(CGSTRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//CGST %
        ExcelBuf.AddColumn(Abs(CGSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//CGST Amount
        ExcelBuf.AddColumn(Abs(SGSTRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//SGST %
        ExcelBuf.AddColumn(Abs(SGSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//SGST Amount
        ExcelBuf.AddColumn(Abs(UTSTRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST %
        ExcelBuf.AddColumn(Abs(UTSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST Amount
        ExcelBuf.AddColumn(Abs(CessRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST %
        ExcelBuf.AddColumn(Abs(CessAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST Amount
        ExcelBuf.AddColumn(Abs(IGSTAmount) + Abs(CGSTAmount) + Abs(SGSTAmount) + Abs(UTSTAmount) + Abs(CessAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Total GST Amount
        txtLedgerDescription := '';
        GenPostingSetup.Reset();
        GenPostingSetup.SetRange("Gen. Bus. Posting Group", "Purch. Cr. Memo Line"."Gen. Bus. Posting Group");
        GenPostingSetup.SetRange("Gen. Prod. Posting Group", "Purch. Cr. Memo Line"."Gen. Prod. Posting Group");
        IF GenPostingSetup.FindFirst() then begin
            GLAccount.Get(GenPostingSetup."Purch. Account");
            txtLedgerDescription := GLAccount.Name;
        end;

        decTCSPer := 0;
        TCSEntries.Reset();
        TCSEntries.SetRange("Document No.", "Purch. Inv. Line"."Document No.");
        TCSEntries.SetRange("TCS Nature of Collection", "Purch. Inv. Line"."TCS Nature of Collection");
        if TCSEntries.FindFirst() then begin
            decTCSPer := TCSEntries."TCS %";
        end;

        TCSBaseAmount := 0;
        IF (PurchInvHeader."Exclude GST in TCS Base") and (decTCSPer <> 0) then
            TCSBaseAmount := "Purch. Inv. Line"."Line Amount"
        else
            TCSBaseAmount := ((Abs(IGSTAmount) + Abs(CGSTAmount) + Abs(SGSTAmount) + Abs(CessAmount) + Abs(UTSTAmount) + Abs("Purch. Inv. Line"."Line Amount")));

        IF decTCSPer <> 0 then
            decTCSAmount := (TCSBaseAmount * decTCSPer / 100)
        else
            decTCSAmount := 0;

        ExcelBuf.AddColumn(txtLedgerDescription, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Vendor Posting Group

        ExcelBuf.AddColumn(Abs(IGSTAmount) + Abs(CGSTAmount) + Abs(SGSTAmount) + Abs(CessAmount) + Abs(UTSTAmount) + "Purch. Inv. Line"."Line Amount" + decTCSAmount, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Total Amount Inc GST

        ExcelBuf.AddColumn(0, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Total Amount Inc GST

        ExcelBuf.AddColumn((TCSBaseAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Total Amount Inc GST

        if (decTCSPer <> 0) then
            ExcelBuf.AddColumn((Abs(decTCSPer)), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number)
        else
            ExcelBuf.AddColumn(0, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);

        if decTCSPer <> 0 then
            ExcelBuf.AddColumn((TCSBaseAmount * decTCSPer / 100), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number)
        else
            ExcelBuf.AddColumn(0, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);

        ExcelBuf.AddColumn(PurchInvHeader."Exclude GST in TCS Base", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);


    end;


    procedure MakeExcelDataBody_Cr()
    var
        BlankFiller: Text[250];
        Item: Record Item;
        PurchCrMemoHdr: Record "Sales Cr.Memo Header";
        cdPostedDocumentNo: Text;
        cdReferenceNo: Text;
        dtPostingDate: Date;
        RefInvoiceNo: Record "Reference Invoice No.";
        RefDocumentDate: Date;
        RefDocumentNo: Code[20];
        decTCSPer: Decimal;
        TCSBaseAmount: Decimal;
        decTCSAmount: Decimal;
        VendorLedgerEntry: Record "Cust. Ledger Entry";
    begin
        ExcelBuf.NewRow;
        CompanyInformation.Get();
        ExcelBuf.AddColumn(CompanyInformation.Name, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//company
        PurchCrMemoHdr.Get("Purch. Cr. Memo Line"."Document No.");
        ExcelBuf.AddColumn(PurchCrMemoHdr."Location GST Reg. No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Location  Reg_ No_
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Shortcut Dimension 1 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//unit Code
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Shortcut Dimension 2 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Department Code
        ExcelBuf.AddColumn(FiscalYearEndDate, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Department Code
        ExcelBuf.AddColumn(txtQuarter, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Financial Quarter
        ExcelBuf.AddColumn(FORMAT("Purch. Cr. Memo Line"."Posting Date", 0, '<Month Text>'), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Month Name
        ExcelBuf.AddColumn('Sales', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Transaction Type
        ExcelBuf.AddColumn(PurchCrMemoHdr."Invoice Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Doc Type
        ExcelBuf.AddColumn(PurchCrMemoHdr."Invoice Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Doc Type
        ExcelBuf.AddColumn('Credit Note', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Type of Document
        ExcelBuf.AddColumn("Purch. Cr. Memo Line".Type, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Type
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Return Receipt No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Sales Shipment/Sales Receipt No
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Sales Shipment/Sales Receipt No
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Posting Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);//Sales Shipment/Sales Receipt No
        RefDocumentNo := '';
        RefDocumentDate := 0D;

        RefInvoiceNo.Reset();
        RefInvoiceNo.SetRange(RefInvoiceNo."Source Type", RefInvoiceNo."Source Type"::Customer);
        RefInvoiceNo.SetRange(RefInvoiceNo."Source No.", "Purch. Cr. Memo Line"."Sell-to Customer No.");
        RefInvoiceNo.SetRange(RefInvoiceNo."Document No.", "Purch. Cr. Memo Line"."Document No.");
        IF RefInvoiceNo.FindFirst() then begin
            RefDocumentNo := RefInvoiceNo."Reference Invoice Nos.";
            VendorLedgerEntry.Reset();
            VendorLedgerEntry.SetRange("Document No.", RefInvoiceNo."Reference Invoice Nos.");
            IF VendorLedgerEntry.FindFirst() then
                RefDocumentDate := VendorLedgerEntry."Posting Date";
        end;
        RefDocumentNo := '';
        RefDocumentDate := 0D;

        RefInvoiceNo.Reset();
        RefInvoiceNo.SetRange(RefInvoiceNo."Source Type", RefInvoiceNo."Source Type"::Customer);
        RefInvoiceNo.SetRange(RefInvoiceNo."Source No.", "Purch. Cr. Memo Line"."Sell-to Customer No.");
        RefInvoiceNo.SetRange(RefInvoiceNo."Document No.", "Purch. Cr. Memo Line"."Document No.");
        IF RefInvoiceNo.FindFirst() then begin
            RefDocumentNo := RefInvoiceNo."Reference Invoice Nos.";
            VendorLedgerEntry.Reset();
            VendorLedgerEntry.SetRange("Document No.", RefInvoiceNo."Reference Invoice Nos.");
            IF VendorLedgerEntry.FindFirst() then
                RefDocumentDate := VendorLedgerEntry."Posting Date";
        end;

        ExcelBuf.AddColumn(RefDocumentNo, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Sales Shipment/Sales Receipt No
        ExcelBuf.AddColumn(RefDocumentDate, false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);//Sales Shipment/Sales Receipt No
        HisPurchSalesHeader.Reset();
        HisPurchSalesHeader.SetRange("Record Type", HisPurchSalesHeader."Record Type"::Revenue);
        HisPurchSalesHeader.SetRange("Document Type", HisPurchSalesHeader."Document Type"::Invoice);
        HisPurchSalesHeader.SetRange("Document No.", "Purch. Cr. Memo Line"."Document No.");
        IF HisPurchSalesHeader.FindFirst() then
            ExcelBuf.AddColumn(HisPurchSalesHeader."Document Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date)//Document Date
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Return Reason Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn(PurchCrMemoHdr."E-Way Bill No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn(PurchCrMemoHdr."Shipment Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);//Document Date

        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date

        ExcelBuf.AddColumn(PurchCrMemoHdr."Invoice Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Item Category Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Gen. Prod. Posting Group", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Sell-to Customer No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn(PurchCrMemoHdr."Bill-to Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn(PurchCrMemoHdr."Customer Posting Group", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn(PurchCrMemoHdr."Sell-to Address" + '' + PurchCrMemoHdr."Sell-to Address 2", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        Vendor.Get(PurchCrMemoHdr."Sell-to Customer No.");
        IF State.Get(Vendor."State Code") then;
        IF State.Description <> '' then
            ExcelBuf.AddColumn(State.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)//Consignee Name
        else
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        IF PurchCrMemoHdr."Customer GST Reg. No." <> '' then
            ExcelBuf.AddColumn(PurchCrMemoHdr."Customer GST Reg. No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)//Consignee Name
        else
            ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn(PurchCrMemoHdr."GST Customer Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn(PurchCrMemoHdr."Gen. Bus. Posting Group", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn("Purch. Cr. Memo Line".Description + '' + "Purch. Cr. Memo Line"."Description 2", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Unit of Measure", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."HSN/SAC Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."GST Jurisdiction Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."GST Group Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn(PurchCrMemoHdr."Nature of Supply", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn(-"Purch. Cr. Memo Line".Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);//Consignee Name
        ExcelBuf.AddColumn(-"Purch. Cr. Memo Line"."Unit Price Incl. of Tax", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);//Consignee Name
        ExcelBuf.AddColumn(-"Purch. Cr. Memo Line"."Unit Price", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);//Consignee Name
        ExcelBuf.AddColumn(Abs("Purch. Cr. Memo Line"."Line Discount Amount") + ABS("Purch. Cr. Memo Line"."Inv. Discount Amount"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);//Consignee Name
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."GST Group Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);//Consignee Name
        ExcelBuf.AddColumn(-"Purch. Cr. Memo Line"."Line Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);//Consignee Name
        CGSTRate := 0;
        CGSTAmount := 0;
        IGSTRate := 0;
        IGSTAmount := 0;
        SGSTRate := 0;
        SGSTAmount := 0;
        UTSTRate := 0;
        UTSTAmount := 0;
        CessAmount := 0;
        CessRate := 0;

        DetailedGSTLedgerEntry.Reset;
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
        DetailedGSTLedgerEntry.SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::"Credit Memo");
        DetailedGSTLedgerEntry.SetRange("Document No.", "Purch. Cr. Memo Line"."Document No.");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", "Purch. Cr. Memo Line"."Line No.");
        if DetailedGSTLedgerEntry.FindSet then begin
            repeat
                if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
                    CGSTRate := DetailedGSTLedgerEntry."GST %";
                    CGSTAmount += DetailedGSTLedgerEntry."GST Amount";
                end;
                if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
                    IGSTRate := DetailedGSTLedgerEntry."GST %";
                    IGSTAmount += DetailedGSTLedgerEntry."GST Amount";
                end;
                if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then begin
                    SGSTRate := DetailedGSTLedgerEntry."GST %";
                    SGSTAmount += DetailedGSTLedgerEntry."GST Amount";
                end;
                if DetailedGSTLedgerEntry."GST Component Code" = 'UTGST' then begin
                    UTSTRate := DetailedGSTLedgerEntry."GST %";
                    UTSTAmount += DetailedGSTLedgerEntry."GST Amount";
                end;
                GSTSetup.Get();
                if DetailedGSTLedgerEntry."GST Component Code" = GSTSetup."Cess Tax Type" then begin
                    CessRate := DetailedGSTLedgerEntry."GST %";
                    CessAmount += DetailedGSTLedgerEntry."GST Amount";
                end;
            until DetailedGSTLedgerEntry.Next = 0;
        end;

        ExcelBuf.AddColumn(-Abs(IGSTRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//IGST %
        ExcelBuf.AddColumn(-Abs(IGSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//IGST Amount
        ExcelBuf.AddColumn(-Abs(CGSTRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//CGST %
        ExcelBuf.AddColumn(-Abs(CGSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//CGST Amount
        ExcelBuf.AddColumn(-Abs(SGSTRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//SGST %
        ExcelBuf.AddColumn(-Abs(SGSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//SGST Amount
        ExcelBuf.AddColumn(-Abs(UTSTRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST %
        ExcelBuf.AddColumn(-Abs(UTSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST Amount
        ExcelBuf.AddColumn(-Abs(CessRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST %
        ExcelBuf.AddColumn(-Abs(CessAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST Amount
        ExcelBuf.AddColumn(-(Abs(IGSTAmount) + Abs(CGSTAmount) + Abs(SGSTAmount) + Abs(UTSTAmount) + Abs(CessAmount)), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Total GST Amount
        txtLedgerDescription := '';
        GenPostingSetup.Reset();
        GenPostingSetup.SetRange("Gen. Bus. Posting Group", "Purch. Cr. Memo Line"."Gen. Bus. Posting Group");
        GenPostingSetup.SetRange("Gen. Prod. Posting Group", "Purch. Cr. Memo Line"."Gen. Prod. Posting Group");
        IF GenPostingSetup.FindFirst() then begin
            GLAccount.Get(GenPostingSetup."Purch. Account");
            txtLedgerDescription := GLAccount.Name;
        end;

        decTCSPer := 0;
        TCSEntries.Reset();
        TCSEntries.SetRange("Document No.", "Purch. Cr. Memo Line"."Document No.");
        TCSEntries.SetRange("TCS Nature of Collection", "Purch. Cr. Memo Line"."TCS Nature of Collection");
        if TCSEntries.FindFirst() then begin
            decTCSPer := TCSEntries."TCS %";
        end;

        TCSBaseAmount := 0;
        IF (PurchCrMemoHdr."Exclude GST in TCS Base") and (decTCSPer <> 0) then
            TCSBaseAmount := "Purch. Cr. Memo Line"."Line Amount"
        else
            TCSBaseAmount := ((Abs(IGSTAmount) + Abs(CGSTAmount) + Abs(SGSTAmount) + Abs(CessAmount) + Abs(UTSTAmount) + Abs("Purch. Cr. Memo Line"."Line Amount")));

        IF decTCSPer <> 0 then
            decTCSAmount := (TCSBaseAmount * decTCSPer / 100)
        else
            decTCSAmount := 0;

        ExcelBuf.AddColumn(txtLedgerDescription, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Vendor Posting Group

        ExcelBuf.AddColumn(-(Abs(IGSTAmount) + Abs(CGSTAmount) + Abs(SGSTAmount) + Abs(CessAmount) + Abs(UTSTAmount) + "Purch. Cr. Memo Line"."Line Amount" + ABS(decTCSAmount)), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Total Amount Inc GST

        ExcelBuf.AddColumn(0, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Total Amount Inc GST

        ExcelBuf.AddColumn(-Abs(TCSBaseAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Total Amount Inc GST

        if (decTCSPer <> 0) then
            ExcelBuf.AddColumn(-(Abs(decTCSPer)), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number)
        else
            ExcelBuf.AddColumn(0, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);

        if decTCSPer <> 0 then
            ExcelBuf.AddColumn(-Abs(TCSBaseAmount * decTCSPer / 100), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number)
        else
            ExcelBuf.AddColumn(0, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);

        ExcelBuf.AddColumn(PurchCrMemoHdr."Exclude GST in TCS Base", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);



    end;


    procedure CreateExcelbook()
    var
        ExcelFileNameLbl: Label 'SalesTaxRegister%1_%2', Comment = '%1= DateTime, %2 = UserID';
    begin
        //ExcelBuf.CreateBookAndOpenExcel('', Text001, '', CompanyName, UserId);
        //Error('');
        ExcelBuf.CreateNewBook(Text001);
        ExcelBuf.WriteSheet(Text001, CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo(ExcelFileNameLbl, CurrentDateTime, UserId));
        ExcelBuf.OpenExcel();
    end;
}

