query 50010 "HIS VCDIMaster Data"
{
    APIGroup = 'apiHIS';
    APIPublisher = 'mindcurve';
    APIVersion = 'v2.0';
    Caption = 'hisMasterdata';
    EntityName = 'hisMasterData';
    EntitySetName = 'hisMasterData';
    QueryType = API;

    elements
    {
        dataitem(hisMasterStaging; "E3 HIS Master Staging")
        {
            column(partyType; "Party Type")
            {
            }
            column(hisCode; "HIS Code")
            {
            }
            column(name; Name)
            {
            }
            column(address; Address)
            {
            }
            column(genBusPostingGroup; "Gen. Bus. Posting Group")
            {
            }
            column(vendorPostingGroup; "Vendor Posting Group")
            {
            }
            column(customerPostingGroup; "Customer Posting Group")
            {
            }
            column(stateCode; "State Code")
            {
            }
            column(panNo; "P.A.N. No.")
            {
            }
            column(gstVendorType; "GST Vendor Type")
            {
            }
            column(gstRegistrationNo; "GST Registration No.")
            {
            }
            column(gstCustomerType; "GST Customer Type")
            {
            }
            column(unitcode; "Global Dimension 1 Code")
            {
            }
            column(genProdPostingGroup; "Gen. Prod. Posting Group")
            {
            }
            column(baseUnitofMeasure; "Base Unit of Measure")
            {
            }
            column(inventoryNonInventory; "Inventory-NonInventory")
            {
            }
            column(gstGroupCode; "GST Group Code")
            {
            }
            column(hsnSACCode; "HSN/SAC Code")
            {
            }
            column(gstCredit; "GST Credit")
            {
            }
            column(itemCategoryCode; "Item Category Code")
            {
            }
            column(errorDescription; "Error Description")
            {
            }
            column(isprocessed; IsCreated)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}