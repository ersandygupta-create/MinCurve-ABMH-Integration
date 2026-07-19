page 50199 E3SettlementType
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 50042;
    Caption = 'Settlement Type';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(SettlementType; Rec.SettlementType)
                {
                    ApplicationArea = all;
                    ToolTip = 'Settlement Type';
                }
                field(PostApplication; Rec.PostApplication)
                {
                    ApplicationArea = all;
                    ToolTip = 'Post Applicatio';
                }
            }
        }
    }

}