report 50047 "E3 Gate OutWard Print"
{
    Caption = 'Gate Outward Print';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50047.GatePassOut.rdl';

    dataset
    {
        dataitem(GateEntryHeader; "E3 Posted Gate Entry Header")
        {
            RequestFilterFields = "Document No.";

            column(GateNo; "Document No.")
            {
            }
            column(CompPicture; compInfo.Picture)
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

            column(DepartmentName; "Department Code")
            {
            }
            column(To_Department_Name; "To Department Name")
            {
            }
            column(From_Department_Name; "From Department Name")
            {
            }
            column(Expected_Return_Date; "Expected Return Date")
            {
            }

            column(ToDestination; "To Destination")
            {
            }

            column(Remarks; Remarks)
            {
            }
            column(SystemCreatedBy; userc."Full Name")
            {
            }
            column(PrintedBy; userc."Full Name")
            {
            }
            column(PrintedDateTime; CurrentDateTime)
            {
            }
            dataitem(GateEntryLine; "E3 Posted Gate Entry Line")
            {
                DataItemLink = "Document No." = field("Document No.");
                column(ItemName; "Item Name")
                {

                }

                column(Quantity; Quantity)
                {
                }
                column(UnitOfMeasurement; "Unit of Measurement")
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
                        //if userc.Get(PrintedBy) then;

                        if Location.FindFirst() then begin
                            LocationAdd := Location.Address;
                            LocationAdd2 := Location."Address 2";
                            LocationPhoneNo := Location."Phone No.";
                            LocationName := Location.Name;

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
        UserC: Record User;
        compInfo: Record "Company Information";


}