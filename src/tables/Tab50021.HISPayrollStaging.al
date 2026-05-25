table 50021 "E3 HIS Payroll Staging"
{
    Caption = 'HIS Payroll Staging';
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
        field(14; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(15; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(16; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(17; "IsProcess"; Boolean)
        {
            Caption = 'IsProcess';
            DataClassification = CustomerContent;
        }

        field(18; "Bank Account Name"; Text[100])
        {
            Caption = 'Bank Account Name';
            DataClassification = CustomerContent;
        }
        field(19; "Bank Branch No."; Text[30])
        {
            Caption = 'Bank Branch No.';
            DataClassification = CustomerContent;
        }
        field(20; "Bank Account No."; Code[30])
        {
            Caption = 'Bank Account No.';
            DataClassification = CustomerContent;
        }
        field(21; "IFSC Code"; Text[20])
        {
            Caption = 'IFSC Code';
            DataClassification = CustomerContent;
        }
        field(22; Narration; Text[200])
        {
            Caption = 'Narration';
            DataClassification = CustomerContent;
        }
        field(23; "Group Name"; Text[200])
        {
            Caption = 'Group Name';
            DataClassification = CustomerContent;
        }
        field(24; "Salary Code"; Code[20])
        {
            Caption = 'Salary Code';
            DataClassification = CustomerContent;
        }
        field(25; "Salary Head"; Text[200])
        {
            Caption = 'Salary Head';
            DataClassification = CustomerContent;
        }
        field(26; "Employee Status"; Text[50])
        {
            Caption = 'Employee Status';
            DataClassification = CustomerContent;
        }
        field(27; "Date of Joining"; Date)
        {
            Caption = 'Date of Joining';
            DataClassification = CustomerContent;
        }
        field(28; "Date of Leaving"; Date)
        {
            Caption = 'Date of Leaving';
            DataClassification = CustomerContent;
        }
        field(29; Designation; Text[100])
        {
            Caption = 'Designation';
            DataClassification = CustomerContent;
        }
        field(30; Grade; Text[50])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
        }
        field(31; "Cost Center Code"; Code[20])
        {
            Caption = 'Cost Center Code';
            DataClassification = CustomerContent;
        }
        field(32; "Cost Center Name"; Text[100])
        {
            Caption = 'Cost Center Name';
            DataClassification = CustomerContent;
        }
        field(33; Gender; Enum "Employee Gender")
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
        }
        field(34; PAN; Code[10])
        {
            Caption = 'PAN';
            DataClassification = CustomerContent;
        }
        field(35; "Paymode"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'PAYMODE';
        }
        field(36; "Salary Hold"; Boolean)
        {
            Caption = 'Salary Hold';
            DataClassification = CustomerContent;
        }
        field(37; "PF No."; Code[20])
        {
            Caption = 'PF No.';
            DataClassification = CustomerContent;
        }
        field(38; "UAN No."; Code[20])
        {
            Caption = 'UAN No.';
            DataClassification = CustomerContent;
        }
        field(39; "ESI No."; Code[20])
        {
            Caption = 'ESI No.';
            DataClassification = CustomerContent;
        }
        field(40; "PT Location"; Text[50])
        {
            Caption = 'PT Location';
            DataClassification = CustomerContent;
        }
        field(41; "Arrear Days"; Decimal)
        {
            Caption = 'Arrear Days';
            DataClassification = CustomerContent;
        }
        field(42; Stddays; Decimal)
        {
            Caption = 'Stddays';
            DataClassification = CustomerContent;
        }
        field(43; WRKDAYS; Decimal)
        {
            Caption = 'WRKDAYS';
            DataClassification = CustomerContent;
        }
        field(44; "LOP DAYS"; Decimal)
        {
            Caption = 'LOP_DAYS';
            DataClassification = CustomerContent;
        }
        field(45; ARREARDAYS; Decimal)
        {
            Caption = 'ARREARDAYS';
            DataClassification = CustomerContent;
        }
        field(46; "Basic Amount"; Decimal)
        {
            Caption = 'BASIC Amount';
            DataClassification = CustomerContent;
        }
        field(47; HRA; Decimal)
        {
            Caption = 'HRA';
            DataClassification = CustomerContent;
        }
        field(48; EXGRATIA; Decimal)
        {
            Caption = 'EXGRATIA';
            DataClassification = CustomerContent;
        }
        field(49; "SPL ALLOW"; Decimal)
        {
            Caption = 'SPL_ALLOW';
            DataClassification = CustomerContent;
        }
        field(50; "OTHER EARN"; Decimal)
        {
            Caption = 'OTHER_EARN';
            DataClassification = CustomerContent;
        }
        field(51; "GROSS EARN"; Decimal)
        {
            Caption = 'GROSS_EARN';
            DataClassification = CustomerContent;
        }
        field(52; "PF Amount"; Decimal)
        {
            Caption = 'PF Amount';
            DataClassification = CustomerContent;
        }
        field(53; "ESI Amount"; Decimal)
        {
            Caption = 'ESI Amount';
            DataClassification = CustomerContent;
        }
        field(54; "VPF SAL"; Decimal)
        {
            Caption = 'VPF_SAL';
            DataClassification = CustomerContent;
        }
        field(55; "HOSTEL_D"; Decimal)
        {
            Caption = 'HOSTEL_D';
            DataClassification = CustomerContent;
        }
        field(56; "P_LOAN"; Decimal)
        {
            Caption = 'P_LOAN';
            DataClassification = CustomerContent;
        }
        field(57; EECLWF; Decimal)
        {
            Caption = 'EECLWF';
            DataClassification = CustomerContent;
        }
        field(58; IT; Decimal)
        {
            Caption = 'IT';
            DataClassification = CustomerContent;
        }
        field(59; GROSS_DED; Decimal)
        {
            Caption = 'GROSS_DED';
            DataClassification = CustomerContent;
        }
        field(60; "Net Pay"; Decimal)
        {
            Caption = 'NET PAY';
            DataClassification = CustomerContent;
        }
        field(61; LV_ENC_SET; Decimal)
        {
            Caption = 'LV_ENC_SET';
            DataClassification = CustomerContent;
        }
        field(62; SHIFT_ALL; Decimal)
        {
            Caption = 'SHIFT_ALL';
            DataClassification = CustomerContent;
        }
        field(63; BONUS_F; Decimal)
        {
            Caption = 'BONUS_F';
            DataClassification = CustomerContent;
        }
        field(64; NOT_E_DED; Decimal)
        {
            Caption = 'NOT_E_DED';
            DataClassification = CustomerContent;
        }
        field(65; CONV; Decimal)
        {
            Caption = 'CONV';
            DataClassification = CustomerContent;
        }
        field(66; FOOD_A; Decimal)
        {
            Caption = 'FOOD_A';
            DataClassification = CustomerContent;
        }
        field(67; CCU; Decimal)
        {
            Caption = 'CCU';
            DataClassification = CustomerContent;
        }
        field(68; RETEN_AMT; Decimal)
        {
            Caption = 'RETEN_AMT';
            DataClassification = CustomerContent;
        }
        field(69; OTHER_DEDN; Decimal)
        {
            Caption = 'OTHER_DEDN';
            DataClassification = CustomerContent;
        }
        field(70; OTH_DED; Decimal)
        {
            Caption = 'OTH_DED';
            DataClassification = CustomerContent;
        }
        field(71; PVCTC; Decimal)
        {
            Caption = 'PVCTC';
            DataClassification = CustomerContent;
        }
        field(72; BONCTCP; Decimal)
        {
            Caption = 'BONCTCP';
            DataClassification = CustomerContent;
        }
        field(73; INCENTIVE; Decimal)
        {
            Caption = 'INCENTIVE';
            DataClassification = CustomerContent;
        }
        field(74; PT; Decimal)
        {
            Caption = 'PT';
            DataClassification = CustomerContent;
        }
        field(75; "Validation Key"; Text[50])
        {
            Caption = 'Validation Key';
            DataClassification = CustomerContent;
        }
        field(76; GRATUITY; Decimal)
        {
            Caption = 'GRATUITY';
            DataClassification = CustomerContent;
        }
        field(77; "Shortcut Dimension 3 Code"; Code[20])
        {
            //CaptionClass = '1,1,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(78; "Shortcut Dimension 5 Code"; Code[20])
        {
            //CaptionClass = '1,1,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if Rec."Salary Head" <> '' then
            Rec."Shortcut Dimension 5 Code" := Rec."Salary Head"
    end;

    trigger OnModify()
    begin
        if Rec."Salary Head" <> '' then
            Rec."Shortcut Dimension 5 Code" := Rec."Salary Head"
    end;

}
