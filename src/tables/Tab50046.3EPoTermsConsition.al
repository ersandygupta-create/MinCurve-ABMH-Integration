table 50100 "PO Terms Condition Master"
{
    DataClassification = CustomerContent;
    Caption = 'PO Terms & Condition Master';
    LookupPageId = "PO Terms Condition List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(3; "Condition Text"; Text[2048])
        {
            Caption = 'Condition Text';
        }
        field(4; Active; Boolean)
        {
            Caption = 'Active';
            InitValue = true;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}

