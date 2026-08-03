permissionset 50001 "E3 Indent Permission"
{
    Assignable = true;
    Caption = 'HIS Permission Sets', MaxLength = 30;
    Permissions = table "E3 Indent Header" = X,
    tabledata "E3 Indent Header" = RIMD,
    table "E3 Indent Line" = X,
    tabledata "E3 Indent Line" = RIMD,
    table "E3 Indenter Master" = X,
    tabledata "E3 Indenter Master" = RIMD,
    page "E3 Indent List" = X,
    page "E3 Indent Card" = X,
    page "E3 Indent Line Subform" = X,
    page "E3 Indenter Master List" = X,
    table "E3 Voucher Type" = X,
    tabledata "E3 Voucher Type" = RIMD,
    page "E3 Voucher Types" = X,
    table "E3 Item Make Master" = X,
    tabledata "E3 Item Make Master" = RIMD,
    page "E3 Item Make Master" = X,
    table "E3 Released Indent Details" = X,
    tabledata "E3 Released Indent Details" = RIMD,
    Page "E3 Quotation Card" = X,
    page "E3 Approved Indent List" = X,
    page "E3 Approved HIS Indent List" = X,
    page "E3 Released Indent Details" = X,
    page "E3 Quotation List" = X,
    table "E3 Indent Cue" = X,
    tabledata "E3 Indent Cue" = RIMD,
    page "E3 Indent Cue Card" = X,
    page "E3 Indent Role Center" = X;

}