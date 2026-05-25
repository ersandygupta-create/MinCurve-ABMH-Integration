tableextension 50062 "E3 Ledger Ent Match Buf Ext" extends "Ledger Entry Matching Buffer"
{

    procedure E3InsertFromBankAccLedgerEntry(BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    begin
        Clear(Rec);
        if (BankAccountLedgerEntry."E3 UTR No." <> '') then begin
            "Entry No." := BankAccountLedgerEntry."Entry No.";
            "Account Type" := "Account Type"::"Bank Account";
            "Account No." := BankAccountLedgerEntry."Bank Account No.";
            "Bal. Account Type" := BankAccountLedgerEntry."Bal. Account Type";
            "Bal. Account No." := BankAccountLedgerEntry."Bal. Account No.";
            // Description := BankAccountLedgerEntry.Description;
            "Posting Date" := BankAccountLedgerEntry."Posting Date";
            "Document Type" := BankAccountLedgerEntry."Document Type";
            //"Document No." := BankAccountLedgerEntry."Document No.";
            //  "External Document No." := BankAccountLedgerEntry."External Document No.";
            "Remaining Amount" := BankAccountLedgerEntry."Remaining Amount";
            "Remaining Amt. Incl. Discount" := "Remaining Amount";
        end;
        Insert(true);
    end;
}