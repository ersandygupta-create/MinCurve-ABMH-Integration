
query 50023 "Purchase Rec. Header"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'purchaseRecHdr';
    EntityName = 'purchaseRecHdr';
    EntitySetName = 'purchaseRecHdr';
    QueryType = API;

    elements
    {
        dataitem(PurchRcptHeader; "Purch. Rcpt. Header")
        {
            column(no; "No.") { }
            column(buyfromVendorNo; "Buy-from Vendor No.") { }
            column(buyfromVendorName; "Buy-from Vendor Name") { }
            column(paytoVendorNo; "Pay-to Vendor No.") { }
            column(paytoName; "Pay-to Name") { }
            column(orderDate; "Order Date") { }
            column(postingDate; "Posting Date") { }
            column(orderNo; "Order No.") { }
            column(documentDate; "Document Date") { }
            column(userID; "User ID") { }

        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}