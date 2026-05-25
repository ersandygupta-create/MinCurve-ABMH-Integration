report 50034 "Bank Format Non-HDFC"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Bank Format Non-HDFC';
    RDLCLayout = './src/reports/Rpt50034.BankFormatNonHDFC.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(E3HISPayrollStaging; "E3 HIS Payroll Staging")
        {
            DataItemTableView = sorting("Entry No.") where("Salary Hold" = const(false), "IFSC Code" = filter(<> '@*HDFC*'));
            RequestFilterFields = "Bank Account Name";
            column(Bank_Account_No_; "Bank Account No.")
            {
            }
            column(Net_Pay; "Net Pay")
            {
            }
            column(Employee_Name; "Employee Name")
            {
            }
            column(Document_Date; "Document Date")
            {
            }
            column(IFSC_Code; "IFSC Code")
            {
            }
            column(Bank_Account_Name; "Bank Account Name")
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
