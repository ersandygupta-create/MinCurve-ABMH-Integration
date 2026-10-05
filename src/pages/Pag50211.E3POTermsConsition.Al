
page 50211 "PO Terms Condition List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "PO Terms Condition Master";
    Caption = 'PO Terms & Conditions Master';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field("Condition Text"; Rec."Condition Text")
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field(Active; Rec.Active) { ApplicationArea = All; }
            }
        }
    }
}