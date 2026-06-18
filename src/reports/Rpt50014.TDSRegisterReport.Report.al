report 50014 "TDS Register Report"
{
    Caption = 'TDS Register';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50014.TDSRegisterReport.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("TDS Entry"; "TDS Entry")
        {
            DataItemTableView = SORTING("Section", "Assessee Code") ORDER(Ascending);
            RequestFilterFields = "Document No.", "Posting Date";
            column(TDS_Report_; 'TDS REGISTER')
            {
            }
            column(FORMAT_dtStart_0_4____________FORMAT_dtEnd_0_4_; Format(dtStart, 0, 4) + ' - ' + Format(dtEnd, 0, 4))
            {
            }
            column(Amount_in_____recGlSetup__LCY_Code_; 'Amount in ' + recGlSetup."LCY Code")
            {
            }
            column(recCompInfo_Picture; recCompInfo.Picture)
            {
            }
            column(recCompInfo_Name; recCompInfo.Name)
            {
            }
            column(recCompInfo_Address______recCompInfo__Address_2_; recCompInfo.Address + ', ' + recCompInfo."Address 2")
            {
            }
            column(recCompInfo_City_____recCompInfo__Post_Code_; recCompInfo.City + '-' + recCompInfo."Post Code")
            {
            }
            column(txtState; txtState)
            {
            }
            column(Phone_No__________recCompInfo__Phone_No__; 'Phone No. :-' + ' ' + recCompInfo."Phone No.")
            {
            }
            column(ComInfoCINNo; recCompInfo."CIN No.")
            {
            }
            column(ComInfoTanNo; recCompInfo."T.A.N. No.")
            {
            }
            column(ComInfoPANNo; recCompInfo."P.A.N. No.")
            {
            }
            column(ComInfoGSTNo; recCompInfo."GST Registration No.")
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(Report_ID_50026_; 'Report ID-50026')
            {
            }
            column(Details_Starts_for____FORMAT__TDS_Entry___TDS_Section__; 'Details Starts for ' + Format("TDS Entry".Section))
            {
            }
            column(txtAssessee_Code_; txtAssessee)
            {
            }
            column(Assessee_Code__; 'Assessee Code:')
            {
            }
            column(intSrno; intSrno)
            {
            }
            column(txtnatureOfDeduction; txtnatureOfDeduction)
            {
            }
            column(txtPartyName; txtPartyName)
            {
            }
            column(txtPartyAddress; txtPartyAddress)
            {
            }
            column(cdPAN; cdPAN)
            {
            }
            column(TDS_Entry__TDS_Entry___TDS_Base_Amount_; "TDS Entry"."TDS Base Amount")
            {
            }
            column(TDS_Entry__TDS_Entry___TDS_Amount_; "TDS Entry"."TDS Amount")
            {
            }
            column(TDS_Entry__TDS_Entry___Surcharge_Amount_; "TDS Entry"."Surcharge Amount")
            {
            }
            column(TDS_Entry__TDS_Entry___eCESS_Amount_; "TDS Entry"."eCESS Amount")
            {
            }
            column(TDS_DocumentType; "TDS Entry"."Document Type")
            {
            }
            column(TDS_Entry__TDS_Entry___SHE_Cess_Amount_; "TDS Entry"."SHE Cess Amount")
            {
            }
            column(decTot; decTot)
            {
            }
            column(TDS_Entry__TDS_Entry___Document_No__; "TDS Entry"."Document No.")
            {
            }
            column(TDS_Entry__TDS_Entry___Posting_Date_; "TDS Entry"."Posting Date")
            {
            }
            column(TDS_Per_; "TDS Entry"."TDS %")
            {
            }
            column(decGTot1; decGTot1)
            {
            }
            column(decGtot2; decGtot2)
            {
            }
            column(decGTot3; decGTot3)
            {
            }
            column(decGTot4; decGTot4)
            {
            }
            column(decGTot5; decGTot5)
            {
            }
            column(Total_For______txtAssessee_Code_; 'Total For ' + txtAssessee)
            {
            }
            column(decGtot16; decGtot16)
            {
            }
            column(decGtot6; decGtot6)
            {
            }
            column(decGTot7; decGTot7)
            {
            }
            column(decGTot8; decGTot8)
            {
            }
            column(decGTot9; decGTot9)
            {
            }
            column(decGTot10; decGTot10)
            {
            }
            column(Details_Total_For____FORMAT__TDS_Entry___TDS_Section__; 'Details Total For ' + Format("TDS Entry".Section))
            {
            }
            column(decGTot17; decGTot17)
            {
            }
            column(Page_No______FORMAT_CurrReport_PAGENO_______Continued_______; 'Page No. ' + Format(CurrReport.PageNo) + '   Continued . . .')
            {
            }
            column(decGTot11; decGTot11)
            {
            }
            column(decGtot12; decGtot12)
            {
            }
            column(decGtot13; decGtot13)
            {
            }
            column(decGtot14; decGtot14)
            {
            }
            column(decGtot15; decGtot15)
            {
            }
            column(decGtot18; decGtot18)
            {
            }
            column(Page_No____Caption; Page_No____CaptionLbl)
            {
            }
            column(Print_Date___Caption; Print_Date___CaptionLbl)
            {
            }
            column(User_Id___Caption; User_Id___CaptionLbl)
            {
            }
            column(Nature_of_TDSCaption; Nature_of_TDSCaptionLbl)
            {
            }
            column(Name_of_the_PartyCaption; Name_of_the_PartyCaptionLbl)
            {
            }
            column(AddressCaption; AddressCaptionLbl)
            {
            }
            column(PAN_No_Caption; PAN_No_CaptionLbl)
            {
            }
            column(Basic_AmountCaption; Basic_AmountCaptionLbl)
            {
            }
            column(SurchargeCaption; SurchargeCaptionLbl)
            {
            }
            column(Sr_No_Caption; Sr_No_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(TDSCaption; TDSCaptionLbl)
            {
            }
            column(E_CessCaption; E_CessCaptionLbl)
            {
            }
            column(SHE_CessCaption; SHE_CessCaptionLbl)
            {
            }
            column(Total_TDSCaption; Total_TDSCaptionLbl)
            {
            }
            column(Invoice_No_Caption; Invoice_No_CaptionLbl)
            {
            }
            column(Section_Caption; Section_CaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(TDS_Entry_Entry_No_; "Entry No.")
            {
            }
            column(TDS_Entry_TDS_Section; "tds entry"."Section")
            {
            }
            column(TDS_Entry_Assessee_Code; "Assessee Code")
            {
            }
            column(VendInvNo; VendInvNo)
            {

            }
            column(ShowNarration; ShowNarration)
            {

            }
            column(Vendor_No_; "Vendor No.")
            {

            }
            column(Challan_No_; "Challan No.")
            {

            }
            column(Challan_Date; FORMAT("Challan Date"))
            {

            }
            column(TotalGSTAmount; TotalGSTAmount)
            {

            }
            column(txtPurchInvComment; txtPurchInvComment)
            {

            }
            column(GLName; GLName) { }
            trigger OnAfterGetRecord()
            begin

                txtAssessee := '';
                recAssessee.Reset;
                recAssessee.SetRange(recAssessee.Code, "TDS Entry"."Assessee Code");
                if recAssessee.FindFirst() then begin
                    txtAssessee := recAssessee.Description;
                end;

                intSrno += 1;
                decTot := "TDS Entry"."TDS Amount" + "TDS Entry"."Surcharge Amount" + "TDS Entry"."eCESS Amount" + "TDS Entry"."SHE Cess Amount";
                decGTot1 += "TDS Entry"."TDS Amount";
                decGtot2 += "TDS Entry"."Surcharge Amount";
                decGTot3 += "TDS Entry"."eCESS Amount";
                decGTot4 += "TDS Entry"."SHE Cess Amount";
                decGTot5 += decTot;
                decGtot16 += "TDS Entry"."TDS Base Amount";

                txtnatureOfDeduction := '';
                recTDSNatOfDed.Reset;
                recTDSNatOfDed.SetRange(recTDSNatOfDed.Code, "TDS Entry".Section);
                if recTDSNatOfDed.FindFirst() then
                    txtnatureOfDeduction := recTDSNatOfDed.Description;

                txtPartyName := '';
                txtPartyAddress := '';
                cdPAN := '';

                if "TDS Entry"."Party Type" = "TDS Entry"."Party Type"::Vendor then begin
                    recVendor.Reset;
                    recVendor.SetRange(recVendor."No.", "TDS Entry"."Party Code");
                    if recVendor.FindFirst() then begin
                        txtPartyName := recVendor.Name;
                        txtPartyAddress := recVendor.Address;
                        cdPAN := recVendor."P.A.N. No.";
                    end;
                end;

                if "TDS Entry"."Party Type" = "TDS Entry"."Party Type"::Customer then begin
                    recCustomer.Reset;
                    recCustomer.SetRange(recCustomer."No.", "TDS Entry"."Party Code");
                    if recCustomer.FindFirst() then begin
                        txtPartyName := recCustomer.Name;
                        txtPartyAddress := recCustomer.Address;
                        cdPAN := recCustomer."P.A.N. No.";
                    end;
                end;

                if "TDS Entry"."Party Type" = "TDS Entry"."Party Type"::Party then begin
                    recParty.Reset;
                    recParty.SetRange(recParty.Code, "TDS Entry"."Party Code");
                    if recParty.FindFirst() then begin
                        txtPartyName := recParty.Name;
                        txtPartyAddress := recParty.Address;
                        cdPAN := recParty."P.A.N. No.";
                    end;
                end;

                if txtPartyName = '' then begin
                    recVendor.Reset;
                    recVendor.SetRange(recVendor."No.", "TDS Entry"."Vendor No.");
                    if recVendor.FindFirst() then begin
                        txtPartyName := recVendor.Name;
                        txtPartyAddress := recVendor.Address;
                        cdPAN := recVendor."P.A.N. No.";
                    end;
                end;

                VendInvNo := '';
                PurchInvHdr.Reset();
                PurchInvHdr.SetRange("No.", "Document No.");
                if PurchInvHdr.FindFirst() then begin
                    VendInvNo := PurchInvHdr."Vendor Invoice No.";
                    CalculateStructure.OnGetPurchInvHeaderGSTAmount(PurchInvHdr, TotalGSTAmount);
                end;

                txtPurchInvComment := '';
                PurchCommentLine.Reset();
                PurchCommentLine.SetRange(PurchCommentLine."No.", "Document No.");
                if PurchCommentLine.FindFirst() then begin
                    repeat
                        txtPurchInvComment += PurchCommentLine.Comment;
                    until PurchCommentLine.Next() = 0;
                end;
                Clear(GLName);
                LineNarration := '';
                GLEntry.Reset();
                GLEntry.SetRange("Document No.", "Document No.");
                GLEntry.SetRange("Entry No.", "G/L Entry No.");
                IF GLEntry.FindFirst() then begin
                    repeat
                        LineNarration := GLEntry."E3 Narration";
                        if GLAcc.Get(GLEntry."G/L Account No.") then
                            GLName := GLAcc.Name;
                    until GLEntry.Next() = 0;
                end;




            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number);
            column(Page_No______FORMAT_CurrReport_PAGENO_; 'Page No. ' + Format(CurrReport.PageNo))
            {
            }
            column(Integer_Number; Number)
            {
            }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, 1);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Show Narration"; ShowNarration)
                    {
                        Caption = 'Show Narration';
                        ApplicationArea = All;
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

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin
        recCompInfo.Get();
        recCompInfo.CalcFields(recCompInfo.Picture);
        recGlSetup.Get;
        if recState.Get(recCompInfo."State Code") then
            txtState := recState.Description;

        dtStart := "TDS Entry".GetRangeMin("Posting Date");
        dtEnd := "TDS Entry".GetRangeMax("Posting Date");


    end;

    var
        recCompInfo: Record "Company Information";
        intSrno: Integer;
        decTot: Decimal;
        decGTot1: Decimal;
        decGtot2: Decimal;
        decGTot3: Decimal;
        decGTot4: Decimal;
        decGTot5: Decimal;
        recTDSNatOfDed: Record "TDS Section";
        txtnatureOfDeduction: Text;
        recCustomer: Record Customer;
        recVendor: Record Vendor;
        recParty: Record Party;
        txtPartyName: Text;
        txtPartyAddress: Text;
        cdPAN: Code[50];
        txtData: array[255] of Text;
        intdata: Integer;
        blnExcel: Boolean;
        recAssessee: Record "Assessee Code";
        txtAssessee: Text;
        decGtot6: Decimal;
        decGTot7: Decimal;
        decGTot8: Decimal;
        decGTot9: Decimal;
        decGTot10: Decimal;
        decGTot11: Decimal;
        decGtot12: Decimal;
        decGtot13: Decimal;
        decGtot14: Decimal;
        decGtot15: Decimal;
        decGtot16: Decimal;
        decGTot17: Decimal;
        decGtot18: Decimal;
        dtStart: Date;
        dtEnd: Date;
        recGlSetup: Record "General Ledger Setup";
        txtState: Text;
        recState: Record State;
        Page_No____CaptionLbl: Label 'Page No. :-';
        Print_Date___CaptionLbl: Label 'Print Date :-';
        User_Id___CaptionLbl: Label 'User Id :-';
        Nature_of_TDSCaptionLbl: Label 'Nature of TDS';
        Name_of_the_PartyCaptionLbl: Label 'Name of the Party';
        AddressCaptionLbl: Label 'Address';
        PAN_No_CaptionLbl: Label 'PAN No.';
        Basic_AmountCaptionLbl: Label 'Basic Amount';
        SurchargeCaptionLbl: Label 'Surcharge';
        Sr_No_CaptionLbl: Label 'Sr.';
        DateCaptionLbl: Label 'Posting Date';
        TDSCaptionLbl: Label 'TDS Amount';
        E_CessCaptionLbl: Label 'E Cess';
        SHE_CessCaptionLbl: Label 'SHE Cess';
        Total_TDSCaptionLbl: Label 'Total TDS';
        Invoice_No_CaptionLbl: Label 'Document No.';
        Section_CaptionLbl: Label 'Section:';
        Grand_TotalCaptionLbl: Label 'Grand Total';
        PurchInvHdr: Record "Purch. Inv. Header";
        VendInvNo: Text[100];
        PurchCommentLine: Record "Purch. Comment Line";
        txtPurchInvComment: Text[1000];
        GLEntry: Record "G/L Entry";
        LineNarration: Text;
        ShowNarration: Boolean;
        CalculateStructure: Codeunit "Calculate Statistics";
        TotalGSTAmount: Decimal;
        RecCompanyName: Code[100];
        GLAcc: Record "G/L Account";
        GLName: Text[100];
}

