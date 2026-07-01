page 50167 "E3 Gate Entry Outward Header"
{
    Caption = 'Gate Entry Outward Header';
    PageType = Document;
    DelayedInsert = true;
    RefreshOnActivate = true;
    SourceTable = "E3 Gate Entry Header";
    SourceTableView = sorting("Entry No.") where("Entry Type" = Filter(Outward));


    layout
    {
        area(Content)
        {
            group(General)
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
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field';
                    ApplicationArea = All;
                    Editable = false;
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
                field("Reference Document Date"; Rec."Reference Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the reference document associated with this record.';
                }

                field("Procurement Type"; Rec."Procurement Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the procurement type, such as Capex or Opex, for this record.';
                }
            }
            part(HISPurchaseSubform; "E3 Gate Entry Outward Subform")
            {
                ApplicationArea = Basic, Suite;
                UpdatePropagation = Both;
                SubPageLink = "Document No." = FIELD("Document No.");
                Caption = 'Gate Entry Outward Line';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Ship)
            {
                Caption = 'Ship';
                Image = Shipment;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                var
                    GateTransfer: Codeunit "E3 Gate Entry Transfer";
                    Inward: Boolean;
                    PurchPaybleSetup: Record "Purchases & Payables Setup";
                begin
                    PurchPaybleSetup.Get();
                    //  PurchPaybleSetup.TestField("Posted Gate Entry Inward No.");
                    PurchPaybleSetup.TestField("Posted Gate Entry Outward No.");

                    Inward := true;
                    if Rec."Gate Pass Type" = Rec."Gate Pass Type"::"Non-Returnable" then begin
                        Message('Inward cannot be created for Gate Pass Type Non-Returnable.');
                        Inward := false;
                        GateTransfer.PostOutwardGateEntry(Rec, Inward);
                    end
                    else
                        GateTransfer.PostOutwardGateEntry(Rec, Inward);

                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        NoSeries: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        ResponsibiltyCenter: Record "Responsibility Center";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        If UserSetup.Find('-') then begin
            ResponsibiltyCenter.Reset();
            ResponsibiltyCenter.SetRange(Code, UserSetup."Purchase Resp. Ctr. Filter");
            if ResponsibiltyCenter.Find('-') then;
        end;
        Rec."Entry Type" := Rec."Entry Type"::Outward;
        PurchasesPayablesSetup.Get();
        PurchasesPayablesSetup.TestField("Gate Entry Nos.");

        Rec."No. Series" := PurchasesPayablesSetup."Gate Entry Nos.";
        Rec."Document No." := NoSeries.GetNextNo(Rec."No. Series", WorkDate(), true);
        Rec."Location Name" := ResponsibiltyCenter."Location Code";
        rec."Department Code" := ResponsibiltyCenter."Global Dimension 2 Code";
        Rec."Shortcut Dimension 1 Code" := ResponsibiltyCenter."Global Dimension 1 Code";
    end;

}