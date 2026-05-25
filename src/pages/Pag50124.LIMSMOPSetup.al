page 50124 "E3 LIMS MOP Revenue Setup"
{

    ApplicationArea = All;
    Caption = 'LIMS MOP Setup';
    PageType = List;
    SourceTableView = SORTING("Entry No.") WHERE("Type" = FILTER("LIMS MOP"));
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
                field("MOP Code"; Rec."MOP Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the MOP Code field.';
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
        Rec.Type := Rec.Type::"LIMS MOP"
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"LIMS MOP"
    end;

}
