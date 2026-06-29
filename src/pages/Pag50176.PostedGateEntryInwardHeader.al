page 50176 "E3 Posted Gate Ent Inward Hdr"
{
    Caption = 'Gate Entry Inward Header';
    PageType = Document;
    DelayedInsert = true;
    RefreshOnActivate = true;
    SourceTable = "E3 Posted Gate Entry Header";
    SourceTableView = sorting("Posted Entry No.") order(descending) where("Entry Type" = Filter(Inward));
    Editable = false;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Gate Pass Type"; Rec."Gate Pass Type")
                {
                    ToolTip = 'Specifies the value of the Gate Pass Type field';
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the value of the Entry Type field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field';
                    ApplicationArea = All;
                }
                field("Purpose Code"; Rec."Purpose Code")
                {
                    ToolTip = 'Specifies the value of the Purpose Code field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle No. field';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field';
                    ApplicationArea = All;
                }
                field("From Department Code"; Rec."From Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field';
                    ApplicationArea = All;
                    Caption = 'From Department Code';
                }
                field("From Department Name"; Rec."From Department Name")
                {
                    ToolTip = 'Specifies the value of the To Department Code field';
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field';
                    ApplicationArea = All;
                    Caption = 'To Department Code';
                }
                field("To Department Name"; Rec."To Department Name")
                {
                    ToolTip = 'Specifies the value of the To Department Code field';
                    ApplicationArea = All;
                }
                field("To Destination"; Rec."To Destination")
                {
                    ToolTip = 'Specifies the value of the To Destination field';
                    ApplicationArea = All;
                    Caption = 'Location Code';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                }
                field("Location Name"; Rec."Location Name")
                {
                    ToolTip = 'Specifies the value of the Location Name field';
                    ApplicationArea = All;
                    Caption = 'Location Name';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field';
                    ApplicationArea = All;
                    Caption = 'Party No.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field';
                    ApplicationArea = All;
                    Caption = 'Party Name';
                }
                field(Person; Rec.Person)
                {
                    ToolTip = 'Specifies the value of the Person field';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the GRN ID field';
                    ApplicationArea = All;
                }
                field("Expected Return Date"; Rec."Expected Return Date")
                {
                    ToolTip = 'Specifies the value of the Expected Return Date field';
                    ApplicationArea = All;
                }
                field("Reference Document No."; Rec."Reference Document No.")
                {
                    ToolTip = 'Specifies the value of the Reference Document No. field';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field';
                    ApplicationArea = All;
                }
            }
            part(HISPurchaseSubform; "E3 Posted Gate Ent Inward Line")
            {
                ApplicationArea = Basic, Suite;
                UpdatePropagation = Both;
                SubPageLink = PostedNo = FIELD(PostedNo);
                Caption = 'Gate Entry Inward Line';
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(GatePassInward)
            {
                ApplicationArea = All;
                Caption = 'Gate Pass Inward Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Print the Gate Pass Inward report.';

                trigger OnAction()
                var
                    GateEntryHeader: Record "E3 Posted Gate Entry Header";
                begin
                    GateEntryHeader.Reset();
                    GateEntryHeader.SetRange("Posted Entry No.", Rec."Posted Entry No.");
                    if GateEntryHeader.FindFirst() then
                        Report.RunModal(
                            Report::"E3 Gate In Print",
                            true,
                            true,
                            GateEntryHeader)
                    else
                        Error('No posted gate entry found.');
                end;
            }
        }
    }


}