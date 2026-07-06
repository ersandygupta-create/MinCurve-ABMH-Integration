page 50182 "E3 Indent Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "E3 Indent Header";
    Caption = 'Indent Header';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Indent No.';
                    ApplicationArea = All;
                    AssistEdit = true;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }

                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }

                field("Indent Date"; Rec."Indent Date")
                {
                    ApplicationArea = All;
                }
                field("Voucher Type Code"; Rec."Voucher Type Code")
                {
                    ApplicationArea = All;
                }
                field("Voucher Type Name"; Rec."Voucher Type Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Expected Receive Date"; Rec."Expected Receive Date")
                {
                    ApplicationArea = All;
                }

                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                }

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field(IndentorCode; Rec."Requesting Staff Code")
                {
                    ApplicationArea = All;
                }
                field("Approval Date Time"; Rec."Approval Date Time")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }

            group("Dimensions")
            {
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Business Unit';
                }
                field("Business Unit Name"; Rec."Business Unit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Department Code';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("To Department Code"; Rec."To Department Code")
                {
                    ApplicationArea = All;
                }
                field("To Department Name"; Rec."To Department Name")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }

                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("To Location Code"; Rec."To Location Code")
                {
                    ApplicationArea = All;
                }

                field("To Location Name"; Rec."To Location Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(IndentLines; "E3 Indent Line Subform")
            {
                ApplicationArea = All;
                Caption = 'Indent Line Subform';
                SubPageLink = "Document No." = FIELD("Document No.");
            }
        }
    }
}