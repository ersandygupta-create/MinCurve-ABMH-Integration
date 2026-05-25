query 50001 "E3 COA API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'E3COA';
    EntityName = 'e3COAs';
    EntitySetName = 'e3COAs';
    QueryType = API;

    elements
    {
        dataitem(gLAccount; "G/L Account")
        {

            column(no; "No.")
            {
            }
            column(name; "Name")
            {
            }
            column(incomebalance; "Income/Balance")
            {
            }
            column(accountcategory; "Account Category")
            {
            }
            column(accsubcategory; "Account Subcategory Descript.")
            {
            }
            column(accountType; "Account Type")
            {
            }
            column(kipsCode; FIReportMapping)
            {
            }
            column(kpisname; "KPIs Name")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
