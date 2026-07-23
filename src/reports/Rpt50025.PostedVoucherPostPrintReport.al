report 50025 "Posted Voucher - Post Voucher"
{

    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50025.PostedVoucherPostVoucher.rdlc';

    Caption = 'Voucher Print - Posted';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Document No.", "Posting Date", Amount)
                                ORDER(Descending);
            RequestFilterFields = "Posting Date", "Document No.";

            column(VoucherSourceDescription; 'Contra Voucher')
            {
            }
            column(PreparedBy; UserId)
            {
            }
            column(E3_Narration; "E3 Narration") { }
            column(DocumentNo_GLEntry; VoucherNoCaptionLbl + ' ' + "Document No.") { }
            column(LocationName; LocationName) { }
            column(LocAdd; LocAdd) { }
            column(LocAdd2; LocAdd2) { }

            column(PostingDateFormatted; 'Posting Date: ' + FORMAT("Posting Date", 0, '<Day,2>-<Month Text,3>-<Year4>')) { }
            column(DocDateFormatted; Format(DocumentDate, 0, '<Day,2>-<Month Text,3>-<Year4>')) { }
            column(CompanyInformationAddress; CompanyInformation.Address + ',' + CompanyInformation."Address 2") { }
            column(CompanyInformationcity; CompanyInformation.City + ' - ' + CompanyInformation."Post Code") { }
            column(CompanyInformation; CompanyInformation.Name) { }
            column(CompanyInfoVATNo; CompanyInformation."GST Registration No.") { }
            column(CreditAmount_GLEntry; "Credit Amount") { }
            column(DebitAmount_GLEntry; "Debit Amount") { }
            column(DrText; DrText) { }
            column(GLAccName; GLAccName) { }
            column(GLAccNo; "G/L Entry"."G/L Account No.") { }
            column(CrText; CrText) { }
            column(DebitAmountTotal; DebitAmountTotal) { }
            column(CreditAmountTotal; CreditAmountTotal) { }
            column(ChequeDetail; 'Cheque No: ' + ChequeNo + '  Dated: ' + FORMAT(ChequeDate)) { }
            column(ChequeNo; ChequeNo) { }
            column(UTR; 'UTR No:' + "G/L Entry"."E3 UTR No.") { }
            column(ChequeDate; ChequeDate) { }
            column(RsNumberText1NumberText2; 'Rs. ' + NumberText[1] + ' ' + NumberText[2]) { }
            column(EntryNo_GLEntry; "Entry No.") { }
            column(PostingDate_GLEntry; "Posting Date") { }
            column(TransactionNo_GLEntry; "Transaction No.") { }
            column(VoucherNoCaption; VoucherNoCaptionLbl) { }
            column(CreditAmountCaption; CreditAmountCaptionLbl) { }
            column(DebitAmountCaption; DebitAmountCaptionLbl) { }
            column(ParticularsCaption; ParticularsCaptionLbl) { }
            column(AmountInWordsCaption; AmountInWordsCaptionLbl) { }
            column(PreparedByCaption; PreparedByCaptionLbl) { }
            column(CheckedByCaption; CheckedByCaptionLbl) { }
            column(ApprovedByCaption; ApprovedByCaptionLbl) { }
            column(ReceiptByCaption; ReceiptByCaption) { }
            column(USERID; userc."User Name") { }
            column(ExtDocumentNoLbl; ExtDocumentNoLbl) { }
            column(DocumentDateLbl; DocumentDateLbl) { }
            column(UnitCodeLbl; UnitCodeLbl) { }
            column(UnitNameLbl; UnitNameLbl) { }
            column(DeptCodeLbl; DeptCodeLbl) { }
            column(DeptNameLbl; DeptNameLbl) { }
            column(CostCenterCodeLbl; CostCenterCodeLbl) { }
            column(CostCenterNameLbl; CostCenterNameLbl) { }
            column(SourceName; SourceName) { }
            column(SourceNo; sourceNo) { }
            column(Comment; "G/L Entry".Comment) { }
            column(Ext_Doc_No_; "G/L Entry"."External Document No.") { }
            column(UnitCode; "G/L Entry"."Global Dimension 1 Code") { }
            column(GlobalDim1Name; GetGlobalDim1Name("G/L Entry")) { }
            column(GlobalDim2Code; GlobalDim2Code) { }
            column(ShortcutDim3Code; "G/L Entry"."Shortcut Dimension 3 Code") { }
            column(DeptCode; "Global Dimension 2 Code") { }
            column(CostCenName; GetShortcutDim3Name("G/L Entry")) { }
            column(Dimension_Set_ID; "Dimension Set ID") { }
            column(CurrExRate; CurrExRate) { }
            column(SourCurrCode; SourCurrCode) { }
            column(SourCurrAmt; SourCurrAmt) { }
            dataitem(DataItem5444; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(IntegerOccurcesCaption; IntegerOccurcesCaptionLbl) { }

                trigger OnAfterGetRecord()
                begin
                    PageLoop := PageLoop - 1;
                end;

                trigger OnPreDataItem()
                begin
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date", Amount);
                    GLEntry.ASCENDING(FALSE);
                    GLEntry.SETRANGE("Posting Date", "G/L Entry"."Posting Date");
                    GLEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                    GLEntry.FINDLAST;
                    IF NOT (GLEntry."Entry No." = "G/L Entry"."Entry No.") THEN
                        CurrReport.BREAK;

                    SETRANGE(Number, 1, PageLoop)
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ReceiptByCaption := 'Checked by:';
                GLAccName := FindGLAccName("Source Type", "Entry No.", "Source No.", "G/L Account No.");

                if Amount < 0 then begin
                    CrText := 'To';
                    DrText := '';
                end else begin
                    CrText := '';
                    DrText := 'Dr';
                end;

                Location.RESET;
                Location.SETRANGE(Code, "Global Dimension 1 Code");
                if Location.FINDFIRST then begin
                    LocationName := Location.Name;
                    LocAdd := Location.Address + '';
                    LocAdd2 := Location."Address 2" + ',' + Location.City;

                    if userc.Get(SystemCreatedBy) then;


                    SourceDesc := '';
                    if "Source Code" <> '' then begin
                        SourceCode.GET("Source Code");
                        SourceDesc := SourceCode.Description;
                        if (("Source Code" = 'BANKPYMTV') or ("Source Code" = 'BANKRCPTV') or ("Source Code" = 'CASHPYMTV') or ("Source Code" = 'CASHRCPTV')) then
                            ReceiptByCaption := 'Receipt by :';
                    end;

                    PageLoop := PageLoop - 1;
                    LinesPrinted := LinesPrinted + 1;

                    ChequeNo := '';
                    ChequeDate := 0D;
                    if ("Source No." <> '') and ("Source Type" = "Source Type"::"Bank Account") then begin
                        if BankAccLedgEntry.GET("Entry No.") then
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
                    FormatNoText(NumberText, ABS(TotalDebitAmt), '');
                    PageLoop := NUMLines;
                    LinesPrinted := 0;
                end;

                if (PrePostingDate <> "Posting Date") or (PreDocumentNo <> "Document No.") then begin
                    DebitAmountTotal := 0;
                    CreditAmountTotal := 0;
                    PrePostingDate := "Posting Date";
                    PreDocumentNo := "Document No.";
                end;

                DebitAmountTotal := DebitAmountTotal + "Debit Amount";
                CreditAmountTotal := CreditAmountTotal + "Credit Amount";

                if "Global Dimension 2 Code" <> '' then begin
                    DimensionValue.RESET();
                    if DimensionValue.GET(GeneralLedgerSetup."Global Dimension 2 Code", "Global Dimension 2 Code") then
                        GlobalDim2Code += DimensionValue.Name;
                end;
                if "External Document No." <> '' then begin
                    GLEntry.Reset();
                    GLEntry.SetRange("Document No.", "Document No.");

                    // Only check Invoice entries if document type is Invoice
                    if "Document Type" = "Document Type"::Invoice then begin
                        GLEntry.SetRange("Document Type", GLEntry."Document Type"::Invoice);
                        if GLEntry.FindFirst() then
                            DocumentDate := GLEntry."Document Date"
                        else
                            DocumentDate := 0D;
                    end else begin
                        // If not an invoice, skip invoice logic and clear date
                        DocumentDate := 0D;
                    end;
                end;


                if "Source Currency Code" <> '' then
                    SourCurrCode := GLEntry."Source Currency Code";
                SourCurrAmt := GLEntry."Source Currency Amount";

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
            // area(content)
            // {
            //     group(Options)
            //     {
            //         Caption = 'Options';
            //         field(PrintLineNarration1; PrintLineNarration)
            //         {
            //             Caption = 'PrintLineNarrationNew';
            //         }
            //     }
            // }
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
        PrintLineNarration := TRUE;
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        PrintLineNarration := TRUE;  // S_D
        GeneralLedgerSetup.GET;

    end;

    var
        CompanyInformation: Record 79;
        SourceCode: Record 230;
        GLEntry: Record 17;
        BankAccLedgEntry: Record 271;
        GLAccName: Text[250];
        SourceDesc: Text[50];
        CrText: Text[2];
        DrText: Text[2];
        NumberText: array[2] of Text[80];
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
        VoucherNoCaptionLbl: Label 'Document No. :';
        CreditAmountCaptionLbl: Label 'Credit Amount';
        DebitAmountCaptionLbl: Label 'Debit Amount';
        ParticularsCaptionLbl: Label 'Particulars';
        AmountInWordsCaptionLbl: Label 'Amount (in words):';
        PreparedByCaptionLbl: Label 'Prepared by:';
        CheckedByCaptionLbl: Label 'Checked by:';
        ApprovedByCaptionLbl: Label 'Approved by:';
        IntegerOccurcesCaptionLbl: Label 'IntegerOccurces';
        NarrationCaptionLbl: Label 'Narration';
        ReceiptByCaptionLbl: Label 'Receipt by :';
        ExtDocumentNoLbl: Label 'Ext. Document No.';
        DocumentDateLbl: Label 'Document Date';
        UnitCodeLbl: Label 'Unit Code';
        UnitNameLbl: Label 'Unit Name';
        DeptCodeLbl: Label 'Department Code';
        DeptNameLbl: Label 'Department Name';
        CostCenterCodeLbl: Label 'Cost Center Code';
        CostCenterNameLbl: Label 'Cost Center Name';
        ReceiptByCaption: Text[50];
        DimensionValue: Record 349;
        GeneralLedgerSetup: Record 98;
        Location: Record Location;
        LocationName: Text[60];
        GSTN: Record 79;
        GSTIN: Code[30];
        LocAdd: Code[300];
        LocAdd2: Code[100];
        LineNarrGL: Text;
        userc: Record User;
        sourceNo: Text;
        SourceName: Text;
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        BankAcc: Record "Bank Account";
        FA: Record "Fixed Asset";
        Employee: Record Employee;
        GlobalDim2Code: Text[100];
        GlobalDim1Name: Text[150];
        DocumentDate: Date;
        SourCurrCode: Code[10];
        SourCurrAmt: Decimal;
        Currency: Record "Currency Exchange Rate";
        CurrExRate: Decimal;


    //[Scope('Internal')]
    procedure FindGLAccName(
        "Source Type": Option " ",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        "Entry No.": Integer;
        "Source No.": Code[20];
        "G/L Account No.": Code[20]
    ): Text[250]
    var
        AccName: Text[250];
        GLAccount: Record "G/L Account";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        Vend: Record "Vendor";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        Bank: Record "Bank Account";
        FALedgerEntry: Record "FA Ledger Entry";
        FA: Record "Fixed Asset";
        EmplLedgerEntry: Record "Employee Ledger Entry";
        Empl: Record Employee;
        CRLF: Text[10];
        TypeHelper: Codeunit "Type Helper";
    begin
        CRLF := TypeHelper.CRLFSeparator();

        IF "Source Type" = "Source Type"::Vendor THEN BEGIN
            IF VendLedgerEntry.GET("Entry No.") THEN BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount."No." + '-' + GLAccount.Name;
                Vend.GET("Source No.");
                AccName += CRLF + Vend."No." + '-' + Vend.Name;
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount."No." + '-' + GLAccount.Name;
            END;
        END ELSE IF "Source Type" = "Source Type"::Customer THEN BEGIN
            IF CustLedgerEntry.GET("Entry No.") THEN BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount."No." + '-' + GLAccount.Name;
                Cust.GET("Source No.");
                AccName += CRLF + Cust."No." + '-' + Cust.Name;
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount."No." + '-' + GLAccount.Name;
            END;
        END ELSE IF "Source Type" = "Source Type"::"Bank Account" THEN BEGIN
            IF BankLedgerEntry.GET("Entry No.") THEN BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount."No." + '-' + GLAccount.Name;
                Bank.GET("Source No.");
                AccName += CRLF + Bank."No." + '-' + Bank.Name;
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount."No." + '-' + GLAccount.Name;
            END;
        END ELSE IF "Source Type" = "Source Type"::Employee THEN BEGIN
            IF EmplLedgerEntry.GET("Entry No.") THEN BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount."No." + '-' + GLAccount.Name;
                Empl.GET("Source No.");
                AccName += CRLF + Empl."No." + '-' + Empl."First Name";
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount."No." + '-' + GLAccount.Name;
            END;
        END ELSE IF "Source Type" = "Source Type"::"Fixed Asset" THEN BEGIN
            FALedgerEntry.Reset();
            FALedgerEntry.SetRange("G/L Entry No.", "Entry No.");
            IF FALedgerEntry.FindFirst() THEN BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount."No." + '-' + GLAccount.Name;
                IF FA.Get(FALedgerEntry."FA No.") THEN
                    AccName += CRLF + FA."No." + '-' + FA.Description;
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount."No." + '-' + GLAccount.Name;
            END;
        END ELSE BEGIN
            GLAccount.GET("G/L Account No.");
            AccName := GLAccount."No." + '-' + GLAccount.Name;
        END;

        IF "Source Type" = "Source Type"::" " THEN BEGIN
            GLAccount.GET("G/L Account No.");
            AccName := GLAccount."No." + '-' + GLAccount.Name;
        END;

        EXIT(AccName);
    end;



    // [Scope('Internal')]
    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        Currency: Record 4;
        TensDec: Integer;
        OnesDec: Integer;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '';

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526)
        ELSE BEGIN
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                IF No > 99999 THEN BEGIN
                    Ones := No DIV (POWER(100, Exponent - 1) * 10);
                    Hundreds := 0;
                END ELSE BEGIN
                    Ones := No DIV POWER(1000, Exponent - 1);
                    Hundreds := Ones DIV 100;
                END;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text16527);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                IF No > 99999 THEN
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(100, Exponent - 1) * 10
                ELSE
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;
        END;

        IF CurrencyCode <> '' THEN BEGIN
            Currency.GET(CurrencyCode);
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + Currency.Description);
        END ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'RUPEES');

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text16528);

        TensDec := ((No * 100) MOD 100) DIV 10;
        OnesDec := (No * 100) MOD 10;
        IF TensDec >= 2 THEN BEGIN
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            IF OnesDec > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        END ELSE
            IF (TensDec * 10 + OnesDec) > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
            ELSE
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526);
        IF (CurrencyCode <> '') THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + Currency."Description" + 'ONLY')
        ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY');
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text16529, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    //[Scope('Internal')]
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
        //ExponentText[3] := Text16562;
        //ExponentText[4] := Text16563;
    end;

    procedure GetShortcutDim3Name(GLEntry: Record "G/L Entry"): Text[50]
    var
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        CostCenterName: Text[50];
    begin
        CostCenterName := '';

        if GLSetup.Get() then begin
            if GLSetup."Shortcut Dimension 3 Code" <> '' then
                if GLEntry."Shortcut Dimension 3 Code" <> '' then begin
                    if DimVal.Get(GLSetup."Shortcut Dimension 3 Code", GLEntry."Shortcut Dimension 3 Code") then
                        CostCenterName := DimVal.Name;
                end;
        end;

        exit(CostCenterName);
    end;

    procedure GetGlobalDim1Name(GLEntry: Record "G/L Entry"): Text[50]
    var
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        GlobalDim1Name: Text[50];
    begin
        GlobalDim1Name := '';

        if GLSetup.Get() then begin
            if GLSetup."Global Dimension 1 Code" <> '' then begin
                if GLEntry."Global Dimension 1 Code" <> '' then begin
                    if DimVal.Get(GLSetup."Global Dimension 1 Code", GLEntry."Global Dimension 1 Code") then
                        GlobalDim1Name := DimVal.Name;
                end;
            end;
        end;

        exit(GlobalDim1Name);
    end;


}

