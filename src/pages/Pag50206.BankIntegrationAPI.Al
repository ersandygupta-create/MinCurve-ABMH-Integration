page 50206 "E3 Bank Integration API Page"
{
    PageType = API;
    SourceTable = "E3 Bank Integration";
    Permissions = tabledata "E3 Bank Integration" = RIMD;
    APIPublisher = 'mindcurve';
    APIGroup = 'bank';
    APIVersion = 'v2.0';
    Caption = 'Bank Integration API';

    EntityName = 'bankIntegrationFile';
    EntitySetName = 'bankIntegrationFiles';

    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field(recordIdentifier; Rec."Record Identifier")
                {
                }
                field(paymentIndicator; Rec."Payment Indicator")
                {

                }
                field(documentNo; Rec."Document No.")
                {

                }
                field(balAccountNo; Rec."Bal. Account No.")
                {

                }
                field(beneficiaryName; Rec.BeneficiaryName)
                {

                }
                field(amount; Rec.Aamount)
                {

                }
                field(postingDate; Rec."Posting Date")
                {

                }
                field(chequeNo; Rec."Cheque No.")
                {

                }
                field(bankAccountNo; Rec."Bank Account No.")
                {

                }
                field(recipientBankAccount; Rec."Recipient Bank Account")
                {

                }
                field(recipientBankIFSCCode; Rec."Recipient Bank IFSC Code")
                {

                }
                field(recipientBankName; Rec."Recipient Bank Name")
                {

                }
                field(beneficiaryAdd1; Rec."Beneficiary Add1")
                { }
                field(beneficiaryAdd2; Rec."Beneficiary Add 2")
                { }
                field(beneficiaryAdd3; Rec."Beneficiary Add 3")
                {

                }
                field(beneficiaryAdd4; Rec."Beneficiary Add 4")
                {

                }
                field(beneficiaryZip; Rec."Beneficiary Zip")
                {

                }
                field(debitNarration; Rec."Debit Narration")
                {

                }
                field(printLocation; Rec."Print Location")
                { }
                field(payableLocation; Rec."Payable Location")
                { }
                field(fiscalYear; Rec."Fiscal Year")
                { }
                field(companyCode; Rec."Company Code")
                { }
                field(emailID; Rec."Email ID")
                { }
                field(mobileNumber; Rec."Mobile Number")
                { }
                field(aADHARNumber; Rec."AADHAR Number")
                { }
                field(beneLEINumber; Rec."Bene LEI Number")
                { }
                field(beneLEIExpiryDate; Rec."Bene LEI Expiry Date")
                { }
                field(duplicateValidationField; Rec."Duplicate Validation Field")
                {

                }
            }
        }
    }


}