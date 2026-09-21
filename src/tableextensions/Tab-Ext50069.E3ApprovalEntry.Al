tableextension 50069 "E3 Approval Entry " extends "Approval Entry"
{
    fields
    {
        // Add changes to table fields here
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    trigger OnAfterModify()
    var
        IndentHeader: Record "E3 Indent Header";
    begin
        If "Table ID" = 50036 then begin
            IndentHeader.Reset();
            IndentHeader.SetRange("Document No.", Rec."Document No.");
            if IndentHeader.Find('-') then begin
                IndentHeader."Approved By" := "Approver ID";
                IndentHeader.Modify();
            end;
        end;
    end;
}