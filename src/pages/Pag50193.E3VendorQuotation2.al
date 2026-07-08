page 50193 "E3 Quotation L2"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "E3 Indent Line";
    SourceTableView = SORTING("Document No.", "Line No.") ORDER(Ascending);
    ApplicationArea = All;
    Caption = 'Indent Quotation 2';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

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
                    Caption = 'Quantity';
                    ToolTip = 'Specifies the required quantity.';
                }
                field("Approved Qty"; Rec."Approved Qty")
                {
                    ToolTip = 'Specifies the required Approved Qty.';
                    Editable = false;
                }
                field("Second Ordered Qty"; Rec."Second Ordered Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Second Ordered Qty';
                    Editable = true;
                    ToolTip = 'Specifies the ordered quantity.';
                }
                field("Second Currency Code"; Rec."Second Currency Code")
                {
                    ApplicationArea = All;
                    Caption = 'Second Currency Code';
                    ToolTip = 'Specifies the currency code of the second vendor.';
                }
                field("Second Price"; Rec."Second Price")
                {
                    ApplicationArea = All;
                    Caption = 'Second Price';
                    ToolTip = 'Specifies the quoted unit price from the second vendor.';
                }
                field("Second discount %"; Rec."Second discount %")
                {
                    ApplicationArea = All;
                    Caption = 'Second Discount %';
                    ToolTip = 'Specifies the discount percentage offered by the second vendor.';
                }
                field("Second Amount"; Rec."Second Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Second Amount';
                    ToolTip = 'Specifies the total amount quoted by the second vendor.';
                }
                field("Second Vendor No."; Rec."Second Vendor No.")
                {
                    ApplicationArea = All;
                    Caption = 'Second Vendor No.';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the number of the second vendor.';
                }
                field("Second Vendor Name"; Rec."Second Vendor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Second Vendor Name';
                    ToolTip = 'Specifies the name of the second vendor.';
                }
                field("Second Remarks"; Rec."Second Remarks")
                {
                    ApplicationArea = All;
                    Caption = 'Second Remarks';
                    ToolTip = 'Specifies additional remarks for the quotation.';
                }
                field("Second Vendor PO Creation"; Rec."Second Vendor PO Creation")
                {
                    ApplicationArea = All;
                    Caption = 'Second Vendor PO Creation';
                    ToolTip = 'Specifies whether the second vendor purchase order has been created.';
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
    trigger OnAfterGetCurrRecord()
    var
        IndentHeader: Record "E3 Indent Header";
    begin
        if (Rec."Shortcut Dimension 1 Code" = '') and
           IndentHeader.Get(Rec."Document No.")
        then
            if IndentHeader."Shortcut Dimension 1 Code" <> '' then begin
                Rec.Validate("Shortcut Dimension 1 Code", IndentHeader."Shortcut Dimension 1 Code");
                Rec.Modify();
            end;
    end;
}