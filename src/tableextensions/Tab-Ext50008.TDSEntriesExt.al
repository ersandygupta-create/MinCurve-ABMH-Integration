tableextension 50008 "E3 HIS TDS Entries" extends "TDS Entry"
{
    fields
    {
        field(50000; "E3 Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = Lookup("Vendor".Name WHERE("No." = FIELD("Vendor No.")));
            Editable = false;
        }
    }
}
