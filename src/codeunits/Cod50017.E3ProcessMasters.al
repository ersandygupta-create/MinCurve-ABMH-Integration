codeunit 50017 "E3 Process Masters"
{
    TableNo = "E3 HIS Master Staging";

    trigger OnRun()
    begin
        Case Rec."Party Type" of
            Rec."Party Type"::Vendor:
                ProcessVendor(Rec);
            Rec."Party Type"::Customer:
                ProcessCustomer(Rec);
            Rec."Party Type"::Item:
                ProcessItem(Rec);
            Rec."Party Type"::Employee:
                ProcessEmployee(Rec);
        End;
    end;

    local procedure ProcessVendor(var HISMasterStaging: Record "E3 HIS Master Staging")
    var
        HISIntegrationMgmt: Codeunit "E3 HIS Integration Mgmt.";
    begin
        Clear(HISIntegrationMgmt);
        HISIntegrationMgmt.InitVendorMaster(HISMasterStaging."Entry No.");
    end;

    local procedure ProcessCustomer(var HISMasterStaging: Record "E3 HIS Master Staging")
    var
        HISIntegrationMgmt: Codeunit "E3 HIS Integration Mgmt.";
    begin
        Clear(HISIntegrationMgmt);
        HISIntegrationMgmt.InitCustomerMaster(HISMasterStaging."Entry No.");
    end;

    local procedure ProcessItem(var HISMasterStaging: Record "E3 HIS Master Staging")
    var
        HISIntegrationMgmt: Codeunit "E3 HIS Integration Mgmt.";
    begin
        Clear(HISIntegrationMgmt);
        HISIntegrationMgmt.InitItemMaster(HISMasterStaging."Entry No.");
    end;

    local procedure ProcessEmployee(var HISMasterStaging: Record "E3 HIS Master Staging")
    var
        HISIntegrationMgmt: Codeunit "E3 HIS Integration Mgmt.";
    begin
        Clear(HISIntegrationMgmt);
        HISIntegrationMgmt.InitEmployeeMaster(HISMasterStaging."Entry No.");
    end;
}
