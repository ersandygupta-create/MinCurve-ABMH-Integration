pageextension 50081 E3PostedPurchInv extends 139
{
    layout
    {
        addafter("Unit Cost (LCY)")
        {
            field("GST Credit"; Rec."GST Credit")
            {
                ApplicationArea = All;
                ToolTip = 'GST Credit';

            }
        }
    }

}