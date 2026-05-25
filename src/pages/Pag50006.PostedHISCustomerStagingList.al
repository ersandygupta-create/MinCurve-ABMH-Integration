page 50006 "E3 Posted HIS Customer List"
{
    ApplicationArea = All;
    Caption = 'Posted HIS Customer Staging List';
    PageType = List;
    Editable = false;
    CardPageId = 50007;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = SORTING("Entry No.") WHERE(IsCreated = FILTER(true), "Party Type" = FILTER(Customer), "Error Description" = FILTER(''));
    SourceTable = "E3 HIS Master Staging";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;

                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;
                }
                field("HIS Code"; Rec."HIS Code")
                {
                    ApplicationArea = all;
                }
                field("Vendor/Customer Code"; Rec."Vendor/Customer Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = aLL;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field("P.A.N. No."; Rec."P.A.N. No.")
                {
                    ApplicationArea = all;
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                }
                field("GST Registration No."; Rec."GST Registration No.")
                {
                    ApplicationArea = ALL;
                }
                field("GST Customer Type"; Rec."GST Customer Type")
                {
                    ApplicationArea = All;
                }
                field(IsCreated; Rec.IsCreated)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Customer Card")
            {
                ApplicationArea = All;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Customer Card";
                RunPageView = SORTING("No.") ORDER(Ascending);
                RunPageLink = "No." = field("Vendor/Customer Code");
                trigger OnAction();
                begin

                end;
            }
            action("HIS Customer Card")
            {
                ApplicationArea = All;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "E3 Posted HIS Customer Card";
                RunPageView = SORTING("HIS Code") ORDER(Ascending);
                RunPageLink = "HIS Code" = field("HIS Code");
                trigger OnAction();
                begin

                end;
            }
        }
    }

}
