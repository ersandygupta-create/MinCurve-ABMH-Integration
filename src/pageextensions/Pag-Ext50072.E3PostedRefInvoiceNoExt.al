pageextension 50072 "E3 Posted Ref. Invoice" extends "Posted Reference Invoice No"
{
    layout
    {
        addafter("Reference Invoice Nos.")
        {
            field("Alternate Ref. Invoice No."; Rec."Alternate Ref. Invoice No.")
            {
                Caption = 'Alternate Ref. Invoice No.';
                ApplicationArea = All;
                ToolTip = 'Specifies the Alternate Reference Invoice number.';
            }
            field(Skip; Rec.Skip)
            {
                Caption = 'Skip';
                ApplicationArea = All;
                ToolTip = 'Specifies the Skip field';
            }
        }
    }
}