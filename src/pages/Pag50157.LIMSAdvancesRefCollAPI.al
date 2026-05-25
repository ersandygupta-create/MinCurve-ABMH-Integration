page 50157 "POne Advances API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'pOneAdvancesAPI';
    DelayedInsert = true;
    EntityName = 'pOneAdvanceRefundCollection';
    EntitySetName = 'pOneAdvanceRefundCollections';
    PageType = API;
    SourceTable = "E3 HIS Revenue Staging Table";
    ODataKeyFields = "Entry No.";
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
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
                field(encounterNo; Rec."Encounter No.")
                {
                    Caption = 'Encounter No.';
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
