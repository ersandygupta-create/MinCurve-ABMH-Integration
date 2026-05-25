pageextension 50073 "E3 Location Card Ext" extends "Location Card"
{
    layout
    {
        addlast(General)
        {
            group(BankAccount)
            {
                field("Invoice Bank"; Rec."Invoice Bank")
                {
                    Caption = 'Invoice Bank';
                    ApplicationArea = All;
                    ToolTip = 'Specify a Bank Account Master Code field.';
                }
            }
        }

    }
}