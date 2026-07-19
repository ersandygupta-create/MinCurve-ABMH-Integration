report 50060 "Apply To Oldest Customer"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50060.ApplyToOldestCustEntry.rdlc';
    Caption = 'Apply To Ext. Document No. Customer';
    Permissions = TableData "Cust. Ledger Entry" = rm,
                  TableData "Sales Invoice Line" = rm,
                  TableData "Detailed Cust. Ledg. Entry" = rimd;
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Application Method", "Customer Posting Group";

            trigger OnAfterGetRecord()
            begin
                //Remove previous applications
                txtCustomerName := Customer.Name;
                intCurrentCustomer += 1;

                intCurrentRecord := 0;
                intTotalRecords := 0;
                intStatus := 0;

                IF blnDeletePrevious THEN BEGIN


                    SettlementUnApply.Reset();
                    SettlementUnApply.SetRange("Bal. Account Type", SettlementUnApply."Bal. Account Type"::Customer);
                    SettlementUnApply.SetRange("Bal. Account No", "No.");
                    SettlementUnApply.SetRange("General Entries Created", false);
                    SettlementUnApply.SetFilter(Amount, '< 0');
                    if SettlementUnApply.FindSet() then
                        repeat
                            recDCLE.RESET();
                            recDCLE.SETCURRENTKEY("Customer No.", "Posting Date", "Entry Type", "Currency Code");
                            recDCLE.SetRange("External Document No.", SettlementUnApply."External Document No.");
                            recDCLE.SETRANGE("Customer No.", Customer."No.");
                            recDCLE.SETFILTER("Entry Type", '<>%1', recDCLE."Entry Type"::"Initial Entry");
                            //  recDCLE.SETFILTER("Source Code", '%1', 'SALESAPPL');
                            recDCLE.CALCFIELDS(Reversed);
                            // recDCLE.SETFILTER(Reversed, '%1', FALSE);
                            IF recDCLE.FIND('-') THEN
                                recDCLE.DELETEALL;

                            recDCLE.RESET();
                            recDCLE.SETCURRENTKEY("Customer No.", "Posting Date", "Entry Type", "Currency Code");
                            recDCLE.SetRange("Document No.", SettlementUnApply."External Document No.");
                            recDCLE.SETRANGE("Customer No.", Customer."No.");
                            recDCLE.SETFILTER("Entry Type", '<>%1', recDCLE."Entry Type"::"Initial Entry");
                            //  recDCLE.SETFILTER("Source Code", '%1', 'SALESAPPL');
                            recDCLE.CALCFIELDS(Reversed);
                            // recDCLE.SETFILTER(Reversed, '%1', FALSE);
                            IF recDCLE.FIND('-') THEN
                                recDCLE.DELETEALL;



                            recCLEWithCreditAmount.RESET;
                            recCLEWithCreditAmount.SETCURRENTKEY("Customer No.", "Due Date", "Currency Code");
                            recCLEWithCreditAmount.SETRANGE("Customer No.", "No.");
                            recCLEWithCreditAmount.SetRange("External Document No.", SettlementUnApply."External Document No.");
                            recCLEWithCreditAmount.SETRANGE(Reversed, FALSE);
                            recCLEWithCreditAmount.MODIFYALL(Open, TRUE);
                            recCLEWithCreditAmount.MODIFYALL("Closed by Entry No.", 0);
                            recCLEWithCreditAmount.MODIFYALL("Closed at Date", 0D);
                            recCLEWithCreditAmount.MODIFYALL("Closed by Amount", 0);
                            recCLEWithCreditAmount.MODIFYALL("Closed by Amount (LCY)", 0);
                            recCLEWithCreditAmount.MODIFYALL("Closed by Currency Code", '');
                            recCLEWithCreditAmount.MODIFYALL("Closed by Currency Amount", 0);

                            recCLEUpd.RESET;
                            recCLEUpd.SETCURRENTKEY("Customer No.", "Due Date", "Currency Code");
                            recCLEUpd.SETRANGE("Customer No.", "No.");
                            recCLEUpd.SetRange("Document No.", SettlementUnApply."Document No.");
                            recCLEUpd.SetFilter(Amount, '< 0');
                            recCLEUpd.CalcFields("Remaining Amount");
                            if ABS(recCLEUpd.Amount) = Abs(recCLEUpd."Remaining Amount") then
                                recCLEUpd.ModifyAll(Open, true);

                            SettlementStagingUpd := SettlementUnApply;
                            SettlementStagingUpd."General Entries Created" := true;
                            SettlementStagingUpd.Modify();
                        until SettlementUnApply.Next() = 0;
                END;

                IF blnAdjustment THEN BEGIN
                    recDCLE.LOCKTABLE(TRUE);
                    Customer1.RESET;
                    Customer1.SETRANGE("No.", "No.");
                    // Customer1.SETRANGE("Credit Date Application","Credit Date Application");
                    IF Customer1.FINDFIRST THEN BEGIN

                        recCLEWithCreditAmount.RESET;
                        recCLEWithCreditAmount.SETCURRENTKEY("Customer No.", "Due Date", "Currency Code");
                        recCLEWithCreditAmount.SETRANGE("Customer No.", Customer1."No.");
                        recCLEWithCreditAmount.SETRANGE(Reversed, FALSE);
                        IF EndDate <> 0D THEN
                            recCLEWithCreditAmount.SETFILTER("Due Date", '<=%1', EndDate);
                        recCLEWithCreditAmount.CALCFIELDS(Amount, "Remaining Amount");
                        recCLEWithCreditAmount.SETFILTER(Amount, '<0');
                        recCLEWithCreditAmount.SETFILTER("Remaining Amount", '< 0');
                        IF recCLEWithCreditAmount.FIND('-') THEN BEGIN
                            intTotalRecords := recCLEWithCreditAmount.COUNT;
                            REPEAT
                                GetCurrencyFactor(recCLEWithCreditAmount."Due Date", recCLEWithCreditAmount."Currency Code");
                                intCurrentRecord += 1;
                                intStatus := ROUND((intCurrentRecord / intTotalRecords) * 10000, 1);
                                Window.UPDATE;
                                CompanyInformation.GET();


                                recDCLEInitialEntry.RESET;
                                recDCLEInitialEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Posting Date");
                                recDCLEInitialEntry.SETRANGE(recDCLEInitialEntry."Cust. Ledger Entry No.", recCLEWithCreditAmount."Entry No.");
                                recDCLEInitialEntry.SETFILTER("Source Code", '<>%1', 'REVERSAL');
                                recDCLEInitialEntry.CALCFIELDS(Reversed);
                                recDCLEInitialEntry.SETFILTER(Reversed, '%1', FALSE);
                                recDCLEInitialEntry.CalcFields("External Document No.");
                                recDCLEInitialEntry.SETRANGE(recDCLEInitialEntry."External Document No.", recCLEWithCreditAmount."External Document No."); //13032024
                                recDCLEInitialEntry.FIND('-');
                                intDVLETransactionNo := recDCLEInitialEntry."Transaction No.";
                                recCLEWithCreditAmount.CALCFIELDS(Amount, "Remaining Amount", "Remaining Amt. (LCY)");
                                IF (ABS(recDCLEInitialEntry.Amount) <> ABS(recCLEWithCreditAmount."Remaining Amount")) THEN BEGIN   //MK //AND NOT FirstEntry
                                    decCreditAmountToApply := ABS(recCLEWithCreditAmount."Remaining Amount");
                                    decPmtAmountLCY := ABS(recCLEWithCreditAmount."Remaining Amt. (LCY)");
                                END ELSE BEGIN
                                    decCreditAmountToApply := ABS(recDCLEInitialEntry.Amount);
                                    decPmtAmountLCY := ABS(recDCLEInitialEntry."Amount (LCY)");
                                END;

                                FirstEntry := TRUE;
                                blnApplicationDone := FALSE;

                                decApplicationAmount := 0;
                                decApplicationAmountLCY := 0;

                                WHILE decCreditAmountToApply > 0 DO BEGIN
                                    CompanyInformation.GET();

                                    //sandeep settlement
                                    SettlementStaging.Reset();
                                    SettlementStaging.SetRange("Bal. Account Type", SettlementStaging."Bal. Account Type"::Customer);
                                    SettlementStaging.SetRange("Bal. Account No", recCLEWithCreditAmount."Customer No.");
                                    SettlementStaging.SetFilter(Amount, '> 0');
                                    SettlementStaging.SetRange("General Entries Created", false);
                                    SettlementStaging.SetRange("Document No.", recCLEWithCreditAmount."Document No.");

                                    if SettlementStaging.Find('-') then begin
                                        recCLEWithDebitAmount.RESET;
                                        recCLEWithDebitAmount.SETCURRENTKEY("Customer No.", "Due Date", "Currency Code");
                                        recCLEWithDebitAmount.SETRANGE("Customer No.", recCLEWithCreditAmount."Customer No.");
                                        recCLEWithDebitAmount.SETRANGE("External Document No.", SettlementStaging."External Document No."); //13032024

                                        recCLEWithDebitAmount.SETRANGE(Reversed, FALSE);
                                        recCLEWithDebitAmount.CALCFIELDS(Amount, "Remaining Amount", "Remaining Amt. (LCY)");
                                        IF EndDate <> 0D THEN
                                            recCLEWithDebitAmount.SETFILTER("Due Date", '<=%1', EndDate);
                                        recCLEWithDebitAmount.SETFILTER(Amount, '> 0');
                                        recCLEWithDebitAmount.SETFILTER("Remaining Amount", '> 0');
                                        IF recCLEWithDebitAmount.FIND('-') THEN BEGIN
                                            blnApplicationDone := TRUE;
                                            REPEAT
                                                IF recCLEWithCreditAmount."Due Date" > recCLEWithDebitAmount."Due Date" THEN
                                                    dtMaxPostingDate := recCLEWithCreditAmount."Due Date"
                                                ELSE
                                                    dtMaxPostingDate := recCLEWithDebitAmount."Due Date";

                                                recCLEWithDebitAmount.CALCFIELDS(Amount, "Remaining Amount", "Remaining Amt. (LCY)");
                                                decDebitAmountToBeAdjusted := SettlementStaging.Amount;//ABS(recCLEWithDebitAmount."Remaining Amount");
                                                decInvAmountLCY := SettlementStaging.Amount;//ABS(recCLEWithDebitAmount."Remaining Amt. (LCY)");
                                                dtPostingDate := recCLEWithDebitAmount."Due Date";

                                                IF decCreditAmountToApply <= decDebitAmountToBeAdjusted THEN BEGIN
                                                    decTempAmount := decCreditAmountToApply;
                                                    decTempAmountLCY := decPmtAmountLCY;
                                                END
                                                ELSE BEGIN
                                                    decTempAmount := decDebitAmountToBeAdjusted;
                                                    decTempAmountLCY := decInvAmountLCY;
                                                END;

                                                decApplicationAmount += decTempAmount;
                                                decApplicationAmountLCY += decTempAmountLCY;

                                                recDCLE."Entry No." := intDCLEEntryNo;
                                                recDCLE."Cust. Ledger Entry No." := recCLEWithDebitAmount."Entry No.";
                                                recDCLE."Entry Type" := recDCLE."Entry Type"::Application;
                                                recDCLE."Posting Date" := dtMaxPostingDate;
                                                recDCLE."Document Type" := recCLEWithDebitAmount."Document Type";
                                                recDCLE."Document No." := SettlementStaging."Document No.";//recCLEWithDebitAmount."Document No.";
                                                recDCLE.Amount := -decTempAmount;
                                                recDCLE."Amount (LCY)" := -decTempAmountLCY;
                                                recDCLE."Customer No." := recCLEWithCreditAmount."Customer No.";
                                                recDCLE."User ID" := recCLEWithCreditAmount."User ID";
                                                recDCLE."Source Code" := recCLEWithCreditAmount."Source Code";
                                                recDCLE."Transaction No." := intDVLETransactionNo;
                                                recDCLE."Journal Batch Name" := recCLEWithCreditAmount."Journal Batch Name";
                                                recDCLE."Credit Amount" := decTempAmount;
                                                recDCLE."Debit Amount" := 0;
                                                recDCLE."Credit Amount (LCY)" := -decTempAmountLCY;
                                                recDCLE."Debit Amount (LCY)" := 0;
                                                recDCLE."Initial Entry Due Date" := recCLEWithDebitAmount."Due Date";
                                                recDCLE."Initial Entry Global Dim. 1" := recCLEWithDebitAmount."Global Dimension 1 Code";
                                                recDCLE."Initial Entry Global Dim. 2" := recCLEWithDebitAmount."Global Dimension 2 Code";
                                                recDCLE."Initial Document Type" := recCLEWithDebitAmount."Document Type";
                                                recDCLE."Applied Cust. Ledger Entry No." := recCLEWithCreditAmount."Entry No.";
                                                recDCLE."Ledger Entry Amount" := false;
                                                recDCLE.INSERT;

                                                intDCLEEntryNo += 1;

                                                decCreditAmountToApply -= decTempAmount;
                                                decPmtAmountLCY -= decTempAmountLCY;

                                                recCLEWithDebitAmount.CALCFIELDS("Remaining Amount");
                                                IF recCLEWithDebitAmount."Remaining Amount" <> 0 THEN
                                                    recCLEWithDebitAmount.Open := TRUE
                                                ELSE BEGIN
                                                    recCLEWithDebitAmount.Open := FALSE;
                                                    recCLEWithDebitAmount."Closed by Entry No." := recCLEWithCreditAmount."Entry No.";
                                                    recCLEWithDebitAmount."Closed at Date" := dtMaxPostingDate;
                                                    recCLEWithDebitAmount."Closed by Amount" := decDebitAmountToBeAdjusted;
                                                    recCLEWithDebitAmount."Closed by Amount (LCY)" := decInvAmountLCY;
                                                    recCLEWithDebitAmount."Closed by Currency Code" := recCLEWithCreditAmount."Currency Code";
                                                    recCLEWithDebitAmount."Closed by Currency Amount" := decDebitAmountToBeAdjusted / decCurrencyFactor;
                                                END;
                                                recCLEWithDebitAmount.MODIFY;

                                                recDCLE.INIT;
                                                recDCLE."Entry No." := intDCLEEntryNo;
                                                recDCLE."Cust. Ledger Entry No." := recCLEWithCreditAmount."Entry No.";
                                                recDCLE."Entry Type" := recDCLE."Entry Type"::Application;
                                                recDCLE."Posting Date" := dtMaxPostingDate;
                                                recDCLE."Document Type" := recCLEWithCreditAmount."Document Type";
                                                recDCLE."Document No." := recCLEWithDebitAmount."Document No.";
                                                recDCLE.Amount := decTempAmount;
                                                recDCLE."Amount (LCY)" := decTempAmountLCY;
                                                recDCLE."Customer No." := recCLEWithCreditAmount."Customer No.";
                                                recDCLE."User ID" := recCLEWithCreditAmount."User ID";
                                                recDCLE."Source Code" := recCLEWithCreditAmount."Source Code";
                                                recDCLE."Transaction No." := intDVLETransactionNo;
                                                recDCLE."Journal Batch Name" := recCLEWithCreditAmount."Journal Batch Name";
                                                recDCLE."Credit Amount" := 0;
                                                recDCLE."Debit Amount" := decTempAmount;
                                                recDCLE."Credit Amount (LCY)" := 0;
                                                recDCLE."Debit Amount (LCY)" := decTempAmountLCY;
                                                recDCLE."Initial Entry Due Date" := recCLEWithCreditAmount."Due Date";
                                                recDCLE."Initial Entry Global Dim. 1" := recCLEWithCreditAmount."Global Dimension 1 Code";
                                                recDCLE."Initial Entry Global Dim. 2" := recCLEWithCreditAmount."Global Dimension 2 Code";
                                                recDCLE."Initial Document Type" := recCLEWithCreditAmount."Document Type";
                                                recDCLE."Applied Cust. Ledger Entry No." := recCLEWithDebitAmount."Entry No.";
                                                recDCLE."Ledger Entry Amount" := false;
                                                recDCLE.INSERT;
                                                intDCLEEntryNo += 1;

                                                GetCurrencyFactor(recCLEWithDebitAmount."Due Date", recCLEWithDebitAmount."Currency Code");
                                                recCLEWithCreditAmount.CALCFIELDS("Remaining Amount");
                                                IF recCLEWithCreditAmount."Remaining Amount" <> 0 THEN
                                                    recCLEWithCreditAmount.Open := TRUE
                                                ELSE BEGIN
                                                    recCLEWithCreditAmount.Open := FALSE;
                                                    recCLEWithCreditAmount."Closed by Entry No." := recCLEWithDebitAmount."Entry No.";
                                                    recCLEWithCreditAmount."Closed at Date" := recCLEWithDebitAmount."Posting Date";
                                                    recCLEWithCreditAmount."Closed by Amount" := decTempAmount;
                                                    recCLEWithCreditAmount."Closed by Amount (LCY)" := decTempAmountLCY;
                                                    recCLEWithCreditAmount."Closed by Currency Code" := recCLEWithDebitAmount."Currency Code";
                                                    recCLEWithCreditAmount."Closed by Currency Amount" := decTempAmount / decCurrencyFactor;
                                                END;
                                                recCLEWithCreditAmount.MODIFY;

                                            UNTIL ((recCLEWithDebitAmount.NEXT = 0) OR (decCreditAmountToApply <= 0));
                                        END
                                        ELSE
                                            decCreditAmountToApply := 0;
                                        SettlementStagingUpd := SettlementStaging;
                                        SettlementStagingUpd."General Entries Created" := true;
                                        SettlementStagingUpd.Modify();
                                    end
                                    else
                                        decCreditAmountToApply := 0;


                                END;

                            UNTIL (recCLEWithCreditAmount.NEXT = 0);
                        END;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin

                recDCLE.RESET;
                recDCLE.FIND('+');
                intDCLEEntryNo := recDCLE."Entry No." + 1;

                intTotalCustomers := Customer.COUNT;
                intCurrentCustomer := 0;

                Window.OPEN('customers   #####1#/#####2#  \' +
                            '\' +
                            '\' +
                            'customer :  #3###################################################\' +
                            '\' +
                            '\' +
                            'Current Adjustment  ######4#     Total Adjustments  ######5#  \' +
                            '\' +
                            '\' +
                            'Progress  @6@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@',
                            intCurrentCustomer, intTotalCustomers, txtCustomerName, intCurrentRecord, intTotalRecords, intStatus);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Open All"; blnDeletePrevious)
                {
                    ApplicationArea = All;
                }
                field(Apply; blnAdjustment)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            CompanyInformation.GET();
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        blnDeletePrevious := FALSE;
        blnAdjustment := TRUE;
        EndDate := WorkDate();
    end;

    trigger OnPreReport()
    begin
        FirstEntry := FALSE;

        CompanyInformation.GET();

    end;

    var
        SettlementStaging: Record "E3 HIS Settlement Staging";
        SettlementStagingUpd: Record "E3 HIS Settlement Staging";
        recCLEWithDebitAmount: Record "Cust. Ledger Entry";
        recCLEWithCreditAmount: Record "Cust. Ledger Entry";
        decCreditAmountToApply: Decimal;
        decDebitAmountToBeAdjusted: Decimal;
        dtPostingDate: Date;
        recDCLE: Record "Detailed Cust. Ledg. Entry";
        recCLEUpd: Record "Cust. Ledger Entry";
        SettlementUnApply: Record "E3 HIS Settlement Staging";
        intDCLEEntryNo: Integer;
        recCurrencyExchangeRate: Record "Currency Exchange Rate";
        decAmountNonLCY: Decimal;
        intDVLETransactionNo: Integer;
        recDCLEInitialEntry: Record "Detailed Cust. Ledg. Entry";
        decTempAmount: Decimal;
        decTempAmountLCY: Decimal;
        decPmtAmountLCY: Decimal;

        decInvAmountLCY: Decimal;
        intDebitEntryNo: Integer;
        blnApplicationDone: Boolean;
        decApplicationAmount: Decimal;
        decApplicationAmountLCY: Decimal;
        Window: Dialog;
        intCurrentRecord: Integer;
        intStatus: Integer;
        intTotalRecords: Integer;
        intTotalCustomers: Integer;
        intCurrentCustomer: Integer;
        txtCustomerName: Text[100];
        decCurrencyFactor: Decimal;
        blnDeletePrevious: Boolean;
        blnAdjustment: Boolean;
        dtMaxPostingDate: Date;
        EndDate: Date;
        FirstEntry: Boolean;
        CustLedgerEntry5: Record "Cust. Ledger Entry";
        Customer1: Record "Customer";
        CompanyInformation: Record "Company Information";


    procedure GetCurrencyFactor(PostingDate: Date; CurrencyCode: Code[10])
    begin
        IF CurrencyCode = '' THEN BEGIN
            decCurrencyFactor := 1;
            EXIT;
        END;

        recCurrencyExchangeRate.RESET;
        recCurrencyExchangeRate.SETRANGE("Currency Code", CurrencyCode);
        recCurrencyExchangeRate.SETFILTER("Starting Date", '<=%1', PostingDate);
        recCurrencyExchangeRate.FINDLAST;
        decCurrencyFactor := recCurrencyExchangeRate.ExchangeRate(PostingDate, CurrencyCode);
    end;
}

