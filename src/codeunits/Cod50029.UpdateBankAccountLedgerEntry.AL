codeunit 50029 "Update Bank Ledger Field"
{
    Permissions =
        tabledata "E3 Bank Integration" = rimd,
        tabledata "Bank Account Ledger Entry" = rimd;

    trigger OnRun()
    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        UpdateBankLedgerEntries();
    end;

    local procedure UpdateBankLedgerEntries()
    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        E3BankIntegration: Record "E3 Bank Integration";
        ValueDate: Date;
    begin
        // Example filter – adjust as needed
        E3BankIntegration.SetRange("BALE updated", false);
        E3BankIntegration.SetFilter("UTR No.", '<>%1', ''); // Assuming we only want entries with a UTR No.
        if E3BankIntegration.FindSet() then
            repeat
                if BankLedgerEntry.Get(E3BankIntegration."Bank Account Ledger Entry No.") then begin
                    // Perform necessary updates to BankLedgerEntry here
                    BankLedgerEntry."EDC UTR No." := E3BankIntegration."UTR No.";
                    if Evaluate(ValueDate, E3BankIntegration.FLD1) then
                        BankLedgerEntry."Value Date" := ValueDate;
                    // Mark as updated
                    BankLedgerEntry.Modify();
                    E3BankIntegration."BALE updated" := true;
                    E3BankIntegration.Modify();
                end;
            until E3BankIntegration.Next() = 0;
    end;
}
