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
                }

                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Critical Item"; Rec."Critical Item")
                {
                    ApplicationArea = All;
                }
                field("Requested Qty"; Rec."Requested Qty")
                {
                    ApplicationArea = All;
                }

                field("Approved Qty"; Rec."Approved Qty")
                {
                    ApplicationArea = All;
                }

                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Ordered Qty"; Rec."Ordered Qty")
                {
                    ApplicationArea = All;
                }
                field("Item Make Name"; Rec."Item Make Name")
                {
                    ApplicationArea = All;
                }
                field("Item Make Code"; Rec."Item Make Code")
                {
                    ApplicationArea = All;
                }
                field("Requested Received Date"; Rec."Requested Received Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}