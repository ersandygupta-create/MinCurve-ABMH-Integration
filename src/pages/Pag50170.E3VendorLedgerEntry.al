page 50170 "E3 Vendor Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'VLE Payment Entry Selection';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Vendor Ledger Entry" = rm;
    SourceTable = "Vendor Ledger Entry";
    SourceTableView = sorting("Vendor No.", "Posting Date") order(descending) where
    ("Ready for Payment" = filter(false), Open = filter(true), "Document Type" = filter(Invoice | "Credit Memo" | ''), "Source Code" = filter('JOURNALV' | 'PURCHASES'),
    "On Hold" = CONST(''), "Bank Integration Enabled" = filter(true),
    "Remaining Amount" = filter(<> 0));


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Specifies the vendor entry select';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the vendor entry''s posting date.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the vendor entry''s document date.';
                }
                field("Bank Integration Enabled"; Rec."Bank Integration Enabled")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies whether the vendor ledger entry is linked to bank integration.';
                }
                field("Invoice Received Date"; Rec."Invoice Received Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the date when the vendor''s invoice was received.';
                    Visible = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the document type that the vendor entry belongs to.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the vendor entry''s document number.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the vendor account that the entry is linked to.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = VendNameVisible;
                }
                field("Message to Recipient"; Rec."Message to Recipient")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the message exported to the payment file when you use the Export Payments to File function in the Payment Journal window.';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ToolTip = 'Specifies a description of the vendor entry.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = Dim2Visible;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the vendor''s market type to link business transactions made for the vendor with the appropriate account in the general ledger.';
                    Visible = false;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = Intercompany;
                    Editable = false;
                    ToolTip = 'Specifies the code of the intercompany partner that the transaction is related to if the entry was created from an intercompany transaction.';
                    Visible = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the currency code for the amount on the line.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the payment of the purchase invoice.';
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the vendor who sent the purchase invoice.';
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount of the original entry.';
                }
                field("Original Amt. (LCY)"; Rec."Original Amt. (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount that the entry originally consisted of, in LCY.';
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount of the entry.';
                    Visible = AmountVisible;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount of the entry in LCY.';
                    Visible = AmountVisible;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits.';
                    Visible = DebitCreditVisible;
                }
                field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits, expressed in LCY.';
                    Visible = DebitCreditVisible;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits.';
                    Visible = DebitCreditVisible;
                }
                field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits, expressed in LCY.';
                    Visible = DebitCreditVisible;
                }
                field(RunningBalanceLCY; CalcRunningVendBalance.GetVendorBalanceLCY(Rec))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Running Balance (LCY)';
                    ToolTip = 'Specifies the running balance in LCY.';
                    AutoFormatType = 1;
                    Visible = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount that remains to be applied to before the entry is totally applied to.';
                }
                field("Remaining Amt. (LCY)"; Rec."Remaining Amt. (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount that remains to be applied to before the entry is totally applied to.';
                }
                field("Amount to Pay"; Rec."Amount to Pay")
                {
                    Caption = 'Amount to Pay';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the type of account that a balancing entry is posted to, such as BANK for a cash account.';
                    Visible = false;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the general ledger, customer, vendor, or bank account that the balancing entry is posted to, such as a cash account for cash purchases.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the due date on the entry.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
                }
                field("Pmt. Disc. Tolerance Date"; Rec."Pmt. Disc. Tolerance Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the latest date the amount in the entry must be paid in order for payment discount tolerance to be granted.';
                }
                field("Original Pmt. Disc. Possible"; Rec."Original Pmt. Disc. Possible")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the discount that you can obtain if the entry is applied to before the payment discount date.';
                }
                field("Remaining Pmt. Disc. Possible"; Rec."Remaining Pmt. Disc. Possible")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the remaining payment discount which can be received if the payment is made before the payment discount date.';
                }
                field("Max. Payment Tolerance"; Rec."Max. Payment Tolerance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the maximum tolerated amount the entry can differ from the amount on the invoice or credit memo.';
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies whether the amount on the entry has been fully paid or there is still a remaining amount that must be applied to.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies that the related entry represents an unpaid invoice for which either a payment suggestion, a reminder, or a finance charge memo exists.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                    Visible = false;

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation(Rec."User ID");
                    end;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the source code that specifies where the entry was created.';
                    Visible = false;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the entry.';
                    Visible = false;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies if the entry has been part of a reverse transaction.';
                    Visible = false;
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the correcting entry that replaced the original entry in the reverse transaction.';
                    Visible = false;
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the original entry that was undone by the reverse transaction.';
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
                field("Exported to Payment File"; Rec."Exported to Payment File")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ToolTip = 'Specifies that the entry was created as a result of exporting a payment journal line.';

                    trigger OnValidate()
                    var
                        ConfirmManagement: Codeunit "Confirm Management";
                    begin
                        if not ConfirmManagement.GetResponseOrDefault(ExportToPaymentFileConfirmTxt, true) then
                            Error('');
                    end;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies a reference to a combination of dimension values. The actual values are stored in the Dimension Set Entry table.';
                    Visible = false;
                }
                field(RecipientBankAcc; Rec."Recipient Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the bank account to transfer the amount to.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 3, which is one of dimension codes that you set up in the General Ledger Setup window.';
                    Visible = Dim3Visible;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 4, which is one of dimension codes that you set up in the General Ledger Setup window.';
                    Visible = Dim4Visible;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 5, which is one of dimension codes that you set up in the General Ledger Setup window.';
                    Visible = Dim5Visible;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 6, which is one of dimension codes that you set up in the General Ledger Setup window.';
                    Visible = Dim6Visible;
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 7, which is one of dimension codes that you set up in the General Ledger Setup window.';
                    Visible = Dim7Visible;
                }
                field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 8, which is one of dimension codes that you set up in the General Ledger Setup window.';
                    Visible = Dim8Visible;
                }
                field("Closed at Date"; Rec."Closed at Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the date at which the vendor ledger entry was closed.';
                    Visible = false;
                }
                field("Remit-to Code"; Rec."Remit-to Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the address for the remit-to code.';
                    Visible = true;
                    TableRelation = "Remit Address".Code where("Vendor No." = field("Vendor No."));
                }
                field("Ready for Payment"; Rec."Ready for Payment")
                {
                    Caption = 'Ready for Payment';
                    ToolTip = 'Specifies the vendor entry Ready for Payment';
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
            part(GLEntriesPart; "G/L Entries Part")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Related G/L Entries';
                ShowFilter = false;
                SubPageLink = "Posting Date" = field("Posting Date"), "Document No." = field("Document No.");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            action("3E Ready for Payment")
            {
                ApplicationArea = All;
                Caption = 'Ready for Payment';
                Image = SuggestVendorPayments;
                ToolTip = 'Mark selected Vendor Ledger Entries as Ready for Payment.';

                trigger OnAction()
                var
                    VLE: Record "Vendor Ledger Entry";
                    Vendor: Record Vendor;
                    userSetup: Record "User Setup";
                    VendorBank: Record "Vendor Bank Account";
                    TotalRemainingAmt: Decimal;
                    VendorAmt: Decimal;
                    VendorNo: Code[20];
                    VendorTotals: Dictionary of [Code[20], Decimal];
                begin
                    userSetup.Reset();
                    userSetup.SetRange("User ID", UserId());
                    if userSetup.Find('-') then begin
                        VLE.SetRange("Global Dimension 1 Code", userSetup."Purchase Resp. Ctr. Filter");
                        VLE.SetRange(Select, true);
                        if not VLE.FindSet() then begin
                            Message('No records selected.');
                            exit;
                        end;
                        // end;


                        Clear(VendorTotals);

                        // 🔹 Step 1: Calculate total remaining amount per Vendor
                        repeat
                            //VLE.CalcFields("Remaining Amount");
                            VendorNo := VLE."Vendor No.";

                            if VendorTotals.ContainsKey(VendorNo) then begin
                                VendorTotals.Get(VendorNo, VendorAmt);
                                VendorAmt += VLE."Amount to Pay";
                                VendorTotals.Set(VendorNo, VendorAmt);
                            end else
                                VendorTotals.Add(VendorNo, VLE."Amount to Pay");
                        until VLE.Next() = 0;
                    end;
                    // 🔹 Step 2: Process only negative total vendors
                    userSetup.Reset();
                    userSetup.SetRange("User ID", UserId());
                    if userSetup.Find('-') then begin
                        VLE.Reset();
                        VLE.SetRange("Global Dimension 1 Code", userSetup."Purchase Resp. Ctr. Filter");
                        VLE.SetRange(Select, true);
                        if VLE.FindSet() then begin
                            repeat
                                VendorTotals.Get(VLE."Vendor No.", VendorAmt);

                                if VendorAmt >= 0 then
                                    Error(
                                        'Vendor %1 has positive remaining amount (%2). Only vendors with payable (negative) balances can be processed.',
                                        VLE."Vendor No.", Format(VendorAmt));

                                if VendorAmt < 0 then begin
                                    // Validate Vendor
                                    if not Vendor.Get(VLE."Vendor No.") then
                                        Error('Vendor %1 not found.', VLE."Vendor No.");

                                    if Vendor."E-Mail" = '' then
                                        Error(
                                            'Vendor %1 does not have an Email ID defined. Please update it before marking as Ready for Payment.',
                                            Vendor."No."
                                        );

                                    // Validate Preferred Bank Account Code
                                    if Vendor."Preferred Bank Account Code" = '' then
                                        Error(
                                            'Vendor %1 does not have a Preferred Bank Account Code defined. ' +
                                            'Please update it before marking as Ready for Payment.',
                                            Vendor."No."
                                        );

                                    // Validate Vendor Bank Account Details
                                    if not VendorBank.Get(Vendor."No.", Vendor."Preferred Bank Account Code") then
                                        Error(
                                            'Preferred Bank Account %1 not found for Vendor %2.',
                                            Vendor."Preferred Bank Account Code", Vendor."No."
                                        );

                                    if VendorBank.Name = '' then
                                        Error(
                                            'Vendor %1 Preferred Bank Account (%2) does not have a Name defined.',
                                            Vendor."No.", Vendor."Preferred Bank Account Code"
                                        );

                                    if VendorBank."Bank Account No." = '' then
                                        Error(
                                            'Vendor %1 Preferred Bank Account (%2) does not have a Bank Account No. defined.',
                                            Vendor."No.", Vendor."Preferred Bank Account Code"
                                        );

                                    if VendorBank."Bank Clearing Code" = '' then
                                        Error(
                                            'Vendor %1 Preferred Bank Account (%2) does not have a IFSC Code defined.',
                                            Vendor."No.", Vendor."Preferred Bank Account Code"
                                        );

                                    if VendorBank."Branch Name" = '' then
                                        Error(
                                            'Vendor %1 Preferred Bank Account (%2) does not have a Branch Name defined.',
                                            Vendor."No.", Vendor."Preferred Bank Account Code"
                                        );

                                    // Mark as Ready for Payment
                                    VLE."Ready for Payment" := true;
                                    VLE.Select := false;
                                    VLE."RP User Id" := UserId;
                                    VLE."RP DateTime" := CurrentDateTime;
                                    VLE.Modify(true);
                                end;
                            until VLE.Next() = 0;
                        end;
                        Message('All selected records have been marked as Ready for Payment.');
                    end;
                end;
            }

        }
    }

    var
        CalcRunningVendBalance: Codeunit "Calc. Running Vend. Balance";
        Navigate: Page Navigate;
        DimensionSetIDFilter: Page "Dimension Set ID Filter";
        HasIncomingDocument: Boolean;
        HasDocumentAttachment: Boolean;
        AmountVisible: Boolean;
        DebitCreditVisible: Boolean;
        VendNameVisible: Boolean;
        ExportToPaymentFileConfirmTxt: Label 'Editing the Exported to Payment File field will change the payment suggestions in the Payment Journal. Edit this field only if you must correct a mistake.\Do you want to continue?';

    protected var
        Dim1Visible: Boolean;
        Dim2Visible: Boolean;
        Dim3Visible: Boolean;
        Dim4Visible: Boolean;
        Dim5Visible: Boolean;
        Dim6Visible: Boolean;
        Dim7Visible: Boolean;
        Dim8Visible: Boolean;
        StyleTxt: Text;

    local procedure SetDimVisibility()
    var
        DimensionManagement: Codeunit DimensionManagement;
    begin
        DimensionManagement.UseShortcutDims(Dim1Visible, Dim2Visible, Dim3Visible, Dim4Visible, Dim5Visible, Dim6Visible, Dim7Visible, Dim8Visible);
    end;

    local procedure SetControlVisibility()
    var
        GLSetup: Record "General Ledger Setup";
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        GLSetup.Get();
        AmountVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Debit/Credit Only");
        DebitCreditVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Amount Only");
        PurchSetup.Get();
        VendNameVisible := PurchSetup."Copy Vendor Name to Entries";
    end;

    local procedure GetBatchRecord(var GenJournalBatch: Record "Gen. Journal Batch"; CreatePayment: Page "Create Payment")
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        JournalTemplateName: Code[10];
        JournalBatchName: Code[10];
    begin
        JournalTemplateName := CreatePayment.GetTemplateName();
        JournalBatchName := CreatePayment.GetBatchNumber();

        GenJournalTemplate.Get(JournalTemplateName);
        GenJournalBatch.Get(JournalTemplateName, JournalBatchName);
    end;

    local procedure SetChangeLogEntriesFilter(var ChangeLogEntry: Record "Change Log Entry")
    begin
        ChangeLogEntry.SetRange("Table No.", Database::"Vendor Ledger Entry");
        ChangeLogEntry.SetRange("Primary Key Field 1 Value", Format(Rec."Entry No.", 0, 9));
    end;

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Due Date", '..%1', Today());
        Rec.SetRange("On Hold", '');
        rec.CalcFields("Remaining Amount");
        rec."Amount to Pay" := rec."Remaining Amount";
    end;

    trigger OnAfterGetRecord()
    begin
        rec.CalcFields("Remaining Amount");
        if (rec."Amount to Pay" = 0) then begin
            rec."Amount to Pay" := rec."Remaining Amount";
            rec.Modify(true);
        end;

    end;
}

