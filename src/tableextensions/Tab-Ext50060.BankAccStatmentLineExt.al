tableextension 50060 "E3 Bank Acc. Recon. Line Ext" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(50000; "E3 UTR No."; Code[35])
        {
            Caption = 'UTR No.';
            DataClassification = CustomerContent;
        }
    }
    procedure E3FilterBankRecLines(BankAccReconciliation: Record "Bank Acc. Reconciliation"; Overwrite: Boolean)
    begin
        Rec.Reset();
        Rec.SetRange("Statement Type", BankAccReconciliation."Statement Type");
        Rec.SetRange("Bank Account No.", BankAccReconciliation."Bank Account No.");
        Rec.SetRange("Statement No.", BankAccReconciliation."Statement No.");
        Rec.SetFilter("E3 UTR No.", '<>%1', '');
        if not Overwrite then
            Rec.SetRange("Applied Entries", 0);
        E3OnAfterFilterBankRecLines(Rec, BankAccReconciliation);
    end;

    [IntegrationEvent(false, false)]
    local procedure E3OnAfterFilterBankRecLines(var Rec: Record "Bank Acc. Reconciliation Line"; BankAccRecon: Record "Bank Acc. Reconciliation")
    begin
    end;

    procedure E3FilterBankRecLinesByDate(BankAccReconciliation: Record "Bank Acc. Reconciliation"; Overwrite: Boolean)
    begin
        E3FilterBankRecLines(BankAccReconciliation, Overwrite);

        // Records sorted by transaction date to optimize matching
        Rec.SetCurrentKey("Transaction Date");
        Rec.SetAscending("Transaction Date", true);
    end;
}