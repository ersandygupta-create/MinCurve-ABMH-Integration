report 50053 "Bank Pay Letter"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Bank Pay Letter';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50053.BankPayLetter.rdl';

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.");

            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Document No.";

            column(Description; Description)
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(IFSCCode; IFSCCode)
            {
            }
            column(BankName; BankName)
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(AccountNo; "Account No.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(BalAccountNo; "Bal. Account No.")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(ChequeNo; "Cheque No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                Clear(BankAccountNo);
                Clear(IFSCCode);
                Clear(BankName);

                // Account No. contains Vendor No.
                if "Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::Vendor then begin
                    if Vendor.Get("Gen. Journal Line"."Account No.") then begin
                        if Vendor."Preferred Bank Account Code" <> '' then
                            if VendorBankAccount.Get(Vendor."No.", Vendor."Preferred Bank Account Code") then begin
                                BankAccountNo := VendorBankAccount."Bank Account No.";
                                IFSCCode := VendorBankAccount."E3 IFSC Code";
                                BankName := VendorBankAccount.Name;
                            end;
                    end;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                }
            }
        }

        actions
        {
        }
    }
    var
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        BankAccountNo: Code[50];
        IFSCCode: Code[20];
        BankName: Text[100];
}