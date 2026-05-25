pageextension 50068 "Bank Acc. Recon Lines Ext" extends "Bank Acc. Reconciliation Lines"
{
    layout
    {
        addafter(Difference)
        {
            field("E3 UTR No."; Rec."E3 UTR No.")
            {
                Caption = 'UTR No.';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}