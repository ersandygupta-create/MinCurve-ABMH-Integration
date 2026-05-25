query 50009 "HIS GRN/GRNReturn Data"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'hisGRNReturndata';
    EntityName = 'hisGRNReturnData';
    EntitySetName = 'hisGRNReturnData';
    QueryType = API;

    elements
    {
        dataitem(hisPurchaseHeader; "E3 HIS Purchase Header")
        {
            column(documentno; "Document No.")
            {
            }
            column(documentdate; "Document Date")
            {
            }
            column(capextype; "Capex Type")
            {
            }
            column(grnid; "GRN ID")
            {
            }
            column(vendorInvoiceno; "Vendor Invoice No.")
            {
            }
            column(storeName; "Store Name")
            {
            }
            column(locationcode; "Location Code")
            {
            }
            column(amount; Amount)
            {
            }
            column(postedOrderNo; "Posted Order No.")
            {
            }
            column(postE3rMemoNo; "Posted Cr.Memo No.")
            {
            }
            column(postingDate; "Posting Date")
            {
            }
            column(vendorCustomerNo; "Vendor No.")
            {
            }
            column(vendorCustomerName; "Vendor Name")
            {
            }
            column(errorDescription; "Error Description")
            {
            }
            column(vendorNoError; "Error 1")
            {
            }
            column(purchaseAccount; "Error 2")
            {
            }
            column(hsnCode; "Error 3")
            {
            }
            column(gstGrouperror; "Error 4")
            {
            }
            column(isprocessed; "Create PO")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}