report 50018 "Purchase Tax Register"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Purchase Tax Register';

    dataset
    {
        dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
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
                    SetFilter("Buy-from Vendor No.", VendorCode);

                if GLAccountNo <> '' then
                    SetFilter("No.", GLAccountNo);
            end;
        }
        dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
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
        Text001: Label 'Purchase Tax Register';
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        State: Record State;
        GenProductPostingGroup: Record "Gen. Product Posting Group";
        GenPostingSetup: Record "General Posting Setup";
        Location: Record Location;
        ShiptoAddress: Record "Ship-to Address";
        Vendor: Record Vendor;
        FiscalYearStartDate: Date;
        FiscalYearEndDate: Date;
        LastYearStartDate: Date;
        LastYearEndDate: Date;
        Month: Integer;
        txtQuarter: Text;
        PurchInvHeader: Record "Purch. Inv. Header";
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
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";


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
        ExcelBuf.AddColumn('Unit Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Dimension1
        ExcelBuf.AddColumn('Department Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Dimension2
        ExcelBuf.AddColumn('Document No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Document No.
        ExcelBuf.AddColumn('Receipt/Return No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor Invoice Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Document Date
        ExcelBuf.AddColumn('Document Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Document Type
        ExcelBuf.AddColumn('Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Type
        ExcelBuf.AddColumn('Item No./GL No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Item No.
        ExcelBuf.AddColumn('Item Description', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Item Description
        ExcelBuf.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Posting Date
        ExcelBuf.AddColumn('Vendor Invoice/Cr. Memo No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Vendor Invoice No.
        ExcelBuf.AddColumn('Place Of Supply', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Seller State
        ExcelBuf.AddColumn('Buy-from Vendor No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Buy-from Vendor No.
        ExcelBuf.AddColumn('Vendor Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Buy-from Vendor Name
        ExcelBuf.AddColumn('Vendor Address', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Vendor Address
        ExcelBuf.AddColumn('Location Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Location Name
        ExcelBuf.AddColumn('Location Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Location Code
        ExcelBuf.AddColumn('Gen. Bus. Posting Group', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Gen_ Bus_ Posting Group
        ExcelBuf.AddColumn('City', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//City
        ExcelBuf.AddColumn('Ship-to City', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Ship-to City
        ExcelBuf.AddColumn('User ID', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//User ID
        ExcelBuf.AddColumn('P.A.N. No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//P_A_N_ No_
        ExcelBuf.AddColumn('GST Group Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//GST Availment
        ExcelBuf.AddColumn('GST Credit Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//GST Credit Type
        ExcelBuf.AddColumn('Ledger Description', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Ledger Description
        ExcelBuf.AddColumn('Store Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Store Name
        ExcelBuf.AddColumn('Nature of TAX', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Nature of TAX
        ExcelBuf.AddColumn('Vendor Posting Group', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Vendor Posting Group
        ExcelBuf.AddColumn('GST Registration No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//GST Registration No.
        ExcelBuf.AddColumn('GST Vendor Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//GST Vendor Type
        ExcelBuf.AddColumn('HSN_SAC Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//HSN_SAC Code
        ExcelBuf.AddColumn('External Document No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//External Document No.
        ExcelBuf.AddColumn('GST Rate', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//GST Group Code
        ExcelBuf.AddColumn('Gen. Prod. Posting Group', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Gen_ Prod_ Posting Group
        ExcelBuf.AddColumn('Location Reg. No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Location  Reg_ No_
        ExcelBuf.AddColumn('Pay-to Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Pay-to Name
        ExcelBuf.AddColumn('Nature of Supply', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Nature of Supply
        ExcelBuf.AddColumn('Purchase Return Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Purchase Return Type
        ExcelBuf.AddColumn('GST Reverse Charge', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//GST Reverse Charge
        ExcelBuf.AddColumn('GST Jurisdiction Type', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//GST Jurisdiction Type
        ExcelBuf.AddColumn('Posted Description', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Type of Supply

        ExcelBuf.AddColumn('Unit of Measurement', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Quantity
        ExcelBuf.AddColumn('Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Amount
        ExcelBuf.AddColumn('Line Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Line Amount
        ExcelBuf.AddColumn('Cost Price ', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Unit Cost

        ExcelBuf.AddColumn('IGST %', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//IGST %
        ExcelBuf.AddColumn('CGST %', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//CGST %
        ExcelBuf.AddColumn('SGST %', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//SGST %
        ExcelBuf.AddColumn('UTGST %', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//UTGST %
        ExcelBuf.AddColumn('CESS %', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//UTGST %

        ExcelBuf.AddColumn('IGST Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//IGST Amount
        ExcelBuf.AddColumn('CGST Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//CGST Amount
        ExcelBuf.AddColumn('SGST Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//SGST Amount
        ExcelBuf.AddColumn('UTGST Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//UTGST Amount
        ExcelBuf.AddColumn('CESS Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//UTGST Amount

        ExcelBuf.AddColumn('Total Tax Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Total GST Amount
        ExcelBuf.AddColumn('Taxable Value of Invoice', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//GST Base Amount
        ExcelBuf.AddColumn('TDS Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//TDS Amount
        ExcelBuf.AddColumn('Inv. Discount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//TDS Amount
        ExcelBuf.AddColumn('TCS Amount', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//TDS Amount
        ExcelBuf.AddColumn('Total Invoice Value ( Taxable Value + GST)', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Total Amount Inc GST
    end;

    procedure MakeExcelDataBody()
    var
        BlankFiller: Text[250];
        Item: Record Item;
        PurchInvHeader1: Record "Purch. Inv. Header";
        cdPostedDocumentNo1: Text;
        cdReferenceNo1: Text;
        dtPostingDate1: Date;
        cdVendorReferenceNo1: Text;
        cdVendorInvoiceNo1: Text;
        cdVendorInvoiceDate1: Date;
    begin
        ExcelBuf.NewRow;
        CompanyInformation.Get();
        ExcelBuf.AddColumn("Purch. Inv. Line"."Shortcut Dimension 1 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Dimension1
        ExcelBuf.AddColumn("Purch. Inv. Line"."Shortcut Dimension 2 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Dimension2
        ExcelBuf.AddColumn("Purch. Inv. Line"."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document No
        ExcelBuf.AddColumn("Purch. Inv. Line"."Receipt No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        PurchInvHeader.Get("Purch. Inv. Line"."Document No.");
        HisPurchSalesHeader.Reset();
        HisPurchSalesHeader.SetRange("Record Type", HisPurchSalesHeader."Record Type"::GRN);
        HisPurchSalesHeader.SetRange("Document Type", HisPurchSalesHeader."Document Type"::Order);
        HisPurchSalesHeader.SetRange("Document No.", "Purch. Inv. Line"."Document No.");
        IF HisPurchSalesHeader.FindFirst() then
            ExcelBuf.AddColumn(HisPurchSalesHeader."Vendor Invoice Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date)//Document Date
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date

        ExcelBuf.AddColumn('Purchase Invoice', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Type
        ExcelBuf.AddColumn("Purch. Inv. Line".Type, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Type

        ChrItemNo := '';
        OrigianlDocNo := '';
        OrigianlDocDate := 0D;
        DetailedGSTLedgerEntry.Reset;
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Purchase);
        DetailedGSTLedgerEntry.SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
        DetailedGSTLedgerEntry.SetRange("Document No.", "Purch. Inv. Line"."Document No.");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", "Purch. Inv. Line"."Line No.");
        if DetailedGSTLedgerEntry.FindSet then
            OrigianlDocDate := DetailedGSTLedgerEntry."Posting Date";
        OrigianlDocNo := DetailedGSTLedgerEntry."Original Invoice No.";
        if (DetailedGSTLedgerEntry."GST Component Code" = 'CGST') or (DetailedGSTLedgerEntry."GST Component Code" = 'IGST') or (DetailedGSTLedgerEntry."GST Component Code" = 'SGST') then
            ChrItemNo := DetailedGSTLedgerEntry."No.";

        if "Purch. Inv. Line".Type = "Purch. Inv. Line".Type::"Charge (Item)" then
            ExcelBuf.AddColumn(ChrItemNo, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//ItemNo
        else
            ExcelBuf.AddColumn("Purch. Inv. Line"."No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//ItemNo

        if "Purch. Inv. Line".Type = "Purch. Inv. Line".Type::"Charge (Item)" then begin
            if Item.Get(ChrItemNo) then
                ExcelBuf.AddColumn(Item.Description + '' + Item."Description 2", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//ItemName
        end else
            ExcelBuf.AddColumn("Purch. Inv. Line".Description + '' + "Purch. Inv. Line"."Description 2", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//ItemName

        ExcelBuf.AddColumn(("Purch. Inv. Line"."Posting Date"), false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);//Posting Date
        IF PurchInvHeader."Vendor Invoice No." <> '' then
            ExcelBuf.AddColumn(PurchInvHeader."Vendor Invoice No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//Vendor Invoice No_
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Vendor Invoice No_

        if Vendor.GET("Purch. Inv. Line"."Buy-from Vendor No.") then;
        if State.Get(Vendor."State Code") then;
        if State.Description <> '' then
            ExcelBuf.AddColumn(State.Description, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//Seller State
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Purch. Inv. Line"."Buy-from Vendor No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Buy-from Vendor No.
        if Vendor.Get("Purch. Inv. Line"."Buy-from Vendor No.") then
            ExcelBuf.AddColumn(Vendor.Name + ' ' + Vendor."Name 2", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Buy-from Vendor Name

        ExcelBuf.AddColumn(Vendor.Address + ' ' + Vendor."Address 2", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Vendor Address
        if LocationRec.Get("Purch. Inv. Line"."Location Code") then;
        if LocationRec.Name <> '' then
            ExcelBuf.AddColumn(LocationRec.Name, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//Location Name
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Location Name
        if "Purch. Inv. Line"."Location Code" <> '' then
            ExcelBuf.AddColumn("Purch. Inv. Line"."Location Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//Location Code
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Location Code
        IF PurchInvHeader."Gen. Bus. Posting Group" <> '' then
            ExcelBuf.AddColumn(PurchInvHeader."Gen. Bus. Posting Group", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//Gen. Bus. Posting Group
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Gen. Bus. Posting Group

        IF PurchInvHeader."Buy-from City" <> '' then
            ExcelBuf.AddColumn(PurchInvHeader."Buy-from City", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//City
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//City
        if PurchInvHeader."Ship-to City" <> '' then
            ExcelBuf.AddColumn(PurchInvHeader."Ship-to City", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//Ship-to City
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Ship-to City

        ExcelBuf.AddColumn(PurchInvHeader."User ID", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//User ID
        Vendor.Get("Purch. Inv. Line"."Buy-from Vendor No.");
        IF Vendor."P.A.N. No." <> '' then
            ExcelBuf.AddColumn(Vendor."P.A.N. No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//P.A.N. No.
        else
            ExcelBuf.AddColumn(Vendor."P.A.N. No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//P.A.N. No.

        ExcelBuf.AddColumn("Purch. Inv. Line"."GST Group Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Availment

        ExcelBuf.AddColumn("Purch. Inv. Line"."GST Credit", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Credit Type

        // txtLedgerDescription := '';
        // PurchInvLine.Reset();
        // PurchInvLine.SetRange("No.", "Purch. Inv. Line"."No.");
        // //GenPostingSetup.SetRange("Gen. Prod. Posting Group", "Purch. Inv. Line"."Gen. Prod. Posting Group");
        // IF PurchInvLine.FindFirst() then begin
        //     GLAccount.Get(PurchInvLine."No.");
        //     txtLedgerDescription := GLAccount.Name;
        // end;
        txtLedgerDescription := '';
        PurchInvLine.Reset();
        PurchInvLine.SetRange("Document No.", "Purch. Inv. Line"."Document No.");
        PurchInvLine.SetRange("Line No.", "Purch. Inv. Line"."Line No.");
        if PurchInvLine.FindFirst() then begin
            case PurchInvLine.Type of
                PurchInvLine.Type::"G/L Account":
                    begin
                        if GLAccount.Get(PurchInvLine."No.") then
                            txtLedgerDescription := GLAccount.Name;
                    end;
                PurchCrMemoLine.Type::Item:
                    begin
                        if Item.Get(PurchInvLine."No.") then
                            txtLedgerDescription := Item.Description;
                    end;
            end;
        end;

        ExcelBuf.AddColumn(txtLedgerDescription, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Vendor Posting Group
        ExcelBuf.AddColumn(PurchInvHeader."Store Name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Store Name
        ExcelBuf.AddColumn(PurchInvHeader."Invoice Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Nature of TAX
        ExcelBuf.AddColumn(PurchInvHeader."Vendor Posting Group", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Vendor Posting Group
        ExcelBuf.AddColumn(PurchInvHeader."Vendor GST Reg. No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Registration No.
        ExcelBuf.AddColumn(PurchInvHeader."GST Vendor Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Vendor Type
        ExcelBuf.AddColumn("Purch. Inv. Line"."HSN/SAC Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//HSN_SAC Code
        ExcelBuf.AddColumn(PurchInvHeader."Your Reference", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//External Document No.
        ExcelBuf.AddColumn("Purch. Inv. Line"."GST Group Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Group Code
        ExcelBuf.AddColumn("Purch. Inv. Line"."Gen. Prod. Posting Group", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Gen. Prod. Posting Group
        ExcelBuf.AddColumn(PurchInvHeader."Location GST Reg. No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Location  Reg_ No_
        ExcelBuf.AddColumn(PurchInvHeader."Pay-to Name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Pay-to Name
        ExcelBuf.AddColumn(PurchInvHeader."Nature of Supply", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Nature of Supply
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Purchase Return Type
        ExcelBuf.AddColumn("Purch. Inv. Line"."GST Reverse Charge", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Reverse Charge
        ExcelBuf.AddColumn("Purch. Inv. Line"."GST Jurisdiction Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //GST Jurisdiction Type
        ExcelBuf.AddColumn(PurchInvHeader."Posting Description", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Remarks
        ExcelBuf.AddColumn("Purch. Inv. Line"."Unit of Measure Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Quantity
        ExcelBuf.AddColumn("Purch. Inv. Line".Quantity, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Quantity
        ExcelBuf.AddColumn("Purch. Inv. Line".Amount, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Amount
        ExcelBuf.AddColumn("Purch. Inv. Line"."Line Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Line Amount
        ExcelBuf.AddColumn("Purch. Inv. Line"."Direct Unit Cost", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Unit Cost

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
        DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Purchase);
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
        ExcelBuf.AddColumn(Abs(CGSTRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//CGST %
        ExcelBuf.AddColumn(Abs(SGSTRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//SGST %
        ExcelBuf.AddColumn(Abs(UTSTRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST %
        ExcelBuf.AddColumn(Abs(CessRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST %
        ExcelBuf.AddColumn(Abs(IGSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//IGST Amount
        ExcelBuf.AddColumn(Abs(CGSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//CGST Amount
        ExcelBuf.AddColumn(Abs(SGSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//SGST Amount
        ExcelBuf.AddColumn(Abs(UTSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST Amount
        ExcelBuf.AddColumn(Abs(CessAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST Amount


        ExcelBuf.AddColumn(Abs(IGSTAmount) + Abs(CGSTAmount) + Abs(SGSTAmount) + Abs(UTSTAmount) + Abs(CessAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Total GST Amount

        ExcelBuf.AddColumn("Purch. Inv. Line"."Line Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//GST Base Amount
        TDSLedgerEntry.Reset();
        TDSLedgerEntry.SetRange("Document No.", "Purch. Inv. Line"."Document No.");
        TDSLedgerEntry.SetRange("Vendor No.", "Purch. Inv. Line"."Buy-from Vendor No.");
        TDSLedgerEntry.SetRange(TDSLedgerEntry.Section, "Purch. Inv. Line"."TDS Section Code");
        if TDSLedgerEntry.FindFirst() then
            ExcelBuf.AddColumn(abs(("Purch. Inv. Line"."Line Amount" * TDSLedgerEntry."TDS %") / 100), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number)//TDS Amount
        else
            ExcelBuf.AddColumn(0, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//TDS Amount

        ExcelBuf.AddColumn("Purch. Inv. Line"."Line Discount Amount" + "Purch. Inv. Line"."Inv. Discount Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Discount

        TCSEntries.Reset();
        TCSEntries.SetRange("Document No.", "Purch. Inv. Line"."Document No.");
        if TCSEntries.FindFirst() then
            ExcelBuf.AddColumn((Abs(TCSEntries."TCS Amount") / "Purch. Inv. Line".Quantity), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number)
        else
            ExcelBuf.AddColumn(0, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);

        ExcelBuf.AddColumn(Abs(IGSTAmount) + Abs(CGSTAmount) + Abs(SGSTAmount) + Abs(CessAmount) + Abs(UTSTAmount) + "Purch. Inv. Line"."Line Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Total Amount Inc GST
    end;


    procedure MakeExcelDataBody_Cr()
    var
        BlankFiller: Text[250];
        Item: Record Item;
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        cdPostedDocumentNo: Text;
        cdReferenceNo: Text;
        dtPostingDate: Date;
    begin

        ExcelBuf.NewRow;
        CompanyInformation.Get();
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Shortcut Dimension 1 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Dimension1
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Shortcut Dimension 2 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Dimension2
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document No
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Return Shipment No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        PurchCrMemoHdr.Get("Purch. Cr. Memo Line"."Document No.");
        HisPurchSalesHeader.Reset();
        HisPurchSalesHeader.SetRange("Record Type", HisPurchSalesHeader."Record Type"::"GRN Return");
        HisPurchSalesHeader.SetRange("Document Type", HisPurchSalesHeader."Document Type"::"Return Order");
        HisPurchSalesHeader.SetRange("Document No.", "Purch. Cr. Memo Line"."Document No.");
        IF HisPurchSalesHeader.FindFirst() then
            ExcelBuf.AddColumn(HisPurchSalesHeader."Vendor Invoice Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date)//Document Date
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Date

        ExcelBuf.AddColumn('Purchase Credit Note', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document Type
        ExcelBuf.AddColumn("Purch. Cr. Memo Line".Type, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Type

        ChrItemNo := '';
        OrigianlDocNo := '';
        OrigianlDocDate := 0D;
        DetailedGSTLedgerEntry.Reset;
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Purchase);
        DetailedGSTLedgerEntry.SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::"Credit Memo");
        DetailedGSTLedgerEntry.SetRange("Document No.", "Purch. Cr. Memo Line"."Document No.");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", "Purch. Cr. Memo Line"."Line No.");
        if DetailedGSTLedgerEntry.FindSet then
            OrigianlDocDate := DetailedGSTLedgerEntry."Posting Date";
        OrigianlDocNo := DetailedGSTLedgerEntry."Original Invoice No.";
        if (DetailedGSTLedgerEntry."GST Component Code" = 'CGST') or (DetailedGSTLedgerEntry."GST Component Code" = 'IGST') or (DetailedGSTLedgerEntry."GST Component Code" = 'SGST') then
            ChrItemNo := DetailedGSTLedgerEntry."No.";

        if "Purch. Cr. Memo Line".Type = "Purch. Cr. Memo Line".Type::"Charge (Item)" then
            ExcelBuf.AddColumn(ChrItemNo, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//ItemNo
        else
            ExcelBuf.AddColumn("Purch. Cr. Memo Line"."No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//ItemNo

        if "Purch. Cr. Memo Line".Type = "Purch. Cr. Memo Line".Type::"Charge (Item)" then begin
            if Item.Get(ChrItemNo) then
                ExcelBuf.AddColumn(Item.Description + '' + Item."Description 2", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//ItemName
        end else
            ExcelBuf.AddColumn("Purch. Cr. Memo Line".Description + '' + "Purch. Cr. Memo Line"."Description 2", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//ItemName

        ExcelBuf.AddColumn(("Purch. Cr. Memo Line"."Posting Date"), false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);//Posting Date
        IF PurchCrMemoHdr."Vendor Cr. Memo No." <> '' then
            ExcelBuf.AddColumn(PurchCrMemoHdr."Vendor Cr. Memo No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//Vendor Invoice No_
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Vendor Invoice No_

        if Vendor.GET("Purch. Cr. Memo Line"."Buy-from Vendor No.") then;
        if State.Get(Vendor."State Code") then;
        if State.Description <> '' then
            ExcelBuf.AddColumn(State.Description, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//Seller State
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Buy-from Vendor No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Buy-from Vendor No.
        if Vendor.Get("Purch. Cr. Memo Line"."Buy-from Vendor No.") then
            ExcelBuf.AddColumn(Vendor.Name + ' ' + Vendor."Name 2", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Buy-from Vendor Name

        ExcelBuf.AddColumn(Vendor.Address + ' ' + Vendor."Address 2", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Vendor Address
        if LocationRec.Get("Purch. Cr. Memo Line"."Location Code") then;
        if LocationRec.Name <> '' then
            ExcelBuf.AddColumn(LocationRec.Name, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//Location Name
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Location Name
        if "Purch. Cr. Memo Line"."Location Code" <> '' then
            ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Location Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//Location Code
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Location Code
        IF PurchCrMemoHdr."Gen. Bus. Posting Group" <> '' then
            ExcelBuf.AddColumn(PurchCrMemoHdr."Gen. Bus. Posting Group", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//Gen. Bus. Posting Group
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Gen. Bus. Posting Group

        IF PurchCrMemoHdr."Buy-from City" <> '' then
            ExcelBuf.AddColumn(PurchCrMemoHdr."Buy-from City", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//City
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//City
        if PurchCrMemoHdr."Ship-to City" <> '' then
            ExcelBuf.AddColumn(PurchCrMemoHdr."Ship-to City", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//Ship-to City
        else
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Ship-to City

        ExcelBuf.AddColumn(PurchCrMemoHdr."User ID", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//User ID
        Vendor.Get("Purch. Cr. Memo Line"."Buy-from Vendor No.");
        IF Vendor."P.A.N. No." <> '' then
            ExcelBuf.AddColumn(Vendor."P.A.N. No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)//P.A.N. No.
        else
            ExcelBuf.AddColumn(Vendor."P.A.N. No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//P.A.N. No.

        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."GST Group Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Availment

        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."GST Credit", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Credit Type

        txtLedgerDescription := '';
        PurchCrMemoLine.Reset();
        PurchCrMemoLine.SetRange("Document No.", "Purch. Cr. Memo Line"."Document No.");
        PurchCrMemoLine.SetRange("Line No.", "Purch. Cr. Memo Line"."Line No.");
        if PurchCrMemoLine.FindFirst() then begin
            case PurchCrMemoLine.Type of
                PurchCrMemoLine.Type::"G/L Account":
                    begin
                        if GLAccount.Get(PurchCrMemoLine."No.") then
                            txtLedgerDescription := GLAccount.Name;
                    end;
                PurchCrMemoLine.Type::Item:
                    begin
                        if Item.Get(PurchCrMemoLine."No.") then
                            txtLedgerDescription := Item.Description;
                    end;
            end;
        end;


        ExcelBuf.AddColumn(txtLedgerDescription, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Vendor Posting Group
        ExcelBuf.AddColumn(PurchCrMemoHdr."Store Name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(PurchCrMemoHdr."Invoice Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Nature of TAX
        ExcelBuf.AddColumn(PurchCrMemoHdr."Vendor Posting Group", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Vendor Posting Group
        ExcelBuf.AddColumn(PurchCrMemoHdr."Vendor GST Reg. No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Registration No.
        ExcelBuf.AddColumn(PurchCrMemoHdr."GST Vendor Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Vendor Type
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."HSN/SAC Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//HSN_SAC Code
        ExcelBuf.AddColumn(PurchCrMemoHdr."Your Reference", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//External Document No.
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."GST Group Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Group Code
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Gen. Prod. Posting Group", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Gen. Prod. Posting Group
        ExcelBuf.AddColumn(PurchCrMemoHdr."Location GST Reg. No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Location  Reg_ No_
        ExcelBuf.AddColumn(PurchCrMemoHdr."Pay-to Name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Pay-to Name
        ExcelBuf.AddColumn(PurchCrMemoHdr."Nature of Supply", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Nature of Supply
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Purchase Return Type
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."GST Reverse Charge", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//GST Reverse Charge
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."GST Jurisdiction Type", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); //GST Jurisdiction Type
        ExcelBuf.AddColumn(PurchCrMemoHdr."Posting Description", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Remarks
        ExcelBuf.AddColumn("Purch. Cr. Memo Line"."Unit of Measure Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Quantity
        ExcelBuf.AddColumn(-"Purch. Cr. Memo Line".Quantity, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Quantity
        ExcelBuf.AddColumn(-"Purch. Cr. Memo Line".Amount, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Amount
        ExcelBuf.AddColumn(-"Purch. Cr. Memo Line"."Line Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Line Amount
        ExcelBuf.AddColumn(-"Purch. Cr. Memo Line"."Direct Unit Cost", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Unit Cost

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
        DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Purchase);
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
        ExcelBuf.AddColumn(-Abs(CGSTRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//CGST %
        ExcelBuf.AddColumn(-Abs(SGSTRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//SGST %
        ExcelBuf.AddColumn(-Abs(UTSTRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST %
        ExcelBuf.AddColumn(-Abs(CessRate), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST %
        ExcelBuf.AddColumn(-Abs(IGSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//IGST Amount
        ExcelBuf.AddColumn(-Abs(CGSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//CGST Amount
        ExcelBuf.AddColumn(-Abs(SGSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//SGST Amount
        ExcelBuf.AddColumn(-Abs(UTSTAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST Amount
        ExcelBuf.AddColumn(-Abs(CessAmount), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//UTGST Amount


        ExcelBuf.AddColumn(-(Abs(IGSTAmount) + Abs(CGSTAmount) + Abs(SGSTAmount) + Abs(UTSTAmount) + Abs(CessAmount)), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Total GST Amount

        ExcelBuf.AddColumn(-"Purch. Cr. Memo Line"."Line Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//GST Base Amount
        ExcelBuf.AddColumn(0, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//TDS Amount

        ExcelBuf.AddColumn(-("Purch. Cr. Memo Line"."Line Discount Amount" + "Purch. Cr. Memo Line"."Inv. Discount Amount"), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Discount

        TCSEntries.Reset();
        TCSEntries.SetRange("Document No.", "Purch. Cr. Memo Line"."Document No.");
        if TCSEntries.FindFirst() then
            ExcelBuf.AddColumn(-(Abs(TCSEntries."TCS Amount") / "Purch. Cr. Memo Line".Quantity), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number)
        else
            ExcelBuf.AddColumn(0, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);

        ExcelBuf.AddColumn(-(Abs(IGSTAmount) + Abs(CGSTAmount) + Abs(SGSTAmount) + Abs(CessAmount) + Abs(UTSTAmount) + "Purch. Cr. Memo Line"."Line Amount"), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);//Total Amount Inc GST

    end;


    procedure CreateExcelbook()
    var
        ExcelFileNameLbl: Label 'PurchaseTaxRegister%1_%2', Comment = '%1= DateTime, %2 = UserID';
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

