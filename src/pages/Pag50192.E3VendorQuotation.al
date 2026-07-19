page 50192 "E3 Quotation"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "E3 Indent Line";
    SourceTableView = SORTING("Document No.", "Line No.") ORDER(Ascending);
    ApplicationArea = All;
    Caption = 'Indent Quotation';

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
                field("Critical Item"; Rec."Critical Item")
                {
                    Caption = 'Critical Item';
                    ToolTip = 'Specifies the Critical Item of the item.';
                }
                field("Original Request Qty"; Rec."Original Request Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Delivery Time"; Rec."Delivery Time")
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
                    Caption = 'Indent Line Remarks';
                    Editable = false;
                    ToolTip = 'Specifies additional remarks for the Indent.';
                }
                field("Quotation Remarks"; Rec."Quotation Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies additional remarks for the quotation.';

                }
                field("Split Line"; Rec."Split Line")
                {
                    ApplicationArea = All;
                    Caption = 'Split Line';
                    ToolTip = 'Specifies whether the Split Line Boolean.';
                }
                field("Vendor PO Creation"; Rec."Vendor PO Creation")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor PO Creation';
                    ToolTip = 'Specifies whether the vendor purchase order has been created.';
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
    actions
    {
        area(Processing)
        {
            action("Split Qty")
            {
                Caption = 'Split Qty';
                ApplicationArea = All;
                Image = Split;

                trigger OnAction()
                var
                    SplitQtyPage: Page "E3 Split Qty";
                    SplitQty: Integer;
                begin
                    // Only allow approved quantity
                    if Rec."Approved Qty" <= 0 then
                        Error('Approved Qty must be greater than zero.');

                    // Open popup
                    if SplitQtyPage.RunModal() = Action::OK then begin
                        SplitQty := SplitQtyPage.GetSplitQty();

                        if SplitQty <= 0 then
                            Error('Split Qty must be greater than zero.');

                        if SplitQty > Rec."Approved Qty" then
                            Error(
                              'Split Qty cannot be greater than Approved Qty (%1).',
                              Rec."Approved Qty");

                        // Create copied lines
                        CreateSplitLines(Rec, SplitQty);

                        CurrPage.Update(false);
                    end;
                end;
            }
        }
    }
    local procedure CreateSplitLines(var SelectedLine: Record "E3 Indent Line"; SplitQty: Decimal)
    var
        NewLine: Record "E3 Indent Line";
        LastLine: Record "E3 Indent Line";
        NextLineNo: Integer;
    begin
        // Validation
        if SplitQty <= 0 then
            Error('Split Qty must be greater than zero.');

        if SplitQty > SelectedLine."Requested Qty" then
            Error('Split Qty cannot be greater than Requested Qty.');

        if SelectedLine."Approved Qty" > SelectedLine."Requested Qty" then
            Error('Approved Qty cannot be greater than Requested Qty.');

        // Find Last Line No.
        LastLine.Reset();
        LastLine.SetRange("Document No.", SelectedLine."Document No.");

        if LastLine.FindLast() then
            NextLineNo := LastLine."Line No."
        else
            NextLineNo := 0;

        NextLineNo += 10000;

        // Store Original Request Qty only once
        if SelectedLine."Original Request Qty" = 0 then begin
            SelectedLine."Original Request Qty" := SelectedLine."Requested Qty";
            SelectedLine.Modify();
        end;

        // Create Split Line
        NewLine.Init();
        NewLine.TransferFields(SelectedLine);

        NewLine."Line No." := NextLineNo;

        // Split Qty
        NewLine."Requested Qty" := SplitQty;
        NewLine."Approved Qty" := SplitQty;
        NewLine."Ordered Qty" := 0;

        NewLine."Original Request Qty" := SelectedLine."Original Request Qty";
        NewLine."Split Line" := true;

        NewLine.Insert(true);

        // Update Existing Line
        SelectedLine."Requested Qty" := SelectedLine."Requested Qty" - SplitQty;
        SelectedLine."Approved Qty" := SelectedLine."Approved Qty" - SplitQty;

        if SelectedLine."Approved Qty" < 0 then
            SelectedLine."Approved Qty" := 0;

        if SelectedLine."Approved Qty" > SelectedLine."Requested Qty" then
            Error('Approved Qty should not be greater than Request Qty.');

        SelectedLine.Modify(true);
    end;

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
