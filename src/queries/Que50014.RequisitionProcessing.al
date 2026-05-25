query 50014 "Requisition Processing"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'requisitionProcessing';
    EntityName = 'requisitionProcessing';
    EntitySetName = 'requisitionProcessing';
    QueryType = API;

    elements
    {
        dataitem(requisitionProcessing; "EDC Requisition Processing")
        {
            column(itemType; "Item Type") { }
            column(lineNo; "Line No") { }
            column(requisitionNo; "Requisition No") { }
            column(itemNo; "Item No") { }
            column(locationCode; "Location Code") { }
            column(requiredDate; "Required Date") { }
            column(description; Description) { }
            column(quantity; Quantity) { }
            column(firstPrice; "First Price") { }
            column(firstAmount; "First Amount") { }
            column(firstVendorNo; "First Vendor No.") { }
            column(postingDate; "Posting Date") { }
            column(purchaseType; "Purchase Type") { }
            column(type; Type) { }
            column(shortcutDimension1Code; "Shortcut Dimension 1 Code") { }
            column(shortcutDimension2Code; "Shortcut Dimension 2 Code") { }
            column(model; Model) { }
            column(requestedQuantity; "Requested Quantity") { }
            column(requestedUnitofMeasure; "Requested Unit of Measure") { }
            column(firstPurchaseOrderNo; "First Purchase Order  No.") { }
            column(firstGSTPer; "First GST %") { }
            column(firstGSTAmount; "First GST Amount") { }
            column(createdBy; "Created By") { }
            column(budgetedAmount; "Budgeted Amount") { }
            column(requisitionType; "Requisition Type") { }
            column(category; Category) { }
            column(status; Status) { }
            column(firstVendorName; "First Vendor Name") { }
            column(procurementType; "Procurement Type") { }
            column(requisitionLineNo; "Requisition Line No") { }
        }
    }
    trigger OnBeforeOpen()
    begin

    end;
}