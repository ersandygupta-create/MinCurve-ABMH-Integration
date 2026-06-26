table 50038 "E3 Indenter Master"
{
    Caption = 'Indenter';
    DataClassification = CustomerContent;
    DrillDownPageId = "E3 Indenter Master List";
    LookupPageId = "E3 Indenter Master List";

    fields
    {
        field(1; "Indenter Code"; Code[20])
        {
            Caption = 'Indenter Code';
            DataClassification = CustomerContent;
        }

        field(2; "Indenter Name"; Text[100])
        {
            Caption = 'Indenter Name';
            DataClassification = CustomerContent;
        }

        field(3; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
                GLSetup: Record "General Ledger Setup";
            begin
                Clear("Department Name");

                GLSetup.Get();

                DimensionValue.Reset();
                DimensionValue.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                DimensionValue.SetRange(Code, "Department Code");

                if DimensionValue.FindFirst() then
                    "Department Name" := DimensionValue.Name;
            end;
        }
        field(4; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(5; "Business Unit Code"; Code[20])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
                GLSetup: Record "General Ledger Setup";
            begin
                "Business Unit Name" := '';
                GLSetup.Get();
                DimensionValue.Reset();
                DimensionValue.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                DimensionValue.SetRange(Code, "Business Unit Code");

                if DimensionValue.FindFirst() then
                    "Business Unit Name" := DimensionValue.Name;
            end;
        }
        field(6; "Business Unit Name"; Text[100])
        {
            Caption = 'Business Unit Name';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(7; "Default Location Code"; Code[20])
        {
            Caption = 'Default Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
            trigger OnValidate()
            var
                LocationRec: Record Location;
            begin
                Clear("Default Location Name");

                if LocationRec.Get("Default Location Code") then
                    "Default Location Name" := LocationRec.Name;
            end;
        }

        field(8; "Default Location Name"; Text[100])
        {
            Caption = 'Default Location Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Indenter Type"; Option)
        {
            Caption = 'Indenter Type';
            OptionMembers = ,"Requested By",Indenter;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Indenter Type", "Indenter Code", "Indenter Name")
        {
            Clustered = true;
        }
    }
}