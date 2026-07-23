page 50202 "E3 Released Indent Details"
{
    PageType = List;
    SourceTable = "E3 Released Indent Details";
    ApplicationArea = All;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Lists;
    Caption = 'Released Indent Details';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique entry number of the indent line detail.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the indent document number.';
                }
                field("Indent Line No."; Rec."Indent Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the indent line number.';
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the purchase order created from the indent.';
                }
                field("Purchase Line No."; Rec."Purchase Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the purchase order line number.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the document line.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item, G/L account, or fixed asset number.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the line.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor number.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor name.';
                }
                field("Approved Qty"; Rec."Approved Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approved quantity for the indent line.';
                }
                field("Created PO Qty"; Rec."Created PO Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity created in the purchase order.';
                }
                field("Remaining Qty"; Rec."Remaining Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the remaining quantity to be converted into a purchase order.';
                }
                field("Quotation Price"; Rec."Quotation Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quotation price used for the purchase order.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the location code for the purchase order.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shortcut dimension 1 code.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shortcut dimension 2 code.';
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the payment terms for the purchase order.';
                }
                field("Delivery Terms"; Rec."Delivery Terms")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the delivery terms for the purchase order.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the purchase order detail was created.';
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the time when the purchase order detail was created.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user who created the purchase order detail.';
                }
            }
        }
    }
}