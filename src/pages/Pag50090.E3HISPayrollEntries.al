page 50090 "E3 HIS Payroll Entries"
{

    ApplicationArea = All;
    Caption = 'HIS Payroll Entries';
    PageType = List;
    Editable = true;
    SourceTableView = Sorting("Entry No.") where(IsProcess = filter(false));
    SourceTable = "E3 HIS Payroll Staging";
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
                field("Employee Code"; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field';
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                    ApplicationArea = All;
                }
                field("Employee Status"; Rec."Employee Status")
                {
                    ToolTip = 'Specifies the value of the Employee Status field';
                    ApplicationArea = All;
                }
                field("Date of Joining"; Rec."Date of Joining")
                {
                    ToolTip = 'Specifies the value of the Date of Joining field';
                    ApplicationArea = All;
                    Caption = 'DOJ';
                }
                field("Date of Leaving"; Rec."Date of Leaving")
                {
                    ToolTip = 'Specifies the value of the Date of Leaving field';
                    ApplicationArea = All;
                    Caption = 'DOL';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field';
                    ApplicationArea = All;
                }
                field("Salary Head"; Rec."Salary Head")
                {
                    ToolTip = 'Specifies the value of the Salary Head field';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Rec."Salary Head" <> '' then
                            Rec."Shortcut Dimension 5 Code" := Rec."Salary Head";
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field';
                    ApplicationArea = All;
                }
                field("Cost Center Code"; Rec."Cost Center Code")
                {
                    ToolTip = 'Specifies the value of the Cost Center Code field';
                    ApplicationArea = All;
                }
                field("Cost Center Name"; Rec."Cost Center Name")
                {
                    ToolTip = 'Specifies the value of the Cost Center Name field';
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                    ApplicationArea = All;
                }
                field(PAN; Rec.PAN)
                {
                    ToolTip = 'Specifies the value of the PAN field';
                    ApplicationArea = All;
                }
                field(Paymode; Rec.Paymode)
                {
                    ToolTip = 'Specifies the value of the Paymode field';
                    ApplicationArea = All;
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ToolTip = 'Specifies the value of the Bank Account Name field';
                    ApplicationArea = All;
                }
                // field("Bank Branch"; Rec."Bank Branch No.")
                // {
                //     ToolTip = 'Specifies the value of the Bank Branch field';
                //     ApplicationArea = All;
                // }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ToolTip = 'Specifies the value of the Bank Account No. field';
                    ApplicationArea = All;
                }
                field("IFSC Code"; Rec."IFSC Code")
                {
                    ToolTip = 'Specifies the value of the IFSC Code field';
                    ApplicationArea = All;
                }
                field("Salary Hold"; Rec."Salary Hold")
                {
                    ToolTip = 'Specifies the value of the Salary Hold field';
                    ApplicationArea = All;
                }
                field("PF No."; Rec."PF No.")
                {
                    ToolTip = 'Specifies the value of the PF No. field';
                    ApplicationArea = All;
                }
                field("UAN No."; Rec."UAN No.")
                {
                    ToolTip = 'Specifies the value of the UAN No. field';
                    ApplicationArea = All;
                }
                field("ESI No."; Rec."ESI No.")
                {
                    ToolTip = 'Specifies the value of the ESI No. field';
                    ApplicationArea = All;
                }
                field("PT Location"; Rec."PT Location")
                {
                    ToolTip = 'Specifies the value of the PT Location field';
                    ApplicationArea = All;
                }
                field("Arrear Days"; Rec."Arrear Days")
                {
                    ToolTip = 'Specifies the value of the Arrear Days field';
                    ApplicationArea = All;
                }
                field(Stddays; Rec.Stddays)
                {
                    ToolTip = 'Specifies the value of the Stddays field';
                    ApplicationArea = All;
                }
                field(WRKDAYS; Rec.WRKDAYS)
                {
                    ToolTip = 'Specifies the value of the WRKDAYS field';
                    ApplicationArea = All;
                }
                field("LOP DAYS"; Rec."LOP DAYS")
                {
                    ToolTip = 'Specifies the value of the LOP DAYS field';
                    ApplicationArea = All;
                }
                field(ARREARDAYS; Rec.ARREARDAYS)
                {
                    ToolTip = 'Specifies the value of the ARREARDAYS field';
                    ApplicationArea = All;
                }
                field("Basic Amount"; Rec."Basic Amount")
                {
                    ToolTip = 'Specifies the value of the Basic Amount field';
                    ApplicationArea = All;
                }
                field(HRA; Rec.HRA)
                {
                    ToolTip = 'Specifies the value of the HRA field';
                    ApplicationArea = All;
                }
                field(EXGRATIA; Rec.EXGRATIA)
                {
                    ToolTip = 'Specifies the value of the EXGRATIA field';
                    ApplicationArea = All;
                }
                field(LV_ENC_SET; Rec.LV_ENC_SET)
                {
                    ToolTip = 'Specifies the value of the LV_ENC_SET field';
                    ApplicationArea = All;
                }
                field("SPL ALLOW"; Rec."SPL ALLOW")
                {
                    ToolTip = 'Specifies the value of the SPL ALLOW field';
                    ApplicationArea = All;
                }
                field(SHIFT_ALL; Rec.SHIFT_ALL)
                {
                    ToolTip = 'Specifies the value of the SHIFT_ALL field';
                    ApplicationArea = All;
                }
                field(BONUS_F; Rec.BONUS_F)
                {
                    ToolTip = 'Specifies the value of the BONUS_F field';
                    ApplicationArea = All;
                }
                field("GROSS EARN"; Rec."GROSS EARN")
                {
                    ToolTip = 'Specifies the value of the Gross Earn field';
                    ApplicationArea = All;
                }
                field("PF Amount"; Rec."PF Amount")
                {
                    ToolTip = 'Specifies the value of the PF Amount field';
                    ApplicationArea = All;
                }
                field("ESI Amount"; Rec."ESI Amount")
                {
                    ToolTip = 'Specifies the value of the ESI Amount field';
                    ApplicationArea = All;
                }
                field("VPF SAL"; Rec."VPF SAL")
                {
                    ToolTip = 'Specifies the value of the VPF SAL field';
                    ApplicationArea = All;
                }
                field(HOSTEL_D; Rec.HOSTEL_D)
                {
                    ToolTip = 'Specifies the value of the Hostel D field';
                    ApplicationArea = All;
                }
                field(P_LOAN; Rec.P_LOAN)
                {
                    ToolTip = 'Specifies the value of the P_Loan field';
                    ApplicationArea = All;
                }
                field(EECLWF; Rec.EECLWF)
                {
                    ToolTip = 'Specifies the value of the EECLWF field';
                    ApplicationArea = All;
                }
                field(IT; Rec.IT)
                {
                    ToolTip = 'Specifies the value of the IT field';
                    ApplicationArea = All;
                }
                field(NOT_E_DED; Rec.NOT_E_DED)
                {
                    ToolTip = 'Specifies the value of the NOT_E_DED field';
                    ApplicationArea = All;
                }
                field(GROSS_DED; Rec.GROSS_DED)
                {
                    ToolTip = 'Specifies the value of the Gross_Ded field';
                    ApplicationArea = All;
                }
                field("Net Pay"; Rec."Net Pay")
                {
                    ToolTip = 'Specifies the value of the Net Pay field';
                    ApplicationArea = All;
                }
                field("OTHER EARN"; Rec."OTHER EARN")
                {
                    ToolTip = 'Specifies the value of the Other Earn field';
                    ApplicationArea = All;
                }
                field(CONV; Rec.CONV)
                {
                    ToolTip = 'Specifies the value of the CONV field';
                    ApplicationArea = All;
                }
                field(FOOD_A; Rec.FOOD_A)
                {
                    ToolTip = 'Specifies the value of the FOOD_A field';
                    ApplicationArea = All;
                }
                field(CCU; Rec.CCU)
                {
                    ToolTip = 'Specifies the value of the CCU field';
                    ApplicationArea = All;
                }
                field(RETEN_AMT; Rec.RETEN_AMT)
                {
                    ToolTip = 'Specifies the value of the RETEN_AMT field';
                    ApplicationArea = All;
                }
                field(OTHER_DEDN; Rec.OTHER_DEDN)
                {
                    ToolTip = 'Specifies the value of the OTHER_DEDN field';
                    ApplicationArea = All;
                }
                field(OTH_DED; Rec.OTH_DED)
                {
                    ToolTip = 'Specifies the value of the OTH_DED field';
                    ApplicationArea = All;
                }
                field(PVCTC; Rec.PVCTC)
                {
                    ToolTip = 'Specifies the value of the PVCTC field';
                    ApplicationArea = All;
                }
                field(BONCTCP; Rec.BONCTCP)
                {
                    ToolTip = 'Specifies the value of the BONCTCP field';
                    ApplicationArea = All;
                }
                field(INCENTIVE; Rec.INCENTIVE)
                {
                    ToolTip = 'Specifies the value of the INCENTIVE field';
                    ApplicationArea = All;
                }
                field(PT; Rec.PT)
                {
                    ToolTip = 'Specifies the value of the PT field';
                    ApplicationArea = All;
                }
                field(GRATUITY; Rec.GRATUITY)
                {
                    ToolTip = 'Specifies the value of the GRATUITY field';
                    ApplicationArea = All;
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
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                    ApplicationArea = All;
                }
                field("Group Name"; Rec."Group Name")
                {
                    ToolTip = 'Specifies the value of the Group Name field';
                    ApplicationArea = All;
                }
                field(Narration; Rec.Narration)
                {
                    ToolTip = 'Specifies the value of the Narration field';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field';
                    ApplicationArea = All;
                    Caption = 'Employee Dimension Code';
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field';
                    ApplicationArea = All;
                    Caption = 'Salary Dimension Code';
                }
                field(IsProcess; Rec.IsProcess)
                {
                    ToolTip = 'Specifies the value of the IsProcess field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Payroll Entries")
            {
                ApplicationArea = All;
                Caption = 'Create Post Payroll Journal';
                Image = CreateLedgerBudget;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Create Payroll Entries action.';
                trigger OnAction();
                var
                    HISIntegration: Codeunit "E3 HIS Integration Mgmt.";
                begin
                    if Confirm('Do you want to create and post payroll entries?', false) then begin
                        HISIntegration.InitGenJnlLinePayrollEntriesRec(Rec);
                        Message('Payroll entries for Document No. %1 have been posted successfully.', Rec."Document No.");
                    end else
                        Message('Operation cancelled by the user.');
                end;
            }
            action("Post Payroll Entries")
            {
                ApplicationArea = All;
                Image = PostBatch;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Post Payroll Entries action.';
                trigger OnAction();
                var
                    HISIntegration: Codeunit "E3 HIS Integration Mgmt.";
                begin

                    HISIntegration.PostGenJnlLineEntries();
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        CheckBln := USERID;
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", CheckBln);
        IF UserSetup.FIND('-') THEN BEGIN
            IF UserSetup.Payroll <> TRUE THEN
                ERROR('Permission of Payroll is not added in your access. If required please contact to IT Administrator ');
        END;
    End;

    var
        CheckBln: Code[30];
        UserSetup: Record "User Setup";


}
