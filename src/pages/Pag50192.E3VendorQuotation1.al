page 50192 "E3 Quotation L1"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "E3 Indent Line";
    SourceTableView = SORTING("Document No.", "Line No.") ORDER(Ascending);
    ApplicationArea = All;
    Caption = 'Indent Quotation 1';

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
                    Caption = 'Requested Quantity';
                    ToolTip = 'Specifies the required quantity.';
                }
                field("Approved Qty"; Rec."Approved Qty")
                {
                    ToolTip = 'Specifies the required Approved Qty.';
                    Editable = false;
                }
                field("First Ordered Qty"; Rec."First Ordered Qty")
                {
                    ApplicationArea = All;
                    Caption = 'First Ordered Qty';
                    Editable = true;
                    ToolTip = 'Specifies the ordered quantity.';
                }
                field("First Currency Code"; Rec."First Currency Code")
                {
                    ApplicationArea = All;
                    Caption = 'First Currency Code';
                    Editable = true;
                    ToolTip = 'Specifies the currency code of the first vendor.';
                }
                field("First Price"; Rec."First Price")
                {
                    ApplicationArea = All;
                    Caption = 'First Price';
                    Editable = true;
                    ToolTip = 'Specifies the quoted unit price from the first vendor.';
                }
                field("First discount %"; Rec."First discount %")
                {
                    ApplicationArea = All;
                    Caption = 'First Discount %';
                    ToolTip = 'Specifies the discount percentage offered by the first vendor.';
                }
                field("First Amount"; Rec."First Amount")
                {
                    ApplicationArea = All;
                    Caption = 'First Amount';
                    ToolTip = 'Specifies the total amount quoted by the first vendor.';
                }
                field("First Vendor No."; Rec."First Vendor No.")
                {
                    ApplicationArea = All;
                    Caption = 'First Vendor No.';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the number of the first vendor.';
                }
                field("First Vendor Name"; Rec."First Vendor Name")
                {
                    ApplicationArea = All;
                    Caption = 'First Vendor Name';
                    ToolTip = 'Specifies the name of the first vendor.';
                }
                field("First Remarks"; Rec."First Remarks")
                {
                    ApplicationArea = All;
                    Caption = 'First Remarks';
                    ToolTip = 'Specifies additional remarks for the quotation.';
                }
                field("First Vendor PO Creation"; Rec."First Vendor PO Creation")
                {
                    ApplicationArea = All;
                    Caption = 'First Vendor PO Creation';
                    ToolTip = 'Specifies whether the first vendor purchase order has been created.';
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
