table 50042 E3SettlementType
{
    DataClassification = ToBeClassified;
    Caption = 'Settlement Type';

    fields
    {
        field(1; SettlementType; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Settlement Type';

        }
        field(2; PostApplication; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Post Application';
        }
    }

    keys
    {
        key(PK; SettlementType)
        {
            Clustered = true;

        }
    }

}