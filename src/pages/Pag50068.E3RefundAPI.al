page 50068 "E3 Refund API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'e3RefundAPI';
    DelayedInsert = true;
    EntityName = 'refund';
    EntitySetName = 'refunds';
    PageType = API;
    SourceTable = "E3 HIS Revenue Staging Table";
    ODataKeyFields = SystemId;
    Extensible = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                    Editable = false;
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(patientName; Rec."Patient Name")
                {
                    Caption = 'Patient Name';
                }
                field(uhid; Rec.UHID)
                {
                    Caption = 'UHID';
                }
                field(ipNo; Rec."IP No.")
                {
                    Caption = 'IP No.';
                }
                field(hisDocumentType; Rec."HIS Document Type")
                {
                    Caption = 'HIS Document Type';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(accountType; Rec."Account Type")
                {
                    Caption = 'Account Type';
                }
                field(accountNo; Rec."Account No.")
                {
                    Caption = 'Account No.';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(chequeNo; Rec."Cheque No.")
                {
                    Caption = 'Cheque No.';
                }
                field(chequeDate; Rec."Cheque Date")
                {
                    Caption = 'Cheque Date';
                }
                field(validationHISKey; Rec."Validation HIS Key")
                {
                    Caption = 'Validation HIS Key';
                    trigger OnValidate()
                    begin
                        DuplicateCheck();
                    end;
                }
                field(hisUserID; Rec."HIS User ID")
                {
                    Caption = 'HIS User ID';
                }
                field(hisUserName; Rec."HIS User Name")
                {
                    Caption = 'HIS User Name';
                }
                field(modeOfPayment; Rec."Mode of Payment")
                {
                    Caption = 'Mode of Payment';
                }
                field(sponsorCode; Rec."Sponsor Code")
                {
                    Caption = 'Sponsor Code';
                }
                field(sponsorName; Rec."Sponsor Name")
                {
                    Caption = 'Sponsor Name';
                }
                field(payerName; Rec."Payer Name")
                {
                    Caption = 'Payer Name';
                }
                field(payorCategory; Rec."Payor Category")
                {
                    Caption = 'Payor Category';
                }
                field(hisBillType; Rec."HIS Bill Type")
                {
                    Caption = 'HIS Bill Type';
                }
                field(receiptNo; Rec."Receipt No.")
                {
                    Caption = 'Receipt No.';
                }
                field(bankAccountNo; Rec."E3 Bank Account No.")
                {
                    Caption = 'Bank Account No.';
                }
                field(ifscCode; Rec."E3 IFSC Code")
                {
                    Caption = 'IFSC Code';
                }
                field(branch; Rec."E3 Branch")
                {
                    Caption = 'Branch';
                }
            }
        }
    }

    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // begin
    //     DuplicateCheck();
    // end;

    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     DuplicateCheck();
    // end;

    local procedure DuplicateCheck()
    var
        RevenueStaging: Record "E3 HIS Revenue Staging Table";
    begin
        //RevenueStaging.SetFilter("Entry No.", '<>%1', Rec."Entry No.");
        RevenueStaging.SetRange("HIS Document Type", Rec."HIS Document Type");
        RevenueStaging.SetRange("Validation HIS Key", Rec."Validation HIS Key");
        if not RevenueStaging.IsEmpty then
            error('Duplicate Entry');
    end;
}
