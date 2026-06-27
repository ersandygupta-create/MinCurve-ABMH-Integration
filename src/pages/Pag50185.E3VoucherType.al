page 50185 "E3 Voucher Types"
{
    ApplicationArea = BasicEU, BasicNO;
    Caption = 'Voucher Types';
    PageType = List;
    SourceTable = "E3 Voucher Type";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = BasicEU, BasicNO;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = BasicEU, BasicNO;
                }
            }
        }
    }
}