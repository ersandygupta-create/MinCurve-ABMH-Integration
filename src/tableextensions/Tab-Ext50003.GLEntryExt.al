tableextension 50003 "E3 HIS G/L Entry" extends "G/L Entry"
{
    fields
    {
        field(50000; "E3 UTR No."; Code[35])
        {
            DataClassification = CustomerContent;
            Caption = 'UTR No.';
        }
        field(50001; "E3 HIS Module"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'HIS Module';
        }
        field(50002; "E3 HIS Document Type"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'HIS Document Type';
        }
        field(50011; "E3 Store Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Store Code';
        }
        field(50012; "E3 Sub Group Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Sub Group Code';
        }
        field(50013; "E3 Receipt No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt No.';
        }
        field(50014; "E3 UHID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'UHID';
        }
        field(50015; "E3 Patient Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Patient Name';
        }
        field(50016; "E3 Validation Key"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Validation Key';
        }
        field(50017; "E3 Narration"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Narration';
        }
        field(50018; "E3 Transaction Type"; Text[50])
        {
            Caption = 'Transaction Type';
            DataClassification = CustomerContent;
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
        field(50120; "E3 Line Narration"; Text[250])
        {
            Caption = 'Line Narration';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Narration".Narration where("Entry No." = field("Entry No."), "Transaction No." = field("Transaction No.")));
        }
        field(50121; "E3 Voucher Narration"; Text[250])
        {
            Caption = 'Voucher Narration';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Narration".Narration where("Entry No." = const(0), "Transaction No." = field("Transaction No.")));
        }
    }
}