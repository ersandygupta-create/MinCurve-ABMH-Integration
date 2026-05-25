pageextension 50067 "Get Reciept Lines Ext" extends "Get Receipt Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field("Order No."; Rec."Order No.")
            {
                Caption = 'PO No.';
                ApplicationArea = All;
                ToolTip = 'Specifies the PO number of the filter';
            }
            field("Posting Date"; Rec."Posting Date")
            {
                Caption = 'Posting Date';
                ApplicationArea = All;
                ToolTip = 'Specifies the Posting Date of the filter';
            }
        }
    }

    actions
    {
    }
}