tableextension 50005 "E3 HIS Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(50000; "E3 Capex Type"; Enum "E3 Capex Type")
        {
            Caption = 'Capex Type';
            DataClassification = CustomerContent;
        }
        field(50001; "E3 Work Order Type"; Enum "E3 Work Order Type")
        {
            Caption = 'Work Order Type';
            DataClassification = CustomerContent;
        }

        field(50002; "E3 Item Type"; Enum "E3 HIS Item Type")
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
        }
        field(50004; "E3 Delivery Terms"; Text[150])
        {
            Caption = 'Delivery Terms';
            DataClassification = CustomerContent;
        }
        field(50005; "Store Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Store Name';
        }
        field(50006; "Advance PO"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Advance PO';
            TableRelation = "Vendor Adv. Pay. Ag. PO" where("Vendor Code" = field("Buy-from Vendor No."));
            trigger OnLookup()
            var
                AdvancedPO: Record "Vendor Adv. Pay. Ag. PO";
            begin
                // Check if Advance PO already exists for this Purchase Order
                AdvancedPO.Reset();
                AdvancedPO.SetRange("Purchase Order No.", Rec."No.");
                AdvancedPO.SetRange("Entry Type", AdvancedPO."Entry Type"::"Purchase Order");

                if not AdvancedPO.FindFirst() then begin
                    // Create new record only if it does not exist
                    AdvancedPO.Init();
                    AdvancedPO."Entry Type" := AdvancedPO."Entry Type"::"Purchase Order";
                    AdvancedPO."Purchase Order No." := Rec."No.";
                    AdvancedPO."Vendor Code" := Rec."Buy-from Vendor No.";
                    AdvancedPO."Vendor Name" := Rec."Buy-from Vendor Name";
                    AdvancedPO.Insert(true);
                end;

                // Update Purchase Order Advance PO field
                if AdvancedPO."Purchase Order No." <> '' then begin
                    Rec.Validate("Advance PO", AdvancedPO."Purchase Order No.");
                    Rec.Modify(true);
                end;

                // Open existing/new record
                Page.Run(Page::"Vendor Advance Pay. Against PO", AdvancedPO);
            end;
        }
        field(50007; "Purchase Narration"; Text[160])
        {
            Caption = 'Purchase Narration';
            DataClassification = CustomerContent;
        }
        field(50008; "HIS GRN Amount"; Decimal)
        {
            Caption = 'HIS GRN Amount';
            Editable = false;
        }
        field(50009; "Integration PO"; Boolean)
        {
            Caption = 'Integration PO';
            Editable = false;
        }
    }
    trigger OnInsert()
    begin
        if "Advance PO" = '' then
            "Advance PO" := "No.";
    end;
}