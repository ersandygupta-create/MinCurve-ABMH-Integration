page 50165 "E3 Gate Entry Inward Subform"
{
    Caption = 'Gate Entry Inward Subform';
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "E3 Gate Entry Line";
    SourceTableView = sorting("Entry No.");

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Name field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
                field("Unit of Measurement"; Rec."Unit of Measurement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measurement field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty field.';
                }
                field("Received Qty"; Rec."Received Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Received Qty field.';
                }
                field("Pending Qty"; Rec."Pending Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pending Qty field.';
                }
                field("Estimated Value"; Rec."Estimated Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated Value field.';
                }
                field("Asset No."; Rec."Asset No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Asset No. field.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Serial No. field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }
}