page 50158 "POne GRN Details API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'pOneGRNDetailsAPI';
    DelayedInsert = true;
    EntityName = 'pOnegrnDetail';
    EntitySetName = 'pOnegrnDetails';
    PageType = API;
    SourceTable = "E3 HIS Purchase Header";
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                // field(recordType; Rec."Record Type")
                // {
                //     Caption = 'Record Type';
                // }
                // field(documentType; Rec."Document Type")
                // {
                //     Caption = 'Document Type';
                // }
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
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(vendorCustomerNo; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                }
                field(vendorCustomerName; Rec."Vendor Name")
                {
                    Caption = 'Vendor Name';
                }
                field(addressCode; Rec."Address Code")
                {
                    Caption = 'Address Code';
                }
                field(hisDocumentType; Rec."HIS Document Type")
                {
                    Caption = 'HIS Document Type';
                }
                field(grnID; Rec."GRN ID")
                {
                    Caption = 'GRN ID';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(noOfLines; Rec."No. of Lines")
                {
                    Caption = 'No. of Lines';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(referenceInvoiceNo; Rec."Reference Invoice No.")
                {
                    Caption = 'Reference Invoice No.';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                // field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                // {
                //     Caption = 'Shortcut Dimension 3 Code';
                // }
                field(vendorInvoiceNo; Rec."Vendor Invoice No.")
                {
                    Caption = 'Vendor Invoice No.';
                }
                field(vendorInvoiceDate; Rec."Vendor Invoice Date")
                {
                    Caption = 'Vendor Invoice Date';
                }
                // field("type"; Rec."Type")
                // {
                //     Caption = 'Type';
                // }
                // field(workOrderType; Rec."Work Order Type")
                // {
                //     Caption = 'Work Order Type';
                // }
                // field(error1; Rec."Error 1")
                // {
                //     Caption = 'Error 1';
                // }
                // field(error2; Rec."Error 2")
                // {
                //     Caption = 'Error 2';
                // }
                // field(error3; Rec."Error 3")
                // {
                //     Caption = 'Error 3';
                // }
                // field(error4; Rec."Error 4")
                // {
                //     Caption = 'Error 4';
                // }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'System ID';
                    Editable = false;
                }
                field(storeName; Rec."Store Name")
                {
                    Caption = 'Store Name';
                }
                field(purchaseOrderNo; Rec."Purchase Order No.")
                {
                    Caption = 'Purchase Order No.';
                }
                field(purchaseOrderDate; Rec."Purchase Order Date")
                {
                    Caption = 'Purchase Order Date';
                }
                field(capexType; Rec."Capex Type")
                {
                    Caption = 'Capex Type';
                }
            }
            part(grnLines; "POne GRN Lines API")
            {
                Caption = 'Lines';
                EntityName = 'pOnegrnLine';
                EntitySetName = 'pOnegrnLines';
                SubPageLink = "Record Type" = field("Record Type"), "document Type" = field("Document Type"), "Document No." = FIELD("Document No.");
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Validate("Record Type", Rec."Record Type"::GRN);
        Rec."Document Type" := Rec."Document Type"::Order;
        //DuplicateCheck();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Validate("Record Type", Rec."Record Type"::GRN);
        Rec."Document Type" := Rec."Document Type"::Order;
        //DuplicateCheck();
    end;

    local procedure DuplicateCheck()
    var
        GRNHeader: Record "E3 HIS Purchase Header";
    begin
        //GRNHeader.SetFilter("Entry No.", '<>%1', Rec."Entry No.");
        GRNHeader.Setrange("Record Type", Rec."Record Type"::GRN);
        GRNHeader.Setrange("Document Type", Rec."Document Type"::Order);
        GRNHeader.SetRange("Document No.", Rec."Document No.");
        //if not GRNHeader.IsEmpty then
        if GRNHeader.Count >= 1 then
            error('Duplicate Entry');
    end;
}
