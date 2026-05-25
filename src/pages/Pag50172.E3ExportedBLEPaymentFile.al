page 50172 "E3 Exported BLE File"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;
    Caption = 'Bank Process Data';
    SourceTable = "E3 Bank Integration";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(PaymentTy; Rec.PaymentTy)
                {
                }
                field(BeneficiaryAccNo; Rec.BeneficiaryAccNo)
                {
                }
                field("Recipient Bank Account"; Rec."Recipient Bank Account")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(BeneficiaryName; Rec.BeneficiaryName)
                {
                }
                field(DraweeLocation; Rec.DraweeLocation)
                {
                }
                field(PrintLocation; Rec.PrintLocation)
                {
                }
                field(BeneAddress1; Rec.BeneAddress1)
                {
                }
                field(BeneAddress2; Rec.BeneAddress2) { }
                field(BeneAddress3; Rec.BeneAddress3) { }
                field(BeneAddress4; Rec.BeneAddress4) { }
                field(BeneAddress5; Rec.BeneAddress5) { }
                field("Bal. Account No."; Rec."Bal. Account No.") { }
                field("Document No."; Rec."Document No.") { }
                field(Paymentdetails1; Rec.Paymentdetails1) { }
                field(Paymentdetails2; Rec.Paymentdetails2) { }
                field(Paymentdetails3; Rec.Paymentdetails3) { }
                field(Paymentdetails4; Rec.Paymentdetails4) { }
                field(Paymentdetails5; Rec.Paymentdetails5) { }
                field(Paymentdetails6; Rec.Paymentdetails6) { }
                field(Paymentdetails7; Rec.Paymentdetails7) { }
                field("Cheque No."; Rec."Cheque No.") { }
                field("Posting Date"; Rec."Posting Date") { }
                field(MICRNumber; Rec.MICRNumber) { }
                field("Recipient Bank IFSC Code"; Rec."Recipient Bank IFSC Code") { }
                field("Recipient Bank Name"; Rec."Recipient Bank Name") { }
                field("Recipient Branch Name"; Rec."Recipient Branch Name") { }
                field(Beneficiaryemailid; Rec.Beneficiaryemailid) { }
                field(EntryNo; Rec.EntryNo) { }
                field("UTR No."; Rec."UTR No.") { }
                field("Unit Code"; Rec."Unit Code") { }
                field("File Name"; Rec."File Name") { }
                field("Bank Account Ledger Entry No."; Rec."Bank Account Ledger Entry No.") { }
                field(FLD1; Rec.FLD1) { }
                field(FLD2; Rec.FLD2) { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}