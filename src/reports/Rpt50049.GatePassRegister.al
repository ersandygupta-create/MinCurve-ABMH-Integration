report 50049 "Gate Pass Register"
{
    Caption = 'Gate Pass Register';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50049.GatePassRegister.rdl';

    dataset
    {
        dataitem(GateEntryHeader; "E3 Posted Gate Entry Header")
        {

            RequestFilterFields = "Document No.", "Posting Date", "Gate Pass Type", "Entry Type";

            column(LocationCode; "To Destination")
            {
            }
            column(LocationAdd; LocationAdd)
            {
            }
            column(LocationAdd2; LocationAdd2)
            {
            }
            column(LocationPhoneNo; LocationPhoneNo)
            {
            }
            column(EntryTypeFilter; EntryType)
            {
            }
            column(Entry_Type; "Entry Type")
            {
            }

            column(DocumentNoFilter; DocumentNo)
            {
            }
            column(Document_No_; "Document No.")
            {
            }
            column(Status; Status)
            {

            }
            column(Posted_Entry_No_; "Posted Entry No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }

            column(From_Department_Code; "From Department Code")
            {
            }
            column(From_Department_Name; "From Department Name")
            {
            }
            column(ToDept; ToDept)
            { }
            column(FromDept; FromDept)
            { }

            column(To_Department_Name; "To Department Name")
            {
            }
            column(Vendor_Name; "Vendor Name")
            {
            }

            column(PurposeCode; "Purpose Code")
            {
            }

            column(Location_Code; "To Destination")
            {
            }
            column(LocationName; LocationName)
            {
            }
            column(SystemCreatedBy; userc."User Name")
            {
            }
            column(Vehicle_No_; "Vehicle No.")
            {
            }

            //Paty No.
            column(Party_No; "Vendor No.")
            {
            }
            column(Person; Person)
            {
            }
            column(BU; "Shortcut Dimension 1 Code")
            {
            }
            column(Expected_Return_Date; "Expected Return Date")
            {
            }
            column(Reference_Document_No_; "Reference Document No.")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(FromDate; FromDateFilter)
            {
            }

            column(ToDate; ToDateFilter)
            {
            }

            column(PrintedBy; userc."User Name")
            {
            }
            column(EntryType; "Entry Type")
            {
            }

            column(GatePassTypeFilter; GatePassType)
            {
            }
            column(GatePassType; GatePassType)
            {
            }
            column(FromDepartmentFilter; GateEntryHeader.GetFilter("From Department Name"))
            {
            }
            column(DestinationFilter; GateEntryHeader.GetFilter("To Destination"))
            {
            }
            column(ToDepartmentFilter; GateEntryHeader.GetFilter("To Department Name"))
            {
            }


            // trigger OnPreDataItem()
            // begin
            //     FromDateFilter := '';
            //     ToDateFilter := '';
            // end;


            dataitem(GateEntryLine; "E3 Posted Gate Entry Line")
            {
                DataItemLink = "Document No." = field("Document No.");

                column(Item_No_; "Item No.")
                {
                }
                column(ItemName; "Item Name")
                {
                }
                column(Variant_Code; "Variant Code")
                {
                }
                column(UnitOfMeasurement; "Unit of Measurement")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Quantity_Received; "Quantity Received")
                {
                }
                column(Estimated_Value_Receive; "Estimated Value Receive")
                {
                }
                column(EstimatedValue; "Estimated Value")
                {
                }

                column(AssetNo; "Asset No.")
                {
                }
                column(Fixed_Asset_Name; "Fixed Asset Name")
                {
                }
                column(Serial_No_; "Serial No.")
                {
                }
                column(LineRemarks; Remarks)
                {
                }


                trigger OnAfterGetRecord()
                begin

                    LocationAdd := '';
                    ToDestination := '';
                    LocationAdd2 := '';
                    LocationPhoneNo := '';
                    LocationName := '';



                    if GateEntryHeader."To Destination" <> '' then begin
                        Location.Reset();
                        Location.SetRange(Code, GateEntryHeader."To Destination");
                        if userc.Get(SystemCreatedBy) then;
                        //   if userc.Get(PrintedBy) then;

                        if Location.FindFirst() then begin
                            LocationAdd := Location.Address;
                            LocationAdd2 := Location."Address 2";
                            LocationPhoneNo := Location."Phone No.";
                            LocationName := Location.Name;

                        end;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                DocumentNo := GetFilter("Document No.");
                GatePassType := GetFilter("Gate Pass Type");
                EntryType := GetFilter("Entry Type");
                FromDateFilter := GetRangeMin("Posting Date");
                ToDateFilter := GetRangeMax("Posting Date");
                FromDept := "From Department Name";
                ToDept := "To Department Name";

            end;
        }
    }





    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {

                    // }
                }
            }
        }

        actions
        {
            // area(processing)
            // {
            //     action(LayoutName)
            //     {

            //     }
            // }
        }
    }
    var
        GateNo: Code[20];
        EmployeeCode: Code[30];
        PersonMode: Text[100];
        EstdDate: Date;
        PostingDate: Date;
        PurposeCode: Code[30];
        DepartmentCode: Code[40];
        ToDestination: Text[100];
        RemarksTxt: Text[250];
        Location: Record Location;
        LocationAdd: Text[200];
        LocationCode: Text[20];
        LocationAdd2: Text[100];
        LocationPhoneNo: Text[30];
        LocationName: Text[100];
        UserC: Record User;
        FromDateFilter: Date;
        ToDateFilter: Date;
        FromDept: Text[100];
        ToDept: Text[100];
        EntryType: Text[100];
        GatePassType: Text[250];
        DocumentNo: Text[100];

}