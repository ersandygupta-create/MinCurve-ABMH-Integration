pageextension 50017 "E3 HIS Sales Order" extends "Sales Order"
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
