codeunit 50018 "E3 GRN/Return Scheduler"
{
    TableNo = "E3 HIS Purchase Header";

    trigger OnRun()
    begin
        PurHeader.Copy(Rec);
        ProcessData(PurHeader);
        Rec := PurHeader;
    end;

    local procedure ProcessData(var PurHeaderStaging: Record "E3 HIS Purchase Header");
    begin

        Clear(IntegrationMgmt);
        IntegrationMgmt.InitPurchaseOrder(PurHeader."Record Type", PurHeader."Document Type", PurHeader."Document No.")
    end;

    var
        PurHeader: Record "E3 HIS Purchase Header";
        IntegrationMgmt: Codeunit "E3 HIS Integration Mgmt.";
        HISIntegrationSetup: Record "E3 HIS Integartion Setup";
}
