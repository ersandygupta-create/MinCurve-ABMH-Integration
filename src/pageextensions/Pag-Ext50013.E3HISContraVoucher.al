pageextension 50013 "E3 HIS Contra Voucher" extends "Contra Voucher"
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
            field("E3 UTR No."; Rec."E3 UTR No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the UTR No. field.';
            }
        }
    }
}
