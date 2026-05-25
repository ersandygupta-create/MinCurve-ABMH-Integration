report 50012 "Customer Ledger Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50012.CustomerLedgerReport.rdlc';
    Caption = 'Customer Account Statement';
    ApplicationArea = aLL;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Location Code", "Customer Posting Group", "Date Filter";
            column(CompanyPAN; RecCompanyInfo."P.A.N. No.")
            {
            }
            column(CompanyInfoName; RecCompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress1; RecCompanyInfo.Address)
            {
            }
            column(Comapny_Logo; RecCompanyInfo.Picture)
            {

            }
            column(CompanyInfoAddress2; RecCompanyInfo."Address 2")
            {
            }
            column(CompanyInfoCity; RecCompanyInfo.City)
            {
            }

            column(CompanyInfoPostCode; RecCompanyInfo."Post Code")
            {
            }
            column(CompanyInfoPhoneNo2; RecCompanyInfo."Phone No. 2")
            {
            }
            column(CompanyInfoCINNO; RecCompanyInfo."CIN No.")
            {
            }
            column(CompanyInfoTanNo; RecCompanyInfo."T.A.N. No.")
            {
            }
            column(CompanyInfoGSTNo; RecCompanyInfo."GST Registration No.")
            {
            }
            column(TodayFormatted; Format(Today))
            {
            }
            column(PageNo; CurrReport.PageNo())
            {
            }
            column(PeriodCustDatetFilter; StrSubstNo(Text000, CustDateFilter))
            {
            }
            column(CustomerFilter; Customer.GetFilters)
            {
            }
            column(Address1; Customer.Address)
            {
            }
            column(Address2; Customer."Address 2")
            {
            }
            column(PostCode; Customer."Post Code")
            {
            }
            column(City; Customer.City)
            {
            }
            column(Email; Customer."E-Mail")
            {
            }
            column(CustGST; Customer."GST Registration No.")
            {
            }
            column(CompanyName; RecCompanyInfo.Name)
            {
            }
            column(PrintAmountsInLCY; PrintAmountsInLCY)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(CustFilterCaption; TableCaption + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(AmountCaption; AmountCaption)
            {
            }
            column(RemainingAmtCaption; RemainingAmtCaption)
            {
            }
            column(No_Cust; "No.")
            {
            }
            column(Name_Cust; Name)
            {
            }
            column(Cust_City; Customer.City)
            {
            }
            column(State_Code; '( ' + Customer."State Code" + ' )')
            {
            }
            column(PhoneNo_Cust; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(StartBalanceLCY; StartBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceLCY; CustBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(CustLedgerEntryAmtLCY; "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCYAdjLCY; StartBalanceLCY + StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(StrtBalLCYCustLedgEntryAmt; StartBalanceLCY + "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(CustDetailTrialBalCaption; CustDetailTrialBalCaptionLbl)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(AllAmtsLCYCaption; AllAmtsLCYCaptionLbl)
            {
            }
            column(RepInclCustsBalCptn; RepInclCustsBalCptnLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(BalanceLCYCaption; BalanceLCYCaptionLbl)
            {
            }
            column(AdjOpeningBalCaption; AdjOpeningBalCaptionLbl)
            {
            }
            column(BeforePeriodCaption; BeforePeriodCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(OpeningBalCaption; OpeningBalCaptionLbl)
            {
            }
            column(OpeningBalance; StartBalanceLCY)
            {
            }
            column(TotalCreditAmt; TotalCreditAmt)
            {
            }
            column(TotalDebitAmt; TotalDebitAmt)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Date Filter" = FIELD("Date Filter");
                DataItemTableView = SORTING("Customer No.", "Posting Date");
                RequestFilterFields = "Document No.";
                column(PostDate_CustLedgEntry; Format("Posting Date"))
                {
                }
                column(DocType_CustLedgEntry; "Document Type")
                {
                    IncludeCaption = true;
                    OptionCaption = ' ,Receipt,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund>';
                    OptionMembers = " ",Receipt,Invoice,"Credit Memo","Finance Charge Memo",Reminder,"Refund>";
                }
                column(DocNo_CustLedgEntry; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(E3_UHID; "E3 UHID")
                {
                }
                column(E3_Patient_Name; "E3 Patient Name")
                {
                }

                column(Desc_CustLedgEntry; txtDescription)
                {
                    IncludeCaption = false;
                }
                column(CustAmount; CustAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(decTDSBaseAmount; decTDSBaseAmount)
                {

                }
                column(decTDSAmount; decTDSAmount)
                {

                }
                column(CustRemainAmount; CustRemainAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustEntryDueDate; Format(CustEntryDueDate))
                {
                }
                column(EntryNo_CustLedgEntry; "Entry No.")
                {
                    IncludeCaption = true;
                }
                column(CustCurrencyCode; CustCurrencyCode)
                {
                }
                column(CustBalanceLCY1; CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(DebitAmt; decDebitAmt)
                {
                }
                column(CreditAmt; decCreditAmt)
                {
                }
                column(ExtDocNo; "External Document No.")
                {
                }
                column(ChequeNo; txtChequeNo + '' + UTR)
                {
                }
                column(ChequeDate; dtChequeDate)
                {
                }
                column(CdShiptoCode; CdShiptoCode)
                {
                }
                column(CdShiptoName; CdShiptoName)
                {
                }
                column(SalesExternalDocNo; CdExternaDocNo)
                {
                }
                column(NarrationLine; txtNarration)
                {
                }
                column(txtBalType; txtBalType)
                {
                }
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = CONST(Item));
                    column(ShowItem; ShowItems)
                    {
                    }
                    column(Item_No; "Sales Invoice Line"."No.")
                    {
                    }
                    column(Item_Name; "Sales Invoice Line".Description)
                    {
                    }
                    column(Itm_ModelNo; "Sales Invoice Line"."Description 2")
                    {
                    }
                    column(Itm_Qty; "Sales Invoice Line".Quantity)
                    {
                    }
                    column(Item_UnitPrice; "Sales Invoice Line"."Unit Price")
                    {
                    }
                    column(SILLineAmount; "Sales Invoice Line"."Line Amount")
                    {
                    }
                    column(SILTaxAmt; decSaleGSTAmount)
                    {
                    }
                    column(Itm_UOM; "Sales Invoice Line"."Unit of Measure Code")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CurrReport.ShowOutput(ShowItems);
                        if ("Cust. Ledger Entry"."Document Type" <> "Cust. Ledger Entry"."Document Type"::Invoice) or (not ShowItems) then
                            CurrReport.Break;

                        SalesInvHdr.Get("Sales Invoice Line"."Document No.");
                        CalcStatistics.OnGetSalesInvHeaderGSTAmount(SalesInvHdr, decSaleGSTAmount);



                    end;
                }
                dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                {
                    DataItemLink = "Document No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = CONST(Item));
                    column(SCMShowItem; ShowItems)
                    {
                    }
                    column(SCMItem_No; "Sales Cr.Memo Line"."No.")
                    {
                    }
                    column(SCMItem_Name; "Sales Cr.Memo Line".Description)
                    {
                    }
                    column(SCMItm_ModelNo; "Sales Cr.Memo Line"."Description 2")
                    {
                    }
                    column(SCMItm_Qty; "Sales Cr.Memo Line".Quantity)
                    {
                    }
                    column(SCMItem_UnitPrice; Abs((("Sales Cr.Memo Line"."Unit Price") * "Sales Cr.Memo Line"."Line Discount %" / 100) - "Sales Cr.Memo Line"."Unit Price"))
                    {
                    }
                    column(SCMLineAmt; "Sales Cr.Memo Line"."Line Amount")
                    {
                    }
                    column(SCMTaxAmt; decSaleCrGSTAmount)
                    {
                    }
                    column(SCMItm_UOM; "Sales Cr.Memo Line"."Unit of Measure Code")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CurrReport.ShowOutput(ShowItems);
                        if ("Cust. Ledger Entry"."Document Type" <> "Cust. Ledger Entry"."Document Type"::"Credit Memo") or (not ShowItems) then
                            CurrReport.Break;

                        SalesCrMemoHdr.Get("Sales Cr.Memo Line"."Document No.");
                        CalcStatistics.OnGetSalesCrMemoHeaderGSTAmount(SalesCrMemoHdr, decSaleCrGSTAmount);

                    end;
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Entry Type", "Posting Date") WHERE("Entry Type" = FILTER("Appln. Rounding" | "Correction of Remaining Amount"));
                    column(EntryType_DtldCustLedgEntry; Format("Entry Type"))
                    {
                    }
                    column(Correction; Correction)
                    {
                        AutoFormatType = 1;
                    }
                    column(CustBalanceLCY2; CustBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(ApplicationRounding; ApplicationRounding)
                    {
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        case "Entry Type" of
                            "Entry Type"::"Appln. Rounding":
                                ApplicationRounding := ApplicationRounding + "Amount (LCY)";
                            "Entry Type"::"Correction of Remaining Amount":
                                Correction := Correction + "Amount (LCY)";
                        end;


                        Correction := Correction + "Amount (LCY)";
                        CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetFilter("Posting Date", CustDateFilter);
                        Correction := 0;
                        ApplicationRounding := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CalcFields(Amount, "Remaining Amount", "Amount (LCY)", "Original Amt. (LCY)", "Remaining Amt. (LCY)");
                    decCreditAmt := 0;
                    decDebitAmt := 0;
                    CustLedgEntryExists := true;
                    CustAmount := "Original Amt. (LCY)";
                    CustRemainAmount := "Remaining Amt. (LCY)";
                    CustCurrencyCode := '';


                    decTDSBaseAmount := 0;
                    decTDSAmount := 0;

                    TDSEntry.Reset();
                    TDSEntry.SetRange("Document No.", "Cust. Ledger Entry"."Document No.");
                    TDSEntry.SetRange("Transaction No.", "Cust. Ledger Entry"."Transaction No.");
                    IF TDSEntry.FindFirst() then begin
                        decTDSBaseAmount := TDSEntry."TDS Base Amount";
                        decTDSAmount := TDSEntry."TDS Amount";
                    end;


                    if ("Cust. Ledger Entry"."Original Amt. (LCY)" < 0) then
                        decCreditAmt := "Cust. Ledger Entry"."Original Amt. (LCY)"
                    else
                        decDebitAmt := "Cust. Ledger Entry"."Original Amt. (LCY)";

                    CustBalanceLCY := CustBalanceLCY + "Original Amt. (LCY)";

                    if ("Document Type" = "Document Type"::Payment) or ("Document Type" = "Document Type"::Refund) then
                        CustEntryDueDate := 0D
                    else
                        CustEntryDueDate := "Due Date";


                    txtChequeNo := '';
                    dtChequeDate := 0D;
                    recBankAccountLedgerEntry.Reset;
                    recBankAccountLedgerEntry.SetRange("Document No.", "Document No.");
                    recBankAccountLedgerEntry.SetRange("Posting Date", "Posting Date");
                    recBankAccountLedgerEntry.SetRange("Transaction No.", "Transaction No.");
                    if recBankAccountLedgerEntry.FindFirst() then begin
                        txtChequeNo := recBankAccountLedgerEntry."Cheque No.";
                        dtChequeDate := recBankAccountLedgerEntry."Cheque Date";
                    end;

                    UTR := '';
                    recGLEntry.Reset;
                    recGLEntry.SetRange("Document No.", "Document No.");
                    recGLEntry.SetRange("Posting Date", "Posting Date");
                    recGLEntry.SetRange("Transaction No.", "Transaction No.");
                    if recGLEntry.FindFirst then begin
                        UTR := recGLEntry."E3 UTR No.";
                    end;

                    CdShiptoCode := '';
                    CdShiptoName := '';
                    CdExternaDocNo := '';
                    recSalesInvHdr.Reset;
                    recSalesInvHdr.SetRange("No.", "Document No.");
                    recSalesInvHdr.SetRange("Sell-to Customer No.", "Customer No.");
                    if recSalesInvHdr.Find('-') then begin
                        if recSalesInvHdr."Ship-to Code" <> '' then begin
                            CdShiptoCode := recSalesInvHdr."Ship-to Code";
                            CdShiptoName := '/ ' + recSalesInvHdr."Ship-to Name";
                        end;
                        CdExternaDocNo := recSalesInvHdr."External Document No."
                    end;

                    txtBalType := '';
                    if CustBalanceLCY < 0 then
                        txtBalType := 'Cr.'
                    else
                        txtBalType := 'Dr.';

                    txtNarration := '';
                    recPostedNarration.SetFilter("Document No.", "Document No.");
                    recPostedNarration.SetRange("Transaction No.", "Transaction No.");
                    if PrintNarrationLine then
                        if recPostedNarration.Find('-') then
                            repeat
                                txtNarration := txtNarration + recPostedNarration.Narration;
                            until recPostedNarration.Next = 0;

                    txtComment := '';
                    recPostedNarration.Reset;
                    recPostedNarration.SetRange("Document No.", "Document No.");
                    if recPostedNarration.Find('-') then
                        repeat
                            txtComment += CopyStr(recPostedNarration.Narration, 1, 1024);
                        until recPostedNarration.Next = 0;

                    txtDescription := '';

                    if "Cust. Ledger Entry".Amount > 0 then begin
                        recGLEntry.Reset;
                        recGLEntry.SetCurrentKey("Document No.", "Posting Date");
                        recGLEntry.SetRange("Document No.", "Cust. Ledger Entry"."Document No.");
                        recGLEntry.SetRange("Posting Date", "Cust. Ledger Entry"."Posting Date");
                        recGLEntry.SetFilter(Amount, '<0');
                        if recGLEntry.Find('-') then;
                        /*
                          IF recGLEntry."Source Type" = recGLEntry."Source Type"::Customer THEN
                          BEGIN
                            recCustomer.GET(recGLEntry."Source No.");
                            txtDescription := recCustomer.Name;
                          END
                        */

                        if recGLEntry."Source Type" = recGLEntry."Source Type"::Vendor then begin
                            recVendor.Get(recGLEntry."Source No.");
                            txtDescription := recVendor.Name;
                        end

                        else
                            if recGLEntry."Source Type" = recGLEntry."Source Type"::"Bank Account" then begin
                                recBank.Get(recGLEntry."Source No.");
                                txtDescription := recBank.Name;
                            end
                            else begin
                                if recGLAccount.Get(recGLEntry."G/L Account No.") then
                                    txtDescription := recGLAccount.Name;
                            end;
                    end
                    else begin
                        recGLEntry.Reset;
                        recGLEntry.SetCurrentKey("Document No.", "Posting Date");
                        recGLEntry.SetRange("Document No.", "Cust. Ledger Entry"."Document No.");
                        recGLEntry.SetRange("Posting Date", "Cust. Ledger Entry"."Posting Date");
                        recGLEntry.SetFilter(Amount, '>0');
                        if recGLEntry.Find('-') then;
                        /*
                          IF recGLEntry."Source Type" = recGLEntry."Source Type"::Customer THEN
                          BEGIN
                            recCustomer.GET(recGLEntry."Source No.");
                            txtDescription := recCustomer.Name;
                          END
                         */
                        if recGLEntry."Source Type" = recGLEntry."Source Type"::Vendor then begin
                            recVendor.Get(recGLEntry."Source No.");
                            txtDescription := recVendor.Name;
                        end
                        else
                            if recGLEntry."Source Type" = recGLEntry."Source Type"::"Bank Account" then begin
                                recBank.Get(recGLEntry."Source No.");
                                txtDescription := recBank.Name;
                            end
                            else begin
                                if recGLAccount.Get(recGLEntry."G/L Account No.") then
                                    txtDescription := recGLAccount.Name;
                            end;
                    end;

                    txtData[1] := Customer."No.";
                    txtData[2] := Customer.Name;
                    txtData[3] := Format("Posting Date");
                    txtData[4] := Format("Document Type");
                    txtData[5] := "Document No.";
                    txtData[6] := txtDescription;
                    txtData[7] := "External Document No.";
                    txtData[8] := txtChequeNo;
                    txtData[9] := Format(dtChequeDate);
                    txtData[10] := '';
                    txtData[11] := '';
                    if ("Cust. Ledger Entry"."Original Amt. (LCY)" < 0) then
                        txtData[11] := Format(Abs("Cust. Ledger Entry"."Original Amt. (LCY)"))
                    else
                        txtData[10] := Format(Abs("Cust. Ledger Entry"."Original Amt. (LCY)"));
                    txtData[12] := Format("Remaining Amount");
                    txtData[13] := Format(CustBalanceLCY);
                    if StrLen(txtComment) > 250 then
                        txtData[14] := CopyStr(txtComment, 1, 250)
                    else
                        txtData[14] := Format(txtComment);

                end;

                trigger OnPreDataItem()
                begin
                    CustLedgEntryExists := false;
                    CurrReport.CreateTotals(CustAmount, "Amount (LCY)");
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(Name1_Cust; Customer.Name)
                {
                }
                column(CustBalanceLCY4; CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(StartBalanceLCY2; StartBalanceLCY)
                {
                }
                column(StartBalAdjLCY2; StartBalAdjLCY)
                {
                }
                column(CustBalStBalStBalAdjLCY; CustBalanceLCY - StartBalanceLCY - StartBalAdjLCY)
                {
                    AutoFormatType = 1;
                }

                trigger OnAfterGetRecord()
                begin
                    if not CustLedgEntryExists and ((StartBalanceLCY = 0) or ExcludeBalanceOnly) then begin
                        StartBalanceLCY := 0;
                        CurrReport.Skip;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if PrintOnlyOnePerPage then
                    PageGroupNo := PageGroupNo + 1;
                CurrReport.CreateTotals("Cust. Ledger Entry"."Amount (LCY)", StartBalanceLCY, StartBalAdjLCY, Correction, ApplicationRounding);
                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                CustBalanceLCY := 0;
                //CustBalanceLCY4:=0;
                //RecCompanyInfo.GET(
                if CustDateFilter <> '' then begin

                    if GetRangeMin("Date Filter") <> 0D then begin
                        SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
                        CalcFields("Net Change (LCY)");
                        StartBalanceLCY := "Net Change (LCY)";
                    end;

                    SetFilter("Date Filter", CustDateFilter);
                    CalcFields("Net Change (LCY)");
                    StartBalAdjLCY := "Net Change (LCY)";
                    TotalCreditAmt := 0;
                    TotalDebitAmt := 0;
                    CustLedgEntry.SetCurrentKey("Customer No.", "Posting Date");
                    CustLedgEntry.SetFilter("Customer No.", "No.");
                    CustLedgEntry.SetFilter("Posting Date", CustDateFilter);
                    if CustLedgEntry.Find('-') then
                        repeat
                            CustLedgEntry.SetFilter("Date Filter", CustDateFilter);
                            CustLedgEntry.CalcFields("Amount (LCY)", "Original Amt. (LCY)");
                            //Rajeev
                            if CustLedgEntry."Original Amt. (LCY)" < 0 then
                                TotalCreditAmt += CustLedgEntry."Original Amt. (LCY)"
                            else
                                TotalDebitAmt += CustLedgEntry."Original Amt. (LCY)";


                            StartBalAdjLCY := StartBalAdjLCY - CustLedgEntry."Amount (LCY)";
                            "Detailed Cust. Ledg. Entry".SetCurrentKey("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                            "Detailed Cust. Ledg. Entry".SetRange("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                            "Detailed Cust. Ledg. Entry".SetFilter("Entry Type", '%1|%2',
                            "Detailed Cust. Ledg. Entry"."Entry Type"::"Correction of Remaining Amount",
                            "Detailed Cust. Ledg. Entry"."Entry Type"::"Appln. Rounding");
                            "Detailed Cust. Ledg. Entry".SetFilter("Posting Date", CustDateFilter);
                            if "Detailed Cust. Ledg. Entry".Find('-') then
                                repeat
                                    StartBalAdjLCY := StartBalAdjLCY - "Detailed Cust. Ledg. Entry"."Amount (LCY)";
                                until "Detailed Cust. Ledg. Entry".Next = 0;
                            "Detailed Cust. Ledg. Entry".Reset;
                        until CustLedgEntry.Next() = 0;

                    CustLedgEntry.SetCurrentKey("Customer No.", "Posting Date");
                    CustLedgEntry.SetRange("Customer No.", Customer."No.");
                    CustLedgEntry.SetFilter("Posting Date", '%1..%2', 0D, dtStartDate - 1);
                    if GD1Filter <> '' then
                        CustLedgEntry.SetFilter("Global Dimension 1 Code", GD1Filter);
                    if GD2Filter <> '' then
                        CustLedgEntry.SetFilter("Global Dimension 2 Code", GD2Filter);
                    if CustLedgEntry.Find('-') then
                        repeat
                            CustLedgEntry.SetFilter("Date Filter", '%1..%2', 0D, dtStartDate - 1);
                            CustLedgEntry.CalcFields("Amount (LCY)");
                        //      StartBalanceLCY += CustLedgEntry."Amount (LCY)" ;
                        until CustLedgEntry.Next() = 0;
                    //END;

                end;
                //CurrReport.PrintOnlyIfDetail := ExcludeBalanceOnly or (StartBalanceLCY = 0);
                //Rajeev CustBalanceLCY := StartBalanceLCY + StartBalAdjLCY
                CustBalanceLCY := StartBalanceLCY;

            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                CurrReport.NewPagePerRecord := PrintOnlyOnePerPage;
                CurrReport.CreateTotals("Cust. Ledger Entry"."Amount (LCY)", StartBalanceLCY, StartBalAdjLCY, Correction, ApplicationRounding);
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
                    field(NewPageperCustomer; PrintOnlyOnePerPage)
                    {
                        Caption = 'New Page per Customer';
                        ApplicationArea = All;
                    }
                    field(ExcludeCustHaveaBalanceOnly; ExcludeBalanceOnly)
                    {
                        Caption = 'Exclude Customers That Have a Balance Only';
                        ApplicationArea = All;
                        MultiLine = true;
                    }
                    field(PrintNarrationLine; PrintNarrationLine)
                    {
                        Caption = 'Print Narration';
                        ApplicationArea = All;
                    }
                    field("Not Show Item"; ShowItems)
                    {
                        Caption = 'Show Item';
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
        PrintToExcel := false;
        PrintAmountsInLCY := true;
    end;

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin
        RecCompanyInfo.Get();
        RecCompanyInfo.CalcFields(RecCompanyInfo.Picture);

        CustFilter := Customer.GetFilters;
        CustDateFilter := Customer.GetFilter("Date Filter");

        dtStartDate := Customer.GetRangeMin("Date Filter");
        dtEndDate := Customer.GetRangeMax("Date Filter");

        GD1Filter := Customer.GetFilter("Global Dimension 1 Filter");
        GD2Filter := Customer.GetFilter("Global Dimension 2 Filter");

        if Customer.GetRangeMin("Date Filter") > Customer.GetRangeMax("Date Filter") then
            Error('Starting Date cannot be greater then Ending Date');

        with "Cust. Ledger Entry" do
            if PrintAmountsInLCY then begin
                AmountCaption := FieldCaption("Amount (LCY)");
                RemainingAmtCaption := FieldCaption("Remaining Amt. (LCY)");
            end else begin
                AmountCaption := FieldCaption(Amount);
                RemainingAmtCaption := FieldCaption("Remaining Amount");
            end;


    end;

    var
        Text000: Label 'Period: %1';
        CustLedgEntry: Record "Cust. Ledger Entry";
        PrintAmountsInLCY: Boolean;
        CalcStatistics: Codeunit "Calculate Statistics";
        decSaleGSTAmount: Decimal;
        SalesInvHdr: Record "Sales Invoice Header";
        SalesCrMemoHdr: Record "Sales Cr.Memo Header";
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        CustFilter: Text[250];
        CustDateFilter: Text[30];
        AmountCaption: Text[80];
        RemainingAmtCaption: Text[30];
        CustAmount: Decimal;
        CustRemainAmount: Decimal;
        CustBalanceLCY: Decimal;
        CustCurrencyCode: Code[10];
        CustEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        StartBalAdjLCY: Decimal;
        Correction: Decimal;
        ApplicationRounding: Decimal;
        CustLedgEntryExists: Boolean;
        PageGroupNo: Integer;
        CustDetailTrialBalCaptionLbl: Label 'Customer - Detail Trial Bal.';
        PageNoCaptionLbl: Label 'Page';
        AllAmtsLCYCaptionLbl: Label 'All amounts are in LCY';
        RepInclCustsBalCptnLbl: Label 'This report also includes customers that only have balances.';
        PostingDateCaptionLbl: Label 'Posting Date';
        DueDateCaptionLbl: Label 'Due Date';
        BalanceLCYCaptionLbl: Label 'Balance (LCY)';
        AdjOpeningBalCaptionLbl: Label 'Adj. of Opening Balance';
        BeforePeriodCaptionLbl: Label 'Total (LCY) Before Period';
        TotalCaptionLbl: Label 'Total (LCY)';
        OpeningBalCaptionLbl: Label 'Total Adj. of Opening Balance';
        "-----------------": Integer;
        intRowNo: Integer;
        txtChequeNo: Text[30];
        dtChequeDate: Date;
        recBankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        ShowItems: Boolean;
        dtStartDate: Date;
        dtEndDate: Date;
        GD1Filter: Text[100];
        GD2Filter: Text[100];
        decDebitAmt: Decimal;
        decCreditAmt: Decimal;
        "-------------------": Integer;
        recSalesInvHdr: Record "Sales Invoice Header";
        CdShiptoCode: Code[20];
        CdShiptoName: Text[100];
        CdExternaDocNo: Code[50];
        txtBalType: Text[30];
        recPostedNarration: Record "Posted Narration";
        txtComment: Text[1024];
        "-----": Integer;
        txtNarration: Text[1024];
        ExcelBuffer: Record "Excel Buffer" temporary;
        txtData: array[255] of Text;
        PrintToExcel: Boolean;
        PrintNarrationLine: Boolean;
        txtDescription: Text[1024];
        recGLEntry: Record "G/L Entry";
        recVendor: Record Vendor;
        recBank: Record "Bank Account";
        recGLAccount: Record "G/L Account";
        decSaleCrGSTAmount: Decimal;
        RecCompanyInfo: Record "Company Information";
        TotalCreditAmt: Decimal;
        TotalDebitAmt: Decimal;
        recCustomer: Record Customer;
        SILTaxAmount: Decimal;
        SCMTaxAmount: Decimal;
        cdCustCode: Code[50];
        UTR: Text[50];
        decTDSBaseAmount: Decimal;
        decTDSAmount: Decimal;
        cdAssessCode: Decimal;
        TDSEntry: Record "TDS Entry";
        RecCompanyName: Code[100];

    procedure InitializeRequest(SetPrintOnlyOnePerPage: Boolean; SetExcludeBalanceOnly: Boolean)
    begin
        PrintOnlyOnePerPage := SetPrintOnlyOnePerPage;
        //PrintAmountsInLCY := ShowAmountInLCY;
        ExcludeBalanceOnly := SetExcludeBalanceOnly;
    end;




}

