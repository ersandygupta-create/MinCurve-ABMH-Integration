codeunit 50031 "E3 Post Gate Entry"
{
    TableNo = "E3 Gate Entry Header";

    trigger OnRun()
    begin
        GateEntryHeader := Rec;
        with GateEntryHeader DO BEGIN
            TESTFIELD("Posting Date");
            TESTFIELD("Document No.");

            GateEntryLine.Reset();
            GateEntryLine.SETRANGE("Document No.", "Document No.");
            IF NOT GateEntryLine.FIND('-') THEN
                ERROR(Text16500);

            IF GateEntryLine.FindSet() THEN
                REPEAT
                UNTIL GateEntryLine.Next() = 0;

            IF GUIALLOWED THEN
                Window.OPEN(
                  '#1###########################\\' +
                  Text16501);
            IF GUIALLOWED THEN
                Window.UPDATE(1, STRSUBSTNO('%1 %2', Text16502, "Document No."));


            IF ModifyHeader THEN BEGIN
                MODIFY();
                COMMIT();
            END;

            GateEntryLine.LOCKTABLE();
            PurchPayble.Get();
            PostedGateEntryHeader.INIT();
            PostedGateEntryHeader.TRANSFERFIELDS(GateEntryHeader);
            PostedGateEntryHeader.PostedNo := NoSeries.GetNextNo(PurchPayble."Gate Entry Receipt Series", WorkDate(), true);

            IF GUIALLOWED THEN
                Window.UPDATE(1, STRSUBSTNO(Text16503, "Document No.", PostedGateEntryHeader."Document No."));
            PostedGateEntryHeader.INSERT();
            PostedGateEntryBuffer.Reset();
            PostedGateEntryBuffer.SetCurrentKey("Posted Entry No.");
            if PostedGateEntryBuffer.FindLast() then
                LastEntryno := PostedGateEntryBuffer."Posted Entry No." + 1
            else
                LastEntryno := 1;
            GateEntryLine.RESET();
            GateEntryLine.SETRANGE("Document No.", "Document No.");
            LineCount := 0;
            IF GateEntryLine.FINDSET THEN
                REPEAT

                    LineCount += 1;
                    IF GUIALLOWED THEN
                        Window.UPDATE(2, LineCount);
                    PostedGateEntryLine.INIT();
                    PostedGateEntryLine."Item No." := GateEntryLine."Item No.";
                    PostedGateEntryLine."Item Name" := GateEntryLine."Item Name";
                    PostedGateEntryLine."Line No." := GateEntryLine."Line No.";
                    PostedGateEntryLine."Variant Code" := GateEntryLine."Variant Code";
                    PostedGateEntryLine."Unit of Measurement" := GateEntryLine."Unit of Measurement";
                    PostedGateEntryLine.Quantity := GateEntryLine.Quantity;
                    PostedGateEntryLine."Quantity Received" := GateEntryLine."Qty to Receive";
                    PostedGateEntryLine."Document No." := PostedGateEntryHeader."Document No.";
                    PostedGateEntryLine."Estimated Value" := GateEntryLine."Estimated Value";
                    PostedGateEntryLine."Asset No." := GateEntryLine."Asset No.";
                    PostedGateEntryLine."Fixed Asset Name" := GateEntryLine."Fixed Asset Name";
                    PostedGateEntryLine."Serial No." := GateEntryLine."Serial No.";
                    PostedGateEntryLine."Lot No." := GateEntryLine."Lot No.";
                    PostedGateEntryLine.Remarks := GateEntryLine.Remarks;
                    PostedGateEntryLine.PostedNo := PostedGateEntryHeader.PostedNo;
                    PostedGateEntryLine."Posted Entry No." := LastEntryno;
                    PostedGateEntryLine."Estimated Value Receive" := GateEntryLine."Estimated Value Receive";
                    PostedGateEntryLine.INSERT();
                    LastEntryno += 1;

                    GateEntryLineUpd := GateEntryLine;
                    GateEntryLineUpd."Quantity Received" := GateEntryLineUpd."Quantity Received" + GateEntryLineUpd."Qty to Receive";
                    GateEntryLineUpd."Qty to Receive" := GateEntryLineUpd.Quantity - GateEntryLineUpd."Quantity Received";
                    GateEntryLineUpd."Estimated Value Receive" := GateEntryLineUpd."Qty to Receive" * GateEntryLineUpd."Cost/Qty";
                    GateEntryLineUpd.Modify(true);
                UNTIL GateEntryLine.NEXT() = 0;

            if not CheckDocDeleteionStatus(GateEntryHeader) then begin
                DELETE();
                GateEntryLine.DELETEALL();
            end;

        END;
        IF GUIALLOWED THEN
            Window.CLOSE;
        Rec := GateEntryHeader;
    end;

    local procedure CheckDocDeleteionStatus(var GateEntryHeader: Record "E3 Gate Entry Header"): Boolean
    var
        GateEntryLine: Record "E3 Gate Entry Line";
    begin
        GateEntryLine.Reset();
        GateEntryLine.SetRange("Document No.", GateEntryHeader."Document No.");
        if GateEntryLine.FindSet() then
            repeat
                if GateEntryLine.Quantity <> GateEntryLine."Quantity Received" then
                    exit(true);
            until GateEntryLine.Next() = 0;
        exit(false);
    end;

    var
        GateEntryHeader: Record "E3 Gate Entry Header";
        GateEntryLine: Record "E3 Gate Entry Line";
        PurchPayble: Record "Purchases & Payables Setup";
        GateEntryLineUpd: Record "E3 Gate Entry Line";
        PostedGateEntryHeader: Record "E3 Posted Gate Entry Header";
        PostedGateEntryLine: Record "E3 Posted Gate Entry Line";
        NoSeries: Codeunit "No. Series";
        Text16500: Label 'There is nothing to post.';
        Text16501: Label 'Posting Lines #2######\';
        Text16502: Label 'Gate Entry.';
        Text16503: Label 'Gate Entry %1 -> Posted Gate Entry %2.';
        NoSeriesMgt: Codeunit "No. Series";
        Window: Dialog;
        ModifyHeader: Boolean;
        LineCount: Integer;
        PostedGateEntryBuffer: Record "E3 Posted Gate Entry Line";
        LastEntryno: Integer;
        PurchPaybleSetup: Record "Purchases & Payables Setup";


}