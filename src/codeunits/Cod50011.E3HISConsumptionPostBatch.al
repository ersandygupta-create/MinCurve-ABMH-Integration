codeunit 50011 "E3 HIS Consumption Post Batch"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        HISIntegrationSetup.Get();
        HISIntegrationSetup.TESTFIELD("Integration Enabled", TRUE);
        HISIntegrationSetup.TESTFIELD("Consumption Creation Enabled", TRUE);

        IF NOT (HISIntegrationSetup."Integration Enabled") AND (HISIntegrationSetup."Consumption Creation Enabled") THEN
            Error(IntegrationErr);

        ProcessData();
    end;

    local procedure ProcessData()
    begin
        xConsumptionEntry.Reset();
        xConsumptionEntry.SetRange("General Entries Created", false);
        if xConsumptionEntry.FindSet() then
            repeat
                ConsumptionEntry := xConsumptionEntry;
                Clear(PostConsumptionLine);
                if PostConsumptionLine.Run(ConsumptionEntry) then;
            until xConsumptionEntry.Next() = 0;
    end;

    var
        HISIntegrationSetup: Record "E3 HIS Integartion Setup";
        xConsumptionEntry: Record "E3 HIS Consumption Entries";
        ConsumptionEntry: Record "E3 HIS Consumption Entries";
        PostConsumptionLine: Codeunit "E3 Post Consumption Line";
        IntegrationErr: Label 'Integration not enabled for consuption creation.';
}
