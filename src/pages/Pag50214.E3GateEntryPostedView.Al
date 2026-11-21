page 50214 "E3 Posted Gate Entry Flat List"
{
    PageType = List;
    SourceTable = "E3 Gate Entry Line";
    Caption = 'Inward Gate Entry (Header & Lines)';
    UsageCategory = History;
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                // --- Header Fields (Pulled via Header record cache) ---

                field(GatePassType; HeaderRec."Gate Pass Type")
                {
                    ApplicationArea = all;
                    Caption = 'Gate Pass Type';
                    Editable = false;
                    ToolTip = 'Gate Pass Type';
                }
                field(EntryType; HeaderRec."Entry Type")
                {
                    ApplicationArea = all;
                    Caption = 'Entry Type';
                    Editable = false;
                    ToolTip = 'Entry Type';
                }
                field(ToDept; HeaderRec."To Department Name")
                {
                    ApplicationArea = all;
                    Caption = 'To Department';
                    Editable = false;
                    ToolTip = 'To Department';
                }
                field(ToDestination; HeaderRec."To Destination")
                {
                    ApplicationArea = all;
                    Caption = 'To Destination';
                    Editable = false;
                    ToolTip = 'To Destination';
                }
                field(ABMHUser; HeaderRec.Person)
                {
                    ApplicationArea = all;
                    Caption = 'ABMH User Name';
                    Editable = false;
                    ToolTip = 'ABMH User Name';
                }

                field(HeaderPostingDate; HeaderRec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date';
                    Editable = false;
                    ToolTip = 'Posting Date';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No.';
                    ToolTip = 'Document No.';
                    Editable = false;
                }
                field(HeaderDocumentNo; HeaderRec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Header Document No.';
                    ToolTip = 'Header Document No.';
                    Visible = false;
                }



                field(HeaderVendorNo; HeaderRec."Vendor No.")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor No.';
                    ToolTip = 'Vendor No.';
                    Editable = false;
                }
                field(HeaderVendorName; HeaderRec."Vendor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Name';
                    ToolTip = 'Vendor Name';
                    Editable = false;
                }
                field(HeaderVehicleNo; HeaderRec."Vehicle No.")
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle No.';
                    ToolTip = 'Vehicle No.';
                    Editable = false;
                }
                field(HeaderStatus; HeaderRec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    ToolTip = 'Status';
                    Editable = false;
                }

                // --- Line Fields ---
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Line No.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Item No.';
                }
                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Item Name';
                }
                field("Quantity"; Rec."Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantity';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = all;
                    ToolTip = 'Quantity Received.';
                }
                field("Unit of Measurement"; Rec."Unit of Measurement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unit of Measurement';
                }
                field("Estimated Value"; Rec."Estimated Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Estimated Value';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Caption = 'Line Remarks';
                    ToolTip = 'Line Remarks';
                }
                field(HeaderRemark; HeaderRec.Remarks)
                {
                    ApplicationArea = all;
                    Caption = 'Header Remark';
                    ToolTip = 'Header Remark';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        GetHeader();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        GetHeader();
    end;

    var
        HeaderRec: Record "E3 Gate Entry Header";
        DocumentNo: Code[20];

    local procedure GetHeader()
    begin
        if Rec."Document No." <> DocumentNo then begin
            HeaderRec.Reset();
            HeaderRec.SetRange("Document No.", Rec."Document No.");
            if not HeaderRec.Find('-') then
                HeaderRec.Init();
            DocumentNo := Rec."Document No.";
        end;
    end;
}