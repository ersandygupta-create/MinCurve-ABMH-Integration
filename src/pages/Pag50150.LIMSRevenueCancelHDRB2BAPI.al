page 50150 "POne Rev Cancel HDR B2B API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'pOneRevCancelHDRB2BAPI';
    DelayedInsert = true;
    EntityName = 'pOneRevcancelheaderB2B';
    EntitySetName = 'pOneRevcancelheadersB2B';
    PageType = API;
    SourceTable = "E3 LIMS Revenue Header";
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

                    trigger OnValidate()
                    begin
                        DuplicateCheck();
                    end;
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
                field(UHID; Rec.UHID)
                {
                    Caption = 'UHID';
                }
                field(encounterNo; Rec."Encounter No.")
                {
                    Caption = 'Encounter No.';
                }
                field(doctor; Rec.Doctor)
                {
                    Caption = 'Doctor Name';
                }
                field(speciality; Rec.Speciality)
                {
                    Caption = 'Speciality';
                }
                field(sponsorCode; Rec."Sponsor Code")
                {
                    Caption = 'Sponsor Code';
                }
                field(sponsorName; Rec."Sponsor Name")
                {
                    Caption = 'Sponsor Name';
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
                field(admissionDateTime; Rec."Admission Date Time")
                {
                    Caption = 'Admission Date Time';
                }
                field(dischargeDateTime; Rec."Discharge Date Time")
                {
                    Caption = 'Discharge Date Time';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(validationHISKey; Rec."Validation HIS Key")
                {
                    Caption = 'Validation HIS Key';
                }
                field(admissionSource; Rec."Admission Source")
                {
                    Caption = 'Admission Source';
                }
                field(packagePatient; Rec."Package Patient")
                {
                    Caption = 'Package Patient';
                }
                field(admissionBedCategory; Rec."Admission Bed Category")
                {
                    Caption = 'Admission Bed Category';
                }
                field(dischargeBedCategory; Rec."Discharge Bed Category")
                {
                    Caption = 'Discharge Bed Category';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(collectionAmount; Rec."Collection Amount")
                {
                    Caption = 'Collection Amount';
                }
                field(taxAmount; Rec."Tax Amount")
                {
                    Caption = 'Tax Amount';
                }
                field(patientPayable; Rec."Patient Payable")
                {
                    Caption = 'Patient Payable';
                }
                field(payorPayable; Rec."Payor Payable")
                {
                    Caption = 'Payor Payable';
                }
                field(discount; Rec.Discount)
                {
                    Caption = 'Discount';
                }
                field(noOfLines; Rec."No. of Lines")
                {
                    Caption = 'No. of Lines';
                }
                field(specialityCode; Rec."Speciality Code")
                {
                    Caption = 'Speciality Code';
                }
            }
            part(RevenuecancelLine; "POne Rev. Cancel Line B2B API")
            {
                Caption = 'Lines';
                EntityName = 'pOneRevcancellineB2B';
                EntitySetName = 'pOneRevcancellinesB2B';
                SubPageLink = "Record Type" = field("Record Type"), "Document Type" = field("Document Type"), "Document No." = field("Document No.");
            }
            part(BillCollectionLine; "E3 HIS Bill Collection API")
            {
                Caption = 'Lines';
                EntityName = 'billcollection';
                EntitySetName = 'billcollections';
                SubPageLink = "Document No." = field("Document No.");
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        Rec.Validate("Record Type", Rec."Record Type"::"Revenue Cancel");
        Rec."Document Type" := Rec."Document Type"::"Credit Memo";
        //DuplicateCheck();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Validate("Record Type", Rec."Record Type"::"Revenue Cancel");
        Rec."Document Type" := Rec."Document Type"::"Credit Memo";
        //DuplicateCheck();
    end;

    local procedure DuplicateCheck()
    var
        RevenueHeader: Record "E3 HIS Revenue Header";
    begin
        //RevenueHeader.SetFilter("Entry No.", '<>%1', Rec."Entry No.");
        RevenueHeader.Setrange("Record Type", Rec."Record Type"::"Revenue Cancel");
        RevenueHeader.Setrange("Document Type", Rec."Document Type"::"Credit Memo");
        RevenueHeader.SetRange("Document No.", Rec."Document No.");
        //if not RevenueHeader.IsEmpty then
        if RevenueHeader.Count >= 1 then
            error('Duplicate Entry');
    end;
}
