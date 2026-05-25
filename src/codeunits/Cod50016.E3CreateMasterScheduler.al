codeunit 50016 "E3 Create Master Scheduler"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        case Rec."Parameter String" of
            'Vendor', 'VENDOR', 'vendor':
                ProcessVendorData();
            'Customer', 'CUSTOMER', 'customer':
                ProcessCustomerData();
            'Item', 'ITEM', 'item':
                ProcessItemData();
            'Employee', 'EMPLOYEE', 'employee':
                ProcessEmployeeData();
            else
                ProcessData();
        end;
    end;

    local procedure ProcessData()
    begin
        xMasterStaging.Reset();
        xMasterStaging.SetRange(IsCreated, false);
        if xMasterStaging.FindSet() then
            repeat
                MasterStaging := xMasterStaging;
                if ProcessMasterRecord.Run(MasterStaging) then;
            until xMasterStaging.Next() = 0;
    end;

    local procedure ProcessVendorData()
    begin
        xMasterStaging.Reset();
        xMasterStaging.SetRange("Party Type", xMasterStaging."Party Type"::Vendor);
        xMasterStaging.SetRange(IsCreated, false);
        if xMasterStaging.FindSet() then
            repeat
                MasterStaging := xMasterStaging;
                if ProcessMasterRecord.Run(MasterStaging) then;
            until xMasterStaging.Next() = 0;
    end;

    local procedure ProcessCustomerData()
    begin
        xMasterStaging.Reset();
        xMasterStaging.SetRange("Party Type", xMasterStaging."Party Type"::Customer);
        xMasterStaging.SetRange(IsCreated, false);
        if xMasterStaging.FindSet() then
            repeat
                MasterStaging := xMasterStaging;
                if ProcessMasterRecord.Run(MasterStaging) then;
            until xMasterStaging.Next() = 0;
    end;

    local procedure ProcessItemData()
    begin
        xMasterStaging.Reset();
        xMasterStaging.SetRange("Party Type", xMasterStaging."Party Type"::Item);
        xMasterStaging.SetRange(IsCreated, false);
        if xMasterStaging.FindSet() then
            repeat
                MasterStaging := xMasterStaging;
                if ProcessMasterRecord.Run(MasterStaging) then;
            until xMasterStaging.Next() = 0;
    end;

    local procedure ProcessEmployeeData()
    begin
        xMasterStaging.Reset();
        xMasterStaging.SetRange("Party Type", xMasterStaging."Party Type"::Employee);
        xMasterStaging.SetRange(IsCreated, false);
        if xMasterStaging.FindSet() then
            repeat
                MasterStaging := xMasterStaging;
                if ProcessMasterRecord.Run(MasterStaging) then;
            until xMasterStaging.Next() = 0;
    end;

    var
        xMasterStaging: Record "E3 HIS Master Staging";
        MasterStaging: Record "E3 HIS Master Staging";
        ProcessMasterRecord: Codeunit "E3 Process Masters";
}
