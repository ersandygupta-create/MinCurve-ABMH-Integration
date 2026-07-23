table 50043 "E3 Released Indent Details"
{
    Caption = 'Indent Line Details';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }

        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "E3 Indent Header";
        }

        field(3; "Indent Line No."; Integer)
        {
            Caption = 'Indent Line No.';
        }

        field(4; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
        }

        field(5; "Purchase Line No."; Integer)
        {
            Caption = 'Purchase Line No.';
        }

        field(6; Type; Enum Type)
        {
            Caption = 'Type';
        }

        field(7; "No."; Code[20])
        {
            Caption = 'No.';
        }

        field(8; Description; Text[100])
        {
            Caption = 'Description';
        }

        field(9; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }

        field(10; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
        }

        field(11; "Approved Qty"; Decimal)
        {
            Caption = 'Approved Qty';
        }

        field(12; "Created PO Qty"; Decimal)
        {
            Caption = 'Created PO Qty';
        }

        field(13; "Remaining Qty"; Decimal)
        {
            Caption = 'Remaining Qty';
        }

        field(14; "Quotation Price"; Decimal)
        {
            Caption = 'Quotation Price';
        }

        field(15; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }

        field(16; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Business Unit';
        }

        field(17; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Department';
        }

        field(18; "Payment Terms"; Text[100])
        {
            Caption = 'Payment Terms';
        }

        field(19; "Delivery Terms"; Text[100])
        {
            Caption = 'Delivery Terms';
        }

        field(20; "Created Date"; Date)
        {
            Caption = 'Created Date';
        }

        field(21; "Created Time"; Time)
        {
            Caption = 'Created Time';
        }

        field(22; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(Key1; "Document No.", "Indent Line No.")
        {
        }

        key(Key2; "Purchase Order No.")
        {
        }
    }
}