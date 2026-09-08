pageextension 50091 "E3 Sales Order List Ext" extends "Sales Order List"
{
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId());

        if not UserSetup."Sales Order" then
            Error('You do not have permission to open Sales Order.');
    end;
}