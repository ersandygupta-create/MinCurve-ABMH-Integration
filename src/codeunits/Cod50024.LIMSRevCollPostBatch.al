codeunit 50024 "LIMS Rev/Coll Post Batch"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        HISIntegrationSetup.Get();
        HISIntegrationSetup.TESTFIELD("Integration Enabled", TRUE);
        HISIntegrationSetup.TESTFIELD("Revenue Creation Enabled", TRUE);

        IF NOT (HISIntegrationSetup."Integration Enabled") AND (HISIntegrationSetup."Revenue Creation Enabled") THEN
            Error(IntegrationErr);
        //CollectionValidation();

        ProcessData();
    end;

    local procedure ProcessData()
    begin
        xRevenueEntry.Reset();
        xRevenueEntry.SetRange("General Entries Created", false);
        if xRevenueEntry.FindSet() then
            repeat
                RevenueEntry := xRevenueEntry;
                Clear(PostRevenueLine);
                if PostRevenueLine.Run(RevenueEntry) then;
            until xRevenueEntry.Next() = 0;
    end;

    var
        HISIntegrationSetup: Record "E3 HIS Integartion Setup";
        xRevenueEntry: Record "E3 HIS Collection Staging";
        RevenueEntry: Record "E3 HIS Collection Staging";
        PostRevenueLine: Codeunit "LIMS Post Rev/Coll Line";
        IntegrationErr: Label 'Integration not enabled for revenue creation.';
}
