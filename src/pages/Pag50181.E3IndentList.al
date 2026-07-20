page 50181 "E3 Indent List"
{
    PageType = List;
    SourceTable = "E3 Indent Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Indent List';
    CardPageId = "E3 Indent Card";
    SourceTableView = WHERE(Status = FILTER(Open | "Pending Approval"), "Source Type" = filter(D365));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source type of the indent.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Indent No.';
                    ToolTip = 'Specifies the unique document number of the indent.';
                }
                field("Indentor Name"; Rec."Indenter Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the indentor.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date on which the indent request was created.';
                }
                field("Requested By"; Rec."Requested To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the person or department to whom the indent is requested.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the indent.';
                }
            }
        }
    }

}