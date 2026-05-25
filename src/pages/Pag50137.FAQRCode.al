page 50137 "FA QR Code"
{
    Caption = 'FA QR Code';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Fixed Asset";

    layout
    {
        area(Content)
        {
            field("QR Code"; Rec."QR Code")
            {
                ApplicationArea = FixedAssets;
                ShowCaption = false;
                ToolTip = 'Specifies the QR Code that has been inserted for the fixed asset.';
            }
        }
    }
}