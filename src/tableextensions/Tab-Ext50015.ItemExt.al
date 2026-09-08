tableextension 50015 "E3 HIS Item" extends Item
{
    fields
    {
        field(50000; "E3 HIS Type"; Enum "E3 HIS Type")
        {
            Caption = 'HIS Type';
            DataClassification = CustomerContent;
        }
        field(50001; "E3 Item Type"; Enum "E3 HIS Item Type")
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
        }
    }
    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId()) then
            Error('User Setup is not configured for user %1.', UserId());

        if not UserSetup."Item Insert" then
            Error(
                'You do not have permission to create a new Item. ' +
                'Please contact your administrator.');

    end;

    trigger OnBeforeModify()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId()) then
            Error('User Setup is not configured for user %1.', UserId());

        if not UserSetup."Item Modify" then
            Error(
                'You do not have permission to modify Item %1. ' +
                'Please contact your administrator.',
                Rec."No.");
    end;




    trigger OnBeforeDelete()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId()) then
            Error('User Setup is not configured for user %1.', UserId());

        if not UserSetup."Item Delete" then
            Error(
                'You do not have permission to delete Item %1. ' +
                'Please contact your administrator.',
                Rec."No.");
    end;
}
