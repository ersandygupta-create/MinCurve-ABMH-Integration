tableextension 50067 "E3 Purchase & Payable Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Bank File Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank File Series';
            TableRelation = "No. Series";
        }
        field(50001; "HIS GRN Amount Validation"; Boolean)
        {
            Caption = 'HIS GRN AMount Validation';
            DataClassification = CustomerContent;
        }
        field(50002; "GRN Vendor Code Check"; Boolean)
        {
            Caption = 'GRN Vendor Code Check';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}