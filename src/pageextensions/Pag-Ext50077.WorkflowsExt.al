pageextension 50087 "E3 Indent Workflows" extends Workflows
{
    actions
    {
        addlast(Process)
        {
            action(AddIndentTemplate)
            {
                ApplicationArea = All;
                Caption = 'Add Indent Template';
                Image = Import;
                ToolTip = 'Add Indent Workflow Template.';
                Visible = ReqTemplateVisible;

                trigger OnAction()
                var
                    Workflow: Record Workflow;
                    E3ApprovalMgmt: Codeunit "E3 Indent Approval Mgmt.";
                    WorkflowSetup: Codeunit "Workflow Setup";
                begin
                    Workflow.Reset();
                    Workflow.SetRange(Template, true);
                    Workflow.SetFilter(Code, 'IndentDOC');
                    IF not Workflow.IsEmpty() then exit;
                    WorkflowSetup.InitWorkflow();
                    E3ApprovalMgmt.InsertIndentApprovalWorkflowTemplate();
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref(AddIndentTemplate_Promoted; AddIndentTemplate)
            {
            }
        }
    }
    trigger OnOpenPage()
    var
        Workflow: Record Workflow;
    begin
        Workflow.Reset();
        Workflow.SetRange(Template, true);
        Workflow.SetFilter(Code, 'IndentDOC');
        IF Workflow.IsEmpty() then ReqTemplateVisible := true;
    end;

    var
        ReqTemplateVisible: Boolean;
}
