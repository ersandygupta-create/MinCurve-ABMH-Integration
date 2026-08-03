pageextension 50079 "E3 All Objects Ext" extends "All Objects with Caption"
{
    actions
    {
        addlast(Processing)
        {
            action("Indent Role Center")
            {
                ApplicationArea = All;
                Caption = 'Indent Role Center';
                Image = RoleCenter;
                ToolTip = 'Open the Indent Role Center.';

                trigger OnAction()
                begin
                    Page.Run(Page::"E3 Indent Role Center");
                end;
            }
        }
    }
}