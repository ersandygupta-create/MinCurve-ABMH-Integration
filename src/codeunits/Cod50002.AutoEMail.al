codeunit 50002 "E3 HIS Auto E-Mail"
{
    Permissions = tabledata "Vendor Ledger Entry" = rm;

    trigger OnRun()
    begin
        for i := 1 to 3 do begin
            VendorLedgerEntry1.Reset();
            // VendorLedgerEntry1.SetRange("Vendor No.", Vendor."No.");
            VendorLedgerEntry1.SETRANGE("E3 Send E-Mail", FALSE);
            VendorLedgerEntry1.SetFilter("Source Code", 'BANKPYMTV');
            VendorLedgerEntry1.CalcFields("E3 Vendor Email");
            VendorLedgerEntry1.SetFilter("E3 Vendor Email", '<>%1', '');
            VendorLedgerEntry1.SetRange("Journal Entry", false);
            VendorLedgerEntry1.CalcFields("Remaining Amt. (LCY)");
            VendorLedgerEntry1.SetFilter("Remaining Amt. (LCY)", '%1', 0);
            IF VendorLedgerEntry1.FindSet() then
                repeat
                    SendMailforVendorLedgerEntryPaymentAdviceJob(VendorLedgerEntry1);
                    i := i + 1;
                    if (i = 3) then
                        break;
                until VendorLedgerEntry1.Next() = 0;

            ;

        end;
    end;

    procedure SendMailforVendorLedgerEntryPaymentAdviceJob(VendLedgerEntry: Record "Vendor Ledger Entry")
    begin
        EMailSetup.Get();
        VendorLedgerEntry1.Reset();
        VendorLedgerEntry1.SetRange("Document Type", VendLedgerEntry."Document Type");
        VendorLedgerEntry1.SetRange("Entry No.", VendLedgerEntry."Entry No.");
        IF VendorLedgerEntry1.FindFirst() then begin
            EMailSetup.Get();
            DocumentNo := DELCHR(VendorLedgerEntry1."Document No.", '=', '\,/,-');
            Postingdate := UpperCase(Format(VendorLedgerEntry1."Posting Date", 0, '<Day,2>-<Month Text,3>-<Year,2>'));
            FileNameVar1 := EMailSetup."Folder Path" + DocumentNo + '-' + Postingdate;
            Vendor.Get(VendorLedgerEntry1."Vendor No.");
            IF Vendor."E-Mail" <> '' then begin
                RecRef.GetTable(VendorLedgerEntry1);
                TempBlob.CreateOutStream(Out);
                TempBlob.CreateInStream(InStr);
                REPORT.SAVEAS(EMailSetup."Report ID", FileNameVar1, REPORTFORMAT::Pdf, Out, RecRef);
                //Subject := VendorLedgerEntry1."Document No." + ', Posting Date ' + FORMAT(VendorLedgerEntry1."Posting Date");
                Subject := 'Payment Advice' + ' - ' + VendorLedgerEntry1."Document No." + ' [' + VendorLedgerEntry1."Vendor No." + ' - ' + VendorLedgerEntry1."Vendor Name" + '] ';
                EmailMessage.Create(Vendor."E-Mail", Subject, EMailSetup."E-Mail Body");

                Clear(Addcc);

                EmailMessage.Create(
                    Vendor."E-Mail",
                    Subject,
                    EMailSetup."E-Mail Body",
                    false);

                // Add CC from Vendor Card - Payment Advice E-Mail
                if Vendor."Payment Advice E-mail" <> '' then
                    foreach CCMail in Vendor."Payment Advice E-mail".Split(';') do begin
                        CCMail := DelChr(CCMail, '<>', ' ');
                        if CCMail <> '' then
                            EmailMessage.AddRecipient(
                                Enum::"Email Recipient Type"::Cc,
                                CCMail);
                    end;
                EmailMessage.AddAttachment(FileNameVar1 + '.pdf', 'PDF', InStr);
                Email.Send(EmailMessage, Enum::"Email Scenario"::"Hospital E-Mail");
                VendLedgerEntry."E3 Send E-Mail" := true;
                VendLedgerEntry.MODIFY;
                //   SLEEP(10000);
                TotalSend += 1;
                COMMIT;
                //   dlgProgress.OPEN(Text002);
                // dlgProgress.UPDATE(1, TotalSend);
            end;
        end;
        //UNTIL VendLedgerEntry.NEXT = 0;
        //   dlgProgress.CLOSE;
        // end;
    end;

    procedure SendMailforVendorLedgerEntryPaymentAdvice(VendLedgerEntry: Record "Vendor Ledger Entry")
    begin
        VendLedgerEntry.SETRANGE("E3 Send E-Mail", FALSE);
        VendLedgerEntry.SetRange("E3 Select E-Mail", true);
        VendLedgerEntry.SetRange("Journal Entry", false);
        //VendLedgerEntry.SetFilter("Document Type", '%1|%2', VendLedgerEntry."Document Type"::Payment, VendLedgerEntry."Document Type"::" ");
        VendorLedgerEntry1.SetFilter("Source Code", 'BANKPYMTV');
        VendLedgerEntry.CalcFields("Remaining Amt. (LCY)");
        VendLedgerEntry.SetFilter("Remaining Amt. (LCY)", '%1', 0);
        IF VendLedgerEntry.FindFirst() then begin
            repeat
                EMailSetup.Get();
                VendorLedgerEntry1.Reset();
                VendorLedgerEntry1.SetRange("Document Type", VendLedgerEntry."Document Type");
                VendorLedgerEntry1.SetRange("Document No.", VendLedgerEntry."Document No.");
                VendorLedgerEntry1.SetRange("Vendor No.", VendLedgerEntry."Vendor No.");
                IF VendorLedgerEntry1.FindFirst() then begin
                    EMailSetup.Get();
                    DocumentNo := DELCHR(VendorLedgerEntry1."Document No.", '=', '\,/,-');
                    Postingdate := UpperCase(Format(VendorLedgerEntry1."Posting Date", 0, '<Day,2>-<Month Text,3>-<Year,2>'));
                    FileNameVar1 := EMailSetup."Folder Path" + DocumentNo + '-' + Postingdate;
                    Vendor.Get(VendorLedgerEntry1."Vendor No.");
                    IF Vendor."E-Mail" <> '' then begin
                        RecRef.GetTable(VendorLedgerEntry1);
                        TempBlob.CreateOutStream(Out);
                        TempBlob.CreateInStream(InStr);
                        REPORT.SAVEAS(EMailSetup."Report ID", FileNameVar1, REPORTFORMAT::Pdf, Out, RecRef);
                        //Subject := VendorLedgerEntry1."Document No." + ', Posting Date ' + FORMAT(VendorLedgerEntry1."Posting Date");
                        Subject := 'Payment Advice' + ' - ' + VendorLedgerEntry1."Document No." + ' [' + VendorLedgerEntry1."Vendor No." + ' - ' + VendorLedgerEntry1."Vendor Name" + '] ';
                        EmailMessage.Create(Vendor."E-Mail", Subject, EMailSetup."E-Mail Body");

                        if Vendor."Payment Advice E-mail" <> '' then
                            foreach CCMail in Vendor."Payment Advice E-mail".Split(';') do begin
                                CCMail := DelChr(CCMail, '<>', ' ');
                                if CCMail <> '' then
                                    EmailMessage.AddRecipient(
                                        Enum::"Email Recipient Type"::Cc,
                                        CCMail);
                            end;
                        EmailMessage.AddAttachment(FileNameVar1 + '.pdf', 'PDF', InStr);
                        Email.Send(EmailMessage, Enum::"Email Scenario"::"Hospital E-Mail");
                        VendLedgerEntry."E3 Send E-Mail" := true;
                        VendLedgerEntry.MODIFY;
                        SLEEP(10000);
                        TotalSend += 1;
                        COMMIT;
                        dlgProgress.OPEN(Text002);
                        dlgProgress.UPDATE(1, TotalSend);
                    end;
                end;
            UNTIL VendLedgerEntry.NEXT = 0;
            dlgProgress.CLOSE;
        end;
    end;

    var
        EMailSetup: Record "E3 HIS E-Mail Setup";
        VendorLedgerEntry1: Record "Vendor Ledger Entry";
        FileNameVar1: Text[500];
        DocumentNo: Text[20];
        Postingdate: Text;
        EmailAccount: Record "Email Account";
        Subject: Text[1000];
        Email: Codeunit Email;

        EmailMessage: Codeunit "Email Message";
        Mail: Codeunit Mail;
        Vendor: Record Vendor;
        TotalSend: Integer;
        dlgProgress: Dialog;
        Text002: TextConst ENN = 'Total E-Mail Send #1', ENU = 'Total E-Mail Send #1';
        TempBlob: Codeunit "Temp Blob";
        Out: OutStream;
        RecRef: RecordRef;
        InStr: InStream;
        Addcc: List of [Text];
        ToEmailID: List of [Text];
        EmailItem: Record "Email Item";
        i: Integer;
        CCMail: Text;


}
