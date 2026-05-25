query 50020 "Cost Element Master"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'costElementMaster';
    EntityName = 'costElementMaster';
    EntitySetName = 'costElementMaster';
    QueryType = API;

    elements
    {
        dataitem(costElementMaster; "EDC Cost Element Master")
        {
            column(globalDimension2Code; "Global Dimension 2 Code") { }
            column(spendCode; "Spend Code") { }
            column(costElementCode; "Cost Element Code") { }
            column(spendName; "Spend Name") { }
            column(costElementName; "Cost Element Name") { }
            column(systemId; SystemId) { }
            column(systemCreatedAt; SystemCreatedAt) { }
            column(systemCreatedBy; SystemCreatedBy) { }
            column(systemModifiedAt; SystemModifiedAt) { }
            column(systemModifiedBy; SystemModifiedBy) { }

        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}