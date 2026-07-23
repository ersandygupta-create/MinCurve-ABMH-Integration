report 50051 "E3 Create Purchase Order"
{
    ProcessingOnly = true;
    UsageCategory = Tasks;
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
        dataitem("E3 Indent Line"; "E3 Indent Line")
        {
            RequestFilterFields = "Document No.";

            trigger OnAfterGetRecord()
            var
                RemainingQty: Decimal;
            begin
                if "E3 Indent Line"."Requested Qty" = 0 then
                    "E3 Indent Line".FieldError("Requested Qty");

                if ("E3 Indent Line"."Vendor No." <> '') and ("E3 Indent Line"."Vendor PO Creation" = true) then begin

                    // Calculate Remaining Qty
                    RemainingQty := GetRemainingQty("E3 Indent Line");

                    // Ordered Qty cannot exceed Remaining Qty
                    if "E3 Indent Line"."Ordered Qty" > RemainingQty then
                        Error(
                            'Ordered Qty (%1) cannot be greater than Remaining Approved Qty (%2).',
                            "E3 Indent Line"."Ordered Qty",
                            RemainingQty);

                    if LastSupplier <> "E3 Indent Line"."Vendor No." then
                        CreatePurchaseHeader("E3 Indent Line", 1);

                    CreatePurchaseLines("E3 Indent Line", 1);

                    // Update Remaining Qty
                    "E3 Indent Line"."Created PO Qty" += PurchaseLine.Quantity;
                    "E3 Indent Line"."Purchase Order No." := PurchaseLine."Document No.";
                    "E3 Indent Line".Modify();
                end;

                ProcessingCompleted("E3 Indent Line");
            end;

            trigger OnPostDataItem()
            var
                IndentLineRec: Record "E3 Indent Line";
                IndentHeaderRec: Record "E3 Indent Header";
            begin
                DialogWindow.Close();

                // Update Release Indent based on remaining quantity
                IndentHeaderRec.Reset();
                IndentHeaderRec.SetRange("Document No.", "E3 Indent Line"."Document No.");

                if IndentHeaderRec.FindFirst() then begin
                    IndentHeaderRec."Release Indent" := true;

                    IndentLineRec.Reset();
                    IndentLineRec.SetRange("Document No.", IndentHeaderRec."Document No.");

                    if IndentLineRec.FindSet() then
                        repeat
                            if GetRemainingQty(IndentLineRec) = 0 then
                                IndentLineRec.Released := true
                            else begin
                                IndentLineRec.Released := false;
                                IndentHeaderRec."Release Indent" := false;
                            end;

                            IndentLineRec.Modify(true);
                        until IndentLineRec.Next() = 0;

                end;

                Message('Purchase Order created for the selected records.');
            end;

            trigger OnPreDataItem()
            begin
                DialogWindow.Open('Purchase Order...' + '\Order No : #1#########' + '\Item No  : #2#########');
            end;
        }
    }

    procedure SetNoSeries(p_NoSeries: Code[20])
    begin
        NoSeries := p_NoSeries;
    end;

    local procedure ProcessingCompleted(IndentLine: Record "E3 Indent Line")
    begin
        if (IndentLine."Vendor No." <> '') and (IndentLine."Vendor PO Creation" = true) then begin
            DialogWindow.Update(2, IndentLine."No.");

            // Only mark as purchased when fully ordered
            if GetRemainingQty(IndentLine) = 0 then
                IndentLine.SetPurchased(PurchaseHeader."No.");
        end;
    end;

    local procedure CreatePurchaseHeader(IndentLine: Record "E3 Indent Line"; PurchHeaderType: Integer)
    var
        RequistionHeader: Record "E3 Indent Header";
        NoSeriesManagement: Codeunit "No. Series";
        RecordLinkManagement: Codeunit "Record Link Management";
    begin
        PurchaseHeader.Init();
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
        PurchaseHeader."No." := NoSeriesManagement.GetNextNo(NoSeries, Today, true);
        PurchaseHeader."E3 Capex Type" := IndentHeader."Procurement Type";
        PurchaseHeader.Insert(true);
        Case PurchHeaderType of
            1:
                PurchaseHeader.Validate("Buy-from Vendor No.", IndentLine."Vendor No.");
        End;
        PurchaseHeader."Location Code" := IndentLine."Location Code";
        PurchaseHeader."Payment Terms" := IndentLine."Payment Terms";
        PurchaseHeader."E3 Delivery Terms" := IndentLine."Delivery Terms";
        Case PurchHeaderType of
            1:
                PurchaseHeader.Validate(PurchaseHeader."Currency Code", IndentLine."Currency Code");
        end;
        PurchaseHeader."Responsibility Center" := IndentLine."Shortcut Dimension 1 Code";
        PurchaseHeader.Validate(PurchaseHeader."Shortcut Dimension 1 Code", IndentHeader."Shortcut Dimension 1 Code");
        PurchaseHeader.Validate(PurchaseHeader."Shortcut Dimension 2 Code", IndentHeader."Shortcut Dimension 2 Code");
        RequistionHeader.Get(IndentLine."Document No.");
        RecordLinkManagement.CopyLinks(RequistionHeader, PurchaseHeader);
        PurchaseHeader.Modify();
        Case PurchHeaderType of
            1:
                LastSupplier := IndentLine."Vendor No.";
        end;
        DialogWindow.Update(1, PurchaseHeader."No.");
        LineNo := 0;
    end;

    local procedure CreatePurchaseLines(IndentLine: Record "E3 Indent Line"; PurchLineType: Integer)
    begin
        LineNo += 10000;
        PurchaseLine.Init();
        PurchaseLine.Validate("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.Validate("Document No.", PurchaseHeader."No.");
        PurchaseLine.Validate("Line No.", LineNo);
        case IndentLine.Type of
            IndentLine.Type::Item:
                begin
                    PurchaseLine.Validate(Type, PurchaseLine.Type::Item);
                    PurchaseLine.Validate("No.", IndentLine."No.");
                end;

            IndentLine.Type::"G/L Account":
                begin
                    PurchaseLine.Validate(Type, PurchaseLine.Type::"G/L Account");
                    PurchaseLine.Validate("No.", IndentLine."No.");
                end;

            IndentLine.Type::"Fixed Asset":
                begin
                    PurchaseLine.Validate(Type, PurchaseLine.Type::"Fixed Asset");
                    PurchaseLine.Validate("No.", IndentLine."Fixed Assets No.");
                end;
        end;
        PurchaseLine.Validate(Quantity, IndentLine."Ordered Qty");
        PurchaseLine.Validate("Unit of Measure Code", IndentLine."Unit of Measure");
        PurchaseLine.Validate("Location Code", PurchaseHeader."Location Code");
        Case PurchLineType of
            1:
                PurchaseLine.Validate("Direct Unit Cost", IndentLine."Quotation Price");
        End;
        PurchaseLine.Validate("Indent No.", IndentLine."Document No.");
        PurchaseLine.Validate("Indent Line No.", IndentLine."Line No.");
        PurchaseLine.Validate(PurchaseLine."Shortcut Dimension 1 Code", IndentLine."Shortcut Dimension 1 Code");
        PurchaseLine.Validate(PurchaseLine."Shortcut Dimension 2 Code");
        PurchaseLine.Validate("Requested Receipt Date", IndentLine."Requested Received Date");
        Case PurchLineType of
            1:
                PurchaseLine.Validate("Line Discount %", IndentLine."Discount %");
        end;
        PurchaseLine.Validate("Description 2", CopyStr(IndentLine.Remarks, 1, 50));

        PurchaseLine."Vendor Item No." := IndentLine."No.";
        PurchaseLine.Insert(true);
        InsertIndentLineDetails(IndentLine);
    end;

    local procedure InsertIndentLineDetails(IndentLine: Record "E3 Indent Line")
    var
        IndentLineDetails: Record "E3 Released Indent Details";
    begin
        IndentLineDetails.Init();

        IndentLineDetails."Document No." := IndentLine."Document No.";
        IndentLineDetails."Indent Line No." := IndentLine."Line No.";
        IndentLineDetails."Purchase Order No." := PurchaseHeader."No.";
        IndentLineDetails."Purchase Line No." := PurchaseLine."Line No.";
        IndentLineDetails.Type := IndentLine.Type;
        IndentLineDetails."No." := IndentLine."No.";
        IndentLineDetails.Description := IndentLine.Description;
        IndentLineDetails."Vendor No." := IndentLine."Vendor No.";
        IndentLineDetails."Vendor Name" := IndentLine."Vendor Name";
        IndentLineDetails."Approved Qty" := IndentLine."Approved Qty";
        IndentLineDetails."Created PO Qty" := PurchaseLine.Quantity;
        IndentLineDetails."Remaining Qty" := GetRemainingQty(IndentLine);
        IndentLineDetails."Quotation Price" := IndentLine."Quotation Price";
        IndentLineDetails."Location Code" := IndentLine."Location Code";
        IndentLineDetails."Payment Terms" := IndentLine."Payment Terms";
        IndentLineDetails."Delivery Terms" := IndentLine."Delivery Terms";
        IndentLineDetails."Created Date" := Today;
        IndentLineDetails."Created Time" := Time;
        IndentLineDetails."Created By" := CopyStr(UserId(), 1, MaxStrLen(IndentLineDetails."Created By"));

        IndentLineDetails.Insert(true);
    end;


    local procedure GetRemainingQty(IndentLine: Record "E3 Indent Line"): Decimal
    var
        PurchLine: Record "Purchase Line";
        TotalOrderedQty: Decimal;
    begin
        TotalOrderedQty := 0;

        PurchLine.Reset();
        PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SetRange("Indent No.", IndentLine."Document No.");
        PurchLine.SetRange("Indent Line No.", IndentLine."Line No.");

        if PurchLine.FindSet() then
            repeat
                TotalOrderedQty += PurchLine.Quantity;
            until PurchLine.Next() = 0;

        exit(IndentLine."Approved Qty" - TotalOrderedQty);
    end;

    local procedure GetOrderedQty(IndentLine: Record "E3 Indent Line"): Decimal
    var
        PurchLine: Record "Purchase Line";
        TotalOrderedQty: Decimal;
    begin
        TotalOrderedQty := 0;

        PurchLine.Reset();
        PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SetRange("Indent No.", IndentLine."Document No.");
        PurchLine.SetRange("Indent Line No.", IndentLine."Line No.");

        if PurchLine.FindSet() then
            repeat
                TotalOrderedQty += PurchLine.Quantity;
            until PurchLine.Next() = 0;

        exit(TotalOrderedQty);
    end;

    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        ApprovalEntry: Record "Approval Entry";
        LastSupplier: Code[20];
        NoSeries: Code[20];
        LineNo: Integer;
        DialogWindow: Dialog;
        IndentHeader: Record "E3 Indent Header";

}
