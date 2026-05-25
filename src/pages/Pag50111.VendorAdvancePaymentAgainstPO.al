page 50111 "Vendor Advance Pay. Against PO"
{

    ApplicationArea = All;
    Caption = 'Vendor Advance Payment Against PO';
    PageType = List;
    SourceTable = "Vendor Adv. Pay. Ag. PO";
    UsageCategory = Lists;
    Editable = true;
    DeleteAllowed = true;
    ModifyAllowed = true;
    InsertAllowed = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Entry Type field';
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Purchase Order No. field';
                }
                field("PO Date"; Rec."PO Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the PO Date field';
                }
                field("Vendor Code"; Rec."Vendor Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Vendor Code field';
                }

                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Vendor Name field';
                }
                field("Basic Amount"; Rec."Basic Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Basic Amount field';
                }
                field("GST Amount"; Rec."GST Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the GST Amount field';
                }
                field("Total PO Amount"; Rec."Total PO Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Total PO Amount field';
                }

                field("Total Applied Amount"; Rec."Total Applied Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = false;
                    ToolTip = 'Specifies the value of the Total Applied Amount field';
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Remaining Amount field';
                }

            }
        }

    }

    actions
    {
        area(navigation)
        {
            action("Update Remaining Amount")
            {
                Caption = 'Update Remaining Amount';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    VendorAdvancePayAgainstPO: Record "Vendor Adv. Pay. Ag. PO";
                begin
                    IF Confirm('Do you want to update the Remaining Amount') then begin
                        VendorAdvancePayAgainstPO.Reset();
                        VendorAdvancePayAgainstPO.SetRange("Entry Type", Rec."Entry Type");
                        VendorAdvancePayAgainstPO.SetRange("Purchase Order No.", Rec."Purchase Order No.");
                        IF VendorAdvancePayAgainstPO.FindFirst() then begin
                            VendorAdvancePayAgainstPO.CalcFields(VendorAdvancePayAgainstPO."Total Applied Amount");
                            IF VendorAdvancePayAgainstPO."Total Applied Amount" <> 0 then begin
                                VendorAdvancePayAgainstPO."Remaining Amount" := VendorAdvancePayAgainstPO."Total PO Amount" - VendorAdvancePayAgainstPO."Total Applied Amount";
                                VendorAdvancePayAgainstPO.Modify();
                            end;
                        end;
                    end;
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        VendorAdvancePayAgainstPO.Reset();
        VendorAdvancePayAgainstPO.SetRange("Entry Type", Rec."Entry Type");
        VendorAdvancePayAgainstPO.SetRange("Purchase Order No.", Rec."Purchase Order No.");
        IF VendorAdvancePayAgainstPO.FindFirst() then begin
            VendorAdvancePayAgainstPO.CalcFields(VendorAdvancePayAgainstPO."Total Applied Amount");
            IF VendorAdvancePayAgainstPO."Total Applied Amount" <> 0 then begin
                VendorAdvancePayAgainstPO."Remaining Amount" := VendorAdvancePayAgainstPO."Total PO Amount" - VendorAdvancePayAgainstPO."Total Applied Amount";
                VendorAdvancePayAgainstPO.Modify();
            end;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        VendorAdvancePayAgainstPO.Reset();
        VendorAdvancePayAgainstPO.SetRange("Entry Type", Rec."Entry Type");
        VendorAdvancePayAgainstPO.SetRange("Purchase Order No.", Rec."Purchase Order No.");
        IF VendorAdvancePayAgainstPO.FindFirst() then begin
            VendorAdvancePayAgainstPO.CalcFields(VendorAdvancePayAgainstPO."Total Applied Amount");
            IF VendorAdvancePayAgainstPO."Total Applied Amount" <> 0 then begin
                VendorAdvancePayAgainstPO."Remaining Amount" := VendorAdvancePayAgainstPO."Total PO Amount" - VendorAdvancePayAgainstPO."Total Applied Amount";
                VendorAdvancePayAgainstPO.Modify();
            end;
        end;
    end;


    var
        VendorAdvancePayAgainstPO: Record "Vendor Adv. Pay. Ag. PO";

}
