pageextension 50005 "E3 HIS G/L Entries" extends "General Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("Amount LCY"; Rec.Amount)
            {
                ApplicationArea = All;
                Caption = 'Amount';
                ToolTip = 'Specifies the value of the Amount field.';
            }
            field("E3 Narration"; Rec."E3 Narration")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Narration field.';
            }
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Document Date field.';
            }
            field("E3 UTR No."; Rec."E3 UTR No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the UTR No. field.';
            }
            field("E3 HIS Module"; Rec."E3 HIS Module")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the HIS Module field.';
            }
            field("E3 HIS Document Type"; Rec."E3 HIS Document Type")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the HIS Document Type field.';
            }
            field("E3 Store Code"; Rec."E3 Store Code")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Store Code field.';
            }
            field("E3 Sub Group Code"; Rec."E3 Sub Group Code")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Sub Group Code field.';
            }
            field("E3 Receipt No."; Rec."E3 Receipt No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Receipt No. field.';
            }

            field("E3 UHID"; Rec."E3 UHID")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the UHID field.';
            }
            field("E3 Patient Name"; Rec."E3 Patient Name")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Patient Name field.';
            }
            field("E3 Validation Key"; Rec."E3 Validation Key")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Validation Key field.';
            }
            field("E3 Encounter No."; Rec."E3 Encounter No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Encounter No. field.';
            }
            field("E3 Doctor Name"; Rec."E3 Doctor Name")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Doctor Name field.';
            }
            field("E3 Speciality"; Rec."E3 Speciality")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Speciality field.';
            }
            field("E3 Sponsor Code"; Rec."E3 Sponsor Code")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Sponsor Code field.';
            }
            field("E3 Sponsor Name"; Rec."E3 Sponsor Name")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Sponsor Name field.';
            }
            field("E3 Payer Code"; Rec."E3 Payer Code")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Payer Code field.';
            }
            field("E3 Payer Name"; Rec."E3 Payer Name")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Payer Name field.';
            }
            field("E3 Line Narration"; Rec."E3 Line Narration")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Line Narration field.', Comment = '%';
            }
            field("E3 Voucher Narration"; Rec."E3 Voucher Narration")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Voucher Narration field.', Comment = '%';
            }

            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the SystemCreatedAt field.';
            }
            field("Created By"; Rec."User ID")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the SystemCreatedBy field.';
            }


        }
    }

    actions
    {
        addafter("Print Voucher")
        {
            action("Print Voucher Dimension")
            {
                ApplicationArea = All;
                Caption = 'Print Voucher Dimension';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Print;
                ToolTip = 'Executes the Print Voucher Dimension action.';
                trigger OnAction()
                begin
                    GLEntry.RESET;
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
                    GLEntry.SETRANGE("Document No.", Rec."Document No.");
                    GLEntry.SETRANGE("Posting Date", Rec."Posting Date");
                    if GLEntry.FindFirst() then
                        REPORT.RUNMODAL(REPORT::"Posted Voucher - Post Voucher", TRUE, TRUE, GLEntry);

                end;
            }
        }


    }
    var
        GLEntry: Record "G/L Entry";
}
