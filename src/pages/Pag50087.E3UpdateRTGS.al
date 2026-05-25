page 50087 "Update UTR No./RTGS"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData 271 = rm;
    SourceTable = 271;
    UsageCategory = Tasks;
    ApplicationArea = All;
    SourceTableView = SORTING("Entry No.")
                      WHERE("E3 UTR No." = CONST(''),
                            Reversed = FILTER(false)
                            );

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Entry No. field';
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bank Account No. field';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posting Date field';
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Document No. field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Amount field';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the User ID field';
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the External Document No. field';
                    ApplicationArea = All;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ToolTip = 'Specifies the value of the Cheque No. field';
                    ApplicationArea = All;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Cheque Date field';
                    ApplicationArea = All;
                }
                field("Line Narration"; Rec."E3 Line Narration")
                {
                    ToolTip = 'Specifies the value of the Line Narration field';
                    ApplicationArea = All;
                }
                field(UTR; Rec."E3 UTR No.")
                {
                    Caption = 'UTR No./RTGS';
                    ToolTip = 'Specifies the value of the UTR No. field';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Unit Code field';
                    ApplicationArea = All;
                }
                field("E3 UTR No."; Rec."E3 UTR No.")
                {
                    Caption = 'Auto Match UTR No.';
                    ToolTip = 'Specifies the value of the E3 UTR No. field';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

