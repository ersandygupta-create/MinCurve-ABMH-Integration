page 50184 "E3 Indenter Master List"
{
    PageType = List;
    SourceTable = "E3 Indenter Master";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Indenter Masters';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Indenter Type"; Rec."Indenter Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Indenter Type of the indenter.';
                }
                field("Indenter Code"; Rec."Indenter Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique code of the indenter.';
                }

                field("Indenter Name"; Rec."Indenter Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the indenter.';
                }

                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                }

                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the department name.';
                }

                field("Business Unit Code"; Rec."Business Unit Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the business unit code.';
                }

                field("Business Unit Name"; Rec."Business Unit Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the business unit name.';
                }

                field("Default Location Code"; Rec."Default Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default location code.';
                }

                field("Default Location Name"; Rec."Default Location Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the default location name.';
                }
            }
        }
    }
}