page 50036 "E3 Vendor Ledger E-Mail"
{

    ApplicationArea = All;
    Caption = 'Vendor Ledger E-mail';
    PageType = List;
    SourceTable = "Vendor Ledger Entry";
    Permissions = TableData "Cust. Ledger Entry" = rm;
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTableView = where("Document Type" = filter(Payment), "Source Code" = filter('BANKPYMTV'), "Journal Entry" = filter(false), "Remaining Amt. (LCY)" = filter(0));
    //SourceTableView = where("Document Type" = filter(Payment | ''), "Journal Entry" = filter(false), "Remaining Amt. (LCY)" = filter(0));

    layout
    {
        area(content)
        {
            group("Filter")

            {
                field("Date Filter"; DateFilter)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF DateFilter <> '' THEN begin
                            Rec.SetFilter("Posting Date", DateFilter);
                        END ELSE BEGIN
                            Rec.SETRANGE("Posting Date");
                        END;
                        CurrPage.UPDATE;
                    end;

                }
                field("Vendor No"; VendorNo)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF VendorNo <> '' THEN BEGIN
                            Rec.SETFILTER("Vendor No.", VendorNo);
                        END
                        ELSE BEGIN
                            Rec.SETRANGE("Vendor No.");
                        END;
                        CurrPage.UPDATE;
                    end;

                }
            }
            repeater(General)
            {

                field("Select E-Mail"; Rec."E3 Select E-Mail")
                {
                    Caption = 'Select E-Mail';
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Original Amt. (LCY)"; Rec."Original Amt. (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Debit Amount (LCY)"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Credit Amount (LCY)"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Remaining Amt. (LCY)"; Rec."Remaining Amt. (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Send E-Mail"; Rec."E3 Send E-Mail")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor E-Mail"; Rec."E3 Vendor Email")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor E-Mail';
                }



            }

        }
    }
    actions
    {
        area(navigation)
        {
            action("Send Mail")
            {
                Caption = 'Send Mail';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    VendorLedgerEntry_Rec: Record "Vendor Ledger Entry";
                    EMailPaymentAdvice: Codeunit "E3 HIS Auto E-Mail";

                // begin
                //     EMailPaymentAdvice.Run();
                // end;
                begin

                    IF Confirm('Do you want to Send the E-Mail !') then begin
                        if (DateFilter <> '') or (VendorNo <> '') then begin
                            VendorLedgerEntry_Rec.Reset;
                            VendorLedgerEntry_Rec.SetRange("E3 Select E-Mail", true);
                            VendorLedgerEntry_Rec.SetRange("Vendor No.", Rec."Vendor No.");
                            if VendorLedgerEntry_Rec.FindFirst then begin
                                EMailPaymentAdvice.SendMailforVendorLedgerEntryPaymentAdvice(VendorLedgerEntry_Rec);

                            end;
                        end else
                            Error('Select one Filter Date Filter Or Vendor No.');
                    end;
                end;
            }
            action("Select Mail")
            {
                Caption = 'Select Mail';
                Image = SelectField;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF (DateFilter <> '') OR (VendorNo <> '') THEN BEGIN
                        IF Rec.FINDFIRST THEN
                            REPEAT
                                Rec."E3 Select E-Mail" := TRUE;
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                    END;
                end;
            }
            action("Clear Select Mail")
            {
                Caption = 'Clear Select Mail';
                Image = SelectField;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF (DateFilter <> '') OR (VendorNo <> '') THEN //BEGIN
                        IF Rec.FindFirst() THEN
                            REPEAT
                                Rec."E3 Select E-Mail" := false;
                                Rec.Modify();
                            UNTIL Rec.Next() = 0;
                END;
                //end;
            }
            action("Print Payment Advice")
            {
                Caption = 'Print Payment Advice';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    VendorLedgerEntry.Reset();
                    VendorLedgerEntry.SetRange("Document No.", Rec."Document No.");
                    VendorLedgerEntry.SetRange("Vendor No.", Rec."Vendor No.");
                    if VendorLedgerEntry.FindFirst() then //begin
                        Report.RunModal(Report::"E3 Vendor - Payment Advice", true, false, VendorLedgerEntry);
                end;
                //end;
            }

        }
    }


    trigger OnOpenPage()
    begin
        Rec.SetRange("E3 Send E-Mail", false);
    end;

    var
        DateFilter: Text;
        VendorNo: Text;
        VendorLedgerEntry: Record "Vendor Ledger Entry";


}
