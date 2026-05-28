pageextension 50075 "E3 Purchase & Payable Ext" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("RCM Exempt End Date (Unreg)")
        {
            field("Bank File Series"; Rec."Bank File Series")
            {
                Caption = 'Bank File Series';
                ApplicationArea = All;
            }
        }
        addafter("Check Doc. Total Amounts")
        {

            field("HIS GRN Amount Validation"; Rec."HIS GRN Amount Validation")
            {
                Caption = 'HIS GRN Amount Validation';
                ApplicationArea = All;
                ToolTip = 'Specify a HIS GRN Amount Validation field.';
            }
            field("GRN Vendor Code Check"; Rec."GRN Vendor Code Check")
            {
                Caption = 'GRN Vendor Code Check';
                ApplicationArea = All;
                ToolTip = 'Specify a GRN Vendor Code Check field.';
            }
            field("Enable Advance Settlement"; Rec."Enable Advance Settlement")
            {
                ApplicationArea = All;
                Caption = 'Enable Advance Settlement';
                ToolTip = 'Enable or Disable Advance Settlement functionality';
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

}