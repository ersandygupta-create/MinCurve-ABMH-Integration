tableextension 50026 "E3 HIS Company Information" extends "Company Information"
{
    fields
    {
        field(50000; "CIN No."; Code[50])
        {
            Caption = 'CIN No.';
            DataClassification = CustomerContent;
        }
        field(50001; "Old Comapany Name"; Code[100])
        {
            Caption = 'Old Company Name';
            DataClassification = CustomerContent;
        }
        field(50002; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
            DataClassification = CustomerContent;
        }
        field(50003; DraftImage; Blob)
        {
            Caption = 'Draft Image';
            DataClassification = CustomerContent;
            Subtype = Bitmap;
        }
    }
}
