page 50159 "POne GRN Lines API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'pOneGRNLinesAPI';
    DelayedInsert = true;
    AutoSplitKey = true;
    EntityName = 'pOnegrnLine';
    EntitySetName = 'pOnegrnLines';
    PageType = API;
    SourceTable = "E3 HIS Purchase Line";
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(itemType; Rec."Item Type")
                {
                    Caption = 'Item Type';
                }
                field(itemID; Rec."Item ID")
                {
                    Caption = 'Item ID';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(itemName; Rec."Item Name")
                {
                    Caption = 'Item Name';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(receivedQty; Rec."Received Qty")
                {
                    Caption = 'Received Qty';
                }
                field(freeQty; Rec."Free Qty")
                {
                    Caption = 'Free Qty';
                }
                field(grossAmount; Rec."Gross Amount")
                {
                    Caption = 'Gross Amount';
                }
                field(gstGroupCode; Rec."GST Group Code")
                {
                    Caption = 'GST Group Code';
                }
                field(hsnCode; Rec."HSN Code")
                {
                    Caption = 'HSN Code';
                }
                field(gstCreditType; Rec."Credit Type")
                {
                    Caption = 'Credit Type';
                }
                field(totalPercentage; Rec."Total Percentage")
                {
                    Caption = 'Total Percentage';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(discount; Rec.Discount)
                {
                    Caption = 'Discount';
                }
                field(otherCharges; Rec."Other Charges")
                {
                    Caption = 'Other Charges';
                }
                field(purchaseAccount; Rec."Purchase Account")
                {
                    Caption = 'Purchase Account';
                }
                // field(locationCode; Rec."Location Code")
                // {
                //     Caption = 'Location Code';
                // }
                // field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                // {
                //     Caption = 'Shortcut Dimension 1 Code';
                // }
                // field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                // {
                //     Caption = 'Shortcut Dimension 2 Code';
                // }
                // field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                // {
                //     Caption = 'Shortcut Dimension 3 Code';
                // }
                field(SGSTPer; Rec."SGST Per")
                {
                    Caption = 'SGST Per';
                }
                field(CGSTPer; Rec."CGST Per")
                {
                    Caption = 'CGST Per';
                }
                field(IGSTPer; Rec."IGST Per")
                {
                    Caption = 'IGST Per';
                }
                field(SGSTAmount; Rec."SGST Amount")
                {
                    Caption = 'SGST Amount';
                }
                field(CGSTAmount; Rec."CGST Amount")
                {
                    Caption = 'CGST Amount';
                }
                field(IGSTAmount; Rec."IGST Amount")
                {
                    Caption = 'IGST Amount';
                }
                field(BCDAmount; Rec."BCD Amount")
                {
                    Caption = 'BCD Amount';
                }
                field(EDUCessAmount; Rec."EDU Cess Amount")
                {
                    Caption = 'EDU Cess Amount';
                }
                field(HEduCessAmount; Rec."HEduCess Amount")
                {
                    Caption = 'HEduCess Amount';
                }
                field(hisType; Rec."HIS Type")
                {
                    Caption = 'HIS Type';
                }
                field(hisItemType; Rec."HIS Item Type")
                {
                    Caption = 'HIS Item Type';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(itemCategory; Rec."Item Category")
                {
                    Caption = 'Item Category';
                }
                field(itemSubCategory; Rec."Item Sub Category")
                {
                    Caption = 'Item Sub Category';
                }
                field(discountPer; Rec."Discount %")
                {
                    Caption = 'Discount %';
                }
                field(batchNo; Rec."Batch No")
                {
                    Caption = 'Batch No';
                }
                field(expiryDate; Rec."Expiry Date")
                {
                    Caption = 'Expiry Date';
                }
                field(manufacturerName; Rec."Manufacturer Name")
                {
                    Caption = 'Manufacturer Name';
                }
                field(unitOfMeasurement; Rec."Unit of Measurement")
                {
                    Caption = 'Unit of Measurement';
                }
                field(packSize; Rec."Pack Size")
                {
                    Caption = 'Pack Size';
                }
                field(itemCategoryName; Rec."Item Category Name")
                {
                    Caption = 'Item Category Name';
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec.HasFilter() then begin
            if Rec.GetFilter("Record Type") = 'GRN' then begin
                Rec.Validate("Record Type", Rec."Record Type"::GRN);
                Rec."Document Type" := Rec."Document Type"::Order;
            end else begin
                Rec.Validate("Record Type", Rec."Record Type"::"GRN Return");
                Rec."Document Type" := Rec."Document Type"::"Return Order";
            end;
            Rec."Document No." := Rec.GetFilter("Document No.");
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec.HasFilter() then begin
            if Rec.GetFilter("Record Type") = 'GRN' then begin
                Rec.Validate("Record Type", Rec."Record Type"::GRN);
                Rec."Document Type" := Rec."Document Type"::Order;
            end else begin
                Rec.Validate("Record Type", Rec."Record Type"::"GRN Return");
                Rec."Document Type" := Rec."Document Type"::"Return Order";
            end;
            Rec."Document No." := Rec.GetFilter("Document No.");
        end;
    end;
}
