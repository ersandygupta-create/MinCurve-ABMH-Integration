page 50202 "E3 Released Quotation List"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "E3 Indent Line";
    SourceTableView = SORTING("Document No.", "Line No.") ORDER(Ascending) where("Released" = filter(true));
    ApplicationArea = All;
    Caption = 'Released Quotation List';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ToolTip = 'Specifies the quotation Purchase Order number.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No.';
                    Visible = false;
                    ToolTip = 'Specifies the quotation document number.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                    Visible = false;
                    ToolTip = 'Specifies the line number of the quotation.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'No.';
                    ToolTip = 'Specifies the item number.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Description';
                    ToolTip = 'Specifies the description of the item.';
                }
                field(Quantity; Rec."Requested Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Requested Quantity';
                    ToolTip = 'Specifies the required quantity.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Amount';
                    ToolTip = 'Specifies the required Amount.';
                }
                field("Approved Qty"; Rec."Approved Qty")
                {
                    ToolTip = 'Specifies the required Approved Qty.';
                    Editable = false;
                }
                field("Ordered Qty"; Rec."Ordered Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Ordered Qty';
                    Editable = true;
                    ToolTip = 'Specifies the ordered quantity.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Caption = 'Currency Code';
                    Editable = true;
                    ToolTip = 'Specifies the currency code of the vendor.';
                }
                field("Price"; Rec."Quotation Price")
                {
                    ApplicationArea = All;
                    Caption = 'Quotation Price';
                    Editable = true;
                    ToolTip = 'Specifies the quoted unit price from the vendor.';
                }
                field("discount %"; Rec."discount %")
                {
                    ApplicationArea = All;
                    Caption = 'Discount %';
                    ToolTip = 'Specifies the discount percentage offered by the vendor.';
                }
                field("Quotation Amount"; Rec."Quotation Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Quotation Amount';
                    ToolTip = 'Specifies the total amount quoted by the vendor.';
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Terms';
                    ToolTip = 'Specifies the payment terms agreed for the quotation or purchase, such as advance payment, credit period, or payment schedule.';
                }
                field("Delivery Terms"; Rec."Delivery Terms")
                {
                    ApplicationArea = All;
                    Caption = 'Delivery Terms';
                    ToolTip = 'Specifies the expected delivery time or delivery terms provided by the vendor.';
                }
                field("AMC Amount"; Rec."AMC Amount")
                {
                    ApplicationArea = All;
                    Caption = 'AMC Amount';
                    ToolTip = 'Specifies the Annual Maintenance Contract (AMC) amount quoted by the vendor.';
                }
                field("CMC Amount"; Rec."CMC Amount")
                {
                    ApplicationArea = All;
                    Caption = 'CMC Amount';
                    ToolTip = 'Specifies the Comprehensive Maintenance Contract (CMC) amount quoted by the vendor.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor No.';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the number of the vendor.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Name';
                    ToolTip = 'Specifies the name of the vendor.';
                }
                field("Remarks"; Rec."Remarks")
                {
                    ApplicationArea = All;
                    Caption = 'Remarks';
                    ToolTip = 'Specifies additional remarks for the quotation.';
                }
                field("Vendor PO Creation"; Rec."Vendor PO Creation")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor PO Creation';
                    ToolTip = 'Specifies whether the vendor purchase order has been created.';
                }
                field("Split Line"; Rec."Split Line")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the Split Line Boolean.';
                }
                field("Quotation Type"; Rec."Quotation Type")
                {
                    ApplicationArea = All;
                    Caption = 'Quotation Type';
                    Visible = false;
                    ToolTip = 'Specifies the quotation ranking (L1, L2, or L3).';
                }
            }
        }
    }
}
