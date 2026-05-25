tableextension 50019 "E3 HIS Retrun Shipment Line" extends "Return Shipment Line"
{
    fields
    {

        field(50000; "E3 Item Type"; Enum "E3 HIS Item Type")
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
        }
    }
}
