tableextension 50002 "E3 Gen. Journal Line Exts" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "E3 UTR No."; Code[35])
        {
            Caption = 'UTR No.';
            DataClassification = CustomerContent;
        }
        field(50001; "E3 HIS Module"; Text[30])
        {
            Caption = 'HIS Module';
            DataClassification = CustomerContent;
        }
        field(50002; "E3 HIS Document Type"; Text[60])
        {
            Caption = 'HIS Document Type';
            DataClassification = CustomerContent;
        }
        field(50011; "E3 Store Code"; Code[10])
        {
            Caption = 'Store Code';
            DataClassification = CustomerContent;
        }
        field(50012; "E3 Sub Group Code"; Code[10])
        {
            Caption = 'Sub Group Code';
            DataClassification = CustomerContent;
        }
        field(50013; "E3 Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            DataClassification = CustomerContent;
        }
        field(50014; "E3 UHID"; Code[20])
        {
            Caption = 'UHID';
            DataClassification = CustomerContent;
        }
        field(50015; "E3 Patient Name"; Text[100])
        {
            Caption = 'Patient Name';
            DataClassification = CustomerContent;
        }
        field(50016; "E3 Validation Key"; Text[50])
        {
            Caption = 'Vaidation Key';
            DataClassification = CustomerContent;
        }
        field(50017; "E3 Narration"; Text[150])
        {
            Caption = 'Narrantion';
            DataClassification = CustomerContent;
        }
        field(50018; "E3 Transaction Type"; Text[50])
        {
            Caption = 'Transaction Type';
            DataClassification = CustomerContent;
        }
        field(50019; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            TableRelation = "Vendor Adv. Pay. Ag. PO" where("Vendor Code" = field("Account No."));//, "Remaining Amount" = filter(<> 0));
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                VendAdvPayAgPO: Record "Vendor Adv. Pay. Ag. PO";
                decAmount: Decimal;
            begin
                VendAdvPayAgPO.Reset();
                VendAdvPayAgPO.SetRange("Entry Type", VendAdvPayAgPO."Entry Type"::"Purchase Order");
                VendAdvPayAgPO.SetRange("Purchase Order No.", "Purchase Order No.");
                IF VendAdvPayAgPO.FindFirst() then begin
                    VendAdvPayAgPO.CalcFields("Total Applied Amount");
                    IF ((VendAdvPayAgPO."Total PO Amount" - VendAdvPayAgPO."Total Applied Amount") = 0) then
                        Error('No Purchase order is pending to apply Amount');

                    IF ((VendAdvPayAgPO."Total PO Amount" - VendAdvPayAgPO."Total Applied Amount") < "Amount (LCY)") then
                        Error('Remaining Amount is less than Bank Payment Amount so Entry Can''t be applied');

                    if (VendAdvPayAgPO."Total PO Amount" < "Amount (LCY)") OR ("Amount (LCY)" = 0) then
                        Error('Purchase Order Amount is less than Bank Payment Amount');

                    VendAdvPayAgPO.CalcFields("Total Applied Amount");
                    VendAdvPayAgPO."Remaining Amount" := (VendAdvPayAgPO."Total PO Amount" - VendAdvPayAgPO."Total Applied Amount");
                    VendAdvPayAgPO.Modify();
                end
            end;
        }
        field(50100; "E3 Encounter No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Encounter No.';
        }
        field(50102; "E3 Doctor Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Doctor Name';
        }
        field(50103; "E3 Speciality"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Speciality';
        }
        field(50104; "E3 Sponsor Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sponsor Code';
        }
        field(50105; "E3 Sponsor Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Sponsor Name';
        }
        field(50106; "E3 Payer Code"; Code[16])
        {
            DataClassification = CustomerContent;
            Caption = 'Payer Code';
        }
        field(50107; "E3 Payer Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Payer Name';
        }
        field(50108; "E3 Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(50109; "E3 IFSC Code"; Text[20])
        {
            Caption = 'IFSC Code';
        }
        field(50110; "E3 Branch"; Text[100])
        {
            Caption = 'Branch';
        }
        field(50111; "Bank Integration"; Boolean)
        {
            Caption = 'Bank Integration';
            DataClassification = CustomerContent;
        }


    }
}