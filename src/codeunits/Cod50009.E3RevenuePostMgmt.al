codeunit 50009 "E3 Revenue Post Mgmt."
{
    TableNo = "E3 HIS Revenue Header";

    trigger OnRun()
    begin
        ProcessRevenue(Rec);
    end;

    local procedure ProcessRevenue(var RevHeader: Record "E3 HIS Revenue Header")
    var
        IntegrationMgmt: Codeunit "E3 HIS Integration Mgmt.";
    begin
        Clear(IntegrationMgmt);

        IntegrationMgmt.InitRevenueInvoice(
            RevHeader."Record Type",
            RevHeader."Document Type",
            RevHeader."Document No.");
    end;
}