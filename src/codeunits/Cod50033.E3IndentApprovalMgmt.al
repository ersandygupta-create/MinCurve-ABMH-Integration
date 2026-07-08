codeunit 50033 "E3 Indent Approval Mgmt."
{
    #region Indent Approval Events
    [IntegrationEvent(false, false)]
    procedure OnSendIndentDocForApproval(var E3IndentHeader: Record "E3 Indent Header") //Send Approval Request
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelIndentApprovalRequest(var E3IndentHeader: Record "E3 Indent Header") //Cancel Approval Request
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseIndentDoc(var E3IndentHeader: Record "E3 Indent Header") //Release After Approval
    begin
    end;
    #endregion Indent Approval Events
    #region Indent Approval Subscribers
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"E3 Indent Approval Mgmt.", 'OnSendIndentDocForApproval', '', false, false)]
    local procedure RunWorkflowOnSendIndentDocForApproval(var E3IndentHeader: Record "E3 Indent Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendIndentDocForApprovalCode(), E3IndentHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"E3 Indent Approval Mgmt.", 'OnCancelIndentApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelIndentApprovalRequest(var E3IndentHeader: Record "E3 Indent Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelIndentApprovalRequestCode(), E3IndentHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"E3 Indent Approval Mgmt.", 'OnAfterReleaseIndentDoc', '', false, false)]
    local procedure RunWorkflowOnAfterReleaseIndentDoc(var E3IndentHeader: Record "E3 Indent Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseIndentDocCode(), E3IndentHeader);
    end;
    #endregion Indent Approval Subscribers
    #region Indent Approval Supported Functions
    local procedure RunWorkflowOnSendIndentDocForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendIndentDocForApproval'));
    end;

    local procedure RunWorkflowOnCancelIndentApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelIndentApprovalRequest'));
    end;

    local procedure RunWorkflowOnAfterReleaseIndentDocCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnAfterReleasIndentDoc'));
    end;

    local procedure InsertIndentDetailReqPageFields()
    var
        E3IndentHeader: Record "E3 Indent Header";
        WorkflowRequestPageHandling: Codeunit "Workflow Request Page Handling";
    begin
        WorkflowRequestPageHandling.InsertDynReqPageField(DATABASE::"E3 Indent Header", E3IndentHeader.FIELDNO("Document No."));
        WorkflowRequestPageHandling.InsertDynReqPageField(DATABASE::"E3 Indent Header", E3IndentHeader.FIELDNO("Request Date"));
        WorkflowRequestPageHandling.InsertDynReqPageField(DATABASE::"E3 Indent Header", E3IndentHeader.FIELDNO(Status));
    end;

    local procedure InsertIndentLineReqPageFields()
    var
        IndentLines: Record "E3 Indent Line";
        WorkflowRequestPageHandling: Codeunit "Workflow Request Page Handling";
    begin
        WorkflowRequestPageHandling.InsertDynReqPageField(DATABASE::"E3 Indent Line", IndentLines.FIELDNO("Document No."));
        WorkflowRequestPageHandling.InsertDynReqPageField(DATABASE::"E3 Indent Line", IndentLines.FIELDNO("Line No."));
    end;

    local procedure InsertIndentApprovalWorkflowDetails(var Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        E3IndentHeader: Record "E3 Indent Header";
        WorkflowSetup: Codeunit "Workflow Setup";
        BlankDateFormula: DateFormula;
    begin
        WorkflowSetup.InitWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Approver Chain", 0, '', BlankDateFormula, true);
        WorkflowSetup.InsertDocApprovalWorkflowSteps(Workflow, BuildIndentConditions(E3IndentHeader.Status::Open), RunWorkflowOnSendIndentDocForApprovalCode(), BuildIndentConditions(E3IndentHeader.Status::"Pending Approval"), RunWorkflowOnCancelIndentApprovalRequestCode(), WorkflowStepArgument, true);
    end;

    local procedure BuildIndentConditions(Status: Option): Text
    var
        E3IndentHeader: Record "E3 Indent Header";
        IndentLines: Record "E3 Indent Line";
        WorkflowSetup: Codeunit "Workflow Setup";
        IndentCondnTxt: label '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name="Indent Header">%1</DataItem><DataItem name="Indent Line">%2</DataItem></DataItems></ReportParameters>', Comment = '%1 Header, %2 Line';
    begin
        E3IndentHeader.SETRANGE(Status, Status);
        exit(StrSubstNo(IndentCondnTxt, WorkflowSetup.Encode(E3IndentHeader.GETVIEW(FALSE)), WorkflowSetup.Encode(IndentLines.GETVIEW(FALSE))));
    end;

    local procedure GetRequDocCatCode(): Code[20]
    begin
        exit('REQDOC');
    end;

    local procedure IsIndentApprovalsWorkflowEnabled(var E3IndentHeader: Record "E3 Indent Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        if E3IndentHeader.Status <> E3IndentHeader.Status::Open then exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(E3IndentHeader, RunWorkflowOnSendIndentDocForApprovalCode()));
    end;
    #endregion Indent Approval Supported Functions
    #region Indent Approval Setup
    #region Workflow Event Handling Subscribers
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddIndentEventsToLibrary()
    var
        WorkflowEventhandling: Codeunit "Workflow Event Handling";
        IndentDocSendForApprovalEventDescTxt: Label 'Approval of a Indent document is requested.';
        IndentDocApprReqCancelledEventDescTxt: Label 'An approval request for a Indent document is canceled.';
        IndentDocReleasedEventDescTxt: Label 'A Indent document is released.';
    begin
        WorkflowEventhandling.AddEventToLibrary(RunWorkflowOnSendIndentDocForApprovalCode(), DATABASE::"E3 Indent Header", IndentDocSendForApprovalEventDescTxt, 0, false);
        WorkflowEventhandling.AddEventToLibrary(RunWorkflowOnCancelIndentApprovalRequestCode(), DATABASE::"E3 Indent Header", IndentDocApprReqCancelledEventDescTxt, 0, false);
        WorkflowEventhandling.AddEventToLibrary(RunWorkflowOnAfterReleaseIndentDocCode(), DATABASE::"E3 Indent Header", IndentDocReleasedEventDescTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddIndentPredecessors(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        case EventFunctionName of
            RunWorkflowOnCancelIndentApprovalRequestCode():
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelIndentApprovalRequestCode(), RunWorkflowOnSendIndentDocForApprovalCode());
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode():
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendIndentDocForApprovalCode());
            WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode():
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendIndentDocForApprovalCode());
            WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode():
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendIndentDocForApprovalCode());
        end;
    end;
    #endregion Workflow Event Handling Subscribers
    #region Workflow Response Handling Subscribers
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure IndentOpen(RecRef: RecordRef; var Handled: Boolean)
    var
        E3IndentHeader: Record "E3 Indent Header";
    begin
        if RecRef.Number = DATABASE::"E3 Indent Header" Then begin
            RecRef.SETTABLE(E3IndentHeader);
            E3IndentHeader.VALIDATE(Status, E3IndentHeader.Status::Open);
            E3IndentHeader.MODIFY(true);
            Handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure IndentRelease(RecRef: RecordRef; var Handled: Boolean)
    var
        E3IndentHeader: Record "E3 Indent Header";
    begin
        if RecRef.Number = DATABASE::"E3 Indent Header" Then begin
            RecRef.SETTABLE(E3IndentHeader);
            E3IndentHeader.VALIDATE(Status, E3IndentHeader.Status::Approved);
            E3IndentHeader.MODIFY(true);
            EnqueueEmailToSender(E3IndentHeader);
            Handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure AddResponseHandlingForIndent(ResponseFunctionName: Code[128])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode():
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode(), RunWorkflowOnSendIndentDocForApprovalCode());
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode():
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode(), RunWorkflowOnSendIndentDocForApprovalCode());
            WorkflowResponseHandling.CancelAllApprovalRequestsCode():
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode(), RunWorkflowOnCancelIndentApprovalRequestCode());
            WorkflowResponseHandling.OpenDocumentCode():
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode(), RunWorkflowOnCancelIndentApprovalRequestCode());
        end;
    end;
    #endregion Workflow Response Handling Subscribers
    #region Workflow Request Page Handling Subscribers
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Request Page Handling", 'OnAfterAssignEntitiesToWorkflowEvents', '', false, false)]
    local procedure AssignIndentEntitiestoWorkflow()
    var
        WorkflowRequestPageHandling: Codeunit "Workflow Request Page Handling";
    begin
        WorkflowRequestPageHandling.AssignEntityToWorkflowEvent(DATABASE::"E3 Indent Header", IndentDocumentCodeTxt);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Request Page Handling", 'OnAfterInsertRequestPageEntities', '', false, false)]
    local procedure IndentAfterInsertRequestPageEntities()
    var
        WorkflowRequestPageHandling: Codeunit "Workflow Request Page Handling";
        IndentDocumentDescTxt: Label 'Indent Detail Document';
    begin
        WorkflowRequestPageHandling.InsertReqPageEntity(IndentDocumentCodeTxt, IndentDocumentDescTxt, DATABASE::"E3 Indent Header", DATABASE::"E3 Indent Line");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Request Page Handling", 'OnAfterInsertRequestPageFields', '', false, false)]
    local procedure IndentOnAfterInsertRequestPageFields()
    begin
        InsertIndentDetailReqPageFields();
        InsertIndentLineReqPageFields();
    end;
    #endregion Workflow Request Page Handling Subscribers
    #region Add Indent Approval To Template
    procedure InsertIndentApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
        WorkflowSetup: Codeunit "Workflow Setup";
        IndentApprWorkflowCodeTxt: Label 'IndentAPW';
        IndentApprWorkflowDescTxt: Label 'Indent Approval Workflow';
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, IndentApprWorkflowCodeTxt, IndentApprWorkflowDescTxt, GetRequDocCatCode());
        WorkflowSetup.InsertApprovalsTableRelations();
        InsertIndentApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;
    #endregion Add Indent Approval To Template
    #region Workflow Setup Subscribers
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', false, false)]
    local procedure AddIndentWorflowToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
        IndentDocCategoryDescTxt: Label 'Indent Document';
    begin
        WorkflowSetup.InsertWorkflowCategory(GetRequDocCatCode(), IndentDocCategoryDescTxt);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAfterInsertApprovalsTableRelations', '', false, false)]
    local procedure OnAfterInsertApprovalTableRelations()
    var
        ApprovalEntry: Record "Approval Entry";
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(Database::"E3 Indent Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnInsertWorkflowTemplates', '', false, false)]
    local procedure IndentOnInsertWorkflowTemplates()
    begin
        InsertIndentApprovalWorkflowTemplate();
    end;
    #endregion Workflow Setup Subscribers
    #endregion Indent Approval Setup
    #region Approvals Mgmt. Subscribers
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure IndentApprovalToPendingApproval(RecRef: RecordRef; var IsHandled: Boolean; var Variant: Variant)
    var
        E3IndentHeader: Record "E3 Indent Header";
    begin
        case RecRef.Number of
            DATABASE::"E3 Indent Header":
                begin
                    RecRef.SETTABLE(E3IndentHeader);
                    E3IndentHeader.VALIDATE(Status, E3IndentHeader.Status::"Pending Approval");
                    E3IndentHeader.MODIFY(true);
                    Variant := E3IndentHeader;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateIndentEntryArgument(var ApprovalEntryArgument: Record "Approval Entry"; var RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        E3IndentHeader: Record "E3 Indent Header";
    begin
        case RecRef.Number of
            DATABASE::"E3 Indent Header":
                begin
                    RecRef.SETTABLE(E3IndentHeader);
                    ApprovalEntryArgument."Document No." := E3IndentHeader."Document No.";
                    E3IndentHeader.CalcFields(Amount);
                    ApprovalEntryArgument.Amount := E3IndentHeader.Amount;
                    ApprovalEntryArgument."Currency Code" := E3IndentHeader."Currency Code";
                end;
        end;
    end;
    #endregion Approvals Mgmt. Subscribers
    #region Check Approval Enabled
    procedure CheckIndentApprovalsWorkflowEnabled(VAR E3IndentHeader: Record "E3 Indent Header"): Boolean
    var
        NoWorkflowEnabledErr: Label 'This record is not supported by related approval workflow.';
    begin
        if not IsIndentApprovalsWorkflowEnabled(E3IndentHeader) then error(NoWorkflowEnabledErr);
        exit(true);
    end;
    #endregion Check Approval Enabled
    #region Indent Approval Comment
    procedure CopyReqCommentsToApprovalComments(var E3IndentHeader: Record "E3 Indent Header")
    var
        CommentLine: Record "Comment Line";
        ApprovalCommentLine: Record "Approval Comment Line";
    begin
        //CommentLine.SetRange("Table Name", CommentLine."Table Name"::"E3 Indent Header");//ak
        CommentLine.SetRange("No.", E3IndentHeader."Document No.");
        CommentLine.SetRange("Line No.", 0);
        If CommentLine.FindSet() then
            repeat
                ApprovalCommentLine.Init();
                ApprovalCommentLine."Table ID" := Database::"E3 Indent Header";
                ApprovalCommentLine."Record ID to Approve" := E3IndentHeader.RecordId;
                ApprovalCommentLine.Comment := CommentLine.Comment;
                ApprovalCommentLine.Insert(true);
            until (CommentLine.Next() = 0);
    end;

    procedure DeleteReqCommentsToApprovalComments(var E3IndentHeader: Record "E3 Indent Header")
    var
        ApprovalCommentLine: Record "Approval Comment Line";
    begin
        ApprovalCommentLine.SetRange("Table ID", Database::"E3 Indent Header");
        ApprovalCommentLine.SetRange("Record ID to Approve", E3IndentHeader.RecordId);
        IF ApprovalCommentLine.FindSet() then ApprovalCommentLine.DeleteAll(true);
    end;
    #endregion Indent Approval Comment
    #region Reqiusion Approval Emails
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeCreateApprovalEntryNotification', '', false, false)]
    local procedure EDCOnBeforeCreateApprovalEntryNotification(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    var
        E3IndentHeader: Record "E3 Indent Header";
        DataTypeMgmt: Codeunit "Data Type Management";
        ResultRecordRef: RecordRef;
    begin
        if ApprovalEntry."Table ID" <> Database::"E3 Indent Header" then exit;
        IsHandled := true;
        DataTypeMgmt.GetRecordRef(ApprovalEntry."Record ID to Approve", ResultRecordRef);
        ResultRecordRef.SETTABLE(E3IndentHeader);
        if ApprovalEntry."Sender ID" <> ApprovalEntry."Approver ID" then
            Case ApprovalEntry.Status of
                ApprovalEntry.Status::Open:
                    EnqueueEmailToApprover(E3IndentHeader, ApprovalEntry);
                ApprovalEntry.Status::Approved: //Approver Approved
                    EnqueueEmailToSender(E3IndentHeader, ApprovalEntry);
                ApprovalEntry.Status::Rejected: //Approver Rejected
                    EnqueueEmailToSender(E3IndentHeader, ApprovalEntry);
            End;
    end;

    local procedure EnqueueEmailToSender(E3IndentHeader: Record "E3 Indent Header"; ApprovalEntry: Record "Approval Entry"): Boolean
    var
        UserSetup: Record "User Setup";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
    begin
        if not UserSetup.Get(ApprovalEntry."Sender ID") then exit(false);
        if UserSetup."E-Mail" = '' then exit(false);
        EmailMessage.Create(UserSetup."E-Mail", GenerateIndentEmailSubject(E3IndentHeader, ApprovalEntry.Status), GetSenderEmailBody(E3IndentHeader, ApprovalEntry), true);
        Email.Enqueue(EmailMessage);
    end;

    local procedure EnqueueEmailToSender(E3IndentHeader: Record "E3 Indent Header")
    var
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        ReleaseBodyLbl: Label 'Document No.. %1 is Released.', Comment = '%1 Document No.';
    begin
        ApprovalEntry.SetRange("Record ID to Approve", E3IndentHeader.RecordId);
        ApprovalEntry.SetRange("Table ID", Database::"E3 Indent Header");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
        if ApprovalEntry.FindLast() then begin
            if not UserSetup.Get(ApprovalEntry."Sender ID") then exit;
            if UserSetup."E-Mail" = '' then exit;
            EmailMessage.Create(UserSetup."E-Mail", StrSubstNo(ReleaseBodyLbl, E3IndentHeader."Document No."), GetApprovedEmailBody(E3IndentHeader, ApprovalEntry."Sender ID"), true);
            Email.Enqueue(EmailMessage);
        end;
    end;

    local procedure GetApprovedEmailBody(E3IndentHeader: Record "E3 Indent Header"; RecipientUserId: Code[50]) EmailBody: Text
    begin
        EmailBody := 'Dear ' + GetUserName(RecipientUserId) + ',</br></br>';
        EmailBody += 'I am writing to confirm that the Expenditure Indent that you requested has been released.</br></br>';
        AddCapexIndentDetails(E3IndentHeader, EmailBody);
        AddApprovalEntriesDetails(E3IndentHeader, EmailBody);
        EmailBody += 'Thank you for your cooperation and support.</br></br>';
        EmailBody += 'Regards,</br></br>';
        EmailBody += 'System  Email, D365 E-Notification.';
    end;

    local procedure EnqueueEmailToApprover(E3IndentHeader: Record "E3 Indent Header"; ApprovalEntry: Record "Approval Entry"): Boolean
    var
        ApproverUserSetup, SenderUserSetup : Record "User Setup";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
    begin
        if (not ApproverUserSetup.Get(ApprovalEntry."Approver ID")) and (not SenderUserSetup.Get(ApprovalEntry."Sender ID")) then exit(false);
        if (ApproverUserSetup."E-Mail" = '') and (SenderUserSetup."E-Mail" = '') then exit(false);
        EmailMessage.Create(ApproverUserSetup."E-Mail", GenerateIndentEmailSubject(E3IndentHeader, ApprovalEntry.Status), GetApprovalEmailBody(E3IndentHeader, ApprovalEntry."Approver ID"), true);
        EmailMessage.AddRecipient("Email Recipient Type"::Cc, SenderUserSetup."E-Mail");
        Email.Enqueue(EmailMessage);
    end;

    local procedure GenerateIndentEmailSubject(E3IndentHeader: Record "E3 Indent Header"; Status: Enum "Approval Status"): Text
    begin
        Case Status of
            Status::Open:
                exit('Approval Request for Document No.. ' + E3IndentHeader."Document No.");
            Status::Approved:
                exit('Approval Request for Document No.. ' + E3IndentHeader."Document No." + ' has been Approved');
            Status::Canceled:
                exit('Approval Request for Document No.. ' + E3IndentHeader."Document No." + ' has been Cancelled');
            Status::Rejected:
                exit('Approval Request for Document No.. ' + E3IndentHeader."Document No." + ' has been Rejected');
        End;
    end;

    local procedure GetSenderEmailBody(E3IndentHeader: Record "E3 Indent Header"; ApprovalEntry: Record "Approval Entry") EmailBody: Text
    begin
        EmailBody := 'Dear ' + GetUserName(ApprovalEntry."Approver ID") + ',</br></br>';
        Case ApprovalEntry.Status of
            ApprovalEntry.Status::Open:
                EmailBody += 'Approval request for Document No.. ' + E3IndentHeader."Document No." + ' has been sent for approval to ' + ApprovalEntry."Approver ID" + '.</br></br>';
            ApprovalEntry.Status::Approved:
                EmailBody += 'Approval request for Document No.. ' + E3IndentHeader."Document No." + ' has been approved by ' + ApprovalEntry."Approver ID" + '.</br></br>';
            ApprovalEntry.Status::Canceled:
                EmailBody += 'Approval request for Document No.. ' + E3IndentHeader."Document No." + ' has been cancelled by you.</br></br>';
            ApprovalEntry.Status::Rejected:
                EmailBody += 'Approval request for Document No.. ' + E3IndentHeader."Document No." + ' has been rejected by ' + ApprovalEntry."Approver ID" + '.</br></br>';
        end;
    end;

    local procedure GetApprovalEmailBody(E3IndentHeader: Record "E3 Indent Header"; RecipientUserId: Code[50]) EmailBody: Text
    begin
        EmailBody := 'Dear ' + GetUserName(RecipientUserId) + ',</br></br>';
        EmailBody += 'I am writing to seek your approval for a Expenditure Indent that has been prepared in accordance with our company''s policies and guidelines.</br></br>';
        AddCapexIndentDetails(E3IndentHeader, EmailBody);
        EmailBody += 'Please review the attached Reference Indent for additional details. </br></br>';
        AddApprovalEntriesDetails(E3IndentHeader, EmailBody);
        EmailBody += 'Thank you for your cooperation and support.</br></br>';
        EmailBody += 'Regards,</br></br>';
        EmailBody += 'System  Email, D365 E-Notification.';
    end;

    local procedure GetUserName(PassedUserId: Code[50]): Text[80]
    var
        User: Record User;
    begin
        User.SetRange("User Name", PassedUserId);
        if User.FindFirst() then exit(User."Full Name");
        exit(PassedUserId);
    end;

    local procedure AddCapexIndentDetails(E3IndentHeader: Record "E3 Indent Header"; var EmailBody: Text)
    var
        DimensionValue: Record "Dimension Value";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        GeneralLedgerSetup.Get();
        E3IndentHeader.CalcFields(Amount);
        EmailBody += 'The details of the Indent are as follows:- </br></br>';
        EmailBody := EmailBody + '<table border="1">';
        EmailBody := EmailBody + '<tr>';
        EmailBody := EmailBody + '<td>' + 'Document No.' + '</td>';
        EmailBody := EmailBody + '<td>' + E3IndentHeader."Document No." + '</td>';
        EmailBody := EmailBody + '</tr>';
        EmailBody := EmailBody + '<tr>';
        EmailBody := EmailBody + '<td>' + 'Amount' + '</td>';
        EmailBody := EmailBody + '<td>' + Format(E3IndentHeader.Amount) + '</td>';
        EmailBody := EmailBody + '</tr>';
        EmailBody := EmailBody + '<tr>';
        EmailBody := EmailBody + '<td>' + 'Budgeted Amount' + '</td>';
        EmailBody := EmailBody + '<td>' + Format(E3IndentHeader."Budgeted Amount") + '</td>';
        EmailBody := EmailBody + '</tr>';
        EmailBody := EmailBody + '<tr>';
        EmailBody := EmailBody + '<td>' + 'Category' + '</td>';
        EmailBody := EmailBody + '<td>' + Format(E3IndentHeader."Procurement Type") + '</td>';
        EmailBody := EmailBody + '</tr>';
        EmailBody := EmailBody + '<tr>';
        EmailBody := EmailBody + '<td>' + 'Currency' + '</td>';
        EmailBody := EmailBody + '<td>' + Format(E3IndentHeader."Currency Code") + '</td>';
        EmailBody := EmailBody + '</tr>';
        EmailBody := EmailBody + '<tr>';
        EmailBody := EmailBody + '<td>' + 'Unit Name' + '</td>';
        if DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 1 Code", E3IndentHeader."Shortcut Dimension 1 Code") then;
        EmailBody := EmailBody + '<td>' + DimensionValue.Name + '</td>';
        EmailBody := EmailBody + '</tr>';
        EmailBody := EmailBody + '<tr>';
        EmailBody := EmailBody + '<td>' + 'Department Name' + '</td>';
        if DimensionValue.Get(GeneralLedgerSetup."Shortcut Dimension 2 Code", E3IndentHeader."Shortcut Dimension 2 Code") then;
        EmailBody := EmailBody + '<td>' + DimensionValue.Name + '</td>';
        EmailBody := EmailBody + '</tr>';
        EmailBody := EmailBody + '</table>';
        EmailBody := EmailBody + '</br></br>';
    end;

    local procedure AddApprovalEntriesDetails(E3IndentHeader: Record "E3 Indent Header"; var EmailBody: Text)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetRange("Record ID to Approve", E3IndentHeader.RecordId);
        if ApprovalEntry.FindSet() then begin
            EmailBody := EmailBody + '<table border="1">';
            EmailBody := EmailBody + '<tr>';
            EmailBody := EmailBody + '<th>' + ApprovalEntry.FieldCaption("Sequence No.") + '</th>';
            EmailBody := EmailBody + '<th>' + ApprovalEntry.FieldCaption(Status) + '</th>';
            EmailBody := EmailBody + '<th>' + ApprovalEntry.FieldCaption("Sender ID") + '</th>';
            EmailBody := EmailBody + '<th>' + ApprovalEntry.FieldCaption("Approver ID") + '</th>';
            EmailBody := EmailBody + '<th>' + ApprovalEntry.FieldCaption("Date-Time Sent for Approval") + '</th>';
            EmailBody := EmailBody + '<th>' + ApprovalEntry.FieldCaption("Last Date-Time Modified") + '</th>';
            EmailBody := EmailBody + '<th>' + ApprovalEntry.FieldCaption("Last Modified By User ID") + '</th>';
            EmailBody := EmailBody + '<th>' + ApprovalEntry.FieldCaption("Due Date") + '</th>';
            EmailBody := EmailBody + '<th>' + ApprovalEntry.FieldCaption(Amount) + '</th>';
            EmailBody := EmailBody + '</tr>';
            repeat
                EmailBody := EmailBody + '<tr>';
                EmailBody := EmailBody + '<td>' + Format(ApprovalEntry."Sequence No.") + '</td>';
                EmailBody := EmailBody + '<td>' + Format(ApprovalEntry.Status) + '</td>';
                EmailBody := EmailBody + '<td>' + Format(ApprovalEntry."Sender ID") + '</td>';
                EmailBody := EmailBody + '<td>' + Format(ApprovalEntry."Approver ID") + '</td>';
                EmailBody := EmailBody + '<td>' + Format(ApprovalEntry."Date-Time Sent for Approval") + '</td>';
                EmailBody := EmailBody + '<td>' + Format(ApprovalEntry."Last Date-Time Modified") + '</td>';
                EmailBody := EmailBody + '<td>' + Format(ApprovalEntry."Last Modified By User ID") + '</td>';
                EmailBody := EmailBody + '<td>' + Format(ApprovalEntry."Due Date") + '</td>';
                EmailBody := EmailBody + '<td>' + Format(ApprovalEntry.Amount) + '</td>';
                EmailBody := EmailBody + '</tr>';
            until ApprovalEntry.Next() = 0;
            EmailBody := EmailBody + '</table>';
            EmailBody := EmailBody + '</br></br>';
        end;
    end;
    #endregion Reqiusion Approval Emails
    var
        IndentDocumentCodeTxt: Label 'IndentDETAILDOC';
}
