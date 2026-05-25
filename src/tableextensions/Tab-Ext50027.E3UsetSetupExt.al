tableextension 50027 "E3 Uset Setup Ext" extends "User Setup"
{
    fields
    {
        field(50000; "E3 Document Delete Approver"; Boolean)
        {
            Caption = 'Document Delete Approver';
            DataClassification = CustomerContent;
        }
        field(50001; "E3 Document Delete Processor"; Boolean)
        {
            Caption = 'Document Delete Processor';
            DataClassification = CustomerContent;
        }
        field(50002; "GL View"; Boolean)
        {
            Caption = 'GL View';
            DataClassification = CustomerContent;
        }
        field(50003; "Payroll"; Boolean)
        {
            Caption = 'Payroll';
            DataClassification = CustomerContent;
        }
        field(50004; "Item Approval1"; Boolean)
        {
            Caption = 'Item Approval1';
            DataClassification = CustomerContent;
        }
        field(50005; "Item Approval2"; Boolean)
        {
            Caption = 'Item Approval2';
            DataClassification = CustomerContent;
        }
        field(50006; "PO Line Modify"; Boolean)
        {
            Caption = 'PO Line Modify';
            DataClassification = CustomerContent;
        }
        field(50007; "Direct PO"; Boolean)
        {
            Caption = 'Direct PO';
            DataClassification = CustomerContent;
        }
        field(50008; "Vendor Ledger View"; Boolean)
        {
            Caption = 'Vendor Ledger View';
            DataClassification = CustomerContent;
        }

    }
}
