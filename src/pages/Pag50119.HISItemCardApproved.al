page 50119 "E3 HIS Item Card Approved"
{

    Caption = 'HIS Item Card Approved';
    PageType = Card;
    SourceTable = "E3 HIS Master Staging";
    Editable = false;

    layout
    {
        area(content)
        {
            group(General)
            {

                field("Type"; Rec."Party Type")
                {
                    ToolTip = 'Specifies the value of the HIS Item Code field';
                    ApplicationArea = All;
                }
                // field("HIS Item Code"; Rec."HIS Code")
                // {
                //     ToolTip = 'Specifies the value of the HIS Item Code field';
                //     ApplicationArea = All;
                // }
                field("Item Name"; Rec."Name")
                {
                    ToolTip = 'Specifies the value of the Item Name field';
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Base Unit of Measure field';
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field';
                    ApplicationArea = All;
                }
                field("Item Status"; Rec."Item Status")
                {
                    ToolTip = 'Specifies the value of the Item Status field';
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field';
                    ApplicationArea = All;
                }
                field("Inventory-NonInventory"; Rec."Inventory-NonInventory")
                {
                    ToolTip = 'Specifies the value of the Item Type field';
                    ApplicationArea = All;
                    Caption = 'Item Type';
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ToolTip = 'Specifies the value of the Inventory Posting Group field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ToolTip = 'Specifies the value of the GST Group Code field';
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ToolTip = 'Specifies the value of the HSN/SAC Code field';
                    ApplicationArea = All;
                }
                field("GST Credit"; Rec."GST Credit")
                {
                    ApplicationArea = All;
                }
                field("Purchase Allowed"; Rec."Purchase Allowed")
                {
                    ToolTip = 'Specifies the value of the Purchase Allowed field';
                    ApplicationArea = All;
                }
                // field("Item Type"; Rec."Item Type")
                // {
                //     ApplicationArea = All;
                // }
                // field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                // {
                //     CaptionClass = '1,1,1';
                //     ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                //     ApplicationArea = All;
                // }
                // field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                // {
                //     CaptionClass = '1,1,2';
                //     ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                //     ApplicationArea = All;
                // }
                field("Error Description"; Rec."Error Description")
                {
                    ToolTip = 'Specifies the value of the Error Description field';
                    ApplicationArea = All;
                }
            }
            group("Log Details")
            {
                field("HIS Interface By"; Rec."HIS Interface By")
                {
                    ApplicationArea = All;
                    Editable = false;

                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("HIS Interface Date Time"; Rec."HIS Interface Date Time")
                {
                    ApplicationArea = All;
                    Editable = false;

                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Modified by"; Rec."Modified by")
                {
                    ApplicationArea = All;
                    Editable = false;

                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Modified Date Time"; Rec."Modified Date Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }

            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Approved Item")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Final Approval';
                //Image = Create;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    HISIntegration: Codeunit "E3 HIS Integration Mgmt.";
                begin

                    if Rec."Party Type" = Rec."Party Type"::Item then begin
                        HISIntegration.InitItemMaster(Rec."Entry No.");
                    end;
                end;
            }
            action("Rejected")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Rejected';
                //Image = Create;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    HISIntegration: Codeunit "E3 HIS Integration Mgmt.";
                begin

                    if Rec."Party Type" = Rec."Party Type"::Item then begin
                        HISIntegration.ItemRejectApproval2(Rec."Entry No.");
                    end;
                end;
            }
        }

    }
    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     rec."Party Type" := rec."Party Type"::Item;
    // end;

}
