tableextension 50014 "E3 HIS Bank Ledger Entry" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50000; "EDC UTR No."; Code[35])
        {
            Caption = 'UTR No.';
            DataClassification = CustomerContent;
        }
        field(50017; "E3 Narration"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Narration';
        }
        field(50120; "E3 Line Narration"; Text[250])
        {
            Caption = 'Line Narration';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Narration".Narration where("Entry No." = field("Entry No."), "Transaction No." = field("Transaction No.")));
        }
        field(50121; "E3 Voucher Narration"; Text[250])
        {
            Caption = 'Voucher Narration';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Narration".Narration where("Entry No." = const(0), "Transaction No." = field("Transaction No.")));
        }
        field(50122; "E3 UTR No."; Code[35])
        {
            Caption = 'E3 UTR No.';
            DataClassification = CustomerContent;
        }
        field(50123; "Bank Integration"; Boolean)
        {
            Caption = 'Bank Integration';
            DataClassification = CustomerContent;
        }
        field(50124; "Recipient Bank IFSC Code"; Code[50])
        {
            Description = 'Recipient Bank IFSC Code';
            DataClassification = CustomerContent;
        }
        field(50125; "Recipient Bank Account"; Code[30])
        {
            Caption = 'Recipient Bank Account';
            DataClassification = ToBeClassified;
        }
        field(50126; "Bank Transaction Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Submitted,Successfull,Failed,Cancelled,File Exported';
            OptionMembers = " ",Submitted,Successfull,Failed,Cancelled,"File Exported";
        }
        field(50127; "Payment Exported"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Exported';
        }
        field(50128; "Recipient Branch Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Recipient Branch Name';
        }
        field(50129; "Recipient Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Recipient Bank Name';
        }
        field(50130; "Value Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Value Date';
        }

    }
    procedure E3SetBankReconciliationCandidatesFilter(BankAccReconciliation: Record "Bank Acc. Reconciliation")
    var
        FilterDate: Date;
    begin
        Rec.Reset();
        Rec.SetRange("Bank Account No.", BankAccReconciliation."Bank Account No.");
        Rec.SetRange("Statement Status", Rec."Statement Status"::Open);
        Rec.SetFilter("Remaining Amount", '<>%1', 0);
        rec.SetFilter("E3 UTR No.", '<>%1', '');
        Rec.SetRange("Reversed", false); // PR 30730


        FilterDate := BankAccReconciliation.MatchCandidateFilterDate();
        if FilterDate <> 0D then
            Rec.SetFilter("Posting Date", '<=%1', FilterDate);

        // Records sorted by posting date to optimize matching
        Rec.SetCurrentKey("Posting Date");
        Rec.SetAscending("Posting Date", true);

        E3OnAfterSetBankReconciliationCandidatesFilter(Rec);
    end;

    [IntegrationEvent(false, false)]
    local procedure E3OnAfterSetBankReconciliationCandidatesFilter(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    begin
    end;

}
