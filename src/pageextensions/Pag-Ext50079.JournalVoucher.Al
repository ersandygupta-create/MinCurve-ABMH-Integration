pageextension 50079 "JV Worksheet Ext" extends "Journal Voucher" // Page 18557
{
    layout
    {
        modify("Account No.")
        {
            trigger OnAfterValidate()
            var
                GlAccMapping: record "E3 HIS GL Accounts Mapping";
            begin
                // if Rec."Account Type" = Rec."Account Type"::"G/L Account" then begin
                //     Glaccmapping.Reset();
                //     glaccmapping.SetRange(Type, GlAccMapping.Type::Revenue);
                //     glaccmapping.SetRange("Account No.", Rec."Account No.");
                //     if Glaccmapping.Find('-') then
                //      //   Error('Direct Posting is not allowed in Selected G/L Account is blocked.');
                // end;
            end;
        }
    }
}