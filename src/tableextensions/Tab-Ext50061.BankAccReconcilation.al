tableextension 50061 "3E Bank Acc. Reconciliation" extends "Bank Acc. Reconciliation"
{
    fields
    {
        // Add changes to table fields here
    }
    [IntegrationEvent(false, false)]
    local procedure E3OnBeforeMatchSingle(var BankAccReconciliation: Record "Bank Acc. Reconciliation"; DateRange: Integer; var IsHandled: Boolean)
    begin
    end;

    procedure E3MatchSingle(DateRange: Integer)
    var
        MatchBankRecLines: Codeunit "3E Match Bank Rec. Lines";
        IsHandled: Boolean;

    begin
        IsHandled := false;
        E3OnBeforeMatchSingle(Rec, DateRange, IsHandled);
        if IsHandled then
            exit;

        MatchBankRecLines.BankAccReconciliationAutoMatch(Rec, DateRange);
    end;

    procedure E3GetBankReconciliationTelemetryFeatureName(): Text
    var
        BankReconciliationFeatureNameTelemetryTxt: Label 'Bank reconciliation', Locked = true;
    begin
        exit(BankReconciliationFeatureNameTelemetryTxt);
    end;

}