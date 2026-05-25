page 50092 "E3 HIS Doctor Staging List"
{
    PageType = List;
    Editable = false;
    CardPageId = 50093;
    SourceTableView = SORTING("Entry No.") WHERE(IsCreated = FILTER(false), "Party Type" = FILTER(Doctor));
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "E3 HIS Master Staging";
    Caption = 'HIS Doctor Staging List';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field';

                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Party Type field';
                }
                field("HIS Code"; Rec."HIS Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the HIS Code field';
                    Caption = 'Doctor Code';
                }
                // field("Doctor Code"; Rec."Vendor/Customer Code")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Doctor Code field.';
                // }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name 2 field';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the City field.';
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact field.';
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile No. field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Doctor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = aLL;
                    ToolTip = 'Specifies the value of the Doctor Posting Group field.';
                    Caption = 'Doctor Posting Group';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the County field.';
                }
                field("P.A.N. No."; Rec."P.A.N. No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the P.A.N. No. field.';
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the State Code field.';
                }
                field("GST Registration No."; Rec."GST Registration No.")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the GST Registration No. field.';
                }
                field("GST Doctor Type"; Rec."GST Vendor Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST Doctor Type field.';
                }
                field("Error Description"; Rec."Error Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Error Description field.';
                }
                field(IsCreated; Rec.IsCreated)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the IsCreated field.';
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
    }
}