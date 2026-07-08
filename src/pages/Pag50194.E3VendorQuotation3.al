page 50194 "E3 Quotation L3"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "E3 Indent Line";
    SourceTableView = SORTING("Document No.", "Line No.") ORDER(Ascending);
    ApplicationArea = All;
    Caption = 'Indent Quotation 3';

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
                field("Third Ordered Qty"; Rec."Third Ordered Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Third Ordered Qty';
                    Editable = true;
                    ToolTip = 'Specifies the ordered quantity.';
                }
                field("Third Currency Code"; Rec."Third Currency Code")
                {
                    ApplicationArea = All;
                    Caption = 'Third Currency Code';
                    ToolTip = 'Specifies the currency code of the third vendor.';
                }
                field("Third Price"; Rec."Third Price")
                {
                    ApplicationArea = All;
                    Caption = 'Third Price';
                    ToolTip = 'Specifies the quoted unit price from the third vendor.';
                }
                field("Third discount %"; Rec."Third discount %")
                {
                    ApplicationArea = All;
                    Caption = 'Third Discount %';
                    ToolTip = 'Specifies the discount percentage offered by the third vendor.';
                }
                field("Third Amount"; Rec."Third Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Third Amount';
                    ToolTip = 'Specifies the total amount quoted by the third vendor.';
                }
                field("Third Vendor No."; Rec."Third Vendor No.")
                {
                    ApplicationArea = All;
                    Caption = 'Third Vendor No.';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the number of the third vendor.';
                }
                field("Third Vendor Name"; Rec."Third Vendor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Third Vendor Name';
                    ToolTip = 'Specifies the name of the third vendor.';
                }
                field("Third Remarks"; Rec."Third Remarks")
                {
                    ApplicationArea = All;
                    Caption = 'Third Remarks';
                    ToolTip = 'Specifies additional remarks for the quotation.';
                }
                field("Third Vendor PO Creation"; Rec."Third Vendor PO Creation")
                {
                    ApplicationArea = All;
                    Caption = 'Third Vendor PO Creation';
                    ToolTip = 'Specifies whether the third vendor purchase order has been created.';
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