pageextension 50003 "E3 HIS Business Manager RC" extends "Business Manager Role Center"
{
    actions
    {
        addbefore(Action39)
        {
            group("E3 HIS Interface")
            {
                Caption = 'HIS Interface';

                group("E3 HIS Setup")
                {
                    Caption = 'Integration Setup';
                    action("E3 Setups")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Integration Setup';
                        Image = Setup;
                        RunObject = Page "E3 Integration Setup";
                        RunPageMode = Create;
                        ToolTip = 'Executes the Integration Setup action.';
                    }
                    group("E3 Masters Setups")
                    {
                        Caption = 'Setups';
                        action("E3 MOP Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'MOP Setup';
                            Image = Setup;
                            RunObject = Page "E3 HIS MOP Revenue Setup";
                            RunPageMode = Create;
                            ToolTip = 'Executes the MOP Setup action.';
                        }
                        action("E3 Payroll Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Payroll Setup';
                            Image = Setup;
                            RunObject = Page "E3 HIS Payroll Setup";
                            RunPageMode = Create;
                            ToolTip = 'Executes the Payroll Setup action.';
                        }
                        action("E3 Pharmacy Setup")
                        {
                            Visible = false;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pharmacy Setup';
                            Image = Setup;
                            RunObject = Page "E3 HIS Pharmacy Setup";
                            RunPageMode = Create;
                            ToolTip = 'Executes the Pharmacy Setup action.';
                        }
                        action("E3 Revenue Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Revenue Setup';
                            Image = Setup;
                            RunObject = Page "E3 HIS Revenue Setup";
                            RunPageMode = Create;
                            ToolTip = 'Executes the Revenue Setup action.';
                        }
                        action("E3 Collection Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Collection Setup';
                            Image = Setup;
                            RunObject = Page "E3 HIS Collection Setup";
                            RunPageMode = Create;
                            ToolTip = 'Executes the Collection Setup action.';
                        }
                        action("E3 Consumption Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Consumption Setup';
                            Image = Setup;
                            RunObject = Page "E3 HIS Consumption Setup";
                            RunPageMode = Create;
                            ToolTip = 'Executes the Consumption Setup action.';
                        }
                        action("E3 HIS Doctor Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Doctor Payout Setup';
                            Image = Setup;
                            RunObject = Page "E3 HIS Doctor Payout Setup";
                            RunPageMode = Create;
                            ToolTip = 'Create a new Doctor Payout for HIS Interface.';
                        }
                        action("E3 Settlement Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Settlement Setup';
                            Image = Setup;
                            RunObject = Page "E3 HIS Settlement Setup";
                            RunPageMode = Create;
                            ToolTip = 'Executes the Settlement Setup action.';
                        }
                        action("E3 Payment Advice E-Mail Setups")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Payment Advice E-Mail Setups';
                            Image = Setup;
                            RunObject = Page "E3 HIS E-Mail Setup";
                            RunPageMode = Create;
                            ToolTip = 'Executes the Payment Advice E-Mail Setups action.';
                        }
                    }
                    group("E3 HIS Mapping")
                    {
                        Caption = 'Mapping';

                        action("E3 HIS Item Mapping")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Mapping';
                            Image = Setup;
                            RunObject = Page "E3 HIS Item Mapping";
                            RunPageMode = Create;
                            ToolTip = 'Executes the Item Mapping action.';
                        }
                        action("E3 HIS UOM Mapping")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'UOM Mapping';
                            Image = Setup;
                            RunObject = Page "E3 HIS UOM Mapping";
                            RunPageMode = Create;
                            ToolTip = 'Create a new UOM Mapping for HIS Interface.';
                        }
                        action("E3 Profit Center")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Dimension Mapping';
                            Image = Setup;
                            RunObject = Page "E3 HIS Dimension Setup";
                            RunPageMode = Create;
                            ToolTip = 'Create a new Dimension mapping for HIS Interface.';
                        }
                        action("E3 HIS Customer Mapping")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HIS Customer Mapping';
                            Image = Setup;
                            RunObject = Page "E3 HIS Customer Mapping";
                            RunPageMode = Create;
                            ToolTip = 'Executes the HIS Customer Mapping Setups action.';
                        }
                    }
                    group("Allow Date")
                    {
                        Caption = 'Allow HIS Data Posting Date';
                        action("Allow Posting Date")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Allow HIS Data Posting Date';
                            Image = Setup;
                            RunObject = Page "Allow Posting Date";
                            RunPageMode = Create;
                            ToolTip = 'Executes the Allow Posting Date action.';
                        }
                    }
                }
                group("E3 HIS Masters")
                {
                    Caption = 'Master';

                    group("E3 Masters Create")
                    {
                        Caption = 'Master Create';

                        action("E3 HIS Vendor List")
                        {
                            AccessByPermission = TableData "E3 HIS Master Staging" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendors List';
                            Image = NewOrder;
                            RunObject = Page "E3 HIS Vendor Staging List";
                            RunPageMode = Create;
                            ToolTip = 'Create a new HIS Vendors for items or services.';
                        }
                        action("E3 HIS Doctor List")
                        {
                            AccessByPermission = TableData "E3 HIS Master Staging" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Doctor List';
                            Image = NewOrder;
                            RunObject = Page "E3 HIS Doctor Staging List";
                            RunPageMode = Create;
                            ToolTip = 'Create a new HIS Doctor for items or services.';
                        }
                        action("E3 HIS Customer List")
                        {
                            AccessByPermission = TableData "E3 HIS Master Staging" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Customers List';
                            Image = NewOrder;
                            RunObject = Page "E3 HIS Customer Staging List";
                            RunPageMode = Create;
                            ToolTip = 'Create a new Customers for items or services.';
                        }
                        action("E3 HIS Emplooyee List")
                        {
                            AccessByPermission = TableData "E3 HIS Master Staging" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Employees List';
                            Image = NewOrder;
                            RunObject = Page "E3 HIS Employee Staging List";
                            RunPageMode = Create;
                            ToolTip = 'Check a new Employees for Payroll Entries.';
                        }
                        action("E3 HIS items List")
                        {
                            AccessByPermission = TableData "E3 HIS Master Staging" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Items List';
                            Image = NewOrder;
                            RunObject = Page "E3 HIS Item List";
                            RunPageMode = Create;
                            ToolTip = 'Create a new Item for Purchase or Sales.';
                        }
                        action("HIS Pending items List")
                        {
                            AccessByPermission = TableData "E3 HIS Master Staging" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Approval Level1';
                            Image = NewOrder;
                            RunObject = Page "E3 HIS Item Pending List";
                            RunPageMode = Create;
                            ToolTip = 'Create a Pending Item for Purchase or Sales.';
                        }
                        action("HIS Approved items List")
                        {
                            AccessByPermission = TableData "E3 HIS Master Staging" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Approval Level2';
                            Image = NewOrder;
                            RunObject = Page "E3 HIS Item Approved List";
                            RunPageMode = Create;
                            ToolTip = 'Create a Approved Item for Purchase or Sales.';
                        }

                    }
                    group("E3 Master Created Successfully")
                    {
                        Caption = 'Master Created Successfully';

                        action("E3 Created HIS Vendor List")
                        {
                            AccessByPermission = TableData "E3 HIS Master Staging" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Created Vendors List';
                            Image = Archive;
                            RunObject = Page "E3 Posted HIS Vend. Stg. List";
                            RunPageMode = Create;
                            ToolTip = 'Check a new Vendors for items or services.';
                        }
                        action("E3 Created HIS Doctor List")
                        {
                            AccessByPermission = TableData "E3 HIS Master Staging" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Created Doctor List';
                            Image = Archive;
                            RunObject = Page "E3 Posted HIS Doct. Stg. List";
                            RunPageMode = Create;
                            ToolTip = 'Check a new Doctor for items or services.';
                        }
                        action("E3 Created HIS Customer List")
                        {
                            AccessByPermission = TableData "E3 HIS Master Staging" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Created Customers List';
                            Image = Archive;
                            RunObject = Page "E3 Posted HIS Customer List";
                            RunPageMode = Create;
                            ToolTip = 'Check a new Customers for items or services.';
                        }
                        action("E3 Created HIS Employee List")
                        {
                            AccessByPermission = TableData "E3 HIS Master Staging" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Created Employees List';
                            Image = Archive;
                            RunObject = Page "E3 Posted HIS Employee List";
                            RunPageMode = Create;
                            ToolTip = 'Check a new Employees for Payroll Entries.';
                        }
                        action("E3 Created HIS items List")
                        {
                            AccessByPermission = TableData "E3 HIS Master Staging" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Created Items List';
                            Image = Archive;
                            RunObject = Page "E3 Posted HIS Item List";
                            RunPageMode = Create;
                            ToolTip = 'Check a new Items for Purchase or Sales.';
                        }
                        action("Pending items List")
                        {
                            AccessByPermission = TableData "E3 HIS Master Staging" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'All Pending Items List';
                            Image = Archive;
                            RunObject = Page "E3 ALL HIS Item List";
                            RunPageMode = Create;
                            ToolTip = 'Check a Pending Items for Purchase or Sales.';
                        }

                    }

                }
                group("E3 HIS Collection Staging")
                {
                    Caption = 'Collection Entries';

                    action("E3 Create HIS Collection Entries")
                    {
                        AccessByPermission = TableData "E3 HIS Revenue Staging Table" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create Collection Entries';
                        Image = Archive;
                        RunObject = Page "E3 HIS Revenue Stagging";
                        RunPageMode = Create;
                        ToolTip = 'Create a new Collection Entries for Companies.';
                    }
                    action("E3 Created HIS Collection Entries")
                    {
                        AccessByPermission = TableData "E3 HIS Revenue Staging Table" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Created Collection Entries';
                        Image = Archive;
                        RunObject = Page "E3 Posted HIS Rev. Stagging";
                        RunPageMode = Create;
                        ToolTip = 'Check a new Collection Entries for Companies.';
                    }

                }
                group("E3 HIS Pharmacy Staging")
                {
                    Caption = 'Pharmacy Entries';
                    Visible = false;

                    action("E3 Create HIS Pharmacy Entries")
                    {
                        AccessByPermission = TableData "E3 HIS Pharmacy Entries" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create Pharmacy Entries';
                        Image = Archive;
                        RunObject = Page "E3 HIS Pharmacy Entries";
                        RunPageMode = Create;
                        ToolTip = 'Create a new Pharmacy Entries for Companies.';
                    }


                    action("E3 Created HIS Phamacy Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Created Phamacy Entries';
                        Image = Archive;
                        RunObject = Page "E3 Posted HIS Pharm. Entries";
                        RunPageMode = Create;
                        ToolTip = 'Executes the Created Phamacy Entries action.';
                    }

                }
                group("E3 HIS Consumption Staging")
                {
                    Caption = 'Consumption Entries';

                    action("E3 Create HIS Consumption Entries")
                    {
                        AccessByPermission = TableData "E3 HIS Consumption Entries" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create Consumption Entries';
                        Image = Archive;
                        RunObject = Page "E3 HIS Consumption Entries";
                        RunPageMode = Create;
                        ToolTip = 'Create a new Consumption Entries for Companies.';
                    }


                    action("E3 Created HIS Consumption Ent.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Created Consumption Entries';
                        Image = Archive;
                        RunObject = Page "E3 Posted HIS Cons. Entries";
                        RunPageMode = Create;
                        ToolTip = 'Executes the Created Consumption Entries action.';
                    }

                }
                group("E3 HIS GRN Entries")
                {
                    Caption = 'GRN Entries';

                    action("E3 HIS GRN")
                    {
                        AccessByPermission = TableData "E3 HIS Purchase Header" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create GRN';
                        Image = Archive;
                        RunObject = Page "E3 HIS GRN List";
                        RunPageMode = Create;
                        ToolTip = 'Create a new GRN Entries for Vendor.';
                    }
                    action("E3 Created HIS GRN")
                    {
                        AccessByPermission = TableData "E3 HIS Purchase Header" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Created GRN';
                        Image = Archive;
                        RunObject = Page "E3 Posted HIS GRN List";
                        RunPageMode = Create;
                        ToolTip = 'Created a GRN Entries for Vendor.';
                    }
                }

                group("E3 HIS GRN Return Entries")
                {
                    Caption = 'GRN Return Entries';

                    action("E3 HIS GRN Return")
                    {
                        AccessByPermission = TableData "E3 HIS Purchase Header" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create GRN Return';
                        Image = Archive;
                        RunObject = Page "E3 HIS GRN Return List";
                        RunPageMode = Create;
                        ToolTip = 'Create a new GRN Return Entries for Vendor.';
                    }
                    action("E3 Created HIS GRN Return")
                    {
                        AccessByPermission = TableData "E3 HIS Purchase Header" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Created GRN Return';
                        Image = Archive;
                        RunObject = Page "E3 Posted HIS GRN Return List";
                        RunPageMode = Create;
                        ToolTip = 'Created a GRN ReturnEntries for Vendor.';
                    }
                }
                group("E3 HIS Revenue Invoice Entries")
                {
                    Caption = 'Revenue Invoice Entries';
                    action("E3 HIS Revenue Invoice")
                    {
                        AccessByPermission = TableData "E3 HIS Revenue Header" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create Revenue Invoice';
                        Image = Archive;
                        RunObject = Page "E3 HIS Revenue List";
                        RunPageMode = Create;
                        ToolTip = 'Executes the Create Revenue Invoice action.';
                    }
                    action("E3 Created HIS Revenue Invoice")
                    {
                        AccessByPermission = TableData "E3 HIS Revenue Header" = IMD;
                        ApplicationArea = Basic, Suite;
                        Image = Archive;
                        RunObject = Page "E3 Posted HIS Revenue List";
                        RunPageMode = Create;
                        ToolTip = 'Executes the Created Revenue Invoice action.';
                        Caption = 'Created Revenue Invoice';
                    }
                }
                group("E3 HIS Revenue Cancel Entries")
                {
                    Caption = 'Revenue Cancel Entries';
                    action("E3 HIS Revenue Cancel")
                    {
                        AccessByPermission = TableData "E3 HIS Revenue Header" = IMD;
                        ApplicationArea = Basic, Suite;
                        Image = Archive;
                        RunObject = Page "E3 HIS Revenue Cancel List";
                        RunPageMode = Create;
                        ToolTip = 'Executes the Revenue Cancel action.';
                        Caption = 'Create Revenue Cancel';
                    }
                    action("E3 Created HIS Revenue Cancel")
                    {
                        AccessByPermission = TableData "E3 HIS Revenue Header" = IMD;
                        ApplicationArea = Basic, Suite;
                        Image = Archive;
                        RunObject = Page "E3 HIS Posted Rev Cancel List";
                        RunPageMode = Create;
                        ToolTip = 'Executes the Created Revenue Cancel action.';
                        Caption = 'Created Revenue Cancel';
                    }
                }
                // group("HIS System Integration")
                // {
                //     Caption = 'System Integration';

                //     action(AkhilSetup)
                //     {
                //         Caption = 'Setup';
                //         ApplicationArea = all;
                //         RunObject = page "E3 Akhil Integration Setup";
                //         ToolTip = 'Executes the Setup action.';
                //     }
                //     action(AkhilSupplerLogs)
                //     {
                //         Caption = 'Supplier Sync Logs';
                //         ApplicationArea = all;
                //         RunObject = page "E3 API Supplier Update Logs";
                //         ToolTip = 'Executes the Supplier Sync Logs action.';
                //     }
                // }

                group("E3 HIS Settlement Staging")
                {
                    Caption = 'Settlement Entries';

                    action("E3 Create HIS Settlement Entries")
                    {
                        AccessByPermission = TableData "E3 HIS Settlement Staging" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Settlement Entries';
                        Image = Archive;
                        RunObject = Page "E3 HIS Settlement Stagging";
                        RunPageMode = Create;
                        ToolTip = 'Create a new Settlement Entries for Companies.';
                    }
                    action("E3 Created HIS Settlement Entries")
                    {
                        AccessByPermission = TableData "E3 HIS Settlement Staging" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Created Settlement Entries';
                        Image = Archive;
                        RunObject = Page "E3 Posted HIS Sett. Stagging";
                        RunPageMode = Create;
                        ToolTip = 'Check a new Posted Settlement Entries for Companies.';
                    }

                }
                group("E3 HIS Doctor Payout Entries")
                {
                    Caption = 'Doctor Payout Entries';

                    action("E3 Create HIS Doctor Payout Entries")
                    {
                        AccessByPermission = TableData "E3 HIS Doctor Payout" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Doctor Payout Entries';
                        Image = Archive;
                        RunObject = Page "E3 HIS Doctor Payout Entries";
                        RunPageMode = Create;
                        ToolTip = 'Create a new Doctor Payout Entries for Companies.';
                    }
                    action("E3 Created Doctor Payout Entries")
                    {
                        AccessByPermission = TableData "E3 HIS Doctor Payout" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Created Doctor Payout Entries';
                        Image = Archive;
                        RunObject = Page "E3 Posted HIS Doctor Payout";
                        RunPageMode = Create;
                        ToolTip = 'Check a new Posted Doctor Payout Entries for Companies.';
                    }

                }

                group("E3 HIS Payroll Entries")
                {
                    Caption = 'Payroll Entries';

                    action("E3 Create HIS Payroll Entries")
                    {
                        AccessByPermission = TableData "E3 HIS Payroll Staging" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Entries';
                        Image = Archive;
                        RunObject = Page "E3 HIS Payroll Entries";
                        RunPageMode = Create;
                        ToolTip = 'Create a new Payroll Entries for Companies.';
                    }
                    action("E3 Created Payroll Entries")
                    {
                        AccessByPermission = TableData "E3 HIS Payroll Staging" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Created Payroll Entries';
                        Image = Archive;
                        RunObject = Page "E3 Posted HIS Payroll Entries";
                        RunPageMode = Create;
                        ToolTip = 'Check a new Posted Payroll Entries for Companies.';
                    }

                }
                // group("E3 HIS Opex GRN Entries")
                // {
                //     Caption = 'Opex GRN Entries';

                //     action("E3 HIS Opex GRN")
                //     {
                //         AccessByPermission = TableData "E3 HIS Purchase Header" = IMD;
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Create Opex GRN';
                //         Image = Archive;
                //         RunObject = Page "E3 HIS GRN Opex List";
                //         RunPageMode = Create;
                //         ToolTip = 'Create a new Opex GRN Entries for Vendor.';
                //     }
                //     action("E3 Created HIS Opex GRN")
                //     {
                //         AccessByPermission = TableData "E3 HIS Purchase Header" = R;
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Created Opex GRN';
                //         Image = Archive;
                //         RunObject = Page "E3 Posted HIS GRN Opex List";
                //         RunPageMode = Create;
                //         ToolTip = 'Created a Opex GRN Entries for Vendor.';
                //     }
                // }
                group("E3 HIS Capex GRN Entries")
                {
                    Caption = 'Capex GRN Entries';

                    action("E3 HIS Capex GRN")
                    {
                        AccessByPermission = TableData "E3 HIS Purchase Header" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create Capex GRN';
                        Image = Archive;
                        RunObject = Page "E3 HIS GRN Capex List";
                        RunPageMode = Create;
                        ToolTip = 'Create a new Capex GRN Entries for Vendor.';
                    }
                    action("E3 Created HIS Capex GRN")
                    {
                        AccessByPermission = TableData "E3 HIS Purchase Header" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Created Capex GRN';
                        Image = Archive;
                        RunObject = Page "E3 Posted HIS GRN Capex List";
                        RunPageMode = Create;
                        ToolTip = 'Created a Capex GRN Entries for Vendor.';
                    }
                }
                group("E3 Gate Entry")
                {
                    Caption = 'Gate Entry';

                    group("E3 Gate Entry Creation")
                    {
                        Caption = 'Gate Entry Creation';
                        action("E3 Gate Entry Outward")
                        {
                            AccessByPermission = TableData "E3 Gate Entry Header" = R;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Create Gate Entry Outward';
                            Image = Archive;
                            RunObject = Page "E3 Gate Entry Outward List";
                            RunPageMode = Create;
                            ToolTip = 'Created a Gate Entry Outward for Vendor.';
                        }
                        action("E3 Gate Entry Inward")
                        {
                            AccessByPermission = TableData "E3 Gate Entry Header" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Create Gate Entry Inward';
                            Image = Archive;
                            RunObject = Page "E3 Gate Entry Inward List";
                            RunPageMode = Create;
                            ToolTip = 'Create a new Gate Entry Inward for Vendor.';
                        }
                    }

                    group("E3 Posted Gate Entry")
                    {
                        Caption = 'Posted Gate Entry';
                        action("E3 Posted Gate Entry Inward")
                        {
                            AccessByPermission = TableData "E3 Posted Gate Entry Header" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Gate Entry Inward';
                            Image = Archive;
                            RunObject = Page "E3 Posted Gate Ent Inward List";
                            RunPageMode = Create;
                            ToolTip = 'Create a new Gate Entry Inward for Vendor.';
                        }
                        action("E3 Posted Gate Entry Outward")
                        {
                            AccessByPermission = TableData "E3 Posted Gate Entry Header" = IMD;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Gate Entry Outward';
                            Image = Archive;
                            RunObject = Page "E3Posted Gate Ent Outward List";
                            RunPageMode = Create;
                            ToolTip = 'Create a new Gate Entry Outward for Vendor.';
                        }
                    }
                }
            }
        }

        addlast("India Taxation")
        {
            group("Excel Report")
            {
                Caption = 'Excel Report';
                action("Account Ledger Excel")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ledger Account Statement';
                    Image = Report;
                    RunObject = report "Account Ledger Report Excel";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Account Ledger action.';
                }
                action("Purchase Tax Register Excel")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Tax Register';
                    Image = Report;
                    RunObject = report "Purchase Tax Register";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Purchase Tax Register action.';
                }
                action("Sales Tax Register Excel")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Tax Register';
                    Image = Report;
                    RunObject = report "Sales Tax Register";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Sales Tax Register action.';
                }
            }
            group("Ledger Report")
            {
                Caption = 'Ledger Report';
                action("Voucher Print-Posted")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Voucher Print - Posted';
                    Image = Report;
                    RunObject = report "Posted Voucher - Post Voucher";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Voucher Print-Posted action.';
                }
                action("Vendor Ledger Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor Account Statement';
                    Image = Report;
                    RunObject = report "Vendor Ledger Report";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Vendor Ledger Report action.';
                }
                action("Customer Ledger Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Account Statement';
                    Image = Report;
                    RunObject = report "Customer Ledger Report";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Customer Ledger Report action.';
                }
                action("Bank Reconciliation Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Reconciliation';
                    Image = Report;
                    RunObject = report "Print Bank Reconciliatio Rep.";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Bank Reconciliation Report action.';
                }
                action("TDS Register Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'TDS Register';
                    Image = Report;
                    RunObject = report "TDS Register Report";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the TDS Register Report action.';
                }
                action("Vendor - Payment Advice")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Advice';
                    Image = Report;
                    RunObject = report "E3 Vendor - Payment Advice";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Vendor - Payment Advice action.';
                }
                action("Employee Ledger Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employee Statement';
                    Image = Report;
                    RunObject = report "Employee Ledger";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Employee Ledger Report action.';
                }
                action("Purchase Order Print")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Order';
                    Image = Report;
                    RunObject = report "Purchase Order Print";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Purchase Order Print action.';
                }
                // action("Posted Sales Invoice Print")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Posted Sales Invoice Print';
                //     Image = Report;
                //     RunObject = report "GST Sales Invoice Print";
                //     RunPageMode = Edit;
                // }
                action("TCS Register")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'TCS Register';
                    Image = Report;
                    RunObject = report "TCS Register Report";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the TCS Register action.';
                }
            }

            group("Balance Report")
            {
                Caption = 'Balance Report';

                action("Vendor Balance")
                {
                    Caption = 'Vendor Balance';
                    ApplicationArea = All;
                    RunObject = Page "Vendor Balance";
                    ToolTip = 'Executes the Vendor Balance action.';
                }
                action("Customer Balance")
                {
                    Caption = 'Customer Balance';
                    ApplicationArea = All;
                    RunObject = Page "Customer Balance";
                    ToolTip = 'Executes the Customer Balance action.';
                }
                action("Bank Balance")
                {
                    Caption = 'Bank Balance';
                    ApplicationArea = All;
                    RunObject = Page "Bank Balance";
                    ToolTip = 'Executes the Bank Balance action.';
                }
                action("Employee Balance")
                {
                    Caption = 'Employee Balance';
                    ApplicationArea = All;
                    RunObject = Page "Employee Balance";
                    ToolTip = 'Executes the Employee Balance action.';
                }
                action("Update UTR No./RTGS")
                {
                    Caption = 'Update UTR No./RTGS';
                    ApplicationArea = All;
                    RunObject = Page "Update UTR No./RTGS";
                    ToolTip = 'Executes the Update UTR No./RTGS action.';
                }
            }
        }
        addbefore(Action39)
        {
            group("3E Bank Integration")
            {
                Caption = 'Bank Integration';
                group("Payment Process")
                {
                    Caption = 'Payment Process';

                    action("VLE Payment Entry Selection")
                    {
                        AccessByPermission = TableData "Vendor Ledger Entry" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Entry Selection';
                        Image = NewOrder;
                        RunObject = Page "E3 Vendor Ledger Entries";
                        RunPageMode = Create;
                        ToolTip = 'Specify the Payment Entry Selection';
                    }
                    action("VLE Ready for Payment")
                    {
                        AccessByPermission = TableData "Vendor Ledger Entry" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Ready for Payment Process';
                        Image = NewOrder;
                        RunObject = Page "E3 VLE Ready for Payment";
                        RunPageMode = Create;
                        ToolTip = 'Specify the VLE Ready for Payment';
                    }
                    action("Bank Process Data")
                    {
                        AccessByPermission = TableData "E3 Bank Integration" = IMD;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Process Data';
                        Image = NewOrder;
                        RunObject = Page "E3 Exported BLE File";
                        RunPageMode = Create;
                        ToolTip = 'Specify the Exported BLE File';
                    }
                }
            }
        }
        addbefore(Action39)
        {
            group("E3 Indent Module")
            {
                Caption = 'Indent Module';
                action("E3 Indent Entries")
                {
                    AccessByPermission = TableData "E3 Indent Header" = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Indent Entries';
                    Image = Archive;
                    RunObject = Page "E3 Indent List";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Create Indent Entries action.';
                }
                action("E3 Indenter Master")
                {
                    AccessByPermission = TableData "E3 Indenter Master" = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Indenter Master';
                    Image = Archive;
                    RunObject = Page "E3 Indenter Master List";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Create Indenter Entries action.';
                }
                action("E3 Item Make Master")
                {
                    AccessByPermission = TableData "E3 Item Make Master" = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Make Master';
                    Image = Archive;
                    RunObject = Page "E3 Item Make Master";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Create Make Entries action.';
                }
            }
        }
    }
}



