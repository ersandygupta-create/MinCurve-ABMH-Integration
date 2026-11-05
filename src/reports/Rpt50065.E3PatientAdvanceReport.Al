
report 50065 "E3 Patient UHID Excel Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Export UHID Financial Summary to Excel';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            trigger OnAfterGetRecord()
            begin
                GenerateExcelReport();
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
                    Caption = 'Filters';
                    field(FilterUHID; ReqUHID)
                    {
                        ApplicationArea = All;
                        Caption = 'UHID (Leave blank for all)';
                    }
                    field(FilterDate; ReqDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Balance as on Date';
                    }
                }
            }
        }
    }

    var
        ReqUHID: Code[20];
        ReqDate: Date;
        ExcelBuf: Record "Excel Buffer" temporary;
        RowNo: Integer;

    local procedure GenerateExcelReport()
    begin
        ExcelBuf.Reset();
        ExcelBuf.DeleteAll();

        RowNo := 1;
        WriteHeader();
        WriteData();

        ExcelBuf.CreateNewBook('Patient Advance Report');
        ExcelBuf.WriteSheet('UHID Summary', CompanyName(), UserId());
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
    end;

    local procedure WriteHeader()
    begin
        // Row 1: Report Title (IsFormula = false)
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Patient Advance Report', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);

        // Row 2: Balance as on Date (IsFormula = false)
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Balance as on : ' + Format(ReqDate, 0, '<Day,2>-<Month,2>-<Year,2>'), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);

        // Row 3: Blank spacing row
        ExcelBuf.NewRow();

        // Row 4: Category Super Headers (IsFormula = false)
        // ExcelBuf.NewRow();
        // ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        // ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        // ExcelBuf.AddColumn('Advance', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        // ExcelBuf.AddColumn('Refund', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        // ExcelBuf.AddColumn('Settlement', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        // ExcelBuf.AddColumn('Refund Settlement', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);

        // Row 5: Detailed Column Headers (IsFormula = false)
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('UHID', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('PATIENT NAME', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('ADVANCE AMOUNT (₹)', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('REFUND AMOUNT (₹)', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('ADVANCE SETTLEMENT AMOUNT (₹)', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('REFUND SETTLEMENT AMOUNT (₹)', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('BALANCE DEPOSIT (₹)', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('STATUS', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
    end;

    local procedure WriteData()
    var
        GLEntry: Record "G/L Entry";
        MappingTable: Record "HIS Payment Document Mapping";
        TempBuffer: Record "HIS Report Buffer" temporary;
        Balance: Decimal;
    begin
        // 1. Gather and aggregate G.L. Entries into a temporary buffer table
        GLEntry.SetRange("G/L Account No.", '1030304007');
        if ReqDate <> 0D then
            GLEntry.SetFilter("Posting Date", '%1..%2', 0D, ReqDate);
        if ReqUHID <> '' then
            GLEntry.SetRange("E3 UHID", ReqUHID);

        if GLEntry.FindSet() then
            repeat
                MappingTable.SetRange("HIS Document Type", GLEntry."E3 HIS Document Type");
                if MappingTable.FindFirst() then begin
                    TempBuffer.UHID := GLEntry."E3 UHID";
                    if TempBuffer.UHID <> '' then begin
                        if not TempBuffer.Get(TempBuffer.UHID) then begin
                            TempBuffer.Init();
                            TempBuffer."Patient Name" := GLEntry."E3 Patient Name";
                            TempBuffer.Insert();
                        end;

                        case MappingTable."Payment Type" of
                            MappingTable."Payment Type"::Advance:
                                TempBuffer."Advance Amount" += GLEntry.Amount;
                            MappingTable."Payment Type"::Refund:
                                TempBuffer."Refund Amount" += GLEntry.Amount;
                            MappingTable."Payment Type"::Settlement:
                                TempBuffer."Settlement Amount" += GLEntry.Amount;
                            MappingTable."Payment Type"::"Refund Settlement":
                                TempBuffer."Refund Settlement Amount" += GLEntry.Amount;
                        end;
                        TempBuffer.Modify();
                    end;
                end;
            until GLEntry.Next() = 0;

        // 2. Output the aggregated temporary buffer records to the Excel Buffer starting at Row 6
        TempBuffer.Reset();
        if TempBuffer.FindSet() then
            repeat
                Balance := TempBuffer."Advance Amount" + TempBuffer."Refund Amount" + TempBuffer."Settlement Amount" + TempBuffer."Refund Settlement Amount";

                ExcelBuf.NewRow();
                ExcelBuf.AddColumn(Format(TempBuffer.UHID), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Format(TempBuffer."Patient Name"), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(TempBuffer."Advance Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TempBuffer."Refund Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TempBuffer."Settlement Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TempBuffer."Refund Settlement Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(Balance, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);

                if Balance = 0 then
                    ExcelBuf.AddColumn('Settled', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)
                else
                    ExcelBuf.AddColumn('Pending', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            until TempBuffer.Next() = 0;
    end;

    local procedure GetPatientName(UHIDVal: Code[20]): Text[100]
    begin
        // Add your patient master lookup logic here
        exit('Patient Name');
    end;
}