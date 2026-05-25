page 50113 "E3 Adv Against PO Batch API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'e3AdvAgPOBatchAPI';
    DelayedInsert = true;
    EntityName = 'e3advAgPOBatch';
    EntitySetName = 'advAgPOBatch';
    SourceTable = "Vendor Adv. Pay. Ag. PO";
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
            part(VendorAdvPo; "E3 Advance PO API")
            {
                Caption = 'AdvancePo';
                EntityName = 'advancePo';
                EntitySetName = 'advancePos';
            }
        }
    }

    var
        BatchNo: Text[100];
}
