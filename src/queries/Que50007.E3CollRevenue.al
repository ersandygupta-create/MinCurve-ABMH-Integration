query 50007 "HIS Coll/Revenue Data"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'hisRevCollectiondata';
    EntityName = 'hisRevCollectionData';
    EntitySetName = 'hisRevCollectionData';
    QueryType = API;

    elements
    {
        dataitem(hisRevenueStaging; "E3 HIS Revenue Staging Table")
        {
            column(hisDocumentType; "HIS Document Type")
            {
            }
            column(documentno; "Document No.")
            {
            }
            column(documentdate; "Document Date")
            {
            }
            column(mop; "Mode of Payment")
            {
            }
            column(amount; Amount)
            {
            }
            column(hisbilltype; "HIS Bill Type")
            {
            }
            column(extdocmentno; "External Document No.")
            {
            }
            column(unitcode; "Shortcut Dimension 1 Code")
            {
            }
            column(deptcode; "Shortcut Dimension 2 Code")
            {
            }
            column(chequeno; "Cheque No.")
            {
            }
            column(chequedate; "Cheque Date")
            {
            }
            column(patientname; "Patient Name")
            {
            }
            column(uhid; UHID)
            {
            }
            column(encounterno; "Encounter No.")
            {
            }
            column(ipno; "IP No.")
            {
            }
            column(sponsorcode; "Sponsor Code")
            {
            }
            column(sponsarname; "Sponsor Name")
            {
            }
            column(payercode; "Payer Code")
            {
            }
            column(payername; "Payer Name")
            {
            }
            column(payorcategory; "Payor Category")
            {
            }
            column(errordescription; "Error Description")
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