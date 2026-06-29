tableextension 50000 "E3 HIS Vendor Ext" extends Vendor
{
    fields
    {
        field(50000; "E3 HIS Code"; Code[20])
        {
            Caption = 'HIS Code';
            DataClassification = CustomerContent;
        }
        field(50001; "E3 MSME Type"; Boolean)
        {
            Caption = 'MSME Type';
            DataClassification = CustomerContent;
        }
        field(50002; "E3 HIS Type"; Enum "E3 HIS Type")
        {
            Caption = 'HIS Type';
            DataClassification = CustomerContent;
        }
        field(50003; "E3 Auto E-Mail"; Boolean)
        {
            Caption = 'Auto E-Mail';
            DataClassification = CustomerContent;
        }
        field(50004; "DL No."; Text[20])
        {
            Caption = 'DL No.';
            DataClassification = CustomerContent;
        }
        field(50015; "E3 Sync Record Exists"; Boolean)
        {
            Caption = 'Sync Record Exists';
            CalcFormula = exist("E3 API Supplier Update Log" where("No." = field("No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(50016; "E3 MSME No."; Code[20])
        {
            Caption = 'MSME No.';
            DataClassification = CustomerContent;
        }
        field(50050; "Opening Balance (LCY)"; Decimal)
        {
            Caption = 'Opening Balance (LCY)';
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = field("No."),
                       "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                       "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                       "Currency Code" = field("Currency Filter"),
                       "Posting Date" = field("Opening Filter"),
                       "Entry Type" = filter(<> Application)));

            FieldClass = FlowField;
            Editable = false;
        }
        field(50051; "Closing Balance (LCY)"; Decimal)
        {
            Caption = 'Closing Balance (LCY)';
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = field("No."),
                       "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                       "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                       "Currency Code" = field("Currency Filter"),
                       "Posting Date" = field(UPPERLIMIT("Date Filter")),
                       "Entry Type" = filter(<> Application)));
            FieldClass = FlowField;
            Editable = false;
        }
        field(50052; "Opening Filter"; Date)
        {
            Caption = 'Opening Filter';
            FieldClass = FlowFilter;
        }
        field(50053; "Bank Integration"; Boolean)
        {
            Caption = 'Bank Integration Enabled';
            DataClassification = CustomerContent;
        }
        field(50054; "Payment Advice E-mail"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Advice Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            begin
                ValidateEmail();
            end;
        }

        modify("Date Filter")
        {
            trigger OnAfterValidate()
            begin
                IF GETFILTER("Date Filter") <> '' THEN BEGIN
                    SETRANGE("Opening Filter", 0D, GETRANGEMIN("Date Filter") - 1);
                END;

            end;
        }
    }
    trigger OnBeforeRename()
    begin
        if (Rec."No." <> xRec."No.") and (xRec."No." <> '') then
            Error('You cannot modify the Vendor No.');
    end;


    // trigger OnBeforeRename()
    // begin
    //     CalcFields("E3 Sync Record Exists");
    //     if "E3 Sync Record Exists" then
    //         Error('Record synchronized to HIS, rename is not allowed');
    // end;
    local procedure ValidateEmail()
    var
        MailManagement: Codeunit "Mail Management";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeValidateEmail(Rec, IsHandled, xRec);
        if IsHandled then
            exit;

        if "E-Mail" = '' then
            exit;
        MailManagement.CheckValidEmailAddresses("E-Mail");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateEmail(var Vendor: Record Vendor; var IsHandled: Boolean; xVendor: Record Vendor)
    begin
    end;


}
