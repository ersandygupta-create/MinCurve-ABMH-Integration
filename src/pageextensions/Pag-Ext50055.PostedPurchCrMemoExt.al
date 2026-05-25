pageextension 50055 "E3 HIS Posted Purch. Cr. Memo" extends "Posted Purchase Credit Memo"
{
    actions
    {
        addlast(IncomingDocument)
        {
            action("E3 Export Non Pharmacy Purchase Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Export Non Pharmacy Purchase Invoice';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    HISIntegration: Codeunit "E3 HIS Integration Mgmt.";
                begin
                    IF (Rec."E3 HIS Type" <> Rec."E3 HIS Type"::" ") then
                        Error('Export Only Non Pharmacy Posted Purchase Invoice %1', Rec."No.");

                    IF (Rec."E3 HIS Type" = Rec."E3 HIS Type"::" ") then begin
                        HISIntegration.InitHISPurchaseSaleHeaderGRNReturn(Rec);
                    END ELSE
                        Error('Export Posted Purchase Invoice is already Created to HIS Staging Table.No need to Export Posted Purchase Invoice %1', Rec."No.");


                end;

            }
        }
    }
}
