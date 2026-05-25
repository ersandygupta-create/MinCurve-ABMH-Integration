tableextension 50011 "E3 HIS Customer Bank Account" extends "Customer Bank Account"
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
