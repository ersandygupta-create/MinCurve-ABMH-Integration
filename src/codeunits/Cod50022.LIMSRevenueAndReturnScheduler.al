codeunit 50022 "LIMS Rev/Rev. Cancel Scheduler"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        HISIntegrationSetup.Get();
        ProcessData();
    end;

    local procedure ProcessData()
    begin
        xRevHeader.Reset();
        xRevHeader.SetRange("Create Revenue", false);
        if xRevHeader.FindSet() then
            repeat
                RevHeader := xRevHeader;
                if HISIntegrationSetup."Rev./Rev.Cancel Direct Post" then begin
                    Clear(RevPostMgmt);
                    if RevPostMgmt.Run(RevHeader) then;
                end else begin
                    Clear(IntegrationMgmt);
                    IntegrationMgmt.InitRevenueInvoice(RevHeader."Record Type", RevHeader."Document Type", RevHeader."Document No.");
                end;
            until xRevHeader.Next() = 0;
    end;

    var
        HISIntegrationSetup: Record "E3 HIS Integartion Setup";
        xRevHeader: Record "E3 LIMS Revenue Header";
        RevHeader: Record "E3 LIMS Revenue Header";
        IntegrationMgmt: Codeunit "E3 LIMS Integration Mgmt.";
        RevPostMgmt: Codeunit "LIMS Revenue Post Mgmt.";
}
