page 50042 "E3 HIS Payroll Setup"
{

    ApplicationArea = All;
    Caption = 'Payroll Setup';
    PageType = List;
    SourceTableView = SORTING("Entry No.") WHERE("Type" = FILTER(Payroll));
    SourceTable = "E3 HIS GL Accounts Mapping";
    UsageCategory = Lists;

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
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                    ApplicationArea = All;
                }
                field("Service Head"; Rec."Service/Station Head")
                {
                    ToolTip = 'Specifies the value of the Service Head field';
                    ApplicationArea = All;
                    Caption = 'Earning/ Deduction Head';
                }
                field("Service Head Name"; Rec."Service/Station Head Name")
                {
                    ToolTip = 'Specifies the value of the Service Head Name field';
                    ApplicationArea = All;
                    Caption = 'Earning/ Deduction Head Name';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field';
                    ApplicationArea = All;
                }
                field("GL Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the GL Account No. field';
                    ApplicationArea = All;
                }
                field("GL Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the GL Account Name field';
                    ApplicationArea = All;
                }
                // field("Department Code"; Rec."Department Code")
                // {
                //     ApplicationArea = All;
                // }
                // field("Department Name"; Rec."Department Name")
                // {
                //     ApplicationArea = All;
                // }
                // field("Sub-Department Code"; Rec."Sub-Department Code")
                // {
                //     ApplicationArea = All;
                // }
                // field("Sub-Department Name"; REC."Sub-Department Name")
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Payroll
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Payroll
    end;

}
