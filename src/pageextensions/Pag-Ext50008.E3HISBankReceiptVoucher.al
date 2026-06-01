pageextension 50008 "E3 HIS Bank Receipt Voucher" extends "Bank Receipt Voucher"
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
            field("E3 HIS Module"; Rec."E3 HIS Module")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the HIS Module field.';
            }
            field("E3 HIS Document Type"; Rec."E3 HIS Document Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the HIS Document Type field.';
            }
            field("E3 Store Code"; Rec."E3 Store Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Store Code field.';
            }
            field("E3 Sub Group Code"; Rec."E3 Sub Group Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sub Group Code field.';
            }
            field("E3 Receipt No."; Rec."E3 Receipt No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Receipt No. field.';
            }

            field("E3 UHID"; Rec."E3 UHID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the UHID field.';
            }
            field("E3 Patient Name"; Rec."E3 Patient Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Patient Name field.';
            }
            field("E3 Validation Key"; Rec."E3 Validation Key")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vaidation Key field.';
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
