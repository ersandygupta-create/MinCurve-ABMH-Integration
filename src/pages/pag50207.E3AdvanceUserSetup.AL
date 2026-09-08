page 50207 "E3 Advanced User Control Setup"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "User Setup";
    Caption = 'Advanced Permission Control';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Advanced Permission Control';
                field("GL View"; Rec."GL View")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to view G/L Accounts.';
                }
                field("GL Insert"; Rec."GL Insert")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to create new G/L Accounts.';
                }
                field("GL Modify"; Rec."GL Modify")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to modify existing G/L Accounts.';
                }
                field("GL Delete"; Rec."GL Delete")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to delete G/L Accounts.';
                }
                field("Vendor View"; Rec."Vendor View")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to view vendor records.';
                }
                field("Vendor Insert"; Rec."Vendor Insert")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to create new vendor records.';
                }
                field("Vendor Modify"; Rec."Vendor Modify")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to modify existing vendor records.';
                }
                field("Vendor Delete"; Rec."Vendor Delete")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to delete vendor records.';
                }
                field("Customer View"; Rec."Customer View")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to view customer records.';
                }
                field("Customer Insert"; Rec."Customer Insert")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to create new customer records.';
                }
                field("Customer Modify"; Rec."Customer Modify")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to modify existing customer records.';
                }
                field("Customer Delete"; Rec."Customer Delete")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to delete customer records.';
                }
                // field("Item View"; Rec."Item View")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies whether the user is allowed to view item records.';
                // }
                field("Item Insert"; Rec."Item Insert")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to create new item records.';
                }
                field("Item Modify"; Rec."Item Modify")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to modify existing item records.';
                }
                field("Item Delete"; Rec."Item Delete")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to delete item records.';
                }
            }
            group(LedgerView)
            {
                Caption = 'Ledger View';
                field("Vendor Ledger View"; Rec."Vendor Ledger View")
                {
                    ApplicationArea = All;
                    Visible = true;
                    ToolTip = 'Specifies the value of the Vendor Ledger View field.';
                }
                field("Customer Ledger View"; Rec."Customer Ledger View")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Ledger View';
                    ToolTip = 'Specifies whether the user can view Customer Ledger Entries.';
                }
                field("Item Ledger View"; Rec."Item Ledger View")
                {
                    ApplicationArea = All;
                    Caption = 'Item Ledger View';
                    ToolTip = 'Specifies whether the user can view Item Ledger Entries.';
                }
                field("Bank Ledger View"; Rec."Bank Ledger View")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Account Ledger View';
                    ToolTip = 'Specifies whether the user can view Bank Account Ledger Entries.';
                }
                field("G/L Entry View"; Rec."G/L Entry View")
                {
                    ApplicationArea = All;
                    Caption = 'G/L Entry View';
                    ToolTip = 'Specifies whether the user can view G/L Entries.';
                }
            }
            group(TransactionControls)
            {
                Caption = 'Transaction Controls';
                field("Bank Payment Voucher"; Rec."Bank Payment Voucher")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to open the Bank Payment Voucher page.';
                }

                field("Bank Receipt Voucher"; Rec."Bank Receipt Voucher")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to open the Bank Receipt Voucher page.';
                }
                field("Cash Payment Voucher"; Rec."Cash Payment Voucher")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to open the Cash Payment Voucher page.';
                }
                field("Cash Receipt Voucher"; Rec."Cash Receipt Voucher")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to open the Cash Receipt Voucher page.';
                }
                field("Journal Voucher"; Rec."Journal Voucher")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to open the Journal Voucher page.';
                }
                field("Contra Voucher"; Rec."Contra Voucher")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the user is allowed to open the Contra Voucher page.';
                }
            }
            group(PurchaseControls)
            {
                Caption = 'Purchase Controls';
                group(PurchaseOrder)
                {
                    Caption = 'Purchase Order';

                    field("Purchase Order"; Rec."Purchase Order")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies whether the user is allowed to open the Purchase Order page.';
                    }
                }
                group(PurchaseInvoice)
                {
                    Caption = 'Purchase Invoice';

                    field("Purchase Invoice"; Rec."Purchase Invoice")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies whether the user is allowed to open the Purchase Invoice page.';
                    }
                }
            }
            group(SalesControls)
            {
                Caption = 'Sales Controls';

                group(SalesPermissions1)
                {
                    Caption = 'Sales Order';

                    field("Sales Order"; Rec."Sales Order")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies whether the user is allowed to access Sales Order.';
                    }
                }
                group(SalesPermissions2)
                {
                    Caption = 'Sales Invoice';
                    field("Sales Invoice"; Rec."Sales Invoice")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies whether the user is allowed to access Sales Invoice.';
                    }
                }
            }
        }
    }
}
