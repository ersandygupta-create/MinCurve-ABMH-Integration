page 50172 "E3 Exported BLE File"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;
    Caption = 'Bank Process Data';
    SourceTable = "E3 Bank Integration";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Record Identifier"; Rec."Record Identifier")
                {
                }
                field("Payment Indicator"; Rec."Payment Indicator")
                {
                }
                field("SAP Document Number"; Rec."SAP Document Number")
                {
                }
                field("Vendor / Beneficiary Code"; Rec."Vendor / Beneficiary Code")
                {
                }
                field("Name of Beneficiary"; Rec."Name of Beneficiary")
                {
                }
                field("Instrument Amount"; Rec."Instrument Amount")
                {
                }
                field("Payment Date"; Rec."Payment Date")
                {
                }
                field("Cheque Number"; Rec."Cheque Number")
                {
                }
                field("Debit Account No."; Rec."Debit Account No.")
                {
                }
                field("Beneficiary Bank A/c No"; Rec."Beneficiary Bank A/c No")
                {
                }
                field("IFSC Code"; Rec."IFSC Code")
                {
                }
                field("Beneficiary Bank Name"; Rec."Beneficiary Bank Name")
                {
                }
                field("Beneficiary Add1"; Rec."Beneficiary Add1")
                {
                }
                field("Beneficiary Add 2"; Rec."Beneficiary Add 2")
                {
                }
                field("Beneficiary Add 3"; Rec."Beneficiary Add 3")
                {
                }
                field("Beneficiary Add 4"; Rec."Beneficiary Add 4")
                {
                }
                field("Beneficiary Zip"; Rec."Beneficiary Zip")
                {
                }
                field("Debit Narration"; Rec."Debit Narration")
                {
                }
                field("Print Location"; Rec."Print Location")
                {
                }
                field("Payable Location"; Rec."Payable Location")
                {
                }
                field("Fiscal Year"; Rec."Fiscal Year")
                {
                }
                field("Company Code"; Rec."Company Code")
                {
                }
                field("Email ID"; Rec."Email ID")
                {
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                }
                field("AADHAR Number"; Rec."AADHAR Number")
                {
                }
                field("Bene LEI Number"; Rec."Bene LEI Number")
                {
                }
                field("Bene LEI Expiry Date"; Rec."Bene LEI Expiry Date")
                {
                }
                field("Duplicate Validation Field"; Rec."Duplicate Validation Field")
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                Caption = 'Action';

                trigger OnAction()
                begin
                end;
            }
        }
    }
}