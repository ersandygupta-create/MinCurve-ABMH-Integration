page 50109 "E3 Settlements Batch API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'e3SettlementsBatchAPI';
    DelayedInsert = true;
    EntityName = 'settlementsBatch';
    EntitySetName = 'settlementsBatch';
    SourceTable = "E3 HIS Settlement Staging";
    SourceTableTemporary = true;
    PageType = API;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(batchNo; BatchNo)
                {
                    Caption = 'Batch No.';

                    trigger OnValidate()
                    begin
                        Rec.Init();
                        Rec.Insert();
                    end;
                }
            }
            part(RevenueLine; "E3 Settlement API")
            {
                Caption = 'Settlements';
                EntityName = 'settlement';
                EntitySetName = 'settlements';
            }
        }
    }

    var
        BatchNo: Text[100];
}
