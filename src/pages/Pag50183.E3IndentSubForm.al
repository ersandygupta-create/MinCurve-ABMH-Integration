page 50183 "E3 Indent Line Subform"
{
    PageType = ListPart;
    SourceTable = "E3 Indent Line";
    ApplicationArea = All;
    Caption = 'Indent Lines';
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = IsLineEditable;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = IsLineEditable;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = IsLineEditable;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Editable = IsLineEditable;
                }
                field("Critical Item"; Rec."Critical Item")
                {
                    ApplicationArea = All;
                    Editable = IsLineEditable;
                }
                field("Requested Qty"; Rec."Requested Qty")
                {
                    ApplicationArea = All;
                    Editable = IsLineEditable;
                }
                field("Approved Qty"; Rec."Approved Qty")
                {
                    ApplicationArea = All;
                    Editable = true;
                    visible = false;

                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    Editable = IsLineEditable;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = IsLineEditable;
                }
                field("AMC Start Date"; Rec."AMC Start Date")
                {
                    ToolTip = 'AMC/CMC Start Date';
                    ApplicationArea = All;
                    Editable = IsDateEdit;
                }
                field("AMC End Date"; Rec."AMC End Date")
                {
                    ToolTip = 'AMC/CMC End Date';
                    ApplicationArea = All;
                    Editable = IsDateEdit;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }

                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }

                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 3 that you set up in the General Ledger Setup window.';
                }
                field("Item Make Code"; Rec."Item Make Code")
                {
                    ApplicationArea = All;
                    //Editable = IsLineEditable;
                }
                field("Item Make Name"; Rec."Item Make Name")
                {
                    ApplicationArea = All;
                    //Editable = false;
                }
                field("Requested Received Date"; Rec."Requested Received Date")
                {
                    ApplicationArea = All;
                    Editable = IsLineEditable;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = IsLineEditable;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = IsLineEditable;
                    visible = false;
                }
            }
        }
    }
    var
        IsLineEditable: Boolean;
        IsApprovedQtyEditable: Boolean;
        IsDateEdit: Boolean;
        IndentHeader: Record "E3 Indent Header";

    trigger OnOpenPage()
    begin
        SetEditable();
    end;

    trigger OnAfterGetRecord()
    begin
        SetEditable();
    end;


    local procedure SetEditable()
    begin
        IsLineEditable := true;
        IsApprovedQtyEditable := false;
        IsDateEdit := false;

        if IndentHeader.Get(Rec."Document No.") then begin
            if IndentHeader."Indent Type" <> IndentHeader."Indent Type"::Opex then begin
                IsDateEdit := false;
                Rec."AMC Start Date" := 0D;
                rec."AMC End Date" := 0D;
            end else
                IsDateEdit := true;

            case IndentHeader.Status of
                IndentHeader.Status::Open:
                    begin
                        IsLineEditable := true;
                        IsApprovedQtyEditable := true;
                    end;

                IndentHeader.Status::"Pending Approval":
                    begin
                        IsLineEditable := false;
                        IsApprovedQtyEditable := true;
                    end;

                IndentHeader.Status::Approved:
                    begin
                        IsLineEditable := false;
                        IsApprovedQtyEditable := false;
                    end;
            end;
        end;
    end;

    procedure RefreshLines()
    begin
        SetEditable();
        CurrPage.Update(false);
    end;
}