tableextension 50063 "E3 Bank Acc. Stat. Line Ext" extends "Bank Account Statement Line"
{
    fields
    {
        field(50000; "E3 UTR No."; Code[35])
        {
            Caption = 'UTR No.';
            DataClassification = CustomerContent;
        }
    }
}