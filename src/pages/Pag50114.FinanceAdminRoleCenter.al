page 50114 "E3 Finance Admin Role Center"
{
    Caption = 'Finance Admin';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control139; "Account Manager Activities")
            {
                ApplicationArea = All;
            }
            part(Control16; "O365 Activities")
            {
                AccessByPermission = TableData "Activities Cue" = I;
                ApplicationArea = Basic, Suite;
            }
            part("Acc. Payables Activities"; "Acc. Payables Activities")
            {
                ApplicationArea = Suite;
            }
            part("Acc. Receivable Activities"; "Acc. Receivable Activities")
            {
                ApplicationArea = Suite;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            part(Control96; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Suite;
            }
            part(Control9; "Trial Balance")
            {
                AccessByPermission = TableData "G/L Entry" = R;
                ApplicationArea = Basic, Suite;
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(creation)
        {
            action("<Page Purchase Order>")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Suite;
                Caption = 'Purchase Order';
                Image = NewOrder;
                RunObject = Page "Purchase Order";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase order.';
            }
            action("Purchase Invoice")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = All;
                Caption = 'Purchase Invoice';
                Image = NewPurchaseInvoice;
                RunObject = Page "Purchase Invoice";
                RunPageMode = Create;
                ToolTip = 'Create a purchase invoice to mirror a sales document sent by a vendor.';
            }
            action("Sales Invoices")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoice';
                Image = NewSalesInvoice;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
                ToolTip = 'Create a new invoice for the sales of items or services. Invoice quantities cannot be posted partially.';
            }
            action("Sales Credit Memos")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Credit Memos';
                RunObject = Page "Sales Credit Memos";
                RunPageMode = Create;
                ToolTip = 'Revert the financial transactions involved when your customers want to cancel a purchase or return incorrect or damaged items that you sent to them and received payment for. To include the correct information, you can create the sales credit memo from the related posted sales invoice or you can create a new sales credit memo with copied invoice information. If you need more control of the sales return process, such as warehouse documents for the physical handling, use sales return orders, in which sales credit memos are integrated. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
            }
        }
        area(processing)
        {
            action("Navigate")
            {
                ApplicationArea = All;
                Caption = 'Find entries...';
                Image = Navigate;
                RunObject = Page Navigate;
                ShortCutKey = 'Ctrl+Alt+Q';
                ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
            }
            group(New)
            {
                Caption = 'New';
                Image = New;

                action(Vendor)
                {
                    AccessByPermission = TableData Vendor = IMD;
                    ApplicationArea = All;
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageMode = Create;
                    ToolTip = 'Register a new vendor.';
                }
            }
        }
        area(embedding)
        {
            ToolTip = 'Manage your business. See KPIs, trial balance, and favorite customers.';

            action(Vendors)
            {
                ApplicationArea = All;
                Caption = 'Vendors';
                RunObject = Page "Vendor List";
                ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            }
            action(Customer)
            {
                ApplicationArea = All;
                Caption = 'Customer';
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The Customer card can be of type Customers or Service to specify if the Customer is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
        }
        area(Sections)
        {
            group("HIS Interface")
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
                        // action("E3 Payroll Setup")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Payroll Setup';
                        //     Image = Setup;
                        //     RunObject = Page "E3 HIS Payroll Setup";
                        //     RunPageMode = Create;
                        //     ToolTip = 'Executes the Payroll Setup action.';
                        // }
                        // action("E3 Pharmacy Setup")
                        // {
                        //     Visible = false;
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Pharmacy Setup';
                        //     Image = Setup;
                        //     RunObject = Page "E3 HIS Pharmacy Setup";
                        //     RunPageMode = Create;
                        //     ToolTip = 'Executes the Pharmacy Setup action.';
                        // }
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
                        // action("E3 Consumption Setup")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Consumption Setup';
                        //     Image = Setup;
                        //     RunObject = Page "E3 HIS Consumption Setup";
                        //     RunPageMode = Create;
                        //     ToolTip = 'Executes the Consumption Setup action.';
                        // }
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
                        // action("E3 HIS UOM Mapping")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'UOM Mapping';
                        //     Image = Setup;
                        //     RunObject = Page "E3 HIS UOM Mapping";
                        //     RunPageMode = Create;
                        //     ToolTip = 'Create a new UOM Mapping for HIS Interface.';
                        // }
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
                        // action("E3 HIS items List")
                        // {
                        //     AccessByPermission = TableData "E3 HIS Master Staging" = IMD;
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Items List';
                        //     Image = NewOrder;
                        //     RunObject = Page "E3 HIS Item List";
                        //     RunPageMode = Create;
                        //     ToolTip = 'Create a new Item for Purchase or Sales.';
                        // }

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
                        // action("E3 Created HIS items List")
                        // {
                        //     AccessByPermission = TableData "E3 HIS Master Staging" = IMD;
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Created Items List';
                        //     Image = Archive;
                        //     RunObject = Page "E3 Posted HIS Item List";
                        //     RunPageMode = Create;
                        //     ToolTip = 'Check a new Items for Purchase or Sales.';
                        // }

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
                // group("E3 HIS Pharmacy Staging")
                // {
                //     Caption = 'Pharmacy Entries';
                //     Visible = false;

                //     action("E3 Create HIS Pharmacy Entries")
                //     {
                //         AccessByPermission = TableData "E3 HIS Pharmacy Entries" = IMD;
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Create Pharmacy Entries';
                //         Image = Archive;
                //         RunObject = Page "E3 HIS Pharmacy Entries";
                //         RunPageMode = Create;
                //         ToolTip = 'Create a new Pharmacy Entries for Companies.';
                //     }


                //     action("E3 Created HIS Phamacy Entries")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Created Phamacy Entries';
                //         Image = Archive;
                //         RunObject = Page "E3 Posted HIS Pharm. Entries";
                //         RunPageMode = Create;
                //         ToolTip = 'Executes the Created Phamacy Entries action.';
                //     }

                // }
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


            }
            group(Action39)
            {
                Caption = 'Finance';
                Image = Journals;
                ToolTip = 'Post financial transactions, manage budgets, analyze G/L  data, and prepare financial statements.';
                action(GeneralJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const(General),
                                        Recurring = const(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                action(Action3)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Accounts';
                    RunObject = Page "Chart of Accounts";
                    ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
                }
                action("G/L Account Categories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Account Categories';
                    RunObject = Page "G/L Account Categories";
                    ToolTip = 'Personalize the structure of your financial statements by mapping general ledger accounts to account categories. You can create category groups by indenting subcategories under them. Each grouping shows a total balance. When you choose the Generate Financial Reports action, the row definitions for the underlying financial reports are updated. The next time you run one of these reports, such as the balance statement, new totals and subentries are added, based on your changes.';
                }
                action(Action62)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                    ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                }
                action("Account Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Financial Reporting';
                    RunObject = Page "Financial Reports";
                    ToolTip = 'Get insight into the financial data stored in your chart of accounts. Financial reports analyze figures in G/L accounts, and compare general ledger entries with general ledger budget entries. For example, you can view the general ledger entries as percentages of the budget entries. Financial reports provide the data for core financial statements and views, such as the Cash Flow chart.';
                }
            }
            group("Cash Management")
            {
                Caption = 'Cash Management';
                ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.';
                action(Customers)
                {
                    ApplicationArea = All;
                    Caption = 'Customer';
                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information for the products that you trade in. The Customer card can be of type Customers or Service to specify if the Customer is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
                }
                action(Action23)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Bank Account List";
                    ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
                }
                action("Bank Acc. Statements")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Acc. Statements';
                    Image = BankAccountStatement;
                    RunObject = Page "Bank Account Statement List";
                    ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
                }
                action("Payment Terms")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Terms';
                    Image = Payment;
                    RunObject = Page "Payment Terms";
                    ToolTip = 'Set up the payment terms that you select from on customer cards to define when the customer must pay, such as within 14 days.';
                }
                action(BankAccountReconciliations)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Reconciliations';
                    Image = BankAccountRec;
                    RunObject = Page "Bank Acc. Reconciliation List";
                    ToolTip = 'Reconcile bank accounts in your system with bank statements received from your bank.';
                }
                action("Update UTR No./RTGS")
                {
                    Caption = 'Update UTR No./RTGS';
                    ApplicationArea = All;
                    RunObject = Page "Update UTR No./RTGS";
                    ToolTip = 'Executes the Update UTR No./RTGS action.';
                }
            }
            group(Action41)
            {
                Caption = 'Purchasing';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
                action(Purchase_VendorList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';
                    RunObject = Page "Vendor List";
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action("<Page Purchase Orders>")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Orders';
                    RunObject = Page "Purchase Order List";
                    ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action(PurchaseReport)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Tax Register';
                    RunObject = Report "Purchase Tax Register";
                }
                action("<Page Purchase Invoices>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoices';
                    RunObject = Page "Purchase Invoices";
                    ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action("<Page Purchase Credit Memos>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Credit Memos';
                    RunObject = Page "Purchase Credit Memos";
                    ToolTip = 'Create purchase credit memos to mirror sales credit memos that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. If you need more control of the purchase return process, such as warehouse documents for the physical handling, use purchase return orders, in which purchase credit memos are integrated. Purchase credit memos can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
                }
                action("<Page Posted Purchase Invoices>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("<Page Posted Purchase Credit Memos>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("<Page Posted Purchase Receipts>")
                {
                    ApplicationArea = Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
                action(PurchaseInvoiceReport)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Invoice Report';
                    RunObject = report "Purchase - Invoice";
                }
            }
            group(VoucherInterface)
            {
                Caption = 'Voucher Interface';
                Image = VoucherInterface;

                action("Bank Payment Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Payment Voucher';
                    RunObject = Page "Bank Payment Voucher";
                }
                action("Bank Receipt Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Receipt Voucher';
                    RunObject = page "Bank Receipt Voucher";
                }
                action("Cash Payment Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'Cash Payment Voucher';
                    RunObject = Page "Cash Payment Voucher";
                }
                action("Cash Receipt Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'Cash Receipt Voucher';
                    RunObject = Page "Cash Receipt Voucher";
                }
                action("Journal Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'Journal Voucher';
                    RunObject = Page "Journal Voucher";
                }
                action("Contra Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'Contra Voucher';
                    RunObject = Page "Contra Voucher";
                }
                action("Day Book")
                {
                    ApplicationArea = All;
                    Caption = 'Day Book';
                    RunObject = report "Day Book";
                }
                action("Bank Book")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Book';
                    RunObject = report "Bank Book";
                }
                action("Cash Book")
                {
                    ApplicationArea = All;
                    Caption = 'Cash Book';
                    RunObject = report "Cash Book";
                }
                action("Voucher Print")
                {
                    ApplicationArea = All;
                    Caption = 'Voucher Print';
                    RunObject = report "Posted Voucher - Post Voucher";
                }
            }
            group("Sales Module")
            {
                Caption = 'Sales Module';
                Image = Receivables;

                action("Sales Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoice';
                    RunObject = Page "Sales Invoice List";
                    RunPageMode = Create;
                    ToolTip = 'Create a new invoice for the sales of items or services. Invoice quantities cannot be posted partially.';
                }
                action("Sales Credit Memo")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Credit Memos';
                    RunObject = Page "Sales Credit Memos";
                    RunPageMode = Create;
                    ToolTip = 'Revert the financial transactions involved when your customers want to cancel a purchase or return incorrect or damaged items that you sent to them and received payment for. To include the correct information, you can create the sales credit memo from the related posted sales invoice or you can create a new sales credit memo with copied invoice information. If you need more control of the sales return process, such as warehouse documents for the physical handling, use sales return orders, in which sales credit memos are integrated. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }
                action(SalesInvoiceReport)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Invoice Print';
                    RunObject = report "GST Sales Invoice Print";
                }
                action(SalesCreditMemoReport)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Credit memo Print';
                    RunObject = Report "Sales - Credit Memo GST";
                }
            }
            group("Report List")
            {
                Caption = 'Report List';
                Image = Reports;

                action("Account Ledger")
                {
                    ApplicationArea = All;
                    Caption = 'Account Ledger Report';
                    RunObject = report "Account Ledger Report Excel";
                }
                action("Sales Tax Register")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Tax Register';
                    RunObject = report "Sales Tax Register";
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
                action("Voucher Print-Posted")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Voucher Print New';
                    Image = Report;
                    RunObject = report "Posted Voucher - Post Voucher";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Voucher Print-Posted action.';
                }
                action("Vendor Ledger Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor Ledger Report';
                    Image = Report;
                    RunObject = report "Vendor Ledger Report";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Vendor Ledger Report action.';
                }
                action("Customer Ledger Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Ledger Report';
                    Image = Report;
                    RunObject = report "Customer Ledger Report";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Customer Ledger Report action.';
                }
                action("Bank Reconciliation Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Reconciliation Report';
                    Image = Report;
                    RunObject = report "Print Bank Reconciliatio Rep.";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Bank Reconciliation Report action.';
                }
                action("TDS Register Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'TDS Register Report';
                    Image = Report;
                    RunObject = report "TDS Register Report";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the TDS Register Report action.';
                }
                action("Vendor - Payment Advice")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Payment Advice';
                    Image = Report;
                    RunObject = report "E3 Vendor - Payment Advice";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Vendor - Payment Advice action.';
                }
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

            }
            group("Excel Reports")
            {
                Caption = 'Excel Reports';
                Image = Excel;
                action(ExcelTemplatesBalanceSheet)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance Sheet';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Balance Sheet";
                    ToolTip = 'Open a spreadsheet that shows your company''s assets, liabilities, and equity.';
                }
                action(ExcelTemplateIncomeStmt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Income Statement';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Income Stmt.";
                    ToolTip = 'Open a spreadsheet that shows your company''s income and expenses.';
                }
                action(ExcelTemplateCashFlowStmt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Statement';
                    Image = "Report";
                    RunObject = Codeunit "Run Template CashFlow Stmt.";
                    ToolTip = 'Open a spreadsheet that shows how changes in balance sheet accounts and income affect the company''s cash holdings.';
                }
                action(ExcelTemplateRetainedEarn)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Retained Earnings Statement';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Retained Earn.";
                    ToolTip = 'Open a spreadsheet that shows your company''s changes in retained earnings based on net income from the other financial statements.';
                }
                action(ExcelTemplateTrialBalance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Balance';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Trial Balance";
                    ToolTip = 'Open a spreadsheet that shows a summary trial balance by account.';
                }
                action(ExcelTemplateAgedAccPay)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Payable';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Aged Acc. Pay.";
                    ToolTip = 'Open a spreadsheet that shows a list of aged remaining balances for each vendor by period.';
                }
                action(ExcelTemplateAgedAccRec)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Receivable';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Aged Acc. Rec.";
                    ToolTip = 'Open a spreadsheet that shows when customer payments are due or overdue by period.';
                }
            }
        }
    }
}