page 50143 "E3 HIS Bill Collection API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'billCollectionsAPI';
    DelayedInsert = true;
    EntityName = 'billcollection';
    EntitySetName = 'billcollections';
    PageType = API;
    SourceTable = "E3 HIS Bill Collection";
    ODataKeyFields = "Entry No.";
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    //Editable = false;
                }
                field(hisDocumentType; Rec."HIS Document Type")
                {
                    Caption = 'HIS Document Type';
                }
                field(modeOfPayment; Rec."Mode of Payment")
                {
                    Caption = 'Mode of Payment';
                }
                field(receiptDate; Rec."Receipt Date")
                {
                    Caption = 'Receipt Date';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(receiptNo; Rec."Receipt No.")
                {
                    Caption = 'Receipt No.';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(referenceNo; Rec."Reference No.")
                {
                    Caption = 'Reference No.';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(validationHISKey; Rec."Validation HIS Key")
                {
                    Caption = 'Validation HIS Key';
                    // trigger OnValidate()
                    // begin
                    //     DuplicateCheck();
                    // end;
                }
            }
        }
    }
    // local procedure DuplicateCheck()
    // var
    //     BillCollectionStaging: Record "HIS Bill Collection";
    // begin
    //     BillCollectionStaging.SetRange("HIS Document Type", Rec."HIS Document Type");
    //     BillCollectionStaging.SetRange("Validation HIS Key", Rec."Validation HIS Key");
    //     if not BillCollectionStaging.IsEmpty then
    //         error('Duplicate Entry');
    // end;
}
