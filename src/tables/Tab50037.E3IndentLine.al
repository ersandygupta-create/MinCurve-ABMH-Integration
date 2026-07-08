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
            InitValue = Item;
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
                ItemMake: Record "E3 Item Make Master";
            begin
                Clear(Description);
                Clear("Unit of Measure");
                Clear("Item Make Code");
                Clear("Item Make Name");
                if Item.Get("No.") then
                    Description := Item.Description;
                "Unit of Measure" := Item."Base Unit of Measure";
                "Item Make Code" := ItemMake.Code;
                "Item Make Name" := ItemMake.Description;

                if Type = Type::" " then
                    Error('Please select Type before selecting No.');

                GetIndentHeader();
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
            Caption = 'Requested Qty';
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
        field(12; "First Vendor No."; Code[20])
        {
            Caption = 'First Vendor No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                VendorRec: Record Vendor;
            begin
                if "First Vendor No." = '' then begin
                    "First Vendor Name" := '';
                    exit;
                end;

                if VendorRec.Get("First Vendor No.") then
                    "First Vendor Name" := VendorRec.Name
                else
                    "First Vendor Name" := '';
            end;
        }

        field(13; "First Vendor Name"; Text[100])
        {
            Caption = 'First Vendor Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(14; "First Price"; Decimal)
        {
            Caption = 'First Price';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                "First Amount" := "Requested Qty" * "First Price";
            end;
        }
        field(15; "First Amount"; Decimal)
        {
            Caption = 'First Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16; "Second Vendor No."; Code[20])
        {
            Caption = 'Second Vendor No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                VendorRec: Record Vendor;
            begin
                // Vendor No. removed
                if "Second Vendor No." = '' then begin
                    "Second Vendor Name" := '';
                    exit;
                end;

                // Vendor selected
                if VendorRec.Get("Second Vendor No.") then
                    "Second Vendor Name" := VendorRec.Name
                else
                    "Second Vendor Name" := '';
            end;
        }
        field(17; "Second Vendor Name"; Text[100])
        {
            Caption = 'Second Vendor Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(18; "Second Price"; Decimal)
        {
            Caption = 'Second Price';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                "Second Amount" := "Requested Qty" * "Second Price";
            end;
        }
        field(19; "Second Amount"; Decimal)
        {
            Caption = 'Second Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(20; "Third Vendor No."; Code[20])
        {
            Caption = 'Third Vendor No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                VendorRec: Record Vendor;
            begin
                // Vendor No. removed
                if "Third Vendor No." = '' then begin
                    "Third Vendor Name" := '';
                    exit;
                end;

                // Vendor selected
                if VendorRec.Get("Third Vendor No.") then
                    "Third Vendor Name" := VendorRec.Name
                else
                    "Third Vendor Name" := '';
            end;
        }
        field(21; "Third Vendor Name"; Text[100])
        {
            Caption = 'Third Vendor Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(22; "Third Price"; Decimal)
        {
            Caption = 'Third Price';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                "Third Amount" := "Requested Qty" * "Third Price";
            end;
        }
        field(23; "Third Amount"; Decimal)
        {
            Caption = 'Third Amount';
            Editable = false;
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
            Editable = false;
            DataClassification = CustomerContent;
            TableRelation = "E3 Item Make Master".Code;
            trigger OnValidate()
            var
                ItemMake: Record "E3 Item Make Master";
            begin
                if Type = Type::Item then begin
                    if Item.Get("No.") then begin
                        Validate("Item Make Code", ItemMake.Code);
                        "Item Make Name" := ItemMake.Description;
                    end else begin
                        Clear("Item Make Code");
                        Clear("Item Make Name");
                    end;
                end;
            end;
        }
        field(26; "First Ordered Qty"; Decimal)
        {
            Caption = 'First Ordered Qty';
            DataClassification = CustomerContent;
        }
        field(27; "First Remarks"; Text[100])
        {
            Caption = 'First Remarks';
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
        field(30; "Quotation Type"; Option)
        {
            Caption = 'Quotation Type';
            OptionCaption = ' ,L1,L2,L3';
            OptionMembers = " ",L1,L2,L3;
        }
        field(31; "Second Ordered Qty"; Decimal)
        {
            Caption = 'Second Ordered Qty';
            DataClassification = CustomerContent;
        }
        field(32; "Third Ordered Qty"; Decimal)
        {
            Caption = 'Third Ordered Qty';
            DataClassification = CustomerContent;
        }
        field(33; "Second Remarks"; Text[100])
        {
            Caption = 'Second Remarks';
            DataClassification = CustomerContent;
        }
        field(34; "Third Remarks"; Text[100])
        {
            Caption = 'Third Remarks';
            DataClassification = CustomerContent;
        }
        field(35; "Remarks"; Text[100])
        {
            Caption = 'Line Remarks';
            DataClassification = CustomerContent;
        }
        field(40; "First Vendor PO Creation"; Boolean)
        {
            Caption = 'First Vendor PO Creation';
            DataClassification = CustomerContent;
        }
        field(41; "Second Vendor PO Creation"; Boolean)
        {
            Caption = 'Second Vendor PO Creation';
            DataClassification = CustomerContent;
        }
        field(42; "Third Vendor PO Creation"; Boolean)
        {
            Caption = 'Third Vendor PO Creation';
            DataClassification = CustomerContent;
        }
        field(43; "Shortcut Dimension 1 Code"; Code[10])
        {
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            ValidateTableRelation = false;
        }
        field(46; "First Purchase Order No."; Code[20])
        {
            Caption = 'First Purchase Order No.';
            DataClassification = CustomerContent;
        }
        field(47; "Second Purchase Order No."; Code[20])
        {
            Caption = 'Second Purchase Order No.';
            DataClassification = CustomerContent;
        }
        field(48; "Third Purchase Order No."; Code[20])
        {
            Caption = 'Third Purchase Order No.';
            DataClassification = CustomerContent;
        }
        field(49; "Purchase Type"; Option)
        {
            OptionCaption = 'Contract,Order,Invoice';
            OptionMembers = Contract,"Order",Invoice;
            DataClassification = CustomerContent;
        }
        field(50; "First discount %"; Decimal)
        {
            Caption = 'First discount %';
            DataClassification = CustomerContent;
        }
        field(51; "Second discount %"; Decimal)
        {
            Caption = 'Second discount %';
            DataClassification = CustomerContent;
        }
        field(52; "Third discount %"; Decimal)
        {
            Caption = 'Third discount %';
            DataClassification = CustomerContent;
        }
        field(53; "Fixed Assets No."; Code[20])
        {
            Caption = 'Fixed Assets No.';
            DataClassification = CustomerContent;
        }
        field(80285; "First Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
        field(80286; "First Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(80287; "Second Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
        field(80288; "Second Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(80289; "Third Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
        field(80290; "Third Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }


    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    local procedure GetIndentHeader()
    begin
        TestField("Document No.");
        if ("Document No." <> IndentHeader."Document No.") then begin
            IndentHeader.Reset();
            IndentHeader.SetRange("Document No.", "Document No.");
            IndentHeader.FindFirst()
        end;
    end;

    procedure SetPurchased(PurchaseOrderNo: Code[20])
    var
        IndentLineDetails: Record "E3 Indent Line";
        PrchaseLineProcessing: Record "Purchase Line";
    begin


    end;

    var
        IndentHeader: Record "E3 Indent Header";
        GLAcc: Record "G/L Account";
        Item: Record "Item";
        Res: Record "Resource";
        StdTxt: Record "Standard Text";
        FA: Record "Fixed Asset";
        ItemCharge: Record "Item Charge";

}