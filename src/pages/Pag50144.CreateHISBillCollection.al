page 50144 "Create HIS Bill Collection"
{
    //ApplicationArea = All;
    Caption = 'HIS Bill Collection Stagging';
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTableView = Sorting("Entry No.") where("General Entries Created" = filter(false));
    SourceTable = "E3 HIS Bill Collection";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field';
                    ApplicationArea = All;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("HIS Document Type"; Rec."HIS Document Type")
                {
                    ToolTip = 'Specifies the value of the HIS Document Type field';
                    ApplicationArea = All;
                }
                field("Mode of Payment"; Rec."Mode of Payment")
                {
                    ToolTip = 'Specifies the value of the Mode of Payment field';
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field';
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ToolTip = 'Specifies the value of the Receipt Date field';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field';
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field';
                    ApplicationArea = All;
                }
                field("HIS User Name"; Rec."HIS User Name")
                {
                    Caption = 'HIS User Name';
                    ApplicationArea = All;
                }
            }
        }
    }
}