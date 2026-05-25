codeunit 50021 "LIMS Revenue Post Mgmt."
{
    TableNo = "E3 LIMS Revenue Header";

    trigger OnRun()
    begin
        xRevHeader.Copy(Rec);
        PostLine(xRevHeader);
        Rec := xRevHeader;
    end;

    local procedure PostLine(var RevHeader: Record "E3 LIMS Revenue Header")
    begin
        Clear(LIMSIntegrationMgmt);
        LIMSIntegrationMgmt.CreateAndPostRevenueInvoice(RevHeader);
    end;

    var
        xRevHeader: Record "E3 LIMS Revenue Header";
        LIMSIntegrationMgmt: Codeunit "E3 LIMS Integration Mgmt.";
}
