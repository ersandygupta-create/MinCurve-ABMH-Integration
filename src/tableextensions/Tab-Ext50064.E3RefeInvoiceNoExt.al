tableextension 50064 "E3 Reference Invoice No." extends "Reference Invoice No."
{
    fields
    {
        field(50000; "Alternate Ref. Invoice No."; Text[20])
        {
            Caption = 'Alternate Ref. Invoice No.';
            DataClassification = CustomerContent;
        }
        field(50001; Skip; Boolean)
        {
            Caption = 'Skip';
            DataClassification = CustomerContent;
        }
    }
}