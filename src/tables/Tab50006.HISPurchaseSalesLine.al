table 50006 "E3 HIS Purchase Line"
{
    Caption = 'HIS Purchase Line';
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
        field(4; "Item ID"; Code[20])
        {
            Caption = 'Item ID';
            DataClassification = CustomerContent;
        }
        field(5; "Item Name"; Text[100])
        {
            Caption = 'Item Name';
            DataClassification = CustomerContent;
        }
        field(6; "Received Qty"; Decimal)
        {
            Caption = 'Received Qty';
            DataClassification = CustomerContent;
        }
        field(7; "Free Qty"; Decimal)
        {
            Caption = 'Free Qty';
            DataClassification = CustomerContent;
        }
        field(8; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
        }
        field(9; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(10; "HSN Code"; Code[20])
        {
            Caption = 'HSN Code';
            TableRelation = "HSN/SAC".Code where("GST Group Code" = field("GST Group Code"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(11; "Gross Amount"; Decimal)
        {
            Caption = 'Gross Amount';
            DataClassification = CustomerContent;
        }
        field(12; Discount; Decimal)
        {
            Caption = 'Discount';
            DataClassification = CustomerContent;
        }
        field(13; "CGST Amount"; Decimal)
        {
            Caption = 'CGST Amount';
            DataClassification = CustomerContent;
        }
        field(14; "SGST Amount"; Decimal)
        {
            Caption = 'SGST Amount';
            DataClassification = CustomerContent;
        }
        field(15; "IGST Amount"; Decimal)
        {
            Caption = 'IGST Amount';
            DataClassification = CustomerContent;
        }
        field(16; "BCD Amount"; Decimal)
        {
            Caption = 'BCD Amount';
            DataClassification = CustomerContent;
        }
        field(17; "EDU Cess Amount"; Decimal)
        {
            Caption = 'EDU Cess Amount';
            DataClassification = CustomerContent;
        }
        field(18; "HEduCess Amount"; Decimal)
        {
            Caption = 'HEduCess Amount';
            DataClassification = CustomerContent;
        }
        field(19; "Other Charges"; Decimal)
        {
            Caption = 'Other Charges';
            DataClassification = CustomerContent;
        }
        field(20; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = IF ("Item Type" = const(" ")) "Standard Text"
            ELSE
            IF ("Item Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Item Type" = CONST(Resource)) Resource
            ELSE
            IF ("Item Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Item Type" = CONST("Charge (Item)")) "Item Charge"
            ELSE
            IF ("Item Type" = CONST(Item)) "item" WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;
            trigger OnValidate()

            begin

                GetHISIntegrationPurchaseSalesHdr();
                CASE "ITEM Type" OF
                    "ITEM Type"::" ":
                        BEGIN
                            StdTxt.GET("Item No.");
                            "Item Name" := StdTxt.Description;
                        END;
                    Type::"G/L Account":
                        BEGIN
                            GLAcc.GET("Item No.");
                            GLAcc.TESTFIELD("Direct Posting", TRUE);
                            "Item Name" := GLAcc.Name;
                            "Credit Type" := GLAcc."GST Credit";
                        END;
                    Type::Item:
                        BEGIN
                            Item.GET("Item No.");
                            Item.TESTFIELD(Blocked, FALSE);
                            Item.TESTFIELD("Gen. Prod. Posting Group");
                            "Item Name" := Item.Description;
                            "GST Group Code" := Item."GST Group Code";
                            "HSN Code" := Item."HSN/SAC Code";
                            "Credit Type" := Item."GST Credit";
                        END;
                    Type::Resource:
                        BEGIN
                            Res.GET("item No.");
                            Res.TESTFIELD(Blocked, FALSE);
                            Res.TESTFIELD("Gen. Prod. Posting Group");
                            "Item Name" := Res.Name;
                            "GST Group Code" := Res."GST Group Code";
                            "HSN Code" := Res."HSN/SAC Code";
                        END;
                    Type::"Fixed Asset":
                        BEGIN
                            FA.GET("item No.");
                            FA.TESTFIELD(Inactive, FALSE);
                            FA.TESTFIELD(Blocked, FALSE);
                            "Item Name" := FA.Description;
                            "GST Group Code" := FA."GST Group Code";
                            "HSN Code" := FA."HSN/SAC Code";
                            "Credit Type" := FA."GST Credit";
                        END;
                    Type::"Charge (Item)":
                        BEGIN
                            ItemCharge.GET("Item No.");
                            "Item Name" := ItemCharge.Description;
                            "GST Group Code" := ItemCharge."GST Group Code";
                            "HSN Code" := ItemCharge."HSN/SAC Code";
                        END;
                END;
                IF HISIntegrationPurchaseSalesHdr."Location Code" <> '' THEN BEGIN
                    "Location Code" := HISIntegrationPurchaseSalesHdr."Location Code";
                    "Shortcut Dimension 1 Code" := HISIntegrationPurchaseSalesHdr."Shortcut Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := HISIntegrationPurchaseSalesHdr."Shortcut Dimension 2 Code";

                END;

            end;

        }
        field(21; "CGST per"; Decimal)
        {
            Caption = 'CGST per';
            DataClassification = CustomerContent;
        }
        field(22; "SGST Per"; Decimal)
        {
            Caption = 'SGST Per';
            DataClassification = CustomerContent;
        }
        field(23; "IGST per"; Decimal)
        {
            Caption = 'IGST per';
            DataClassification = CustomerContent;
        }
        field(24; "Total Percentage"; Decimal)
        {
            Caption = 'Total Percentage';
            DataClassification = CustomerContent;
        }
        field(25; "Item Type"; Enum "Purchase Line Type")
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
        }
        field(26; "Purchase Account"; Code[20])
        {
            Caption = 'Purchase Account';
            DataClassification = CustomerContent;
        }
        field(28; "GST Group Code"; Code[20])
        {
            Caption = 'GST Group Code';
            TableRelation = "GST Group";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(29; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
        }
        field(30; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
        }
        field(31; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = CustomerContent;
        }
        field(32; "Record Type"; Option)
        {
            Caption = 'Record Type';
            OptionMembers = ,GRN,"GRN Return",Sales,"Sales Return";
            DataClassification = CustomerContent;
        }
        field(33; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = ,Order,"Return Order";
            DataClassification = CustomerContent;
        }
        field(34; "Credit Type"; Enum "GST Credit")
        {
            Caption = 'Credit Type';
            DataClassification = CustomerContent;
        }
        field(35; "Fixed Assets No."; Code[20])
        {
            Caption = 'Fixed Assets No.';
            DataClassification = CustomerContent;
        }
        field(36; "HIS Type"; Enum "E3 HIS Type")
        {
            Caption = 'HIS Type';
            DataClassification = CustomerContent;
        }
        field(37; "HIS Item Type"; Enum "E3 HIS Item Type")
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
        }
        field(38; "Shortcut Dimension 3 Code"; Code[20])
        {
            //CaptionClass = '1,1,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(100; "Service Category"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Service Category';
        }
        field(101; "Service Item ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item ID';
        }
        field(102; "Service Item Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Name';
        }
        field(103; "SACHSNCODE"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'SACHSNCODE';
        }
        field(104; "ServiceItemCode"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ServiceItemCode';
        }
        field(105; "GST Group"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'GST Group';
        }
        field(106; "Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
        }
        field(107; "MOU Discount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MOU Discount';
        }
        field(108; "Add on Discount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Add on Discount';
        }
        field(109; "Net Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Amount';
        }
        field(110; "Taxable Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Taxable Amount';
        }
        field(111; "Patient Payable"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Patient Payable';
        }
        field(112; "Payor Payable"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Payor Payable';
        }
        field(113; "Item Category"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Category';
        }
        field(114; "Item Sub Category"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Sub Category';
        }
        field(115; "Discount %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Discount %';
        }
        field(116; "Batch No"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Batch No';
        }
        field(117; "Expiry Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Expiry Date';
        }
        field(118; "Manufacturer Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Manufacturer Name';
        }
        field(119; "Unit of Measurement"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measurement';
        }
        field(120; "Pack Size"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pack Size';
        }
        field(121; "Item Category Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Category Name';
        }
    }
    keys
    {
        key(PK; "Entry No.", "Record Type", "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    local procedure GetHISIntegrationPurchaseSalesHdr()
    begin
        TestField("Record Type");
        TestField("Document Type");
        TestField("Document No.");
        IF ("Record Type" <> HISIntegrationPurchaseSalesHdr."Record Type") OR ("Document Type" <> HISIntegrationPurchaseSalesHdr."Document Type") OR
            ("Document No." <> HISIntegrationPurchaseSalesHdr."Document No.") THEN BEGIN
            HISIntegrationPurchaseSalesHdr.Reset();
            HISIntegrationPurchaseSalesHdr.SetRange("Record Type", "Record Type");
            HISIntegrationPurchaseSalesHdr.SetRange("Document Type", "Document Type");
            HISIntegrationPurchaseSalesHdr.SetRange("Document No.", "Document No.");
            HISIntegrationPurchaseSalesHdr.FindFirst();

        END;
    end;

    trigger OnInsert()
    BEGIN
        GetHISIntegrationPurchaseSalesHdr();
    END;

    var
        HISIntegrationPurchaseSalesHdr: Record "E3 HIS Purchase Header";
        GLAcc: Record "G/L Account";
        Item: Record "Item";
        Res: Record "Resource";
        StdTxt: Record "Standard Text";
        FA: Record "Fixed Asset";
        ItemCharge: Record "Item Charge";
}
