xmlport 50030 "Vendor Payment Report_N"
{
    Direction = Export;
    FieldDelimiter = '<None>';
    FieldSeparator = '|';
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                RequestFilterFields = "Cheque No.";
                XmlName = 'import';
                SourceTableView = SORTING("Entry No.")
                                  WHERE("Bal. Account Type" = FILTER(2),
                                        "Cheque No." = FILTER(<> ''));
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
                    // "Bank Account Ledger Entry".RESET;
                    // "Bank Account Ledger Entry".SETRANGE("Posting Date",StartDate,EndDate);
                    IF ChequeNo <> '' THEN
                        "Bank Account Ledger Entry".SETRANGE("Bank Account Ledger Entry"."Cheque No.", ChequeNo);
                    // IF "Bank Account Ledger Entry".FINDFIRST THEN BEGIN
                    VendorAmount := '';
                    BankAccountLedgerEntry.RESET;
                    BankAccountLedgerEntry.SETRANGE("Posting Date", StartDate, EndDate);
                    BankAccountLedgerEntry.SETRANGE("Bal. Account Type", BankAccountLedgerEntry."Bal. Account Type"::Vendor);
                    BankAccountLedgerEntry.SETRANGE("Bal. Account No.", "Bank Account Ledger Entry"."Bal. Account No.");
                    BankAccountLedgerEntry.SETRANGE("Cheque No.", "Bank Account Ledger Entry"."Cheque No."); //jyoti sancheti
                    BankAccountLedgerEntry.CALCSUMS("Amount (LCY)");
                    VendorAmount := FORMAT(ROUND(ABS(BankAccountLedgerEntry."Amount (LCY)"), 1, '<'), 0, 1) + '00';

                    BenificiaryName := '';
                    BankAccNo := '';
                    IFSCCode := '';
                    BankAdd := '';
                    BankCity := '';
                    VendorName := '';
                    VendMobile := '';
                    VendorBankAccount.RESET;
                    VendorBankAccount.SETRANGE("Vendor No.", "Bank Account Ledger Entry"."Bal. Account No.");
                    IF VendorBankAccount.FINDLAST THEN BEGIN
                        BenificiaryName := VendorBankAccount.Name;
                        BankAccNo := VendorBankAccount."Bank Account No.";
                        IFSCCode := VendorBankAccount."E3 IFSC Code";
                        BankAdd := VendorBankAccount.Address + ' ' + VendorBankAccount."Address 2";
                        BankCity := VendorBankAccount.City;
                        VendorName := VendorBankAccount.Name;
                        VendMobile := VendorBankAccount."Phone No." + '|';
                    END;


                    VendEmail := '';
                    Vendor.RESET;
                    Vendor.SETRANGE("No.", "Bank Account Ledger Entry"."Bal. Account No.");
                    IF Vendor.FINDFIRST THEN BEGIN
                        VendEmail := FORMAT(1);// Vendor."E-Mail";
                    END;
                    //END;
                    txtCompanyName := UnitName;
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
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                    ApplicationArea = All;
                }
                field(EndDate; EndDate)
                {
                    Caption = 'End Date';
                    ApplicationArea = All;
                }
                field(UnitName; UnitName)
                {
                    Caption = 'Unit Name';
                    ApplicationArea = All;
                }
                field(BankAccountCode; BankAccountCode)
                {
                    Caption = 'Bank Account';
                    ApplicationArea = all;
                    TableRelation = "Bank Account"."No.";

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        BankAccountList: Page "Bank Account List";
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
            }
        }

        trigger OnInit()
        begin
            CompanyInformation.GET;
            //txtCompanyName := 'Sandeep';//UnitName;//CompanyInformation.Name;
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
        BankAccountLedgerEntry: Record 271;
        ChequeNo: Text;
        UnitName: Text[60];
}

