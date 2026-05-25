table 50032 "E3 Bank Integration"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNo; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            BlankZero = true;
            MinValue = 1;
            DataClassification = CustomerContent;
        }
        field(2; PaymentTy; Text[1])
        {
            DataClassification = ToBeClassified;

        }
        field(3; BeneficiaryAccNo; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Recipient Bank Account"; Code[30])
        {
            DataClassification = ToBeClassified;

        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(6; BeneficiaryName; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(7; DraweeLocation; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(8; PrintLocation; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(9; BeneAddress1; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(10; BeneAddress2; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(11; BeneAddress3; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(12; BeneAddress4; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(13; BeneAddress5; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(14; "Bal. Account No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(15; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(16; Paymentdetails1; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(17; Paymentdetails2; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(18; Paymentdetails3; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(19; Paymentdetails4; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(20; Paymentdetails5; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(21; Paymentdetails6; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(22; Paymentdetails7; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(23; "Cheque No."; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(24; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(25; MICRNumber; Text[30])
        {
            DataClassification = ToBeClassified;

        }
        field(26; "Recipient Bank IFSC Code"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(27; "Recipient Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(28; "Recipient Branch Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(29; Beneficiaryemailid; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(30; "UTR No."; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
            DataClassification = CustomerContent;
        }
        field(32; FLD1; Text[80])
        {
            Caption = 'FLD1';
            DataClassification = CustomerContent;
        }
        field(33; FLD2; Text[80])
        {
            Caption = 'FLD2';
            DataClassification = CustomerContent;
        }
        field(34; FLD3; Text[80])
        {
            Caption = 'FLD3';
            DataClassification = CustomerContent;
        }
        field(35; FLD4; Text[80])
        {
            Caption = 'FLD4';
            DataClassification = CustomerContent;
        }
        field(36; FLD5; Text[80])
        {
            Caption = 'FLD5';
            DataClassification = CustomerContent;
        }
        field(37; FLD6; Text[80])
        {
            Caption = 'FLD6';
            DataClassification = CustomerContent;
        }
        field(38; FLD7; Text[80])
        {
            Caption = 'FLD7';
            DataClassification = CustomerContent;
        }
        field(39; FLD8; Text[80])
        {
            Caption = 'FLD8';
            DataClassification = CustomerContent;
        }
        field(40; FLD9; Text[80])
        {
            Caption = 'FLD9';
            DataClassification = CustomerContent;
        }
        field(41; FLD10; Text[80])
        {
            Caption = 'FLD10';
            DataClassification = CustomerContent;
        }
        field(42; FLD11; Text[80])
        {
            Caption = 'FLD11';
            DataClassification = CustomerContent;
        }
        field(43; FLD12; Text[80])
        {
            Caption = 'FLD12';
            DataClassification = CustomerContent;
        }
        field(44; FLD13; Text[80])
        {
            Caption = 'FLD13';
            DataClassification = CustomerContent;
        }
        field(45; FLD14; Text[80])
        {
            Caption = 'FLD14';
            DataClassification = CustomerContent;
        }
        field(46; FLD15; Text[80])
        {
            Caption = 'FLD15';
            DataClassification = CustomerContent;
        }
        field(47; FLD16; Text[80])
        {
            Caption = 'FLD16';
            DataClassification = CustomerContent;
        }
        field(48; FLD17; Text[80])
        {
            Caption = 'FLD17';
            DataClassification = CustomerContent;
        }
        field(49; FLD18; Text[80])
        {
            Caption = 'FLD18';
            DataClassification = CustomerContent;
        }
        field(50; FLD19; Text[80])
        {
            Caption = 'FLD19';
            DataClassification = CustomerContent;
        }
        field(51; FLD20; Text[80])
        {
            Caption = 'FLD20';
            DataClassification = CustomerContent;
        }
        field(52; "File Name"; Text[50])
        {
            Caption = 'File Name';
            DataClassification = CustomerContent;
        }
        field(53; "Bank Account Ledger Entry No."; Integer)
        {
            Caption = 'Bank Account Ledger Entry No.';
            DataClassification = CustomerContent;
        }
        field(54; "BALE updated"; Boolean)
        {
            Caption = 'BALE updated';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}