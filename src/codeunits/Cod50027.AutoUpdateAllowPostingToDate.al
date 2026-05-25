codeunit 50027 "E3 Auto Update Posting Dates"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        UpdatePostingDates();
    end;

    procedure UpdatePostingDates()
    var
        GLSetup: Record "General Ledger Setup";
        FASetup: Record "FA Setup";
        UserSetup: Record "User Setup";
        NewAllowPostingTo: Date;
    begin
        NewAllowPostingTo := Today;

        // 2. Update General Ledger Setup
        if GLSetup.Get() then begin
            GLSetup."Allow Posting To" := NewAllowPostingTo;
            GLSetup.Modify();
        end;

        // 3. Update FA Setup (Fixed Asset)
        if FASetup.Get() then begin
            FASetup."Allow FA Posting To" := NewAllowPostingTo;
            FASetup.Modify();
        end;

        // 4. Update User Setup (Optional: Update for specific users or all)
        if UserSetup.FindSet() then
            repeat
                UserSetup."Allow Posting To" := NewAllowPostingTo;
                UserSetup."Allow VAT Date To" := NewAllowPostingTo;
                UserSetup.Modify();
            until UserSetup.Next() = 0;
    end;
}
