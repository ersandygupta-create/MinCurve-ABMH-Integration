pageextension 50015 "E3 HIS Purch. Invoice Subform" extends "Purch. Invoice Subform"
{
    layout
    {
        addafter("Qty. to Assign")
        {
            field("GST Reverse Charge"; Rec."GST Reverse Charge")
            {
                ApplicationArea = All;
                Editable = TRUE;
                ToolTip = 'Specifies the value of the GST Reverse Charge field.';
            }
        }
        addafter("Unit of Measure Code")
        {
            field("Pack Size"; Rec."Pack Size")
            {
                Caption = 'Pack Size';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Pack Size field.';
            }
        }

    }
}
