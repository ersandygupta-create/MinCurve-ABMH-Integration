xmlport 50029 "Vendor Payment Report"
{
    Direction = Export;
    FieldDelimiter = '<None>';
    FieldSeparator = '|';
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Table25; 25)
            {
                XmlName = 'import';
                textelement(VendorAmount)
                {
                }
                textelement(ComBankAccNo)
                {
                }
                textelement(BankAccNo)
                {
                }
                textelement(VendorName)
                {
                }
                textelement(BankCity)
                {
                }
                textelement(txtCompanyName)
                {
                }
                textelement(IFSCCode)
                {
                }
                textelement(VendEmail)
                {
                }
                textelement(VendMobile)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "Vendor Ledger Entry".CALCFIELDS("Vendor Ledger Entry"."Amount (LCY)");
                    VendorAmount := FORMAT(ROUND(ABS("Vendor Ledger Entry"."Amount (LCY)"), 1, '<'), 0, 1) + '00';

                    BenificiaryName := '';
                    BankAccNo := '';
                    IFSCCode := '';
                    BankAdd := '';
                    BankCity := '';

                    VendorBankAccount.RESET;
                    VendorBankAccount.SETRANGE("Vendor No.", "Vendor Ledger Entry"."Vendor No.");
                    IF VendorBankAccount.FINDLAST THEN BEGIN
                        BenificiaryName := VendorBankAccount.Name;
                        BankAccNo := VendorBankAccount."Bank Account No.";
                        IFSCCode := VendorBankAccount."E3 IFSC Code";
                        BankAdd := VendorBankAccount.Address + ' ' + VendorBankAccount."Address 2";
                        BankCity := VendorBankAccount.City;
                    END;

                    VendMobile := '';
                    VendEmail := '';
                    VendorName := '';
                    Vendor.RESET;
                    Vendor.SETRANGE("No.", "Vendor Ledger Entry"."Vendor No.");
                    IF Vendor.FINDFIRST THEN BEGIN
                        VendorName := Vendor.Name;
                        VendMobile := COPYSTR(Vendor."Phone No.", 1, 10);
                        VendEmail := FORMAT(1);// Vendor."E-Mail";
                    END;
                end;

                trigger OnPreXmlItem()
                begin
                    "Vendor Ledger Entry".SETRANGE("Posting Date", StartDate, EndDate);
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                    Caption = 'Start Date';
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                    Caption = 'End Date';
                }
                field("Bank Account Code"; BankAccountCode)
                {
                    TableRelation = "Bank Account"."No.";
                    ToolTip = 'Specifies the value of the Bank Account Code field.';
                    Caption = 'Bank Account Code';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        BankAccountList: Page 371;
                    begin
                        BankAccount.RESET;
                        BankAccount.SETFILTER(BankAccount."No.", BankAccountCode);
                        IF BankAccount.FINDFIRST THEN BEGIN
                            BankAccountList.LOOKUPMODE(TRUE);
                            BankAccountList.SETTABLEVIEW(BankAccount);
                            IF BankAccountList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                BankAccountList.GETRECORD(BankAccount);
                                BankAccountCode := BankAccount."No.";
                                ComBankAccNo := BankAccount."Bank Account No.";
                                BankAccountName := BankAccount.Name;
                            END;
                        END;
                    end;
                }
                field("Bank Account No."; ComBankAccNo)
                {
                    ToolTip = 'Specifies the value of the Bank Account No. field.';
                    Caption = 'Bank Account No.';
                    ApplicationArea = All;
                }
                field("Bank Account Name"; BankAccountName)
                {
                    ToolTip = 'Specifies the value of the Bank Account Name field.';
                    Caption = 'Bank Account Name';
                    ApplicationArea = All;
                }
                field("Company Name"; txtCompanyName)
                {
                    ToolTip = 'Specifies the value of the Company Name field.';
                    Caption = 'Company Name';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            CompanyInformation.GET;
            txtCompanyName := CompanyInformation.Name;
        end;
    }

    trigger OnPreXmlPort()
    begin
        CompanyInformation.GET;
    end;

    var
        CompanyInformation: Record 79;
        BankAccount: Record 270;
        StartDate: Date;
        EndDate: Date;
        BankAccountName: Text;
        VendorBankAccount: Record 288;
        BenificiaryName: Text[50];
        Vendor: Record 23;
        BankAccountCode: Text;
        BankAdd: Text;
        "Vendor Ledger Entry": Record "Vendor Ledger Entry";
}

