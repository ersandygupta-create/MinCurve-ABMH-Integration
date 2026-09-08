pageextension 50220 "E3 Item Ledger Entries Ext" extends "Item Ledger Entries"
{
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId());

        if not UserSetup."Item Ledger View" then
            Error('You do not have permission to view Item Ledger Entries.');
    end;
}