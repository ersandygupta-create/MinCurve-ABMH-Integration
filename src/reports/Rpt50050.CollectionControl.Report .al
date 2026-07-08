report 50050 "Collection Control Register"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Collection Control Register';

    dataset
    {
        dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Quantity = FILTER(<> 0), "No." = FILTER(<> ''));

            trigger OnAfterGetRecord()
            begin
                SrNo += 1;
                MakeExcelDataBody();
            end;

            trigger OnPreDataItem()
            begin
                SrNo := 0;
                if (StartDate <> 0D) or (EndDate <> 0D) then
                    "Purch. Inv. Line".SetRange("Posting Date", StartDate, EndDate);
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
                        ApplicationArea = All;
                        TableRelation = "E3 HIS GL Accounts Mapping"."Account No." WHERE("Collection Control Account" = CONST(true));
                    }
                    field("From Date"; StartDate)
                    {
                        ApplicationArea = All;
                    }
                    field("To Date"; EndDate)
                    {
                        ApplicationArea = All;
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
        StartDate: Date;
        GL: Code[20];
        EndDate: Date;
        ExcelBuf: Record "Excel Buffer" temporary;
        blnExportToExcel: Boolean;
        SrNo: Integer;

    procedure MakeExcelInfo()
    begin
        MakeExcelDataHeader();
    end;

    local procedure MakeExcelDataHeader()
    var
        i: Integer;
        DateFilterTxt: Text;
    begin
        // --- ROW 1: EMPTY SPACE FOR MARGIN ---
        ExcelBuf.NewRow();

        // --- ROW 2: O.P. JINDAL INSTITUTE OF CANCER & CARDIAC RESEARCH ---
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('O.P. JINDAL INSTITUTE OF CANCER & CARDIAC RESEARCH', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.StartRange();
        for i := 2 to 8 do begin
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        end;
        ExcelBuf.EndRange();


        // --- ROW 3: Collection Control Account Reports ---
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Collection Control Account Reports', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.StartRange();
        for i := 2 to 8 do begin
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        end;
        ExcelBuf.EndRange();


        // --- ROW 4: Dynamic Date Range Text Block ---
        DateFilterTxt := 'From Date: ' + Format(StartDate, 0, '<Day,2>-<Month Text,3>-<Year4>') + ' To Date: ' + Format(EndDate, 0, '<Day,2>-<Month Text,3>-<Year4>');
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(DateFilterTxt, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.StartRange();
        for i := 2 to 8 do begin
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        end;
        ExcelBuf.EndRange();


        // --- ROW 5 & 6: SPACING LINES ---
        ExcelBuf.NewRow();
        ExcelBuf.NewRow();


        // --- ROW 7: MATURED IMAGE HEADERS ---
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('SR. NO.', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('POSTING DATE', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Document No.', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('UTR No.', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Total Collection', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Adjusted Account(₹)', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Balance Amount', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('STATUS', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow();

        // 1. Sr. No & Dates
        ExcelBuf.AddColumn(SrNo, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Purch. Inv. Line"."Posting Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);

        // 2. Document tracking fields
        ExcelBuf.AddColumn("Purch. Inv. Line"."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Purch. Inv. Line"."Receipt No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); // Maps out to UTR area frame

        // 3. Numeric values mapping (Using Line Amount as a sample for compilation validation)
        ExcelBuf.AddColumn("Purch. Inv. Line"."Line Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Purch. Inv. Line"."Line Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(0, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);

        // 4. Status block
        ExcelBuf.AddColumn('Settled', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure CreateExcelbook()
    var
        ExcelFileNameLbl: Label 'CollectionControlRegister_%1', Comment = '%1 = DateTime';
    begin
        ExcelBuf.CreateNewBook('Collection Control');

        // Execute independent merges row-by-row up to Column 8 (Column H)
        ExcelBuf.CreateRange('CompNameHeaderRange');
        ExcelBuf.CreateRange('ReportTitleRange');
        ExcelBuf.CreateRange('DateFilterRange');

        ExcelBuf.WriteSheet('CollectionControl', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo(ExcelFileNameLbl, Format(CurrentDateTime, 0, '<Year4><Month,2><Day,2>_<Hours24><Minutes,2>')));
        ExcelBuf.OpenExcel();
    end;
}