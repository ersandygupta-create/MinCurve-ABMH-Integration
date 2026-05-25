page 50108 "E3 Advances Batch API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'e3AdvancesBatchAPI';
    DelayedInsert = true;
    EntityName = 'e3advanceBatch';
    EntitySetName = 'advanceBatch';
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
            part(RevenueLine; "E3 Advances API")
            {
                Caption = 'Advances';
                EntityName = 'advance';
                EntitySetName = 'advances';
            }
        }
    }

    var
        BatchNo: Text[100];
}
