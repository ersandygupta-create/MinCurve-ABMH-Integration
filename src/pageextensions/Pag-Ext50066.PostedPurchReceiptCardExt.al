pageextension 50066 "Posted Purch Receipt Card Ext" extends "Posted Purchase Receipt"
{
    layout
    {
        addbefore("Quote No.")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Posting Description';
                ToolTip = 'Specifies a posting description of the order.';
            }
        }
        addlast(General)
        {
            field("Indent Type"; Rec."Indent Type")
            {
                ApplicationArea = all;
                ToolTip = 'Indent Type';
                Editable = false;
            }
            field("Project Code"; Rec."Project Code")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Project Code';
            }
            field("AMC/CMC"; Rec."AMC/CMC")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'AMC/CMC';
            }
        }

    }

    actions
    {
    }
}