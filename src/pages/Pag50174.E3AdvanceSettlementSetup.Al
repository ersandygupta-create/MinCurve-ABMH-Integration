page 50174 "E3 Advance Settlement"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Advance Settlement Setup';
    SourceTable = E3AdvanceSetllementSetup;

    layout
    {
        area(Content)
        {

            repeater(GroupName)
            {
                field(VendorPostingGroup; Rec.VendorPostingGroup)
                {
                    ApplicationArea = All;
                }
                field(Enable; Rec.Enable)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


}