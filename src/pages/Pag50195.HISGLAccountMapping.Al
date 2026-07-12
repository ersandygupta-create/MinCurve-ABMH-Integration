page 50195 "E3 HIS GL Accounts Mapping"
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "E3 HIS GL Accounts Mapping";

    layout
    {
        area(Content)
        {
            repeater(control1)
            {
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Account No';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Account Name';

                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Account Type';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}