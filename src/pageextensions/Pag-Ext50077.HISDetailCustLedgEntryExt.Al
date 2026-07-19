pageextension 50077 E3DetailedCustLedgerEntry extends 573
{
    layout
    {
        addafter(Amount)
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                ToolTip = 'External Document No';
            }
            field(Reversed; Rec.Reversed)
            {
                ApplicationArea = All;
                ToolTip = 'Reversed';

            }
        }
    }

}