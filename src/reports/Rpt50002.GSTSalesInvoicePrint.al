report 50002 "GST Sales Invoice Print"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50002.GST Sales Invoice.rdl';
    Permissions = tabledata "Sales Invoice Header" = RM;
    Caption = 'Sales Invocie - GST';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Header"; "Sales Invoice Header")
        {
            column(Adhaar_Ship; adhaarship2)
            {

            }
            column(AdhaarNo_cust; adhaarshipbill)
            {

            }
            column(External_Document_No_; "External Document No.")
            {

            }
            column(Order_Date; "Order Date")
            {

            }
            column(GL_amt; GL_amt)
            {

            }
            column(TCSAmount; TCSAmount)
            {
            }
            column(tcsamount_rec; tcsamount_rec)
            {

            }
            column(Bill_to_City; "Bill-to City")
            {

            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(Bill_to_Post_Code; "Bill-to Post Code")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Ship_to_Post_Code123; "Ship-to Post Code")
            {

            }
            column(TCSPer; TCSPer)
            {
            }
            column(WUOM; WUOM)
            {
            }
            column(LocationGSTNo; LocationGSTNo)
            {

            }
            column(LocAddress; LocAddress) { }
            column(GSTCodeBill; GSTCodeBill)
            {

            }

            column(EncodedText; EncodedText)
            {

            }
            column(GSTCOdeShip; GSTCOdeShip)
            {

            }
            column(ShipStateName; ShipStateName)
            {

            }
            column(BillStateName; BillStateName)
            {

            }
            column(amounttoCustomer; amounttoCustomer)
            {

            }
            column(GST_Bill_to_State_Code; "GST Bill-to State Code")
            {

            }
            column(Bill_to_Contact_No_; "Bill-to Contact No.")
            {

            }
            column(Customer_GST_Reg__No_; GSTNoCust)

            {

            }
            column(State; State)
            {

            }
            column(Ship_to_GST_Reg__No_; ShipGSTNo)
            {

            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {

            }
            column(Ship_to_Code; "Ship-to Code")
            {

            }
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {

            }
            column(GST_Ship_to_State_Code; "GST Ship-to State Code")
            {

            }

            column(CompName; RecCompanyName)//CompInfo.Name)
            {
            }
            column(CompPic; CompInfo.Picture)
            {
            }
            column(CompAdd; CompInfo.Address)
            {
            }
            column(CompInfoGSTRegNo; CompInfo."GST Registration No.")
            {

            }
            column(CompInfoPANNo; CompInfo."P.A.N. No.")
            {

            }
            column(Acknowledgement_Date; "Acknowledgement Date")
            {

            }
            column(Acknowledgement_No_; ackno)
            {

            }
            column(CompCity; CompInfo.City)
            {
            }
            column(CompPostCode; CompInfo."Post Code")
            {
            }
            column(CompGstNo; compInfo."GST Registration No.")
            {
            }
            column(PhoneNo; CompInfo."Phone No.")
            {
            }
            column(QRcode_2; QRcode_2)
            {

            }
            column(FaxNo; CompInfo."Fax No.")
            {
            }
            column(Email; CompInfo."E-Mail")
            {
            }
            column(Web; CompInfo."Home Page")
            {
            }
            column(CompInfSaleEquNo; '')// CompInfo."Sales Enquiry No.")
            {
            }
            column(TinNo; '')// CompInfo."T.I.N. No.")
            {
            }
            column(CstNo; '')// CompInfo."C.S.T No.")
            {
            }
            column(CERange; '')// CompInfo."C.E. Range")
            {
            }
            column(CEDivision; '')// CompInfo."C.E. Division")
            {
            }
            column(ECCNo; '')// CompInfo."E.C.C. No.")
            {
            }
            column(PanNo; '')// CompInfo."P.A.N. No.")
            {
            }
            column(CERegi_No; '')// CompInfo."C.E. Registration No.")
            {
            }
            column(VatNo; CompInfo."VAT Registration No.")
            {
            }
            column(TermsText; '')// LocationRec."Terms 1")
            {
            }
            column(TermsText3; '')// LocationRec."Terms 3")
            {
            }
            column(TermsText4; '')// LocationRec."Terms 4")
            {
            }
            column(DeclarationText; '')// LocationRec."Terms 2")
            {
            }
            column(CompanyFullAdd; CompInfo.Address + ',' + CompInfo."Address 2" + ',' + CompInfo.City + '-' + CompInfo."Post Code" + ' INDIA')
            {
            }
            column(AmounttoCustSH; '')// ROUND("Sales Header"."Amount to Customer", 1, '='))
            {
            }
            column(LRRRNo_SalesHeader; '')// "Sales Header"."LR/RR No.")
            {
            }
            column(LRRRDate_SalesHeader; "Sales Header"."Order Date")
            {
            }
            column(UserName; UserName)
            {
            }
            column(AwardText; AwardText)
            {
            }
            column(CustomerTINSELL; '')// CustomerRec."T.I.N. No.")
            {
            }
            column(CustomerGSTNoSELL; '')// CustomerRec."GST Registration No.")
            {
            }
            column(Phone_NoSELL; CustomerRec."Phone No.")
            {
            }
            column(CustomerSateSELL; '')// CustomerRec."State Code")
            {
            }
            column(CustomerGSTNoBillTo; "Customer GST Reg. No.")// CustomerRecBillTo."GST Registration No.")
            {
            }
            column(Phone_NoBillTo; CustomerRecBillTo."Phone No.")
            {
            }
            column(CustomerSateBillTo; "GST Bill-to State Code")
            {
            }
            column(StateGSTNoCodeSELL; '')// StateRec."State Code (GST Reg. No.)" + ',Pin Code -' + CustomerRec."Post Code")
            {
            }
            column(StateGSTNoCodeBILLTo2; '')// StateRecBillTo."State Code (GST Reg. No.)" + ',Pin Code -' + CustomerRecBillTo."Post Code")
            {
            }
            column(StateGSTNoCodeBillTo; '')// StateRecBillTo.Description)
            {
            }
            column(StateNAmeSELL; '')// StateRec.Description)
            {
            }
            column(StateNAmeBillTo; '')// StateRecBillTo.Description)
            {
            }
            column(No_Header; "Sales Header"."No.")
            {
            }
            column(SELLtoCustomerNo; "Sales Header"."Sell-to Customer No.")
            {
            }
            column(SELLtoName; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(SELLtoAddress; "Sales Header"."Sell-to Address")
            {
            }
            column(SELLltoAddress2; "Sales Header"."Sell-to Address 2")
            {
            }
            column(SELLtoCity; "Sales Header"."Sell-to City")
            {
            }
            column(SELLtoContact; "Sales Header"."Sell-to Contact")
            {
            }
            column(SELLtoContactNo; "Sales Header"."Sell-to Contact No.")
            {
            }
            column(BilltoPostCode_SalesHeader; "Sales Header"."Bill-to Post Code")
            {
            }
            column(BilltoCustomerState_SalesHeader; "GST Bill-to State Code")// "Sales Header"."Bill to Customer State")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesHeader; "Sales Header"."Bill-to Name")
            {
            }
            column(BilltoName2_SalesHeader; "Sales Header"."Bill-to Name 2")
            {
            }
            column(BilltoAddress_SalesHeader; "Sales Header"."Bill-to Address")
            {
            }
            column(BilltoAddress2_SalesHeader; "Sales Header"."Bill-to Address 2")
            {
            }
            column(BilltoCity_SalesHeader; "Sales Header"."Bill-to City")
            {
            }
            column(BilltoContact_SalesHeader; "Sales Header"."Bill-to Contact")
            {
            }
            column(PostingDate; "Sales Header"."Document Date")
            {
            }
            column(SalespersonCode; "Sales Header"."Salesperson Code")
            {
            }
            column(ROUNDValue; ROUNDValue)
            {
            }
            column(SalesPerson_Name; SalesPersonRec.Name)
            {
            }
            column(Numbertext; Numbertext[1])
            {
            }
            column(VehicleNo_SalesHeader; "Sales Header"."Vehicle No.")
            {
            }
            column(RouteDescription; '')//"Sales Header"."Route Description")
            {
            }
            column(TimeofRemoval_SalesHeader; '')// "Sales Header"."Time of Removal")
            {
            }
            column(Bank_Name; CompInfo."Bank Name")
            {
            }
            column(YourReference_SalesHeader; "Sales Header"."Your Reference")
            {
            }
            column(BankAcNo; compInfo."Bank Account No.")
            {
            }
            column(BankAccountAddress; BankAccount.Address)
            {
            }
            column(BankAccountSWIFTCode; CompInfo."SWIFT Code")// BankAccount."Branch Name")
            {
            }
            column(BankBranchNo; CompInfo."Bank Branch No.")//BankAccount."IFSC Code")
            {
            }
            column(SaleComment; SaleComment)
            {
            }
            column(E_Way_Bill_No_; "E-Way Bill No.")
            {
            }
            column(EwayBillDate_SalesHeader; '')
            {
            }
            column(E_Inv__Cancelled_Date; "E-Inv. Cancelled Date")
            {

            }
            column(BankAccno; compinfo."Bank Account No.")
            {

            }
            column(bankname; compinfo."Bank Name")
            {

            }
            column(ifsccode; compinfo."Payment Routing No.")
            {

            }

            column(branchname; '')
            {

            }

            column(CompInfo; CompInfo."CIN No.")
            {

            }
            column(GSTRegistrationNo_SalesHeader; "Sales Header"."Customer GST Reg. No.")
            {
            }

            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(NoOfCopies; CopyText)
                {
                }
                dataitem(PageLoop; Integer)
                {

                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(VarSalesInvPrintNo; VarSalesInvPrintNo)
                    {
                    }
                    column(Number; Number)
                    {

                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("nO.");
                        DataItemLinkReference = "Sales Header";

                        column(Line_Discount_Amount; "Line Discount Amount")
                        {

                        }

                        column(HSNCode__rec; "Sales Invoice Line"."HSN/SAC Code")
                        {
                        }
                        column(Item_no; "Sales Invoice Line"."No.")
                        {
                        }
                        column(Description; "Sales Invoice Line".Description)
                        {
                        }
                        column(UnitofMeasure; "sales Invoice line"."Unit of Measure")
                        {
                        }
                        column(LineDiscountAmount_SalesLine; (ABS("sales Invoice line"."Line Discount Amount") + ABS("sales Invoice line"."Inv. Discount Amount")))
                        {
                        }
                        column(LineAmount_SalesLine; "sales Invoice line"."Line Amount")
                        {

                        }
                        column(UnitPrice; "Sales Invoice Line"."Unit Price")
                        {

                        }
                        column(Quantity; "Sales Invoice Line".Quantity)
                        {

                        }
                        column(decAmount; "Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price")
                        {

                        }
                        column(P_LineCount; P_LineCount)
                        {

                        }
                        column(SRNo; SRNo)
                        {
                        }
                        column(amountinwords; amountinwords)
                        {

                        }
                        column(taxableAmt; taxableAmt)
                        {

                        }
                        column(TAx_Value; TAx_Value)
                        {

                        }
                        column(Line_Discount_final; round("Line Discount %", 0.01, '='))
                        {

                        }
                        column(IGSTRate; IGSTRate)
                        {

                        }
                        column(CGSTRate; CGSTRate)
                        {

                        }
                        column(SGSTRate; SGSTRate)
                        {

                        }
                        column(IGSTAmt; IGSTAmt)
                        {

                        }
                        column(SGSTAmt; SGSTAmt)
                        {

                        }
                        column(CGSTAmt; CGSTAmt)
                        {

                        }
                        column(BankAccName; BankName) { }
                        column(BankAccountNo; BankAccountNo) { }
                        column(BankIFSCCode; IFSCCode) { }
                        column(Branch; Branch) { }
                        trigger OnAfterGetRecord()
                        begin

                            Clear(glaccno);
                            Cust_rec.Reset();
                            Cust_rec.SetRange("No.", "Sales Invoice Line"."Bill-to Customer No.");
                            if Cust_rec.FindFirst() then begin
                                CustPostRec.Reset();
                                CustPostRec.SetRange(Code, Cust_rec."Customer Posting Group");
                                if CustPostRec.FindFirst() then
                                    glaccno := CustPostRec."Invoice Rounding Account";
                            end;

                            if ("Sales Invoice Line"."No." = glaccno) then
                                CurrReport.Skip();

                            HSNCode := '';
                            IF ItemRec.GET("Sales invoice Line"."No.") THEN
                                HSNCode := ItemRec."HSN/SAC Code";
                            TotalLineAmt := 0;
                            //ak
                            Salesheadrec.Reset();
                            Salesheadrec.SetRange("No.", "Sales Invoice Line"."Document No.");
                            if Salesheadrec.FindFirst() then begin
                                if LocationRec.Get(Salesheadrec."Location Code") then begin
                                    if LocationRec."Invoice Bank" <> '' then begin

                                        if BankAccRec.Get(LocationRec."Invoice Bank") then begin
                                            // Example fields – use as per your requirement
                                            BankName := BankAccRec.Name;
                                            BankAccountNo := BankAccRec."Bank Account No.";
                                            IFSCCode := BankAccRec."IFSC Code";
                                            Branch := BankAccRec.City;
                                        end;
                                    end;
                                    //end;


                                    SRNo += 1;

                                    DTGSTEntry.RESET;
                                    DTGSTEntry.SetRange(DTGSTEntry."Entry Type", DTGSTEntry."Entry Type"::"Initial Entry");
                                    DTGSTEntry.SetRange(DTGSTEntry."Document Type", DTGSTEntry."Document Type"::Invoice);
                                    DTGSTEntry.SetRange(DTGSTEntry."Transaction Type", DTGSTEntry."Transaction Type"::Sales);
                                    DTGSTEntry.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                                    DTGSTEntry.SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
                                    IF DTGSTEntry.FINDSET THEN
                                        REPEAT
                                            IF DTGSTEntry."GST Component Code" = 'IGST' THEN BEGIN
                                                IGSTRate := ABS(DTGSTEntry."GST %");
                                                IGSTAmt := ABS(DTGSTEntry."GST Amount");
                                            END;
                                            IF (DTGSTEntry."GST Component Code" = 'SGST') OR (DTGSTEntry."GST Component Code" = 'UTGST') THEN BEGIN
                                                SGSTRate := ABS(DTGSTEntry."GST %");
                                                SGSTAmt := ABS(DTGSTEntry."GST Amount");
                                            END;

                                            IF DTGSTEntry."GST Component Code" = 'CGST' THEN BEGIN
                                                CGSTRate := ABS(DTGSTEntry."GST %");
                                                CGSTAmt := ABS(DTGSTEntry."GST Amount");
                                            END;
                                        UNTIL DTGSTEntry.NEXT = 0;

                                    P_LineCount += 1;
                                end;
                            end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SRNo := 0;

                            P_LineCount := 0;
                        end;

                    }
                    dataitem(Integer_rec; Integer)
                    {

                        column(aa; 'aa')
                        {
                        }
                        trigger OnPreDataItem()
                        begin
                            SalesLineREC.RESET;
                            SalesLineREC.COPYFILTERS("Sales invoice Line");
                            SalesLineREC.SETRANGE(SalesLineREC.Type, SalesLineREC.Type::Item);
                            MaxNo := 28;
                            IF ((SalesLineREC.COUNT) > 29) AND ((SalesLineREC.COUNT) < 58) THEN
                                MaxNo := 58;


                            PrintNo := SalesLineREC.COUNT;
                            NeedNo := MaxNo - PrintNo;
                            SETRANGE(Number, 1, NeedNo);


                        end;

                        trigger OnAfterGetRecord()
                        var
                            myInt: Integer;
                        begin

                        end;
                    }


                    trigger OnAfterGetRecord()
                    begin

                        VarSalesInvPrintNo := FORMAT(PageLoop.Number);

                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        OutputNo += 1;
                    END;

                    IF OutputNo = 1 THEN
                        CopyText := 'Original'
                    ELSE
                        IF OutputNo = 2 THEN
                            CopyText := 'Office Copy'
                        ELSE
                            IF OutputNo = 3 THEN
                                CopyText := 'Transport Copy'
                            ELSE
                                IF OutputNo = 4 THEN
                                    CopyText := 'Duplicate 2';

                end;

                trigger OnPreDataItem()
                begin

                    NoOfLoops := ABS(NoOfcopies);
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                SIL: Record "SALES INVOICE LINE";
                SalesCommentLine: Record "Sales Comment Line";
            begin
                SaleComment := '';
                SalesCommentLine.SetRange("Document Type", SalesCommentLine."Document Type"::"Posted Invoice");
                SalesCommentLine.SetRange("No.", "Sales Header"."No.");
                if SalesCommentLine.FindSet() then
                    repeat
                        if SaleComment = '' then
                            SaleComment := SalesCommentLine.Comment
                        else
                            SaleComment := SaleComment + ' ' + SalesCommentLine.Comment;
                    until SalesCommentLine.Next() = 0;

                DTGSTEntry.RESET;
                DTGSTEntry.SetRange(DTGSTEntry."Entry Type", DTGSTEntry."Entry Type"::"Initial Entry");
                DTGSTEntry.SetRange(DTGSTEntry."Document Type", DTGSTEntry."Document Type"::Invoice);
                DTGSTEntry.SetRange(DTGSTEntry."Transaction Type", DTGSTEntry."Transaction Type"::Sales);
                DTGSTEntry.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                DTGSTEntry.SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
                IF DTGSTEntry.FINDSET THEN
                    REPEAT
                        IF DTGSTEntry."GST Component Code" = 'IGST' THEN BEGIN
                            IGSTRate := ABS(DTGSTEntry."GST %");
                            IGSTAmt := ABS(DTGSTEntry."GST Amount");
                        END;
                        IF (DTGSTEntry."GST Component Code" = 'SGST') OR (DTGSTEntry."GST Component Code" = 'UTGST') THEN BEGIN
                            SGSTRate := ABS(DTGSTEntry."GST %");
                            SGSTAmt := ABS(DTGSTEntry."GST Amount");
                        END;

                        IF DTGSTEntry."GST Component Code" = 'CGST' THEN BEGIN
                            CGSTRate := ABS(DTGSTEntry."GST %");
                            CGSTAmt := ABS(DTGSTEntry."GST Amount");
                        END;
                    UNTIL DTGSTEntry.NEXT = 0;

                Clear(tcsamount_rec);
                tCSEntry_rec.Reset();
                tCSEntry_rec.SetRange("Document No.", "Sales Header"."No.");
                tCSEntry_rec.SetRange("Document Type", tCSEntry_rec."Document Type"::Invoice);
                if tCSEntry_rec.FindFirst() then begin
                    repeat
                        tcsamount_rec += tCSEntry_rec."TCS Amount";
                    until tCSEntry_rec.Next() = 0;
                end;

                IF CustomerRecBillTo.GET("Sales Header"."Bill-to Customer No.") THEN;


                SalesOtherState := FALSE;
                "PONo." := '';
                PODate := '';
                LocationRec.Reset();
                if LocationRec.GET("Sales Header"."Location Code") then
                    LocationGSTNo := LocationRec."GST Registration No.";
                LocAddress := LocationRec.Address + ',' + LocationRec."Address 2" + ',' + LocationRec.City + ',' + LocationRec."Post Code";
                Clear(ShipStateName);
                Clear(BillStateName);
                Clear(GSTCodeBill);
                Clear(GSTCOdeShip);
                State_rec.Reset();
                if State_rec.Get("Sales Header"."GST Ship-to State Code") then
                    ShipStateName := State_rec.Description;
                GSTCOdeShip := State_rec."State Code (GST Reg. No.)";
                if State_rec.Get("Sales Header"."GST Bill-to State Code") then
                    BillStateName := State_rec.Description;
                GSTCodeBill := State_rec."State Code (GST Reg. No.)";


                amounttoCustomer := 0;
                CalculateStructure.GetPostedSalesInvStatisticsAmount("Sales Header", amounttoCustomer);



                Clear(AdhaarNo_cust);

                Clear(glaccno);
                Cust_rec.Reset();
                Cust_rec.SetRange("No.", "Sales Header"."Bill-to Customer No.");
                if Cust_rec.FindFirst() then begin
                    CustPostRec.Reset();
                    CustPostRec.SetRange(Code, Cust_rec."Customer Posting Group");
                    if CustPostRec.FindFirst() then
                        glaccno := CustPostRec."Invoice Rounding Account";
                end;

                Clear(GL_amt);
                SIL_GlRec.Reset();
                SIL_GlRec.SetRange("Document No.", "Sales Header"."No.");
                SIL_GlRec.SetRange(Type, SIL_GlRec.Type::"G/L Account");
                SIL_GlRec.SetRange("No.", glaccno);
                if SIL_GlRec.FindFirst() then begin
                    GL_amt := SIL_GlRec.Amount;
                end;

                GSTNoCust := '';
                if "Sales Header"."Customer GST Reg. No." <> '' then
                    GSTNoCust := Format('GSTIN No :' + "Sales Header"."Customer GST Reg. No.") else
                    GSTNoCust := '';
                ShipGSTNo := '';
                if "Sales Header"."Ship-to GST Reg. No." <> '' then
                    ShipGSTNo := Format('GSTIN No : ' + "Sales Header"."Ship-to GST Reg. No.")
                else
                    ShipGSTNo := '';

                Adhaar_Ship := '';
                customer_rec_bill.Reset();
                if customer_rec_bill.get("Sales Header"."Ship-to Code") then begin
                end;
                if Adhaar_Ship <> '' then
                    adhaarship2 := 'Adahaar No.' + Adhaar_Ship
                else
                    adhaarship2 := '';
                if AdhaarNo_cust <> '' then
                    adhaarshipbill := 'Adahaar No.' + AdhaarNo_cust
                else
                    adhaarshipbill := '';
                ackno := '';
                if "Acknowledgement No." <> '' then
                    ackno := Format("Acknowledgement No." + '/') else
                    ackno := '';
                if ("Sales Header"."Posting Date" < CompInfo."Transaction Date") then
                    RecCompanyName := compinfo."Old Comapany Name"
                else
                    RecCompanyName := CompInfo.Name;


            end;


            trigger OnPreDataItem()
            begin


                IF (FromDoc <> '') AND (ToDoc <> '') THEN
                    "Sales Header".SETFILTER("Sales Header"."No.", '>=%1&<=%2', FromDoc, ToDoc);


            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                Clear(Qrinstream);
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
                group("No of Pages")
                {
                    Caption = 'No of Pages';
                }
                field("No Of Copies"; NoOfcopies)
                {
                    ApplicationArea = all;
                }
                group("Document Filter")
                {
                    Caption = 'Document Filter';
                    field("Copy Type Wise Printing"; CopyTypeWisePrinting)
                    {
                        Visible = false;
                        ApplicationArea = all;
                    }
                    field("Sales Type"; Salestype)
                    {
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                        Visible = false;
                        ApplicationArea = all;
                    }
                    field("From Doc"; FromDoc)
                    {
                        ApplicationArea = all;
                        trigger OnValidate()
                        begin
                            ToDoc := FromDoc;
                        end;
                    }
                    field("To Doc"; ToDoc)
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        NoOfcopies := 1;

        CopyTypeWisePrinting := FALSE;
    end;

    trigger OnPreReport()
    begin
        CompInfo.RESET;
        CompInfo.GET;
        CompInfo.CALCFIELDS(CompInfo.Picture);

        IF fromFunction THEN
            NoOfcopies := 1;
    end;

    var
        CompInfo: Record "cOMPANY INFORMATION";
        NoOfLoops: Integer;
        NoOfcopies: Integer;
        OutputNo: Integer;
        CopyText: Text;
        SRNo: Integer;
        Numbertext: array[100] of Text;
        MaxNo: Integer;
        EmailPage: page "Posted Sales Invoice";
        PrintNo: Integer;
        NeedNo: Integer;
        adhaarship2: Text;
        DetailGstLedger: Record "Detailed GST Ledger Entry";
        GSTEINV: Decimal;
        adhaarshipbill: Text;
        GSTNoCust: Text;
        ShipGSTNo: Text;
        Stream_qr: InStream;
        AwardText: Label 'NATIONAL AWARD WINNER FROM GOVT. OF INDIA';
        DeclarationText: Label 'We certify that food/foods is/are warranted by the manufacturer to the nature substance and quality which it/these purport/purports to be.';
        TermsText: Label 'In case of any dispute the matter shall be refer to the Arbitator. Subject To Ludhiana Jurdiction.';
        CustomerRec: Record "cUSTOMER";
        kyutangkrrhahai: Integer;
        SalesPersonRec: Record "Salesperson/Purchaser";
        SalesPost: Codeunit "Sales-Post";
        ROUNDValue: Decimal;
        GLEntry: Record "G/L Entry";
        Base64: Codeunit "Base64 Convert";
        LocationRec: Record "LOCATION";
        ReplaceValue: Decimal;
        SurChargeAmt: Decimal;
        SalesQty: Decimal;
        ModValue: Integer;
        SalesLineREC: Record "sALES INVOICE LINE";
        TaxAmount: Decimal;
        User: Record User;
        EncodedText: Text;
        UserName: Text;
        FromDoc: Text;
        ToDoc: Text;
        QRcode_2: Text;
        VarDetailGstLegEntry: Record "Detailed GST Ledger Entry";
        SaleComment: Text;
        Salestype: Text;
        CopyTypeWisePrinting: Boolean;
        VarSalesInvPrintNo: Text;
        "PONo.": Text;
        PODate: Text;
        CustomerRecBillTo: Record "cUSTOMER";
        ItemRec: Record "iTEM";
        HSNCode: Text;
        CGSTRate: Decimal;
        CGSTAmt: Decimal;
        SGSTRate: Decimal;
        SGSTAmt: Decimal;
        IGSTRate: Decimal;
        IGSTAmt: Decimal;
        SalesOtherState: Boolean;
        reportr2: Report 116;
        VarDetailGstLegEntry1: Record "Detailed GST Ledger Entry";
        CGSTName: Text;
        SGSTName: Text;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        BankAccount: Record "Bank Account";
        TaxBaseAmount: Decimal;
        TotalLineDisc: Decimal;
        TotalLineAmt: Decimal;
        CGST0: Decimal;
        CGST25: Decimal;
        CGST6: Decimal;
        CGST9: Decimal;
        streamout1: OutStream;
        CGST14: Decimal;
        SGST0: Decimal;
        SGST25: Decimal;
        SGST6: Decimal;
        SGST9: Decimal;
        Salesheadrec: Record "Sales Invoice Header";
        SGST14: Decimal;
        IGST0: Decimal;
        IGST5: Decimal;
        IGST12: Decimal;
        IGST18: Decimal;
        IGST28: Decimal;
        fromFunction: Boolean;

        IGST_recrate: Decimal;
        Qrinstream: InStream;
        qrboolean: Boolean;
        IGST_amt: Decimal;
        // SMTPMailSetup: Record "SMTP Mail Setup";
        SalesInvoiceHeaderEway: Record "Sales Invoice Header";
        WUOM: Text;
        LocationGSTNo: Code[20];
        LocAddress: Text[250];
        TCSAmount: Decimal;
        // TCSEntry: Record "tcs entry";
        TCSPer: Decimal;
        //        EInvoiceHeader: Record "50050";
        SalesInvoiceLine: Record "Sales Invoice Line";
        GST_Zero: Decimal;

        Netrate: Decimal;

        schemedisc: Decimal;

        TempBlob: Codeunit "Temp Blob";

        QRcode_text: Text;

        totalamt: Decimal;

        Outputstream: OutStream;

        SIL_GlRec: Record "Sales Invoice Line";
        GL_amt: Decimal;
        pagegl: page 20;

        repcheck: Report 1401;

        NoText: array[100] of Text;

        amountinwords: Text;

        netamt: Decimal;


        saleinvline: Record "Sales Invoice Line";
        GSTCodeBill: Code[30];
        GSTCOdeShip: Code[30];

        report_PO: Report 18008;

        taxableAmt: Decimal;

        TotalGST: Decimal;
        TotalIGST: Decimal;

        DTGSTEntry: Record "Detailed GST Ledger Entry";

        TAx_Value: Decimal;
        ShipStateName: Text[50];
        BillStateName: Text[50];
        P_LineCount: Integer;

        State_rec: Record State;
        QRCode_text12: Text;

        Blank: Integer;

        predisc: Decimal;

        Generalled_rec: Record "General Ledger Setup";
        schdisc: Decimal;
        repldisc: Decimal;
        taxamt_final: Decimal;

        tCSEntry_rec: Record "TCS Entry";
        tcsamount_rec: Decimal;

        CustPostRec: Record "Customer Posting Group";
        CalculateStructure: Codeunit "Calculate Statistics";
        Cust_rec: Record Customer;
        glaccno: Code[30];
        Customer_Rec_12: Record Customer;
        AdhaarNo_cust: Text;
        customer_rec_bill: Record Customer;
        Adhaar_Ship: Text;
        ackno: Code[50];
        amounttoCustomer: Decimal;
        decAmount: Decimal;
        RecCompanyName: Code[100];
        BankAccRec: Record "Bank Account";
        BankName: Text[100];
        BankAccountNo: Code[50];
        IFSCCode: Code[20];
        Branch: Text[50];


    procedure SetType(LocalSalesType: Text)
    begin
        Salestype := LocalSalesType;
    end;

    procedure SETDATA(DocNoPara: Text; SalesTypePara: Text)
    begin
        FromDoc := DELSTR(DocNoPara, 1, 6);
        ToDoc := DELSTR(DocNoPara, 1, 6);
        Salestype := SalesTypePara;
        fromFunction := TRUE;
    end;







}