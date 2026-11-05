enum 50015 E3PaymentType
{
    Extensible = true;
    Value(0; Advance)
    {
        Caption = 'Advance', Locked = true;
    }
    Value(1; Refund)
    {
        Caption = 'Refund', Locked = true;
    }
    Value(2; Settlement)
    {
        Caption = 'Settlement', Locked = true;
    }
    Value(3; "Refund Settlement")
    {
        Caption = 'Refund Settlement', Locked = true;
    }
}