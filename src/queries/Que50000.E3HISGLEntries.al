query 50000 "E3 HIS G/L Entries"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'E3GLEntries';
    EntityName = 'e3GLEntries';
    EntitySetName = 'e3GLEntries';
    QueryType = API;

    elements
    {
        dataitem(gLEntry; "G/L Entry")
        {

            column(postingDate; "Posting Date")
            {
            }
            column(gLAccountNo; "G/L Account No.")
            {
            }
            column(globalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(globalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(E3DoctorName; "E3 Doctor Name")
            {
            }
            column(E3Speciality; "E3 Speciality")
            {
            }
            column(E3PayerName; "E3 Payer Name")
            {
            }
            column(sourceType; "Source Type")
            {
            }
            column(sourceno; "Source No.")
            {
            }
            column(amount; Amount)
            {
                Method = Sum;
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
