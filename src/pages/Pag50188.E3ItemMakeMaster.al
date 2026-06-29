page 50188 "E3 Item Make Master"
{
    PageType = List;
    SourceTable = "E3 Item Make Master";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Item Make Master';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique code for the item make.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the item make.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
        }
    }
}