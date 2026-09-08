pageextension 50088 "E3 Purchase Invoice Permission" extends "Purchase Invoices"
{
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId());

        if not UserSetup."Purchase Invoice" then
            Error('You do not have permission to open Purchase Invoice.');
    end;
}