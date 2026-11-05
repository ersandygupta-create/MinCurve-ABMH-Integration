table 50048 "HIS Payment Document Mapping"
{
    DataClassification = CustomerContent;
    Caption = 'HIS payment type mapping for report';

    fields
    {
        field(1; "Payment Type"; Enum E3PaymentType)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Type';
        }
        field(2; "HIS Document Type"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'HIS Document Type';
        }
    }

    keys
    {
        key(PK; "Payment Type", "HIS Document Type")
        {
            Clustered = true;
        }
    }
}