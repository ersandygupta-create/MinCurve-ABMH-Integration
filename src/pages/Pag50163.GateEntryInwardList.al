page 50163 "E3 Gate Entry Inward List"
{
    ApplicationArea = All;
    Caption = 'Gate Entry Inward List';
    PageType = List;
    Editable = false;
    CardPageId = "E3 Gate Entry Inward Header";
    InsertAllowed = false;
    SourceTable = "E3 Gate Entry Header";
    SourceTableView = sorting("Entry No.") where("Entry Type" = filter(Inward));
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Gate Pass Type"; Rec."Gate Pass Type")
                {
                    ToolTip = 'Specifies the value of the Gate Pass Type field';
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the value of the Entry Type field';
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field';
                    ApplicationArea = All;
                }
                field("Purpose Code"; Rec."Purpose Code")
                {
                    ToolTip = 'Specifies the value of the Purpose Code field';
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle No. field';
                    ApplicationArea = All;
                }
                field("Posting Date/Time"; Rec."Posting Date/Time")
                {
                    ToolTip = 'Specifies the value of the Posting Date/Time field';
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field';
                    ApplicationArea = All;
                }
                field("To Destination"; Rec."To Destination")
                {
                    ToolTip = 'Specifies the value of the To Destination field';
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field';
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field';
                    ApplicationArea = All;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the GRN ID field';
                    ApplicationArea = All;
                }
                field("Expected Return Date"; Rec."Expected Return Date")
                {
                    ToolTip = 'Specifies the value of the Expected Return Date field';
                    ApplicationArea = All;
                }
                field("Reference Document No."; Rec."Reference Document No.")
                {
                    ToolTip = 'Specifies the value of the Reference Document No. field';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}