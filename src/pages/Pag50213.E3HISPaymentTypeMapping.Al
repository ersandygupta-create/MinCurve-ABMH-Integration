page 50213 "HIS Payment Mapping List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 50048;
    Caption = 'HIS Payment Type Mapping';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Payment Type"; Rec."Payment Type")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the payment type.';
                }
                field("HIS Document Type"; Rec."HIS Document Type")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the HIS document type mapping.';
                }
            }
        }
    }
}