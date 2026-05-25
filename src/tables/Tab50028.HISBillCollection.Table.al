table 50028 "E3 HIS Bill Collection"
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
        field(2; "HIS Document Type"; Text[100])
        {
            Caption = 'HIS Document Type';
            DataClassification = ToBeClassified;
        }
        field(3; "Mode of Payment"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Mode of Payment';
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';
            DataClassification = CustomerContent;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(7; "External Document No."; Code[30])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
        }
        field(8; "Reference No."; Code[30])
        {
            Caption = 'Reference No.';
            DataClassification = CustomerContent;
        }
        field(9; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(10; "Validation HIS Key"; Code[50])
        {
            Caption = 'Validation HIS Key';
            DataClassification = CustomerContent;
        }
        field(11; "General Entries Created"; Boolean)
        {
            Caption = 'General Entries Created';
            DataClassification = CustomerContent;
        }
        field(12; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            DataClassification = CustomerContent;
        }
        // field(13; "Record Type"; Option)
        // {
        //     Caption = 'Record Type';
        //     OptionMembers = ,Revenue,"Revenue Cancel";
        //     DataClassification = ToBeClassified;
        // }
        // field(14; "Document Type"; Option)
        // {
        //     Caption = 'Document Type';
        //     OptionMembers = ,Invoice,"Credit Memo";
        //     DataClassification = ToBeClassified;
        // }
    }

    keys
    {
        key(PK; "Entry No.")
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