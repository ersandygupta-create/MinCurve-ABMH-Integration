pageextension 50018 "E3 HIS Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field("E3 RCM"; Rec."E3 RCM")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RCM field.';
            }

        }
    }
}
