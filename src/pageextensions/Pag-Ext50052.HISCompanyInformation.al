pageextension 50052 "HIS Company Information" extends "Company Information"
{
    layout
    {
        addbefore(Picture)
        {
            field(CompRegNo; Rec."CIN No.")
            {
                Caption = 'CIN / Reg. No.';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CIN / Reg. No. field.';
            }

            field("Old Comapany Name"; Rec."Old Comapany Name")
            {
                Caption = 'Old Company Name';
                ApplicationArea = All;
                ToolTip = 'Old Company Name';
            }
            field("Transaction Date"; Rec."Transaction Date")
            {
                Caption = 'Transaction Date';
                ApplicationArea = All;
                ToolTip = 'Transaction Date to print Old COmpany Name';
            }
        }
        addafter(Picture)
        {
            field(DraftImage; Rec.DraftImage)
            {
                ToolTip = 'Draft Image';
                ApplicationArea = All;
                Caption = 'Draft Image';

            }
        }
    }
}
