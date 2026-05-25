page 50030 "E3 HIS GL Entries Editable"
{

    ApplicationArea = All;
    Caption = 'GL Entries Editable';
    PageType = List;
    Permissions = TableData "G/L Entry" = rmd;
    DeleteAllowed = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    SourceTable = "G/L Entry";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry''s Document No.';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry G/L Account No.';
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry Description';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source type that applies to the source number that is shown in the Source No. field.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the source document that the entry originates from.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Specifies the Amount of the entry.';
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits.';
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits.';
                }

            }
        }
    }

}
