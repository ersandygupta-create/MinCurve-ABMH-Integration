page 50110 "E3 Refund Batch API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'e3RefundsBatchAPI';
    DelayedInsert = true;
    EntityName = 'refundsBatch';
    EntitySetName = 'refundsBatch';
    SourceTable = "E3 HIS Revenue Staging Table";
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
            part(RevenueLine; "E3 Refund API")
            {
                Caption = 'Refunds';
                EntityName = 'refund';
                EntitySetName = 'refunds';
            }
        }
    }

    var
        BatchNo: Text[100];
}
