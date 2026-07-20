report 50061 DeleteDcle
{
    UsageCategory = ReportsAndAnalysis;
    // ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Delete DCLE';
    Permissions = TableData "Cust. Ledger Entry" = RIMD,
                  TableData "Detailed Cust. Ledg. Entry" = RIMD;


    dataset
    {
        dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")

        {
            trigger OnPreDataItem()
            begin
                SetRange("Entry Type", "Detailed Cust. Ledg. Entry"."Entry Type"::Application);
                SetRange("Customer No.", '9');
            end;

            trigger OnAfterGetRecord()
            begin
                // "Detailed Cust. Ledg. Entry".DeleteAll();
            end;

        }
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            trigger OnPreDataItem()
            begin
                SetRange("Customer No.", '9');
                SetRange("Document No.", '27RC001');

            end;

            trigger OnAfterGetRecord()
            begin
                "Cust. Ledger Entry".Open := true;
                "Cust. Ledger Entry"."External Document No." := '27RC001';
                //  "Cust. Ledger Entry".Modify();
            end;
        }
        dataitem(CLE; "Cust. Ledger Entry")
        {
            trigger OnPreDataItem()
            begin
                SetRange("Customer No.", '9');
                // SetFilter(Amount, '< 0');
                SetFilter("External Document No.", '<>%1', "Document No.");

            end;

            trigger OnAfterGetRecord()
            begin
                //   Cle.Delete();
            end;
        }
    }

}