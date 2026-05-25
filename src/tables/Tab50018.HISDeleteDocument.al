table 50018 "E3 HIS Delete Document"
{
    Caption = 'Delete Document';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; "Created By"; Code[50])
        {
            Caption = 'Approved By';
            Editable = false;
            TableRelation = User;
        }
        field(5; "Created Datetime"; DateTime)
        {
            Caption = 'Approved Datetime';
            Editable = false;
        }
        field(6; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            Editable = false;
            TableRelation = User;
        }
        field(7; "Approved Datetime"; DateTime)
        {
            Caption = 'Approved Datetime';
            Editable = false;
        }
        field(8; "Processed By"; Code[50])
        {
            Caption = 'Processed By';
            Editable = false;
            TableRelation = User;
        }
        field(9; "Processed Datetime"; DateTime)
        {
            Caption = 'Processed Datetime';
            Editable = false;
        }
        field(10; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Approved,Validated,Processed,Error;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Error Text"; Text[250])
        {
            Caption = 'Error Text';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "HIS Document Type"; Text[100])
        {
            Caption = 'HIS Document Type';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Datetime" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        if rec.Status <> rec.Status::Open then
            Error('You can only modify an Open record. Kindly delete this record and create new.');
    end;

    trigger OnDelete()
    begin
        if rec.Status = rec.Status::Processed then
            Error('You cannot delete the procesed record.');
    end;

}
