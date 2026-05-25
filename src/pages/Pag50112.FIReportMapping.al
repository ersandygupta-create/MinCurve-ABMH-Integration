page 50112 "FIReportMapping KPIs"
{
    ApplicationArea = All;
    Caption = 'FIReportMapping';
    PageType = List;
    SourceTable = "E3 FIReportingMapping";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                ShowCaption = true;
                field("KPI Code"; Rec."KPI Code")
                {
                    ApplicationArea = All;
                    Caption = 'KPI Code';
                    ToolTip = 'Specifies a KPI Code for the Field';
                }
                field("KPI Name"; Rec."KPI Name")
                {
                    ApplicationArea = All;
                    Caption = 'KPI Name';
                    ToolTip = 'Specifies a KPI Name of the Field';
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
    end;
}