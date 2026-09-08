tableextension 50027 "E3 Uset Setup Ext" extends "User Setup"
{
    fields
    {
        field(50000; "E3 Document Delete Approver"; Boolean)
        {
            Caption = 'Document Delete Approver';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50001; "E3 Document Delete Processor"; Boolean)
        {
            Caption = 'Document Delete Processor';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50002; "GL View"; Boolean)
        {
            Caption = 'GL View';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50003; "Payroll"; Boolean)
        {
            Caption = 'Payroll';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50004; "Item Approval1"; Boolean)
        {
            Caption = 'Item Approval1';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50005; "Item Approval2"; Boolean)
        {
            Caption = 'Item Approval2';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50006; "PO Line Modify"; Boolean)
        {
            Caption = 'PO Line Modify';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50007; "Direct PO"; Boolean)
        {
            Caption = 'Direct PO';
            DataClassification = CustomerContent;
            InitValue = false;
        }


        field(50008; "Vendor Ledger View"; Boolean)
        {
            Caption = 'Vendor Ledger View';
            DataClassification = CustomerContent;
            InitValue = false;
        }


        field(50009; "Short Close Indent"; Boolean)
        {
            Caption = 'Short Close Indent';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50010; "HSN Master"; Boolean)
        {
            Caption = 'HSN Master';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50011; "Dimension Value Editable"; Boolean)
        {
            Caption = 'Dimension Value Editable';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50012; "UOM Editable"; Boolean)
        {
            Caption = 'UOM Editable';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50013; "Gate Pass Approval"; Boolean)
        {
            Caption = 'Gate Pass Approval';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50014; "GL Insert"; Boolean)
        {
            Caption = 'GL Insert';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50015; "GL Modify"; Boolean)
        {
            Caption = 'GL Modify';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50016; "GL Delete"; Boolean)
        {
            Caption = 'GL Delete';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50017; "Vendor View"; Boolean)
        {
            Caption = 'Vendor View';
            ToolTip = 'Specifies whether the user is allowed to view vendor records.';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50018; "Vendor Insert"; Boolean)
        {
            Caption = 'Vendor Insert';
            ToolTip = 'Specifies whether the user is allowed to create new vendor records.';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50019; "Vendor Modify"; Boolean)
        {
            Caption = 'Vendor Modify';
            ToolTip = 'Specifies whether the user is allowed to modify existing vendor records.';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50020; "Vendor Delete"; Boolean)
        {
            Caption = 'Vendor Delete';
            ToolTip = 'Specifies whether the user is allowed to delete vendor records.';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50021; "Customer View"; Boolean)
        {
            Caption = 'Customer View';
            ToolTip = 'Specifies whether the user is allowed to view customer records.';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50022; "Customer Insert"; Boolean)
        {
            Caption = 'Customer Insert';
            ToolTip = 'Specifies whether the user is allowed to create new customer records.';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50023; "Customer Modify"; Boolean)
        {
            Caption = 'Customer Modify';
            ToolTip = 'Specifies whether the user is allowed to modify existing customer records.';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50024; "Customer Delete"; Boolean)
        {
            Caption = 'Customer Delete';
            ToolTip = 'Specifies whether the user is allowed to delete customer records.';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50025; "Item Insert"; Boolean)
        {
            Caption = 'Item Insert';
            ToolTip = 'Specifies whether the user is allowed to create new item records.';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50026; "Item Modify"; Boolean)
        {
            Caption = 'Item Modify';
            ToolTip = 'Specifies whether the user is allowed to modify existing item records.';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50027; "Item Delete"; Boolean)
        {
            Caption = 'Item Delete';
            ToolTip = 'Specifies whether the user is allowed to delete item records.';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50028; "Bank Payment Voucher"; Boolean)
        {
            Caption = 'Bank Payment Voucher';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50029; "Bank Receipt Voucher"; Boolean)
        {
            Caption = 'Bank Receipt Voucher';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50030; "Cash Payment Voucher"; Boolean)
        {
            Caption = 'Cash Payment Voucher';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50031; "Cash Receipt Voucher"; Boolean)
        {
            Caption = 'Cash Receipt Voucher';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50032; "Journal Voucher"; Boolean)
        {
            Caption = 'Journal Voucher';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50033; "Contra Voucher"; Boolean)
        {
            Caption = 'Contra Voucher';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50034; "Purchase Order"; Boolean)
        {
            Caption = 'Purchase Order';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50035; "Purchase Invoice"; Boolean)
        {
            Caption = 'Purchase Invoice';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50036; "Sales Order"; Boolean)
        {
            Caption = 'Sales Order';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50037; "Sales Invoice"; Boolean)
        {
            Caption = 'Sales Invoice';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50038; "Customer Ledger View"; Boolean)
        {
            Caption = 'Customer Ledger View';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50039; "Item Ledger View"; Boolean)
        {
            Caption = 'Item Ledger View';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50040; "Bank Ledger View"; Boolean)
        {
            Caption = 'Bank Account Ledger View';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(50041; "G/L Entry View"; Boolean)
        {
            Caption = 'G/L Entry View';
            DataClassification = CustomerContent;
            InitValue = false;

        }



    }
}
