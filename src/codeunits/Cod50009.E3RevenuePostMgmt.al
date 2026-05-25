codeunit 50009 "E3 Revenue Post Mgmt."
{
    TableNo = "E3 HIS Revenue Header";

    trigger OnRun()
    begin
        xRevHeader.Copy(Rec);
        PostLine(xRevHeader);
        Rec := xRevHeader;
    end;

    local procedure PostLine(var RevHeader: Record "E3 HIS Revenue Header")
    begin
        Clear(IntegrationMgmt);
        IntegrationMgmt.CreateAndPostRevenueInvoice(RevHeader);
    end;

    var
        xRevHeader: Record "E3 HIS Revenue Header";
        IntegrationMgmt: Codeunit "E3 HIS Integration Mgmt.";
}
