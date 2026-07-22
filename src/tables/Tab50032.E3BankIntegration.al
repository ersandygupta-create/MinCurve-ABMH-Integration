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
        field(2; "Record Identifier"; Code[1])
        {
            Caption = 'Record Identifier';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the record identifier.';
        }

        field(3; "Payment Indicator"; Code[10])
        {
            Caption = 'Payment Indicator';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payment indicator.';
        }

        field(4; "SAP Document Number"; Code[20])
        {
            Caption = 'SAP Document Number';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the SAP document number.';
        }

        field(5; "Vendor / Beneficiary Code"; Code[20])
        {
            Caption = 'Vendor / Beneficiary Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the vendor or beneficiary code.';
        }

        field(6; "Name of Beneficiary"; Text[150])
        {
            Caption = 'Name of Beneficiary';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the beneficiary name.';
        }

        field(7; "Instrument Amount"; Decimal)
        {
            Caption = 'Instrument Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the instrument amount.';
        }

        field(8; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payment date.';
        }

        field(9; "Cheque Number"; Code[20])
        {
            Caption = 'Cheque Number';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the cheque number.';
        }

        field(10; "Debit Account No."; Code[30])
        {
            Caption = 'Debit Account No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the debit account number.';
        }

        field(11; "Beneficiary Bank A/c No"; Code[30])
        {
            Caption = 'Beneficiary Bank A/c No';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the beneficiary bank account number.';
        }

        field(12; "IFSC Code"; Code[20])
        {
            Caption = 'IFSC Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the IFSC code.';
        }

        field(13; "Beneficiary Bank Name"; Text[150])
        {
            Caption = 'Beneficiary Bank Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the beneficiary bank name.';
        }

        field(14; "Beneficiary Add1"; Text[100])
        {
            Caption = 'Beneficiary Add1';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the first beneficiary address.';
        }

        field(15; "Beneficiary Add 2"; Text[100])
        {
            Caption = 'Beneficiary Add 2';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the second beneficiary address.';
        }

        field(16; "Beneficiary Add 3"; Text[100])
        {
            Caption = 'Beneficiary Add 3';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the third beneficiary address.';
        }

        field(17; "Beneficiary Add 4"; Text[100])
        {
            Caption = 'Beneficiary Add 4';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the fourth beneficiary address.';
        }

        field(18; "Beneficiary Zip"; Code[20])
        {
            Caption = 'Beneficiary Zip';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the beneficiary ZIP code.';
        }

        field(19; "Debit Narration"; Text[100])
        {
            Caption = 'Debit Narration';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the debit narration.';
        }

        field(20; "Print Location"; Text[150])
        {
            Caption = 'Print Location';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the print location.';
        }

        field(21; "Payable Location"; Text[150])
        {
            Caption = 'Payable Location';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payable location.';
        }

        field(22; "Fiscal Year"; Code[20])
        {
            Caption = 'Fiscal Year';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the fiscal year.';
        }

        field(23; "Company Code"; Code[20])
        {
            Caption = 'Company Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the company code.';
        }

        field(24; "Email ID"; Text[100])
        {
            Caption = 'Email ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the email ID.';
        }

        field(25; "Mobile Number"; Code[20])
        {
            Caption = 'Mobile Number';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the mobile number.';
        }

        field(26; "AADHAR Number"; Code[20])
        {
            Caption = 'AADHAR Number';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Aadhaar number.';
        }

        field(27; "Bene LEI Number"; Code[30])
        {
            Caption = 'Bene LEI Number';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the beneficiary LEI number.';
        }

        field(28; "Bene LEI Expiry Date"; Date)
        {
            Caption = 'Bene LEI Expiry Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the beneficiary LEI expiry date.';
        }

        field(29; "Duplicate Validation Field"; Text[100])
        {
            Caption = 'Duplicate Validation Field';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the duplicate validation field.';
        }
        field(30; "File Name"; Text[50])
        {
            Caption = 'File Name';
            DataClassification = CustomerContent;
        }
        field(31; "Bank Account Ledger Entry No."; Integer)
        {
            Caption = 'Bank Account Ledger Entry No.';
            DataClassification = CustomerContent;
        }
        field(32; "BALE updated"; Boolean)
        {
            Caption = 'BALE updated';
            DataClassification = CustomerContent;
        }
        field(33; FLD1; Text[80])
        {
            Caption = 'FLD1';
            DataClassification = CustomerContent;
        }
        field(34; FLD2; Text[80])
        {
            Caption = 'FLD2';
            DataClassification = CustomerContent;
        }
        field(35; "UTR No."; Code[35])
        {
            DataClassification = ToBeClassified;
        }



    }

    keys
    {
        key(PK; EntryNo)
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