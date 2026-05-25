pageextension 50071 "E3 Update Ref. Invoice No" extends "Update Reference Invoice No"
{
    layout
    {
        addafter(Description)
        {
            field("Alternate Ref. Invoice No."; Rec."Alternate Ref. Invoice No.")
            {
                Caption = 'Alternate Ref. Invoice No.';
                ApplicationArea = All;
                ToolTip = 'Specifies the Alternate Ref. Invoice No.';
                Editable = _editable;
                trigger OnValidate()
                begin
                    if rec."Alternate Ref. Invoice No." <> '' then
                        _editableRec := false
                    else
                        _editableRec := true;
                    if (rec."Reference Invoice Nos." <> '') then
                        Error('Reference Invoice No must be blank');
                end;
            }
            field(Skip; Rec.Skip)
            {
                Caption = 'Skip';
                ApplicationArea = All;
                Editable = _editable;
                ToolTip = 'Specifies the Skip field';
                trigger OnValidate()
                begin
                    if (rec."Reference Invoice Nos." <> '') then
                        Error('Reference Invoice No must be blank');
                end;
            }
        }
        modify("Reference Invoice Nos.")
        {
            Editable = _editableRec;
            trigger OnAfterAfterLookup(Selected: RecordRef)
            begin
                if rec."Reference Invoice Nos." <> '' then
                    _editable := false
                else
                    _editable := true;
            end;

            trigger OnBeforeValidate()
            begin
                if rec."Reference Invoice Nos." <> '' then
                    _editable := false
                else
                    _editable := true;
                Message('OB');
            end;

            trigger OnAfterValidate()
            begin
                Message('OA');
                if rec."Reference Invoice Nos." <> '' then
                    _editable := false
                else
                    _editable := true;
            end;

        }


    }

    actions
    {
        modify(Verify)
        {
            Visible = false;
        }
        addlast(Processing)
        {
            action(NewVerify)
            {
                ApplicationArea = All;
                Caption = 'Verify';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;
                Tooltip = 'Specifies the process through which the reference document can be verified.';

                trigger OnAction()
                var
                    RefInvNoMgt: Codeunit "Reference Invoice No. Mgt.";
                    RefInvoiceNo: Record "Reference Invoice No.";
                begin
                    if (rec."Reference Invoice Nos." <> '') then
                        RefInvNoMgt.VerifyReferenceNo(Rec)
                    else
                        if ((rec."Alternate Ref. Invoice No." <> '') AND (rec.Skip = true)) then begin
                            rec.Verified := true;
                            rec.Modify();
                            Message('Alternate No Verified');
                        end;

                    ;
                end;
            }
        }
    }


    procedure VerifyReferenceNo(var RefInvNo: Record "Reference Invoice No.")
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        ReferenceInvoiceNo: Record "Reference Invoice No.";
        FirstRecord: Boolean;
        RCMValue: Boolean;
        GSTDocumentType: Enum "GST Document Type";
    begin
        ReferenceInvoiceNo.SetRange("Document No.", RefInvNo."Document No.");
        ReferenceInvoiceNo.SetRange("Document Type", RefInvNo."Document Type");
        ReferenceInvoiceNo.SetRange("Source No.", RefInvNo."Source No.");
        if ReferenceInvoiceNo.FindSet() then
            repeat
                if RefInvNo."Document No." = RefInvNo."Reference Invoice Nos." then
                    Error(SameDocErr);

                if RefInvNo."Source Type" = RefInvNo."Source Type"::Vendor then begin
                    VendorLedgerEntry.SetCurrentKey("Document No.", "Vendor No.", "Entry No.");
                    VendorLedgerEntry.SetRange("Vendor No.", RefInvNo."Source No.");
                    VendorLedgerEntry.SetRange("Document No.", ReferenceInvoiceNo."Reference Invoice Nos.");
                    if VendorLedgerEntry.FindFirst() then begin
                        if not FirstRecord then begin
                            RCMValue := VendorLedgerEntry."RCM Exempt";
                            FirstRecord := true;
                        end else
                            if RCMValue <> VendorLedgerEntry."RCM Exempt" then
                                Error(RCMValueCheckErr);

                        DetailedGSTLedgerEntry.SetRange("Document No.", ReferenceInvoiceNo."Reference Invoice Nos.");
                        //  GSTDocumentType := GenJnlDocumentType2GSTDocumentType(VendorLedgerEntry."Document Type");
                        DetailedGSTLedgerEntry.SetRange("Document Type", GSTDocumentType);
                        DetailedGSTLedgerEntry.SetRange("Source No.", RefInvNo."Source No.");
                        if not DetailedGSTLedgerEntry.IsEmpty() then begin
                            if not ReferenceInvoiceNo.Verified then
                                ReferenceInvoiceNo.Verified := true;

                            ReferenceInvoiceNo.Modify();
                        end else
                            Error(ReferenceInvoiceErr);
                    end else
                        Error(ReferenceNoErr);
                end;

                if RefInvNo."Source Type" = RefInvNo."Source Type"::Customer then begin
                    CustLedgerEntry.SetCurrentKey("Document No.", "Customer No.", "Entry No.");
                    CustLedgerEntry.SetRange("Customer No.", RefInvNo."Source No.");
                    CustLedgerEntry.SetRange("Document No.", ReferenceInvoiceNo."Reference Invoice Nos.");
                    if CustLedgerEntry.FindFirst() then begin
                        DetailedGSTLedgerEntry.SetRange("Document No.", ReferenceInvoiceNo."Reference Invoice Nos.");
                        //   GSTDocumentType := GenJnlDocumentType2GSTDocumentType(CustLedgerEntry."Document Type");
                        DetailedGSTLedgerEntry.SetRange("Document Type", GSTDocumentType);
                        DetailedGSTLedgerEntry.SetRange("Source No.", RefInvNo."Source No.");
                        if not DetailedGSTLedgerEntry.IsEmpty() then begin
                            if not ReferenceInvoiceNo.Verified then
                                ReferenceInvoiceNo.Verified := true;

                            ReferenceInvoiceNo.Modify();
                        end else
                            Error(ReferenceInvoiceErr);
                    end else
                        Error(ReferenceNoErr);
                end;
            until ReferenceInvoiceNo.Next() = 0;
    end;

    trigger OnOpenPage()
    begin
        _editable := true;
        _editableRec := true;
    end;

    var
        RefGenJournalLine: Record "Gen. Journal Line";
        _editable: Boolean;
        _editableRec: Boolean;
        ReferenceNoMsg: Label 'Reference Invoice No is required where Invoice Type is Debit Note and Supplementary.';
        ReferenceNoErr: Label 'Selected Document No does not exist for Reference Invoice No.';
        ReferenceInvoiceNoErr: Label 'You cannot select Non GST Document on a GST Document.';
        ReferenceNoNonGSTErr: Label 'You cannot select Non GST - Invoice in Reference Invoice No.';
        RefNoAlterErr: Label 'Reference Invoice No cannot be updated after verification.';
        ReferenceVerifyErr: Label 'Reference Invoice No cannot be update after Verification.';
        VendInvNoErr: Label 'The field Reference Invoice No. of table %1 contains a value that cannot be found in the related table Vendor Ledger Entry.', Comment = '%1 = Document No.';
        CustInvNoErr: Label 'The field Reference Invoice No. of table %1 contains a value that cannot be found in the related table Cust. Ledger Entry.', Comment = '%1 = Document No.';
        SameDocErr: Label 'You cannot apply same document.';
        RCMValueCheckErr: Label 'You cannot select RCM and Non - RCM Invoice together.';
        DocumentTypeErr: Label 'You cannot select Credit Memo/Payment for Reference Invoice.';
        ReferenceInvoiceErr: Label 'Reference Invoice No is not require updation for Non-GST Document.';
        DiffVendNoErr: Label 'You cannot select Reference Invoice No. from different vendors.';
        DiffCustNoErr: Label 'You cannot select Reference Invoice No. from different customers.';
        DiffStateCodeErr: Label 'State code  must be same in both the Document.';
        DiffGSTRegNoErr: Label 'GST Registration No. must be same in both the Documents of %1 for %2.', Comment = '%1 = Field Name, %2 = Posted Document No. / Reference Invoice No.';
        DiffJurisdictionErr: Label '%1  must be same in both the Documents.', Comment = '%1 = Field Name';
        DiffCurrencyCodeErr: Label '%1 must be same in both the documents.', Comment = '%1 = Field Name';
        PurchaseDocumentErr: Label 'Invoice posted from Purchase Document is applicable for application.';
        SalesDocumentErr: Label 'Invoice posted from Sales Document is applicable for application.';
        PostingDateErr: Label 'Posted Invoice No. %1 Posting Date must be earlier than Document No. %2.', Comment = '%1 = Document No., %2 = Document No.';
        DiffGSTWithoutPaymentOfDutyErr: Label 'GST Without Payment of Duty must be same in both the Documents.';
        DateErr: Label '%1 and %2 cannot be blank in GST Accounting Period.', Comment = '%1 = Credit Memo Locking Date, %2 = Annual Return Filed Date';
        EqualDateLockErr: Label 'Document No. %1 cannot be posted as Posting Date must be earlier than %2 & %3 %4.', Comment = '%1 =Document No., %2 = Field Name, %3 = Field Name, %4 = Date';
        DateLockErr: Label 'Document No. %1 cannot be posted as Posting Date must be earlier than %2 %3.', Comment = '%1 =Document No., %2 = Field Name, %3 = Date';
        UpdateGSTNosErr: Label 'Please Update GST Registration No. for Document No. %1 through batch first, then proceed for application.', Comment = '%1 = Document No';
        OneDocumentErr: Label 'You cannot apply more than 1 Document to %1 %2.', Comment = '%1 = Document Type,%2 = Document No.';
        DiffLocationGSTRegErr: Label 'Location GST Reg. No. must be same in both the Documents.';
        InvoiceNoBlankErr: Label 'Credit Memo No. %1 has already been applied against Invoice No. %2.', Comment = '%1 =Document No., %2 = Invoice No.';
        CompGSTRegNoARNNoErr: Label 'Company Information must have either GST Registration No. or ARN No.';
        ReferenceInvNoPurchErr: Label 'Reference Invoice No. must have a value in Purchase Header: Document Type = %1, No = %2. It cannot be zero or empty.', Comment = '%1 = Document Type,%2 = Document No.';
        ReferenceInvNoSalesErr: Label 'Reference Invoice No. must have a value in Sales Header: Document Type = %1, No = %2. It cannot be zero or empty.', Comment = '%1 = Document Type,%2 = Document No.';
        ReferenceNoJnlErr: Label 'Reference Invoice No. must have a value  in Journal: Document Type = %1, No = %2. It cannot be zero or empty.', Comment = '%1 = Document Type and %2 = Document No';
        ReferenceInvNoServiceErr: Label 'Reference Invoice No. must have a value in Service Header: Document Type = %1, No = %2. It cannot be zero or empty.', Comment = '%1 = Document Type,%2 = Document No.';


}