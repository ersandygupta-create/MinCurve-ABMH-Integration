query 50008 "HIS Consumption Data"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'hisConsumptiondata';
    EntityName = 'hisConsumptionData';
    EntitySetName = 'hisConsumptionData';
    QueryType = API;

    elements
    {
        dataitem(hisConsumptionEntries; "E3 HIS Consumption Entries")
        {
            column(locationcode; "Location Code")
            {
            }
            column(uhid; UHID)
            {
            }
            column(patientname; "PATIENT_NAMES")
            {
            }
            column(itemid; ITEM_ID)
            {
            }
            column(itemname; ITEM_NAME)
            {
            }
            column(qty; QUANTITY)
            {
            }
            column(itemcategorycode; "Item Category Code")
            {
            }
            column(itemcategoryname; "Item Category Name")
            {
            }
            column(postingdate; "Posting Date")
            {
            }
            column(documentno; "Document No.")
            {
            }
            column(hisdocumenttype; "HIS Document Type")
            {
            }
            column(extdocumentno; "External Document No.")
            {
            }
            column(amount; "Amount")
            {
            }
            column(unitcode; "Shortcut Dimension 1 Code")
            {
            }
            column(deptcode; "Shortcut Dimension 2 Code")
            {
            }
            column(departmentName; DepartmentName)
            {
            }
            column(speciality; Speciality)
            {
            }
            column(issueReturnFlag; "Issue/Return Flag")
            {
            }
            column(isprocessed; "General Entries Created")
            {
            }
            column(errorDescription; "Error Description")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}