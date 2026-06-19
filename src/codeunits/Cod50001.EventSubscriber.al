codeunit 50001 "E3 HIS Event Subscriber"
{

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure InsertHISFieldGLEntries(GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry");
    begin
        GLEntry."E3 Narration" := GenJournalLine."E3 Narration";
        GLEntry."E3 UTR No." := GenJournalLine."E3 UTR No.";
        GLEntry."E3 HIS Module" := GenJournalLine."E3 HIS Module";
        GLEntry."E3 HIS Document Type" := GenJournalLine."E3 HIS Document Type";
        GLEntry."E3 Store Code" := GenJournalLine."E3 Store Code";
        GLEntry."E3 Sub Group Code" := GenJournalLine."E3 Sub Group Code";
        GLEntry."E3 Receipt No." := GenJournalLine."E3 Receipt No.";
        GLEntry."E3 UHID" := GenJournalLine."E3 UHID";
        GLEntry."E3 Patient Name" := GenJournalLine."E3 Patient Name";
        GLEntry."E3 Validation Key" := GenJournalLine."E3 Validation Key";
        GLEntry."E3 Transaction Type" := GenJournalLine."E3 Transaction Type";
        GLEntry."E3 Encounter No." := GenJournalLine."E3 Encounter No.";
        GLEntry."E3 Doctor Name" := GenJournalLine."E3 Doctor Name";
        GLEntry."E3 Speciality" := GenJournalLine."E3 Speciality";
        GLEntry."E3 Sponsor Code" := GenJournalLine."E3 Sponsor Code";
        GLEntry."E3 Sponsor Name" := GenJournalLine."E3 Sponsor Name";
        GLEntry."E3 Payer Code" := GenJournalLine."E3 Payer Code";
        GLEntry."E3 Payer Name" := GenJournalLine."E3 Payer Name";
        GLEntry."HIS User Name" := GenJournalLine."HIS User Name";

    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure EDCOnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."E3 HIS Module" := GenJournalLine."E3 HIS Module";
        CustLedgerEntry."E3 HIS Document Type" := GenJournalLine."E3 HIS Document Type";
        CustLedgerEntry."E3 Receipt No." := GenJournalLine."E3 Receipt No.";
        CustLedgerEntry."E3 UHID" := GenJournalLine."E3 UHID";
        CustLedgerEntry."E3 Patient Name" := GenJournalLine."E3 Patient Name";
        CustLedgerEntry."E3 Encounter No." := GenJournalLine."E3 Encounter No.";
        CustLedgerEntry."E3 Doctor Name" := GenJournalLine."E3 Doctor Name";
        CustLedgerEntry."E3 Speciality" := GenJournalLine."E3 Speciality";
        CustLedgerEntry."E3 Sponsor Code" := GenJournalLine."E3 Sponsor Code";
        CustLedgerEntry."E3 Sponsor Name" := GenJournalLine."E3 Sponsor Name";
        CustLedgerEntry."E3 Payer Code" := GenJournalLine."E3 Payer Code";
        CustLedgerEntry."E3 Payer Name" := GenJournalLine."E3 Payer Name";
        CustLedgerEntry."Sales (LCY)" := GenJournalLine."Sales/Purch. (LCY)";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure InsertHISFieldVendLedgerEntries(GenJournalLine: Record "Gen. Journal Line"; var VendorLedgerEntry: Record "Vendor Ledger Entry");
    var
        Vendor: Record "vendor";
    begin
        VendorLedgerEntry."E3 Payment Terms Code" := GenJournalLine."Payment Terms Code";
        VendorLedgerEntry."Purchase Order No." := GenJournalLine."Purchase Order No.";
        VendorLedgerEntry."E3 Receipt No." := GenJournalLine."E3 Receipt No.";
        VendorLedgerEntry."E3 UHID" := GenJournalLine."E3 UHID";
        VendorLedgerEntry."E3 Patient Name" := GenJournalLine."E3 Patient Name";
        VendorLedgerEntry."Bank Integration" := GenJournalLine."Bank Integration";
        IF VendorLedgerEntry."Vendor Name" = '' then begin
            IF GenJournalLine."Account Type" = GenJournalLine."Account Type"::Vendor THEN
                IF Vendor.Get(GenJournalLine."Account No.") then
                    VendorLedgerEntry."Vendor Name" := Vendor.Name;

            IF GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::Vendor THEN
                IF Vendor.Get(GenJournalLine."Bal. Account No.") then
                    VendorLedgerEntry."Vendor Name" := Vendor.Name;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Detailed CV Ledg. Entry Buffer", 'OnAfterCopyFromGenJnlLine', '', true, true)]

    local procedure InsertPONOFieldDetailedVendorLedgEntry(var DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; GenJnlLine: Record "Gen. Journal Line")
    begin
        DtldCVLedgEntryBuffer."Purchase Order No." := GenJnlLine."Purchase Order No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Bank Account Ledger Entry", 'OnAfterCopyFromGenJnlLine', '', true, true)]
    local procedure InsertHISFieldBankLedgerEntries(GenJournalLine: Record "Gen. Journal Line"; var BankAccountLedgerEntry: Record "Bank Account Ledger Entry");
    var
        Customer: Record "Customer Bank Account";
        Vendor: Record "Vendor Bank Account";
        Employee: Record Employee;

    begin
        BankAccountLedgerEntry."E3 UTR No." := GenJournalLine."E3 UTR No.";
        BankAccountLedgerEntry."E3 Narration" := GenJournalLine."E3 Narration";
        if (GenJournalLine."Cheque No." <> '') then
            BankAccountLedgerEntry."E3 UTR No." := GenJournalLine."Cheque No."
        else
            if (GenJournalLine."E3 UTR No." <> '') then
                BankAccountLedgerEntry."E3 UTR No." := GenJournalLine."E3 UTR No.";

        BankAccountLedgerEntry."Bank Integration" := GenJournalLine."Bank Integration";
        case GenJournalLine."Bal. Account Type" of
            "Gen. Journal Account Type"::Customer:
                begin
                    Customer.Reset();
                    Customer.SetRange("Customer No.", GenJournalLine."Bal. Account No.");
                    Customer.SetRange(Code, GenJournalLine."Recipient Bank Account");
                    if Customer.Find('-') then begin
                        BankAccountLedgerEntry."Recipient Bank Name" := Customer.Name;
                        BankAccountLedgerEntry."Recipient Bank Account" := Customer."Bank Account No.";
                        BankAccountLedgerEntry."Recipient Bank IFSC Code" := Customer."Bank Clearing Code";
                        BankAccountLedgerEntry."Recipient Branch Name" := Customer.IBAN;
                    end;
                end;
            "Gen. Journal Account Type"::Vendor:
                begin
                    Vendor.Reset();
                    Vendor.SetRange("vendor No.", GenJournalLine."Bal. Account No.");
                    Vendor.SetRange(Code, GenJournalLine."Recipient Bank Account");
                    if Vendor.Find('-') then begin
                        BankAccountLedgerEntry."Recipient Bank Name" := Vendor.Name;
                        BankAccountLedgerEntry."Recipient Bank Account" := Vendor."Bank Account No.";
                        BankAccountLedgerEntry."Recipient Bank IFSC Code" := Vendor."Bank Clearing Code";
                        BankAccountLedgerEntry."Recipient Branch Name" := Vendor.IBAN;
                    end;

                end;
            "Gen. Journal Account Type"::Employee:
                begin
                    Employee.Reset();
                    Employee.SetRange("No.", GenJournalLine."Bal. Account No.");
                    Employee.SetRange(Employee."Bank Account No.", GenJournalLine."Recipient Bank Account");
                    if Employee.Find('-') then begin
                        BankAccountLedgerEntry."Recipient Bank Account" := Employee."Bank Account No.";
                        BankAccountLedgerEntry."Recipient Bank IFSC Code" := Employee.IBAN;
                    end;
                end;
        end;

    end;

    [EventSubscriber(ObjectType::CodeUnit, codeUnit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', true, true)]
    local procedure ModifyConfimationForPurchaseOrderPosting(PurchaseHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
    begin

        if PurchaseHeader."Posting Date" = 0D then
            Error('Posting Date must be filled before posting the document.');

        if PurchaseHeader."Document Date" > PurchaseHeader."Posting Date" then
            Error('Document Date (%1) cannot be later than Posting Date (%2).', PurchaseHeader."Document Date", PurchaseHeader."Posting Date");

        IF ((PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) or (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Return Order"))
             AND (PurchaseHeader."E3 Item Type" = PurchaseHeader."E3 Item Type"::"Non Pharmacy") then begin
            PurchaseHeader.TestField("Location Code");
            PurchLine.RESET();
            PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchLine.SETRANGE("Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor No.");
            PurchLine.SETRANGE(PurchLine.Type, PurchLine.Type::Item);
            IF PurchLine.FindSet() THEN
                repeat
                    IF PurchLine."Location Code" = '' then
                        Error('You can''t post blank Location Cdoe !');
                    IF (PurchLine."E3 Item Type" = PurchLine."E3 Item Type"::Pharmacy) then
                        Error('You can''t select Pharmacy Item No. %1,Line No. %2,Item Name %3', PurchLine."No.", PurchLine."Line No.", PurchLine.Description);
                until PurchLine.Next() = 0;

        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, OnBeforeOnRename, '', false, false)]
    local procedure OnBeforeOnRenameVendor(xVendor: Record Vendor; var Vendor: Record Vendor; var IsHandled: Boolean)
    begin
        xVendor.CalcFields("E3 Sync Record Exists");
        if xVendor."E3 Sync Record Exists" then
            Error('Record is already synchronized to HIS, rename is not allowed');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Order Address", OnBeforeRenameEvent, '', false, false)]
    local procedure OnBeforeOnRenameOrderAdd(var xRec: Record "Order Address"; var Rec: Record "Order Address"; RunTrigger: Boolean)
    begin
        xRec.CalcFields("E3 Sync Record Exists");
        if xRec."E3 Sync Record Exists" then
            Error('Record is already synchronized to HIS, rename is not allowed');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure EDCOnAfterCopyGenJnlLineFromSalesHeader(var GenJournalLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header")
    begin
        GenJournalLine."E3 HIS Module" := SalesHeader."E3 HIS Module";
        GenJournalLine."E3 HIS Document Type" := SalesHeader."E3 HIS Document Type";
        GenJournalLine."E3 Receipt No." := SalesHeader."E3 Receipt No.";
        GenJournalLine."E3 UHID" := SalesHeader."E3 UHID";
        GenJournalLine."E3 Patient Name" := SalesHeader."E3 Patient Name";
        GenJournalLine."E3 Encounter No." := SalesHeader."E3 Encounter No.";
        GenJournalLine."E3 Doctor Name" := SalesHeader."E3 Doctor Name";
        GenJournalLine."E3 Speciality" := SalesHeader."E3 Speciality";
        GenJournalLine."E3 Sponsor Code" := SalesHeader."E3 Sponsor Code";
        GenJournalLine."E3 Sponsor Name" := SalesHeader."E3 Sponsor Name";
        GenJournalLine."E3 Payer Code" := SalesHeader."E3 Payer Code";
        GenJournalLine."E3 Payer Name" := SalesHeader."E3 Payer Name";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchInvHeaderInsert', '', false, false)]
    local procedure EDCOnAfterPurchInvHeaderInsert(var PurchHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header"; PreviewMode: Boolean)
    var
        GenJnlNarration: Record "Gen. Journal Narration";
        PurchCommentLine: Record "Purch. Comment Line";
    begin
        if PreviewMode then
            exit;

        PurchCommentLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchCommentLine.SetRange("No.", PurchHeader."No.");
        if PurchCommentLine.FindSet() then
            repeat
                GenJnlNarration.Init();
                GenJnlNarration."Journal Template Name" := '';
                GenJnlNarration."Journal Batch Name" := '';
                GenJnlNarration."Document No." := PurchInvHeader."No.";
                GenJnlNarration."Gen. Journal Line No." := 0;
                GenJnlNarration."Line No." := PurchCommentLine."Line No.";
                GenJnlNarration.Narration := PurchCommentLine.Comment;
                GenJnlNarration.Insert();
            until PurchCommentLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGlobalGLEntry', '', false, false)]
    local procedure InitPostedNarration(GenJournalLine: Record "Gen. Journal Line"; var GlobalGLEntry: Record "G/L Entry")
    var
        GenJnlNarration: Record "Gen. Journal Narration";
        PostedNarration: Record "Posted Narration";
        GLAccount: Record "G/L Account";
        CurrentBalance: Decimal;
        PostingAmount: Decimal;
    begin

        if GenJournalLine."Account Type" <> GenJournalLine."Account Type"::"G/L Account" then
            exit;

        if GenJournalLine."Account No." = '' then
            exit;

        if not GLAccount.Get(GenJournalLine."Account No.") then
            exit;

        // Check only accounts marked for validation
        if not GLAccount."Block Negative Balance" then
            exit;

        GLAccount.CalcFields(Balance);
        CurrentBalance := GLAccount.Balance;

        // Credit amount is negative
        if GenJournalLine.Amount < 0 then begin
            PostingAmount := Abs(GenJournalLine.Amount);

            if PostingAmount > CurrentBalance then
                Error(
                    'Negative balance is not allowed for G/L Account %1.\' +
                    'Current Balance : %2\' +
                    'Posting Amount : %3',
                    GLAccount."No.",
                    CurrentBalance,
                    PostingAmount);
        end;


        if (GenJournalLine."Source Code" <> 'PURCHASES') then
            exit;

        if (GenJournalLine."Document Type" = GenJournalLine."Document Type"::" ") or (GenJournalLine."Document No." = '') then
            exit;

        GenJnlNarration.Reset();
        GenJnlNarration.SetRange("Journal Template Name", '');
        GenJnlNarration.SetRange("Journal Batch Name", '');
        GenJnlNarration.SetRange("Document No.", GenJournalLine."Document No.");
        GenJnlNarration.SetFilter("Line No.", '<>%1', 0);
        GenJnlNarration.SetRange("Gen. Journal Line No.", 0);

        PostedNarration.Reset();
        PostedNarration.SetCurrentKey("Transaction No.");
        PostedNarration.SetRange("Transaction No.", GlobalGLEntry."Transaction No.");
        if not PostedNarration.FindFirst() then
            if GenJnlNarration.FindSet() then
                repeat
                    InsertPostedNarrationVouchers(GlobalGLEntry, GenJnlNarration);
                until GenJnlNarration.Next() = 0;
    end;

    local procedure InsertPostedNarrationVouchers(GLEntry: Record "G/L Entry"; PurchCommentLine: Record "Gen. Journal Narration")
    var
        PostedNarration: Record "Posted Narration";
    begin
        PostedNarration.Init();
        PostedNarration."Entry No." := 0;
        PostedNarration."Transaction No." := GLEntry."Transaction No.";
        PostedNarration."Line No." := PurchCommentLine."Line No.";
        PostedNarration."Posting Date" := GLEntry."Posting Date";
        PostedNarration."Document Type" := GLEntry."Document Type";
        PostedNarration."Document No." := GLEntry."Document No.";
        PostedNarration.Narration := PurchCommentLine.Narration;
        PostedNarration.Insert();
    end;

    [EventSubscriber(ObjectType::CodeUnit, codeUnit::"Bank Acc. Recon. Post (Yes/No)", OnBeforeBankAccReconPostYesNo, '', true, true)]
    local procedure InsetBankAccReconLine(var BankAccReconciliation: Record "Bank Acc. Reconciliation")
    var
        BankAccRecLine: Record "Bank Acc. Reconciliation Line";
        BankAccStatmentLine: Record "Bank Account Statement Line";
    begin
        BankAccStatmentLine."E3 UTR No." := BankAccRecLine."E3 UTR No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchCrMemoHeaderInsert', '', false, false)]
    local procedure EDCOnAfterPurchCrMemoHeaderInsert(var PurchHeader: record "Purchase Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; PreviewMode: Boolean)
    var
        RefInvoiceNo: Record "Reference Invoice No.";
    begin
        RefInvoiceNo.Reset();
        RefInvoiceNo.SetRange("Document No.", PurchHeader."No.");
        if RefInvoiceNo.Find('-') then
            PurchCrMemoHdr."Reference Invoice No." := RefInvoiceNo."Alternate Ref. Invoice No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure CheckOrderAmountonPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    var
        CalcStatistics: Codeunit "Calculate Statistics";
        AmountToVendor: Decimal;
        PurchPayablesSetup: Record "Purchases & Payables Setup";
        HISPurchHdr: Record "E3 HIS Purchase Header";
    begin

        HISPurchHdr.SetRange("Document No.", PurchaseHeader."No.");
        if not PurchPayablesSetup.Get() then
            exit;
        if HISPurchHdr.FindSet() then begin
            repeat
                if PurchaseHeader."Integration PO" = true then
                    if PurchPayablesSetup."GRN Vendor Code Check" then
                        if HISPurchHdr."Vendor No." <> PurchaseHeader."Buy-from Vendor No." then
                            Error(
      'Vendor Code mismatch. Staging Vendor (%1) must match Buy-from Vendor (%2). Posting is not allowed.',
      HISPurchHdr."Vendor No.",
      PurchaseHeader."Buy-from Vendor No."
    );
            until HISPurchHdr.Next() = 0;
        end;

        if not PurchPayablesSetup.Get() then
            exit;

        if not PurchPayablesSetup."HIS GRN Amount Validation" then
            exit;

        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) or
           (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo") then begin

            if PurchaseHeader."Integration PO" then begin

                CalcStatistics.GetPurchaseStatisticsAmount(PurchaseHeader, AmountToVendor);

                if Abs(PurchaseHeader."HIS GRN Amount" - AmountToVendor) > 1 then begin
                    if not Confirm('Difference between Order Amount and Amount to Vendor is more than 1. Do you want to continue posting?', false) then
                        Error('Posting cancelled by user.');
                end;

            end;
        end;
    end;
}