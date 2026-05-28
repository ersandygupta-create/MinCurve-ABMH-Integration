table 50033 "E3AdvanceSetllementSetup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; VendorPostingGroup; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group".Code;
            Caption = 'Vendor Posting Group';

        }
        field(2; Enable; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Enable';
        }
    }

    keys
    {
        key(Key1; VendorPostingGroup)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}