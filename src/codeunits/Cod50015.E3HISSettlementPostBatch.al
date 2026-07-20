codeunit 50015 "E3 HIS Settlement Post Batch"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        HISIntegrationSetup.Get();
        HISIntegrationSetup.TESTFIELD("Integration Enabled", TRUE);
        HISIntegrationSetup.TESTFIELD("Revenue Creation Enabled", TRUE);

        IF NOT (HISIntegrationSetup."Integration Enabled") AND (HISIntegrationSetup."Revenue Creation Enabled") THEN
            Error(IntegrationErr);

        ProcessData();
    end;

    local procedure ProcessData()
    begin
        xSettlementEntry.Reset();
        xSettlementEntry.SetRange("General Entries Created", false);
        if xSettlementEntry.FindSet() then
            repeat
                SettlementEntry := xSettlementEntry;

                // sandeep
                SettlementSetup.Reset();
                SettlementSetup.SetRange(SettlementType, SettlementEntry."HIS Document Type");
                SettlementSetup.SetRange(PostApplication, true);
                if not SettlementSetup.Find('-') then begin
                    Clear(PostSettlementLine);
                    if PostSettlementLine.Run(SettlementEntry) then;
                end;
            until xSettlementEntry.Next() = 0;
    end;

    var
        HISIntegrationSetup: Record "E3 HIS Integartion Setup";
        xSettlementEntry: Record "E3 HIS Settlement Staging";
        SettlementEntry: Record "E3 HIS Settlement Staging";
        SettlementSetup: Record E3SettlementType;
        PostSettlementLine: Codeunit "E3 Post Settlement Line";
        IntegrationErr: Label 'Integration not enabled for Settlement creation.';

}
