report 50028 "GRN Report Print"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50028.GRNReportPrint.rdlc';
    Caption = 'Format - GRN';

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("No." = FILTER(<> ''));
            RequestFilterFields = "No.";
            column(CompanyLogo; CompanyInformation.Picture)
            {
            }
            column(CompName; RecCompanyName)//CompName)
            {
            }
            column(COMPANNo; COMPANNo)
            {
            }
            column(CompanyGSTIN; CompanyInformation."GST Registration No.")
            {
            }
            column(ComanyFAX; CompanyInformation."Fax No.")
            {
            }
            column(TelNo; CompanyInformation."Phone No.")
            {
            }
            column(LocationName; LocationName)
            {
            }
            column(LocationAdd; LocationAdd)
            {
            }
            column(LocationGSTIN; LocationGSTIN)
            {
            }
            column(Dept; txtdescruption)
            {
            }
            column(Locationcode; "Purch. Rcpt. Header"."Location Code")
            {
            }
            column(GRNNo; "Purch. Rcpt. Header"."No.")
            {
            }
            column(VenPhone; "Purch. Rcpt. Header"."Pay-to Contact no.")
            {
            }
            column(DelTerms; "Purch. Rcpt. Header"."E3 Delivery Terms")
            {
            }
            column(VedrEmail; Vendor."E-Mail")
            {
            }
            column(VendorPANNo; VendorPANNo)
            {
            }
            column(City; City)
            {
            }
            column(PostCode; PostCode)
            {
            }
            column(GSRDate; "Purch. Rcpt. Header"."Posting Date")
            {
            }
            column(PONo; "Purch. Rcpt. Header"."Order No.")
            {
            }
            column(PODate; "Purch. Rcpt. Header"."Order Date")
            {
            }
            column(CapexType; "Purch. Rcpt. Header"."E3 Capex Type")
            {
            }
            column(Createdby; userc."User Name")
            {
            }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ItemNo; "Purch. Rcpt. Line"."No.")
                {
                }
                column(ItemName; "Purch. Rcpt. Line".Description)
                {
                }
                column(HSNCode; "Purch. Rcpt. Line"."HSN/SAC Code")
                {
                }
                column(UOM; "Purch. Rcpt. Line"."Unit of Measure")
                {
                }
                column(ReceiptQTY; "Purch. Rcpt. Line".Quantity)
                {
                }
                column(QTYInvoiced; "Purch. Rcpt. Line"."Quantity Invoiced")
                {
                }
                column(VendorCode; VendorCode)
                {
                }
                column(VendorName; VendorName)
                {
                }
                column(VendorGSTIN; VendorGSTIN)
                {
                }
                column(VendorAddress; VendorAddress)
                {
                }
                column(Unitcost; "Purch. Rcpt. Line"."Unit Cost")
                {
                }
                column(Gstgrupcode; "Purch. Rcpt. Line"."GST Group Code")
                {
                }
                column(GstbaseAmt; "Purch. Rcpt. Line"."VAT Base Amount")
                {
                }
                column(LineGST; LineGST)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    LineGST := 0;
                    GSTPer := 0;
                    GSTGroupCode := '';
                    EvlDecimal := 0;

                    if ("Purch. Rcpt. Header"."Currency Code" = 'INR') or ("Purch. Rcpt. Header"."Currency Code" = '') then begin
                        GSTGroupCode := "Purch. Rcpt. Line"."GST Group Code";
                        if (StrLen(GSTGroupCode) < 3) then
                            GSTGroupCode := GSTGroupCode
                        else
                            GSTGroupCode := CopyStr(GSTGroupCode, 1, 2);

                        if (GSTGroupCode <> '') then
                            Evaluate(EvlDecimal, GSTGroupCode);

                        GSTPer := EvlDecimal;
                        LineGST := ("Purch. Rcpt. Line"."Unit Cost" * "Purch. Rcpt. Line".Quantity * GSTPer) / 100;
                    end else begin
                        LineGST := 0;
                        GSTPer := 0;
                    end;
                end;

            }

            trigger OnAfterGetRecord()
            begin
                Vendor.RESET;
                Vendor.SETRANGE("No.", "Buy-from Vendor No.");
                IF Vendor.FINDFIRST THEN BEGIN
                    VendorCode := Vendor."No.";
                    VendorName := Vendor.Name;
                    VendorGSTIN := Vendor."GST Registration No.";
                    VendorPANNo := Vendor."P.A.N. No.";
                    VendorEmail := Vendor."E-Mail";
                    VendorAddress := Vendor.Address + ' ' + Vendor."Address 2";
                    City := Vendor.City;
                    PostCode := Vendor."Post Code";

                    if userc.Get(SystemCreatedBy) then;
                    if userm.Get(SystemModifiedBy) then;

                    if (PurchaseHeader."Posting Date" < CompanyInformation."Transaction Date") then
                        RecCompanyName := CompanyInformation."Old Comapany Name"
                    else
                        RecCompanyName := CompanyInformation.Name;
                END;

                // sandeep

                txtdescruption := '';
                DimensionValue.RESET;
                DimensionValue.SETRANGE("Dimension Code", '%1', 'DEPT');
                DimensionValue.SETRANGE(Code, "Shortcut Dimension 2 Code");
                IF DimensionValue.FINDFIRST THEN BEGIN
                    txtdescruption := DimensionValue.Name;
                END;

                LocationAdd := '';
                LocationEmail := '';
                LocationPhoneNo := '';
                LocationGSTIN := '';
                LocationName := '';
                IF "Purch. Rcpt. Header"."Location Code" <> '' THEN BEGIN
                    Location.RESET;
                    Location.SETRANGE(Code, "Purch. Rcpt. Header"."Location Code");
                    IF Location.FINDFIRST THEN BEGIN
                        LocationName := Location.Name;
                        LocationAdd := Location.Address + ', ' + Location."Address 2" + ', ' + Location.City + ', ' + FORMAT(Location."Post Code");
                        LocationEmail := Location."E-Mail";
                        LocationPhoneNo := Location."Phone No.";
                        LocationGSTIN := Location."GST Registration No.";
                        //LocationWebsite := Location."Home Page";
                    END;
                end;

            end;

        }

    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.RESET;
        CompanyInformation.GET();
        CompanyInformation.CALCFIELDS(Picture);
        CompName := CompanyInformation.Name;
        COMPANNo := CompanyInformation."P.A.N. No.";
    end;

    var
        CompanyInformation: Record 79;
        CompName: Text;
        Vendor: Record 23;
        VendorCode: Code[20];
        VendorName: Text;
        COMPANNo: Code[10];
        VendorPANNo: Code[10];
        VendorGSTIN: Code[15];
        VendorAddress: Text;
        City: Text[50];
        PostCode: Code[10];
        LineGST: Decimal;
        GSTGroupCode: Code[20];
        EvlDecimal: Decimal;
        GSTPer: Decimal;
        VendorEmail: Text;
        PurchaseHeader: Record 38;
        AmttoVendr: Decimal;
        DimensionValue: Record 349;
        txtdescruption: Text;
        userc: Record User;
        userm: Record User;
        Location: Record Location;
        LocationName: Text[100];
        LocationEmail: Code[100];
        LocationPhoneNo: Code[50];
        LocationGSTIN: Code[15];
        LocationWebsite: Text[200];
        LocationAdd: Code[200];
        RecCompanyName: Code[100];

}

