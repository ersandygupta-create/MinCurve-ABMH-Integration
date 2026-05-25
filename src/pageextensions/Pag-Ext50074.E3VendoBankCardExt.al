pageextension 50074 "E3 Vendor Bank Card Ext" extends "Vendor Bank Account Card"
{
    layout
    {
        modify("Bank Clearing Code")
        {
            Caption = 'IFSC Code';
        }
        modify(IBAN)
        {
            Caption = 'Bank Branch Name';
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
}