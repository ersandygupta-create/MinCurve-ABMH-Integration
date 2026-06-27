page 50187 "E3 Indent Line API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Indent Line API';
    DelayedInsert = true;
    AutoSplitKey = true;
    EntityName = 'indentLine';
    EntitySetName = 'indentLines';
    PageType = API;
    SourceTable = "E3 Indent Line";
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'System Id';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(unitOfMeasure; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                }
                field(requestedQty; Rec."Requested Qty")
                {
                    Caption = 'Requested Qty';
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(approvedQty; Rec."Approved Qty")
                {
                    Caption = 'Approved Qty';
                }
                field(requestedReceivedDate; Rec."Requested Received Date")
                {
                    Caption = 'Requested Received Date';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(itemMakeCode; Rec."Item Make Code")
                {
                    Caption = 'Item Make Code';
                }
                field(orderedQty; Rec."Ordered Qty")
                {
                    Caption = 'Ordered Qty';
                }
                field(remarks; Rec.Remarks)
                {
                    Caption = 'Remarks';
                }
                field(itemMakeName; Rec."Item Make Name")
                {
                    Caption = 'Item Make Name';
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec.HasFilter() then begin
            Rec."Document No." := Rec.GetFilter("Document No.");
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec.HasFilter() then begin
            Rec."Document No." := Rec.GetFilter("Document No.");
        end;
    end;
}