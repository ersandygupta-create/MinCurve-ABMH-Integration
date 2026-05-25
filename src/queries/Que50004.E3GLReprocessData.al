query 50004 "E3 GL Reprocessed Data"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'E3GLReprocessedData';
    EntityName = 'e3GLReprocessedData';
    EntitySetName = 'e3GLReprocessedData';
    QueryType = API;

    elements
    {
        dataitem(hisRprocessDoc; "E3 HIS Delete Document")
        {
            column(entryNo; "Entry No.")
            {
            }
            column(documentNo; "Document No.")
            {
            }
            column(postingDate; "Posting Date")
            {
            }
            column(createdBy; "Created By")
            {
            }
            column(createdDatetime; "Created Datetime")
            {
            }
            column(approvedBy; "Approved By")
            {
            }
            column(approvedDatetime; "Approved Datetime")
            {
            }
            column(processedBy; "Processed By")
            {
            }
            column(processedDatetime; "Processed Datetime")
            {
            }
            column(status; Status)
            {
            }
            column(errorText; "Error Text")
            {
            }

        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
