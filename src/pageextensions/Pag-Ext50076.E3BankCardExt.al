pageextension 50076 "E3 Bank Card Ext" extends "Bank Account Card"
{
    layout
    {
        addlast(content)
        {
            group("Bank Integration")
            {
                field("Server Code"; Rec."Server Code")
                {
                    Caption = 'Server Code';
                    ApplicationArea = All;
                    ToolTip = 'Specify a Server Code field.';
                }
                field("Client Code"; Rec."Client Code")
                {
                    Caption = 'Client Code';
                    ApplicationArea = All;
                    ToolTip = 'Specify a Client Code field.';
                }
                field("Client Code 1"; Rec."Client Code 1")
                {
                    Caption = 'Client Code 1';
                    ApplicationArea = All;
                    ToolTip = 'Specify a Client Code 1 field.';
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}