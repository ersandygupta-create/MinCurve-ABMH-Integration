table 50030 "E3 Gate Entry Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            BlankZero = true;
            MinValue = 1;
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(2; "Gate Pass Type"; Enum "E3 Gate Pass Type")
        {
            Caption = 'Gate Pass Type';
            DataClassification = CustomerContent;
        }
        field(3; "Entry Type"; Enum "E3 Gate Pass Entry Type")
        {
            Caption = 'Entry Type';
            DataClassification = CustomerContent;
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(5; "Purpose Code"; Code[20])
        {
            Caption = 'Purpose Code';
            DataClassification = CustomerContent;
        }
        field(6; "Person/Mode"; Code[20])
        {
            Caption = 'Person/Mode';
            DataClassification = CustomerContent;
        }
        field(7; "Vehicle No."; Code[30])
        {
            Caption = 'Vehicle No.';
            DataClassification = CustomerContent;
        }
        field(8; "LR No."; Code[30])
        {
            Caption = 'LR No.';
            DataClassification = CustomerContent;
        }
        field(9; "Posting Date/Time"; DateTime)
        {
            Caption = 'Posting Date/Time';
            DataClassification = CustomerContent;
        }
        field(10; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(11; "To Destination"; Text[100])
        {
            Caption = 'To Destination';
            DataClassification = CustomerContent;
        }
        field(12; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
            TableRelation = "Vendor";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                "Vendor Name" := '';
                if Vendor.Get("Vendor No.") then
                    "Vendor Name" := Vendor.Name;
            end;
        }
        field(13; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = CustomerContent;
        }
        field(14; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
        }
        field(15; Status; Enum "E3 Gate Pass Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(16; "Expected Return Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Return Date';
        }
        field(17; "Reference Document No."; Code[20])
        {
            Caption = 'Reference Document No.';
            DataClassification = CustomerContent;
        }
        field(18; Remarks; Text[150])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        Vendor: Record Vendor;

}