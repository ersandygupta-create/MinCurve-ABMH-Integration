query 50019 "Dimension Values"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'dimensionValue';
    EntityName = 'dimensionValue';
    EntitySetName = 'dimensionValue';
    QueryType = API;

    elements
    {
        dataitem(dimensionValue; "Dimension Value")
        {
            column(dimensionCode; "Dimension Code") { }
            column(code; Code) { }
            column(name; Name) { }
            column(dimensionValueType; "Dimension Value Type") { }
            column(totaling; Totaling) { }
            column(blocked; Blocked) { }
            column(consolidationCode; "Consolidation Code") { }
            column(indentation; Indentation) { }
            column(globalDimensionNo; "Global Dimension No.") { }
            column(maptoICDimensionCode; "Map-to IC Dimension Code") { }
            column(maptoICDimensionValueCode; "Map-to IC Dimension Value Code") { }
            column(dimensionValueID; "Dimension Value ID") { }
            column(lastModifiedDateTime; "Last Modified Date Time") { }
            column(dimensionId; "Dimension Id") { }
            column(systemId; SystemId) { }
            column(systemCreatedAt; SystemCreatedAt) { }
            column(systemCreatedBy; SystemCreatedBy) { }
            column(systemModifiedAt; SystemModifiedAt) { }
            column(systemModifiedBy; SystemModifiedBy) { }
            column(systemRowVersion; SystemRowVersion) { }
            column(securityCenterCode; "EDC Security Center Code") { }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}