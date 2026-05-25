query 50025 "E3 Exported Bank File Get API"
{
    QueryType = API;
    APIPublisher = 'mindCurve';
    APIGroup = 'apiHIS';
    APIVersion = 'v2.0';
    Caption = 'Bankfiles';
    EntityName = 'Bankfiles';
    EntitySetName = 'Bankfiles';

    elements
    {
        dataitem(BankIntegration; "E3 Bank Integration")
        {
            DataItemTableFilter = "UTR No." = const('');

            column(documentNo; "Document No.") { }
            column(paymentTy; PaymentTy) { }
            column(beneficiaryAccNo; BeneficiaryAccNo) { }
            column(recipientBankAccount; "Recipient Bank Account") { }
            column(amount; Amount) { }
            column(beneficiaryName; BeneficiaryName) { }
            column(draweeLocation; DraweeLocation) { }
            column(printLocation; PrintLocation) { }
            column(beneAddress1; BeneAddress1) { }
            column(beneAddress2; BeneAddress2) { }
            column(beneAddress3; BeneAddress3) { }
            column(beneAddress4; BeneAddress4) { }
            column(beneAddress5; BeneAddress5) { }
            column(balAccountNo; "Bal. Account No.") { }
            column(entryNo; EntryNo) { }
            column(paymentdetails1; Paymentdetails1) { }
            column(paymentdetails2; Paymentdetails2) { }
            column(paymentdetails3; Paymentdetails3) { }
            column(paymentdetails4; Paymentdetails4) { }
            column(paymentdetails5; Paymentdetails5) { }
            column(paymentdetails6; Paymentdetails6) { }
            column(paymentdetails7; Paymentdetails7) { }
            column(chequeNo; "Cheque No.") { }
            column(postingDate; "Posting Date") { }
            column(micrNumber; MICRNumber) { }
            column(recipientBankIFSCCode; "Recipient Bank IFSC Code") { }
            column(recipientBankName; "Recipient Bank Name") { }
            column(recipientBranchName; "Recipient Branch Name") { }
            column(beneficiaryemailid; Beneficiaryemailid) { }
            column(unitCode; "Unit Code") { }
            column(fileName; "File Name") { }
        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}