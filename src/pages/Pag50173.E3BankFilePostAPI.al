page 50173 "E3 Update Bank UTR No. API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindCurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = '3eBankUTRupdateAPI';
    DelayedInsert = true;
    EntityName = 'bankUTRUpdate';
    EntitySetName = 'bankUTRUpdate';
    PageType = API;
    SourceTable = "E3 Bank Integration";
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(recordIdentifier; Rec."Record Identifier")
                {
                    Caption = 'Record Identifier';
                }
                field(paymentIndicator; Rec."Payment Indicator")
                {
                    Caption = 'Payment Indicator';
                }
                field(sapDocumentNumber; Rec."SAP Document Number")
                {
                    Caption = 'SAP Document Number';
                }
                field(vendorBeneficiaryCode; Rec."Vendor / Beneficiary Code")
                {
                    Caption = 'Vendor / Beneficiary Code';
                }
                field(nameOfBeneficiary; Rec."Name of Beneficiary")
                {
                    Caption = 'Name of Beneficiary';
                }
                field(instrumentAmount; Rec."Instrument Amount")
                {
                    Caption = 'Instrument Amount';
                }
                field(paymentDate; Rec."Payment Date")
                {
                    Caption = 'Payment Date';
                }
                field(chequeNumber; Rec."Cheque Number")
                {
                    Caption = 'Cheque Number';
                }
                field(debitAccountNo; Rec."Debit Account No.")
                {
                    Caption = 'Debit Account No.';
                }
                field(beneficiaryBankAccountNo; Rec."Beneficiary Bank A/c No")
                {
                    Caption = 'Beneficiary Bank A/c No';
                }
                field(ifscCode; Rec."IFSC Code")
                {
                    Caption = 'IFSC Code';
                }
                field(beneficiaryBankName; Rec."Beneficiary Bank Name")
                {
                    Caption = 'Beneficiary Bank Name';
                }
                field(beneficiaryAdd1; Rec."Beneficiary Add1")
                {
                    Caption = 'Beneficiary Add1';
                }
                field(beneficiaryAdd2; Rec."Beneficiary Add 2")
                {
                    Caption = 'Beneficiary Add 2';
                }
                field(beneficiaryAdd3; Rec."Beneficiary Add 3")
                {
                    Caption = 'Beneficiary Add 3';
                }
                field(beneficiaryAdd4; Rec."Beneficiary Add 4")
                {
                    Caption = 'Beneficiary Add 4';
                }
                field(beneficiaryZip; Rec."Beneficiary Zip")
                {
                    Caption = 'Beneficiary Zip';
                }
                field(debitNarration; Rec."Debit Narration")
                {
                    Caption = 'Debit Narration';
                }
                field(printLocation; Rec."Print Location")
                {
                    Caption = 'Print Location';
                }
                field(payableLocation; Rec."Payable Location")
                {
                    Caption = 'Payable Location';
                }
                field(fiscalYear; Rec."Fiscal Year")
                {
                    Caption = 'Fiscal Year';
                }
                field(companyCode; Rec."Company Code")
                {
                    Caption = 'Company Code';
                }
                field(emailID; Rec."Email ID")
                {
                    Caption = 'Email ID';
                }
                field(mobileNumber; Rec."Mobile Number")
                {
                    Caption = 'Mobile Number';
                }
                field(aadharNumber; Rec."AADHAR Number")
                {
                    Caption = 'AADHAR Number';
                }
                field(beneLEINumber; Rec."Bene LEI Number")
                {
                    Caption = 'Bene LEI Number';
                }
                field(beneLEIExpiryDate; Rec."Bene LEI Expiry Date")
                {
                    Caption = 'Bene LEI Expiry Date';
                }
                field(duplicateValidationField; Rec."Duplicate Validation Field")
                {
                    Caption = 'Duplicate Validation Field';
                }
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        Message('Record %1 has been updated.', Rec.EntryNo);
        exit(true);
    end;
}