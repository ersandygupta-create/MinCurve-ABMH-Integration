table 50049 "HIS Report Buffer"
{
    DataClassification = CustomerContent;
    TableType = Temporary;

    fields
    {
        field(1; UHID; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'UHID';
        }
        field(2; "Patient Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Patient Name';
        }
        field(3; "Advance Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Advance Amount';
        }
        field(4; "Refund Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Refund Amount';
        }
        field(5; "Settlement Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Settlement Amount';
        }
        field(6; "Refund Settlement Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Refund Settlement Amount';
        }
    }

    keys
    {
        key(PK; UHID)
        {
            Clustered = true;
        }
    }
}