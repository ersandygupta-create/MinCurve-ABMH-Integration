report 50038 "E3 UTR No. Update"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;
    ProcessingOnly = true;
    Permissions = tabledata 271 = RIDM;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            column(Cheque_Date; "Cheque Date")
            { }
            trigger OnAfterGetRecord()
            begin
                if ("Bank Account Ledger Entry"."EDC UTR No." <> '') then begin
                    "Bank Account Ledger Entry"."E3 UTR No." := "Bank Account Ledger Entry"."EDC UTR No.";
                    "Bank Account Ledger Entry".Modify(true);
                end
                else
                    if "Bank Account Ledger Entry"."Cheque No." <> '' then begin
                        "Bank Account Ledger Entry"."E3 UTR No." := "Bank Account Ledger Entry"."Cheque No.";
                        "Bank Account Ledger Entry".Modify(true);
                    end;

            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
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
            area(processing)
            {

            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = Excel;
            LayoutFile = 'mySpreadsheet.xlsx';
        }
    }

    var
        BALE: Record "Bank Account Ledger Entry";
}