report 50050 "Collection Control Register"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Collection Control Register';

    dataset
    {
        dataitem(GLEntry; "G/L Entry")
        {
            trigger OnPreDataItem()
            begin
                SrNo := 0;
                if (GL <> '') then
                    GLEntry.SetRange("G/L Account No.", GL)
                else
                    Error('GL Account Can not be blank.');
                if (StartDate <> 0D) or (EndDate <> 0D) then
                    GLEntry.SetRange("Posting Date", StartDate, EndDate);

                GLEntry.SetFilter("Source Code", '%1', 'BANKREC');
            end;

            trigger OnAfterGetRecord()
            begin
                SrNo += 1;

                TotAmount := 0;
                BalAmount := 0;

                if GLEntry."E3 UTR No." <> '' then begin
                    GLEntryRec.Reset();
                    GLEntryRec.SetFilter("Source Code", '<>%1', 'BANKREC');
                    GLEntryRec.SetRange("E3 UTR No.", GLEntry."E3 UTR No.");
                    if GLEntryRec.CalcSums(Amount) then
                        TotAmount := Abs(GLEntryRec.Amount);
                end;

                BalAmount := Abs(GLEntry.Amount) - TotAmount;

                if (BalAmount <= 0) then begin
                    Status := 'Settled';
                    BalAmount := 0;
                end else begin
                    Status := 'Pending';
                end;

                MakeExcelDataBody();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    Caption = 'Filters';
                    field("G/L Account No."; GL)
                    {
                        ToolTip = 'GL Account No';
                        Caption = 'GL Account No';
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            MappingTable: Record "E3 HIS GL Accounts Mapping";
                            MappingListPage: Page "E3 HIS GL Accounts Mapping";
                        begin
                            MappingTable.Reset();
                            MappingTable.SetRange("Collection Control Account", true);

                            MappingListPage.SetTableView(MappingTable);
                            MappingListPage.LookupMode(true);

                            if MappingListPage.RunModal() = Action::LookupOK then begin
                                MappingListPage.GetRecord(MappingTable);
                                GL := MappingTable."Account No.";
                                Text := MappingTable."Account No.";
                                exit(true);
                            end;
                        end;
                    }
                    field("From Date"; StartDate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'From Date';
                        Caption = 'From Date';
                    }
                    field("To Date"; EndDate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'To Date';
                        Caption = 'To Date';
                    }
                }
            }
        }

        trigger OnInit()
        begin
            blnExportToExcel := true;
        end;
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyNameText := CompanyInfo.Name;

        if (StartDate = 0D) and (EndDate = 0D) then
            Error('Please check Date Filter');

        if blnExportToExcel then
            MakeExcelInfo();
    end;

    trigger OnPostReport()
    begin
        if blnExportToExcel then
            CreateExcelbook();
    end;

    var
        GLEntryRec: Record "G/L Entry";
        CompanyInfo: Record "Company Information";
        ExcelBuf: Record "Excel Buffer" temporary;
        StartDate: Date;
        GL: Code[20];
        CompanyNameText: Text[100];
        EndDate: Date;
        TotAmount: Decimal;
        BalAmount: Decimal;
        Status: Text[10];
        blnExportToExcel: Boolean;
        SrNo: Integer;

    procedure MakeExcelInfo()
    begin
        MakeExcelDataHeader();
    end;

    local procedure MakeExcelDataHeader()
    var
        DateFilterTxt: Text;
    begin
        ExcelBuf.NewRow();

        // ROW 2: Header Company Title (Merged 8 columns across via the 2nd parameter)
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(CompanyNameText, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        // We write 7 empty columns to accommodate the merged space natively without crash
        AddEmptyColumns(7);

        // ROW 3: Report Classification Name (Merged 8 columns across)
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Collection Control Account Reports', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        AddEmptyColumns(7);

        // ROW 4: Selected Date Constraint Info (Merged 8 columns across)
        DateFilterTxt := 'From Date: ' + Format(StartDate, 0, '<Day,2>-<Month Text,3>-<Year4>') + ' To Date: ' + Format(EndDate, 0, '<Day,2>-<Month Text,3>-<Year4>');
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(DateFilterTxt, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        AddEmptyColumns(7);

        ExcelBuf.NewRow();
        ExcelBuf.NewRow();

        // ROW 7: Structural Data Headers
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('SR. NO.', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('POSTING DATE', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Document No.', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('UTR No.', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Total Collection (₹)', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Adjusted Account(₹)', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Balance Amount', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('STATUS', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow();

        ExcelBuf.AddColumn(SrNo, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Format(GLEntry."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(GLEntry."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(GLEntry."E3 UTR No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(Abs(GLEntry.Amount), false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotAmount, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(BalAmount, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);

        ExcelBuf.AddColumn(Status, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
    end;

    local procedure AddEmptyColumns(Count: Integer)
    var
        i: Integer;
    begin
        for i := 1 to Count do
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure CreateExcelbook()
    var
        ExcelFileNameLbl: Label 'CollectionControlRegister_%1', Comment = '%1 = DateTime';
    begin
        ExcelBuf.CreateNewBook('Collection Control');
        ExcelBuf.WriteSheet('CollectionControl', CompanyNameText, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo(ExcelFileNameLbl, Format(CurrentDateTime, 0, '<Year4><Month,2><Day,2>_<Hours24><Minutes,2>')));
        ExcelBuf.OpenExcel();
    end;
}