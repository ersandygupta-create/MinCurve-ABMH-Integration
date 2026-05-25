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

    }
}
