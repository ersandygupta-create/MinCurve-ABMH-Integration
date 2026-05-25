query 50002 "E3 FIReporting"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'E3FIReporting';
    EntityName = 'e3FIReportings';
    EntitySetName = 'e3FIReportings';
    QueryType = API;

    elements
    {
        dataitem(fireportings; "E3 FIReportingMapping")
        {

            column(kpicode; "KPI Code")
            {
            }
            column(kipname; "KPI Name")
            {
            }
            column(type; Type)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
