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
        addafter("EDC Opex PO Series")
        {
            field("E3 Indent PO Series"; Rec."E3 Indent PO Series")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the E3 Indent PO Series field.';
            }
        }
    }
}

