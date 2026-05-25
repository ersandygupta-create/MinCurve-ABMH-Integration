tableextension 50022 "E3 Order Adress" extends "Order Address"
{
    fields
    {
        field(50010; "E3 NPU"; Boolean)
        {
            Caption = 'NPU';
            DataClassification = CustomerContent;
        }
        field(50015; "E3 Sync Record Exists"; Boolean)
        {
            Caption = 'Sync Record Exists';
            CalcFormula = exist("E3 API Supplier Update Log" where("No." = field("Vendor No."), "Address Code" = field(Code)));
            FieldClass = FlowField;
            Editable = false;
        }
    }

    // trigger OnBeforeRename()
    // begin
    //     CalcFields("E3 Sync Record Exists");
    //     if "E3 Sync Record Exists" then
    //         Error('Record synchronized to HIS, rename is not allowed');
    // end;
}
