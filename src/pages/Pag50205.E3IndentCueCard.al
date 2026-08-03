page 50205 "E3 Indent Cue Card"
{
    PageType = CardPart;
    SourceTable = "E3 Indent Cue";
    Caption = 'Indent Activities';

    layout
    {
        area(Content)
        {
            cuegroup(Activities)
            {
                field("Open Indents"; Rec."Open Indents")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    DrillDownPageId = "E3 Indent List";
                    ToolTip = 'Specifies the total number of indent documents that are currently in the Open status.';
                }
                field("Pending Approval"; Rec."Pending Approval")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    DrillDownPageId = "E3 Indent List";
                    ToolTip = 'Specifies the total number of indent documents that are pending approval.';
                }
                field("Approved Indents"; Rec."Approved Indents")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    DrillDownPageId = "E3 Approved Indent List";
                    ToolTip = 'Specifies the total number of approved indent documents.';
                }
                field("Rejected Indents"; Rec."Rejected Indents")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    DrillDownPageId = "E3 Indent List";
                    ToolTip = 'Specifies the total number of rejected indent documents.';
                }
                field("Purchase Orders"; Rec."Purchase Orders")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    DrillDownPageId = "Purchase Order List";
                    ToolTip = 'Specifies the total number of purchase orders.';
                }
                field("Pending Purchase Orders"; Rec."Pending Purchase Orders")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Order List";
                    ToolTip = 'Specifies the total number of purchase orders that are pending approval.';
                }
                field("Approved Purchase Orders"; Rec."Approved Purchase Orders")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Order List";
                    ToolTip = 'Specifies the total number of approved (released) purchase orders.';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if not Rec.Get('1') then begin
            Rec.Init();
            Rec."Primary Key" := '1';
            Rec.Insert();
        end;
    end;
}
