table 50047 "PO Selected Terms Condition"
{
    DataClassification = CustomerContent;
    Caption = 'PO Selected Terms & Conditions';

    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Term Code"; Code[20])
        {
            Caption = 'Term Code';
            TableRelation = "PO Terms Condition Master".Code where(Active = const(true));

            trigger OnValidate()
            var
                MasterTerm: Record "PO Terms Condition Master";
            begin
                if MasterTerm.Get(Rec."Term Code") then begin
                    Rec.Description := MasterTerm.Description;
                    Rec."Condition Text" := MasterTerm."Condition Text";
                end;
            end;
        }
        field(4; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(5; "Condition Text"; Text[2048])
        {
            Caption = 'Condition Text';
        }
        field(6; "Posted Invoice No."; Code[20])
        {
            Caption = 'Posted Invoice No.';
        }
    }

    keys
    {
        key(PK; "Document Type", "Document No.", "Term Code")
        {
            Clustered = true;
        }
        key(PostedKey; "Posted Invoice No.", "Term Code") { }
    }
}