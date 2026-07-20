codeunit 50100 "SendReportEmailManagement"
{
    trigger OnRun()
    begin
        SendEmail();
    end;

    procedure SendEmail()
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
    begin
        // Create the Email Message (To, Subject, Body, IsHtml)
        EmailMessage.Create(
            'er.sandygupta@gmail.com',
            'Greeting',
            'Hi',
            false // Set to false for plain text
        );

        // Send the email
        if Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
            Message('The email has been sent successfully.')
        else
            Error('Failed to send the email. Please check your Email Setup in Business Central.');
    end;
}

/*codeunit 50100 "SendReportEmailManagement"
{
    trigger OnRun()
    begin
        SendReportViaEmail();
    end;

    procedure SendReportViaEmail()
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        TempBlob: Codeunit "Temp Blob";
        ReportOutStream: OutStream;
        ReportInStream: InStream;
        ParametersXml: Text;
    begin
        // 1. Create the Email Message (To, Subject, Body)
        EmailMessage.Create(
            'er.sandygupta@gmail.com',
            'Monthly Sales Report',
            'Hello,<br><br>Please find attached the requested report.<br><br>Best regards,<br>Finance Team',
            true // True means the body is formatted as HTML
        );

        // 2. Prepare a Blob stream to hold the generated PDF
        TempBlob.CreateOutStream(ReportOutStream);

        // 3. Save the report directly to the stream as a PDF
        // Syntax: Report.SaveAs(ReportID, ParametersXml, ReportFormat::Pdf, OutStream [, RecordRef])
        // We use Report::"Standard Sales - Invoice" (Report 1306) as an example.
        Report.SaveAs(Report::"Standard Sales - Invoice", ParametersXml, ReportFormat::Pdf, ReportOutStream);

        // 4. Convert the OutStream back to an InStream so the email module can read it
        TempBlob.CreateInStream(ReportInStream);

        // 5. Attach the stream to the email message
        EmailMessage.AddAttachment(
            'Sales_Invoice_Report.pdf', // File name for the attachment
            'application/pdf',          // MIME type
            ReportInStream
        );

        // 6. Send the email using the standard BC setup
        // Email.Send returns true if successful
        if Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
            Message('The email with the report attachment has been sent successfully.')
        else
            Error('Failed to send the email. Please check your Email Setup in Business Central.');
    end;
}*/
