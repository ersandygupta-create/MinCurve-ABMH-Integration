table 50045 "E3 Project Master"
{
    DataClassification = ToBeClassified;
    Caption = 'Project Master';

    fields
    {
        field(1; "Project Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Code';

        }
        field(2; "Project Name"; Text[60])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Name';
        }
    }

    keys
    {
        key(PK; "Project Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Project Code", "Project Name")
        {

        }
    }

}