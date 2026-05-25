page 50073 "E3 Credit Note API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'e3CreditNoteAPI';
    DelayedInsert = true;
    EntityName = 'creditnote';
    EntitySetName = 'creditnotes';
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
                field(hisDocumentType; Rec."HIS Document Type")
                {
                    Caption = 'HIS Document Type';
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
                field(validationHISKey; Rec."Validation HIS Key")
                {
                    Caption = 'Validation HIS Key';
                    trigger OnValidate()
                    begin
                        DuplicateCheck();
                    end;
                }
                field(payerCode; Rec."Payer Code")
                {
                    Caption = 'Payer Code';
                }
                field(payorCategory; Rec."Payor Category")
                {
                    Caption = 'Payor Category';
                }
                field(payerName; Rec."Payer Name")
                {
                    Caption = 'Payer Name';
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
