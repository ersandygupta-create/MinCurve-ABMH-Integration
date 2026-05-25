report 50045 "Fixed Assets QR Code Print"
{
    ApplicationArea = All;
    Caption = 'QR Code';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50045.FAQRCodePrint.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(No_; "No.")
            {

            }
            column(Description; Description)
            {

            }
            column(FA_Location_Code; "FA Location Code")
            {

            }
            column(QR_Code; "QR Code")
            {

            }
            dataitem("FA Depreciation Book"; "FA Depreciation Book")
            {
                DataItemLink = "FA No." = field("No.");
                DataItemLinkReference = FixedAsset;
                column(Depreciation_Starting_Date; "Depreciation Starting Date")
                {

                }
            }
        }
    }
    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            // area(Content)
            // {
            //     group(GroupName)
            //     {
            //         field(Name; SourceExpression)
            //         {

            //         }
        }
        //}
        //}

        actions
        {
            // area(processing)
            // {
            //     action(LayoutName)
            //     {

            //     }
        }
    }
    // }


    var
        myInt: Integer;
}