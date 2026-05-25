codeunit 50006 "E3 Consumption Sheduler"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin

        HISPharmacyPost.InitGenJnlLineConsumptionEntry();
        IntegrationMgmt.PostGenJnlLineConsumptionEntries();
    end;

    var
        IntegrationMgmt: Codeunit "E3 HIS Integration Mgmt.";
        HISPharmacyPost: Codeunit "E3 HIS Integration Mgmt.";
}
