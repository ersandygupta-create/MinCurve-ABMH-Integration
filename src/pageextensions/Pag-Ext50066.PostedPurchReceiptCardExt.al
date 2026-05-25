pageextension 50066 "Posted Purch Receipt Card Ext" extends "Posted Purchase Receipt"
{
    layout
    {
        addbefore("Quote No.")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Posting Description';
                ToolTip = 'Specifies a posting description of the order.';
            }
        }

    }

    actions
    {
    }
}