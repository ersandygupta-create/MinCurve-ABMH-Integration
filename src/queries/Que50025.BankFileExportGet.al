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
            column(recordIdentifier; "Record Identifier") { }
            column(paymentIndicator; "Payment Indicator") { }
            column(sapDocumentNumber; "SAP Document Number") { }
            column(vendorBeneficiaryCode; "Vendor / Beneficiary Code") { }
            column(nameOfBeneficiary; "Name of Beneficiary") { }
            column(instrumentAmount; "Instrument Amount") { }
            column(paymentDate; "Payment Date") { }
            column(chequeNumber; "Cheque Number") { }
            column(debitAccountNo; "Debit Account No.") { }
            column(beneficiaryBankAccountNo; "Beneficiary Bank A/c No") { }
            column(ifscCode; "IFSC Code") { }
            column(beneficiaryBankName; "Beneficiary Bank Name") { }
            column(beneficiaryAdd1; "Beneficiary Add1") { }
            column(beneficiaryAdd2; "Beneficiary Add 2") { }
            column(beneficiaryAdd3; "Beneficiary Add 3") { }
            column(beneficiaryAdd4; "Beneficiary Add 4") { }
            column(beneficiaryZip; "Beneficiary Zip") { }
            column(debitNarration; "Debit Narration") { }
            column(printLocation; "Print Location") { }
            column(payableLocation; "Payable Location") { }
            column(fiscalYear; "Fiscal Year") { }
            column(companyCode; "Company Code") { }
            column(emailID; "Email ID") { }
            column(mobileNumber; "Mobile Number") { }
            column(aadharNumber; "AADHAR Number") { }
            column(beneLEINumber; "Bene LEI Number") { }
            column(beneLEIExpiryDate; "Bene LEI Expiry Date") { }
            column(duplicateValidationField; "Duplicate Validation Field") { }
        }
    }

    trigger OnBeforeOpen()
    begin
    end;
}