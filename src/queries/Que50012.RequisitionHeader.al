query 50012 "Requisition Header"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'requisitionHeader';
    EntityName = 'requisitionHeader';
    EntitySetName = 'requisitionHeader';
    QueryType = API;

    elements
    {
        dataitem(requisitionHeader; "EDC Requisition Header")
        {
            column(requisitionNo; "Requisition No") { }
            column(locationCode; "Location Code") { }
            column(priority; Priority) { }
            column(createdBy; "Created By") { }
            column(requisitionType; "Requisition Type") { }
            column(category; Category) { }
            column(budgetedAmount; "Budgeted Amount") { }
            column(status; Status) { }
            column(postingDate; "Posting Date") { }
            column(shortcutDimension1Code; "Shortcut Dimension 1 Code") { }
            column(shortcutDimension2Code; "Shortcut Dimension 2 Code") { }
            column(spendCode; "EDC Spend Code") { }
            column(costElementCode; "EDC Cost Element Code") { }
            column(itemCategory; "Item Category") { }
            column(budgetType; "Budget Type") { }
            column(procurementType; "Procurement Type") { }
            column(financialYear; "EDC Financial Year") { }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}