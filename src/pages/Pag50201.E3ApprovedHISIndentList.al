page 50201 "E3 Approved HIS Indent List"
{
    PageType = List;
    SourceTable = "E3 Indent Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Indent List';
    CardPageId = "E3 Indent Card";
    SourceTableView = sorting("Document No.") order(descending) WHERE(Status = FILTER(Approved), "Source Type" = filter(HIS));

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
                field("Indent No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique indent number.';
                }
                field("Indenter Name"; Rec."Indenter Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the indentor.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date on which the indent was requested.';
                }
                field("To Department"; Rec."To Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department for which the indent is created.';
                }
                field("To Department Name"; Rec."To Department Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department for which the indent is created.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the indent.';
                }
                field("Voucher Type Code"; Rec."Voucher Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the voucher type associated with the indent.';
                }
                field("Voucher Type Name"; Rec."Voucher Type Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the voucher type Name associated with the indent.';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user who approved the indent.';
                }
            }
        }
    }
}