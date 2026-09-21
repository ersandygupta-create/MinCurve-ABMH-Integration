report 50062 "E3 Update Bank Ledger Entry"
{
    Caption = 'Update UTR Number in Bank Ledger Entry from Excel';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;
    Permissions = tabledata "Bank Account Ledger Entry" = m,
                  tabledata "G/L Entry" = m;

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
        BankAccLedgerEntry: Record "Bank Account Ledger Entry";
        GLEntry: Record "G/L Entry";
        RowNo: Integer;
        MaxRowNo: Integer;
        DocumentNo: Code[20];
        NewValue: Code[35];
        UpdatedCount: Integer;
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
            DocumentNo := CopyStr(GetTextCellValue(RowNo, 1), 1, MaxStrLen(DocumentNo)); // Column A: Document No.
            NewValue := CopyStr(GetTextCellValue(RowNo, 2), 1, MaxStrLen(NewValue));     // Column B: New UTR Value

            if DocumentNo <> '' then begin

                // --- 1. UPDATE BANK ACCOUNT LEDGER ENTRY ---
                BankAccLedgerEntry.Reset();
                BankAccLedgerEntry.SetRange("Document No.", DocumentNo);
                if BankAccLedgerEntry.FindSet() then begin
                    repeat
                        BankAccLedgerEntry."E3 UTR No." := NewValue;
                        BankAccLedgerEntry.Modify(false);
                    until BankAccLedgerEntry.Next() = 0;

                    UpdatedCount += 1;
                end;

                // --- 2. UPDATE G/L ENTRY ---
                GLEntry.Reset();
                GLEntry.SetRange("Document No.", DocumentNo);
                if GLEntry.FindSet() then
                    repeat
                        GLEntry."E3 UTR No." := NewValue;
                        GLEntry.Modify(false);
                    until GLEntry.Next() = 0;

            end;
        end;

        Message('%1 Bank Account Ledger Entry document group(s) updated successfully.', UpdatedCount);
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