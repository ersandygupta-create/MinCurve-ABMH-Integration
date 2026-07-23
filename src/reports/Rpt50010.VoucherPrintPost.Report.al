report 50010 "Voucher Print-Post"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50010.VoucherPrintPost.rdlc';
    Caption = 'Voucher Print - Posted';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Document No.", "Posting Date") ORDER(Descending);
            RequestFilterFields = "Document No.";
            column(txtNarration; txtNarration + ' ' + txtNarration1 + ' ' + LineNarrGL)
            {
            }
            column(VoucherSourceDesc; SourceDesc + ' Voucher')
            {
            }
            column(DocumentNo_GLEntry; "Document No.")
            {
            }
            column(E3_Narration; LineNarrGL)
            {
            }

            column(PostingDateFormatted; 'Date: ' + Format("Posting Date", 0, '<day,2>/<month,2>/<year4>'))
            {
            }
            column(CompanyInformationAddress; CompanyInformation.Address + ' ' + CompanyInformation."Address 2" + '  ' + CompanyInformation.City)
            {
            }
            column(CompanyInformationName; RecCompanyName)//CompanyInformation.Name)
            {
            }
            column(CompanyPAN; CompanyInformation."P.A.N. No.")
            {
            }
            column(CompanyGSTIN; CompanyInformation."GST Registration No.")
            {
            }
            column(CompanyCIN; CompanyInformation."CIN No.")
            {
            }
            column(CompanyLogo; CompanyInformation.Picture)
            {
            }
            column(CreditAmount_GLEntry; "Credit Amount")
            {
            }
            column(DebitAmount_GLEntry; "Debit Amount")
            {
            }
            column(DrText; DrText)
            {
            }
            column(GLAccName; GLAccName)
            {
            }
            column(CrText; CrText)
            {
            }
            column(DebitAmountTotal; DebitAmountTotal)
            {
            }
            column(CreditAmountTotal; CreditAmountTotal)
            {
            }
            column(ChequeDetail; 'Cheque No./RTGS: ' + ChequeNo + ' ' + "E3 UTR No." + '  Dated: ' + Format(ChequeDate))
            {
            }
            column(ChequeNo; ChequeNo)
            {
            }
            column(ChequeDate; ChequeDate)
            {
            }
            column(BeneficiaryName; '')
            {
            }
            column(RsNumberText1NumberText2; '*** ' + NumberText[1] + ' ' + NumberText[2])
            {
            }
            column(EntryNo_GLEntry; "Entry No.")
            {
            }
            column(PostingDate_GLEntry; "Posting Date")
            {
            }
            column(TransactionNo_GLEntry; "Transaction No.")
            {
            }
            column(VoucherNoCaption; VoucherNoCaptionLbl)
            {
            }
            column(CreditAmountCaption; CreditAmountCaptionLbl)
            {
            }
            column(DebitAmountCaption; DebitAmountCaptionLbl)
            {
            }
            column(ParticularsCaption; ParticularsCaptionLbl)
            {
            }
            column(AmountInWordsCaption; AmountInWordsCaptionLbl)
            {
            }
            column(PreparedByCaption; PreparedByCaptionLbl)
            {
            }
            column(CheckedByCaption; CheckedByCaptionLbl)
            {
            }
            column(ApprovedByCaption; ApprovedByCaptionLbl)
            {
            }
            column(ReceiverByCaption; ReceiverCaptionLbl)
            {
            }
            column(Loc_Add; arrLoctAdd[1])
            {
            }
            column(Loc_Add1; arrLoctAdd[2])
            {
            }
            column(Loc_Add2; arrLoctAdd[3])
            {
            }
            column(Loc_Add3; arrLoctAdd[4])
            {
            }
            column(ExternalDocNo; "External Document No.")
            {
            }
            column(txtPostedDescription; txtPostedDescription)
            {
            }
            column(DocumentDate; dtVendInvdate)
            {
            }
            column(CreatedByUSERID; "User ID")
            {
            }
            column(PostedByUserid; "User ID")
            {
            }
            column(SourceName; SourceName)
            {
            }
            column(SourceNo; sourceNo)
            {
            }
            column(UHID; "E3 UHID")
            {
            }
            column(PatientName; "E3 Patient Name")
            {
            }

            dataitem("Dimension Set Entry"; "Dimension Set Entry")
            {
                DataItemLink = "Dimension Set ID" = FIELD("Dimension Set ID");
                DataItemTableView = SORTING("Dimension Set ID", "Dimension Code");
                column(Dimension_Set_ID; "Dimension Set Entry"."Dimension Set ID")
                {
                }
                column(Dimension_Name; "Dimension Set Entry"."Dimension Name")
                {
                }
                column(Dimension_Value_Code; "Dimension Set Entry"."Dimension Value Code")
                {
                }
                column(Dimension_Value_Name; "Dimension Set Entry"."Dimension Value Name")
                {
                }
            }
            dataitem(LineNarration; "Posted Narration")
            {
                DataItemLink = "Transaction No." = FIELD("Transaction No."), "Entry No." = FIELD("Entry No.");
                DataItemTableView = SORTING("Entry No.", "Transaction No.", "Line No.");
                column(Narration_LineNarration; ('Line: ' + Narration))
                {
                }
                column(PrintLineNarration; PrintLineNarration)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if PrintLineNarration then begin
                        PageLoop := PageLoop - 1;
                        LinesPrinted := LinesPrinted + 1;
                    end;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(IntegerOccurcesCaption; IntegerOccurcesCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PageLoop := PageLoop - 1;
                end;

                trigger OnPreDataItem()
                begin
                    GLEntry.SetCurrentKey("Document No.", "Posting Date", Amount);
                    GLEntry.Ascending(false);
                    GLEntry.SetRange("Posting Date", "G/L Entry"."Posting Date");
                    GLEntry.SetRange("Document No.", "G/L Entry"."Document No.");
                    GLEntry.FindLast;
                    if not (GLEntry."Entry No." = "G/L Entry"."Entry No.") then
                        CurrReport.Break;

                    SetRange(Number, 1, PageLoop)
                end;
            }
            dataitem(PostedNarration1; "Posted Narration")
            {
                DataItemLink = "Transaction No." = FIELD("Transaction No.");
                DataItemTableView = SORTING("Entry No.", "Transaction No.", "Line No.") WHERE("Entry No." = CONST(0));
                column(Narration_PostedNarration1; 'Vouecher: ' + Narration)
                {
                }
                column(NarrationCaption; NarrationCaptionLbl)
                {
                }

                trigger OnPreDataItem()
                begin
                    GLEntry.SetCurrentKey("Document No.", "Posting Date", Amount);
                    GLEntry.Ascending(false);
                    GLEntry.SetRange("Posting Date", "G/L Entry"."Posting Date");
                    GLEntry.SetRange("Document No.", "G/L Entry"."Document No.");
                    GLEntry.FindLast;
                    if not (GLEntry."Entry No." = "G/L Entry"."Entry No.") then
                        CurrReport.Break;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                GLAccName := '';
                GLAccName := FindGLAccName("Entry No.", "Source No.", "G/L Account No.");
                if Amount < 0 then begin
                    CrText := 'To';
                    DrText := '';
                end else begin
                    CrText := '';
                    DrText := 'Dr';
                end;

                SourceDesc := '';
                if "Source Code" <> '' then begin
                    if "Source Code" <> 'GENJNL' then begin
                        SourceCode.Get("Source Code");
                        SourceDesc := SourceCode.Description;
                    end;

                    if "Source Code" = 'GENJNL' then begin
                        SourceDesc := 'Bank';
                    end;
                end;

                PageLoop := PageLoop - 1;
                LinesPrinted := LinesPrinted + 1;

                ChequeNo := '';
                ChequeDate := 0D;
                if ("Source No." <> '') and ("Source Type" = "Source Type"::"Bank Account") then begin
                    if BankAccLedgEntry.Get("Entry No.") then begin
                        ChequeNo := BankAccLedgEntry."Cheque No.";
                        ChequeDate := BankAccLedgEntry."Cheque Date";
                    end;
                end;

                if (ChequeNo <> '') and (ChequeDate <> 0D) then begin
                    PageLoop := PageLoop - 1;
                    LinesPrinted := LinesPrinted + 1;
                end;

                if PostingDate <> "Posting Date" then begin
                    PostingDate := "Posting Date";
                    TotalDebitAmt := 0;
                end;

                if DocumentNo <> "Document No." then begin
                    DocumentNo := "Document No.";
                    TotalDebitAmt := 0;
                end;

                if PostingDate = "Posting Date" then begin
                    InitTextVariable;
                    TotalDebitAmt += "Debit Amount";
                    FormatNoText(NumberText, Abs(TotalDebitAmt), '');
                    PageLoop := NUMLines;
                    LinesPrinted := 0;
                end;

                //IN0090.Begin
                if (PrePostingDate <> "Posting Date") or (PreDocumentNo <> "Document No.") then begin
                    DebitAmountTotal := 0;
                    CreditAmountTotal := 0;
                    PrePostingDate := "Posting Date";
                    PreDocumentNo := "Document No.";
                end;

                DebitAmountTotal := DebitAmountTotal + "Debit Amount";
                CreditAmountTotal := CreditAmountTotal + "Credit Amount";
                //IN0090.End

                CompanyInformation.get();
                CompanyInformation.CalcFields(Picture);
                //arrLoctAdd[1] := CompanyInformation.Name;
                arrLoctAdd[2] := CompanyInformation.Address + '-' + CompanyInformation."Address 2";
                recState.Get(CompanyInformation."State Code");
                if recCountry.Get(CompanyInformation."Country/Region Code") then
                    arrLoctAdd[3] := CompanyInformation.City + '-' + CompanyInformation."Post Code" + ', ' + recState.Description + ', ' + recCountry.Name;
                arrLoctAdd[4] := 'Phone No. : ' + CompanyInformation."Phone No.";

                if ("G/L Entry"."Posting Date" < CompanyInformation."Transaction Date") then
                    arrLoctAdd[1] := CompanyInformation."Old Comapany Name"
                else
                    arrLoctAdd[1] := CompanyInformation.Name;

                txtPostedDescription := '';
                recPurchInvHdr.Reset;
                recPurchInvHdr.SetRange(recPurchInvHdr."No.", "Document No.");
                if recPurchInvHdr.Find('+') then begin
                    txtPostedDescription := recPurchInvHdr."Posting Description";
                end else
                    recPurchCrMemoHdr.Reset;
                recPurchCrMemoHdr.SetRange(recPurchCrMemoHdr."No.", "Document No.");
                if recPurchCrMemoHdr.Find('+') then begin
                    txtPostedDescription := recPurchCrMemoHdr."Posting Description";
                end else
                    recSalesInvHdr.Reset;
                recSalesInvHdr.SetRange(recSalesInvHdr."No.", "Document No.");
                if recSalesInvHdr.Find('+') then begin
                    txtPostedDescription := recSalesInvHdr."Posting Description";
                end else
                    recSalesCrMemoHdr.Reset;
                recSalesCrMemoHdr.SetRange(recSalesCrMemoHdr."No.", "Document No.");
                if recSalesCrMemoHdr.Find('+') then begin
                    txtPostedDescription := recSalesCrMemoHdr."Posting Description";

                end;

                txtNarration := '';
                PostedNarration.Reset;
                PostedNarration.SetRange("Document No.", "Document No.");
                PostedNarration.SetRange("Entry No.", 0);
                if PostedNarration.Find('-') then
                    repeat
                        txtNarration += PostedNarration.Narration;
                    until PostedNarration.Next = 0;

                txtNarration1 := '';

                PurchCommentLine.Reset;
                PurchCommentLine.SetRange(PurchCommentLine."Document Type", PurchCommentLine."Document Type"::"Posted Invoice");
                PurchCommentLine.SetRange(PurchCommentLine."No.", "G/L Entry"."Document No.");
                if PurchCommentLine.FindFirst then
                    repeat
                        txtNarration1 += PurchCommentLine.Comment;
                    until PurchCommentLine.Next = 0;

                SalesCommentLine.Reset;
                SalesCommentLine.SetRange(SalesCommentLine."Document Type", SalesCommentLine."Document Type"::"Posted Invoice");
                SalesCommentLine.SetRange(SalesCommentLine."No.", "G/L Entry"."Document No.");
                if SalesCommentLine.FindFirst then
                    repeat
                        txtNarration1 += SalesCommentLine.Comment;
                    until SalesCommentLine.Next = 0;


                LineNarrGL := '';
                GLEntry.Reset;
                GLEntry.SetRange("Journal Batch Name", "Journal Batch Name");
                GLEntry.SetRange("Document No.", "Document No.");
                if GLEntry.FindFirst then begin
                    repeat
                        LineNarrGL := GLEntry."E3 Narration";
                    until GLEntry.Next = 0;
                end;

                dtVendInvdate := 0D;
                PurchInvHeader.Reset;
                PurchInvHeader.SetRange("No.", "Document No.");
                if PurchInvHeader.FindFirst then begin
                    dtVendInvdate := PurchInvHeader."Order Date";
                end;


                SourceName := '';
                sourceNo := '';
                GLAccount.Reset;
                GLAccount.SetRange("No.", "G/L Entry"."G/L Account No.");
                if GLAccount.FindFirst then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange("Journal Batch Name", "Journal Batch Name");
                        GLEntry.SetRange("Document No.", "Document No.");
                        GLEntry.SetRange("G/L Account No.", GLAccount."No.");
                        if GLEntry.FindFirst then begin
                            repeat
                                if GLEntry."Source Type" <> GLEntry."Source Type"::" " then begin
                                    if (GLEntry."Source Type" = GLEntry."Source Type"::Customer) and Customer.Get("Source No.") then begin
                                        sourceNo := "Source No.";
                                        SourceName := Customer.Name;
                                    end else
                                        if (GLEntry."Source Type" = GLEntry."Source Type"::Vendor) and Vendor.Get("Source No.") then begin
                                            sourceNo := "Source No.";
                                            SourceName := Vendor.Name;
                                        end else
                                            if (GLEntry."Source Type" = GLEntry."Source Type"::"Bank Account") and BankAcc.Get("Source No.") then begin
                                                sourceNo := "Source No.";
                                                SourceName := BankAcc.Name
                                            end else
                                                if (GLEntry."Source Type" = GLEntry."Source Type"::"Fixed Asset") and FA.Get("Source No.") then begin
                                                    sourceNo := "Source No.";
                                                    SourceName := FA.Description;
                                                end else

                                                    if (GLEntry."Source Type" = GLEntry."Source Type"::Employee) and Employee.Get("Source No.") then begin
                                                        sourceNo := "Source No.";
                                                        SourceName := Employee.FullName();
                                                    end;

                                end;
                            until GLEntry.Next = 0;
                        end;
                    until GLAccount.Next = 0;
                end;
                //MESSAGE(SourceName);
            end;

            trigger OnPreDataItem()
            begin
                NUMLines := 13;
                PageLoop := NUMLines;
                LinesPrinted := 0;
                DebitAmountTotal := 0;
                CreditAmountTotal := 0;
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
                    field(PrintLineNarration; PrintLineNarration)
                    {
                        Caption = 'PrintLineNarration';
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

    trigger OnInitReport()
    begin
        //"G/L Entry".setrange("Document No.",cdDocsNo);
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        /*
        arrLoctAdd[1] := CompanyInformation.Name;
        arrLoctAdd[2] := CompanyInformation.Address + '-' +CompanyInformation."Address 2";
        recState.GET(CompanyInformation.State);
        IF recCountry.GET(CompanyInformation."Country/Region Code") THEN
           arrLoctAdd[3] := CompanyInformation.City + '-' + CompanyInformation."Post Code" + ', ' + recState.Description + ', ' + recCountry.Name;
           arrLoctAdd[4] := 'Phone No. : ' + CompanyInformation."Phone No.";
        */

    end;

    var
        CompanyInformation: Record "Company Information";
        SourceCode: Record "Source Code";
        GLEntry: Record "G/L Entry";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        GLAccName: Text[100];
        SourceDesc: Text[100];
        CrText: Text[2];
        DrText: Text[2];
        NumberText: array[2] of Text[80];
        PostedVoucher: Report "Posted Voucher";
        PageLoop: Integer;
        LinesPrinted: Integer;
        NUMLines: Integer;
        ChequeNo: Code[50];
        ChequeDate: Date;
        Text16526: Label 'ZERO';
        Text16527: Label 'HUNDRED';
        Text16528: Label 'AND';
        Text16529: Label '%1 results in a written number that is too long.';
        Text16532: Label 'ONE';
        Text16533: Label 'TWO';
        Text16534: Label 'THREE';
        Text16535: Label 'FOUR';
        Text16536: Label 'FIVE';
        Text16537: Label 'SIX';
        Text16538: Label 'SEVEN';
        Text16539: Label 'EIGHT';
        Text16540: Label 'NINE';
        Text16541: Label 'TEN';
        Text16542: Label 'ELEVEN';
        Text16543: Label 'TWELVE';
        Text16544: Label 'THIRTEEN';
        Text16545: Label 'FOURTEEN';
        Text16546: Label 'FIFTEEN';
        Text16547: Label 'SIXTEEN';
        Text16548: Label 'SEVENTEEN';
        Text16549: Label 'EIGHTEEN';
        Text16550: Label 'NINETEEN';
        Text16551: Label 'TWENTY';
        Text16552: Label 'THIRTY';
        Text16553: Label 'FORTY';
        Text16554: Label 'FIFTY';
        Text16555: Label 'SIXTY';
        Text16556: Label 'SEVENTY';
        Text16557: Label 'EIGHTY';
        Text16558: Label 'NINETY';
        Text16559: Label 'THOUSAND';
        Text16560: Label 'MILLION';
        Text16561: Label 'BILLION';
        Text16562: Label 'LAKH';
        Text16563: Label 'CRORE';
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        PrintLineNarration: Boolean;
        PostingDate: Date;
        TotalDebitAmt: Decimal;
        DocumentNo: Code[20];
        DebitAmountTotal: Decimal;
        CreditAmountTotal: Decimal;
        PrePostingDate: Date;
        PreDocumentNo: Code[50];
        VoucherNoCaptionLbl: Label 'Voucher No. :';
        CreditAmountCaptionLbl: Label 'Credit Amount';
        DebitAmountCaptionLbl: Label 'Debit Amount';
        ParticularsCaptionLbl: Label 'Particulars';
        AmountInWordsCaptionLbl: Label 'Amount (in words):';
        PreparedByCaptionLbl: Label 'Prepared By:';
        CheckedByCaptionLbl: Label 'Approved by:';
        ApprovedByCaptionLbl: Label 'Posted by:';
        IntegerOccurcesCaptionLbl: Label 'IntegerOccurces';
        NarrationCaptionLbl: Label 'Narration :';
        "------acxrv---------": Integer;
        CreditAmount: Text[10];
        ReceiverCaptionLbl: Label 'Received By :';
        recLocation: Record Location;
        recState: Record State;
        recCountry: Record "Country/Region";
        arrLoctAdd: array[10] of Text[300];
        LastGLEntryNo: Integer;
        cdDocsNo: Code[20];
        recPurchInvHdr: Record "Purch. Inv. Header";
        recPurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        recSalesInvHdr: Record "Sales Invoice Header";
        recSalesCrMemoHdr: Record "Sales Cr.Memo Header";
        txtPostedDescription: Text;
        PostedNarration: Record "Posted Narration";
        txtNarration: Text[1000];
        PurchCommentLine: Record "Purch. Comment Line";
        txtNarration1: Text;
        LineNarrGL: Text;
        PurchInvHeader: Record "Purch. Inv. Header";
        dtVendInvdate: Date;
        SourceName: Text;
        Customer: Record Customer;
        Vendor: Record Vendor;
        BankAcc: Record "Bank Account";
        FA: Record "Fixed Asset";
        Employee: Record Employee;
        sourceNo: Text;
        GLAccount: Record "G/L Account";
        SalesCommentLine: Record "Sales Comment Line";
        RecCompanyName: Code[100];

    procedure FindGLAccName("Entry No.": Integer; "Source No.": Code[20]; "G/L Account No.": Code[20]): Text[100]
    var
        AccName: Text[100];
        VendLedgerEntry: Record "Vendor Ledger Entry";
        Vend: Record Vendor;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        Bank: Record "Bank Account";
        FALedgerEntry: Record "FA Ledger Entry";
        FAsset: Record "Fixed Asset";
        GLAccounts: Record "G/L Account";
    begin
        AccName := '';
        if "G/L Entry"."Source Type" = "Source Type"::Vendor then begin
            GLAccount.Get("G/L Account No.");
            if StrPos(GLAccount.Name, 'GST') > 0 then
                AccName := GLAccount."No." + ' - ' + GLAccount.Name;
            if AccName = '' then begin
                if ("G/L Entry"."Source No." <> '') and (StrPos(GLAccount.Name, 'CREDITOR') > 0) then begin
                    Vend.Get("Source No.");
                    AccName := Vend."No." + ' - ' + Vend.Name + ' ' + Vend.City + ' ' + Vend."State Code"
                end else begin
                    GLAccount.Get("G/L Account No.");
                    AccName := GLAccount."No." + ' - ' + GLAccount.Name;
                end;
            end;
        end else
            if "G/L Entry"."Source Type" = "Source Type"::Customer then begin
                GLAccount.Get("G/L Account No.");
                if StrPos(GLAccount.Name, 'GST') > 0 then
                    AccName := GLAccount."No." + ' - ' + GLAccount.Name;
                if AccName = '' then begin
                    //IF CustLedgerEntry.GET("Entry No.") THEN BEGIN
                    if ("G/L Entry"."Source No." <> '') and (StrPos(GLAccount.Name, 'DEBTOR') > 0) then begin
                        Cust.Get("Source No.");
                        AccName := Cust."No." + ' - ' + Cust.Name + ' ' + Cust.City + ' ' + Cust."State Code"
                    end else begin
                        GLAccount.Get("G/L Account No.");
                        AccName := GLAccount."No." + ' - ' + GLAccount.Name;
                    end;
                end;
            end else
                if "G/L Entry"."Source Type" = "Source Type"::"Bank Account" then begin
                    GLAccount.Get("G/L Account No.");
                    if StrPos(GLAccount.Name, 'GST') > 0 then
                        AccName := GLAccount."No." + ' - ' + GLAccount.Name;
                    if AccName = '' then begin
                        if BankLedgerEntry.Get("Entry No.") then begin
                            Bank.Get("Source No.");
                            AccName := Bank."No." + ' - ' + Bank.Name
                        end else begin
                            GLAccount.Get("G/L Account No.");
                            AccName := GLAccount."No." + ' - ' + GLAccount.Name;
                        end;
                    end;
                    // PS45258.begin
                    //ELSE IF "Source Type" = "Source Type"::"Fixed Asset" THEN BEGIN
                    //  FALedgerEntry.RESET;
                    //  FALedgerEntry.SETCURRENTKEY("G/L Entry No.");
                    //  FALedgerEntry.SETRANGE("G/L Entry No.","Entry No.");
                    //  IF FALedgerEntry.FINDFIRST THEN BEGIN
                    //    FA.GET("Source No.");
                    //    AccName := FA.Description;
                    //  END ELSE BEGIN
                    //    GLAccount.GET("G/L Account No.");
                    //    AccName := GLAccount.Name;
                    //  END;
                    //END ELSE BEGIN
                end else begin
                    // PS45258.end
                    GLAccount.Get("G/L Account No.");
                    AccName := GLAccount."No." + ' - ' + GLAccount.Name;
                end;

        if "G/L Entry"."Source Type" = "Source Type"::" " then begin
            GLAccount.Get("G/L Account No.");
            AccName := GLAccount."No." + ' - ' + GLAccount.Name;
        end;

        exit(AccName);
    end;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        Currency: Record Currency;
        TensDec: Integer;
        OnesDec: Integer;
    begin
        Clear(NoText);
        NoTextIndex := 1;
        NoText[1] := '';

        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526)
        else begin
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                if No > 99999 then begin
                    Ones := No div (Power(100, Exponent - 1) * 10);
                    Hundreds := 0;
                end else begin
                    Ones := No div Power(1000, Exponent - 1);
                    Hundreds := Ones div 100;
                end;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text16527);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                if No > 99999 then
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(100, Exponent - 1) * 10
                else
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;
        end;

        if CurrencyCode <> '' then begin
            Currency.Get(CurrencyCode);
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + Currency.GetCurrencySymbol());
        end else
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'RUPEES');

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text16528);

        TensDec := ((No * 100) mod 100) div 10;
        OnesDec := (No * 100) mod 10;
        if TensDec >= 2 then begin
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            if OnesDec > 0 then
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        end else
            if (TensDec * 10 + OnesDec) > 0 then
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
            else
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526);
        if (CurrencyCode <> '') then
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + Currency.GetCurrencySymbol() + ' ONLY')
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY');
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := true;

        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then
                Error(Text16529, AddText);
        end;

        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := Text16532;
        OnesText[2] := Text16533;
        OnesText[3] := Text16534;
        OnesText[4] := Text16535;
        OnesText[5] := Text16536;
        OnesText[6] := Text16537;
        OnesText[7] := Text16538;
        OnesText[8] := Text16539;
        OnesText[9] := Text16540;
        OnesText[10] := Text16541;
        OnesText[11] := Text16542;
        OnesText[12] := Text16543;
        OnesText[13] := Text16544;
        OnesText[14] := Text16545;
        OnesText[15] := Text16546;
        OnesText[16] := Text16547;
        OnesText[17] := Text16548;
        OnesText[18] := Text16549;
        OnesText[19] := Text16550;

        TensText[1] := '';
        TensText[2] := Text16551;
        TensText[3] := Text16552;
        TensText[4] := Text16553;
        TensText[5] := Text16554;
        TensText[6] := Text16555;
        TensText[7] := Text16556;
        TensText[8] := Text16557;
        TensText[9] := Text16558;

        ExponentText[1] := '';
        ExponentText[2] := Text16559;
        ExponentText[3] := Text16562;
        ExponentText[4] := Text16563;
    end;

    procedure GetDocsNo(DocsNo: Code[20])
    begin
        cdDocsNo := DocsNo;
    end;
}

