page 50182 "E3 Indent Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "E3 Indent Header";
    Caption = 'Indent Header';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Indent No.';
                    ApplicationArea = All;
                    AssistEdit = true;
                    Editable = IsPageEditable;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Indentor; Rec.Indenter)
                {
                    ApplicationArea = All;
                    Editable = IsPageEditable;
                }
                field("Requested To"; Rec."Requested To")
                {
                    ApplicationArea = All;
                    Editable = IsPageEditable;
                }

                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expected Receive Date"; Rec."Expected Receive Date")
                {
                    ApplicationArea = All;
                    Editable = IsPageEditable;
                    trigger OnValidate()
                    begin
                        if Rec."Request Date" = 0D then
                            Error('Request Date must be entered before Expected Receive Date.');

                        if Rec."Expected Receive Date" < Rec."Request Date" then
                            Error(
                                'Expected Receive Date (%1) cannot be earlier than Request Date (%2).',
                                Rec."Expected Receive Date",
                                Rec."Request Date");
                    end;
                }
                field("Voucher Type Code"; Rec."Voucher Type Code")
                {
                    ApplicationArea = All;
                    Editable = IsPageEditable;
                    Visible = false;
                }
                field("Voucher Type Name"; Rec."Voucher Type Name")
                {
                    ApplicationArea = All;
                    Editable = IsPageEditable;
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = IsPageEditable;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    Editable = IsPageEditable;
                }
                field("Approval Date Time"; Rec."Approval Date Time")
                {
                    ApplicationArea = All;
                    Editable = IsPageEditable;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = IsPageEditable;
                }
                field("Budget Type"; Rec."Budget Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the budget type for this record.';
                }

                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the budgeted amount for this record.';
                }
                field("Utilized Amount"; Rec."Utilized Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Utilized amount for this record.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual amount for this record.';
                }
            }

            group("Dimensions")
            {
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Business Unit';
                    Editable = IsPageEditable;
                }
                field("Business Unit Name"; Rec."Business Unit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = IsPageEditable;
                    Caption = 'Department Code';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("To Department Code"; Rec."To Department Code")
                {
                    ApplicationArea = All;
                    Editable = IsPageEditable;
                }
                field("To Department Name"; Rec."To Department Name")
                {
                    ApplicationArea = All;
                    Editable = IsPageEditable;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = IsPageEditable;
                }

                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("To Location Code"; Rec."To Location Code")
                {
                    ApplicationArea = All;
                    Editable = IsPageEditable;
                }
                field("To Location Name"; Rec."To Location Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(IndentLines; "E3 Indent Line Subform")
            {
                ApplicationArea = All;
                Caption = 'Indent Line Subform';
                SubPageLink = "Document No." = FIELD("Document No.");
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
            systempart(Control1000000050; Notes)
            {
            }
        }

    }
    actions
    {
        area(Processing)
        {
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                Image = Approval;

                action(SendApproval)
                {
                    Caption = 'Send Approval Request';
                    ApplicationArea = All;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = ShowApprovalActions;

                    trigger OnAction()
                    var
                        IndentApproval: Codeunit "E3 Indent Approval Mgmt.";
                        IndentLine: Record "E3 Indent Line";
                    begin
                        IndentLine.SetRange("Document No.", Rec."Document No.");

                        if IndentLine.FindSet() then
                            repeat
                                if IndentLine."Requested Qty" <= 0 then
                                    Error(
                                      'Requested Qty must be greater than 0 for Line No. %1.',
                                      IndentLine."Line No.");

                                if IndentLine."Approved Qty" <= 0 then
                                    Error(
                                      'Approved Qty must be greater than 0 for Line No. %1.',
                                      IndentLine."Line No.");
                            until IndentLine.Next() = 0;

                        IndentApproval.OnSendIndentDocForApproval(Rec);

                        CurrPage.Update(true);
                    end;
                }

                action(CancelApproval)
                {
                    Caption = 'Cancel Approval Request';
                    ApplicationArea = All;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = ShowApprovalActions;

                    trigger OnAction()
                    var
                        IndentApproval: Codeunit "E3 Indent Approval Mgmt.";
                    begin
                        IndentApproval.OnCancelIndentApprovalRequest(Rec);
                        CurrPage.Update(true);
                    end;
                }
            }
            action(ReopenIndent)
            {
                Caption = 'Reopen Indent';
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                Visible = Rec.Status = Rec.Status::Approved;
                ToolTip = 'Reopens the approved indent for modification.';

                trigger OnAction()
                begin
                    if not Confirm('Do you want to reopen this approved indent?', false) then
                        exit;

                    Rec.Status := Rec.Status::Open; // Change to your initial status if different
                    Rec."Approved By" := '';
                    Rec."Approval Date Time" := 0DT;
                    Rec.Modify(true);

                    CurrPage.Update(true);

                    Message('Indent %1 has been reopened successfully.', Rec."Document No.");
                end;
            }

            action(ApprovalEntries)
            {
                Caption = 'Approval Entries';
                ApplicationArea = All;
                Image = ApprovalEntries;
                RunObject = Page "Approval Entries";
                RunPageLink = "Document No." = FIELD("Document No.");
                RunPageView = sorting("Document No.")
                          order(Ascending)
                          where("Table ID" = const(50051));
            }
            action(ShortCloseIndent)
            {
                Caption = 'Short Closed Indent';
                Image = Close;
                ToolTip = 'Executes the Short Closed Indent action.';

                trigger OnAction()
                begin
                    Rec.ShortCloseIndent(Rec);
                end;
            }

        }
    }
    var
        IsPageEditable: Boolean;
        IsEditable: Boolean;
        ShowApprovalActions: Boolean;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Request Date" := WorkDate();
        Rec."Source Type" := "E3 Source Type"::D365
    end;

    trigger OnOpenPage()
    begin

        Rec."Source Type" := Rec."Source Type"::D365;
        IsEditable := Rec.Status <> Rec.Status::Approved;
        SetPageEditable();
    end;

    trigger OnAfterGetRecord()
    begin
        SetPageEditable();
    end;

    local procedure SetPageEditable()
    begin
        IsPageEditable :=
        (Rec.Status <> Rec.Status::"Pending Approval") and
        (Rec.Status <> Rec.Status::Approved) and
        (not Rec."Short Close Indent");

        IsEditable := IsPageEditable;

        ShowApprovalActions := Rec.Status <> Rec.Status::Approved;
    end;


}