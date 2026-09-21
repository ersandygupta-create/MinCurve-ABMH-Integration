tableextension 50018 "E3 HIS Purch. Inv. Line" extends "Purch. Inv. Line"
{
    fields
    {

        field(50000; "E3 HIS Item Type"; Enum "E3 HIS Item Type")
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
        }
        field(50003; "Pack Size"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pack Size';
        }
        field(50004; "E3 HIS Type"; Enum "E3 HIS Type")
        {
            Caption = 'HIS Type';
            DataClassification = CustomerContent;
        }
        field(50005; "AMC Start Date"; Date)
        {
            Caption = 'AMC/CMC Start Date';
            DataClassification = CustomerContent;
        }
        field(50006; "AMC End Date"; Date)
        {
            Caption = 'AMC/CMC End Date';
            DataClassification = CustomerContent;
        }

    }
}
