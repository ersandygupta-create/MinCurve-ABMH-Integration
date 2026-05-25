query 50005 "E3 GL Budget Entry Data"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'E3GLBudgetEntryData';
    EntityName = 'e3GLBudgetEntryData';
    EntitySetName = 'e3GLBudgetEntryData';
    QueryType = API;

    elements
    {
        dataitem(glBudgetEntry; "G/L Budget Entry")
        {
            column(entryNo; "Entry No.")
            {
            }
            column(budgetName; "Budget Name")
            {
            }
            column(glAccountNo; "G/L Account No.")
            {
            }
            column(date; Date)
            {
            }
            column(unitCode; "Global Dimension 1 Code")
            {
            }
            column(deptCode; "Global Dimension 2 Code")
            {
            }
            column(amount; Amount)
            {
            }
            column(description; Description)
            {
            }
            column(userID; "User ID")
            {
            }
            column(systemCreatedAt; SystemCreatedAt)
            {
            }
            column(budgetDimension1Code; "Budget Dimension 1 Code")
            {
            }
            column(budgetDimension2Code; "Budget Dimension 2 Code")
            {
            }
            column(dimensionSetID; "Dimension Set ID")
            {
            }
            column(itemType; "EDC Item Type")
            {
            }
            column(remarks; "EDC Remarks")
            {
            }

        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
