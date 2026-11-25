codeunit 50005 "E3 Rev./Rev. Ret. Scheduler"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        HISIntegrationSetup.Get();
        ProcessData();
    end;

    local procedure ProcessData()
    var
        RevenueHeader: Record "E3 HIS Revenue Header";
        HeaderToPost: Record "E3 HIS Revenue Header";
        FailedHeader: Record "E3 HIS Revenue Header";
        RevenuePostMgmt: Codeunit "E3 Revenue Post Mgmt.";
        HeaderSystemId: Guid;
        PostingError: Text;
        UnknownPostingErr: Label 'An unknown error occurred during revenue invoice posting.';
    begin
        RevenueHeader.SetRange("Record Type", RevenueHeader."Record Type"::Revenue);
        RevenueHeader.SetRange("Document Type", RevenueHeader."Document Type"::Invoice);
        RevenueHeader.SetRange("Create Revenue", false);
        RevenueHeader.SetRange("Error Description", '');

        if RevenueHeader.FindSet() then
            repeat
                HeaderToPost := RevenueHeader;
                HeaderSystemId := HeaderToPost.SystemId;

                Clear(RevenuePostMgmt);
                ClearLastError();
                if not RevenuePostMgmt.Run(HeaderToPost) then begin
                    PostingError := GetLastErrorText();
                    if PostingError = '' then
                        PostingError := UnknownPostingErr;

                    if FailedHeader.GetBySystemId(HeaderSystemId) then begin
                        FailedHeader."Error Description" :=
                            CopyStr(PostingError, 1, MaxStrLen(FailedHeader."Error Description"));
                        FailedHeader.Modify(true);
                        Commit();
                    end;
                end;
            until RevenueHeader.Next() = 0;
    end;

    var
        HISIntegrationSetup: Record "E3 HIS Integartion Setup";
        xRevHeader: Record "E3 HIS Revenue Header";
        RevHeader: Record "E3 HIS Revenue Header";
        RevPostMgmt: Codeunit "E3 Revenue Post Mgmt.";
}