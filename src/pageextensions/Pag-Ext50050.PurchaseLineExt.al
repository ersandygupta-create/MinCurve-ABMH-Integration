pageextension 50050 "E3 HIS Purch. Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        modify("GST Group Code")
        {
            Editable = TRUE;
        }
        modify("No.")
        {
            Editable = IsLineEditable;
        }
        modify(Description)
        {
            Editable = false;
        }

        modify(Quantity)
        {
            Editable = IsLineEditable;
        }
        modify("Gen. Prod. Posting Group")
        {
            Editable = IsLineEditable;
        }
        modify("Location Code")
        {
            Editable = IsLineEditable;
        }
        modify("Unit of Measure Code")
        {
            Editable = IsLineEditable;
        }
        modify("Direct Unit Cost")
        {
            Editable = IsLineEditable;
        }
        modify("Line Amount")
        {
            Editable = IsLineEditable;
        }
        modify("Line Discount %")
        {
            Editable = IsLineEditable;
        }
        modify("Line Discount Amount")
        {
            Editable = IsLineEditable;
        }
        modify("GST Assessable Value")
        {
            Editable = IsLineEditable;
        }
        modify("Custom Duty Amount")
        {
            Editable = IsLineEditable;
        }
        modify("EDC Requested Quantity")
        {
            Editable = IsLineEditable;
        }
        modify("EDC Requested Unit of Measure")
        {
            Editable = IsLineEditable;
        }
        modify("EDC Indent No.")
        {
            Editable = IsLineEditable;
        }
        modify("EDC Indent Date")
        {
            Editable = IsLineEditable;
        }
        modify("EDC Indent Line No.")
        {
            Editable = IsLineEditable;
        }
        modify("EDC AMC Percentage")
        {
            Editable = IsLineEditable;
        }
        modify("EDC AMC Amount")
        {
            Editable = IsLineEditable;
        }
        modify("EDC CMC Percentage")
        {
            Editable = IsLineEditable;
        }
        modify("EDC CMC Amount")
        {
            Editable = IsLineEditable;
        }
        addafter("Expected Receipt Date")
        {
            field("Indent No."; Rec."Indent No.")
            {
                ApplicationArea = All;
                Caption = 'Indent No;';
                ToolTip = 'Specifies Indent No. for the line.';
            }
            field("Indent Line No."; Rec."Indent Line No.")
            {
                ApplicationArea = All;
                Caption = 'Indent Line No.';
                ToolTip = 'Specifies Indent Line No. for the line.';
            }
        }
    }
    var
        IsLineEditable: Boolean;
        UserSetup: Record "User Setup";

    trigger OnAfterGetCurrRecord()
    begin
        // Default: allow editing if Indent No. is blank
        if Rec."Indent No." = '' then begin
            IsLineEditable := true;
        end else begin
            IsLineEditable := false;
            if UserSetup.Get(UserId) then
                IsLineEditable := UserSetup."PO Line Modify";
        end;
    end;
}
//}
