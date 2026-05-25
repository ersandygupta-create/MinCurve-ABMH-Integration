page 50001 "E3 HIS Vendor Staging Card"
{

    Caption = 'HIS Vendor Staging Card';
    PageType = Card;
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
                    Visible = false;
                    ApplicationArea = All;
                }
                field("MSME Type"; Rec."MSME Type")
                {
                    ToolTip = 'Specifies the value of the MSME Type field';
                    ApplicationArea = All;
                }
                field("MSME No."; Rec."MSME No.")
                {
                    ToolTip = 'Specifies the value of the MSME No. field';
                    ApplicationArea = All;
                }
                field(Certificate; Rec.Certificate)
                {
                    ToolTip = 'Specifies the value of the Certificate field';
                    ApplicationArea = All;
                }
                field("Party Type"; Rec."Party Type")
                {
                    ToolTip = 'Specifies the value of the Party Type field';
                    ApplicationArea = All;
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = false;
                }
                field("Vendor/Customer Code"; Rec."Vendor/Customer Code")
                {
                    Caption = 'Vendor No.';
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field';
                    ApplicationArea = All;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies the value of the Name 2 field';
                    ApplicationArea = All;
                }
                field("Error Description"; Rec."Error Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
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

                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = all;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = ALL;
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
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = ALL;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = ALL;
                }
                field("Application Method"; Rec."Application Method")
                {
                    ApplicationArea = all;
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
                }
                field("GST Registration No."; Rec."GST Registration No.")
                {
                    ApplicationArea = ALL;
                    trigger OnValidate()
                    begin
                        if rec."GST Registration No." <> '' then
                            Rec."GST Vendor Type" := "GST Vendor Type"::Registered
                        else
                            Rec."GST Vendor Type" := "GST Vendor Type"::Unregistered;
                    end;
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
                field("Bank IFSC Code"; Rec."IFSC Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the IFSC Code field';
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = all;
                }
            }
            group("Log Details")
            {
                field(SystemCreatedBy; Rec.SystemId)
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
            action("Create Vendor Card")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create Vendor Card';
                Image = Create;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    HISIntegration: Codeunit "E3 HIS Integration Mgmt.";
                begin
                    if Rec."Party Type" = Rec."Party Type"::Vendor then begin
                        HISIntegration.InitVendorMaster(Rec."Entry No.");
                    end;
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Party Type" := Rec."Party Type"::Vendor
    end;

    trigger OnInit()
    begin
        if rec."GST Registration No." <> '' then
            rec."GST Vendor Type" := "GST Vendor Type"::Registered
        else
            Rec."GST Vendor Type" := "GST Vendor Type"::Unregistered;
    end;

}
