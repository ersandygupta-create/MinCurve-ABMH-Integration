codeunit 50019 "E3 GRN/GRN Return Create"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        ProcessData();
    end;

    local procedure ProcessData()
    begin
        xGRNHeader.Reset();
        xGRNHeader.SetRange("Create PO", false);
        if xGRNHeader.FindSet() then
            repeat
                GRNHeader := xGRNHeader;
                if ProcessGRNReturn.Run(GRNHeader) then;
            until xGRNHeader.Next() = 0;
    end;

    var
        xGRNHeader: Record "E3 HIS Purchase Header";
        GRNHeader: Record "E3 HIS Purchase Header";
        ProcessGRNReturn: Codeunit "E3 GRN/Return Scheduler";
}
