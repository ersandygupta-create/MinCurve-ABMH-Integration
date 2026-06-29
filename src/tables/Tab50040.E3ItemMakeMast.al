table 50040 "E3 Item Make Master"
{
    DataClassification = ToBeClassified;
    Caption = 'Item Make Master';
    DrillDownPageId = "E3 Item Make Master";
    LookupPageId = "E3 Item Make Master";

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;

        }
        field(2; Description; Text[60])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

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