pageextension 50061 "E3 HIS Purchase Invoice Card" extends "Purchase Invoice"
{
    layout

    {
        addlast(General)
        {
            field("Store Name"; Rec."Store Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Store Name field';
            }
            field("Purchase Narration"; Rec."Purchase Narration")
            {
                ApplicationArea = All;
                ToolTip = 'Enter purchase narration here.';
                trigger OnValidate()
                begin
                    UpdatePurchCommentLines(Rec);
                end;
            }
        }
    }
    local procedure UpdatePurchCommentLines(PurchaseHeader: Record "Purchase Header")
    var
        PurchCommentLine: Record "Purch. Comment Line";
        FullText: Text[160];
        FirstPart: Text[80];
        SecondPart: Text[80];
    begin
        FullText := PurchaseHeader."Purchase Narration";

        FirstPart := CopyStr(FullText, 1, 80);
        SecondPart := CopyStr(FullText, 81, 160);

        // Line 1
        if PurchCommentLine.Get(PurchaseHeader."Document Type"::Invoice, PurchaseHeader."No.", 0, 10000) then begin
            PurchCommentLine.Comment := FirstPart;
            PurchCommentLine.Modify();
        end else begin
            PurchCommentLine.Init();
            PurchCommentLine."Document Type" := PurchaseHeader."Document Type"::Invoice;
            PurchCommentLine."No." := PurchaseHeader."No.";
            PurchCommentLine."Document Line No." := 0;
            PurchCommentLine."Line No." := 10000;
            PurchCommentLine.Comment := FirstPart;
            PurchCommentLine.Insert();
        end;

        // Line 2
        if SecondPart <> '' then begin
            if PurchCommentLine.Get(PurchaseHeader."Document Type"::Invoice, PurchaseHeader."No.", 0, 20000) then begin
                PurchCommentLine.Comment := SecondPart;
                PurchCommentLine.Modify();
            end else begin
                PurchCommentLine.Init();
                PurchCommentLine."Document Type" := PurchaseHeader."Document Type"::Invoice;
                PurchCommentLine."No." := PurchaseHeader."No.";
                PurchCommentLine."Document Line No." := 0;
                PurchCommentLine."Line No." := 20000;
                PurchCommentLine.Comment := SecondPart;
                PurchCommentLine.Insert();
            end;
        end else begin
            if PurchCommentLine.Get(PurchaseHeader."Document Type"::Invoice, PurchaseHeader."No.", 0, 20000) then
                PurchCommentLine.Delete();
        end;
    end;

}