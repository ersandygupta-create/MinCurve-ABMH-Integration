table 50022 "Vendor Adv. Pay. Ag. PO"
{
    Caption = 'Vendor Adv. Pay. Ag. PO';
    DataClassification = ToBeClassified;
    LookupPageId = "Vendor Advance Pay. Against PO";
    DrillDownPageId = "Vendor Advance Pay. Against PO";

    fields
    {
        field(1; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Entry Type"; enum "E3 HIS Item Map. Entry Type")
        {
            Caption = 'Entry Type';
            DataClassification = ToBeClassified;
        }
        field(3; "PO Date"; Date)
        {
            Caption = 'PO Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Vendor Code"; Code[20])
        {
            Caption = 'Vendor Code';
            TableRelation = Vendor;
            DataClassification = ToBeClassified;
        }
        field(5; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Basic Amount"; Decimal)
        {
            Caption = 'Basic Amount';
            DataClassification = ToBeClassified;
        }
        field(7; "GST Amount"; Decimal)
        {
            Caption = 'GST Amount';
            DataClassification = ToBeClassified;
        }
        field(8; "Total PO Amount"; Decimal)
        {
            Caption = 'Total PO Amount';
            DataClassification = ToBeClassified;
        }
        field(9; "Remaining Amount"; Decimal)
        {
            Caption = 'Remaining Amount';
            DataClassification = ToBeClassified;
        }
        field(10; "Total Applied Amount"; Decimal)
        {
            Caption = 'Total Applied Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Entry Type" = filter("Initial Entry"), "Purchase Order No." = field("Purchase Order No.")));
            Editable = false;
        }
        field(11; ValidationHISKey; Text[30])
        {
            Caption = 'ValidationHISKey';
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(PK; "Purchase Order No.", "Entry Type")
        {
            Clustered = true;
        }

    }
    fieldgroups
    {
        fieldgroup(DropDown; "Entry Type", "Purchase Order No.", "Vendor Code", "Vendor Name", "Total PO Amount", "Total Applied Amount", "Remaining Amount")
        {
        }

    }
}
