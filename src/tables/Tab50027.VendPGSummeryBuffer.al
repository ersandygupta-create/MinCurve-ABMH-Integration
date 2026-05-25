table 50027 "Vend PG Summary Buffer"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Vendor No."; Code[20]) { }
        field(2; "Vendor Posting Group"; Code[20]) { }
        field(3; "Opening Balance"; Decimal) { }
        field(4; "Debit Amount"; Decimal) { }
        field(5; "Credit Amount"; Decimal) { }
        field(6; "Closing Balance"; Decimal) { }
        field(7; "Balance As On Date"; Decimal) { }
        field(50; "Posting Group Name"; Text[100])
        {
            Caption = 'Posting Group Name';
        }
    }

    keys
    {
        key(PK; "Vendor No.", "Vendor Posting Group") { }
    }
}