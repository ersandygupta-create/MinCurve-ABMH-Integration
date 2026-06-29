tableextension 50017 "E3 HIS Purch. Recpt. Line" extends "Purch. Rcpt. Line"
{
    fields
    {

        field(50000; "E3 Item Type"; Enum "E3 HIS Item Type")
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
        }
        field(50001; "Pack Size"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pack Size';
        }
        field(50003; "Indent No."; Code[20])
        {
            Caption = 'Indent No.';
            DataClassification = CustomerContent;
        }
        field(50004; "Indent Line No."; Integer)
        {
            Caption = 'Indent Line No.';
            DataClassification = CustomerContent;
        }
    }
}
