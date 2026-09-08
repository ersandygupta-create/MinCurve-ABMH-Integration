pageextension 50092 "E3 Sales Invoice List Ext" extends "Sales Invoice List"
{
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId());

        if not UserSetup."Sales Invoice" then
            Error('You do not have permission to open Sales Invoice.');
    end;
}