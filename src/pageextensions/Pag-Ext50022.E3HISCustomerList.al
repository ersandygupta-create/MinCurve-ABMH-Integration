pageextension 50022 "E3 HIS Customer List" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field("P.A.N. No."; Rec."P.A.N. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the P.A.N. No. field.';
            }
            field("GST Registration No."; Rec."GST Registration No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GST Registration No. field.';
            }
        }
    }
}
