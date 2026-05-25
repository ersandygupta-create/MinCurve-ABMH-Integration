page 50072 "E3 Revenue Cancel Line API"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'e3RevenueCancelLineAPI';
    DelayedInsert = true;
    AutoSplitKey = true;
    EntityName = 'revenuecancelline';
    EntitySetName = 'revenuecancellines';
    PageType = API;
    SourceTable = "E3 HIS Revenue Line";
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
                field(shortcutDimenion3Name; Rec."Shortcut Dimenion 3 Code Name")
                {
                    Caption = 'Shortcut Dimenion 3 Code Name';
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
                field(hsnCode; Rec."HSN Code")
                {
                    Caption = 'SACHSNCODE';
                }
                field(cgstAmount; Rec."CGST Amount")
                {
                    Caption = 'CGST Amount';
                }
                field(sgstAmount; Rec."sGST Amount")
                {
                    Caption = 'sGST Amount';
                }
                field(serviceItemCode; Rec."Service Item Code")
                {
                    Caption = 'ServiceItemCode';
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                }
                field(itemSubCategory; Rec."Item Sub Category Code")
                {
                    Caption = 'Item Sub Category';
                }
                field(gstGroup; Rec."GST Group Code")
                {
                    Caption = 'GST Group';
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
                field(addOnDiscount; Rec."Discount")
                {
                    Caption = 'Add on Discount';
                }
                field(netAmount; Rec."Net Amount")
                {
                    Caption = 'Net Amount';
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
            Rec.Validate("Record Type", Rec."Record Type"::"Revenue Cancel");
            Rec."Document Type" := Rec."Document Type"::"Credit Memo";
            Rec."Document No." := Rec.GetFilter("Document No.");
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec.HasFilter() then begin
            Rec.Validate("Record Type", Rec."Record Type"::"Revenue Cancel");
            Rec."Document Type" := Rec."Document Type"::"Credit Memo";
            Rec."Document No." := Rec.GetFilter("Document No.");
        end;
    end;
}
