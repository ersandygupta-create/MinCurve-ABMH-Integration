page 50047 "Bank Balance"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    Caption = 'Bank Balance';
    SourceTable = "Bank Account";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending);


    layout
    {
        area(content)
        {
            group(Filters)
            {
                Caption = 'Filters';
                field("Global Dimension 1 Filter"; BranchFilter)
                {
                    Caption = 'Unit Filter';

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        Clear(DimValList);
                        Clear(DimVal);

                        GLSetup.Get();
                        DimVal.Reset;
                        DimVal.SetFilter("Dimension Code", GLSetup."Global Dimension 1 Code");
                        DimValList.LookupMode := true;
                        DimValList.SetTableView(DimVal);
                        if DimValList.RunModal = ACTION::LookupOK then
                            Text := DimValList.GetSelectionFilter
                        else
                            exit(false);

                        exit(true);

                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        SetRecFilters;
                    end;
                }
                field("Global Dimension 2 Filter"; BusinessHeadFilter)
                {
                    Caption = 'GD2 Filter';

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        Clear(DimValList);
                        Clear(DimVal);

                        GLSetup.Get();
                        DimVal.Reset;
                        DimVal.SetFilter("Dimension Code", GLSetup."Global Dimension 2 Code");
                        DimValList.LookupMode := true;
                        DimValList.SetTableView(DimVal);
                        if DimValList.RunModal = ACTION::LookupOK then
                            Text := DimValList.GetSelectionFilter
                        else
                            exit(false);

                        exit(true);

                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        SetRecFilters;
                    end;
                }
                field("Date Filter"; dateFilter)
                {
                    Caption = 'Date Filter';

                    trigger OnValidate()
                    begin
                        //if ApplicationMgt.MakeDateFilter(dateFilter) = 0 then;
                        StartingDateFilterOnAfterValid;
                    end;
                }
            }
            repeater(Group)
            {
                Editable = false;
                IndentationControls = Name;

                field("No."; Rec."No.")
                {
                    Editable = false;
                    Style = Strong;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    Style = Strong;
                }

                field("Opening Balance"; Rec."Opening Balance")
                {
                }
                field("Debit Amount"; Rec."Debit Amount (LCY)")
                {
                    Editable = false;
                }
                field("Credit Amount"; Rec."Credit Amount (LCY)")
                {
                    Editable = false;
                }
                field("Net Change"; Rec."Net Change")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Balance; Rec.Balance)
                {
                    Caption = 'Balance As on Date';
                }
                field("Balance at Date"; Rec."Balance at Date")
                {
                    Caption = 'Closing Balance';
                    Editable = false;
                }
            }
        }
    }



    trigger OnAfterGetRecord()
    begin

    end;

    trigger OnOpenPage()
    begin

        dateFilter := Format(Today);
        CurrPage.SaveRecord;
        SetRecFilters;


    end;

    var
        dateFilter: Text;
        DimValList: Page "Dimension Value List";
        BranchFilter: Code[20];
        BusinessHeadFilter: Code[20];
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";

    procedure StartingDateFilterOnAfterValid()
    begin
        CurrPage.SaveRecord;
        SetRecFilters;
    end;


    procedure LocFilterOnAfterValidate()
    begin
        CurrPage.SaveRecord;
        SetRecFilters;
    end;


    procedure SetRecFilters()
    begin
        if BranchFilter <> '' then begin
            Rec.SetFilter("Global Dimension 1 Filter", BranchFilter);
        end else
            Rec.SetRange("Global Dimension 1 Filter");

        if BusinessHeadFilter <> '' then begin
            Rec.SetFilter("Global Dimension 2 Filter", BusinessHeadFilter);
        end else
            Rec.SetRange("Global Dimension 2 Filter");

        if dateFilter <> '' then begin
            Rec.SetFilter("Date Filter", dateFilter);
            Rec.SetRange("Opening Filter", 0D, Rec.GetRangeMin("Date Filter") - 1);
        end else begin
            Rec.SetRange("Date Filter");
            Rec.SetRange("Opening Filter");
        end;

        CurrPage.Update(false);
    end;


}

