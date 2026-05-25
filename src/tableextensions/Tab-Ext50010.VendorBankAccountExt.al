tableextension 50010 "E3 HIS Vendor Bank Account" extends "Vendor Bank Account"
{
    fields
    {
        field(50000; "E3 IFSC Code"; Code[20])
        {
            Caption = 'IFSC Code';
            DataClassification = CustomerContent;
        }
    }
}
