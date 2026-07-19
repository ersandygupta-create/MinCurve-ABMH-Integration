tableextension 50068 "Detail Cust. Ledger Entry" extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        field(50000; "Reversed"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Max("Cust. Ledger Entry".Reversed WHERE("Entry No." = FIELD("Cust. Ledger Entry No.")));
            Editable = false;
        }
        field(50001; "Rev Document No."; Code[20])
        {
            Caption = 'Reversed Document No.';
            FieldClass = FlowField;
            CalcFormula = Max("Cust. Ledger Entry"."Document No." WHERE("Entry No." = FIELD("Cust. Ledger Entry No.")));
        }
        field(50002; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Cust. Ledger Entry"."External Document No." WHERE("Entry No." = FIELD("Cust. Ledger Entry No.")));
        }
    }
}