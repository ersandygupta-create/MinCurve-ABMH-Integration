query 50021 "Purchase Inv Header"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'purchaseInvHdr';
    EntityName = 'purchaseInvHdr';
    EntitySetName = 'purchaseInvHdr';
    QueryType = API;

    elements
    {
        dataitem(PurchInvHeader; "Purch. Inv. Header")
        {
            column(no; "No.") { }
            column(postingDate; "Posting Date") { }
            column(orderNo; "Order No.") { }
            column(amount; Amount) { }
            column(vendorInvoiceNo; "Vendor Invoice No.") { }
            column(documentDate; "Document Date") { }
            column(userID; "User ID") { }

        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}