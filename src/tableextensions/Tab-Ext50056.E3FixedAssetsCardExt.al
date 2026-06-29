tableextension 50056 "E3 HIS Fixed Asset" extends "Fixed Asset"
{
    fields
    {
        field(50000; "Model No."; Text[50])
        {
            Caption = 'Model No.';
            DataClassification = CustomerContent;
        }
        field(50001; "QR Code"; Media)
        {
            Caption = 'QR Code';
        }
        field(50002; "Old Asset Code"; Text[60])
        {
            Caption = 'Old Asset Code';
        }
        field(50003; "Sub Asset Group Name"; code[50])
        {
            TableRelation = E3SubAssetGroupName.Code;
            Caption = 'Sub Asset Group Name';
        }
        field(50004; "Nature Of Asset"; Enum E3NatureOfAsset)
        {
            Caption = 'Nature of Asset';
        }
        field(50005; Qty; Decimal)
        {
            Caption = 'Quantity';
        }
        field(50006; Remark; Text[200])
        {
            Caption = 'Remark';
        }
    }
    trigger OnBeforeRename()
    begin
        if (Rec."No." <> xRec."No.") and (xRec."No." <> '') then
            Error('You cannot modify the FA No.');
    end;

}
