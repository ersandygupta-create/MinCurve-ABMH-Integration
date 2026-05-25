table 50020 "E3 HIS Doctor Payout"
{
    Caption = 'HIS Doctor Payout';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(3; "HIS Document Type"; Text[60])
        {
            Caption = 'HIS Document Type';
            DataClassification = CustomerContent;
        }
        field(4; "Document Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(5; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = CustomerContent;
        }
        field(6; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Account Type" = CONST(Employee)) Employee;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(7; "External Document No."; Code[30])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
        }
        field(8; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(9; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Bal. Account Type';
            DataClassification = CustomerContent;
        }
        field(10; "Bal. Account No"; Code[20])
        {
            Caption = 'Bal. Account No';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                               Blocked = CONST(false))
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Bal. Account Type" = CONST(Employee)) Employee;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(14; "Line Narration"; Text[150])
        {
            Caption = 'Line Narration';
            DataClassification = CustomerContent;
        }
        field(15; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(16; "General Entries Created"; Boolean)
        {
            Caption = 'General Entries Created';
            DataClassification = CustomerContent;
        }
        field(17; "General Template Code"; Code[10])
        {
            Caption = 'General Template Code';
            TableRelation = "Gen. Journal Template";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(18; "General Batch Code"; Code[10])
        {
            Caption = 'General Batch Code';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("General Template Code"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(19; TRANSACTION_TYPE; Text[50])
        {
            Caption = 'TRANSACTION_TYPE';
            DataClassification = CustomerContent;
        }
        field(20; "Encounter No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Encounter No.';
        }
        field(21; "Mode of Payment"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Mode of Payment';
        }
        field(22; "IP No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'IP No.';
        }
        field(23; "Patient Name"; Text[100])
        {
            Caption = 'Patient Name';
            DataClassification = CustomerContent;
        }
        field(24; "TDS Section"; Code[20])
        {
            Caption = 'TDS Section Code';
            TableRelation = "TDS Section";
            DataClassification = CustomerContent;
        }
        field(25; UHID; Code[20])
        {
            Caption = 'UHID';
            DataClassification = CustomerContent;
        }
        field(26; "Doctor ID"; Text[50])
        {
            Caption = 'Doctor ID';
            DataClassification = CustomerContent;
        }
        field(27; "Doctor Name"; Text[100])
        {
            Caption = 'Doctor Name';
            DataClassification = CustomerContent;
        }
        field(28; "Gross Before TDS"; Decimal)
        {
            Caption = 'Gross Before TDS';
            DataClassification = CustomerContent;
        }
        field(29; "TDS Amount"; Decimal)
        {
            Caption = 'TDS Amount';
            DataClassification = CustomerContent;
        }
        field(30; "Gross After TDS"; Decimal)
        {
            Caption = 'Gross After TDS';
            DataClassification = CustomerContent;
        }
        field(31; "After TDS Earn"; Decimal)
        {
            Caption = 'After TDS Earn';
            DataClassification = CustomerContent;
        }
        field(32; "After TDS Dedu."; Decimal)
        {
            Caption = 'After TDS Dedu.';
            DataClassification = CustomerContent;
        }
        field(33; "Net Payable Amount"; Decimal)
        {
            Caption = 'Net Payable Amount';
            DataClassification = CustomerContent;
        }
        field(34; "Expense G/L Code"; Code[20])
        {
            Caption = 'Expense G/L Code';
            DataClassification = CustomerContent;
        }
        field(35; "Month Year"; Date)
        {
            Caption = 'Month Year';
            DataClassification = CustomerContent;
        }
        field(36; "Payment Type"; Text[50])
        {
            Caption = 'Payment Type';
            DataClassification = CustomerContent;
        }
        field(37; "OP Payout Type Name"; Text[100])
        {
            Caption = 'OP Payout Type Name';
            DataClassification = CustomerContent;
        }
        field(38; "IP Payout Type Name"; Text[100])
        {
            Caption = 'IP Payout Type Name';
            DataClassification = CustomerContent;
        }
        field(39; "Gross OP Amount"; Decimal)
        {
            Caption = 'Gross OP Amount';
            DataClassification = CustomerContent;
        }
        field(40; "Gross IP Amount"; Decimal)
        {
            Caption = 'Gross IP Amount';
            DataClassification = CustomerContent;
        }
        field(41; "Net Bill Amount"; Decimal)
        {
            Caption = 'Net Bill Amount';
            DataClassification = CustomerContent;
        }
        field(42; "Doc. OP Amount"; Decimal)
        {
            Caption = 'Doc. OP Amount';
            DataClassification = CustomerContent;
        }
        field(43; "Doc. IP Amount"; Decimal)
        {
            Caption = 'Doc. IP Amount';
            DataClassification = CustomerContent;
        }
        field(44; "Doc. Net Amount"; Decimal)
        {
            Caption = 'Doc. Net Amount';
            DataClassification = CustomerContent;
        }
        field(45; "Doc. Accrual"; Decimal)
        {
            Caption = 'Doc. Accrual';
            DataClassification = CustomerContent;
        }
        field(46; "Doc. Payable Amount"; Decimal)
        {
            Caption = 'Doc. Payable Amount';
            DataClassification = CustomerContent;
        }
        field(47; "Adjusted Amount"; Decimal)
        {
            Caption = 'Adjusted Amount';
            DataClassification = CustomerContent;
        }
        field(48; "Minimum Guarantee Amt"; Decimal)
        {
            Caption = 'Minimum Guarantee Amt';
            DataClassification = CustomerContent;
        }
        field(49; "Monthly Fixed Amt"; Decimal)
        {
            Caption = 'Monthly Fixed Amt';
            DataClassification = CustomerContent;
        }
        field(50; "Net Doctor Payable"; Decimal)
        {
            Caption = 'Net Doctor Payable';
            DataClassification = CustomerContent;
        }
        field(51; "Before TDS Earn"; Decimal)
        {
            Caption = 'Before TDS Earn';
            DataClassification = CustomerContent;
        }
        field(52; "Before TDS Dedu."; Decimal)
        {
            Caption = 'Before TDS Dedu.';
            DataClassification = CustomerContent;
        }
        field(53; "Unit Name"; Text[100])
        {
            Caption = 'Unit Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name WHERE("Global Dimension No." = CONST(1),
            Code = field("Shortcut Dimension 1 Code")));
        }

    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

}
