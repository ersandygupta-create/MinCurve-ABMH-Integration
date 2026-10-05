page 50212 "PO Terms Subpage"
{
    PageType = ListPart;
    SourceTable = "PO Selected Terms Condition";
    Caption = 'Terms & Conditions Selection';
    AutoSplitKey = false;
    DelayedInsert = true; // Ensures record is inserted properly when moving across fields
    MultipleNewLines = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Term Code"; Rec."Term Code")
                {
                    ApplicationArea = All;
                    TableRelation = "PO Terms Condition Master".Code where(Active = const(true));

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Condition Text"; Rec."Condition Text")
                {
                    ApplicationArea = All;
                    Editable = false;
                    visible = false;
                }
            }
        }
    }
}