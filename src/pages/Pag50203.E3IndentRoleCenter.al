page 50203 "E3 Indent Role Center"
{
    PageType = RoleCenter;
    Caption = 'Indent Module';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(RoleCenter)
        {
            part(IndentCue; "E3 Indent Cue Card")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Embedding)
        {
            group("Indent Module")
            {
                Caption = 'Indent Module';
                group("Create Indent")
                {
                    Caption = 'Create Indent';
                    action("System Indent")
                    {
                        ApplicationArea = All;
                        Caption = 'System Indent';
                        Image = NewDocument;
                        RunObject = Page "E3 Indent List";
                        RunPageMode = Create;
                    }
                    action("HIS Indent")
                    {
                        ApplicationArea = All;
                        Caption = 'HIS Indent';
                        Image = NewDocument;
                        RunObject = Page "E3 HIS Indent List";
                        RunPageMode = Create;
                    }
                }
                group("Approved Indent")
                {
                    Caption = 'Approved Indent';

                    action("System Approved Indent")
                    {
                        ApplicationArea = All;
                        Caption = 'System Approved Indent';
                        Image = Approvals;
                        RunObject = Page "E3 Approved Indent List";
                    }
                    action("HIS Approved Indent")
                    {
                        ApplicationArea = All;
                        Caption = 'HIS Approved Indent';
                        Image = Approvals;
                        RunObject = Page "E3 Approved HIS Indent List";
                    }
                }
                group(Quotation)
                {
                    Caption = 'Quotation';

                    action("Vendor Quotation")
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor Quotation';
                        Image = Quote;
                        RunObject = Page "E3 Quotation List";
                    }
                    action("Released Quotation")
                    {
                        ApplicationArea = All;
                        Caption = 'Released Quotation';
                        Image = Quote;
                        RunObject = Page "E3 Released Indent Details";
                    }
                }
                action("Item Make Master")
                {
                    ApplicationArea = All;
                    Caption = 'Item Make Master';
                    Image = Item;
                    RunObject = Page "E3 Item Make Master";
                }
            }
        }
        area(Creation)
        {
            action(NewHISIndent)
            {
                Caption = 'New HIS Indent';
                Image = NewDocument;
                ApplicationArea = All;
                RunObject = Page "E3 HIS Indent List";
                RunPageMode = Create;
            }
        }
        area(Processing)
        {
            action(ApprovedIndentList)
            {
                Caption = 'Approved Indents';
                Image = Approvals;
                ApplicationArea = All;
                RunObject = Page "E3 Approved Indent List";
            }
            action(VendorQuotationList)
            {
                Caption = 'Vendor Quotation';
                Image = Quote;
                ApplicationArea = All;
                RunObject = Page "E3 Quotation List";
            }
            action(ItemMake)
            {
                Caption = 'Item Make Master';
                Image = Item;
                ApplicationArea = All;
                RunObject = Page "E3 Item Make Master";
            }
        }

        area(Reporting)
        {
            group("Indent Reports")
            {
                Caption = 'Indent Reports';

                action("Indent Report")
                {
                    ApplicationArea = All;
                    Caption = 'Indent Report';
                    Image = Report;
                    RunObject = Report "E3 Indent Slip";
                }
                action("Indent Slip")
                {
                    ApplicationArea = All;
                    Caption = 'Indent Slip';
                    Image = Report;
                    RunObject = Report "E3 Indent Slip";
                }
            }
        }
    }
}