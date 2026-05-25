tableextension 50013 "E3 HIS Purch. Credit Memo" extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50000; "E3 Capex Type"; Enum "E3 Capex Type")
        {
            Caption = 'Capex Type';
            DataClassification = CustomerContent;
        }
        field(50001; "E3 Work Order Type"; Enum "E3 Work Order Type")
        {
            Caption = 'Work Order Type';
            DataClassification = CustomerContent;
        }
        field(50002; "E3 Item Type"; Enum "E3 HIS Item Type")
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
        }

        field(50003; "E3 HIS Type"; Enum "E3 HIS Type")
        {
            Caption = 'HIS Type';
            DataClassification = CustomerContent;
        }
        field(50004; "Store Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Store Name';
        }
    }
}
