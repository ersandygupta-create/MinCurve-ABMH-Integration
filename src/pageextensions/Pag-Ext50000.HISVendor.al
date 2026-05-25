pageextension 50000 "E3 HIS Vendor Card" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field("E3 HIS Code"; Rec."E3 HIS Code")
            {
                ApplicationArea = All;
                Editable = false;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("E3 MSME Type"; Rec."E3 MSME Type")
            {
                ApplicationArea = All;
                Editable = true;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("MSME No."; Rec."E3 MSME No.")
            {
                ApplicationArea = All;
                Editable = true;
                Style = StrongAccent;
                StyleExpr = true;
                ToolTip = 'Specifies the value of the MSME No. field';
            }
            field("E3 Auto E-Mail"; Rec."E3 Auto E-Mail")
            {
                ApplicationArea = All;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("DL No."; Rec."DL No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Name)
        {
            field("Name2"; Rec."Name 2")
            {
                ApplicationArea = All;
                Caption = 'Name 2';
                ToolTip = 'Specifies the value of the Name 2 field';
            }
            field("Bank Integration"; Rec."Bank Integration")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Integration Enabled';
                ToolTip = 'Indicates whether bank integration is enabled for this vendor.';
            }

        }
    }

    actions
    {
        addafter(PayVendor)
        {
            action("Vendor Ledger Report")
            {
                ApplicationArea = All;
                Caption = 'Vendor Ledger Report';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;
                trigger OnAction()
                begin
                    recVendor.Reset();
                    recVendor.SetRange("No.", Rec."No.");
                    REPORT.RUNMODAL(Report::"Vendor Ledger Report", TRUE, TRUE, recVendor);

                end;
            }
            action("Vendor NotePad Report")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor Payment Report_N';
                Image = xmlport;
                RunObject = xmlport "Vendor Payment Report_N";
                RunPageMode = Edit;
            }
            action("Vendor Excel Report")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor Payment Report_Excel';
                Image = Report;
                RunObject = report "Vendor Payment Report";
                RunPageMode = Edit;

            }
            action("TDS Register")
            {
                ApplicationArea = All;
                Caption = 'TDS Register';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;
                trigger OnAction()
                begin
                    recTDSEntry.Reset();
                    recTDSEntry.SetRange(recTDSEntry."Vendor No.", Rec."No.");
                    REPORT.RUNMODAL(Report::"TDS Register Report", TRUE, TRUE, recTDSEntry);

                end;
            }
        }

        addafter("Ven&dor")
        {
            group(AkhilIntegration)
            {
                Caption = 'HIS Integration';

                action(SyncLog)
                {
                    Caption = 'HIS Sync Logs';
                    ToolTip = 'HIS System Sync Logs.';
                    Image = Log;
                    ApplicationArea = all;
                    RunObject = page "E3 API Supplier Update Logs";
                    RunPageLink = "No." = field("No.");
                    RunPageMode = View;
                }

                // action(ReSync)
                // {
                //     Caption = 'Re-Sync';
                //     ToolTip = 'Re-sync all data to Akhil Systems.';
                //     Image = LinkAccount;
                //     ApplicationArea = all;

                //     trigger OnAction()
                //     var
                //         EDCAkhilMgmt: Codeunit "E3 Akhil Integration Mgmt.";
                //     begin
                //         Clear(EDCAkhilMgmt);
                //         EDCAkhilMgmt.SupplierSyncAll(Rec);
                //     end;
                // }
            }
        }
    }
    var
        recVendor: Record Vendor;
        recTDSEntry: Record "TDS Entry";
}
