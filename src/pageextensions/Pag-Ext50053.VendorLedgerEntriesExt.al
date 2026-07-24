pageextension 50053 "E3 HIS Vend. Ledger Entries" extends "Vendor Ledger Entries"
{
    layout
    {
        addbefore("Location GST Reg. No.")
        {
            field("VendorPostingGroup"; Rec."Vendor Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Vendor Posting Group';
                Editable = false;
                ToolTip = 'Specifies the value of the Vendor Posting Group field.';
            }
            field("Purchase Order No."; Rec."Purchase Order No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("E3 Send E-Mail"; rec."E3 Send E-Mail")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("E3 Payment Terms Code"; Rec."E3 Payment Terms Code")
            {
                Editable = false;
                ApplicationArea = All;
                Style = StrongAccent;
                StyleExpr = TRUE;
            }
            field("TDS Amount"; Rec."Total TDS Including SHE CESS")
            {
                Editable = false;
                ApplicationArea = All;
                Style = StrongAccent;
                StyleExpr = TRUE;
            }
            field("E3 Narration"; Rec."E3 Narration")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Narration field.';
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
            field("E3 Receipt No."; Rec."E3 Receipt No.")
            {
                Caption = 'Receipt No.';
                ToolTip = 'Specifies the value of the Receipt No. field.';
                ApplicationArea = All;
            }
            field("E3 UHID"; Rec."E3 UHID")
            {
                Caption = 'UHID';
                ToolTip = 'Specifies the value of the UHID field.';
                ApplicationArea = All;
            }
            field("E3 Patient Name"; Rec."E3 Patient Name")
            {
                Caption = 'Patient Name';
                ToolTip = 'Specifies the value of the Patient Name field.';
                ApplicationArea = All;
            }
            field("E3 Bank Account No."; Rec."E3 Bank Account No.")
            {
                Caption = 'Bank Account No.';
                ToolTip = 'Specifies the value of the Bank Account No. field.';
                ApplicationArea = All;
                //Visible = false;
            }
            field("E3 IFSC Code"; Rec."E3 IFSC Code")
            {
                Caption = 'IFSC Code';
                ToolTip = 'Specifies the value of the IFSC Code field.';
                ApplicationArea = All;
                //Visible = false;
            }
            field("E3 Branch"; Rec."E3 Branch")
            {
                Caption = 'Branch';
                ToolTip = 'Specifies the value of the Branch field.';
                ApplicationArea = All;
                //Visible = false;
            }
            field("RP User Id"; Rec."RP User Id")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("RP DateTime"; Rec."RP DateTime")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("CR User Id"; Rec."CR User Id")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("CR DateTime"; Rec."CR DateTime")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Ready for Payment"; Rec."Ready for Payment")
            {
                ApplicationArea = All;
            }



        }
    }

    actions
    {
        addbefore("&Navigate")
        {
            action("E3 Print Payment Advice")
            {
                ApplicationArea = All;
                Caption = 'Print Payment Advice';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF (Rec."Document Type" = Rec."Document Type"::Payment) OR (Rec."Document Type" = Rec."Document Type"::" ") THEN begin
                        VendorLedgerEntry.Reset();
                        VendorLedgerEntry.SetRange("Document No.", Rec."Document No.");
                        VendorLedgerEntry.SetRange("Vendor No.", Rec."Vendor No.");
                        if VendorLedgerEntry.FindFirst() then
                            Report.RunModal(Report::"E3 Vendor - Payment Advice", true, false, VendorLedgerEntry);
                    end else
                        Error('Please Payment Advice Select only Payment Document !');
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Amount to Pay" = 0 then
            Rec.Validate("Amount to Pay", Rec."Remaining Amount");
        CheckBln := USERID;
        UserSetup.RESET();
        UserSetup.SETRANGE("User ID", CheckBln);
        IF UserSetup.FIND('-') THEN
            IF UserSetup."Vendor Ledger View" <> TRUE THEN
                ERROR('Permission of Vendor Ledger View is not added in your access. If required please contact to IT Administrator ');
    END;

    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        CheckBln: Code[30];
        UserSetup: Record "User Setup";
}
