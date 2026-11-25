codeunit 50009 "E3 Revenue Post Mgmt."
{
    TableNo = "E3 HIS Revenue Header";

    trigger OnRun()
    var
        IntegrationMgmt: Codeunit "E3 HIS Integration Mgmt.";
    begin
        if Rec."Create Revenue" then
            exit;

        if Rec."Record Type" <> Rec."Record Type"::Revenue then
            exit;

        if Rec."Document Type" <> Rec."Document Type"::Invoice then
            exit;

        IntegrationMgmt.InitRevenueInvoice(
            Rec."Record Type",
            Rec."Document Type",
            Rec."Document No.");
    end;
}