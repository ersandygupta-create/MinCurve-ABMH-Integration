page 50153 "POne Revenue Line B2C API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'pOneRevenueLineB2CAPI';
    DelayedInsert = true;
    AutoSplitKey = true;
    EntityName = 'pOneRevenuelineB2C';
    EntitySetName = 'pOneRevenuelinesB2C';
    PageType = API;
    SourceTable = "E3 HIS Revenue Line";
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
                    Caption = 'Documment No.';
                }
                field(accountType; Rec."Account Type")
                {
                    Caption = 'Account Type';
                }
                field(accountNo; Rec."Account No.")
                {
                    Caption = 'Account No.';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Shortcut Dimension 3 Code';
                }
                field(serviceCategory; Rec."Service Category")
                {
                    Caption = 'Service Category';
                }
                field(itemID; Rec."Item ID")
                {
                    Caption = 'Item ID';
                }
                field(itemName; Rec."Item Name")
                {
                    Caption = 'Item Name';
                }
                field(gstGroup; Rec."GST Group Code")
                {
                    Caption = 'GST Group';
                }
                field(hsnCode; Rec."HSN Code")
                {
                    Caption = 'SACHSNCODE';
                }
                field(serviceItemCode; Rec."Service Item Code")
                {
                    Caption = 'Service Item Code';
                }
                field(quantity; Rec.Qty)
                {
                    Caption = 'Quantity';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(mouDiscount; Rec."MOU Discount")
                {
                    Caption = 'MOU Discount';
                }
                field(addOnDiscount; Rec.Discount)
                {
                    Caption = 'Add on Discount';
                }
                field(netAmount; Rec."Net Amount")
                {
                    Caption = 'Net Amount';
                }
                field(taxableAmount; Rec."Taxable Amount")
                {
                    Caption = 'Taxable Amount';
                }
                field(patientPayable; Rec."Patient Payable")
                {
                    Caption = 'Patient Payable';
                }
                field(payorPayable; Rec."Payor Payable")
                {
                    Caption = 'Payor Payable';
                }
                field(packagePatient; Rec."Package Patient")
                {
                    Caption = 'Package Patient';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(departmentName; Rec."Department Name")
                {
                    Caption = 'Department Name';
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec.HasFilter() then begin
            Rec.Validate("Record Type", Rec."Record Type"::Revenue);
            Rec."Document Type" := Rec."Document Type"::Invoice;
            Rec."Document No." := Rec.GetFilter("Document No.");
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec.HasFilter() then begin
            Rec.Validate("Record Type", Rec."Record Type"::Revenue);
            Rec."Document Type" := Rec."Document Type"::Invoice;
            Rec."Document No." := Rec.GetFilter("Document No.");
        end;
    end;
}
