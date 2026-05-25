page 50173 "E3 Update Bank UTR No. API"
{

    APIGroup = 'apiHIS';
    APIPublisher = 'mindCurve';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = '3eBankUTRupdateAPI';
    DelayedInsert = true;
    EntityName = 'bankUTRUpdate';
    EntitySetName = 'bankUTRUpdate';
    PageType = API;
    SourceTable = "E3 Bank Integration";
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(entryNo; Rec.EntryNo)
                {
                    Caption = 'EntryNo';
                    Editable = false;
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(utrNo; Rec."UTR No.")
                {
                    Caption = 'UTR No.';
                }
                field(fld1; Rec.FLD1)
                {
                    Caption = 'FLD1';
                }
                field(fld2; Rec.FLD2)
                {
                    Caption = 'FLD2';
                }
                field(fld3; Rec.FLD3)
                {
                    Caption = 'FLD3';
                }
                field(fld4; Rec.FLD4)
                {
                    Caption = 'FLD4';
                }
                field(fld5; Rec.FLD5)
                {
                    Caption = 'FLD5';
                }
                field(fld6; Rec.FLD6)
                {
                    Caption = 'FLD6';
                }
                field(fld7; Rec.FLD7)
                {
                    Caption = 'FLD7';
                }
                field(fld8; Rec.FLD8)
                {
                    Caption = 'FLD8';
                }
                field(fld9; Rec.FLD9)
                {
                    Caption = 'FLD9';
                }
                field(fld10; Rec.FLD10)
                {
                    Caption = 'FLD10';
                }
                field(fld11; Rec.FLD11)
                {
                    Caption = 'FLD11';
                }
                field(fld12; Rec.FLD12)
                {
                    Caption = 'FLD12';
                }
                field(fld13; Rec.FLD13)
                {
                    Caption = 'FLD13';
                }
                field(fld14; Rec.FLD14)
                {
                    Caption = 'FLD14';
                }
                field(fld15; Rec.FLD15)
                {
                    Caption = 'FLD15';
                }
                field(fld16; Rec.FLD16)
                {
                    Caption = 'FLD16';
                }
                field(fld17; Rec.FLD17)
                {
                    Caption = 'FLD17';
                }
                field(fld18; Rec.FLD18)
                {
                    Caption = 'FLD18';
                }
                field(fld19; Rec.FLD19)
                {
                    Caption = 'FLD19';
                }
                field(fld20; Rec.FLD20)
                {
                    Caption = 'FLD20';
                }
            }
        }
    }
    trigger OnModifyRecord(): Boolean
    begin
        if Rec."UTR No." <> xRec."UTR No." then begin
            Message('UTR Number has been updated for document %1', Rec.EntryNo);
        end;
    end;
}
