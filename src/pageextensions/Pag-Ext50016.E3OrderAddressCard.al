pageextension 50016 "E3 Order Address Card" extends "Order Address"
{
    layout
    {
        addlast(General)
        {
            field("E3 NPU"; Rec."E3 NPU")
            {
                ToolTip = 'Specifies the value of the NPU field.';
                ApplicationArea = All;
            }
        }
    }
}
