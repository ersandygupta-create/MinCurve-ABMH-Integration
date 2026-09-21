pageextension 50210 "E3 Number Sequence List" extends 456
{
    layout
    {
        addafter(Description)
        {
            field("Indent Type"; Rec."Indent Type")
            {
                ApplicationArea = All;
                ToolTip = 'Indent Type';
            }
        }
    }
}