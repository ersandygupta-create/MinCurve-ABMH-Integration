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
                field("Requested By"; Rec."Requested To")
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
                field("Indent Type"; Rec."Indent Type")
                {
                    ToolTip = 'Indent Type';
                    ApplicationArea = All;
                    Editable = HeaderEditable;
                }
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Project Code';
                    Editable = HeaderEditable;
                }
                field("AMC/CMC"; Rec."AMC/CMC")
                {
                    ApplicationArea = All;
                    ToolTip = 'AMC/CMC';
                    Editable = HeaderEditable;
                }
            }
            part("Quotation 1"; "E3 Quotation")
            {
                SubPageLink = "Document No." = FIELD("Document No.");
                Visible = true;
            }
        }
        area(factboxes)
        {
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"E3 Indent Header"), "No." = field("Document No.");
            }
            systempart(Control1000000031; Notes)
            {
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
                    IndentlineRec: Record "E3 Indent Line";
                begin
                    if not Confirm('Do you want to create Purchase Order?', true) then
                        exit;

                    Rec.TestField("Location Code");

                    Location.Get(Rec."Location Code");
                    Location.TestField("E3 Indent PO Series");

                    IndentlineRec.Reset();
                    indentlineRec.SetRange("Document No.", Rec."Document No.");
                    if indentlineRec.FindSet() then
                        repeat
                            IndentLineRec.TestField("Vendor No.");


                        until indentlineRec.Next() = 0;

                    IndentLine.Reset();
                    IndentLine.SetRange("Document No.", Rec."Document No.");



                    Clear(CreatePurchaseOrders);
                    CreatePurchaseOrders.SetNoSeries(Location."E3 Indent PO Series");
                    CreatePurchaseOrders.SetTableView(IndentLine);
                    CreatePurchaseOrders.RunModal();

                    Message('Purchase Order created successfully.');
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