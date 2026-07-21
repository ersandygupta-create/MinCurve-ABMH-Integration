tableextension 50010 "E3 HIS Vendor Bank Account" extends "Vendor Bank Account"
{
    fields
    {
        field(50000; "E3 IFSC Code"; Code[20])
        {
            Caption = 'IFSC Code';
            DataClassification = CustomerContent;
        }
        field(50001; "Branch Name"; Text[50])
        {
            Caption = 'Branch Name';
            DataClassification = CustomerContent;
        }
    }
}
