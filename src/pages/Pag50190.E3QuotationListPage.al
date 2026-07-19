page 50190 "E3 Quotation List"
{
    CardPageID = "E3 Quotation Card";
    Editable = false;
    PageType = List;
    SourceTableView = sorting("Document No.") WHERE(Status = FILTER(Approved), "Release Indent" = FILTER(false));
    UsageCategory = Lists;
    ApplicationArea = All;
    Caption = 'Quotation Lists';
    SourceTable = "E3 Indent Header";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Indent No.';
                    ToolTip = 'Specifies the indent number of the Indent No.';
                }
                field("Requested By"; Rec."Requested To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the requested by of the Requested By.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the request date of the Request Date.';
                }
                field("Voucher Type Code"; Rec."Voucher Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the voucher type code of the Voucher Type Code.';
                }
                field("Voucher Type Name"; Rec."Voucher Type Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the voucher type name of the Voucher Type Name.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the Status.';
                }

                field("Expected Receive Date"; Rec."Expected Receive Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expected receive date of the Expected Receive Date.';
                }

                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approved by of the Approved By.';
                }
            }
        }
    }
}