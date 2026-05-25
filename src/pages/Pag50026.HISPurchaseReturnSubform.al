page 50026 "E3 HIS Purch. Return Subform"
{

    Caption = 'HIS Purchase Return Subform';
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "E3 HIS Purchase Line";

    SourceTableView = sorting("Entry No.") where("Record Type" = Filter("GRN Return"), "Document Type" = filter("Return Order"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Record Type"; Rec."Record Type")
                {
                    ToolTip = 'Specifies the value of the Record Type field';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = true;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = true;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the GRN No. field';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = true;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field';
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                    ApplicationArea = All;
                }
                field("Item Category"; rec."Item Category")
                {
                    ApplicationArea = All;
                }
                field("Item Category Name"; Rec."Item Category Name")
                {
                    Caption = 'Item Category Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Category Name field';
                }
                field("Item Sub Category"; rec."Item Sub Category")
                {
                    ApplicationArea = All;
                }
                field("Item Type"; Rec."Item Type")
                {
                    ToolTip = 'Specifies the value of the Item Type field';
                    ApplicationArea = All;
                    Caption = 'Account Type';
                    //Editable = false;
                }
                field("Purchase Account"; Rec."Purchase Account")
                {
                    ToolTip = 'Specifies the value of the Purchase Account field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item ID"; Rec."Item ID")
                {
                    ToolTip = 'Specifies the value of the Item ID field';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field';
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Item Name"; Rec."Item Name")
                {
                    ToolTip = 'Specifies the value of the Item Name field';
                    ApplicationArea = All;
                    //Editable = false;
                }
                field("Unit of Measurement"; rec."Unit of Measurement")
                {
                    ApplicationArea = All;
                    Caption = 'UOM';
                    ToolTip = 'Specify a value UOM field.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Unit Cost field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Received Qty"; Rec."Received Qty")
                {
                    ToolTip = 'Specifies the value of the Received Qty field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Free Qty"; Rec."Free Qty")
                {
                    ToolTip = 'Specifies the value of the Free Qty field';
                    ApplicationArea = All;
                    //Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Discount %"; rec."Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Discount % field';
                    Caption = 'Discount %';
                }
                field(Discount; Rec.Discount)
                {
                    ToolTip = 'Specifies the value of the Discount field';
                    ApplicationArea = All;
                    Caption = 'Discount Amount';
                    //Editable = false;
                }
                field("Other Charges"; Rec."Other Charges")
                {
                    ToolTip = 'Specifies the value of the Other Charges field';
                    ApplicationArea = All;
                    //Editable = false;
                }
                field("Gross Amount"; Rec."Gross Amount")
                {
                    ToolTip = 'Specifies the value of the Gross Amount field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ToolTip = 'Specifies the value of the GST Group Code field';
                    ApplicationArea = All;
                }
                field("HSN Code"; Rec."HSN Code")
                {
                    ToolTip = 'Specifies the value of the HSN Code field';
                    ApplicationArea = All;
                }
                field("Total Percentage"; Rec."Total Percentage")
                {
                    ToolTip = 'Specifies the value of the Total Percentage field';
                    ApplicationArea = All;
                    //Editable = false;
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field';
                    ApplicationArea = All;
                    //Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    ApplicationArea = All;
                    Visible = false;
                    //Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                    ApplicationArea = All;
                    //Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field';
                    ApplicationArea = All;
                    //Editable = false;
                }
                field("Fixed Assets No."; Rec."Fixed Assets No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Batch No"; rec."Batch No")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Manufacturer Name"; rec."Manufacturer Name")
                {
                    ApplicationArea = All;
                }
                field("Pack Size"; rec."Pack Size")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Record Type" := Rec."Record Type"::"GRN Return";
        Rec."Document Type" := Rec."Document Type"::"Return Order";
    end;

}
