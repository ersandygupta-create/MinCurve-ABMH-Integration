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
    }
    trigger OnBeforeRename()
    begin
        if (Rec."No." <> xRec."No.") and (xRec."No." <> '') then
            Error('You cannot modify the FA No.');
    end;

}
