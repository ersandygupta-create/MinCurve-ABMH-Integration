codeunit 50030 "E3 Gate Entry Mgmt."
{
    TableNo = "E3 Gate Entry Header";

    trigger OnRun()
    begin
        GateEntryHeader.Copy(Rec);
        Code();
        Rec := GateEntryHeader;
    end;

    var
        Text16500: Label 'Do you want to Post the Gate Entry?';
        Text16501: Label 'Gate Entry Posted successfully.';
        Text16502: Label 'Received Qty must be greater than 0 for at least one line.';

        GateEntryHeader: Record "E3 Gate Entry Header";
        GateEntryLine: Record "E3 Gate Entry Line";
        GateEntryPost: Codeunit 50031;

    local procedure Code()
    begin
        if not Confirm(Text16500, false) then
            exit;

        // Validate Qty to Receive
        GateEntryLine.Reset();
        GateEntryLine.SetRange("Document No.", GateEntryHeader."Document No.");
        GateEntryLine.SetFilter("Qty to Receive", '>%1', 0);

        if not GateEntryLine.FindFirst() then
            Error(Text16502);

        GateEntryPost.Run(GateEntryHeader);

        Commit();

        Message(Text16501);
    end;
}