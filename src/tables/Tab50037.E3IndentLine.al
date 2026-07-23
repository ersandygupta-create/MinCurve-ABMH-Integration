table 50037 "E3 Indent Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            TableRelation = "E3 Indent Header";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateHeaderValues();
            end;

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
            begin
                UpdateHeaderValues();
                Clear(Description);
                Clear("Unit of Measure");
                if Item.Get("No.") then
                    Description := Item.Description;
                "Unit of Measure" := Item."Base Unit of Measure";

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
        field(10; "Remarks"; Text[100])
        {
            Caption = 'Line Remarks';
            DataClassification = CustomerContent;
        }
        field(11; "Approved Qty"; Decimal)
        {
            Caption = 'Approved Qty';
            DataClassification = CustomerContent;
        }
        field(12; "Requested Received Date"; Date)
        {
            Caption = 'Requested Received Date';
            DataClassification = CustomerContent;
        }
        field(13; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                VendorRec: Record Vendor;
            begin
                if "Vendor No." = '' then begin
                    "Vendor Name" := '';
                    exit;
                end;

                if VendorRec.Get("Vendor No.") then
                    "Vendor Name" := VendorRec.Name
                else
                    "Vendor Name" := '';
            end;
        }
        field(14; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; "Quotation Price"; Decimal)
        {
            Caption = 'Price';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                "Quotation Amount" := "Approved Qty" * "Quotation Price";
            end;
        }
        field(16; "Quotation Amount"; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(17; "Entry No."; Code[50])
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(18; "Item Make Code"; Code[30])
        {
            Caption = 'Item Make Code';
            //Editable = false;
            DataClassification = CustomerContent;
            TableRelation = "E3 Item Make Master";
            trigger OnValidate()
            var
                ItemMake: Record "E3 Item Make Master";
            begin
                "Item Make Name" := '';

                if "Item Make Code" = '' then
                    exit;

                if ItemMake.Get("Item Make Code") then
                    "Item Make Name" := ItemMake.Description;
            end;
        }
        field(19; "Ordered Qty"; Decimal)
        {
            Caption = 'Ordered Qty';
            DataClassification = CustomerContent;
        }
        field(20; "Quotation Remarks"; Text[100])
        {
            Caption = 'Quotation Remarks';
            DataClassification = CustomerContent;
        }
        field(21; "Item Make Name"; Text[60])
        {
            Caption = 'Item Make Name';
            //Editable = false;
            DataClassification = CustomerContent;
        }
        field(22; "Critical Item"; Boolean)
        {
            Caption = 'Critical Item';
            DataClassification = CustomerContent;
        }
        field(23; "Quotation Type"; Option)
        {
            Caption = 'Quotation Type';
            OptionCaption = ' ,L1';
            OptionMembers = " ",L1;
        }
        field(24; "Vendor PO Creation"; Boolean)
        {
            Caption = 'Vendor PO Creation';
            DataClassification = CustomerContent;
        }
        field(25; "Shortcut Dimension 1 Code"; Code[10])
        {
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            ValidateTableRelation = false;
        }
        field(26; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            DataClassification = CustomerContent;
        }
        field(27; "Purchase Type"; Option)
        {
            OptionCaption = 'Contract,Order,Invoice';
            OptionMembers = Contract,"Order",Invoice;
            DataClassification = CustomerContent;
        }
        field(28; "discount %"; Decimal)
        {
            Caption = 'discount %';
            DataClassification = CustomerContent;
        }
        field(29; "Fixed Assets No."; Code[20])
        {
            Caption = 'Fixed Assets No.';
            DataClassification = CustomerContent;
        }
        field(30; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Editable = true;
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
        }
        field(31; "Payment Terms"; Code[10])
        {
            Caption = 'Payment Terms';
            DataClassification = CustomerContent;
            TableRelation = "Payment Terms";
        }
        field(32; "Delivery Terms"; Text[75])
        {
            Caption = 'Devlivery Terms';
            DataClassification = CustomerContent;
        }
        field(33; "AMC Amount"; Decimal)
        {
            Caption = 'AMC Amount';
            DataClassification = CustomerContent;
        }
        field(34; "CMC Amount"; Decimal)
        {
            Caption = 'CMC Amount';
            DataClassification = CustomerContent;
        }
        field(35; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(36; Released; Boolean)
        {
            Caption = 'Released';
            DataClassification = CustomerContent;
        }
        field(37; "Split Line"; Boolean)
        {
            Caption = 'Split Line';
            DataClassification = CustomerContent;
        }
        field(38; "Original Request Qty"; Decimal)
        {
            Caption = 'Original Request Qty';
            DataClassification = CustomerContent;
        }
        field(39; "Created PO Qty"; Decimal)
        {
            Caption = 'Created PO Qty';
            DataClassification = CustomerContent;
        }
        field(40; "Short Close"; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(41; "PO Created"; Boolean)
        {
            Caption = 'PO Created';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80285; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
        field(80286; "Currency Factor"; Decimal)
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

    trigger OnInsert()
    begin
        UpdateHeaderValues();
    end;

    local procedure UpdateHeaderValues()
    var
        IndentHeader: Record "E3 Indent Header";
    begin
        if ("Document No." = '') then
            exit;

        if IndentHeader.Get("Document No.") then begin
            "Entry No." := IndentHeader."Entry No.";
            "Requested Received Date" := IndentHeader."Expected Receive Date";
            "Location Code" := IndentHeader."Location Code";
            "Shortcut Dimension 1 Code" := IndentHeader."Shortcut Dimension 1 Code";
            "Shortcut Dimension 2 Code" := IndentHeader."Shortcut Dimension 2 Code";
        end;
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