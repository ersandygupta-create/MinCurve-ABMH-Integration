pageextension 50059 "PgExt_Bank Card" extends "Bank Account List"
{
    actions
    {
        addafter("Bank Account Statements")
        {
            action("Bank Account Reconciliation Report")
            {
                ApplicationArea = All;
                Caption = 'Bank Account Reconciliation Report';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;
                trigger OnAction()
                begin
                    recBankAccount.Reset();
                    recBankAccount.SetRange("No.", Rec."No.");
                    REPORT.RUNMODAL(Report::"Print Bank Reconciliatio Rep.", TRUE, TRUE, recBankAccount);

                end;
            }
        }


    }
    var
        recBankAccount: Record "Bank Account";

}
