page 50115 "E3 Advance PO API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'e3AdvancePoAPI';
    DelayedInsert = true;
    EntityName = 'advancePo';
    EntitySetName = 'advancePos';
    PageType = API;
    SourceTable = "Vendor Adv. Pay. Ag. PO";
    ODataKeyFields = "Purchase Order No.";
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(purchaseOrderNo; Rec."Purchase Order No.")
                {
                    Caption = 'Purchase Order No.';
                    trigger OnValidate()
                    begin
                        DuplicateCheck();
                    end;
                }
                field(entryType; Rec."Entry Type")
                {
                    Caption = 'Entry Type';
                }
                field(poDate; Rec."PO Date")
                {
                    Caption = 'PO Date';
                }
                field(vendorCode; Rec."Vendor Code")
                {
                    Caption = 'Vendor Code';
                }

                field(vendorName; Rec."Vendor Name")
                {
                    Caption = 'Vendor Name';
                }
                field(basicAmount; Rec."Basic Amount")
                {
                    Caption = 'Basic Amount';
                }
                field(gstAmount; Rec."GST Amount")
                {
                    Caption = 'GST Amount';
                }
                field(totalPOAmount; Rec."Total PO Amount")
                {
                    Caption = 'Total PO Amount';
                }
            }
        }
    }

    local procedure DuplicateCheck()
    var
        VendorAdvPo: Record "Vendor Adv. Pay. Ag. PO";
    begin
        VendorAdvPo.SetRange("Purchase Order No.", Rec."Purchase Order No.");
        if not VendorAdvPo.IsEmpty then
            error('Duplicate Entry');
    end;

}
