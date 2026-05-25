table 50012 "E3 HIS Revenue Line"
{
    Caption = 'HIS Revenue Line';
    DataClassification = ToBeClassified;

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
        field(2; "Document No."; Code[20])
        {
            Caption = 'Documment No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Item ID"; Code[20])
        {
            Caption = 'Item ID';
            DataClassification = ToBeClassified;
        }
        field(5; "Item Name"; Text[100])
        {
            Caption = 'Item Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Qty"; Decimal)
        {
            Caption = 'Qty';
            DataClassification = ToBeClassified;
        }
        field(7; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = ToBeClassified;
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(9; "HSN Code"; Code[20])
        {
            Caption = 'HSN Code';
            TableRelation = "HSN/SAC".Code where("GST Group Code" = field("GST Group Code"));
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
        }
        field(10; Discount; Decimal)
        {
            Caption = 'Discount';
            DataClassification = ToBeClassified;
        }
        field(11; "MOU Discount"; Decimal)
        {
            Caption = 'MOU Discount';
            DataClassification = ToBeClassified;
        }
        field(12; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
            DataClassification = ToBeClassified;
        }
        field(13; "Taxable Amount"; Decimal)
        {
            Caption = 'Taxable Amount';
            DataClassification = ToBeClassified;
        }
        field(14; "Patient Payable"; Decimal)
        {
            Caption = 'Patient Payable';
            DataClassification = ToBeClassified;
        }
        field(15; "Payor Payable"; Decimal)
        {
            Caption = 'Payor Payable';
            DataClassification = ToBeClassified;
        }
        field(16; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = const(" ")) "Standard Text"
            ELSE
            IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST(Resource)) Resource
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("Charge (Item)")) "Item Charge"
            ELSE
            IF ("Account Type" = CONST(Item)) "item" WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;
            trigger OnValidate()

            begin

                GetHISIntegrationSalesHdr();
                CASE "Account Type" OF
                    "Account Type"::" ":
                        BEGIN
                            StdTxt.GET("Account No.");
                            "Item Name" := StdTxt.Description;
                        END;
                    Type::"G/L Account":
                        BEGIN
                            GLAcc.GET("Account No.");
                            GLAcc.TESTFIELD("Direct Posting", TRUE);
                            "Item Name" := GLAcc.Name;
                            "Credit Type" := GLAcc."GST Credit";
                        END;
                    Type::Item:
                        BEGIN
                            Item.GET("Account No.");
                            Item.TESTFIELD(Blocked, FALSE);
                            Item.TESTFIELD("Gen. Prod. Posting Group");
                            "Item Name" := Item.Description;
                            "GST Group Code" := Item."GST Group Code";
                            "HSN Code" := Item."HSN/SAC Code";
                            "Credit Type" := Item."GST Credit";
                        END;
                    Type::Resource:
                        BEGIN
                            Res.GET("Account No.");
                            Res.TESTFIELD(Blocked, FALSE);
                            Res.TESTFIELD("Gen. Prod. Posting Group");
                            "Item Name" := Res.Name;
                            "GST Group Code" := Res."GST Group Code";
                            "HSN Code" := Res."HSN/SAC Code";
                        END;
                    Type::"Fixed Asset":
                        BEGIN
                            FA.GET("Account No.");
                            FA.TESTFIELD(Inactive, FALSE);
                            FA.TESTFIELD(Blocked, FALSE);
                            "Item Name" := FA.Description;
                            "GST Group Code" := FA."GST Group Code";
                            "HSN Code" := FA."HSN/SAC Code";
                            "Credit Type" := FA."GST Credit";
                        END;
                    Type::"Charge (Item)":
                        BEGIN
                            ItemCharge.GET("Account No.");
                            "Item Name" := ItemCharge.Description;
                            "GST Group Code" := ItemCharge."GST Group Code";
                            "HSN Code" := ItemCharge."HSN/SAC Code";
                        END;
                END;
                IF HISIntegrationSalesHdr."Location Code" <> '' THEN BEGIN
                    "Location Code" := HISIntegrationSalesHdr."Location Code";
                    "Shortcut Dimension 1 Code" := HISIntegrationSalesHdr."Shortcut Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := HISIntegrationSalesHdr."Shortcut Dimension 2 Code";

                END;

            end;

        }
        field(17; "Account Type"; Enum "Purchase Line Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(18; "Revenue Account"; Code[20])
        {
            Caption = 'Revenue Account';
            DataClassification = ToBeClassified;
        }
        field(19; "GST Group Code"; Code[20])
        {
            Caption = 'GST Group Code';
            TableRelation = "GST Group";
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
        }
        field(20; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
        }
        field(21; "Service Category"; Text[50])
        {
            Caption = 'Service Category';
            DataClassification = ToBeClassified;
        }
        field(22; "Package Patient"; Boolean)
        {
            Caption = 'Package Patient';
            DataClassification = ToBeClassified;
        }
        field(23; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
        }
        field(24; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
        }
        field(25; "Record Type"; Option)
        {
            Caption = 'Record Type';
            OptionMembers = ,Revenue,"Revenue Cancel";
            DataClassification = ToBeClassified;
        }
        field(26; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = ,Invoice,"Credit Memo";
            DataClassification = ToBeClassified;
        }
        field(27; "Credit Type"; Enum "GST Credit")
        {
            Caption = 'Credit Type';
            DataClassification = ToBeClassified;
        }
        field(28; "Shortcut Dimension 3 Code"; Code[20])
        {
            //CaptionClass = '1,1,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
        }
        field(29; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = ToBeClassified;
        }
        field(30; "Item Sub Category Code"; Code[20])
        {
            Caption = 'Item Sub Category Code';
            DataClassification = ToBeClassified;
        }
        field(31; "Service Item Code"; Code[20])
        {
            Caption = 'Service Item Code';
            DataClassification = ToBeClassified;
        }
        field(35; "Discount G/L Account"; Code[20])
        {
            Caption = 'Discount G/L Account';
            DataClassification = CustomerContent;
        }
        field(36; "MOU Discount G/L Account"; Code[20])
        {
            Caption = 'MOU Discount G/L Account';
            DataClassification = CustomerContent;
        }
        field(37; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            DataClassification = CustomerContent;
        }
        field(38; "CGST Amount"; Decimal)
        {
            Caption = 'CGST Amount';
            DataClassification = CustomerContent;
        }
        field(39; "SGST Amount"; Decimal)
        {
            Caption = 'SGST Amount';
            DataClassification = CustomerContent;
        }
        field(40; "Shortcut Dimenion 3 Code Name"; Text[50])
        {
            Caption = 'Specility Name';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.", "Record Type", "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    local procedure GetHISIntegrationSalesHdr()
    begin
        TestField("Record Type");
        TestField("Document Type");
        TestField("Document No.");
        IF ("Record Type" <> HISIntegrationSalesHdr."Record Type") OR ("Document Type" <> HISIntegrationSalesHdr."Document Type") OR
            ("Document No." <> HISIntegrationSalesHdr."Document No.") THEN BEGIN
            HISIntegrationSalesHdr.Reset();
            HISIntegrationSalesHdr.SetRange("Record Type", "Record Type");
            HISIntegrationSalesHdr.SetRange("Document Type", "Document Type");
            HISIntegrationSalesHdr.SetRange("Document No.", "Document No.");
            HISIntegrationSalesHdr.FindFirst();
        END;
    end;

    trigger OnInsert()
    BEGIN
        GetHISIntegrationSalesHdr();
    END;

    var
        HISIntegrationSalesHdr: Record "E3 HIS Revenue Header";
        GLAcc: Record "G/L Account";
        Item: Record "Item";
        Res: Record "Resource";
        StdTxt: Record "Standard Text";
        FA: Record "Fixed Asset";
        ItemCharge: Record "Item Charge";
}
