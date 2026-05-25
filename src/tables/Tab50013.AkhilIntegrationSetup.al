table 50013 "E3 Akhil Integration Setup"
{
    Caption = 'Akhil Integration Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Integration Enabled"; Boolean)
        {
            Caption = 'Integration Enabled';
            DataClassification = CustomerContent;
        }

        field(5; Username; Text[50])
        {
            Caption = 'Username';
            DataClassification = CustomerContent;
        }
        field(6; Password; Text[50])
        {
            Caption = 'Password';
            DataClassification = CustomerContent;
        }
        field(7; Host; Text[100])
        {
            Caption = 'Host';
            DataClassification = CustomerContent;
        }
        field(10; "Vendor Master API"; Text[100])
        {
            Caption = 'Vendor Master API';
            DataClassification = CustomerContent;
        }
        field(11; "Settlement API"; Text[100])
        {
            Caption = 'Settlement API';
            DataClassification = CustomerContent;
        }
        field(12; "TDS API"; Text[100])
        {
            Caption = 'TDS API';
            DataClassification = CustomerContent;
        }
        field(13; "Write-off API"; Text[100])
        {
            Caption = 'Write-off API';
            DataClassification = CustomerContent;
        }

        field(20; "Vendor Master API Enabled"; Boolean)
        {
            Caption = 'Vendor Master API';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                EnqueueJobEntry('FAILOVERSUPPLIER')
            end;
        }
        field(21; "Settlement API Enabled"; Boolean)
        {
            Caption = 'Settlement API';
            DataClassification = CustomerContent;

        }
        field(22; "TDS API Enabled"; Boolean)
        {
            Caption = 'TDS API';
            DataClassification = CustomerContent;
        }
        field(23; "Write-off API Enabled"; Boolean)
        {
            Caption = 'Write-off API';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    var
        E3AkhilIntMgmt: Codeunit "E3 Akhil Integration Mgmt.";


    procedure EnqueueJobEntry(ParamStr: Text[20]): Guid
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobDesLbl: Label '%1', Locked = true;
    begin
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", CODEUNIT::"E3 Akhil Integration Mgmt.");
        JobQueueEntry.SetRange("Parameter String", ParamStr);
        if JobQueueEntry.FindFirst() then
            exit;

        Clear(JobQueueEntry.ID);
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := CODEUNIT::"E3 Akhil Integration Mgmt.";
        JobQueueEntry."Parameter String" := ParamStr;
        JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime + 30000;
        JobQueueEntry."Notify On Success" := true;
        JobQueueEntry."Job Queue Category Code" := '';
        JobQueueEntry.Description := StrSubstNo(JobDesLbl, ParamStr);
        JobQueueEntry."Recurring Job" := true;
        JobQueueEntry."Run on Mondays" := true;
        JobQueueEntry."Run on Tuesdays" := true;
        JobQueueEntry."Run on Wednesdays" := true;
        JobQueueEntry."Run on Thursdays" := true;
        JobQueueEntry."Run on Fridays" := true;
        JobQueueEntry."Run on Saturdays" := true;
        JobQueueEntry."Run on Sundays" := true;
        JobQueueEntry."No. of Minutes between Runs" := 30;
        CODEUNIT.Run(CODEUNIT::"Job Queue - Enqueue", JobQueueEntry);
        exit(JobQueueEntry.ID)
    end;
}
