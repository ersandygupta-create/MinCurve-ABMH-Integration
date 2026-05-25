pageextension 50006 "E3 HIS Cust. Ledger Entries" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("External Document No.")
        {
            field("E3 HIS Module"; Rec."E3 HIS Module")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("E3 HIS Document Type"; Rec."E3 HIS Document Type")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("E3 Receipt No."; Rec."E3 Receipt No.")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("E3 UHID"; Rec."E3 UHID")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("E3 Patient Name"; Rec."E3 Patient Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("E3 Encounter No."; Rec."E3 Encounter No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("E3 Doctor Name"; Rec."E3 Doctor Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("E3 Speciality"; Rec."E3 Speciality")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("E3 Sponsor Code"; Rec."E3 Sponsor Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("E3 Sponsor Name"; Rec."E3 Sponsor Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("E3 Payer Code"; Rec."E3 Payer Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("E3 Payer Name"; Rec."E3 Payer Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
