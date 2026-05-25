page 50034 "E3 HIS Delete Document"
{
    ApplicationArea = All;
    Caption = 'HIS Reprocess Document';
    PageType = List;
    SourceTable = "E3 HIS Delete Document";
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("HIS Document Type"; Rec."HIS Document Type")
                {
                    ToolTip = 'Specifies the value of the HIS Document Type field.', Comment = '%';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field(Status; rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Specifies the value of the Approved By field.', Comment = '%';
                }
                field("Approved Datetime"; Rec."Approved Datetime")
                {
                    ToolTip = 'Specifies the value of the Approved Datetime field.', Comment = '%';
                }
                field("Processed By"; Rec."Processed By")
                {
                    ToolTip = 'Specifies the value of the Processed By field.', Comment = '%';
                }
                field("Processed Datetime"; Rec."Processed Datetime")
                {
                    ToolTip = 'Specifies the value of the Processed Datetime field.', Comment = '%';
                }
                field("Error Text"; Rec."Error Text")
                {
                    ToolTip = 'Specifies the value of the Processed Datetime field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {

            action("Validate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Validate';
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Validate action.';

                trigger OnAction()
                begin
                    ProcessDeletedDocuments.ValidateDeleteDocument();
                end;
            }
            action("Approve Validated")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approve Validated';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Approve Validated action.';

                trigger OnAction()
                begin
                    UserSetup.get(UserId);
                    if not UserSetup."E3 Document Delete Approver" then
                        Error('You are not authorized to approve.');

                    DeletedDocuments.Reset();
                    DeletedDocuments.SetRange(Status, DeletedDocuments.Status::Validated);
                    if DeletedDocuments.FindFirst() then
                        repeat
                            DeletedDocumentModify.Get(DeletedDocuments."Entry No.");
                            DeletedDocumentModify.Status := DeletedDocuments.Status::Approved;
                            DeletedDocumentModify."Approved By" := UserId;
                            DeletedDocumentModify."Approved Datetime" := CurrentDateTime;
                            DeletedDocumentModify.Modify();
                        until DeletedDocuments.Next() = 0
                end;
            }
            action("Process Approved")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Process Approved';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Process Approved action.';

                trigger OnAction()
                begin
                    UserSetup.get(UserId);
                    if not UserSetup."E3 Document Delete Processor" then
                        Error('You are not authorized to process.');

                    ProcessDeletedDocuments.ProcessDeleteDocument();
                end;
            }
        }
    }
    var
        UserSetup: Record "User Setup";
        DeletedDocuments, DeletedDocumentModify : Record "E3 HIS Delete Document";
        ProcessDeletedDocuments: Codeunit "E3 HIS Delete Document";

}
