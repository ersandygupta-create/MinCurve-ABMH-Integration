report 50033 "Bank Format-HDFC"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Bank Format-HDFC';
    RDLCLayout = './src/reports/Rpt50033.BankFormatHDFCReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(E3HISPayrollStaging; "E3 HIS Payroll Staging")
        {
            DataItemTableView = sorting("Entry No.") where("Salary Hold" = filter(false), "IFSC Code" = filter('@*HDFC*'));
            RequestFilterFields = "Bank Account Name", "Document Date";
            column(Bank_Account_No_; "Bank Account No.")
            {
            }
            column(Net_Pay; "Net Pay")
            {
            }
            column(Narration; Narration)
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        Narration: Text[50];
}
