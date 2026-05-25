pageextension 50010 "E3 TDS Entries" extends "TDS Entries"
{
    layout
    {
        addafter("Vendor No.")
        {
            field("E3 Vendor Name"; Rec."E3 Vendor Name")
            {
                ApplicationArea = all;
                Style = StrongAccent;
                StyleExpr = true;
                ToolTip = 'Specifies the value of the Vendor Name field.';
            }

        }
    }
}
