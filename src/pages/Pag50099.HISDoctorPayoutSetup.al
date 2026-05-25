page 50099 "E3 HIS Doctor Payout Setup"
{
    ApplicationArea = All;
    Caption = 'Doctor Payout Setup';
    PageType = List;
    SourceTableView = SORTING("Entry No.") WHERE("Type" = FILTER(Doctor));
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
                field("HIS Document Type"; Rec."MOP Code")
                {
                    ApplicationArea = All;
                    Caption = 'Payout Category';
                    ToolTip = 'Specifies the value of the Payout Category field.';
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
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Doctor
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Doctor
    end;

}
