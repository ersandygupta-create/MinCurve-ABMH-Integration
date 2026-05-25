table 50023 "E3 FIReportingMapping"
{
    Caption = 'FIReportingMapping';
    LookupPageId = "FIReportMapping KPIs";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "KPI Code"; Text[20])
        {
            Caption = 'KPI Code';
            DataClassification = CustomerContent;
        }
        field(2; "KPI Name"; Text[100])
        {
            Caption = 'KPI Name';
            DataClassification = CustomerContent;
        }
        field(3; Type; Decimal)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(PK; "KPI Code", "KPI Name")
        {
            Clustered = true;
        }
    }
}
