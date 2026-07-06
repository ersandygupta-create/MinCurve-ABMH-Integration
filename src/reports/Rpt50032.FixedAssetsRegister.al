report 50032 "EDC Fixed Assets Register"
{
    ApplicationArea = All;
    Caption = 'FAR';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50032.FixedAssetRegister.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(FA; "Fixed Asset")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "FA Posting Group", "Global Dimension 1 Code";

            // ================= BASIC =================
            column(AssetNo; "No.") { }
            column(AssetName; Description) { }
            column(FAPostingGroup; "FA Posting Group") { }
            column(FALocation; "FA Location Code") { }
            column(SerialNo; "Serial No.") { }
            column(ModelNo; "Model No.") { }
            column(Old_Asset_Code; "Old Asset Code")
            { }
            column(Nature_Of_Asset; Format("Nature Of Asset"))
            { }
            column(Remark; Remark) { }
            column(Qty; Qty) { }
            column(Sub_Asset_Group_Name; "Sub Asset Group Name") { }

            column(UnitCode; "Global Dimension 1 Code") { }
            column(UnitName; UnitName) { }

            // ================= DATES =================
            column(AcquisitionDate; AcquisitionDate) { }
            column(PutToUseDate; PutToUseDate) { }
            column(DisposalDate; DisposalDate) { }

            // ================= DEPRECIATION =================
            column(DepMethod; DepreciationMethod) { }
            column(ServiceLife; ServiceLife) { }
            column(DepPercent; DepPercent) { }
            column(DepPeriodRemaining; DepPeriodRemaining) { }

            // ================= VENDOR (INVOICE) =================
            column(VendorNo; VendorNo) { }
            column(VendorName; VendorName) { }
            column(VendorInvNo; VendorInvNo) { }
            column(VendorInvDate; VendorInvDate) { }
            column(DeptName; DeptName) { }

            // ================= PRIMARY VENDOR (FA MASTER) =================
            column(PrimaryVendorNo; PrimaryVendorNo) { }
            column(PrimaryVendorName; PrimaryVendorName) { }

            // ================= GROSS BLOCK =================
            column(OpenCost; OpenCost) { }
            column(AddCost; AddCost) { }
            column(DispCost; DispCost) { }
            column(CloseCost; CloseCost) { }

            // ================= ACC DEP =================
            column(OpenDep; OpenDep) { }
            column(AddDep; AddDep) { }
            column(DepDisp; DepDisp) { }
            column(CloseDep; CloseDep) { }

            // ================= NBV =================
            column(OpenNBV; OpenNBV) { }
            column(CloseNBV; CloseNBV) { }

            // ================= FILTER HEADER =================
            column(FAFilterTxt; FAFilterTxt) { }
            column(UnitFilterTxt; UnitFilterTxt) { }
            column(FAPostingGroupFilterTxt; FAPostingGroupFilterTxt) { }
            column(DateFilterTxt; DateFilterTxt) { }

            trigger OnPreDataItem()
            begin
                FAFilterTxt := FA.GetFilter("No.");
                UnitFilterTxt := FA.GetFilter("Global Dimension 1 Code");
                FAPostingGroupFilterTxt := FA.GetFilter("FA Posting Group");
                DateFilterTxt := Format(FromDate) + ' .. ' + Format(ToDate);
            end;

            trigger OnAfterGetRecord()
            begin
                GetAcquisitionEntry();
                GetDepBook();
                CalcDepPeriodRemaining();
                GetVendorDetails();      // Invoice Vendor
                GetPrimaryVendor();     // FA Master Vendor
                GetUnitName();
                CalcAmounts();
                GetDeptName("No.");
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field(FromDate; FromDate) { ApplicationArea = All; }
                    field(ToDate; ToDate) { ApplicationArea = All; }
                }
            }
        }
    }

    // ================= VARIABLES =================
    var
        FALedg: Record "FA Ledger Entry";
        FADepBook: Record "FA Depreciation Book";
        VendLedg: Record "Vendor Ledger Entry";
        VendorRec: Record Vendor;
        DimValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";

        FromDate, ToDate : Date;

        AcquisitionDate: Date;
        PutToUseDate: Date;
        DisposalDate: Date;
        AcqDocNo: Code[20];

        VendorNo: Code[20];
        VendorName: Text[100];
        VendorInvNo: Code[35];
        VendorInvDate: Date;

        PrimaryVendorNo: Code[20];
        PrimaryVendorName: Text[100];

        DepreciationMethod: Text[50];
        ServiceLife: Decimal;
        DepPercent: Decimal;
        DepPeriodRemaining: Decimal;

        UnitName: Text[100];
        DeptName: Text[100];

        OpenCost, AddCost, DispCost, CloseCost : Decimal;
        OpenDep, AddDep, DepDisp, CloseDep : Decimal;
        OpenNBV, CloseNBV : Decimal;

        FAFilterTxt: Text[250];
        UnitFilterTxt: Text[250];
        FAPostingGroupFilterTxt: Text[250];
        DateFilterTxt: Text[250];

    // ================= ACQUISITION =================
    local procedure GetAcquisitionEntry()
    begin
        Clear(AcquisitionDate);
        Clear(AcqDocNo);

        FALedg.Reset();
        FALedg.SetRange("FA No.", FA."No.");
        FALedg.SetRange("FA Posting Type", FALedg."FA Posting Type"::"Acquisition Cost");
        FALedg.SetCurrentKey("Posting Date");

        if FALedg.FindFirst() then begin
            AcquisitionDate := FALedg."Posting Date";
            AcqDocNo := FALedg."Document No.";
        end;
    end;

    // ================= DEP BOOK =================
    local procedure GetDepBook()
    begin
        Clear(DepreciationMethod);
        Clear(ServiceLife);
        Clear(PutToUseDate);
        Clear(DisposalDate);
        Clear(DepPercent);

        FADepBook.Reset();
        FADepBook.SetRange("FA No.", FA."No.");
        if FADepBook.FindFirst() then begin
            DepreciationMethod := Format(FADepBook."Depreciation Method");
            ServiceLife := FADepBook."No. of Depreciation Years";
            PutToUseDate := FADepBook."Depreciation Starting Date";
            DisposalDate := FADepBook."Disposal Date";

            if ServiceLife <> 0 then
                DepPercent := (1 / ServiceLife) * 100;
        end;
    end;

    // ================= DEP PERIOD REMAINING =================
    local procedure CalcDepPeriodRemaining()
    var
        YearsUsed: Decimal;
    begin
        DepPeriodRemaining := 0;

        if (PutToUseDate = 0D) or (ServiceLife = 0) then
            exit;

        YearsUsed := (ToDate - PutToUseDate) / 365;
        DepPeriodRemaining := ServiceLife - Round(YearsUsed, 0.01, '=');

        if DepPeriodRemaining < 0 then
            DepPeriodRemaining := 0;
    end;

    // ================= AMOUNTS (EXCEL LOGIC SAME) =================
    local procedure CalcAmounts()
    var
        MinDate: Date;
    begin
        ClearAmounts();
        MinDate := DMY2DATE(1, 1, 1900);

        OpenCost := CalcLedger(MinDate, FromDate - 1, FALedg."FA Posting Type"::"Acquisition Cost", false);
        AddCost := CalcLedger(FromDate, ToDate, FALedg."FA Posting Type"::"Acquisition Cost", false);

        DispCost :=
            CalcLedger(FromDate, ToDate, FALedg."FA Posting Type"::"Acquisition Cost", true) +
            CalcLedger(FromDate, ToDate, FALedg."FA Posting Type"::"Write-Down", false);

        CloseCost := OpenCost + AddCost - DispCost;

        OpenDep := CalcLedger(MinDate, FromDate - 1, FALedg."FA Posting Type"::Depreciation, false);
        AddDep := CalcLedger(FromDate, ToDate, FALedg."FA Posting Type"::Depreciation, false);
        DepDisp := CalcLedger(FromDate, ToDate, FALedg."FA Posting Type"::Depreciation, true);

        CloseDep := OpenDep + AddDep - DepDisp;

        OpenNBV := OpenCost - OpenDep;
        CloseNBV := CloseCost - CloseDep;
    end;

    // ================= LEDGER CORE =================
    local procedure CalcLedger(FromDt: Date; ToDt: Date; PostingType: Option; IsDisposal: Boolean): Decimal
    var
        Amt: Decimal;
    begin
        FALedg.Reset();
        FALedg.SetRange("FA No.", FA."No.");
        FALedg.SetRange("Posting Date", FromDt, ToDt);
        FALedg.SetRange("FA Posting Type", PostingType);

        if IsDisposal then
            FALedg.SetRange("FA Posting Category", FALedg."FA Posting Category"::Disposal)
        else
            FALedg.SetRange("FA Posting Category", FALedg."FA Posting Category"::" ");

        if FALedg.FindSet() then
            repeat
                Amt += Abs(FALedg.Amount);
            until FALedg.Next() = 0;

        exit(Amt);
    end;

    // ================= INVOICE VENDOR =================
    local procedure GetVendorDetails()
    begin
        Clear(VendorNo);
        Clear(VendorName);
        Clear(VendorInvNo);
        Clear(VendorInvDate);

        if AcqDocNo = '' then
            exit;

        VendLedg.SetRange("Document No.", AcqDocNo);
        VendLedg.SetRange("Document Type", VendLedg."Document Type"::Invoice);

        if VendLedg.FindFirst() then begin
            VendorNo := VendLedg."Vendor No.";
            VendorName := VendLedg."Vendor Name";
            VendorInvNo := VendLedg."External Document No.";
            VendorInvDate := VendLedg."Document Date";
        end;
    end;

    // ================= PRIMARY VENDOR (FA MASTER) =================
    local procedure GetPrimaryVendor()
    begin
        Clear(PrimaryVendorNo);
        Clear(PrimaryVendorName);

        if FA."Vendor No." = '' then
            exit;

        PrimaryVendorNo := FA."Vendor No.";

        if VendorRec.Get(PrimaryVendorNo) then
            PrimaryVendorName := VendorRec.Name;
    end;

    // ================= UNIT =================
    local procedure GetUnitName()
    begin
        Clear(UnitName);
        GLSetup.Get();

        DimValue.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
        DimValue.SetRange(Code, FA."Global Dimension 1 Code");

        if DimValue.FindFirst() then
            UnitName := DimValue.Name;
    end;

    local procedure GetDeptName(var FANumber: Code[20])
    var
        DefaultDimension: Record "Default Dimension";
        DimensionValue: Record "Dimension Value";
    begin
        Clear(DeptName);
        DefaultDimension.Reset();
        DefaultDimension.SetRange("No.", FANumber);
        DefaultDimension.SetFilter("Dimension Code", '%1', 'DEPT');
        IF DefaultDimension.Find('-') then begin
            DimensionValue.Reset();
            DimensionValue.SetRange(Code, DefaultDimension."Dimension Value Code");
            if DimensionValue.find('-') then
                DeptName := DimensionValue.Name;
        end;

    end;

    local procedure ClearAmounts()
    begin
        Clear(OpenCost);
        Clear(AddCost);
        Clear(DispCost);
        Clear(CloseCost);
        Clear(OpenDep);
        Clear(AddDep);
        Clear(DepDisp);
        Clear(CloseDep);
        Clear(OpenNBV);
        Clear(CloseNBV);
    end;
}