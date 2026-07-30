pageextension 50018 "E3 HIS Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field("E3 RCM"; Rec."E3 RCM")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RCM field.';
            }
        }
    }

    actions
    {
        addlast(Reporting)
        {
            action("Pro Forma Invoice")
            {
                ApplicationArea = All;
                Caption = 'Pro Forma Invoice';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Print the Pro Forma Invoice for the current sales invoice.';

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("Document Type", Rec."Document Type");
                    SalesHeader.SetRange("No.", Rec."No.");

                    Report.RunModal(
                        Report::"E3 Pro Forma Sales Invoice",
                        true,
                        false,
                        SalesHeader);
                end;
            }
        }
    }
}