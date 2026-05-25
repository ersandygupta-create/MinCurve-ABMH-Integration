codeunit 50007 "E3 Rev/Adv/Coll Sheduler"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        IntegrationMgmt.InitGenJnlLineRevenueStaging();
        IntegrationMgmt.PostGenJnlLineEntries();
    end;

    var
        IntegrationMgmt: Codeunit "E3 HIS Integration Mgmt.";
}
