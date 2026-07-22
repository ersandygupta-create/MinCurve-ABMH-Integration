tableextension 50007 "E3 HIS Purch. Inv. Header" extends "Purch. Inv. Header"
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
        field(50004; "E3 Delivery Terms"; Text[150])
        {
            Caption = 'Delivery Terms';
            DataClassification = CustomerContent;
        }
        field(50005; "Store Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Store Name';
        }
        field(50010; "Payment Terms"; Text[100])
        {
            Caption = 'Payment Terms';
            DataClassification = CustomerContent;
        }

    }
}
