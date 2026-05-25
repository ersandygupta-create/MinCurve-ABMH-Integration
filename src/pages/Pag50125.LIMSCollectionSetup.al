page 50125 "E3 LIMS Coll. Setup"
{

    ApplicationArea = All;
    Caption = 'LIMS Collection Setup';
    PageType = List;
    SourceTableView = SORTING("Entry No.") WHERE("Type" = FILTER("LIMS Collection"));
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
                field("Profit Center ID"; Rec."Service/Station Head")
                {
                    Caption = 'Collection Type';
                    ToolTip = 'Specifies the value of the Collection Type field';
                    ApplicationArea = All;
                }
                field("Profit Center Name"; Rec."Service/Station Head Name")
                {
                    Caption = 'Collection Type Name';
                    ToolTip = 'Specifies the value of the Collection Type Name field';
                    ApplicationArea = All;
                }
                // field(OPIP; Rec.OPIP)
                // {
                //     ApplicationArea = ALL;
                //     ToolTip = 'Specifies the value of the OPIP field.';
                // }
                // field("HIS Code"; Rec."HIS Code")
                // {
                //     ApplicationArea = ALL;
                //     ToolTip = 'Specifies the value of the HIS Code field.';
                // }
                // field(Package; Rec.Package)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Package field.';
                // }
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
        Rec.Type := Rec.Type::"LIMS Collection"
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"LIMS Collection"
    end;

}
