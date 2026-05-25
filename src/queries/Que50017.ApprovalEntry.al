query 50017 "Approval Entry"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'approvalEntry';
    EntityName = 'approvalEntry';
    EntitySetName = 'approvalEntry';
    QueryType = API;

    elements
    {
        dataitem(approvalEntry; "Approval Entry")
        {
            column(entryNo; "Entry No.") { }
            column(tableID; "Table ID") { }
            column(documentNo; "Document No.") { }
            column(sequenceNo; "Sequence No.") { }
            column(status; Status) { }
            column(dateTimeSentforApproval; "Date-Time Sent for Approval") { }
            column(lastDateTimeModified; "Last Date-Time Modified") { }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}