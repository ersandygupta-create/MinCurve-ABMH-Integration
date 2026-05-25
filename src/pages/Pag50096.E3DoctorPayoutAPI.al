page 50096 "E3 Doctors API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'e3DoctorsAPI';
    DelayedInsert = true;
    EntityName = 'doctor';
    EntitySetName = 'doctorPayouts';
    PageType = API;
    SourceTable = "E3 HIS Doctor Payout";
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
                    trigger OnValidate()
                    begin
                        DuplicateCheck();
                    end;

                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(hisDocumentType; Rec."HIS Document Type")
                {
                    Caption = 'HIS Document Type';
                }
                field(modeOfPayment; Rec."Mode of Payment")
                {
                    Caption = 'Mode of Payment';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(balaccounttype; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field(balaccountno; Rec."Bal. Account No")
                {
                    Caption = 'Bal. Account No';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(uhid; Rec.UHID)
                {
                    Caption = 'UHID';
                }
                field(ipno; Rec."IP No.")
                {
                    Caption = 'IP No.';
                }
                field(encounterNo; Rec."Encounter No.")
                {
                    Caption = 'Encounter No.';
                }

                field(patientName; Rec."Patient Name")
                {
                    Caption = 'Patient Name';
                }
                field(linenarration; Rec."Line Narration")
                {
                    Caption = 'Line Narration';
                }
                field(grossBeforeTDS; Rec."Gross Before TDS")
                {
                    Caption = 'Gross Before TDS';
                }
                field(tdsAmount; Rec."TDS Amount")
                {
                    Caption = 'TDS Amount';
                }
                field(grossAfterTDS; Rec."Gross After TDS")
                {
                    Caption = 'Gross After TDS';
                }
                field(afterTDSEarn; Rec."After TDS Earn")
                {
                    Caption = 'After TDS Earn';
                }
                field(afterTDSDedu; Rec."After TDS Dedu.")
                {
                    Caption = 'After TDS Dedu.';
                }
                field(netPayableAmount; Rec."Net Payable Amount")
                {
                    Caption = 'Net Payable Amount';
                }
                field(tdsSection; Rec."TDS Section")
                {
                    Caption = 'TDS Section';
                }
                field(doctorid; Rec."Doctor ID")
                {
                    Caption = 'Doctor ID';
                }
                field(doctorName; Rec."Doctor Name")
                {
                    Caption = 'Doctor Name';
                }
                field(expenseGLCode; Rec."Expense G/L Code")
                {
                    Caption = 'Expense G/L Code';
                }
                field(monthYear; Rec."Month Year")
                {
                    Caption = 'Month Year';
                }
                field(paymentType; Rec."Payment Type")
                {
                    Caption = 'Payment Type';
                }
                field(opPayoutTypeName; Rec."OP Payout Type Name")
                {
                    Caption = 'OP Payout Type Name';
                }
                field(ipPayoutTypeName; Rec."IP Payout Type Name")
                {
                    Caption = 'IP Payout Type Name';
                }
                field(grossOPAmount; Rec."Gross OP Amount")
                {
                    Caption = 'Gross OP Amount';
                }
                field(grossIPAmount; Rec."Gross IP Amount")
                {
                    Caption = 'Gross IP Amount';
                }
                field(netBillAmount; Rec."Net Bill Amount")
                {
                    Caption = 'Net Bill Amount';
                }
                field(docOPAmount; Rec."Doc. OP Amount")
                {
                    Caption = 'Doc. OP Amount';
                }
                field(docIPAmount; Rec."Doc. IP Amount")
                {
                    Caption = 'Doc. IP Amount';
                }
                field(docNetAmount; Rec."Doc. Net Amount")
                {
                    Caption = 'Doc. Net Amount';
                }
                field(docAccrual; Rec."Doc. Accrual")
                {
                    Caption = 'Doc. Accrual';
                }
                field(docPayableAmount; Rec."Doc. Payable Amount")
                {
                    Caption = 'Doc. Payable Amount';
                }
                field(adjustedAmount; Rec."Adjusted Amount")
                {
                    Caption = 'Adjusted Amount';
                }
                field(minimumGuaranteeAmt; Rec."Minimum Guarantee Amt")
                {
                    Caption = 'Minimum Guarantee Amt';
                }
                field(monthlyFixedAmt; Rec."Monthly Fixed Amt")
                {
                    Caption = 'Monthly Fixed Amt';
                }
                field(netDoctorPayable; Rec."Net Doctor Payable")
                {
                    Caption = 'Net Doctor Payable';
                }
                field(beforeTDSEarn; Rec."Before TDS Earn")
                {
                    Caption = 'Before TDS Earn';
                }
                field(beforeTDSDedu; Rec."Before TDS Dedu.")
                {
                    Caption = 'Before TDS Dedu';
                }
            }
        }
    }


    local procedure DuplicateCheck()
    var
        DoctorPayout: Record "E3 HIS Doctor Payout";
    begin
        //DoctorPayout.SetFilter("Entry No.", '<>%1', Rec."Entry No.");
        DoctorPayout.SetRange("HIS Document Type", Rec."HIS Document Type");
        DoctorPayout.SetRange("Document No.", Rec."Document No.");
        if not DoctorPayout.IsEmpty then
            error('Duplicate Entry');
    end;
}
