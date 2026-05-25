pageextension 50063 "Chart of Accounts Card" extends "G/L Account Card"
{
    layout
    {
        addafter(Totaling)
        {
            field(FIReportMapping; Rec.FIReportMapping)
            {
                ApplicationArea = All;
                Caption = 'KPIs Mapping';
                ToolTip = 'Specifies the value of the KPIs Mapping field.';
            }
            field("KPIs Name"; Rec."KPIs Name")
            {
                ApplicationArea = All;
                Caption = 'KPIs Mapping Name';
                ToolTip = 'Specifies the value of the KPIs Mapping Name field.';
            }
        }
        addafter(Name)
        {
            field("Name 2"; Rec."Name 2")
            {
                ApplicationArea = All;
                Caption = 'Name 2';
                ToolTip = 'Specifies the value of the Name 2 field.';
            }
        }
    }
}