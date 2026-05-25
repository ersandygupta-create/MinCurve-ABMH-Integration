pageextension 50056 "E3 Blanket Purchase Order" extends "Blanket Purchase Order"
{
    layout

    {
        addlast(General)
        {
            field("E3 Delivery Terms"; Rec."E3 Delivery Terms")
            {
                ApplicationArea = All;
                Style = StrongAccent;
                StyleExpr = true;
                ToolTip = 'Specifies the value of the Delivery Terms field.';
            }

        }
    }


}
