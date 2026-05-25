tableextension 50020 "E3 HIS Purch. Cr. Memo Line" extends "Purch. Cr. Memo Line"
{
    fields
    {

        field(50000; "E3 Item Type"; Enum "E3 HIS Item Type")
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
        }
        field(50002; "E3 HIS Type"; Enum "E3 HIS Type")
        {
            Caption = 'HIS Type';
            DataClassification = CustomerContent;
        }

    }
}

