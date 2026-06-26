table 50037 "E3 Indent Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            TableRelation = "E3 Indent Header";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Type; Enum Type)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation = IF (Type = const(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge"
            ELSE
            IF (Type = CONST(Item)) "item" WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                Item: Record Item;
            begin
                Clear(Description);
                Clear("Unit of Measure");
                Clear("Item Make Code");
                Clear("Item Make Name");
                if Item.Get("No.") then
                    Description := Item.Description;
                "Unit of Measure" := Item."Base Unit of Measure";


                CASE Type OF
                    Type::" ":
                        BEGIN
                            StdTxt.GET("No.");
                            Description := StdTxt.Description;
                        END;
                    Type::"G/L Account":
                        BEGIN
                            GLAcc.GET("No.");
                            GLAcc.TESTFIELD("Direct Posting", TRUE);
                            Description := GLAcc.Name;
                        END;
                    Type::Item:
                        BEGIN
                            Item.GET("No.");
                            Item.TESTFIELD(Blocked, FALSE);
                            Item.TESTFIELD("Gen. Prod. Posting Group");
                            Description := Item.Description;
                        END;
                    Type::Resource:
                        BEGIN
                            Res.GET("No.");
                            Res.TESTFIELD(Blocked, FALSE);
                            Res.TESTFIELD("Gen. Prod. Posting Group");
                            Description := Res.Name;
                        END;
                    Type::"Fixed Asset":
                        BEGIN
                            FA.GET("No.");
                            FA.TESTFIELD(Inactive, FALSE);
                            FA.TESTFIELD(Blocked, FALSE);
                            Description := FA.Description;
                        END;
                    Type::"Charge (Item)":
                        BEGIN
                            ItemCharge.GET("No.");
                            Description := ItemCharge.Description;
                        END;
                END;

            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(6; "Unit of Measure"; Code[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(7; "Requested Qty"; Decimal)
        {
            Caption = 'Requested';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if ("Requested Qty" <> 0) then
                    Amount := "Requested Qty" * "Unit Cost";
            end;
        }
        field(8; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Amount := "Requested Qty" * "Unit Cost";
            end;
        }
        field(9; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(10; "Approved Qty"; Decimal)
        {
            Caption = 'Approved Qty';
            DataClassification = CustomerContent;
        }
        field(11; "Requested Received Date"; Date)
        {
            Caption = 'Requested Received Date';
            DataClassification = CustomerContent;
        }
        field(12; "First Price"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Second Price"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Third Price"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(15; "First Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16; "Second Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Third Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(18; "First Vendor No."; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(19; "Second Vendor No."; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(20; "Third Vendor No."; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(21; "Quotation No."; Option)
        {
            OptionMembers = "Quote 1","Quote 2","Quote 3";
        }
        field(22; "Price Quoted"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(23; "Finalized"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(24; "Entry No."; Code[50])
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(25; "Item Make Code"; Code[30])
        {
            Caption = 'Item Make Code';
            DataClassification = CustomerContent;

        }
        field(26; "Ordered Qty"; Decimal)
        {
            Caption = 'Ordered Qty';
            DataClassification = CustomerContent;
        }
        field(27; Remarks; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(28; "Item Make Name"; Text[60])
        {
            Caption = 'Item Make Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(29; "Critical Item"; Boolean)
        {
            Caption = 'Critical Item';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        GLAcc: Record "G/L Account";
        Item: Record "Item";
        Res: Record "Resource";
        StdTxt: Record "Standard Text";
        FA: Record "Fixed Asset";
        ItemCharge: Record "Item Charge";

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