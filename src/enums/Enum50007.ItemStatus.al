enum 50007 "E3 HIS Item Status"
{
    Extensible = true;

    value(0; New)
    {
        Caption = 'New';
    }
    value(1; "Pending Approval")
    {
        Caption = 'Pending Approval';
    }
    value(2; Approved)
    {
        Caption = 'First Level Approved';
    }
    value(3; Reject)
    {
        Caption = 'Reject';
    }

}
