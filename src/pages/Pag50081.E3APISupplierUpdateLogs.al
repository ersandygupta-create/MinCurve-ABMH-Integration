page 50081 "E3 API Supplier Update Logs"
{
    ApplicationArea = All;
    Caption = 'API Supplier Update Logs';
    PageType = List;
    SourceTable = "E3 API Supplier Update Log";
    UsageCategory = Lists;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Editable = false;

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Unique Log No."; Rec."Unique Log No.")
                {
                    ToolTip = 'Specifies the value of the Unique ID field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Address Code"; Rec."Address Code")
                {
                    ToolTip = 'Specifies the value of the Address Code field.';
                }
                field("Address Name"; Rec."Address Name")
                {
                    ToolTip = 'Specifies the value of the Address Name field.';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies the value of the Name 2 field.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field("State Code"; Rec."State Code")
                {
                    ToolTip = 'Specifies the value of the State Code field.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Last Modified Date Time"; Rec."Last Modified Date Time")
                {
                    ToolTip = 'Specifies the value of the Last Modified Date Time field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ToolTip = 'Specifies the value of the Fax No. field.';
                }
                field("DL No."; Rec."DL No.")
                {
                    ToolTip = 'Specifies the value of the DL No. field.';
                }
                field("P.A.N. No."; Rec."P.A.N. No.")
                {
                    ToolTip = 'Specifies the value of the P.A.N. No. field.';
                }
                field("GST Registration No."; Rec."GST Registration No.")
                {
                    ToolTip = 'Specifies the value of the GST Registration No. field.';
                }
                field("GST Vendor Type"; Rec."GST Vendor Type")
                {
                    ToolTip = 'Specifies the value of the GST Vendor Type field.';
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ToolTip = 'Specifies the value of the Vendor Posting Group field.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the value of the Payment Terms Code field.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ToolTip = 'Specifies the value of the Mobile Phone No. field.';
                }
                field("Preferred Bank Account Code"; Rec."Preferred Bank Account Code")
                {
                    ToolTip = 'Specifies the value of the Preferred Bank Account Code field.';
                }
                field(BankAccountNo; Rec.BankAccountNo)
                {
                    ToolTip = 'Specifies the value of the Bank Account No. field.';
                }
                field(BankAccountName; Rec.BankAccountName)
                {
                    ToolTip = 'Specifies the value of the Bank Account Name field.';
                }
                field(BankBranchNo; Rec.BankBranchNo)
                {
                    ToolTip = 'Specifies the value of the Bank Branch No. field.';
                }
                field(BankCity; Rec.BankCity)
                {
                    ToolTip = 'Specifies the value of the Bank City field.';
                }
                field(BankPostCode; Rec.BankPostCode)
                {
                    ToolTip = 'Specifies the value of the Bank Post Code field.';
                }
                field(IFSCCode; Rec.IFSCCode)
                {
                    ToolTip = 'Specifies the value of the IFSC Code field.';
                }
                field("Sync Status"; Rec."Sync Status")
                {
                    ToolTip = 'Specifies the value of the Sync Status field.';
                }
                field("Error Message"; Rec."Error Message")
                {
                    ToolTip = 'Specifies the value of the Error Message field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Sync)
            {
                Caption = 'Sync';
                ApplicationArea = All;
                Image = Link;
                ToolTip = 'Executes the Sync action.';
                trigger OnAction()
                var
                    EDCAkhilMgmt: Codeunit "E3 Akhil Integration Mgmt.";
                begin
                    Clear(EDCAkhilMgmt);
                    EDCAkhilMgmt.SendSupplierDetails(Rec);
                    Rec.Modify(false);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
