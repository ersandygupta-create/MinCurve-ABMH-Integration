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
        ErrorText: Text;
    begin
        xRevHeader.Reset();
        xRevHeader.SetRange("Create Revenue", false);
        xRevHeader.SetRange("Error Description", '');
        xRevHeader.SetFilter("Customer No.", '<>%1', '');
        xRevHeader.SetFilter("No. of Lines", '<>%1', 0);
        xRevHeader.SetRange("Error 1", false);
        xRevHeader.SetRange("Error 2", false);
        xRevHeader.SetRange("Error 3", false);
        xRevHeader.SetRange("Error 4", false);

        if xRevHeader.FindSet() then
            repeat
                RevHeader := xRevHeader;

                ClearLastError();
                Clear(RevPostMgmt);

                // Process one document independently
                if not RevPostMgmt.Run(RevHeader) then begin

                    // Capture the processing error
                    ErrorText := GetLastErrorText();

                    if ErrorText = '' then
                        ErrorText := 'Unknown error occurred during revenue processing.';

                    // Update failed document header
                    xRevHeader."Error Description" :=
                        CopyStr(
                            ErrorText,
                            1,
                            MaxStrLen(xRevHeader."Error Description"));

                    xRevHeader.Modify(true);

                    // Save error and continue with next document
                    Commit();
                end;

            until xRevHeader.Next() = 0;
    end;

    var
        HISIntegrationSetup: Record "E3 HIS Integartion Setup";
        xRevHeader: Record "E3 HIS Revenue Header";
        RevHeader: Record "E3 HIS Revenue Header";
        RevPostMgmt: Codeunit "E3 Revenue Post Mgmt.";
}