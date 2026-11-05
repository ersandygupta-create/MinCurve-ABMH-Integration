report 50066 "E3 Update GL Entry"
{
    Caption = 'Update UHID and HIS Document Type GL Entry from Excel';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;
    Permissions = tabledata "G/L Entry" = m;

    dataset
    {
    }

    requestpage
    {
        layout
        {
            area(content)
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        ImportAndProcessExcel();
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
        InStream: InStream;
        FileName: Text;
        SheetName: Text;

    local procedure ImportAndProcessExcel()
    var
        GLEntry: Record "G/L Entry";
        RowNo: Integer;
        MaxRowNo: Integer;
        EntryNo: Integer;
        UHIVal: Code[50];
        HISDocTypeVal: Code[30];
        UpdatedCount: Integer;
        PatientName: Text[100];
    begin
        // 1. Upload File
        if not UploadIntoStream('Select Excel File', '', 'Excel Files (*.xlsx)|*.xlsx', FileName, InStream) then
            exit;

        // 2. Get Sheet Name (Cloud / SaaS Compatible)
        TempExcelBuffer.GetSheetsNameListFromStream(InStream, TempNameValueBuffer);
        if TempNameValueBuffer.FindFirst() then
            SheetName := TempNameValueBuffer.Value
        else
            Error('No sheets found in the selected Excel file.');

        // 3. Load Excel Data into Temporary Excel Buffer
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(InStream, SheetName);
        TempExcelBuffer.ReadSheet();

        // 4. Find Max Rows
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then
            MaxRowNo := TempExcelBuffer."Row No.";

        // 5. Loop rows (skipping header at Row 1)
        for RowNo := 2 to MaxRowNo do begin
            EntryNo := GetIntegerCellValue(RowNo, 1);                                     // Column A: Entry No.
            UHIVal := CopyStr(GetTextCellValue(RowNo, 2), 1, MaxStrLen(GLEntry."E3 UHID"));      // Column B: UHI
            HISDocTypeVal := CopyStr(GetTextCellValue(RowNo, 3), 1, MaxStrLen(GLEntry."E3 HIS Document Type")); // Column C: HIS Document Type
            PatientName := CopyStr(GetTextCellValue(RowNo, 4), 1, MaxStrLen(GLEntry."E3 HIS Document Type"));
            if (EntryNo <> 0) and GLEntry.Get(EntryNo) then begin
                GLEntry."E3 UHID" := UHIVal;
                GLEntry."E3 HIS Document Type" := HISDocTypeVal;
                GLEntry."E3 Patient Name" := PatientName;
                GLEntry.Modify(false);
                UpdatedCount += 1;
            end;
        end;

        Message('%1 G/L Entry record(s) updated successfully.', UpdatedCount);
    end;

    local procedure GetTextCellValue(RowNo: Integer; ColNo: Integer): Text
    begin
        if TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text");
        exit('');
    end;

    local procedure GetIntegerCellValue(RowNo: Integer; ColNo: Integer): Integer
    var
        Result: Integer;
    begin
        if TempExcelBuffer.Get(RowNo, ColNo) then
            if Evaluate(Result, TempExcelBuffer."Cell Value as Text") then
                exit(Result);
        exit(0);
    end;
}