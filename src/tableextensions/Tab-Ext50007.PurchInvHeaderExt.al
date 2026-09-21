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
        field(60006; "Indent Type"; enum "E3 Capex Type")
        {
            Caption = 'Indent Type';
            DataClassification = ToBeClassified;
        }
        field(60007; "AMC/CMC"; Enum "E3 AMC CMC")
        {
            Caption = 'AMC/CMC';
            DataClassification = ToBeClassified;
        }


        field(60008; "Project Code"; Code[20])
        {
            Caption = 'Project Code';
            DataClassification = ToBeClassified;
            TableRelation = "E3 Project Master"."Project Code";
        }

    }
}
