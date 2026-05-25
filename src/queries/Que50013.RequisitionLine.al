query 50013 "Requisition Line"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'requisitionLine';
    EntityName = 'requisitionLine';
    EntitySetName = 'requisitionLine';
    QueryType = API;

    elements
    {
        dataitem(requisitionLines; "EDC Requisition Lines")
        {
            column(requisitionNo; "Requisition No") { }
            column(locationCode; "Location Code") { }
            column(item; Item) { }
            column(description; Description) { }
            column(quantity; Quantity) { }
            column(firstVendorNo; "First Vendor No.") { }
            column(status; Status) { }
            column(shortcutDimension1Code; "Shortcut Dimension 1 Code") { }
            column(shortcutDimension2Code; "Shortcut Dimension 2 Code") { }
            column(firstGSTPer; "First GST %") { }
            column(firstGSTAmount; "First GST Amount") { }
            column(firstVendorName; "First Vendor Name") { }
            column(amount; Amount) { }
            column(itemCategory; "Item Category") { }
            column(postingDate; "Posting Date") { }
            column(procurementType; "Procurement Type") { }
            column(lineNo; "Line No") { }

        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}