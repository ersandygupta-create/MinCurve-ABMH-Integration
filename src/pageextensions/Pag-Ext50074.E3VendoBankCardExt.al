pageextension 50074 "E3 Vendor Bank Card Ext" extends "Vendor Bank Account Card"
{
    layout
    {
        addafter("Transit No.")
        {
            field("Branch Name"; Rec."Branch Name")
            {
                ApplicationArea = All;
            }
            field("IFSC Code"; Rec."E3 IFSC Code")
            {
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