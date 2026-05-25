page 50095 "E3 Posted HIS Doct. Stg. Card"
{

    Caption = 'Posted HIS Doctor Staging Card';
    PageType = Card;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = SORTING("Entry No.") WHERE(IsCreated = FILTER(true), "Party Type" = FILTER(Doctor), "Error Description" = FILTER(''));
    SourceTable = "E3 HIS Master Staging";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("HIS Code"; Rec."HIS Code")
                {
                    ToolTip = 'Specifies the value of the HIS Code field';
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Party Type"; Rec."Party Type")
                {
                    ToolTip = 'Specifies the value of the Party Type field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies the value of the Name 2 field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                    ApplicationArea = All;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ToolTip = 'Specifies the value of the Birth Date field';
                    ApplicationArea = All;
                    Caption = 'DOB';
                    Editable = false;
                }
                field("Date of Joining"; Rec."Date of Joining")
                {
                    ToolTip = 'Specifies the value of the Date of Joining field';
                    ApplicationArea = All;
                    Caption = 'Date of Joining';
                    Editable = false;
                }
                field("Date of Leaving"; Rec."Date of Leaving")
                {
                    ToolTip = 'Specifies the value of the Date of Leaving field';
                    ApplicationArea = All;
                    Caption = 'Date of Leaving';
                    Editable = false;
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field';
                    ApplicationArea = All;
                    Caption = 'Designation';
                    Editable = false;
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field';
                    ApplicationArea = All;
                    Caption = 'Grade';
                    Editable = false;
                }
                field(Aadhar; Rec.Aadhar)
                {
                    ToolTip = 'Specifies the value of the Aadhar field';
                    ApplicationArea = All;
                    Caption = 'Aadhar';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                }
                field("Valid From"; Rec."Valid From")
                {
                    ToolTip = 'Specifies the value of the Valid From field';
                    ApplicationArea = All;
                    Caption = 'Valid From';
                    Editable = false;
                }
                field("Valid To"; Rec."Valid To")
                {
                    ToolTip = 'Specifies the value of the Valid To field';
                    ApplicationArea = All;
                    Caption = 'Valid To';
                    Editable = false;
                }
                field(Qualification; Rec.Qualification)
                {
                    ToolTip = 'Specifies the value of the Qualification field';
                    ApplicationArea = All;
                    Caption = 'Qualification';
                    Editable = false;
                }
                field(Experience; Rec.Experience)
                {
                    ToolTip = 'Specifies the value of the Experience field';
                    ApplicationArea = All;
                    Caption = 'Experience';
                    Editable = false;
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ToolTip = 'Specifies the value of the Registration No. field';
                    ApplicationArea = All;
                    Caption = 'Doctor Registration No.';
                }
                field("Engagement Mode"; Rec."Engagement Mode")
                {
                    ToolTip = 'Specifies the value of the Engagement Mode field';
                    ApplicationArea = All;
                    Caption = 'Engagement Mode';
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ToolTip = 'Specifies the value of the Payment Mode field';
                    ApplicationArea = All;
                    Caption = 'Payment Mode';
                }
                field(Paygroup; Rec.Paygroup)
                {
                    ToolTip = 'Specifies the value of the Paygroup field';
                    ApplicationArea = All;
                    Caption = 'Paygroup';
                }
            }
            group("Address Information")
            {
                field(Address; Rec.Address)
                {
                    ApplicationArea = all;
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
                    ApplicationArea = ALL;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    ToolTip = 'Specifies the value of the Mobile No. field';
                    ApplicationArea = All;
                    Caption = 'Mobile No.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field';
                    ApplicationArea = All;
                    Caption = 'E-Mail';
                }

                field(County; Rec.County)
                {
                    ApplicationArea = all;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor/Customer Code"; Rec."Vendor/Customer Code")
                {
                    ApplicationArea = all;
                }

            }
            group("Invoicing Information")
            {
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = All;
                    Caption = 'Doctor Posting Group';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = ALL;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ToolTip = 'Specifies the value of the Unit Name field';
                    ApplicationArea = All;
                    Caption = 'Unit Name';
                }

            }
            group("Statutory Details")
            {
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                }
                field("GST Vendor Type"; Rec."GST Vendor Type")
                {
                    ApplicationArea = all;
                    Caption = 'GST Doctor Type';
                }
                field("GST Registration No."; Rec."GST Registration No.")
                {
                    ApplicationArea = ALL;
                }
                field("P.A.N. No."; Rec."P.A.N. No.")
                {
                    ApplicationArea = all;
                }
            }
            group("Bank Details")
            {
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ApplicationArea = all;
                }
                field("Vendor Bank Account Name"; Rec."VC Bank Account Name")
                {
                    ApplicationArea = all;
                    Caption = 'Doctor Bank Account Name';
                }
                field("Bank Address"; Rec."Bank Address")
                {
                    ApplicationArea = all;
                }
                field("Bank Address 2"; Rec."Bank Address 2")
                {
                    ApplicationArea = all;
                }
                field("Bank Post Code"; Rec."Bank Post Code")
                {
                    ApplicationArea = all;
                }
                field("Bank City"; Rec."Bank City")
                {
                    ApplicationArea = all;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = all;
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = all;
                }
                field("Bank IFSC Code"; Rec."IFSC Code")
                {
                    ApplicationArea = all;
                }
            }
            group("Log Details")
            {
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = ALL;
                }
                field(IsCreated; Rec.IsCreated)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Error Description"; Rec."Error Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }

        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Doctor Card")
            {
                ApplicationArea = All;
                Image = Doctor;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Vendor Card";
                RunPageView = SORTING("No.") ORDER(Ascending);
                RunPageLink = "No." = field("Vendor/Customer Code");
                trigger OnAction();
                begin

                end;
            }
        }
    }

}
