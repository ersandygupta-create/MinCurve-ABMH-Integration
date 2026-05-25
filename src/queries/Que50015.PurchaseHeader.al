query 50015 "Purchase Header"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'purchaseHeader';
    EntityName = 'purchaseHeader';
    EntitySetName = 'purchaseHeader';
    QueryType = API;

    elements
    {
        dataitem(purchaseHeader; "Purchase Header")
        {
            column(documentType; "Document Type") { }
            column(no; "No.") { }
            column(buyfromVendorNo; "Buy-from Vendor No.") { }
            column(orderDate; "Order Date") { }
            column(postingDate; "Posting Date") { }
            column(locationCode; "Location Code") { }
            column(shortcutDimension1Code; "Shortcut Dimension 1 Code") { }
            column(shortcutDimension2Code; "Shortcut Dimension 2 Code") { }
            column(buyfromVendorName; "Buy-from Vendor Name") { }
            column(buyfromVendorName2; "Buy-from Vendor Name 2") { }
            column(documentDate; "Document Date") { }
            column(status; Status) { }
            column(procurementType; "EDC Procurement Type") { }
        }
    }


    trigger OnBeforeOpen()
    begin

    end;
}