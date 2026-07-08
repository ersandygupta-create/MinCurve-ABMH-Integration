tableextension 50065 "E3 Location" extends Location
{
    fields
    {
        field(50000; "Invoice Bank"; Code[20])
        {
            Caption = 'Invoice Bank';
            TableRelation = "Bank Account";
            DataClassification = CustomerContent;
        }
        field(50001; "E3 Indent PO Series"; Code[20])
        {
            Caption = 'Indent PO Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

    }
}