table 50031 "E3 Gate Entry Line"
{
    Caption = 'Gate Entry Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            BlankZero = true;
            MinValue = 1;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Documment No.';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(5; "Item Name"; Text[100])
        {
            Caption = 'Item Name';
            DataClassification = CustomerContent;
        }
        field(6; "Variant Code"; Code[20])
        {
            Caption = 'Variant Code';
            DataClassification = CustomerContent;
        }
        field(7; "Unit of Measurement"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measurement';
            TableRelation = "Unit of Measure".Code;
        }
        field(8; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(9; "Received Qty"; Decimal)
        {
            Caption = 'Received Qty';
            DataClassification = CustomerContent;
        }
        field(10; "Pending Qty"; Decimal)
        {
            Caption = 'Pending Qty';
            DataClassification = CustomerContent;
        }
        field(11; "Estimated Value"; Decimal)
        {
            Caption = 'Estimated Value';
            DataClassification = CustomerContent;
        }
        field(12; "Asset No."; Code[20])
        {
            Caption = 'Asset No.';
            DataClassification = CustomerContent;
        }
        field(13; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;
        }
        field(14; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            DataClassification = CustomerContent;
        }
        field(15; Remarks; Text[150])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(PK; "Entry No.", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    local procedure GetGatEntryHdr()
    begin
        TestField("Document No.");
        IF ("Document No." <> GateEntryHdr."Document No.") THEN BEGIN
            GateEntryHdr.Reset();
            GateEntryHdr.SetRange("Document No.", "Document No.");
            GateEntryHdr.FindFirst();

        END;
    end;

    trigger OnInsert()
    BEGIN
        GetGatEntryHdr();
    END;

    var
        GateEntryHdr: Record "E3 Gate Entry Header";

}
