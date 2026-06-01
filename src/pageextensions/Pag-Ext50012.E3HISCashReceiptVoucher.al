pageextension 50012 "E3 HIS Cash Receipt Voucher" extends "Cash Receipt Voucher"
{
    layout
    {
        addlast(Control1)
        {
            field("Posting Group"; Rec."Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the account posting group that the entry on the journal line will be posted to.';
            }
            field("E3 Narration"; Rec."E3 Narration")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Narrantion field.';
            }
        }
        addafter(Amount)
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
        }
    }
}
