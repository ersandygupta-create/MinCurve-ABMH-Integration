tableextension 50066 "E3 Item Master" extends Item
{

    trigger OnBeforeRename()
    begin
        if (Rec."No." <> xRec."No.") and (xRec."No." <> '') then
            Error('You cannot modify the Item No.');
    end;

}