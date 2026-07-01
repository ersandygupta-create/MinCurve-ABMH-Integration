table 50030 "E3 Gate Entry Header"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Document No.", "Entry Type";

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
            Editable = false;
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
        field(9; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if (Rec."Posting Date" < WorkDate()) then
                    error('Posting Date can not be before the workdate.')
            end;
        }
        field(10; "Department Code"; Code[20])
        {
            Caption = 'To Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
                GLSetup: Record "General Ledger Setup";
            begin
                "To Department Name" := '';

                GLSetup.Get();

                if DimensionValue.Get(GLSetup."Global Dimension 2 Code", "Department Code") then
                    "To Department Name" := DimensionValue.Name;
            end;
        }
        field(11; "To Destination"; Code[20])
        {
            Caption = 'To Destination';
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
            trigger OnValidate()
            var
                LocationRec: Record Location;
            begin
                if LocationRec.Get("To Destination") then
                    "Location Name" := LocationRec.Name
                else
                    "Location Name" := '';
            end;
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
        field(14; Person; Text[100])
        {
            Caption = 'Person';
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
            trigger OnValidate()
            begin
                if ("Posting Date" <> 0D) and
                   ("Expected Return Date" <> 0D) and
                   ("Posting Date" > "Expected Return Date")
                then
                    Error(
                      'Expected Return Date must be greater than or equal to Posting Date.');
            end;
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
        field(21; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(22; "Location Name"; Text[100])
        {
            Caption = 'Location Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(23; "To Department Name"; Text[100])
        {
            Caption = 'To Department Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(24; "From Department Code"; Code[20])
        {
            Caption = 'From Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
                GLSetup: Record "General Ledger Setup";
            begin
                "From Department Name" := '';
                GLSetup.Get();
                if DimensionValue.Get(GLSetup."Global Dimension 2 Code", "From Department Code") then
                    "From Department Name" := DimensionValue.Name;
            end;
        }
        field(25; "From Department Name"; Text[100])
        {
            Caption = 'From Department Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(26; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(27; "Reference Document Date"; Date)
        {
            Caption = 'Reference Document Date';
            DataClassification = CustomerContent;
        }
        field(28; "Procurement Type"; Enum "E3 Capex Type")
        {
            Caption = 'Procurement Type';
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

    trigger OnInsert()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        NoSeries: Codeunit "No. Series";
    begin
        if "Document No." = '' then begin
            PurchasesPayablesSetup.Get();
            PurchasesPayablesSetup.TestField("Gate Entry Nos.");

            Rec."No. Series" := PurchasesPayablesSetup."Gate Entry Nos.";

            "Document No." :=
                NoSeries.GetNextNo(Rec."No. Series", WorkDate(), true);
        end;
    end;


}