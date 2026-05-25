pageextension 50058 "E3 HIS Purchase Orders" extends "Purchase Orders"
{
    layout
    {
        addlast(Control1)
        {
            field("Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the transaction type of the document.';
            }
        }
    }
}

