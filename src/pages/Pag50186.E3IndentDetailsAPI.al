page 50186 "E3 Indent Header API"
{
    PageType = API;
    APIPublisher = 'mindcurve';
    APIGroup = 'apiHIS';
    APIVersion = 'v2.0';
    Caption = 'Indent Details API';
    EntityName = 'indentDetail';
    EntitySetName = 'indentDetails';
    SourceTable = "E3 Indent Header";
    DelayedInsert = true;
    ApplicationArea = All;
    ODataKeyFields = "Document No.";
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(requestedBy; Rec."Requested To")
                {
                    Caption = 'Requested By';
                }
                field(indentDate; Rec."Request Date")
                {
                    Caption = 'Indent Date';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Business Unit Code';
                }
                field(businessUnitName; Rec."Business Unit Name")
                {
                    Caption = 'Business Unit Name';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Department Code';
                }
                field(departmentName; Rec."Department Name")
                {
                    Caption = 'Department Name';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(locationName; Rec."Location Name")
                {
                    Caption = 'Location Name';
                }
                field(toLocationCode; Rec."To Location Code")
                {
                    Caption = 'To Location Code';
                }
                field(toLocationName; Rec."To Location Name")
                {
                    Caption = 'To Location Name';
                }
                field(expectedReceiveDate; Rec."Expected Receive Date")
                {
                    Caption = 'Expected Receive Date';
                }
                field(approvedBy; Rec."Approved By")
                {
                    Caption = 'Approved By';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(indenterCode; Rec.Indenter)
                {
                    Caption = 'Indenter';
                }
                field(indenterName; Rec."Indenter Name")
                {
                    Caption = 'Requesting Staff Name';
                }
                field(remarks; Rec.Remarks)
                {
                    Caption = 'Remarks';
                }
                field(toDepartmentCode; Rec."To Department Code")
                {
                    Caption = 'To Department Code';
                }
                field(toDepartmentName; Rec."To Department Name")
                {
                    Caption = 'To Department Name';
                }
                field(approvalDateTime; Rec."Approval Date Time")
                {
                    Caption = 'Approval Date Time';
                }
                field(voucherTypeCode; Rec."Voucher Type Code")
                {
                    Caption = 'Voucher Type Code';
                }
                field(voucherTypeName; Rec."Voucher Type Name")
                {
                    Caption = 'Voucher Type Name';
                }
            }
            part(IndentLine; "E3 Indent Line API")
            {
                Caption = 'Lines';
                EntityName = 'indentLine';
                EntitySetName = 'indentLines';
                SubPageLink = "Document No." = field("Document No.");
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    local procedure DuplicateCheck()
    var
        IndentHdr: Record "E3 Indent Header";
    begin
        IndentHdr.SetRange("Document No.", Rec."Document No.");
        if not IndentHdr.IsEmpty then
            error('Duplicate Entry');
    end;
}