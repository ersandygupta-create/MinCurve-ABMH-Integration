pageextension 50089 E3PurchaseOrderSub extends 54
{
    layout
    {
        addafter("No. of Fixed Asset Cards")
        {
            field("FA Posting Type"; Rec."FA Posting Type")
            {
                ApplicationArea = All;
                ToolTip = 'FA Posting Type';
            }
        }
    }


}