pageextension 50023 "E3 User Setup Ext" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("E3 Document Delete Approver"; Rec."E3 Document Delete Approver")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Document Delete Approver field.';
            }
            field("E3 Document Delete Processor"; rec."E3 Document Delete Processor")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Document Delete Processor field.';
            }
            field("GL View"; Rec."GL View")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GL View field.';
            }
            field(Payroll; Rec.Payroll)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payroll field.';
            }
            field("Item Approval1"; Rec."Item Approval1")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Approval1 field.';
            }
            field("Item Approval2"; Rec."Item Approval2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Approval2 field.';
            }
            field("PO Line Modify"; Rec."PO Line Modify")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PO Line Modify field.';
            }
            field("Vendor Ledger View"; Rec."Vendor Ledger View")
            {
                ApplicationArea = All;
                Visible = true;
                ToolTip = 'Specifies the value of the Vendor Ledger View field.';
            }
        }
    }
}
