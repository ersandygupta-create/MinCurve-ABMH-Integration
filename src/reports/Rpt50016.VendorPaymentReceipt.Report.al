report 50016 "E3 Vendor - Payment Advice"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/reports/Rpt50016.VendorPaymentReceipt.rdl';
    Caption = 'Vendor - Payment Advice';

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = SORTING("Document Type", "Vendor No.", "Posting Date", "Currency Code") WHERE("Document Type" = FILTER(Payment | ''));
            RequestFilterFields = "Vendor No.", "Posting Date", "Document No.", "Global Dimension 1 Code";
            dataitem(PageLoop; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(CompanyPicture; CompanyInfo.Picture)
                {
                }
                column(PrintedOn; 'Printed on ' + Format(Today) + ' at ' + Format(Time))
                {
                }
                column(VendAddr6; VendAddr[6])
                {
                }
                column(VendAddr7; VendAddr[7])
                {
                }
                column(VendAddr8; VendAddr[8])
                {
                }
                column(VendAddr4; VendAddr[4])
                {
                }
                column(VendAddr5; VendAddr[5])
                {
                }
                column(VendAddr3; VendAddr[3])
                {
                }
                column(VendAddr1; VendAddr[1])
                {
                }
                column(VendAddr2; VendAddr[2])
                {
                }
                column(VendorGSTNo; Vend."GST Registration No.")
                {
                }
                column(VendorPANNo; Vend."P.A.N. No.")
                {
                }
                column(VenEmail; Vend."E-Mail")
                {
                }
                column(VendNo_VendLedgEntry; "Vendor Ledger Entry"."Vendor No.")
                {
                    //IncludeCaption = true;
                }
                column(DocDate_VendLedgEntry; Format("Vendor Ledger Entry"."Document Date"))
                {
                    //IncludeCaption = true;
                }
                column(VenBankAccountNo; VenBankAccountNo)
                {
                }
                column(VenIFSCCode; VenIFSCCode)
                {
                }

                column(LocationName; LocationName)
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
                column(CompanyAddr1; RecCompanyName)//CompanyAddr[1])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CompanyAddr5; CompanyAddr[5])
                {
                }
                column(CompanyAddr6; CompanyAddr[6])
                {
                }
                column(PhoneNo; CompanyInfo."Phone No.")
                {
                }
                column(HomePage; CompanyInfo."Home Page")
                {
                }
                column(Email; CompanyInfo."E-Mail")
                {
                }
                column(VATRegistrationNo; CompanyInfo."VAT Registration No.")
                {
                }
                column(GiroNo; CompanyInfo."Giro No.")
                {
                }
                column(BankName; CompanyInfo."Bank Name")
                {
                }
                column(BankAccountNo; CompanyInfo."Bank Account No.")
                {
                }
                column(CompanyGSTNo; CompanyInfo."GST Registration No.")
                {
                }
                column(CompanyPANNo; CompanyInfo."P.A.N. No.")
                {
                }
                column(ReportTitle; ReportTitle)
                {
                }
                column(DocNo_VendLedgEntry; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(PymtDiscTitle; PaymentDiscountTitle)
                {
                }
                column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                {
                }
                column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                {
                }
                column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
                {
                }
                column(CompanyInfoBankAccNoCaption; CompanyInfoBankAccNoCaptionLbl)
                {
                }
                column(RcptNoCaption; RcptNoCaptionLbl)
                {
                }
                column(CompanyInfoVATRegNoCaption; CompanyInfoVATRegNoCaptionLbl)
                {
                }
                column(PostingDateCaption; PostingDateCaptionLbl)
                {
                }
                column(AmtCaption; AmtCaptionLbl)
                {
                }
                column(PymtAmtSpecCaption; PymtAmtSpecCaptionLbl)
                {
                }
                column(PymtTolInvCurrCaption; PymtTolInvCurrCaptionLbl)
                {
                }
                column(ChequeNo; ChequeNo)
                {
                }
                column(ChequeDate; ChequeDate)
                {
                }
                column(IssueBankName; IssueBankName)
                {
                }
                column(IssueBankAccountNo; IssueBankAccountNo)
                {
                }
                column(decTDSAmt; FORMAT(decTDSAmt))
                {
                }
                column(decPaymentAmount; FORMAT(decPaymentAmount))
                {
                }
                column(ModeofPayment; ModeofPayment)
                {
                }
                column(TotalPayment; FORMAT(ABS(decTDSAmt) + ABS(decPaymentAmount)))
                {
                }
                column(NetAmtLbl; NetAmtLbl)
                {
                }
                column(GSTAmtLbl; GSTAmtLbl)
                {
                }
                column(TDSAmtLbl; TDSAmtLbl)
                {
                }
                dataitem(DetailedVendorLedgEntry1; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Applied Vend. Ledger Entry No." = FIELD("Entry No.");
                    DataItemLinkReference = "Vendor Ledger Entry";
                    DataItemTableView = SORTING("Applied Vend. Ledger Entry No.", "Entry Type") WHERE(Unapplied = CONST(false));
                    column(AppliedVLENo_DtldVendLedgEntry; "Applied Vend. Ledger Entry No.")
                    {
                    }
                    dataitem(VendLedgEntry1; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Entry No." = FIELD("Vendor Ledger Entry No.");
                        DataItemLinkReference = DetailedVendorLedgEntry1;
                        DataItemTableView = SORTING("Entry No.");
                        RequestFilterFields = "Original Amt. (LCY)";
                        column(PostingDate_VendLedgEntry1; Format("Document Date"))
                        {
                        }
                        column(DocType_VendLedgEntry1; "Document Type")
                        {
                            IncludeCaption = true;
                        }
                        column(DocNo_VendLedgEntry1; "Document No.")
                        {
                            IncludeCaption = true;
                        }
                        column(Description_VendLedgEntry1; Description)
                        {
                            IncludeCaption = true;
                        }
                        column(OriginalAmtLCY; ABS(decLineAmount))
                        {
                        }
                        column(NegShowAmountVendLedgEntry1; -NegShowAmountVendLedgEntry1)
                        {
                        }
                        column(CurrCode_VendLedgEntry1; CurrencyCode("Currency Code"))
                        {
                        }
                        column(NegPmtDiscInvCurrVendLedgEntry1; -NegPmtDiscInvCurrVendLedgEntry1)
                        {
                        }
                        column(NegPmtTolInvCurrVendLedgEntry1; -NegPmtTolInvCurrVendLedgEntry1)
                        {
                        }
                        column(InvTDSAmt; InvTDSAmt)
                        {
                        }
                        column(decInvGSTAmount; decInvGSTAmount)
                        {
                        }
                        column(decAppAmt; decAppAmt)
                        {
                        }
                        column(ExtDocNo; "External Document No.")
                        {
                        }

                        trigger OnAfterGetRecord()

                        begin
                            Docdate := "Vendor Ledger Entry"."Document Date";

                            if "Entry No." = "Vendor Ledger Entry"."Entry No." then
                                CurrReport.Skip;

                            NegPmtDiscInvCurrVendLedgEntry1 := 0;
                            NegPmtTolInvCurrVendLedgEntry1 := 0;
                            PmtDiscPmtCurr := 0;
                            PmtTolPmtCurr := 0;

                            NegShowAmountVendLedgEntry1 := -DetailedVendorLedgEntry1.Amount;

                            if "Vendor Ledger Entry"."Currency Code" <> "Currency Code" then begin
                                NegPmtDiscInvCurrVendLedgEntry1 := Round("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1 := Round("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                AppliedAmount :=
                                  Round(
                                    -DetailedVendorLedgEntry1.Amount / "Original Currency Factor" * "Vendor Ledger Entry"."Original Currency Factor",
                                    Currency."Amount Rounding Precision");
                            end else begin
                                NegPmtDiscInvCurrVendLedgEntry1 := Round("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1 := Round("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                AppliedAmount := -DetailedVendorLedgEntry1.Amount;
                            end;

                            PmtDiscPmtCurr := Round("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");

                            PmtTolPmtCurr := Round("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");

                            RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;

                            InvTDSAmt := 0;
                            TDSEntry.Reset;
                            TDSEntry.SetRange("Document No.", VendLedgEntry1."Document No.");
                            TDSEntry.SetRange("Vendor No.", VendLedgEntry1."Vendor No.");
                            TDSEntry.SETRANGE("Section", VendLedgEntry1."TDS Section Code");
                            if TDSEntry.FindFirst then begin
                                InvTDSAmt := Abs(TDSEntry."TDS Amount");
                            end;

                            decAppAmt := 0;
                            DetailedVendorLedgEntry.RESET;
                            DetailedVendorLedgEntry.SETRANGE("Vendor Ledger Entry No.", "Entry No.");
                            DetailedVendorLedgEntry.SETRANGE("Vendor No.", "Vendor No.");
                            IF DetailedVendorLedgEntry.FINDFIRST THEN BEGIN
                                decAppAmt += Abs(DetailedVendorLedgEntry."Amount (LCY)");
                            END;

                            decInvGSTAmount := 0;
                            DetailedGSTLedgerEntry.Reset;
                            DetailedGSTLedgerEntry.SetRange("Document No.", VendLedgEntry1."Document No.");
                            DetailedGSTLedgerEntry.SetRange("Source Type", DetailedGSTLedgerEntry."Source Type"::Vendor);
                            DetailedGSTLedgerEntry.SetRange("Source No.", VendLedgEntry1."Vendor No.");
                            DetailedGSTLedgerEntry.SetRange("GST Vendor Type", VendLedgEntry1."GST Vendor Type"::Registered);
                            if DetailedGSTLedgerEntry.FindFirst then begin
                                repeat
                                    decInvGSTAmount += ABS(DetailedGSTLedgerEntry."GST Amount");
                                until DetailedGSTLedgerEntry.Next = 0;
                            end;

                            decLineAmount := 0;
                            decGSTAmount := 0;
                            decTDSAmount := 0;
                            PurchInvHdr.Reset();
                            PurchInvHdr.SetRange("No.", VendLedgEntry1."Document No.");
                            PurchInvHdr.SetRange("Pay-to Vendor No.", VendLedgEntry1."Vendor No.");
                            IF PurchInvHdr.FindFirst() THEN begin
                                PurchInvHdr.CalcFields(PurchInvHdr.Amount);
                                decLineAmount := PurchInvHdr.Amount;
                                CalcStatistics.OnGetPurchInvHeaderGSTAmount(PurchInvHdr, decGSTAmount);
                                CalcStatistics.OnGetPurchInvHeaderTDSAmount(PurchInvHdr, decTDSAmount);

                                decAmountLCYVLE := 0;
                                vendorLedgerEntry.Reset();
                                vendorLedgerEntry.SetFilter(vendorLedgerEntry."Vendor No.", PurchInvHdr."Buy-from Vendor No.");
                                vendorLedgerEntry.SetRange(vendorLedgerEntry."Purchase Order No.", PurchInvHdr."Vendor Order No.");
                                vendorLedgerEntry.SetFilter(vendorLedgerEntry."E3 Payment Terms Code", '<>%1', '');
                                vendorLedgerEntry.CalcFields("amount (LCY)");
                                vendorLedgerEntry.SetFilter("amount (LCY)", '<>%1', 0);
                                IF vendorLedgerEntry.FindFirst() then begin
                                    repeat
                                        vendorLedgerEntry.CalcFields(vendorLedgerEntry."amOunT (LCY)");
                                        decAmountLCYVLE := vendorLedgerEntry."amount (LCY)";
                                    until vendorLedgerEntry.Next() = 0;
                                end;
                            end;
                        end;
                    }
                }
                dataitem(DetailedVendorLedgEntry2; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    DataItemLinkReference = "Vendor Ledger Entry";
                    DataItemTableView = SORTING("Vendor Ledger Entry No.", "Entry Type", "Posting Date") WHERE(Unapplied = CONST(false));
                    column(VLENo_DtldVendLedgEntry; "Vendor Ledger Entry No.")
                    {
                    }
                    dataitem(VendLedgEntry2; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Entry No." = FIELD("Applied Vend. Ledger Entry No.");
                        DataItemLinkReference = DetailedVendorLedgEntry2;
                        CalcFields = "Original Amt. (LCY)";
                        DataItemTableView = SORTING("Entry No.");
                        column(NegAppliedAmt; -AppliedAmount)
                        {
                        }
                        column(Description_VendLedgEntry2; Description)
                        {
                        }
                        column(DocNo_VendLedgEntry2; "Document No.")
                        {
                        }
                        column(DocType_VendLedgEntry2; "Document Type")
                        {
                        }
                        column(AppliedOriginal; ABS(decLineAmount))
                        {
                        }
                        column(PostingDate_VendLedgEntry2; Format("Posting Date"))
                        {
                        }
                        column(CurrCode_VendLedgEntry2; CurrencyCode("Currency Code"))
                        {
                        }
                        column(NegPmtDiscInvCurrVendLedgEntry2; -NegPmtDiscInvCurrVendLedgEntry1)
                        {
                        }
                        column(NegPmtTolInvCurr1VendLedgEntry2; -NegPmtTolInvCurrVendLedgEntry1)
                        {
                        }
                        column(decAppliedGSTAmount; decAppliedGSTAmount)
                        {
                        }
                        column(AppliedTDSAmt; AppliedTDSAmt)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if "Entry No." = "Vendor Ledger Entry"."Entry No." then
                                CurrReport.Skip();

                            NegPmtDiscInvCurrVendLedgEntry1 := 0;
                            NegPmtTolInvCurrVendLedgEntry1 := 0;
                            PmtDiscPmtCurr := 0;
                            PmtTolPmtCurr := 0;

                            NegShowAmountVendLedgEntry1 := DetailedVendorLedgEntry2.Amount;

                            if "Vendor Ledger Entry"."Currency Code" <> "Currency Code" then begin
                                NegPmtDiscInvCurrVendLedgEntry1 := Round("Pmt. Disc. Rcd.(LCY)" * "Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1 := Round("Pmt. Tolerance (LCY)" * "Original Currency Factor");
                            end else begin
                                NegPmtDiscInvCurrVendLedgEntry1 := Round("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1 := Round("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                            end;

                            PmtDiscPmtCurr := Round("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");

                            PmtTolPmtCurr := Round("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");

                            AppliedAmount := DetailedVendorLedgEntry2.Amount;
                            RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;

                            AppliedTDSAmt := 0;
                            TDSEntry.Reset();
                            TDSEntry.SetRange("Document No.", VendLedgEntry2."Document No.");
                            TDSEntry.SetRange("Vendor No.", VendLedgEntry2."Vendor No.");
                            TDSEntry.SETRANGE("Section", VendLedgEntry2."TDS Section Code");
                            if TDSEntry.FindFirst() then
                                AppliedTDSAmt := Abs(TDSEntry."TDS Amount");

                            decAppliedGSTAmount := 0;
                            DetailedGSTLedgerEntry.Reset();
                            DetailedGSTLedgerEntry.SetRange("Document No.", VendLedgEntry2."Document No.");
                            DetailedGSTLedgerEntry.SetRange("Source Type", DetailedGSTLedgerEntry."Source Type"::Vendor);
                            DetailedGSTLedgerEntry.SetRange("Source No.", VendLedgEntry2."Vendor No.");
                            if DetailedGSTLedgerEntry.FindFirst() then
                                repeat
                                    decAppliedGSTAmount += ABS(DetailedGSTLedgerEntry."GST Amount");
                                until DetailedGSTLedgerEntry.Next() = 0;

                            decLineAmount := 0;
                            decGSTAmount := 0;
                            decTDSAmount := 0;
                            PurchInvHdr.Reset();
                            PurchInvHdr.SetRange("No.", VendLedgEntry2."Document No.");
                            PurchInvHdr.SetRange("Pay-to Vendor No.", VendLedgEntry2."Vendor No.");
                            IF PurchInvHdr.FindFirst() THEN begin
                                CalcStatistics.GetPostedPurchInvStatisticsAmount(PurchInvHdr, decLineAmount);
                                CalcStatistics.OnGetPurchInvHeaderGSTAmount(PurchInvHdr, decGSTAmount);
                                CalcStatistics.OnGetPurchInvHeaderTDSAmount(PurchInvHdr, decTDSAmount);
                            end;
                        end;
                    }
                }
                dataitem(Total; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(NegRemainingAmt; -RemainingAmount)
                    {
                    }
                    column(CurrCode_VendLedgEntry; CurrencyCode("Vendor Ledger Entry"."Currency Code"))
                    {
                    }
                    column(NegOriginalAmt_VendLedgEntry; -"Vendor Ledger Entry"."Original Amount")
                    {
                    }
                    column(ExtDocNo_VendLedgEntry; "Vendor Ledger Entry"."External Document No.")
                    {
                    }
                    column(PymtAmtNotAllocatedCaption; PymtAmtNotAllocatedCaptionLbl)
                    {
                    }
                    column(PymtAmtCaption; PymtAmtCaptionLbl)
                    {
                    }
                    column(ExternalDocNoCaption; ExternalDocNoCaptionLbl)
                    {
                    }
                    column(AmtWords; AmtWords[1])
                    {
                    }


                }
            }

            trigger OnAfterGetRecord()
            begin
                Vend.Get("Vendor No.");
                FormatAddr.Vendor(VendAddr, Vend);
                if not Currency.Get("Currency Code") then
                    Currency.InitRoundingPrecision;

                ReportTitle := Text004;

                CalcFields("Original Amount");
                RemainingAmount := -"Original Amount";

                ChequeNo := '';
                ChequeDate := 0D;
                IssueBankName := '';
                IssueBankAccountNo := '';
                decPaymentAmount := 0;
                BankAccountLedgerEntry.Reset();
                BankAccountLedgerEntry.SetRange("Document Type", "Document Type");
                BankAccountLedgerEntry.SetRange("Document No.", "Document No.");
                if BankAccountLedgerEntry.FindFirst() then begin
                    decPaymentAmount := Abs(BankAccountLedgerEntry."Amount (LCY)");
                    ChequeNo := BankAccountLedgerEntry."Cheque No." + '' + BankAccountLedgerEntry."E3 UTR No.";
                    ChequeDate := BankAccountLedgerEntry."Cheque Date";
                    if BankAccount.Get(BankAccountLedgerEntry."Bank Account No.") then
                        IssueBankName := BankAccount.Name;
                    IssueBankAccountNo := BankAccount."Bank Account No.";
                    if BankAccountLedgerEntry."Cheque No." <> '' then
                        ModeofPayment := 'CHEQUE'
                    else
                        if BankAccountLedgerEntry."E3 UTR No." <> '' then
                            ModeofPayment := 'Online Transfer'
                        else
                            ModeofPayment := '';
                end;

                LocationAdd := '';
                LocationEmail := '';
                LocationPhoneNo := '';
                LocationGSTIN := '';
                LocationName := '';
                IF "Vendor Ledger Entry"."Location Code" <> '' THEN BEGIN
                    Location.RESET;
                    Location.SETRANGE(Code, "Vendor Ledger Entry"."Location Code");
                    IF Location.FINDFIRST THEN BEGIN
                        LocationName := Location.Name;
                        LocationAdd := Location.Address + ', ' + Location."Address 2" + ', ' + Location.City + ', ' + FORMAT(Location."Post Code");
                        LocationEmail := Location."E-Mail";
                        LocationPhoneNo := Location."Phone No.";
                        LocationGSTIN := Location."GST Registration No.";
                        LocationWebsite := Location."Home Page";
                    END;
                end;

                VendorBank.Reset();
                VendorBank.SetRange("Vendor No.", "Vendor No.");
                if VendorBank.FindFirst() then
                    VenBankAccountNo := (VendorBank."Bank Account No.");
                VenIFSCCode := (VendorBank."Bank Clearing Code");


                decTDSAmt := 0;
                TDSEntry.Reset;
                TDSEntry.SetRange("Document Type", "Document Type");
                TDSEntry.SetRange("Document No.", "Document No.");
                TDSEntry.SetRange("Vendor No.", "Vendor No.");
                TDSEntry.SetRange(Section, "TDS Section Code");
                if TDSEntry.FindFirst() then
                    decTDSAmt := Abs(TDSEntry."TDS Amount");

                TotalAppliedAmount := 0;
                TotalVendorLedgerEntry.Reset();
                TotalVendorLedgerEntry.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
                TotalVendorLedgerEntry.SetRange("Vendor No.", "Vendor Ledger Entry"."Vendor No.");
                IF TotalVendorLedgerEntry.FindFirst() then
                    repeat
                        TotalVendorLedgerEntry.CalcFields(TotalVendorLedgerEntry."Original Amt. (LCY)");
                        TotalAppliedAmount += TotalVendorLedgerEntry."Original Amt. (LCY)";
                    until TotalVendorLedgerEntry.Next() = 0;

                PostedVoucher.InitTextVariable();
                PostedVoucher.FormatNoText(AmtWords, Abs(TotalAppliedAmount), "Currency Code");
                if ("Vendor Ledger Entry"."Posting Date" < CompanyInfo."Transaction Date") then
                    RecCompanyName := CompanyInfo."Old Comapany Name"
                else
                    RecCompanyName := CompanyInfo.Name;

            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                GLSetup.Get();
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
        CurrencyCodeCaption = 'Currency Code';
        PageCaption = 'Page';
        DocDateCaption = 'Document Date';
        EmailCaption = 'E-Mail';
        HomePageCaption = 'Home Page';
    }

    var
        BankAccount: Record "Bank Account";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        CompanyInfo: Record "Company Information";
        Currency: Record Currency;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        PurchInvHdr: Record "Purch. Inv. Header";
        TDSEntry: Record "TDS Entry";
        Vend: Record Vendor;
        TotalVendorLedgerEntry: Record "Vendor Ledger Entry";
        PostedVoucher: Report "Posted Voucher";
        CalcStatistics: Codeunit "Calculate Statistics";
        FormatAddr: Codeunit "Format Address";
        ChequeNo: Code[60];
        ChequeDate: Date;
        AppliedAmount: Decimal;
        AppliedTDSAmt: Decimal;
        decAppliedGSTAmount: Decimal;
        decGSTAmount: Decimal;
        decInvGSTAmount: Decimal;
        decLineAmount: Decimal;
        decPaymentAmount: Decimal;
        decTDSAmount: Decimal;
        decTDSAmt: Decimal;
        InvTDSAmt: Decimal;
        NegPmtDiscInvCurrVendLedgEntry1: Decimal;
        NegPmtTolInvCurrVendLedgEntry1: Decimal;
        NegShowAmountVendLedgEntry1: Decimal;
        PmtDiscPmtCurr: Decimal;
        PmtTolPmtCurr: Decimal;
        RemainingAmount: Decimal;
        TotalAppliedAmount: Decimal;
        AmtCaptionLbl: label 'Applied Amt';
        CompanyInfoBankAccNoCaptionLbl: label 'Account No.';
        CompanyInfoBankNameCaptionLbl: label 'Bank';
        CompanyInfoGiroNoCaptionLbl: label 'Giro No.';
        CompanyInfoPhoneNoCaptionLbl: label 'Phone No.';
        CompanyInfoVATRegNoCaptionLbl: label 'GST Registration No.';
        ExternalDocNoCaptionLbl: label 'External Document No.';
        GSTAmtLbl: label 'GST Amt';
        NetAmtLbl: label 'Net Amt';
        PostingDateCaptionLbl: label 'Posting Date';
        PymtAmtCaptionLbl: label 'Total Amount';
        PymtAmtNotAllocatedCaptionLbl: label 'Payment Amount Not Allocated';
        PymtAmtSpecCaptionLbl: label 'Payment Amount Specification';
        PymtTolInvCurrCaptionLbl: label 'Payment Tolerance';
        RcptNoCaptionLbl: label 'Receipt No. : ';
        TDSAmtLbl: label 'TDS Amt';
        Text003: label 'Payment Receipt';
        Text004: label 'Payment Advice';
        Text006: label 'Payment Discount Given';
        Text007: label 'Payment Discount Received';
        IssueBankAccountNo: Text;
        IssueBankName: Text;
        ModeofPayment: Text;
        PaymentDiscountTitle: Text[30];
        ReportTitle: Text[30];
        CompanyAddr: array[8] of Text[50];
        VendAddr: array[8] of Text[50];
        AmtWords: array[2] of Text[1000];
        RecCompanyName: Code[100];
        Location: Record Location;
        LocationName: Text[100];
        LocationEmail: Code[100];
        LocationPhoneNo: Code[50];
        LocationGSTIN: Code[15];
        LocationWebsite: Text[200];
        LocationAdd: Code[200];
        VendorBank: Record "Vendor Bank Account";
        VenBankAccountNo: Text[30];
        VenIFSCCode: Text[20];
        vendorLedgerEntry: Record "Vendor Ledger Entry";
        decAmountLCYVLE: Decimal;
        NetdecLineAmount: Decimal;
        decAppAmt: Decimal;
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        VLE: Record "Vendor Ledger Entry";
        Docdate: Date;


    local procedure CurrencyCode(SrcCurrCode: Code[10]): Code[10]
    begin
        if SrcCurrCode = '' then
            exit(GLSetup."LCY Code");

        exit(SrcCurrCode);
    end;
}

