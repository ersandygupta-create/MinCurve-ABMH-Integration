pageextension 50002 "E3 HIS Vendor Bank Acc. Card" extends "Vendor Bank Account Card"
{
    layout
    {
        addlast(General)
        {
            field("E3 IFSC Code"; Rec."E3 IFSC Code")
            {
                Caption = 'IFSC Code';
                ToolTip = 'Enter IFDC Code of Bank Account.';
                ApplicationArea = all;
            }
        }
    }
}
