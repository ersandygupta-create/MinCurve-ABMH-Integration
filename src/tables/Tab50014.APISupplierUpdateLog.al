table 50014 "E3 API Supplier Update Log"
{
    Caption = 'API Supplier Update Log';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(4; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(5; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
        }
        field(8; Contact; Text[100])
        {
            Caption = 'Contact';
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
        }
        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
        field(21; "Vendor Posting Group"; Code[20])
        {
            Caption = 'Vendor Posting Group';
        }
        field(27; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
        }
        field(53; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
        }
        field(84; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'Email';
        }
        field(288; "Preferred Bank Account Code"; Code[20])
        {
            Caption = 'Preferred Bank Account Code';
        }
        field(5061; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
        }
        field(18080; "GST Registration No."; Code[20])
        {
            Caption = 'GST Registration No.';
            DataClassification = CustomerContent;
        }
        field(18081; "GST Vendor Type"; Enum "GST Vendor Type")
        {
            Caption = 'GST Vendor Type';
            DataClassification = CustomerContent;
        }
        field(18544; "P.A.N. No."; Code[20])
        {
            DataClassification = EndUserIdentifiableInformation;
        }
        field(18547; "State Code"; Code[10])
        {
            TableRelation = "State";
            DataClassification = EndUserIdentifiableInformation;
        }
        field(18548; "Tax Code"; Code[20])
        {
            DataClassification = EndUserIdentifiableInformation;
        }
        field(50004; "DL No."; Text[20])
        {
            Caption = 'DL No.';
        }
        field(50088; "Request Payload"; Blob)
        {
            Caption = 'Request Payload';
        }
        field(50089; "Response Payload"; Blob)
        {
            Caption = 'Response Payload';
        }
        field(50090; BankAccountNo; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(50091; BankAccountName; Text[100])
        {
            Caption = 'Bank Account Name';
        }
        field(50092; BankBranchNo; Text[20])
        {
            Caption = 'Bank Branch No.';
        }
        field(50093; IFSCCode; Text[20])
        {
            Caption = 'IFSC Code';
        }
        field(50094; BankPostCode; Text[20])
        {
            Caption = 'Bank Post Code';
        }
        field(50095; BankCity; Text[50])
        {
            Caption = 'Bank City';
        }
        field(50096; "Unique Log No."; Integer)
        {
            Caption = 'Unique ID';
        }
        field(50097; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionMembers = " ",New,Update;
            OptionCaption = ' ,New,Update';
        }
        field(50098; "Sync Status"; Option)
        {
            Caption = 'Sync Status';
            OptionMembers = " ",Synced,Error;
            OptionCaption = ' ,Synced,Error';
        }
        field(50099; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
        }
        field(50100; "Address Code"; Code[10])
        {
            Caption = 'Address Code';
        }
        field(50101; "Address Name"; Code[100])
        {
            Caption = 'Address Name';
        }
    }
    keys
    {
        key(PK; "No.", "Unique Log No.")
        {
            Clustered = true;
        }
    }

}
