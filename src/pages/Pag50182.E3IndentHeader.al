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
                field("Requested To"; Rec."Requested By")
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
    }
    actions
    {
        area(navigation)
        {
            group(Approval)
            {
                Caption = 'Approval';
                Image = Approval;
                action(SendApproval)
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        IndentApproval: Codeunit "E3 Indent Approval Mgmt.";
                        IndentLine: Record "E3 Indent Line";
                        IndentHeader: Record "E3 Indent Header";
                    begin
                        IndentLine.SetRange("Document No.", Rec."Document No.");

                        if IndentLine.FindSet() then
                            repeat
                                if IndentLine."Requested Qty" <= 0 then
                                    Error(
                                        'Requested Qty must be greater than 0 for Line No. %1 before sending the approval request.',
                                        IndentLine."Line No.");

                                if IndentLine."Approved Qty" <= 0 then
                                    Error(
                                        'Approved Qty must be greater than 0 for Line No. %1 before sending the approval request.',
                                        IndentLine."Line No.");
                            until IndentLine.Next() = 0;

                        IndentApproval.OnSendIndentDocForApproval(Rec);
                        IndentHeader.UpdateApprovalDetails();
                    end;
                }

                action(CancelApproval)
                {
                    Caption = 'Cancel Approval Request';
                    Image = CancelApprovalRequest;
                    Promoted = true;

                    trigger OnAction()
                    var
                        IndentApproval: Codeunit "E3 Indent Approval Mgmt.";
                    begin
                        IndentApproval.OnCancelIndentApprovalRequest(Rec);
                    end;
                }
                action(VersionHistory)
                {
                    Caption = 'Approval Entries';
                    ShortCutKey = 'Ctrl+F11';
                    Image = Versions;
                    ToolTip = 'Executes the Approval Entries action.';
                    RunObject = Page "Approval Entries";
                    RunPageLink = "Document No." = FIELD("Document No.");
                    RunPageView = sorting("Document No.") order(Ascending) where("Table ID" = filter(50051));
                }
                action(IndentSlip)
                {
                    ApplicationArea = All;
                    Caption = 'Indent Slip';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    ToolTip = 'Print the Indent Slip for the selected Indent Card.';

                    trigger OnAction()
                    var
                        IndentSlip: Record "E3 Indent Header";
                    begin
                        IndentSlip.Reset();
                        IndentSlip.SetRange("Document No.", Rec."Document No.");

                        if IndentSlip.FindFirst() then
                            Report.RunModal(
                                Report::"E3 Indent Slip",
                                true,
                                true,
                                IndentSlip)
                        else
                            Error('No posted gate entry found for Document No. %1.', Rec."Document No.");
                    end;
                }


            }
        }
    }
    var
        IsPageEditable: Boolean;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Request Date" := WorkDate();
    end;

    trigger OnOpenPage()
    begin
        SetPageEditable();
    end;

    trigger OnAfterGetRecord()
    begin
        SetPageEditable();
    end;

    local procedure SetPageEditable()
    begin
        IsPageEditable := Rec.Status <> Rec.Status::"Pending Approval";
    end;

}