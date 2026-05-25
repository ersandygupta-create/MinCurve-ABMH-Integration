page 50162 "Allow Posting Date"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "HIS Allow Posting Date";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Code Unit Name"; Rec."Code Unit Name")
                {
                    Caption = 'Table Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code Unit Name field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field("To Date"; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date field.';
                }
            }
        }
    }

}