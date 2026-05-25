query 50011 "HIS Settlement Data"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'hisSettlementndata';
    EntityName = 'hisSettlementData';
    EntitySetName = 'hisSettlementData';
    QueryType = API;

    elements
    {
        dataitem(hisSettlementStaging; "E3 HIS Settlement Staging")
        {
            column(hisDocumentType; "HIS Document Type")
            {
            }
            column(documentNo; "Document No.")
            {
            }
            column(documentDate; "Document Date")
            {
            }
            column(amount; Amount)
            {
            }
            column(balAccountType; "Bal. Account Type")
            {
            }
            column(balAccountNo; "Bal. Account No")
            {
            }
            column(extdocumentno; "External Document No.")
            {
            }

            column(unitcode; "Shortcut Dimension 1 Code")
            {
            }
            column(patientName; "Patient Name")
            {
            }
            column(uhid; UHID)
            {
            }
            column(encounterNo; "Encounter No.")
            {
            }
            column(ipNo; "IP No.")
            {
            }
            column(sponsorCode; "Sponsor Code")
            {
            }
            column(sponsorName; "Sponsor Name")
            {
            }
            column(payerName; "Payer Name")
            {
            }
            column(payorCategory; "Payor Category")
            {
            }
            column(errorDescription; "Error Description")
            {
            }
            column(isprocessed; "General Entries Created")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}