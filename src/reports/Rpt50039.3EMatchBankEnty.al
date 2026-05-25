report 50039 "E3 Match Bank Entries"
{
    Caption = 'Match Bank Entries';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Bank Acc. Reconciliation"; "Bank Acc. Reconciliation")
        {
            DataItemTableView = sorting("Bank Account No.", "Statement No.");

            trigger OnAfterGetRecord()
            var
                BankLE: Record "Bank Account Ledger Entry";
            begin
                //ak
                BankLE.Reset();
                BankLE.SetRange("Bank Account No.", "Bank Acc. Reconciliation"."Bank Account No.");
                BankLE.SetFilter("Remaining Amount", '<>%1', 0); // only consider open / relevant entries

                if BankLE.FindSet() then begin
                    repeat
                        if BankLE."Posting Date" > "Bank Acc. Reconciliation"."Statement Date" then begin

                        end;
                    // MESSAGE(
                    //   'Skipping ledger entry %1 because its Posting Date %2 is later than the Statement Date %3.',
                    //   BankLE."Entry No.", BankLE."Posting Date", "Bank Acc. Reconciliation"."Statement Date"
                    // )
                    until BankLE.Next() = 0;
                end; //ak

                BankAccRecLine.Reset();
                BankAccRecLine.SetRange("Statement No.", "Statement No.");
                BankAccRecLine.SetRange("Bank Account No.", "Bank Account No.");
                BankAccRecLine.SetRange("Statement Type", "Statement Type");
                BankAccRecLine.SetFilter("E3 UTR No.", '<>%1', '');
                if BankAccRecLine.FindSet() then
                    repeat
                        BankAccLedgerEntry.Reset();
                        BankAccLedgerEntry.SetRange("E3 UTR No.", BankAccRecLine."E3 UTR No.");
                        BankAccLedgerEntry.SetRange(BankAccLedgerEntry."Bank Account No.", BankAccRecLine."Bank Account No.");
                        //BankAccLedgerEntry.SetRange(BankAccLedgerEntry."Statement No.", BankAccRecLine."Statement No.");
                        BankAccLedgerEntry.SetRange(BankAccLedgerEntry."Statement Status", BankAccLedgerEntry."Statement Status"::Open);
                        BankAccLedgerEntry.SetFilter(BankAccLedgerEntry."Remaining Amount", '<>%1', 0);
                        BankAccLedgerEntry.SetRange(BankAccLedgerEntry."Reversed", false); // PR 30730
                        BankAccLedgerEntry.SetFilter(BankAccLedgerEntry."E3 UTR No.", BankAccRecLine."E3 UTR No.");
                        BankAccLedgerEntry.SetRange(BankAccLedgerEntry."Remaining Amount", BankAccRecLine."Statement Amount");
                        BankAccLedgerEntry.SetRange("Posting Date", 0D, "Bank Acc. Reconciliation"."Statement Date");//ak

                        if BankAccLedgerEntry.Find('-') then
                            if BankAccEntrySetReconNo.ApplyEntries(BankAccRecLine, BankAccLedgerEntry, Relation1::"One-to-One") then
                                //    if BankAccEntrySetReconNo.ApplyEntries(BankAccRecLine, BankAccLedgerEntry, Relation::"One-to-Many") then
                                PaymentMatchingDetails.CreatePaymentMatchingDetail(BankAccRecLine, 'Match UTR');
                    until BankAccRecLine.Next() = 0;



                //E3MatchSingle(DateRange);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control3)
                {
                    ShowCaption = false;
                    field(DateRange; DateRange)
                    {
                        ApplicationArea = Basic, Suite;
                        BlankZero = true;
                        Caption = 'Transaction Date Tolerance (Days)';
                        MinValue = 0;
                        ToolTip = 'Specifies the span of days before and after the bank account ledger entry posting date within which the function will search for matching transaction dates in the bank statement. If you enter 0 or leave the field blank, then the Match Automatically function will only search for matching transaction dates on the bank account ledger entry posting date.';
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

    var
        BankAccLedgerEntry: Record "Bank Account Ledger Entry";
        BankAccEntrySetReconNo: Codeunit "Bank Acc. Entry Set Recon.-No.";
        PaymentMatchingDetails: Record "Payment Matching Details";
        DateRange: Integer;
        BankAccRecLine: Record "Bank Acc. Reconciliation Line";
        Relation1: Option "One-to-One","One-to-Many","Many-to-One";

}

