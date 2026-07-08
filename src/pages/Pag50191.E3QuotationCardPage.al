page 50191 "E3 Quotation Card"
{
    Caption = 'Quotation Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Document;
    SourceTable = "E3 Indent Header";
    SourceTableView = WHERE(Status = FILTER(Approved), "Release Indent" = FILTER(false));
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Indent No.';
                    Editable = HeaderEditable;
                    ToolTip = 'Specifies the indent number of the Indent No.';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    Editable = HeaderEditable;
                    ToolTip = 'Specifies the requested by of the Requested By.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    Editable = HeaderEditable;
                    ToolTip = 'Specifies the request date of the Request Date.';
                }
                field("Voucher Type Code"; Rec."Voucher Type Code")
                {
                    ApplicationArea = All;
                    Editable = HeaderEditable;
                    ToolTip = 'Specifies the voucher type code of the Voucher Type Code.';
                }
                field("Voucher Type Name"; Rec."Voucher Type Name")
                {
                    ApplicationArea = All;
                    Editable = HeaderEditable;
                    ToolTip = 'Specifies the voucher type name of the Voucher Type Name.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = HeaderEditable;
                    ToolTip = 'Specifies the status of the Status.';
                }

                field("Expected Receive Date"; Rec."Expected Receive Date")
                {
                    ApplicationArea = All;
                    Editable = HeaderEditable;
                    ToolTip = 'Specifies the expected receive date of the Expected Receive Date.';
                }

                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    Editable = HeaderEditable;
                    ToolTip = 'Specifies the approved by of the Approved By.';
                }
            }
            part("Quotation 1"; "E3 Quotation L1")
            {
                SubPageLink = "Document No." = FIELD("Document No.");
                Visible = true;
            }
            part("Quotation 2"; "E3 Quotation L2")
            {
                SubPageLink = "Document No." = FIELD("Document No.");
                Visible = true;
            }
            part("Quotation 3"; "E3 Quotation L3")
            {
                SubPageLink = "Document No." = FIELD("Document No.");
                Visible = true;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreatePO)
            {
                Caption = 'Create Purchase Order';
                ApplicationArea = All;
                Image = CreateDoc;

                trigger OnAction()
                var
                    Location: Record Location;
                    IndentLine: Record "E3 Indent Line";
                begin
                    if not Confirm('Do you want to create Purchase Order?', true) then
                        exit;

                    Rec.TestField("Location Code");

                    Location.Get(Rec."Location Code");
                    Location.TestField("E3 Indent PO Series");

                    IndentLine.Reset();
                    IndentLine.SetRange("Document No.", Rec."Document No.");

                    Clear(CreatePurchaseOrders);
                    CreatePurchaseOrders.SetNoSeries(Location."E3 Indent PO Series");
                    CreatePurchaseOrders.SetTableView(IndentLine);
                    CreatePurchaseOrders.RunModal();
                end;

            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        HeaderEditable := Rec.Status <> Rec.Status::Approved;
    end;

    var
        IndentLine: Record "E3 Indent Line";
        IndentHeader: Record "E3 Indent Header";
        CreatePurchaseOrders: Report "E3 Create Purchase Order";
        HeaderEditable: Boolean;
}