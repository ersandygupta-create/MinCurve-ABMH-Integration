pageextension 50060 "E3 Chart of Accounts List" extends "Chart of Accounts"
{
    layout
    {
        addafter(Name)
        {
            field("DebitAmount"; Rec."Debit Amount")
            {
                ApplicationArea = All;
                Caption = 'Debit Amount';
                ToolTip = 'Specifies the value of the Debit Amount field.';
            }
            field("CreditAmount"; Rec."Credit Amount")
            {
                ApplicationArea = All;
                Caption = 'Credit Amount';
                ToolTip = 'Specifies the value of the Credit Amount field.';
            }
            // field("NetChange"; Rec."Net Change")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Net Change';
            //     ToolTip = 'Specifies the value of the Net Change field.';
            // }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CheckBln := USERID;
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", CheckBln);
        IF UserSetup.FIND('-') THEN BEGIN
            IF UserSetup."GL View" <> TRUE THEN
                ERROR('Permission of COA is not added in your access. If required, please contact to IT Administrator ');
        END;
    end;

    var
        CheckBln: Code[30];
        UserSetup: Record "User Setup";
}


