page 50107 "E3 Consumption Batch API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'e3ConsumptionBatchAPI';
    DelayedInsert = true;
    EntityName = 'e3ConsumptionBatch';
    EntitySetName = 'e3ConsumptionBatch';
    SourceTable = "E3 HIS Consumption Entries";
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
            part(RevenueLine; "E3 Consumption API")
            {
                Caption = 'Consumptions';
                EntityName = 'consumption';
                EntitySetName = 'consumptions';
            }
        }
    }

    var
        BatchNo: Text[100];
}
