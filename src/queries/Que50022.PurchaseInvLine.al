query 50022 "Purchase Invoice Line"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'purchaseInvLine';
    EntityName = 'purchaseInvLine';
    EntitySetName = 'purchaseInvLine';
    QueryType = API;

    elements
    {
        dataitem(PurchInvLine; "Purch. Inv. Line")
        {
            column(buyfromVendorNo; "Buy-from Vendor No.") { }
            column(documentNo; "Document No.") { }
            column(lineNo; "Line No.") { }
            column(no; "No.") { }
            column(locationCode; "Location Code") { }
            column(expectedReceiptDate; "Expected Receipt Date") { }
            column(description; Description) { }
            column(description2; "Description 2") { }
            column(quantity; Quantity) { }
            column(directUnitCost; "Direct Unit Cost") { }
            column(unitCostLCY; "Unit Cost (LCY)") { }
            column(lineDiscount; "Line Discount %") { }
            column(lineDiscountAmount; "Line Discount Amount") { }
            column(lineAmount; "Line Amount") { }
            column(amount; Amount) { }
            column(amountIncludingVAT; "Amount Including VAT") { }
            column(receiptNo; "Receipt No.") { }
            column(receiptLineNo; "Receipt Line No.") { }
            column(orderNo; "Order No.") { }
            column(orderLineNo; "Order Line No.") { }
            column(paytoVendorNo; "Pay-to Vendor No.") { }
            column(postingDate; "Posting Date") { }
            column(buyfromVendorName; "Buy-from Vendor Name") { }
            column(systemCreatedAt; SystemCreatedAt) { }
            column(systemModifiedAt; SystemModifiedAt) { }
            column(gstGroupCode; "GST Group Code") { }
            column(hsnSACCode; "HSN/SAC Code") { }
            column(shortcutDimension1Code; "Shortcut Dimension 1 Code") { }
        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}