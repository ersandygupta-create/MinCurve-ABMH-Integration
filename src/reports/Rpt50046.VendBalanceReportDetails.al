report 50046 "Vendor Balance Details"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Vendor Balance';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50046.VendorBalanceReportDetails.rdl';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.", "Date Filter";

            column(Vendor_No; "No.") { }
            column(Vendor_Name; Name) { }

            // Header filters
            column(Filter_Vendor; GetFilter("No.")) { }
            column(Filter_Date; GetFilter("Date Filter")) { }
            column(Filter_PostingGroup; VendorPostingGroupFilter) { }

            dataitem(Buffer; "Vend PG Summary Buffer")
            {
                UseTemporary = true;

                DataItemLinkReference = Vendor;
                DataItemLink = "Vendor No." = field("No.");

                column(Vendor_Posting_Group; "Vendor Posting Group") { }
                column(Posting_Group_Name; "Posting Group Name") { }

                column(Opening_Balance; "Opening Balance") { }
                column(Debit_Amount; "Debit Amount") { }
                column(Credit_Amount; "Credit Amount") { }
                column(Closing_Balance; "Closing Balance") { }
                column(Balance_As_On_Date; "Balance As On Date") { }
            }

            trigger OnAfterGetRecord()
            begin
                Buffer.Reset();
                Buffer.DeleteAll();

                BuildVendorBalanceFinal();

                if Buffer.IsEmpty() then
                    CurrReport.Skip();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(VendorPostingGroupFilter; VendorPostingGroupFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor Posting Group';
                        TableRelation = "Vendor Posting Group";
                        ToolTip = 'Use | for multi-select (DOMESTIC|RETENTION)';
                    }
                }
            }
        }
    }

    var
        VendorPostingGroupFilter: Text;

    // =====================================================
    // 🔹 FINAL LOGIC IMPLEMENTATION
    // =====================================================
    local procedure BuildVendorBalanceFinal()
    var
        VLE: Record "Vendor Ledger Entry";
        ReportDate: Date;
        SystemDate: Date;
    begin
        ReportDate := Vendor.GetRangeMax("Date Filter");
        SystemDate := WorkDate();

        // ===============================
        // 🔹 OPENING BALANCE (< Report Date)
        // ===============================
        VLE.Reset();
        VLE.SetRange("Vendor No.", Vendor."No.");
        VLE.SetFilter("Posting Date", '<%1', ReportDate);

        if VendorPostingGroupFilter <> '' then
            VLE.SetFilter("Vendor Posting Group", VendorPostingGroupFilter);

        if VLE.FindSet() then
            repeat
                VLE.CalcFields("Debit Amount (LCY)", "Credit Amount (LCY)");
                InitBuffer(VLE);

                Buffer."Opening Balance" +=
                    VLE."Debit Amount (LCY)" - VLE."Credit Amount (LCY)";
                Buffer.Modify();
            until VLE.Next() = 0;

        // ===============================
        // 🔹 DEBIT / CREDIT (ON Report Date)
        // ===============================
        VLE.Reset();
        VLE.SetRange("Vendor No.", Vendor."No.");
        VLE.SetRange("Posting Date", ReportDate);

        if VendorPostingGroupFilter <> '' then
            VLE.SetFilter("Vendor Posting Group", VendorPostingGroupFilter);

        if VLE.FindSet() then
            repeat
                VLE.CalcFields("Debit Amount (LCY)", "Credit Amount (LCY)");
                InitBuffer(VLE);

                Buffer."Debit Amount" += VLE."Debit Amount (LCY)";
                Buffer."Credit Amount" += VLE."Credit Amount (LCY)";
                Buffer.Modify();
            until VLE.Next() = 0;

        // ===============================
        // 🔹 CLOSING BALANCE (Till Report Date)
        // ===============================
        Buffer.Reset();
        if Buffer.FindSet() then
            repeat
                Buffer."Closing Balance" :=
                    Buffer."Opening Balance" +
                    Buffer."Debit Amount" -
                    Buffer."Credit Amount";

                Buffer.Modify();
            until Buffer.Next() = 0;

        // ===============================
        // 🔹 BALANCE AS ON DATE (Till System Date)
        // ===============================
        VLE.Reset();
        VLE.SetRange("Vendor No.", Vendor."No.");
        VLE.SetFilter("Posting Date", '<=%1', SystemDate);

        if VendorPostingGroupFilter <> '' then
            VLE.SetFilter("Vendor Posting Group", VendorPostingGroupFilter);

        if VLE.FindSet() then
            repeat
                VLE.CalcFields("Debit Amount (LCY)", "Credit Amount (LCY)");
                InitBuffer(VLE);

                Buffer."Balance As On Date" +=
                    VLE."Debit Amount (LCY)" - VLE."Credit Amount (LCY)";
                Buffer.Modify();
            until VLE.Next() = 0;
    end;

    local procedure InitBuffer(VLE: Record "Vendor Ledger Entry")
    var
        VendPG: Record "Vendor Posting Group";
    begin
        if not Buffer.Get(Vendor."No.", VLE."Vendor Posting Group") then begin
            Buffer.Init();
            Buffer."Vendor No." := Vendor."No.";
            Buffer."Vendor Posting Group" := VLE."Vendor Posting Group";

            if VendPG.Get(VLE."Vendor Posting Group") then
                Buffer."Posting Group Name" := VendPG.Description;

            Buffer.Insert();
        end;
    end;
}