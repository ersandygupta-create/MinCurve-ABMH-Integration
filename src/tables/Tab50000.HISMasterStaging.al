table 50000 "E3 HIS Master Staging"
{
    Caption = 'HIS Master Staging ';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            BlankZero = true;
            MinValue = 1;
            DataClassification = CustomerContent;
        }
        field(2; "Party Type"; Option)
        {
            Caption = 'Party Type';
            OptionMembers = ,Vendor,Customer,Employee,Item,Doctor;
            DataClassification = CustomerContent;
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(4; "Search Name"; Text[100])
        {
            Caption = 'Search Name';
            DataClassification = CustomerContent;
        }
        field(5; "Name 2"; Text[100])
        {
            Caption = 'Name 2';
            DataClassification = CustomerContent;
        }
        field(6; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(7; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(8; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(9; "State Code"; Code[10])
        {
            Caption = 'State Code';
            TableRelation = State;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(10; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            ValidateTableRelation = false;
        }
        field(11; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(12; County; Text[30])
        {
            Caption = 'County';
            CaptionClass = '5,1,' + "Country/Region Code";
            DataClassification = CustomerContent;
        }
        field(13; Contact; Text[50])
        {
            Caption = 'Contact';
            DataClassification = CustomerContent;
        }
        field(14; "Phone No."; Text[11])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
        }
        field(15; "Vendor/Customer Code"; Code[20])
        {
            Caption = 'Vendor/Customer Code';
            TableRelation = IF ("Party Type" = const(Vendor)) "Vendor"
            else
            if ("Party Type" = const(Customer)) "Customer";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Name := '';
                IF "party Type" = "party Type"::Vendor then begin
                    Vendor.Get("Vendor/Customer Code");
                    Name := Vendor.Name;
                    "Name 2" := Vendor."Name 2";
                end;
                IF "party Type" = "party Type"::Customer then begin
                    Customer.Get("Vendor/Customer Code");
                    Name := Customer.Name;
                    "Name 2" := Customer."Name 2";
                end;
                IF "party Type" = "party Type"::Employee then begin
                    Employee.Get("Vendor/Customer Code");
                    Name := Employee."First Name";
                    "Name 2" := Employee."Last Name";
                end;

            end;
        }
        field(16; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(17; "Vendor Posting Group"; Code[20])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(18; "Customer Posting Group"; Code[20])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(19; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(20; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionMembers = ,"G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            DataClassification = CustomerContent;
        }
        field(21; "Payment Type"; Code[30])
        {
            Caption = 'Payment Type';
            DataClassification = CustomerContent;
        }
        field(22; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(23; "Application Method"; Enum "Application Method")
        {
            Caption = 'Application Method';
            DataClassification = CustomerContent;
        }
        field(24; "P.A.N. No."; Code[10])
        {
            Caption = 'P.A.N. No.';
            DataClassification = CustomerContent;
        }
        field(25; "GST Registration No."; Code[15])
        {
            Caption = 'GST Registration No.';
            DataClassification = CustomerContent;
        }
        field(26; "GST Vendor Type"; Enum "GST Vendor Type")
        {
            Caption = 'GST Vendor Type';
            DataClassification = CustomerContent;
        }
        field(27; "Error Description"; Text[250])
        {
            Caption = 'Error Description';
            DataClassification = CustomerContent;
        }
        field(28; IsCreated; Boolean)
        {
            Caption = 'IsCreated';
            DataClassification = CustomerContent;
        }
        field(29; "HIS Code"; Code[20])
        {
            Caption = 'HIS Code';
            DataClassification = CustomerContent;
        }
        field(30; "MSME Type"; Boolean)
        {
            Caption = 'MSME Type';
            DataClassification = CustomerContent;
        }
        field(31; Certificate; Blob)
        {
            Caption = 'Certificate';
            DataClassification = CustomerContent;
        }
        field(32; "HIS Interface By"; Code[50])
        {
            Caption = 'HIS Interface By';
            DataClassification = CustomerContent;
        }
        field(33; "HIS Interface Date Time"; DateTime)
        {
            Caption = 'HIS Interface Date Time';
            DataClassification = CustomerContent;
        }
        field(34; "Modified by"; Code[50])
        {
            Caption = 'Modified by';
            DataClassification = CustomerContent;
        }
        field(35; "Modified Date Time"; DateTime)
        {
            Caption = 'Modified Date Time';
            DataClassification = CustomerContent;
        }

        field(36; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            ValidateTableRelation = false;
        }
        field(37; "GST Customer Type"; Enum "GST Customer Type")
        {
            Caption = 'GST Customer Type';
            DataClassification = CustomerContent;
        }

        field(39; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
            ValidateTableRelation = false;
        }
        field(40; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Product Posting Group";
            ValidateTableRelation = false;
        }
        field(41; "Inventory Posting Group"; Code[20])
        {
            Caption = 'Inventory Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Inventory Posting Group";
            ValidateTableRelation = false;
        }
        field(42; "Base Unit of Measure"; Code[20])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;
        }
        field(43; "GST Group Code"; code[10])
        {
            Caption = 'GST Group Code';
            TableRelation = "GST Group";
            ValidateTableRelation = false;
        }
        field(44; "HSN/SAC Code"; code[10])
        {
            Caption = 'HSN/SAC Code';
            TableRelation = "HSN/SAC".Code WHERE("GST Group Code" = FIELD("GST Group Code"));
            ValidateTableRelation = false;
        }
        field(45; "GST Credit"; Enum "GST Credit")
        {
            Caption = 'GST Credit';
        }
        field(46; "Employee Posting Group"; Code[20])
        {
            Caption = 'Employee Posting Group';
            TableRelation = "Employee Posting Group";
            ValidateTableRelation = false;
        }
        field(47; "Bank Account Name"; Code[100])
        {
            Caption = 'Bank Account Name';
        }
        field(48; "Bank Branch No."; Text[20])
        {
            Caption = 'Bank Branch No.';
        }
        field(49; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(50; "Bank Address"; Text[100])
        {
            Caption = 'Bank Address';
        }
        field(51; "Bank Address 2"; Text[50])
        {
            Caption = 'Bank Address 2';
        }
        field(52; "VC Bank Account Name"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(53; "Bank City"; Text[30])
        {
            Caption = 'Bank City';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));

            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(54; "Bank Post Code"; Code[20])
        {
            Caption = 'Bank Post Code';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            ValidateTableRelation = false;
        }
        field(55; "IFSC Code"; Text[20])
        {
            Caption = 'IFSC Code';
        }

        field(56; "Item Type"; Enum "E3 HIS Item Type")
        {
            Caption = 'HIS Type';
            DataClassification = CustomerContent;
        }

        field(57; "HIS Type"; Enum "E3 HIS Type")
        {
            Caption = 'HIS Type';
            DataClassification = CustomerContent;
        }

        field(58; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            begin
                ValidateEmail();
            end;
        }
        field(59; "Sponser code"; Code[30])
        {
            Caption = 'Sponser code';
        }
        field(60; "Sponser Name"; Text[100])
        {
            Caption = 'Sponser Name';
        }
        field(64; "Item ID"; Code[20])
        {
            Caption = 'Item ID';
            DataClassification = CustomerContent;
        }
        field(65; "Item Category Name"; text[50])
        {
            Caption = 'Item Category Name';
            DataClassification = CustomerContent;
        }
        field(66; "Item Sub Category Code"; Code[20])
        {
            Caption = 'Item Sub Category Code';
            DataClassification = ToBeClassified;
        }
        field(67; "Item Sub Category Name"; Text[50])
        {
            Caption = 'Item Sub Category Name';
            DataClassification = ToBeClassified;
        }
        field(68; "Substitute Category"; Text[150])
        {
            Caption = 'Substitute Category';
            DataClassification = ToBeClassified;
        }
        field(69; "Generic Name"; Text[150])
        {
            Caption = 'Generic Name';
            DataClassification = ToBeClassified;
        }
        field(70; "Pack Size"; Text[10])
        {
            Caption = 'Pack Size';
            DataClassification = ToBeClassified;
        }
        field(71; "Inventory-NonInventory"; Enum "Item Type")
        {
            Caption = 'Inventory-NonInventory Item';

        }
        field(75; "MSME No."; Code[20])
        {
            Caption = 'MSME No.';
            DataClassification = CustomerContent;
        }
        field(76; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
            DataClassification = CustomerContent;
        }
        field(77; Gender; Enum "Employee Gender")
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
        }
        field(78; "Date of Joining"; Date)
        {
            Caption = 'Date of Joining';
            DataClassification = CustomerContent;
        }
        field(79; "Date of Leaving"; Date)
        {
            Caption = 'Date of Leaving';
            DataClassification = CustomerContent;
        }
        field(80; Designation; Text[100])
        {
            Caption = 'Designation';
            DataClassification = CustomerContent;
        }
        field(81; Grade; Text[100])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
        }
        field(82; Title; Text[20])
        {
            Caption = 'Title';
            DataClassification = CustomerContent;
        }
        field(83; "Sub Department Name"; Text[100])
        {
            Caption = 'Sub Department Name';
            DataClassification = CustomerContent;
        }
        field(84; Speciality; Text[100])
        {
            Caption = 'Speciality';
            DataClassification = CustomerContent;
        }
        field(85; "Employment Type"; Text[100])
        {
            Caption = 'Employment Type';
            DataClassification = CustomerContent;
        }
        field(86; Aadhar; Code[12])
        {
            Caption = 'Aadhar';
            DataClassification = CustomerContent;
        }
        field(87; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = ,Active,Inactive,Terminated;
            DataClassification = CustomerContent;
        }
        field(88; "Valid From"; Date)
        {
            Caption = 'Valid From';
            DataClassification = CustomerContent;
        }
        field(89; "Valid To"; Date)
        {
            Caption = 'Valid To';
            DataClassification = CustomerContent;
        }
        field(90; "Mobile No."; Text[10])
        {
            Caption = 'Mobile No.';
            DataClassification = CustomerContent;
        }
        field(91; Qualification; Text[50])
        {
            Caption = 'Qualification';
            DataClassification = CustomerContent;
        }
        field(92; "Registration No."; Text[50])
        {
            Caption = 'Registration No.';
            DataClassification = CustomerContent;
        }
        field(93; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            DataClassification = CustomerContent;
        }
        field(94; "Unit Name"; Text[100])
        {
            Caption = 'Unit Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name WHERE("Global Dimension No." = CONST(1),
            Code = field("Global Dimension 1 Code")));
        }
        field(95; Experience; Text[50])
        {
            Caption = 'Experience';
            DataClassification = CustomerContent;
        }
        field(96; "Purchase Allowed"; Boolean)
        {
            Caption = 'Purchase Allowed';
            DataClassification = CustomerContent;
        }
        field(97; "Engagement Mode"; Text[50])
        {
            Caption = 'Engagement Mode';
            DataClassification = CustomerContent;
        }
        field(98; "Payment Mode"; Text[50])
        {
            Caption = 'Payment Mode';
            DataClassification = CustomerContent;
        }
        field(99; Paygroup; Text[50])
        {
            Caption = 'Paygroup';
            DataClassification = CustomerContent;
        }
        field(100; "Employee Type"; Text[30])
        {
            Caption = 'Employee Type';
            DataClassification = CustomerContent;
        }
        field(101; "Item Status"; Enum "E3 HIS Item Status")
        {
            Caption = 'Item Status';
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key1; "HIS Code")
        {
        }
    }
    var
        PostCode: Record "Post Code";

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLookupCity(var Vendor: Record Vendor; var PostCodeRec: Record "Post Code")
    begin
    end;


    [IntegrationEvent(false, false)]
    local procedure OnBeforeLookupPostCode(var Vendor: Record Vendor; var PostCodeRec: Record "Post Code")
    begin
    end;

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
    local procedure OnBeforeValidateEmail(var HISMasterStaging: Record "E3 HIS Master Staging"; var IsHandled: Boolean; xHISMasterStaging: Record "E3 HIS Master Staging")
    begin
    end;

    var
        Vendor: Record Vendor;
        Customer: Record Customer;
        Employee: Record Employee;

}
