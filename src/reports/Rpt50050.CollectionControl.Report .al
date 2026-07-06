report 50050 "Collection Control Register"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Collection Control Register';

    dataset
    {
        dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Quantity = FILTER(<> 0), "No." = FILTER(<> ''));

            trigger OnAfterGetRecord()
            begin
                MakeExcelDataBody
            end;

            trigger OnPreDataItem()
            begin
            end;
        }

    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("G/L Account No."; GL)
                {
                    ApplicationArea = All;
                    TableRelation = "E3 HIS GL Accounts Mapping"."Account No." WHERE("Collection Control Account" = CONST(true));
                }
                field("From Date"; StartDate)
                {
                    ApplicationArea = All;
                }
                field("To Date"; EndDate)
                {
                    ApplicationArea = All;
                }

            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            blnExportToExcel := true;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        if blnExportToExcel then
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        if (StartDate = 0D) and (EndDate = 0D) then
            Error('Please check Date Filter');

        if blnExportToExcel then
            MakeExcelInfo;
    end;

    var
        StartDate: Date;
        GL: Code[20];
        EndDate: Date;
        CompanyInformation: Record "Company Information";
        ExcelBuf: Record "Excel Buffer" temporary;
        blnExportToExcel: Boolean;


    procedure MakeExcelInfo()
    begin

        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow();
        excelbuf.NewRow();
        ExcelBuf.AddColumn('Sandeep', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);//Dimension1
        //excelbuf.mergecells();
    end;

    procedure MakeExcelDataBody()
    var
    begin
        ExcelBuf.NewRow;
        CompanyInformation.Get();
        ExcelBuf.AddColumn("Purch. Inv. Line"."Shortcut Dimension 1 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Dimension1
        ExcelBuf.AddColumn("Purch. Inv. Line"."Shortcut Dimension 2 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Dimension2
        ExcelBuf.AddColumn("Purch. Inv. Line"."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);//Document No
        ExcelBuf.AddColumn("Purch. Inv. Line"."Receipt No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
    end;




    procedure CreateExcelbook()
    var
        ExcelFileNameLbl: Label 'PurchaseTaxRegister%1_%2', Comment = '%1= DateTime, %2 = UserID';
    begin
        ExcelBuf.CreateNewBook('Collection Controll');
        ExcelBuf.WriteSheet('CollectionControl', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo(ExcelFileNameLbl, CurrentDateTime, UserId));
        ExcelBuf.OpenExcel();
    end;
}

