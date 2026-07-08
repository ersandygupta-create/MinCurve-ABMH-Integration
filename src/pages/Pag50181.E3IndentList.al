page 50181 "E3 Indent List"
{
    PageType = List;
    SourceTable = "E3 Indent Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Indent List';
    CardPageId = "E3 Indent Card";
    SourceTableView = WHERE(Status = FILTER(Open | "Pending Approval"));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}