report 50048 "E3 Gate In Print"
{

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Gate Inward Print';
    RDLCLayout = './src/reports/Rpt50048.GatePassIn.rdl';

    dataset
    {
        dataitem(GateEntryHeader; "E3 Posted Gate Entry Header")
        {
            RequestFilterFields = PostedNo;

            column(CompPicture; compInfo.Picture)
            {
            }
            column(GateNo; "Document No.")
            {
            }
            column(LocationCode; "To Destination")
            {
            }
            column(LocationName; LocationName)
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
            column(LocCity; LocCity)
            {
            }
            column(LocPostCode; LocPostCode)
            {
            }
            column(Entry_Type; "Entry Type")
            {
            }
            column(GatePassType; "Gate Pass Type")
            {
            }
            column(Vendor_Name; "Vendor Name")
            {
            }

            column(Vendor_No_; "Vendor No.")
            {
            }

            column(Person; Person)
            {
            }
            column(Vehicle_No_; "Vehicle No.")
            {
            }

            column(Posting_Date; "Posting Date")
            {
            }

            column(PurposeCode; "Purpose Code")
            {
            }

            column(FromDepartmentCode; "From Department Code")
            {
            }
            column(To_Department_Name; "To Department Name")
            {
            }
            column(From_Department_Name; "From Department Name")
            {
            }
            column(Reference_Document_No_; "Reference Document No.")
            {
            }
            column(Reference_Document_Date; "Reference Document Date")
            {
            }
            column(ToDestination; "To Destination")
            {
            }
            column(Expected_Return_Date; "Expected Return Date")
            {
            }

            column(Remarks; Remarks)
            {
            }
            column(SystemCreatedBy; userc."User Name")
            {
            }
            column(PrintedBy; userc."User Name")
            {
            }
            column(Procurement_Type; "Procurement Type")
            {
            }
            column(Outward_Document_No_; "Outward Document No.")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }

            dataitem(GateEntryLine; "E3 Posted Gate Entry Line")
            {
                DataItemLink = PostedNo = field(PostedNo);

                column(Line_No_; "Line No.")
                {

                }
                column(ItemName; "Item Name")
                {
                }

                column(Quantity_Received; "Quantity Received")
                {
                }

                column(UnitOfMeasurement; "Unit of Measurement")
                {
                }
                column(Estimated_Value_Receive; "Estimated Value Receive")
                {
                }
                column(AssetNo; "Asset No.")
                {
                }
                column(Fixed_Asset_Name; "Fixed Asset Name")
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
                            LocCity := Location.City;
                            LocPostCode := Location."Post Code";
                        end;

                    end;
                end;

            }


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
    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
    end;

    var
        GateNo: Code[20];
        GatePassType: Text[50];
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
        LocCity: Text[30];
        LocPostCode: Code[20];
        UserC: Record User;
        GateLine: Record "E3 Posted Gate Entry Line";
        CompInfo: Record "Company Information";


}