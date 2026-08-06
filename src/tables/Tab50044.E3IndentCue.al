table 50044 "E3 Indent Cue"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
        }

        field(2; "Open Indents"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("E3 Indent Header" where(Status = const(Open)));
            Caption = 'Open Indents';
        }
        field(3; "Pending Approval"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("E3 Indent Header" where(Status = const("Pending Approval")));
            Caption = 'Pending Approval';
        }
        field(4; "Approved Indents"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("E3 Indent Header" where(Status = const(Approved)));
            Caption = 'Approved Indents';
        }
        field(5; "Rejected Indents"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("E3 Indent Header" where(Status = const(Rejected)));
            Caption = 'Rejected Indents';
        }
        field(6; "Purchase Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" where("Document Type" = const(Order)));
            Caption = 'Purchase Orders';
        }
        field(7; "Pending Purchase Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" where("Document Type" = const(Order), Status = const(Open)));
            Caption = 'Pending Purchase Orders';
        }
        field(8; "Approved Purchase Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" where("Document Type" = const(Order), Status = const(Released)));
            Caption = 'Approved Purchase Orders';
        }

    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}