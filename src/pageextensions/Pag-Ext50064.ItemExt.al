pageextension 50064 "Item Ext" extends "Item Card"
{
    layout
    {
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Rec.TestField("Base Unit of Measure");
        exit(true);
    end;

}