enum 50010 "E3 Gate Pass Status"
{
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; "Pending Approval")
    {
        Caption = 'Pending Approval';
    }
    value(2; Approved)
    {
        Caption = 'Approved';
    }
    value(3; Posted)
    {
        Caption = 'Posted';
    }
    value(4; "Partially Returned")
    {
        Caption = 'Partially Returned';
    }
    value(5; Closed)
    {
        Caption = 'Closed';
    }
    value(6; Cancelled)
    {
        Caption = 'Cancelled';
    }

}
