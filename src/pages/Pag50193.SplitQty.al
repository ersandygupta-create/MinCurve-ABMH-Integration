page 50193 "E3 Split Qty"
{
    Caption = 'Split Quantity';
    PageType = StandardDialog;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(SplitQty; SplitQty)
                {
                    ApplicationArea = All;
                    Caption = 'Split Qty';
                    ToolTip = 'Enter the quantity to split.';
                }
            }
        }
    }

    var
        SplitQty: Decimal;

    procedure GetSplitQty(): Decimal
    begin
        exit(SplitQty);
    end;

    procedure SetSplitQty(NewSplitQty: Decimal)
    begin
        SplitQty := NewSplitQty;
    end;
}