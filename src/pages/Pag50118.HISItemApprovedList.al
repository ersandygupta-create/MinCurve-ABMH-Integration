page 50118 "E3 HIS Item Approved List"
{

    ApplicationArea = All;
    Caption = 'HIS Item Approval Level2';
    PageType = List;
    Editable = false;
    CardPageId = 50119;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    SourceTableView = SORTING("HIS Code") WHERE("Item Status" = filter(Approved), IsCreated = filter(false), "Party Type" = FILTER(Item));

    SourceTable = "E3 HIS Master Staging";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type"; Rec."Party Type")
                {
                    ToolTip = 'Specifies the value of the HIS Item Code field';
                    ApplicationArea = All;
                }
                field("HIS Item Code"; Rec."HIS Code")
                {
                    ToolTip = 'Specifies the value of the HIS Item Code field';
                    ApplicationArea = All;
                }
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
                    ToolTip = 'Specifies the value of the Item Category Code field';
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field';
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ToolTip = 'Specifies the value of the Inventory Posting Group field';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                    ApplicationArea = All;
                }
                field("Inventory-NonInventory"; Rec."Inventory-NonInventory")
                {
                    ToolTip = 'Specifies the value of the Inventory-NonInventory Item field.';
                    ApplicationArea = All;
                }
                field(IsCreated; Rec.IsCreated)
                {
                    ToolTip = 'Specifies the value of the IsCreated Item field.';
                    ApplicationArea = All;
                }
                field("Error Description"; Rec."Error Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Error Description field';
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
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        CheckBln := USERID;
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", CheckBln);
        IF UserSetup.FIND('-') THEN BEGIN
            IF UserSetup."Item Approval2" <> TRUE THEN
                ERROR('Permission of Item Approval2 is not added in your access. If required, please contact to IT Administrator ');
        END;
    end;

    var
        CheckBln: Code[30];
        UserSetup: Record "User Setup";

}
