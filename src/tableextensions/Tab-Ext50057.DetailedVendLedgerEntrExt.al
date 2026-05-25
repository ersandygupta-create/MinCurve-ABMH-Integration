tableextension 50057 DetailedVendLedgerEntrExt extends "Detailed Vendor Ledg. Entry"
{
    fields
    {
        field(50003; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            DataClassification = ToBeClassified;
        }
    }
}
