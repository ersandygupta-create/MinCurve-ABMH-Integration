tableextension 50001 "E3 HIS Customer Ext" extends Customer
{
    fields
    {
        field(50000; "E3 HIS Code"; Code[20])
        {
            Caption = 'HIS Code';
            DataClassification = CustomerContent;
        }
        field(50002; "E3 HIS Type"; Enum "E3 HIS Type")
        {
            Caption = 'HIS Type';
            DataClassification = CustomerContent;
        }

        field(50050; "Opening Balance (LCY)"; Decimal)
        {
            Caption = 'Opening Balance (LCY)';
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                       "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                       "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                       "Currency Code" = field("Currency Filter"),
                       "Posting Date" = field("Opening Filter"),
                       "Entry Type" = filter(<> Application)));

            FieldClass = FlowField;
            Editable = false;
        }
        field(50051; "Closing Balance (LCY)"; Decimal)
        {
            Caption = 'Closing Balance (LCY)';
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                       "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                       "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                       "Currency Code" = field("Currency Filter"),
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
            Error('You cannot modify the Customer No.');
    end;

    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId()) then
            Error('User Setup is not configured for user %1.', UserId());

        if not UserSetup."Customer Insert" then
            Error(
                'You do not have permission to create a new Customer. ' +
                'Please contact your administrator.');
    end;

    trigger OnBeforeModify()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId()) then
            Error('User Setup is not configured for user %1.', UserId());

        if not UserSetup."Customer Modify" then
            Error(
                'You do not have permission to modify Customer %1. ' +
                'Please contact your administrator.',
                Rec."No.");
    end;

    trigger OnBeforeDelete()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId()) then
            Error('User Setup is not configured for user %1.', UserId());

        if not UserSetup."Customer Delete" then
            Error(
                'You do not have permission to delete Customer %1. ' +
                'Please contact your administrator.',
                Rec."No.");
    end;

}
