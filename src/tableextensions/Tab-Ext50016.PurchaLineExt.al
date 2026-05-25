tableextension 50016 "E3 HIS Purcha Line" extends "Purchase Line"
{
    fields
    {
        field(50000; "E3 Item Type"; Enum "E3 HIS Item Type")
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
                PurchHeader: Record "Purchase Header";
            begin
                IF Rec.Type = Rec.Type::Item then begin
                    Item.Get("No.");
                    Validate("E3 Item Type", Item."E3 Item Type");
                    IF PurchHeader.Get("Document Type", "Document No.") then
                        if PurchHeader."E3 Item Type" = PurchHeader."E3 Item Type"::"Non Pharmacy" then
                            IF PurchHeader."E3 Item Type" <> Item."E3 Item Type" then
                                Error('You can''t select other than Non Pharmacy Item %1 !', Item."No.");
                end;
            end;
        }


    }

}
