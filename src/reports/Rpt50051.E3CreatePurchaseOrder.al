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
            begin
                if "E3 Indent Line"."Requested Qty" = 0 then "E3 Indent Line".FieldError("Requested Qty");
                if ("E3 Indent Line"."First Vendor No." <> '') and ("E3 Indent Line"."First Vendor PO Creation" = true) then begin
                    if LastSupplier <> "E3 Indent Line"."First Vendor No." then CreatePurchaseHeader("E3 Indent Line", 1);
                    CreatePurchaseLines("E3 Indent Line", 1);
                    "E3 Indent Line"."First Purchase Order No." := PurchaseLine."Document No.";
                    "E3 Indent Line".Modify();
                end;
                // Second Purchase Order Creation
                if ("E3 Indent Line"."Second Vendor No." <> '') and ("E3 Indent Line"."Second Vendor PO Creation" = true) then begin
                    if LastSupplier <> "E3 Indent Line"."Second Vendor No." then CreatePurchaseHeader("E3 Indent Line", 2);
                    CreatePurchaseLines("E3 Indent Line", 2);
                    "E3 Indent Line"."Second Purchase Order No." := PurchaseLine."Document No.";
                    "E3 Indent Line".Modify();
                end;
                // Third Purchase Order Creation
                if ("E3 Indent Line"."Third Vendor No." <> '') and ("E3 Indent Line"."Third Vendor PO Creation" = true) then begin
                    if LastSupplier <> "E3 Indent Line"."Third Vendor No." then CreatePurchaseHeader("E3 Indent Line", 3);
                    CreatePurchaseLines("E3 Indent Line", 3);
                    "E3 Indent Line"."Third Purchase Order No." := PurchaseLine."Document No.";
                    "E3 Indent Line".Modify();
                end;
                ProcessingCompleted("E3 Indent Line");
            end;

            trigger OnPostDataItem()
            begin
                DialogWindow.Close();
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
        if (IndentLine."First Vendor No." <> '') and (IndentLine."First Vendor PO Creation" = true) then begin
            DialogWindow.Update(2, IndentLine."No.");
            IndentLine.SetPurchased(PurchaseHeader."No.");
        end;
        if (IndentLine."Second Vendor No." <> ' ') and (IndentLine."Second Vendor PO Creation" = true) then begin
            DialogWindow.Update(2, IndentLine."No.");
            IndentLine.SetPurchased(PurchaseHeader."No.");
        end;
        if (IndentLine."Third Vendor No." <> ' ') and (IndentLine."Third Vendor PO Creation" = true) then begin
            DialogWindow.Update(2, IndentLine."No.");
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
                PurchaseHeader.Validate("Buy-from Vendor No.", IndentLine."First Vendor No.");
            2:
                PurchaseHeader.Validate("Buy-from Vendor No.", IndentLine."Second Vendor No.");
            3:
                PurchaseHeader.Validate("Buy-from Vendor No.", IndentLine."Third Vendor No.");
        End;
        PurchaseHeader."Location Code" := IndentLine."Shortcut Dimension 1 Code";
        Case PurchHeaderType of
            1:
                PurchaseHeader.Validate(PurchaseHeader."Currency Code", IndentLine."First Currency Code");
            2:
                PurchaseHeader.Validate(PurchaseHeader."Currency Code", IndentLine."Second Currency Code");
            3:
                PurchaseHeader.Validate(PurchaseHeader."Currency Code", IndentLine."Third Currency Code");
        end;
        PurchaseHeader.Validate("Responsibility Center", IndentLine."Shortcut Dimension 1 Code");
        PurchaseHeader.Validate(PurchaseHeader."Shortcut Dimension 1 Code", IndentHeader."Shortcut Dimension 1 Code");
        PurchaseHeader.Validate(PurchaseHeader."Shortcut Dimension 2 Code", IndentHeader."Shortcut Dimension 2 Code");
        PurchaseHeader."E3 Capex Type" := IndentHeader."Procurement Type";
        RequistionHeader.Get(IndentLine."Document No.");
        RecordLinkManagement.CopyLinks(RequistionHeader, PurchaseHeader);
        PurchaseHeader.Modify();
        Case PurchHeaderType of
            1:
                LastSupplier := IndentLine."First Vendor No.";
            2:
                LastSupplier := IndentLine."Second Vendor No.";
            3:
                LastSupplier := IndentLine."Third Vendor No.";
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
        PurchaseLine.Validate(Quantity, IndentLine."Requested Qty");
        PurchaseLine.Validate("Unit of Measure Code", IndentLine."Unit of Measure");
        PurchaseLine.Validate("Location Code", IndentLine."Shortcut Dimension 1 Code");
        Case PurchLineType of
            1:
                PurchaseLine.Validate("Direct Unit Cost", IndentLine."First Price");
            2:
                PurchaseLine.Validate("Direct Unit Cost", IndentLine."Second Price");
            3:
                PurchaseLine.Validate("Direct Unit Cost", IndentLine."Third Price");
        End;
        PurchaseLine.Validate("Indent No.", IndentLine."Document No.");
        //PurchaseLine.Validate("Indent Date", IndentLine."Posting Date");
        PurchaseLine.Validate("Indent Line No.", IndentLine."Line No.");
        PurchaseLine.Validate(PurchaseLine."Shortcut Dimension 1 Code", IndentLine."Shortcut Dimension 1 Code");
        // PurchaseLine.Validate(PurchaseLine."Shortcut Dimension 2 Code", IndentLine."Shortcut Dimension 2 Code");
        PurchaseLine.Validate("Requested Receipt Date", IndentLine."Requested Received Date");
        Case PurchLineType of
            1:
                PurchaseLine.Validate("Line Discount %", IndentLine."First Discount %");
            2:
                PurchaseLine.Validate("Line Discount %", IndentLine."Second Discount %");
            3:
                PurchaseLine.Validate("Line Discount %", IndentLine."Third Discount %");
        end;
        PurchaseLine.Validate("Description 2", CopyStr(IndentLine.Remarks, 1, 50));
        //PurchaseLine."E3 Requested Unit of Measure" := IndentLine."Requested Unit of Measure";
        //PurchaseLine."E3 Requested Quantity" := IndentLine."Requested Quantity";

        PurchaseLine."Vendor Item No." := IndentLine."No.";
        PurchaseLine.Insert(true);
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
