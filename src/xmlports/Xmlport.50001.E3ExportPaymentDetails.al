xmlport 50001 "Bank Payment Export"
{
    Direction = Export;
    Format = VariableText;
    FieldDelimiter = '<None>';
    FieldSeparator = ',';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                XmlName = 'Export';
                SourceTableView = where("Bank Integration" = filter(true));

                textelement(ImpTy) { }
                textelement(VendorCode) { }
                textelement(BeneficiaryAccountNumber) { }
                textelement(Amt) { }
                textelement(BeneficiaryName) { }
                textelement(DraweeLocation) { }
                textelement(PrintLocation) { }
                textelement(BeneAddress1) { }
                textelement(BeneAddress2) { }
                textelement(BeneAddress3) { }
                textelement(BeneAddress4) { }
                textelement(BeneAddress5) { }
                textelement(InstructionReferenceNumber) { }
                textelement(CustomerReferenceNumber) { }
                textelement(Paymentdetails1) { }
                textelement(Paymentdetails2) { }
                textelement(Paymentdetails3) { }
                textelement(Paymentdetails4) { }
                textelement(Paymentdetails5) { }
                textelement(Paymentdetails6) { }
                textelement(Paymentdetails7) { }
                textelement(ChequeNumber) { }
                textelement(ChqTrnDate) { }
                textelement(MICRNumber) { }
                textelement(IFCCode) { }
                textelement(BeneBankName) { }
                textelement(BeneBankBranchName) { }
                textelement(Beneficiaryemailid) { }

                trigger OnAfterGetRecord()
                var
                    VendorBank: Record "Vendor Bank Account";
                    Vendor: Record Vendor;
                    IFSCFirstChar: Text[1];
                begin
                    ImpTy := '';
                    VendorCode := "Gen. Journal Line"."Account No.";
                    Amt := Format("Gen. Journal Line".Amount);
                    BeneficiaryName := CopyStr("Gen. Journal Line".Description, 1, 40);
                    DraweeLocation := '';
                    PrintLocation := '';
                    BeneAddress3 := '';
                    BeneAddress4 := '';
                    BeneAddress5 := '';
                    InstructionReferenceNumber := '';
                    CustomerReferenceNumber := '';
                    Paymentdetails1 := '';
                    Paymentdetails2 := '';
                    Paymentdetails3 := '';
                    Paymentdetails4 := '';
                    Paymentdetails5 := '';
                    Paymentdetails6 := '';
                    Paymentdetails7 := '';
                    ChequeNumber := '';
                    ChqTrnDate := Format("Gen. Journal Line"."Posting Date");
                    MICRNumber := '';
                    IFCCode := '';
                    BeneBankName := '';
                    BeneBankBranchName := '';
                    BeneficiaryAccountNumber := '';
                    Beneficiaryemailid := '';
                    BeneAddress1 := '';
                    BeneAddress2 := '';

                    // ✅ Get Vendor Bank Account info
                    if ("Gen. Journal Line"."Recipient Bank Account" <> '') then begin
                        if VendorBank.Get("Gen. Journal Line"."Account No.", "Gen. Journal Line"."Recipient Bank Account") then //begin
                            BeneBankName := VendorBank.Name;
                        BeneBankBranchName := VendorBank."Bank Branch No.";
                        BeneficiaryAccountNumber := VendorBank."Bank Account No.";
                        IFCCode := VendorBank."Bank Clearing Code";

                        if IFCCode <> '' then
                            ImpTy := CopyStr(IFCCode, 1, 1)
                        else
                            ImpTy := '';
                    end;


                    // ✅ Get Vendor details
                    if Vendor.Get("Gen. Journal Line"."Account No.") then begin
                        BeneAddress1 := Vendor.Address;
                        BeneAddress2 := Vendor."Address 2";
                        Beneficiaryemailid := Vendor."E-Mail";
                    end;
                end;

            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
            }
        }

        trigger OnInit()
        begin
            CompanyInformation.Get;
        end;
    }

    trigger OnPreXmlPort()
    begin
        CompanyInformation.Get;
    end;

    var
        CompanyInformation: Record "Company Information";
}
