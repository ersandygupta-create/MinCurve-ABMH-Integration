page 50088 "E3 HIS Doctor Payout Entries"
{

    ApplicationArea = All;
    Caption = 'HIS Doctor Payout Entries';
    PageType = List;
    Editable = true;

    SourceTableView = Sorting("Entry No.") where("General Entries Created" = filter(false));
    SourceTable = "E3 HIS Doctor Payout";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field';
                    ApplicationArea = All;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;

                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field';
                    ApplicationArea = All;
                }
                field("HIS Document Type"; Rec."HIS Document Type")
                {
                    ToolTip = 'Specifies the value of the Payout Category field';
                    ApplicationArea = All;
                    Caption = 'Payout Category';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field';
                    ApplicationArea = All;
                }
                // field("Mode of Payment"; Rec."Mode of Payment")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Mode of Payment field.';
                // }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                    ApplicationArea = All;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ToolTip = 'Specifies the value of the Bal. Account Type field';
                    ApplicationArea = All;
                    Caption = 'Type';
                }
                field("Bal. Account No"; Rec."Bal. Account No")
                {
                    ToolTip = 'Specifies the value of the Bal. Account No field';
                    ApplicationArea = All;
                    Caption = 'Doctors Code';
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field';
                    ApplicationArea = All;
                }
                field("Doctor Name"; Rec."Doctor Name")
                {
                    ToolTip = 'Specifies the value of the Doctor Name field';
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field';
                    ApplicationArea = All;
                }

                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    ApplicationArea = All;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ToolTip = 'Specifies the value of the Unit Name field';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                    ApplicationArea = All;
                }
                field("Line Narration"; Rec."Line Narration")
                {
                    ToolTip = 'Specifies the value of the Line Narration field';
                    ApplicationArea = All;
                }
                // field("Patient Name"; Rec."Patient Name")
                // {
                //     ToolTip = 'Specifies the value of the Patient Name field';
                //     ApplicationArea = All;
                // }
                // field(UHID; Rec.UHID)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the UHID field.';
                // }
                // field("Encounter No."; Rec."Encounter No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Encounter No. field.';
                // }
                // field("IP No."; Rec."IP No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the IP No. field.';
                // }
                field("Gross Before TDS"; Rec."Gross Before TDS")
                {
                    ToolTip = 'Specifies the value of the Gross Before TDS field';
                    ApplicationArea = All;
                }
                field("TDS Amount"; Rec."TDS Amount")
                {
                    ToolTip = 'Specifies the value of the TDS Amount field';
                    ApplicationArea = All;
                }
                field("Gross After TDS"; Rec."Gross After TDS")
                {
                    ToolTip = 'Specifies the value of the Gross After TDS field';
                    ApplicationArea = All;
                }
                field("After TDS Earn"; Rec."After TDS Earn")
                {
                    ToolTip = 'Specifies the value of the After TDS Earn field';
                    ApplicationArea = All;
                }
                field("After TDS Dedu."; Rec."After TDS Dedu.")
                {
                    ToolTip = 'Specifies the value of the After TDS Dedu. field';
                    ApplicationArea = All;
                }
                field("Net Payable Amount"; Rec."Net Payable Amount")
                {
                    ToolTip = 'Specifies the value of the Net Payable Amount field';
                    ApplicationArea = All;
                }
                field("TDS Section"; Rec."TDS Section")
                {
                    ToolTip = 'Specifies the value of the TDS Section field';
                    ApplicationArea = All;
                }
                field("Expense G/L Code"; Rec."Expense G/L Code")
                {
                    ToolTip = 'Specifies the value of the Expense G/L Code field';
                    ApplicationArea = All;
                }
                field("Month Year"; Rec."Month Year")
                {
                    ToolTip = 'Specifies the value of the Month Year field';
                    ApplicationArea = All;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ToolTip = 'Specifies the value of the Payment Type field';
                    ApplicationArea = All;
                }
                field("OP Payout Type Name"; Rec."OP Payout Type Name")
                {
                    ToolTip = 'Specifies the value of the OP Payout Type Name field';
                    ApplicationArea = All;
                }
                field("IP Payout Type Name"; Rec."IP Payout Type Name")
                {
                    ToolTip = 'Specifies the value of the IP Payout Type Name field';
                    ApplicationArea = All;
                }
                field("Gross OP Amount"; Rec."Gross OP Amount")
                {
                    ToolTip = 'Specifies the value of the Gross OP Amount field';
                    ApplicationArea = All;
                }
                field("Gross IP Amount"; Rec."Gross IP Amount")
                {
                    ToolTip = 'Specifies the value of the Gross IP Amount field';
                    ApplicationArea = All;
                }
                field("Net Bill Amount"; Rec."Net Bill Amount")
                {
                    ToolTip = 'Specifies the value of the Net Bill Amount field';
                    ApplicationArea = All;
                }
                field("Doc. OP Amount"; Rec."Doc. OP Amount")
                {
                    ToolTip = 'Specifies the value of the Doc. OP Amount field';
                    ApplicationArea = All;
                }
                field("Doc. IP Amount"; Rec."Doc. IP Amount")
                {
                    ToolTip = 'Specifies the value of the Doc. IP Amount field';
                    ApplicationArea = All;
                }
                field("Doc. Net Amount"; Rec."Doc. Net Amount")
                {
                    ToolTip = 'Specifies the value of the Doc. Net Amount field';
                    ApplicationArea = All;
                }
                field("Doc. Accrual"; Rec."Doc. Accrual")
                {
                    ToolTip = 'Specifies the value of the Doc. Accrual field';
                    ApplicationArea = All;
                }
                field("Doc. Payable Amount"; Rec."Doc. Payable Amount")
                {
                    ToolTip = 'Specifies the value of the Doc. Payable Amount field';
                    ApplicationArea = All;
                }
                field("Adjusted Amount"; Rec."Adjusted Amount")
                {
                    ToolTip = 'Specifies the value of the Adjusted Amount field';
                    ApplicationArea = All;
                }
                field("Minimum Guarantee Amt"; Rec."Minimum Guarantee Amt")
                {
                    ToolTip = 'Specifies the value of the Minimum Guarantee Amt field';
                    ApplicationArea = All;
                }
                field("Monthly Fixed Amt"; Rec."Monthly Fixed Amt")
                {
                    ToolTip = 'Specifies the value of the Monthly Fixed Amt field';
                    ApplicationArea = All;
                }
                field("Net Doctor Payable"; Rec."Net Doctor Payable")
                {
                    ToolTip = 'Specifies the value of the Net Doctor Payable field';
                    ApplicationArea = All;
                }
                field("Before TDS Earn"; Rec."Before TDS Earn")
                {
                    ToolTip = 'Specifies the value of the Before TDS Earn field';
                    ApplicationArea = All;
                }
                field("Before TDS Dedu."; Rec."Before TDS Dedu.")
                {
                    ToolTip = 'Specifies the value of the Before TDS Dedu. field';
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Doctor Payout Entries")
            {
                ApplicationArea = All;
                Image = CreateLedgerBudget;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Create Doctor Payout Entries action.';
                trigger OnAction();
                var
                    HISIntegration: Codeunit "E3 HIS Integration Mgmt.";
                begin
                    HISIntegration.InitGenJnlLineDoctorPayoutEntries();

                end;
            }
            action("Post Doctor Payout Entries")
            {
                ApplicationArea = All;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Post Doctor Payout Entries action.';
                trigger OnAction();
                var
                    HISIntegration: Codeunit "E3 HIS Integration Mgmt.";
                begin

                    HISIntegration.PostGenJnlLineEntries();
                end;
            }
        }
    }

}
