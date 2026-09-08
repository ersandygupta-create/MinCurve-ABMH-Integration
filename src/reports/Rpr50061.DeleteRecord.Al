report 50061 Delete
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = tabledata "Purch. Rcpt. Header" = Rimd;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            trigger OnPreDataItem()
            begin
                SetFilter("No.", 'ABHSTR00627GR1926');
            end;

            trigger OnAfterGetRecord()
            begin

                "Purch. Rcpt. Header".Delete();
                Message(format('Record deleted.'));

            end;
        }

    }

}