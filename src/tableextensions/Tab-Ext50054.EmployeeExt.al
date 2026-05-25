tableextension 50054 Employee_Ext extends Employee
{
    fields
    {
        field(50050; "Opening Balance (LCY)"; Decimal)
        {
            Caption = 'Opening Balance (LCY)';
            CalcFormula = sum("Detailed Employee Ledger Entry"."Amount (LCY)" where("Employee No." = field("No."),
                       "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                       "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                       "Posting Date" = field("Opening Filter"),
                       "Entry Type" = filter(<> Application)));

            FieldClass = FlowField;
            Editable = false;
        }
        field(50051; "Closing Balance (LCY)"; Decimal)
        {
            Caption = 'Closing Balance (LCY)';
            CalcFormula = sum("Detailed Employee Ledger Entry"."Amount (LCY)" where("Employee No." = field("No."),
                       "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                       "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                       "Posting Date" = field(UPPERLIMIT("Date Filter")),
                       "Entry Type" = filter(<> Application)));
            FieldClass = FlowField;
            Editable = false;
        }

        field(50052; "Opening Filter"; Date)
        {
            Caption = 'Opening Filter';
            FieldClass = FlowFilter;
        }

        field(50053; "Debit Amount (LCY)"; Decimal)
        {
            Caption = 'Debit Amount (LCY)';
            CalcFormula = sum("Detailed Employee Ledger Entry"."Amount (LCY)" where("Employee No." = field("No."),
                       "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                       "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                       "Posting Date" = field(UPPERLIMIT("Date Filter")),
                       "Amount (LCY)" = filter(> 0),
                       "Entry Type" = filter(<> Application)));
            FieldClass = FlowField;
            Editable = false;
        }
        field(50054; "Credit Amount (LCY)"; Decimal)
        {
            Caption = 'Credit Amount (LCY)';
            CalcFormula = - sum("Detailed Employee Ledger Entry"."Amount (LCY)" where("Employee No." = field("No."),
                       "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                       "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                       "Posting Date" = field(UPPERLIMIT("Date Filter")),
                       "Amount (LCY)" = filter(< 0),
                       "Entry Type" = filter(<> Application)));
            FieldClass = FlowField;
            Editable = false;
        }
        modify("Date Filter")
        {
            trigger OnAfterValidate()
            begin
                IF GETFILTER("Date Filter") <> '' THEN BEGIN
                    SETRANGE("Opening Filter", 0D, GETRANGEMIN("Date Filter") - 1);
                END;

            end;
        }
    }
    trigger OnBeforeRename()
    begin
        if (Rec."No." <> xRec."No.") and (xRec."No." <> '') then
            Error('You cannot modify the Employee No.');
    end;

}
