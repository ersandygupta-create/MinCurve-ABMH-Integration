report 50031 "HDFC Check_M"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50031.HDFCCheckM.rdlc';
    Caption = 'Check Print HDFC - Multiple Vendor';
    Permissions = TableData 270 = m;

    dataset
    {
        dataitem(GenJnlLine; 81)
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
            RequestFilterFields = "Document No.";
            column(JnlTemplateName_GenJnlLine; "Journal Template Name")
            {
            }
            column(JnlBatchName_GenJnlLine; "Journal Batch Name")
            {
            }
            column(LineNo_GenJnlLine; "Line No.")
            {
            }
            column(TextAcPay; TextAcPay)
            {
            }
            column(YearVar; YearVar)
            {
            }
            column(MonthText; MonthText)
            {
            }
            column(DayText; DayText)
            {
            }
            column(DayText1; DayText1)
            {
            }
            column(DayText2; DayText2)
            {
            }
            column(Month1; Month1)
            {
            }
            column(Month2; Month2)
            {
            }
            column(year1; Year1)
            {
            }
            column(year2; Year2)
            {
            }
            column(year3; Year3)
            {
            }
            column(year4; Year4)
            {
            }
            column(AcPayee; AcPayee)
            {
            }
            column(CheckToAddr1; CheckToAddr[1])
            {
            }
            column(CheckDateText1; CheckDateText)
            {
            }
            column(DescriptionLine; DescriptionLine[1])
            {
            }
            column(decAmount; CheckAmountText)
            {
            }

            trigger OnAfterGetRecord()
            var
                BankAccount: Record 270;
            begin
                IF "Cheque Date" <> 0D THEN
                    CheckDateText := FORMAT("Cheque Date", 0, 4)
                ELSE
                    CheckDateText := FORMAT("Posting Date", 0, 4);

                IF ("Cheque Date" <> 0D) THEN BEGIN
                    DayVar := DATE2DMY("Cheque Date", 1);
                    IF STRLEN(FORMAT(DayVar)) = 1 THEN
                        DayText := FORMAT('0') + FORMAT(DayVar)
                    ELSE
                        DayText := FORMAT(DayVar);
                    MonthVar := DATE2DMY("Cheque Date", 2);
                    IF STRLEN(FORMAT(MonthVar)) = 1 THEN
                        MonthText := FORMAT('0') + FORMAT(MonthVar)
                    ELSE
                        MonthText := FORMAT(MonthVar);
                    YearVar := DATE2DMY("Cheque Date", 3);
                    CheckDateText := DayText + MonthText + FORMAT(YearVar);
                END ELSE BEGIN
                    DayVar := DATE2DMY("Posting Date", 1);
                    IF STRLEN(FORMAT(DayVar)) = 1 THEN
                        DayText := FORMAT('0') + FORMAT(DayVar)
                    ELSE
                        DayText := FORMAT(DayVar);
                    MonthVar := DATE2DMY("Posting Date", 2);
                    IF STRLEN(FORMAT(MonthVar)) = 1 THEN
                        MonthText := FORMAT('0') + FORMAT(MonthVar)
                    ELSE
                        MonthText := FORMAT(MonthVar);
                    YearVar := DATE2DMY("Posting Date", 3);
                    CheckDateText := DayText + MonthText + FORMAT(YearVar);
                    //CheckDateText := FORMAT(DayVar)+FORMAT(MonthVar)+FORMAT(YearVar);
                END;
                DayText1 := COPYSTR(CheckDateText, 1, 1);
                DayText2 := COPYSTR(CheckDateText, 2, 1);
                Month1 := COPYSTR(CheckDateText, 3, 1);
                Month2 := COPYSTR(CheckDateText, 4, 1);
                Year1 := COPYSTR(CheckDateText, 5, 1);
                Year2 := COPYSTR(CheckDateText, 6, 1);
                Year3 := COPYSTR(CheckDateText, 7, 1);
                Year4 := COPYSTR(CheckDateText, 8, 1);
                IF test <> '' THEN
                    CheckToAddr[1] := Test;

                decAmount := 0;
                recGenJnlLine2.RESET;
                //recGenJnlLine2.SETRANGE("Journal Template Name","Journal Batch Name");
                //recGenJnlLine2.SETRANGE("Journal Batch Name","Journal Batch Name");
                recGenJnlLine2.SETRANGE("Document No.", GenJnlLine."Document No.");
                recGenJnlLine2.SETRANGE("Posting Date", GenJnlLine."Posting Date");
                IF recGenJnlLine2.FINDFIRST THEN BEGIN
                    REPEAT
                        decAmount += recGenJnlLine2.Amount;
                    UNTIL recGenJnlLine2.NEXT = 0;
                END;
                decAmount := Round(decAmount, 1, '<');






                CheckAmountText := FORMAT(decAmount);

                UseCheckNo := INCSTR(UseCheckNo);

                BankAcc2.RESET;
                BankAcc2.SETRANGE("No.", GenJnlLine."Bal. Account No.");
                IF BankAcc2.FINDFIRST THEN BEGIN
                    BankAcc2."Last Check No." := UseCheckNo;
                    BankAcc2.MODIFY;
                END;

                //CheckReport.InitTextVariable;
                //CheckReport.FormatNoText(DescriptionLine, decAmount, 'PAISA ONLY');
                //CheckReport.FormatNoText(DescriptionLine, decAmount, '');
                InitTextVariable();
                FormatNoText(DescriptionLine, decAmount, 'PAISA ONLY');

                GenJnlLine3.RESET;
                GenJnlLine3.SETRANGE("Document No.", "Document No.");
                GenJnlLine3.SETFILTER("Cheque No.", '%1', '');
                IF GenJnlLine3.FINDFIRST THEN BEGIN
                    REPEAT
                        GenJnlLine."Cheque No." := UseCheckNo;
                        IF GenJnlLine3."Cheque No." = '' THEN
                            GenJnlLine."Cheque Date" := GenJnlLine3."Posting Date"
                        ELSE
                            GenJnlLine."Cheque Date" := GenJnlLine3."Cheque Date";
                        GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::" ";
                        GenJnlLine.MODIFY;
                    UNTIL GenJnlLine.NEXT = 0;
                END;
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
                group(Options)
                {
                    Caption = 'Options';
                    field(BankAccount; BankAcc2."No.")
                    {
                        Caption = 'Bank Account';
                        TableRelation = "Bank Account";
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the BankAccount field.';

                        trigger OnValidate()
                        begin
                            InputBankAccount;
                        end;
                    }
                    field(CurrCheck; CurrCheck)
                    {
                        Caption = 'Current Check No.';
                        Visible = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the CurrCheck field.';

                        trigger OnValidate()
                        begin
                            EVALUATE(CurrCheckInt, CurrCheck);

                            UseCheckNo := FORMAT(CurrCheckInt - 1);
                        end;
                    }
                    field(LastCheckNo; UseCheckNo)
                    {
                        Caption = 'Last Check No.';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the LastCheckNo field.';
                    }
                    field(OneCheckPerVendorPerDocumentNo; OneCheckPrVendor)
                    {
                        Caption = 'One Check per Vendor per Document No.';
                        MultiLine = true;
                        ToolTip = 'Specifies the value of the OneCheckPerVendorPerDocumentNo field.';
                        ApplicationArea = All;
                    }
                    field(ReprintChecks; ReprintChecks)
                    {
                        Caption = 'Reprint Checks';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ReprintChecks field.';
                    }
                    field(TestPrinting; TestPrint)
                    {
                        Caption = 'Test Print';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the TestPrinting field.';
                    }
                    field(PreprintedStub; PreprintedStub)
                    {
                        Caption = 'Preprinted Stub';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the PreprintedStub field.';
                    }
                    field(Test; test)
                    {
                        Caption = 'Beneficiary Name';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the BenName field.';
                    }
                    field(AcPayee; AcPayee)
                    {
                        Caption = 'Print A/C Payee';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the AcPayee field.';
                    }

                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            Test := 'YOURSELF';
        end;

        trigger OnOpenPage()
        begin
            IF BankAcc2."No." <> '' THEN
                IF BankAcc2.GET(BankAcc2."No.") THEN
                    UseCheckNo := BankAcc2."Last Check No."
                ELSE BEGIN
                    BankAcc2."No." := '';
                    UseCheckNo := '';
                END;
            //CLEAR(BeneficiaryName);
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
    end;

    trigger OnPreReport()
    begin
        IF AcPayee THEN
            TextAcPay := 'A/C PAYEE ONLY'
        ELSE
            TextAcPay := '';
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text1280000;
        ExponentText[4] := Text1280001;
    end;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[20])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
        Currency: Record Currency;
        TensDec: Integer;
        OnesDec: Integer;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '****';

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        ELSE
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
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
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

        IF CurrencyCode <> '' THEN BEGIN
            //Currency.GET(CurrencyCode);
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'RUPEES');//+ Currency."Currency Numeric Description");
        END ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'RUPEES');

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        // AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100) + '/100');

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
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text026);
        IF (CurrencyCode <> '') THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY')//+ Currency."Currency Decimal Description" + ' ONLY')
        ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY');

    end;

    local procedure GetAmtDecimalPosition(): Decimal
    var
        Currency: Record Currency;
    begin
        if GenJnlLine."Currency Code" = '' then
            Currency.InitRoundingPrecision
        else begin
            Currency.Get(GenJnlLine."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;
        exit(1 / Currency."Amount Rounding Precision");
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := true;

        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then
                Error(Text029, AddText);
        end;

        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    var
        Text000: Label 'Preview is not allowed.';
        Text001: Label 'Last Check No. must be filled in.';
        Text002: Label 'Filters on %1 and %2 are not allowed.';
        Text003: Label 'XXXXXXXXXXXXXXXX';
        Text004: Label 'must be entered.';
        Text005: Label 'The Bank Account and the General Journal Line must have the same currency.';
        Text006: Label 'Salesperson';
        Text007: Label 'Purchaser';
        Text008: Label 'Both Bank Accounts must have the same currency.';
        Text009: Label 'Our Contact';
        Text010: Label 'XXXXXXXXXX';
        Text011: Label 'XXXX';
        Text012: Label 'XX.XXXXXXXXXX.XXXX';
        Text013: Label '%1 already exists.';
        Text014: Label 'Check for %1 %2';
        Text015: Label 'Payment';
        Text016: Label 'In the Check report, One Check per Vendor and Document No.\must not be activated when Applies-to ID is specified in the journal lines.';
        Text018: Label 'XXX';
        Text019: Label 'Total';
        Text020: Label 'The total amount of check %1 is %2. The amount must be positive.';
        Text021: Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
        Text022: Label 'NON-NEGOTIABLE';
        Text023: Label 'Test print';
        Text024: Label 'XXXX.XX';
        Text025: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        Text029: Label '%1 results in a written number that is too long.';
        Text030: Label ' is already applied to %1 %2 for customer %3.';
        Text031: Label ' is already applied to %1 %2 for vendor %3.';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text059: Label 'THOUSAND';
        Text060: Label 'LAKH';
        Text061: Label 'BILLION';
        Text1280000: Label 'LAKH';
        Text1280001: Label 'CRORE';
        Month1: Text;
        Month2: Text;
        Year1: Text;
        Year2: Text;
        Year3: Text;
        Year4: Text;
        CompanyInfo: Record 79;
        SalesPurchPerson: Record 13;
        GenJnlLine2: Record 81;
        GenJnlLine3: Record 81;
        Cust: Record 18;
        CustLedgEntry: Record 21;
        Vend: Record 23;
        VendLedgEntry: Record 25;
        BankAcc: Record 270;
        BankAcc2: Record 270;
        CheckLedgEntry: Record 272;
        Currency: Record 4;
        FormatAddr: Codeunit 365;
        CheckManagement: Codeunit 367;
        CompanyAddr: array[8] of Text[50];
        CheckToAddr: array[8] of Text[50];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        BalancingType: Option "G/L Account",Customer,Vendor,"Bank Account";
        BalancingNo: Code[20];
        ContactText: Text[30];
        CheckNoText: Text[30];
        CheckDateText: Text[30];
        CheckAmountText: Text[30];
        DescriptionLine: array[2] of Text[80];
        DocType: Text[30];
        DocNo: Text[30];
        ExtDocNo: Text[35];
        VoidText: Text[30];
        LineAmount: Decimal;
        LineDiscount: Decimal;
        TotalLineAmount: Decimal;
        TotalLineDiscount: Decimal;
        RemainingAmount: Decimal;
        CurrentLineAmount: Decimal;
        UseCheckNo: Code[20];
        FoundLast: Boolean;
        ReprintChecks: Boolean;
        TestPrint: Boolean;
        FirstPage: Boolean;
        OneCheckPrVendor: Boolean;
        FoundNegative: Boolean;
        ApplyMethod: Option Payment,OneLineOneEntry,OneLineID,MoreLinesOneEntry;
        ChecksPrinted: Integer;
        HighestLineNo: Integer;
        PreprintedStub: Boolean;
        TotalText: Text[10];
        Test: Text[100];
        DocDate: Date;
        i: Integer;
        Text062: Label 'G/L Account,Customer,Vendor,Bank Account';
        CurrencyCode2: Code[10];
        NetAmount: Text[30];
        CurrencyExchangeRate: Record 330;
        LineAmount2: Decimal;
        Text063: Label 'Net Amount %1';
        GLSetup: Record 98;
        Text064: Label '%1 must not be %2 for %3 %4.';
        Text065: Label 'Subtotal';
        TDSAmount: Decimal;
        WorkTaxAmount: Decimal;
        TDSAmountLCY: Decimal;
        WorkTaxAmountLCY: Decimal;
        JnlBankCharges: Record "Journal Bank Charges";
        TempJnlBankCharges: Record "Journal Bank Charges" temporary;
        CheckNoCaptionLbl: Label 'Check No.';
        NetAmtCaptionLbl: Label 'Net Amount';
        DiscCaptionLbl: Label 'Discount';
        AmtCaptionLbl: Label 'Amount';
        DocNoCaptionLbl: Label 'Document No.';
        DocDateCaptionLbl: Label 'Document Date';
        CurrCodeCaptionLbl: Label 'Currency Code';
        YourDocNoCaptionLbl: Label 'Your Doc. No.';
        TDSCaptionLbl: Label 'TDS';
        BankChargeCaptionLbl: Label 'Bank Charge';
        TransportCaptionLbl: Label 'Transport';
        BeneficiaryName: Text[50];
        AcPayee: Boolean;
        TextAcPay: Text[30];
        CurrCheck: Code[20];
        CurrCheckInt: Integer;
        DayVar: Integer;
        YearVar: Integer;
        MonthVar: Integer;
        DayText: Text;
        MonthText: Text;
        DayText1: Text;
        DayText2: Text;
        recGenJnlLine2: Record 81;
        decAmount: Decimal;
        CheckReport: Report 1401;
        Test1: text[500];

    //[Scope('Internal')]
    procedure InputBankAccount()
    begin
        IF BankAcc2."No." <> '' THEN BEGIN
            BankAcc2.GET(BankAcc2."No.");
            BankAcc2.TESTFIELD("Last Check No.");
            UseCheckNo := BankAcc2."Last Check No.";
        END;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    begin
    end;
}

