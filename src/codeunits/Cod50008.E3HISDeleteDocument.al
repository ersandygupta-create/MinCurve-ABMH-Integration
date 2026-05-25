codeunit 50008 "E3 HIS Delete Document"
{
    Permissions = tabledata "G/L Entry" = rmd,
    tabledata "Cust. Ledger Entry" = rmd,
    tabledata "Detailed Cust. Ledg. Entry" = rmd,
    tabledata "Vendor Ledger Entry" = rmd,
    tabledata "Detailed Vendor Ledg. Entry" = rmd,
    tabledata "Bank Account Ledger Entry" = rmd;

    trigger OnRun()
    begin

    end;

    procedure ProcessDeleteDocument()
    var
    begin
        DeleteDocument.Reset();
        DeleteDocument.Setrange(Status, DeleteDocument.Status::Approved);
        if DeleteDocument.FindSet() then
            repeat

                CustLedgerEntry.Reset();
                CustLedgerEntry.SetRange("E3 HIS Document Type", DeleteDocument."HIS Document Type");
                CustLedgerEntry.SetRange("Document No.", DeleteDocument."Document No.");
                CustLedgerEntry.SetRange("Posting Date", DeleteDocument."Posting Date");
                if CustLedgerEntry.FindFirst() then
                    Repeat
                        DetailedCustLedgEntry.Reset();
                        DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                        if DetailedCustLedgEntry.FindFirst() then
                            DetailedCustLedgEntry.DeleteAll();

                        CustLedgerEntry.Delete();
                    Until CustLedgerEntry.next() = 0;



                VendorLedgerEntry.Reset();
                VendorLedgerEntry.SetRange("Document No.", DeleteDocument."Document No.");
                VendorLedgerEntry.SetRange("Posting Date", DeleteDocument."Posting Date");
                if VendorLedgerEntry.FindFirst() then
                    Repeat
                        DetailedVendLedgEntry.Reset();
                        DetailedVendLedgEntry.SetRange("Vendor Ledger Entry No.", VendorLedgerEntry."Entry No.");
                        if DetailedVendLedgEntry.FindFirst() then
                            DetailedVendLedgEntry.DeleteAll();

                        VendorLedgerEntry.Delete();
                    until VendorLedgerEntry.Next() = 0;

                BankAccountLedgerEntry.Reset();
                BankAccountLedgerEntry.SetRange("Document No.", DeleteDocument."Document No.");
                BankAccountLedgerEntry.SetRange("Posting Date", DeleteDocument."Posting Date");
                if BankAccountLedgerEntry.FindFirst() then
                    BankAccountLedgerEntry.DeleteAll();


                HISSettlementEntry.Reset();
                HISSettlementEntry.SetRange("HIS Document Type", DeleteDocument."HIS Document Type");
                HISSettlementEntry.SetRange("Document No.", DeleteDocument."Document No.");
                HISSettlementEntry.SetRange("Document Date", DeleteDocument."Posting Date");
                if HISSettlementEntry.FindFirst() then
                    HISSettlementEntry.DeleteAll();

                HISRevenueEntry.Reset();
                HISRevenueEntry.SetRange("HIS Document Type", DeleteDocument."HIS Document Type");
                HISRevenueEntry.SetRange("Document No.", DeleteDocument."Document No.");
                HISRevenueEntry.SetRange("Document Date", DeleteDocument."Posting Date");
                if HISRevenueEntry.FindFirst() then
                    HISRevenueEntry.DeleteAll();


                HISConsumptionEntry.Reset();
                HISConsumptionEntry.SetRange("HIS Document Type", DeleteDocument."HIS Document Type");
                HISConsumptionEntry.SetRange("Document No.", DeleteDocument."Document No.");
                HISConsumptionEntry.SetRange("Posting Date", DeleteDocument."Posting Date");
                if HISConsumptionEntry.FindFirst() then
                    HISConsumptionEntry.DeleteAll();

                HISRevenueHeader.Reset();
                HISRevenueHeader.SetRange("HIS Document Type", DeleteDocument."HIS Document Type");
                HISRevenueHeader.SetRange("Document No.", DeleteDocument."Document No.");
                HISRevenueHeader.SetRange("Posting Date", DeleteDocument."Posting Date");
                if HISRevenueHeader.FindFirst() then begin
                    HISRevenueLine.Reset();
                    HISRevenueLine.SetRange("Document No.", DeleteDocument."Document No.");
                    HISRevenueLine.SetRange(HISRevenueLine."Document Type", HISRevenueHeader."Document Type");
                    HISRevenueLine.SetRange(HISRevenueLine."Record Type", HISRevenueHeader."Record Type");
                    if HISRevenueLine.FindFirst() then
                        HISRevenueLine.DeleteAll();

                    HISRevenueHeader.Delete();
                end;

                GLEntry.Reset();
                GLEntry.SetRange("E3 HIS Document Type", DeleteDocument."HIS Document Type");
                GLEntry.SetRange("Document No.", DeleteDocument."Document No.");
                GLEntry.SetRange("Posting Date", DeleteDocument."Posting Date");
                if GLEntry.FindSet() then
                    repeat
                        DeletedGLEntry.Init();
                        DeletedGLEntry.TransferFields(GLEntry);
                        DeletedGLEntry.Insert();

                        GLEntry.Delete();
                    until GLEntry.Next() = 0;

                DeleteDocumentModify.get(DeleteDocument."Entry No.");
                DeleteDocumentModify.Status := DeleteDocumentModify.Status::Processed;
                DeleteDocumentModify."Processed By" := UserId;
                DeleteDocumentModify."Processed Datetime" := CurrentDateTime;
                DeleteDocumentModify.Modify();


            until DeleteDocument.Next() = 0;
    end;

    procedure ValidateDeleteDocument()
    begin

        DeleteDocument.Reset();
        DeleteDocument.SetRange(Status, DeleteDocument.Status::Error);
        if DeleteDocument.FindSet() then begin
            DeleteDocument.ModifyAll("Error Text", '');
            DeleteDocument.ModifyAll(Status, DeleteDocument.Status::Open);
        end;

        DeleteDocument.Reset();
        DeleteDocument.SetRange(Status, DeleteDocument.Status::Open);
        if DeleteDocument.FindSet() then
            repeat
                blnError := false;
                CustLedgerEntry.Reset();
                CustLedgerEntry.SetRange("E3 HIS Document Type", DeleteDocument."HIS Document Type");
                CustLedgerEntry.SetRange("Document No.", DeleteDocument."Document No.");
                CustLedgerEntry.SetRange("Posting Date", DeleteDocument."Posting Date");
                if CustLedgerEntry.FindSet() then
                    repeat
                        CustLedgerEntry.CalcFields("Original Amount", "Remaining Amount");
                        if CustLedgerEntry."Original Amount" <> CustLedgerEntry."Remaining Amount" then
                            blnError := true
                    until (CustLedgerEntry.Next() = 0) or (blnError = true);

                if blnError then begin
                    DeleteDocumentModify.get(DeleteDocument."Entry No.");
                    DeleteDocumentModify.Status := DeleteDocumentModify.Status::Error;
                    DeleteDocumentModify."Error Text" += 'Customer Ledger already applied. ;';
                    DeleteDocumentModify.Modify();
                end;

                blnError := false;
                VendorLedgerEntry.Reset();
                VendorLedgerEntry.SetRange("Document No.", DeleteDocument."Document No.");
                VendorLedgerEntry.SetRange("Posting Date", DeleteDocument."Posting Date");
                if VendorLedgerEntry.FindSet() then
                    repeat
                        VendorLedgerEntry.CalcFields("Original Amount", "Remaining Amount");
                        if VendorLedgerEntry."Original Amount" <> VendorLedgerEntry."Remaining Amount" then
                            blnError := true
                    until (VendorLedgerEntry.Next() = 0) or (blnError = true);

                if blnError then begin
                    DeleteDocumentModify.get(DeleteDocument."Entry No.");
                    DeleteDocumentModify.Status := DeleteDocumentModify.Status::Error;
                    DeleteDocumentModify."Error Text" += 'Vendor Ledger already applied. ;';
                    DeleteDocumentModify.Modify();
                end;

                BankAccountLedgerEntry.Reset();
                BankAccountLedgerEntry.SetRange("Document No.", DeleteDocument."Document No.");
                BankAccountLedgerEntry.SetRange("Posting Date", DeleteDocument."Posting Date");
                BankAccountLedgerEntry.SetRange(Open, false);
                if BankAccountLedgerEntry.FindFirst() then begin

                    DeleteDocumentModify.get(DeleteDocument."Entry No.");
                    DeleteDocumentModify.Status := DeleteDocumentModify.Status::Error;
                    DeleteDocumentModify."Error Text" += 'Bank Reco already done. ;';
                    DeleteDocumentModify.Modify();
                end;

                DeleteDocumentModify.get(DeleteDocument."Entry No.");
                if DeleteDocumentModify.Status = DeleteDocumentModify.Status::Open THEN
                    DeleteDocumentModify.Status := DeleteDocumentModify.Status::Validated;
                DeleteDocumentModify.Modify();


            until DeleteDocument.Next() = 0;

    end;

    var
        DeleteDocument, DeleteDocumentModify : Record "E3 HIS Delete Document";
        GLEntry: Record "G/L Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        HISSettlementEntry: Record "E3 HIS Settlement Staging";
        HISRevenueEntry: Record "E3 HIS Revenue Staging Table";
        HISConsumptionEntry: Record "E3 HIS Consumption Entries";
        HISRevenueHeader: Record "E3 HIS Revenue Header";
        HISRevenueLine: Record "E3 HIS Revenue Line";
        DeletedGLEntry: Record "E3 Deleted G/L Entry";
        blnError: Boolean;


}
