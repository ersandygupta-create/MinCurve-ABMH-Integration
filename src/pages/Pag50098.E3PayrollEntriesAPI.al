page 50098 "E3 HIS Payroll API"
{

    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'e3PayrollAPI';
    DelayedInsert = true;
    EntityName = 'payroll';
    EntitySetName = 'payrolls';
    PageType = API;
    SourceTable = "E3 HIS Payroll Staging";
    ODataKeyFields = SystemId;
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                    Editable = false;
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';

                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(salaryCode; Rec."Salary Code")
                {
                    Caption = 'Salary Code';
                }
                field(salaryHead; Rec."Salary Head")
                {
                    Caption = 'Salary Head';
                }
                field(accountType; Rec."Account Type")
                {
                    Caption = 'Account Type';
                }
                field(accountNo; Rec."Account No.")
                {
                    Caption = 'Account No.';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(employeeCode; Rec."Employee Code")
                {
                    Caption = 'Employee Code';
                }
                field(employeeName; Rec."Employee Name")
                {
                    Caption = 'Employee Name';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(groupName; Rec."Group Name")
                {
                    Caption = 'Group Name';
                }
                field(bankAccountName; Rec."Bank Account Name")
                {
                    Caption = 'Bank Account Name';
                }
                field(bankBranch; Rec."Bank Branch No.")
                {
                    Caption = 'Bank Branch No.';
                }
                field(ifscCode; Rec."IFSC Code")
                {
                    Caption = 'IFSC Code';
                }
                field(bankAccountNo; Rec."Bank Account No.")
                {
                    Caption = 'Bank Account No.';
                }
                field(narration; Rec.Narration)
                {
                    Caption = 'Narration';
                }
                field(isProcess; Rec.IsProcess)
                {
                    Caption = 'IsProcess';
                }
                field(employeeStatus; Rec."Employee Status")
                {
                    Caption = 'Employee Status';
                }
                field(dateofJoining; Rec."Date of Joining")
                {
                    Caption = 'Date of Joining';
                }
                field(dateofLeaving; Rec."Date of Leaving")
                {
                    Caption = 'Date of Leaving';
                }
                field(designation; Rec.Designation)
                {
                    Caption = 'Designation';
                }
                field(grade; Rec.Grade)
                {
                    Caption = 'Grade';
                }
                field(costCenterCode; Rec."Cost Center Code")
                {
                    Caption = 'Cost Center Code';
                }
                field(costCenterName; Rec."Cost Center Name")
                {
                    Caption = 'Cost Center Name';
                }
                field(gender; Rec.Gender)
                {
                    Caption = 'Gender';
                }
                field(pan; Rec.PAN)
                {
                    Caption = 'PAN';
                }
                field(paymode; Rec.Paymode)
                {
                    Caption = 'Paymode';
                }
                field(salaryHold; Rec."Salary Hold")
                {
                    Caption = 'Salary Hold';
                }
                field(pfno; Rec."PF No.")
                {
                    Caption = 'PF No.';
                }
                field(uanno; Rec."UAN No.")
                {
                    Caption = 'UAN No.';
                }
                field(esino; Rec."ESI No.")
                {
                    Caption = 'ESI No.';
                }
                field(ptLocation; Rec."PT Location")
                {
                    Caption = 'PT Location';
                }
                field(stddays; Rec.Stddays)
                {
                    Caption = 'Stddays';
                }
                field(wrkdays; Rec.WRKDAYS)
                {
                    Caption = 'WRKDAYS';
                }
                field(lopDays; Rec."LOP DAYS")
                {
                    Caption = 'LOP DAYS';
                }
                field(arreardays; Rec.ARREARDAYS)
                {
                    Caption = 'ARREARDAYS';
                }
                field(basicAmount; Rec."Basic Amount")
                {
                    Caption = 'Basic Amount';
                }
                field(hra; Rec.HRA)
                {
                    Caption = 'HRA';
                }
                field(exgratia; Rec.EXGRATIA)
                {
                    Caption = 'EXGRATIA';
                }
                field(splallow; Rec."SPL ALLOW")
                {
                    Caption = 'SPL ALLOW';
                }
                field(otherearn; Rec."OTHER EARN")
                {
                    Caption = 'OTHER EARN';
                }
                field(grossearn; Rec."GROSS EARN")
                {
                    Caption = 'GROSS EARN';
                }
                field(pfAmount; Rec."PF Amount")
                {
                    Caption = 'PF Amount';
                }
                field(esiAmount; Rec."ESI Amount")
                {
                    Caption = 'ESI Amount';
                }
                field(vpfsal; Rec."VPF SAL")
                {
                    Caption = 'VPF SAL';
                }
                field(hosteld; Rec.HOSTEL_D)
                {
                    Caption = 'HOSTEL_D';
                }
                field(ploan; Rec.P_LOAN)
                {
                    Caption = 'P_LOAN';
                }
                field(it; Rec.IT)
                {
                    Caption = 'IT';
                }
                field(grossded; Rec.GROSS_DED)
                {
                    Caption = 'GROSS_DED';
                }
                field(netpay; Rec."Net Pay")
                {
                    Caption = 'Net Pay';
                }
                field(conv; Rec.CONV)
                {
                    Caption = 'CONV';
                }
                field(foodA; Rec.FOOD_A)
                {
                    Caption = 'FOOD_A';
                }
                field(ccu; Rec.CCU)
                {
                    Caption = 'CCU';
                }
                field(retenAMT; Rec.RETEN_AMT)
                {
                    Caption = 'RETEN_AMT';
                }
                field(otherDEDN; Rec.OTHER_DEDN)
                {
                    Caption = 'OTHER_DEDN';
                }
                field(othDED; Rec.OTH_DED)
                {
                    Caption = 'OTH_DED';
                }
                field(pvctc; Rec.PVCTC)
                {
                    Caption = 'PVCTC';
                }
                field(bonctcp; Rec.BONCTCP)
                {
                    Caption = 'BONCTCP';
                }
                field(incentive; Rec.INCENTIVE)
                {
                    Caption = 'INCENTIVE';
                }
                field(pt; Rec.PT)
                {
                    Caption = 'PT';
                }
                field(shiftALL; Rec.SHIFT_ALL)
                {
                    Caption = 'SHIFT_ALL';
                }
                field(eeclwf; Rec.EECLWF)
                {
                    Caption = 'EECLWF';
                }
                field(bonusF; Rec.BONUS_F)
                {
                    Caption = 'BONUS_F';
                }
                field(noteded; Rec.NOT_E_DED)
                {
                    Caption = 'NOT_E_DED';
                }
                field(gratuity; Rec.GRATUITY)
                {
                    Caption = 'GRATUITY';
                }
                field(lvencset; Rec.LV_ENC_SET)
                {
                    Caption = 'LV_ENC_SET';
                }
                field(validationKey; Rec."Validation Key")
                {
                    Caption = 'Validation Key';
                    trigger OnValidate()
                    begin
                        DuplicateCheck();
                    end;
                }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Shortcut Dimension 3 Code';
                }
                field(shortcutDimension5Code; Rec."Shortcut Dimension 5 Code")
                {
                    Caption = 'Shortcut Dimension 5 Code';
                }
            }
        }
    }
    local procedure DuplicateCheck()
    var
        PayrollStaging: Record "E3 HIS Payroll Staging";
    begin
        PayrollStaging.SetRange("HIS Document Type", Rec."HIS Document Type");
        PayrollStaging.SetRange("Validation Key", Rec."Validation Key");
        if not PayrollStaging.IsEmpty then
            error('Duplicate Entry');
    end;
}