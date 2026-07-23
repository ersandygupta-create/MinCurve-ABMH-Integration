report 50015 "Purchase Order Print"
{
    ApplicationArea = All;
    Caption = 'Purchase Order';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50015PurchaseOrderNew.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            RequestFilterHeading = 'Purchase Order Print';

            column(CompanyName; compinfo.Name)
            {
            }
            column(CompanyName2;
            CompInfo."Name 2")
            {
            }
            column(CompanyAddress; CompAdd)
            {
            }
            column(ComPANNo; compinfo."P.A.N. No.")
            {
            }
            column(ComWebSite; compinfo."Home Page")
            {
            }
            column(Email; Email)
            {
            }
            column(PhoneNo; PhoneNo)
            {
            }
            column(GSTIN; GSTIN)
            {
            }
            column(txtcomment; txtcomment)
            {

            }
            column(txtcommentNote; txtcommentNote)
            {

            }
            column(txtVendorComment; txtVendorComment)
            {
            }
            column(PayTerms; PayTerms)
            {
            }
            column(DrugLigNo; DrugLigNo)
            {
            }
            column(LocationAdd; LocationAdd)
            {
            }

            column(LocationEmail; LocationEmail)
            {
            }
            column(LocationPhoneNo; LocationPhoneNo)
            {
            }
            column(LocationGSTIN; LocationGSTIN)
            {
            }
            column(LocationWebsite; LocationWebsite)
            {

            }
            column(Document_Type; "Document Type")
            {
            }
            column(PurchInvNo; "No.")
            {
            }
            column(PurchInvPostingDate; Format("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Order_Date; "Order Date")
            {
            }
            column(Status; Status)
            {
            }
            column(SystemCreatedBy; userc."User Name")
            {
            }
            column(SystemModifiedBy; userm."User Name")
            {
            }
            column(ApprovedBy; userId)
            {
            }
            column(CreatedBy; PreparedBy)
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SupplierAdd; PurchaseHeader."Buy-from Address" + ', ' + PurchaseHeader."Buy-from Address 2" + ', ' + PurchaseHeader."Buy-from City" + ', ' + PurchaseHeader."Buy-from Post Code")
            {
            }
            column(SupplierPhoneNo; SupplierPhoneNo)
            {
            }
            column(SupplierName; SupplierName)
            {
            }
            column(Supplier_No; "Buy-from Vendor No.")
            {

            }
            column(IGSTRsAmount_Var; IGSTRsAmount_Var)
            {
            }
            column(CGSTRsAmount_Var; CGSTRsAmount_Var)
            {
            }
            column(SGSTRsAmount_Var; SGSTRsAmount_Var)
            {
            }
            column(SupplierEmail; SupplierEmail)
            {
            }
            column(SupplierGSTIN; PurchaseHeader."Vendor GST Reg. No.")
            {
            }
            column(OrderaddGSTIN; PurchaseHeader."Order Address GST Reg. No.")
            {
            }
            column(DelTerms; PurchaseHeader."E3 Delivery Terms")
            {
            }
            column(SupplierPANNo; SupplierPANNo)
            {
            }
            column(LocationName; LocationName)
            {
            }
            column(AmtWords; AmtWords[1])
            {
            }
            column(TotalAmttoVendor; TotalAmttoVendor)
            {
            }
            column(txtPurchaseHeader; txtPurchaseHeader)
            {

            }
            column(TotalTDS; TotalTDS)
            {
            }
            column(TotalGSTAmount; TotalInclTaxAmount)
            {

            }
            column(CGST_Amt; CGST_Amt)
            {
            }
            column(SGST_Amt; SGST_Amt)
            {
            }
            column(IGST_Amt; IGST_Amt)
            {
            }
            column(Currency_Code; CdCurrencyCode)
            {

            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            trigger OnAfterGetRecord()
            begin
                IF Status = Status::Open then begin
                    txtPurchaseHeader := 'Approval Pending'
                end else
                    if status = status::"Pending Approval" then begin
                        txtPurchaseHeader := 'Approval Pending '
                    end else
                        if status = status::Released then begin
                            txtPurchaseHeader := 'Approved'
                        end;


                SupplierName := '';
                SupplierAdd := '';
                SupplierEmail := '';
                SupplierPhoneNo := '';
                SupplierGSTIN := '';
                IF Customer.Get("Buy-from Vendor No.") THEN begin
                    SupplierName := Customer.Name + '' + Customer."Name 2";
                    IF recState.Get(Customer."State Code") THEN;
                    IF CountryRegion.Get(Customer."Country/Region Code") THEN;
                    SupplierAdd := Customer.Address + ', ' + Customer."Address 2" + ', ' + Customer.City + ', ' + FORMAT(Customer."Post Code") + ', ' + FORMAT(recState.Description) + ', ' + CountryRegion.Name;
                    SupplierEmail := Customer."E-Mail";
                    SupplierPhoneNo := Customer."Phone No.";
                    SupplierGSTIN := Customer."GST Registration No.";
                    SupplierPANNo := Customer."P.A.N. No.";
                end;

                LocationAdd := '';
                LocationEmail := '';
                LocationPhoneNo := '';
                LocationGSTIN := '';
                LocationName := '';
                IF PurchaseHeader."Location Code" <> '' THEN BEGIN
                    Location.RESET;
                    Location.SETRANGE(Code, PurchaseHeader."Location Code");
                    IF Location.FINDFIRST THEN BEGIN
                        recState.Get(Location."State Code");
                        CountryRegion.Get(Location."Country/Region Code");
                        LocationName := Location.Name;
                        LocationAdd := Location.Address + ', ' + Location."Address 2" + ', ' + Location.City + ', ' + FORMAT(Location."Post Code") + ', ' + FORMAT(recState.Description) + ', ' + CountryRegion.Name;
                        LocationEmail := Location."E-Mail";
                        LocationPhoneNo := Location."Phone No.";
                        LocationGSTIN := Location."GST Registration No.";
                        LocationWebsite := Location."Home Page";
                    END;
                end;


                decAmountoVendor := 0;
                recPurchaseLine.Reset();
                recPurchaseLine.SetRange("Document Type", "Document Type");
                recPurchaseLine.SetRange("Document No.", "No.");
                IF recPurchaseLine.FindFirst() then begin
                    repeat
                        decAmountoVendor += recPurchaseLine.Amount;
                    until recPurchaseLine.Next() = 0;
                end;

                IF PurchaseHeader."Currency Code" <> '' then
                    CdCurrencyCode := PurchaseHeader."Currency Code"
                else
                    CdCurrencyCode := 'INR';

                CalcStatistics.GetPurchaseStatisticsAmount(PurchaseHeader, TotalAmttoVendor);
                CalcStatistics.OnGetPurchaseHeaderGSTAmount(PurchaseHeader, TotalInclTaxAmount);
                CalcStatistics.OnGetPurchaseHeaderTDSAmount(PurchaseHeader, TotalTDS);

                if TotalInclTaxAmount = 0 then begin
                    GetGSTAmounts(PurchaseHeader);
                    TotalInclTaxAmount := CGST_Amt + SGST_Amt + IGST_Amt;
                    if TotalInclTaxAmount <> 0 then
                        TotalAmttoVendor += TotalInclTaxAmount;
                end;

                Customer.get("Buy-from Vendor No.");
                IF (Customer."State Code" = "Location State Code") and (TotalInclTaxAmount <> 0) then begin
                    CGSTRsAmount_Var := (TotalInclTaxAmount / 2);
                    SGSTRsAmount_Var := (TotalInclTaxAmount / 2);
                END ELSE
                    IGSTRsAmount_Var := TotalInclTaxAmount;

                PostedVoucher.InitTextVariable;
                PostedVoucher.FormatNoText(AmtWords, Round(TotalAmttoVendor, 1), PurchaseHeader."Currency Code");

                txtcomment := '';
                PurchCommentLine.Reset();
                PurchCommentLine.SetRange("Document Type", "Document Type");
                //PurchCommentLine.SetRange(Type, PurchCommentLine.Type::"Term & Condition");
                PurchCommentLine.SetRange("No.", "No.");
                IF PurchCommentLine.FindSet() then begin
                    repeat
                        txtcomment += PurchCommentLine.Comment;
                    until PurchCommentLine.Next() = 0;
                end;

                txtcommentNote := '';
                PurchCommentLine.Reset();
                PurchCommentLine.SetRange("Document Type", "Document Type");
                PurchCommentLine.SetRange("Document Line No.", PurchCommentLine."Document Line No.");
                PurchCommentLine.SetRange("No.", "No.");
                IF PurchCommentLine.FindSet() then begin
                    repeat
                        txtcommentNote += PurchCommentLine.Comment;
                    until PurchCommentLine.Next() = 0;

                end;
                txtDescription := '';
                ExtendedTextLine.Reset();
                ExtendedTextLine.SetRange("Table Name", ExtendedTextLine."Table Name"::Item);
                ExtendedTextLine.SetRange("No.", PurchaseLine."Vendor Item No.");
                IF ExtendedTextLine.FINDFIRST THEN BEGIN
                    repeat
                        txtDescription += ExtendedTextLine.Text;
                    UNTIL ExtendedTextLine.NEXT() = 0;

                    // END ELSE
                    //txtDescription := "Purchase Line".Description + '' + "Purchase Line"."Description 2";
                end;
                PayTerms := '';
                PaymentTerms.SetRange(Code, PurchaseHeader."Payment Terms Code");
                if PaymentTerms.FindFirst() then begin
                    repeat
                        PayTerms += PaymentTerms.Description;
                    until PaymentTerms.Next() = 0;
                end;

                txtVendorComment := '';
                VendorComment.Reset();
                VendorComment.SetRange("Table Name", VendorComment."Table Name"::Vendor);
                //VendorComment.SetRange(Type, VendorComment.Type::"Term & Condition");
                VendorComment.SetRange("No.", "Buy-from Vendor No.");
                IF VendorComment.FindFirst() then begin
                    repeat
                        txtVendorComment += VendorComment.Comment;
                    until VendorComment.Next() = 0;

                end;

                userId := '';
                PreparedBy := '';
                ApprovalEntry.RESET;
                ApprovalEntry.SETRANGE("Table ID", 38);
                ApprovalEntry.SETRANGE("Document No.", "No.");
                ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                IF ApprovalEntry.FINDLAST THEN
                    userId := ApprovalEntry."Last Modified By User ID";
                PreparedBy := ApprovalEntry."Sender ID";

            end;

        }
        dataitem(PurchaseLine; "Purchase Line")
        {
            DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            DataItemLinkReference = purchaseHeader;
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

            column(Description; Description + ', ' + PurchaseLine."Description 2")
            {
            }
            column(ExttxtDesc; txtDescription)
            {
            }
            column(Line_No_; PurchaseLine."Line No.")
            {
            }
            column(UOM; PurchaseLine."Unit of Measure Code")
            {
            }
            column(HSN_SAC_Code;
            "HSN/SAC Code")
            {
            }
            column(Quantity;
            Quantity)
            {
            }
            column(Direct_Unit_Cost;
            "Direct Unit Cost")
            {
            }
            column(freeQty; freeQty)
            {
            }
            column(Line_Amount; "Line Amount")
            {
            }
            column(Line_Discount__; "Line Discount %")
            {
            }
            column(IGSTRatePercnt_Var;
            IGSTRatePercnt_Var)
            {
            }

            column(CGSTRatePercnt_Var;
            CGSTRatePercnt_Var)
            {
            }
            column(SGSTRatePercnt_Var;
            SGSTRatePercnt_Var)
            {
            }
            column(Line_Discount_Amount;
            "Line Discount Amount")
            {
            }
            column(Inv__Discount_Amount;
            "Inv. Discount Amount" + "Line Discount Amount")
            {
            }
            column(Amount; Amount)
            {
            }
            column(SNo; SNo)
            {
            }
            column(decGSTPer;
            decGSTPer)
            {
            }
            column(ItemCode;
            PurchaseLine."No.")
            {
            }
            column(LineGSTAmount;
            LineGSTAmount)
            {
            }
            column(Warrnty; Warrnty)
            {
            }
            column(Parts; Parts)
            {
            }
            column(AMC_Amount; PurchaseLine."EDC AMC Amount")
            {
            }
            column(CMC_Amount; PurchaseLine."EDC CMC Amount")
            {
            }
            column(YOY_Amount; YOYAmount)
            {
            }
            column(ModelName; Model)
            {
            }
            trigger OnPreDataItem()
            begin
                SNo := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
                decGSTPer := 0;
                LineGSTAmount := 0;
                TaxTransactionValue.Reset();
                TaxTransactionValue.SetFilter("Tax Record ID", '%1', PurchaseLine.RecordId);
                TaxTransactionValue.SetFilter("Value Type", '%1', TaxTransactionValue."Value Type"::Component);
                TaxTransactionValue.SetFilter("Tax Type", '%1', 'GST');
                TaxTransactionValue.SetRange("Visible on Interface", TRUE);
                if TaxTransactionValue.FindSet() then
                    repeat
                        IF TaxTransactionValue.Percent <> 0 then begin
                            decGSTPer += TaxTransactionValue.Percent;
                        end;
                    until TaxTransactionValue.Next() = 0;
                LineGSTAmount := PurchaseLine."Line Amount" * decGSTPer / 100;

                if userc.Get(SystemCreatedBy) then;
                if userm.Get(SystemModifiedBy) then;

                //ak
                RequisitionProcessing.RESET;
                RequisitionProcessing.SETRANGE("Requisition No", "recPurchaseLine"."EDC Indent No.");
                IF RequisitionProcessing.FIND('-') THEN BEGIN
                    IF RequisitionProcessing."First Name/Model" <> '' THEN
                        ModelName := RequisitionProcessing."First Name/Model";


                    IF RequisitionProcessing."Second Name/Model" <> '' THEN
                        ModelName := RequisitionProcessing."Second Name/Model";
                    IF RequisitionProcessing."Third Name/Model" <> '' THEN
                        ModelName := RequisitionProcessing."Third Name/Model";

                    RequisitionLines.RESET;
                    RequisitionLines.SETRANGE("Requisition No", "EDC Indent No.");
                    IF RequisitionLines.FINDFIRST THEN
                        IF RequisitionLines."First Vendor PO Creation" = TRUE THEN BEGIN
                            YOYPer := RequisitionLines."First YOY Percentage";
                            YOYAmount := RequisitionLines."Fir YOY Escalation on AMC/CMC";
                            InstallChrg := RequisitionLines."First Installtion Charges";
                            FreeItemValue := RequisitionLines."First Accessories";
                            GSTonAcc := RequisitionLines."First GST on Accessories";
                            Model := RequisitionLines."First Name/Model";
                            Warrnty := RequisitionLines."First Equipments (in Months)";
                            Parts := RequisitionLines."First Parts/Acce (in months)";
                            PreInstallation := RequisitionLines."First Pre Installation Requir";
                            DeliveryTerms := RequisitionLines."First Delivery Time";
                            FeturedReq := RequisitionLines."Firs Feature Available not pur";
                            TransportationChg := RequisitionLines."First Transportation Charges";
                            AMC := RequisitionLines."First AMC Amount";
                            AMCPer := RequisitionLines."First AMC Percentage";
                            CMC := RequisitionLines."First CMC Amount";
                            CMCPer := RequisitionLines."First CMC Percentage";
                        END ELSE
                            IF RequisitionLines."Second Vendor PO Creation" = TRUE THEN BEGIN
                                YOYPer := RequisitionLines."Second YOY Percentage";
                                YOYAmount := RequisitionLines."Sec YOY Escalation on AMC/CMC";
                                InstallChrg := RequisitionLines."Second Installtion Charges";
                                FreeItemValue := RequisitionLines."Second Accessories";
                                GSTonAcc := RequisitionLines."Second GST on Accessories";
                                Model := RequisitionLines."Second Name/Model";
                                Warrnty := RequisitionLines."Second Equipments (in Months)";
                                PreInstallation := RequisitionLines."Second Pre Installation Requir";
                                DeliveryTerms := RequisitionLines."Second Delivery Terms";
                                FeturedReq := RequisitionLines."Sec Feature Available not pur";
                                TransportationChg := RequisitionLines."Second Transportation Charges";
                                Warrnty := RequisitionLines."Second Equipments (in Months)";
                                Parts := RequisitionLines."Second Parts/Acce (in months)";
                                AMC := RequisitionLines."Second AMC Amount";
                                AMCPer := RequisitionLines."Second AMC Percentage";
                                CMC := RequisitionLines."Second CMC Amount";
                                CMCPer := RequisitionLines."Second CMC Percentage";
                            END ELSE
                                IF RequisitionLines."Third Vendor PO Creation" = TRUE THEN BEGIN
                                    YOYPer := RequisitionLines."Third YOY Percentage";
                                    YOYAmount := RequisitionLines."Thir YOY Escalation on AMC/CMC";
                                    InstallChrg := RequisitionLines."Third Installtion Charges";
                                    FreeItemValue := RequisitionLines."Third Accessories";
                                    GSTonAcc := RequisitionLines."Third GST on Accessories";
                                    Model := RequisitionLines."Third Name/Model";
                                    Warrnty := RequisitionLines."Third Equipments (in Months)";
                                    PreInstallation := RequisitionLines."Third Pre Installation Requir";
                                    DeliveryTerms := RequisitionLines."Third Delivery Time";
                                    FeturedReq := RequisitionLines."Thir Feature Available not pur";
                                    TransportationChg := RequisitionLines."Third Transportation Charges";
                                    Warrnty := RequisitionLines."Third Equipments (in Months)";
                                    Parts := RequisitionLines."Third Parts/Acce (in months)";
                                    AMC := RequisitionLines."Third AMC Amount";
                                    AMCPer := RequisitionLines."Third AMC Percentage";
                                    CMC := RequisitionLines."Third CMC Amount";
                                    CMCPer := RequisitionLines."Third CMC Percentage";

                                END;





                    //ak
                end;
            End;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
        recState.Get(CompInfo."State Code");
        CountryRegion.Get(CompInfo."Country/Region Code");
        CompAdd := CompInfo.Address + ', ' + CompInfo."Address 2" + ', ' + CompInfo.City + ', ' + FORMAT(CompInfo."Post Code") + ', ' + FORMAT(recState.Description) + ', ' + CountryRegion.Name;
        Email := CompInfo."E-Mail";
        PhoneNo := CompInfo."Phone No.";
        GSTIN := CompInfo."GST Registration No.";
        DrugLigNo := CompInfo."Registration No.";
    end;

    var
        CompInfo: Record "Company Information";
        Customer: Record "Vendor";
        CompAdd: Text[500];
        recState: Record State;
        CountryRegion: Record "Country/Region";
        Email: Text[100];
        PhoneNo: Code[50];
        GSTIN: Code[15];
        DrugLigNo: Code[200];
        Location: Record Location;
        LocationName: Text[100];
        LocationEmail: Text[100];
        LocationPhoneNo: Code[50];
        LocationGSTIN: Text[15];
        LocationWebsite: Text[200];
        LocationAdd: Text[200];

        SupplierName: Text[300];
        SupplierAdd: Text[500];
        SupplierEmail: Text[100];
        SupplierPhoneNo: Text[20];
        SupplierGSTIN: Code[20];
        SupplierPANNo: Code[10];
        freeQty: Decimal;
        LineGSTAmount: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        IGSTRatePercnt_Var: Decimal;
        IGSTRsAmount_Var: Decimal;
        SGSTRatePercnt_Var: Decimal;
        SGSTRsAmount_Var: Decimal;
        CGSTRatePercnt_Var: Decimal;
        CGSTRsAmount_Var: Decimal;
        recPurchaseLine: Record "Purchase Line";
        Sno: Integer;
        decAmountoVendor: Decimal;
        CheckReport: Report "Check";
        AmtWords: array[2] of Text[500];
        TotalInclTaxAmount: Decimal;
        decGSTPer: Decimal;
        TotalTDS: Decimal;
        TotalAmttoVendor: Decimal;
        rpt: Report 18008;
        CalcStatistics: Codeunit "Calculate Statistics";
        RecordIDList: List of [RecordID];
        TaxTransactionValue: Record "Tax Transaction Value";
        ComponentJObject: JsonObject;
        ScriptDatatypeMgmt: Codeunit "Script Data Type Mgmt.";
        CdCurrencyCode: Code[20];
        PostedVoucher: Report "Posted Voucher";
        PurchCommentLine: Record "Purch. Comment Line";
        VendorComment: Record "Comment Line";
        txtcommentNote: Text;
        txtcomment: Text;
        txtVendorComment: Text;
        txtPurchaseHeader: Text[150];
        userc: Record User;
        userm: Record User;
        userId: Text;
        PreparedBy: Text;
        ApprovalEntry: Record "Approval Entry";
        ExtendedTextLine: Record "Extended Text Line";
        txtDescription: Text;
        PaymentTerms: Record "Payment Terms";
        PayTerms: Text;
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';
        CGST_Amt: Decimal;
        IGST_Amt: Decimal;
        SGST_Amt: Decimal;
        RequisitionProcessing: Record "EDC Requisition Processing";
        RequisitionHeader: Record "EDC Requisition Header";
        RequisitionLines: Record "EDC Requisition Lines";
        DT: Text;
        YOY: Decimal;
        PT: Text;
        PI: Text;
        AMC: Decimal;
        CMC: Decimal;
        FI: Decimal;
        FN: Text;
        WI: Text;
        WP: Text;
        AMCPer: Decimal;
        CMCPer: Decimal;
        YOYPer: Decimal;
        InstallChrg: Decimal;
        FreeItemValue: Text[100];
        GSTonAcc: Decimal;
        Model: Text[50];
        YOYAmount: Decimal;
        Warrnty: Text[100];
        PreInstallation: Text[100];
        DeliveryTerms: Text[100];
        FeturedReq: Text[100];
        FreightAmt: Decimal;
        InstalationAmt: Decimal;
        GSTOnAcc1: Decimal;
        TransportationChg: Decimal;
        Parts: Text[100];
        ModelName: Text;
        RecCompanyName: Text[100];


    local procedure GetGSTAmounts(PurchHeader: Record "Purchase Header")
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        PurchaseLine: Record "Purchase Line";
        GSTSetup: Record "GST Setup";
        ComponentName: Code[30];
    begin
        GSTSetup.Get();
        Clear(IGST_Amt);
        Clear(SGST_Amt);
        Clear(CGST_Amt);

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        if PurchaseLine.FindSet() then
            repeat
                if (PurchaseLine.Type <> PurchaseLine.Type::" ") then begin
                    ComponentName := GetComponentName(PurchaseLine, GSTSetup);

                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
                    TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                    if TaxTransactionValue.FindSet() then
                        repeat
                            case TaxTransactionValue."Value ID" of
                                6:
                                    SGST_Amt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                2:
                                    CGST_Amt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                3:
                                    IGST_Amt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                            end;
                        until TaxTransactionValue.Next() = 0;
                end;
            until PurchaseLine.Next() = 0;
    end;

    local procedure GetComponentName(PurchaseLine: Record "Purchase Line";
        GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin
        if GSTSetup."GST Tax Type" = GSTLbl then
            if PurchaseLine."GST Jurisdiction Type" = PurchaseLine."GST Jurisdiction Type"::Interstate then
                ComponentName := IGSTLbl
            else
                ComponentName := CGSTLbl
        else
            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                ComponentName := CESSLbl;
        exit(ComponentName)
    end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
    var
        TaxComponent: Record "Tax Component";
        GSTSetup: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup.Get() then
            exit;
        GSTSetup.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;


}
