pageextension 50070 "3E Bank Acc. Recon Ext" extends "Bank Acc. Reconciliation"
{
    layout
    {
        // Add changes to page layout here
    }
    actions
    {
        modify(MatchAutomatically)
        {
            Visible = false;
        }
        addafter(MatchAutomatically)
        {
            action("3EMatchAutomatically")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Match Automatically';
                Image = MapAccounts;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Automatically search for and match bank statement lines.';

                trigger OnAction()
                var
                    RecLine: Record "Bank Acc. Reconciliation Line";
                    BankLE: Record "Bank Account Ledger Entry";
                begin

                    RecLine.Reset();
                    RecLine.SetRange("Bank Account No.", Rec."Bank Account No.");
                    RecLine.SetRange("Statement No.", Rec."Statement No.");
                    if RecLine.FindSet() then begin
                        repeat
                            if Rec."Statement Date" < RecLine."Transaction Date" then
                                Error(
                                  'Cannot match automatically: Statement Date (%1) is earlier than transaction date on a line (%2).',
                                  Rec."Statement Date", RecLine."Transaction Date"
                                );
                        until RecLine.Next() = 0;
                    end;

                    Rec.SetRange("Statement Type", Rec."Statement Type");
                    Rec.SetRange("Bank Account No.", Rec."Bank Account No.");
                    Rec.SetRange("Statement No.", Rec."Statement No.");
                    REPORT.Run(REPORT::"E3 Match Bank Entries", true, true, Rec);
                end;
            }
        }
    }
}
