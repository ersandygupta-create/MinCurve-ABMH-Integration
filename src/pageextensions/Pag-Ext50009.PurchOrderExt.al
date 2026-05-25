pageextension 50009 "E3 HIS Purchase Order" extends "Purchase Order"
{
    layout

    {
        addlast(General)
        {

            field("E3 Item Type"; Rec."E3 Item Type")
            {
                ApplicationArea = All;
                Style = StrongAccent;
                StyleExpr = true;
                ToolTip = 'Specifies the value of the Item Type field.';
            }
            field("E3 Delivery Terms"; Rec."E3 Delivery Terms")
            {
                ApplicationArea = All;
                Style = StrongAccent;
                StyleExpr = true;
                ToolTip = 'Specifies the value of the Delivery Terms field.';
            }
            field("Store Name"; Rec."Store Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Store Name field';
            }
            field("Advance PO"; Rec."Advance PO")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Advance PO field';
            }
        }
    }

    actions
    {
        addafter(Print)
        {
            action("Work Order Print")
            {
                ApplicationArea = All;
                Caption = 'PO & Work Order Print';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;
                trigger OnAction()
                var
                    PurchaseOrderReportId: Integer;
                    WorkOrderReportId: Integer;
                begin
                    recPurchHdr.Reset();
                    recPurchHdr.SetRange("No.", Rec."No.");

                    if Rec."EDC Procurement Type" = Rec."EDC Procurement Type"::CAPEX then begin
                        REPORT.RUNMODAL(Report::"Purchase Order Print_New", TRUE, TRUE, recPurchHdr);
                    end else if Rec."EDC Procurement Type" = Rec."EDC Procurement Type"::OPEX then begin
                        REPORT.RUNMODAL(Report::"Work Order Print", TRUE, TRUE, recPurchHdr);
                    end else
                        Error('Procurement Type is not configured for printing.');
                end;

            }
        }


    }
    var
        recPurchHdr: Record "Purchase Header";

}
