pageextension 50007 "E3 Bank Payment Voucher" extends "Bank Payment Voucher"
{
    layout
    {
        addafter(Amount)
        {
            field("DebitAmount"; Rec."Debit Amount")
            {
                ApplicationArea = All;
                Caption = 'Debit Amount';
                ToolTip = 'Specifies the Debit Amount that the entry on the journal line will be posted to.';
            }
            field("CreditAmount"; Rec."Credit Amount")
            {
                ApplicationArea = All;
                Caption = 'Credit Amount';
                ToolTip = 'Specifies the Credit Amount that the entry on the journal line will be posted to.';
            }
            field("Posting Group"; Rec."Posting Group")
            {
                ApplicationArea = All;
                Editable = true;
                ToolTip = 'Specifies the account posting group that the entry on the journal line will be posted to.';
            }
            field("E3 Narration"; Rec."E3 Narration")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Narrantion field.';
            }
            field("E3 UTR No."; Rec."E3 UTR No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the UTR No. field.';
            }
            field("E3 HIS Module"; Rec."E3 HIS Module")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the HIS Module field.';
            }
            field("E3 HIS Document Type"; Rec."E3 HIS Document Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the HIS Document Type field.';
            }
            field("E3 Store Code"; Rec."E3 Store Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Store Code field.';
            }
            field("E3 Sub Group Code"; Rec."E3 Sub Group Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sub Group Code field.';
            }
            field("E3 Receipt No."; Rec."E3 Receipt No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Receipt No. field.';
            }

            field("E3 UHID"; Rec."E3 UHID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the UHID field.';
            }
            field("E3 Patient Name"; Rec."E3 Patient Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Patient Name field.';
            }
            field("E3 Validation Key"; Rec."E3 Validation Key")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vaidation Key field.';
            }
            field("Purchase Order No."; Rec."Purchase Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Order No. field.';
            }
            field("Recipient Bank Account"; Rec."Recipient Bank Account")
            {
                Caption = 'Vendor Bank';
                ToolTip = 'Specifies the value of the Purchase Recipient Bank Account field.';
                ApplicationArea = All;
            }

        }
    }
    actions
    {
        addafter("Void &All Checks")
        {
            action("Axis Print Check")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Multiple Vendor Check Print A';
                Image = Report;
                RunObject = report "Axis Bank Check_M";
                RunPageMode = Edit;
            }
            action("Check Print Check")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Check Print H';
                Image = Report;
                RunObject = report "Bank Check H";
                RunPageMode = Edit;
            }
        }
        addafter("Test Report")
        {
            action("Bank Payment NotePad")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Payment NotePad';
                Image = XmlPort;
                //RunObject = xmlport "3E Bank Payment Notepad";
                RunPageMode = Edit;
            }
        }
    }
}