pageextension 50065 "Posted Pur Receipt List Ext" extends "Posted Purchase Receipts"
{
    layout
    {
        addafter("Location Code")
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