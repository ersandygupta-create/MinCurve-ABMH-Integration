page 50208 "E3 Project Master List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "E3 Project Master";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Project Code"; rec."Project Code")
                {
                    ToolTip = 'Project Code';
                }
                field("Project Name"; Rec."Project Name")
                {
                    ToolTip = 'Project Name';
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