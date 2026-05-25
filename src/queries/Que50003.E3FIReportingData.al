query 50003 "E3 FI Reporting Data"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'E3FIReportingData';
    EntityName = 'e3FIReportingData';
    EntitySetName = 'e3FIReportingData';
    QueryType = API;

    elements
    {
        dataitem(gLEntry; "G/L Entry")
        {
            column(entryNo; "Entry No.")
            {
            }
            column(postingDate; "Posting Date")
            {
            }
            column(documentNo; "Document No.")
            {
            }
            column(gLAccountNo; "G/L Account No.")
            {
            }
            column(description; Description)
            {
            }
            column(globalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(globalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(shortcutDimension3Code; "Shortcut Dimension 3 Code")
            {
            }
            column(documentDate; "Document Date")
            {
            }
            column(utrNo; "E3 UTR No.")
            {
            }
            column(hisDocumentType; "E3 HIS Document Type")
            {
            }
            column(externalDocumentNo; "External Document No.")
            {
            }
            column(encounterNo; "E3 Encounter No.")
            {
            }
            column(patientName; "E3 Patient Name")
            {
            }
            column(E3DoctorName; "E3 Doctor Name")
            {
            }
            column(E3Speciality; "E3 Speciality")
            {
            }
            column(payerCode; "E3 Payer Code")
            {
            }
            column(E3PayerName; "E3 Payer Name")
            {
            }
            column(sponsorCode; "E3 Sponsor Code")
            {
            }
            column(sponsorName; "E3 Sponsor Name")
            {
            }
            column(sourceType; "Source Type")
            {
            }
            column(sourceno; "Source No.")
            {
            }
            column(narration; "E3 Narration")
            {
            }
            column(voucherNarration; "E3 Voucher Narration")
            {
            }
            column(lineNarration; "E3 Line Narration")
            {
            }
            column(storeCode; "E3 Store Code")
            {
            }
            column(subGroupCode; "E3 Sub Group Code")
            {
            }
            column(receiptNo; "E3 Receipt No.")
            {
            }
            column(uhid; "E3 UHID")
            {
            }
            column(amount; Amount)
            {
            }
            column(systemCreatedAt; SystemCreatedAt)
            {
            }
            column(userid; "User ID")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
