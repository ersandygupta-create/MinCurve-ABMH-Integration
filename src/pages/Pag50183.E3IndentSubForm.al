page 50183 "E3 Indent Line Subform"
{
    PageType = ListPart;
    SourceTable = "E3 Indent Line";
    ApplicationArea = All;
    Caption = 'Indent Lines';
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the unique line number of the record.';
                }

                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of line, such as Item or G/L Account.';
                }

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the selected item, resource, or account.';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the selected record.';
                }

                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unit of measure for the item.';
                }

                field("Critical Item"; Rec."Critical Item")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the item is marked as a critical item.';
                }

                field("Requested Qty"; Rec."Requested Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity requested.';
                }

                field("Approved Qty"; Rec."Approved Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity approved for the request.';
                }

                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unit cost of the item.';
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount calculated for the line.';
                }

                field("Ordered Qty"; Rec."Ordered Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity that has been ordered.';
                }
                field("Item Make Code"; Rec."Item Make Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the selected item make.';
                }
                field("Item Make Name"; Rec."Item Make Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the selected item make.';
                }
                field("Requested Received Date"; Rec."Requested Received Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the requested date by which the item should be received.';
                }

                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies additional remarks or comments for the line.';
                }

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique entry number assigned to the record.';
                }
            }
        }
    }
}