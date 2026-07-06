table 50036 "E3 Indent Header"
{
    DataClassification = ToBeClassified;
    Caption = 'Indent Header';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Requested By"; Text[60])
        {
            Caption = 'Requested By';
            DataClassification = CustomerContent;
            TableRelation = "E3 Indenter Master"."Indenter Name";

            trigger OnValidate()
            var
                IndenterMaster: Record "E3 Indenter Master";
            begin
                Clear("Shortcut Dimension 2 Code");
                Clear("Department Name");
                Clear("Shortcut Dimension 1 Code");
                Clear("Business Unit Name");
                Clear("Location Code");
                Clear("Location Name");

                IndenterMaster.Reset();
                IndenterMaster.SetRange("Indenter Name", "Requested By");
                IndenterMaster.SetRange("Indenter Type", IndenterMaster."Indenter Type"::"Requested By");

                if IndenterMaster.FindFirst() then begin
                    Validate("Shortcut Dimension 2 Code", IndenterMaster."Department Code");
                    "Department Name" := IndenterMaster."Department Name";

                    Validate("Shortcut Dimension 1 Code", IndenterMaster."Business Unit Code");
                    "Business Unit Name" := IndenterMaster."Business Unit Name";

                    Validate("Location Code", IndenterMaster."Default Location Code");
                    "Location Name" := IndenterMaster."Default Location Name";
                end;
            end;
        }
        field(3; "Indent Date"; Date)
        {
            Caption = 'Indent Date';
            DataClassification = CustomerContent;
        }
        field(4; Status; Option)
        {
            OptionMembers = Open,Pending,Approved,Rejected;
            Caption = 'Status';
        }
        field(5; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
                GLSetup: Record "General Ledger Setup";
            begin
                "Business Unit Name" := '';
                GLSetup.Get();
                DimensionValue.Reset();
                DimensionValue.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                DimensionValue.SetRange(Code, "Shortcut Dimension 1 Code");

                if DimensionValue.FindFirst() then
                    "Business Unit Name" := DimensionValue.Name;
            end;
        }
        field(6; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
                GLSetup: Record "General Ledger Setup";
            begin
                "Department Name" := '';
                GLSetup.Get();
                DimensionValue.Reset();
                DimensionValue.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                DimensionValue.SetRange(Code, "Shortcut Dimension 2 Code");

                if DimensionValue.FindFirst() then
                    "Department Name" := DimensionValue.Name;
            end;
        }
        field(7; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            Editable = false;
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
            trigger OnValidate()
            var
                LocationRec: Record Location;
            begin
                "Location Name" := '';
                if LocationRec.Get("Location Code") then
                    "Location Name" := LocationRec.Name
                else
                    "Location Name" := '';
            end;
        }
        field(8; "Location Name"; Text[100])
        {
            Caption = 'Location Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "To Location Code"; Code[20])
        {
            Caption = 'To Location Code';
            Editable = false;
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
            trigger OnValidate()
            var
                LocationRec: Record Location;
            begin
                "To Location Name" := '';
                if LocationRec.Get("To Location Code") then
                    "To Location Name" := LocationRec.Name
                else
                    "To Location Name" := '';
            end;
        }
        field(11; "To Location Name"; Text[100])
        {
            Caption = 'To Location Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(12; "Expected Receive Date"; Date)
        {
            Caption = 'Expected Receive Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                IndentLine: Record "E3 Indent Line";
            begin
                IndentLine.Reset();
                IndentLine.SetRange("Document No.", "Document No.");

                if IndentLine.FindSet() then
                    repeat
                        IndentLine."Requested Received Date" := "Expected Receive Date";
                        IndentLine.Modify(true);
                    until IndentLine.Next() = 0;
            end;
        }
        field(13; "Approved By"; Text[100])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
        }
        field(14; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            BlankZero = true;
            MinValue = 1;
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(15; "Business Unit Name"; Text[100])
        {
            Caption = 'Business Unit Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16; "Requesting Staff Code"; Text[60])
        {
            Caption = 'Requesting Staff Code';
            DataClassification = CustomerContent;
            TableRelation = "E3 Indenter Master"."Indenter Code";
            trigger OnValidate()
            var
                IndenterMaster: Record "E3 Indenter Master";
            begin
                Clear("Requesting Staff Name");
                Clear("To Location Code");
                Clear("To Location Name");
                Clear("To Department Code");
                Clear("To Department Name");

                IndenterMaster.Reset();
                IndenterMaster.SetRange("Indenter Name", "Requesting Staff Code");
                IndenterMaster.SetRange("Indenter Type", IndenterMaster."Indenter Type"::Indenter);

                if IndenterMaster.FindFirst() then begin
                    "Requesting Staff Name" := IndenterMaster."Indenter Name";

                    "To Location Code" := IndenterMaster."Default Location Code";
                    "To Location Name" := IndenterMaster."Default Location Name";

                    "To Department Code" := IndenterMaster."Department Code";
                    "To Department Name" := IndenterMaster."Department Name";
                end;
            end;
        }
        field(17; Remarks; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(18; "To Department Code"; Code[20])
        {
            Caption = 'To Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            ValidateTableRelation = false;
            Editable = false;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
                GLSetup: Record "General Ledger Setup";
            begin
                "To Department Name" := '';
                GLSetup.Get();
                DimensionValue.Reset();
                DimensionValue.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                DimensionValue.SetRange(Code, "To Department Code");

                if DimensionValue.FindFirst() then
                    "To Department Name" := DimensionValue.Name;
            end;
        }
        field(19; "To Department Name"; Text[100])
        {
            Caption = 'To Department Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(20; "Approval Date Time"; DateTime)
        {
            Caption = 'Approval Date Time';
            DataClassification = CustomerContent;
        }
        field(21; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(22; "Voucher Type Code"; Code[10])
        {
            Caption = 'Voucher Type Code';
            DataClassification = CustomerContent;
            TableRelation = "E3 Voucher Type".Code;
            trigger OnValidate()
            var
                VoucherType: Record "E3 Voucher Type";
            begin
                if VoucherType.Get("Voucher Type Code") then
                    "Voucher Type Name" := VoucherType.Description
                else
                    Clear("Voucher Type Name");
            end;
        }
        field(23; "Voucher Type Name"; Text[80])
        {
            Caption = 'Voucher Type Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(24; "Requesting Staff Name"; Text[100])
        {
            Caption = 'Requesting Staff Name';
            Editable = false;
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "Document No.")
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
    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeries: Codeunit "No. Series";
    begin
        if "Document No." = '' then begin
            PurchSetup.Get();
            PurchSetup.TestField("Indent Nos.");

            "Document No." :=
                NoSeries.GetNextNo(PurchSetup."Indent Nos.", WorkDate());

            if "Indent Date" = 0D then
                "Indent Date" := Today;
        end;
    end;

    procedure AssistEdit(OldIndentHeader: Record "E3 Indent Header"): Boolean
    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeries: Codeunit "No. Series";
        IndentHeader: Record "E3 Indent Header";
    begin
        IndentHeader := Rec;

        PurchSetup.Get();
        PurchSetup.TestField("Indent Nos.");

        if NoSeries.LookupRelatedNoSeries(
            PurchSetup."Indent Nos.",
            OldIndentHeader."No. Series",
            IndentHeader."No. Series")
        then begin
            IndentHeader."Document No." := NoSeries.GetNextNo(IndentHeader."No. Series");
            Rec := IndentHeader;
            exit(true);
        end;

        exit(false);
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