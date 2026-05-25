codeunit 50020 "E3 LIMS Integration Mgmt."
{
    trigger OnRun()
    begin

    end;

    procedure CollectionValidation()
    var
        temRevenueStaging: Record "E3 HIS Collection Staging";
        GLAccountMapping: Record "E3 HIS GL Accounts Mapping";
        MOPSetupMissing: Text[70];
        DocumentType: Text[70];
    begin
        temRevenueStaging.Reset();
        temRevenueStaging.SetRange("General Entries Created", false);
        if temRevenueStaging.FindSet() then
            repeat
                temRevenueStaging."Error Description" := '';
                MOPSetupMissing := '';
                DocumentType := '';
                GLAccountMapping.Reset();
                GLAccountMapping.SetRange(Type, GLAccountMapping.Type::"LIMS MOP");
                GLAccountMapping.SetRange("MOP Code", temRevenueStaging."Mode of Payment");
                if not GLAccountMapping.FindFirst() then
                    MOPSetupMissing := Text.StrSubstNo('MOP %1 setup missing', temRevenueStaging."Mode of Payment");
                if temRevenueStaging."Mode of Payment" = '' then
                    MOPSetupMissing := 'MOP can not be blank';
                GLAccountMapping.Reset();
                GLAccountMapping.SetRange(Type, GLAccountMapping.Type::"LIMS Collection");
                GLAccountMapping.SetRange("Service/Station Head", temRevenueStaging."HIS Document Type");
                if not GLAccountMapping.FindFirst() then
                    DocumentType := text.StrSubstNo('Collection Type %1 setup missing', temRevenueStaging."HIS Document Type");
                if temRevenueStaging."HIS Document Type" = '' then
                    DocumentType := 'Coll type can not be blank';
                temRevenueStaging."Error Description" := MOPSetupMissing + ' ' + DocumentType;
                temRevenueStaging.Modify(true);
            until temRevenueStaging.Next() = 0;
    end;

    procedure InitGenJnlLineCollectionStaging()
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLineRec: Record "Gen. Journal Line";
        HISGLAccountMapping: Record "E3 HIS GL Accounts Mapping";
        intLineNo: Integer;
        MOPLbl: Label 'MOP Setup not found for Mode of payment %1.';
        DocumentTypeLbl: Label 'Setup not found for Document Type %1.';
    begin
        IntegrationSetup.GET();
        IntegrationSetup.TESTFIELD("Integration Enabled", TRUE);
        IntegrationSetup.TESTFIELD("Revenue Creation Enabled", TRUE);
        IntegrationSetup.TESTFIELD("Vendor Gen. Bus. Posting Group");
        IntegrationSetup.TESTFIELD("Custom Gen. Bus. Posting Group");

        IntegrationSetupLine.Reset();
        IntegrationSetupLine.SetRange(Type, IntegrationSetupLine.Type::Collection);
        IntegrationSetupLine.FindFirst();
        IntegrationSetupLine.TestField("General Journal Template Code");
        IntegrationSetupLine.TestField("General Journal Batch Code");

        IF NOT (IntegrationSetup."Integration Enabled") AND (IntegrationSetup."Revenue Creation Enabled") THEN
            EXIT;

        //CollectionValidation();

        HISCollectionStaging.RESET();
        HISCollectionStaging.SETFILTER(HISCollectionStaging."General Entries Created", '%1', FALSE);
        HISCollectionStaging.SETFILTER(HISCollectionStaging.Amount, '<>%1', 0);//
        //HISRevenueStaging.SETFILTER(HISRevenueStaging."Account No.", '<>%1', '');
        IF HISCollectionStaging.FINDSET() THEN
            REPEAT
                GenJournalLine.RESET();
                GenJournalLine.SETRANGE("Journal Template Name", IntegrationSetupLine."General Journal Template Code");
                GenJournalLine.SETRANGE("Journal Batch Name", IntegrationSetupLine."General Journal Batch Code");
                IF GenJournalLine.FINDLAST() THEN
                    intLineNo := GenJournalLine."Line No."
                ELSE
                    intLineNo := 10000;

                GenJournalLine.INIT();
                GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name", IntegrationSetupLine."General Journal Template Code");
                GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name", IntegrationSetupLine."General Journal Batch Code");
                intLineNo += 10000;
                GenJournalLine."Line No." := intLineNo;
                GenJournalLine.VALIDATE("Document Type", HISCollectionStaging."Document Type");
                GenJournalLine.VALIDATE("Document No.", HISCollectionStaging."Document No.");
                GenJournalLine.VALIDATE("Posting Date", HISCollectionStaging."Document Date");

                HISGLAccountMapping.Reset();
                HISGLAccountMapping.SetRange(Type, HISGLAccountMapping.Type::"LIMS MOP");
                HISGLAccountMapping.SetRange("MOP Code", HISCollectionStaging."Mode of Payment");
                if HISGLAccountMapping.FindFirst() then begin

                    GenJournalLine.VALIDATE("Account Type", HISGLAccountMapping."Account Type");
                    GenJournalLine.VALIDATE("Account No.", HISGLAccountMapping."Account No.");
                end ELSE
                    Error(MOPLbl, HISCollectionStaging."Mode of Payment");

                GenJournalLine.VALIDATE(Amount, HISCollectionStaging.Amount);
                GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
                GenJournalLine.VALIDATE("Cheque Date", HISCollectionStaging."Cheque Date");
                GenJournalLine.VALIDATE("Cheque No.", COPYSTR(HISCollectionStaging."Cheque No.", 1, 10));
                if HISCollectionStaging."Shortcut Dimension 1 Code" <> '' then begin
                    GenJournalLine.VALIDATE("Location Code", HISCollectionStaging."Shortcut Dimension 1 Code");
                    GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", HISCollectionStaging."Shortcut Dimension 1 Code");
                end;

                if HISCollectionStaging."Shortcut Dimension 1 Code" <> '' then
                    GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", GetMappedDimension(HISCollectionStaging."Shortcut Dimension 2 Code"));

                GenJournalLine.VALIDATE("External Document No.", HISCollectionStaging."External Document No.");
                GenJournalLine."E3 Narration" := COPYSTR(HISCollectionStaging."Line Narration", 1, 50);
                GenJournalLine."E3 HIS Module" := HISCollectionStaging."HIS Module";
                GenJournalLine."E3 HIS Document Type" := COPYSTR(HISCollectionStaging."HIS Document Type", 1, 60);
                GenJournalLine."E3 UTR No." := HISCollectionStaging."Cheque No.";
                GenJournalLine."E3 Sub Group Code" := HISCollectionStaging."Sub Group";
                GenJournalLine."E3 Receipt No." := COPYSTR(HISCollectionStaging."Receipt No.", 1, 20);
                GenJournalLine."E3 UHID" := HISCollectionStaging.UHID;
                GenJournalLine."E3 Validation Key" := HISCollectionStaging."Validation HIS Key";
                GenJournalLine."E3 Store Code" := HISCollectionStaging."Store Code";
                GenJournalLine."E3 Patient Name" := HISCollectionStaging."Patient Name";
                GenJournalLine."E3 Transaction Type" := HISCollectionStaging.TRANSACTION_TYPE;
                GenJournalLine."E3 Encounter No." := HISCollectionStaging."Encounter No.";
                GenJournalLine.INSERT();
                //Sandeep
                GenJournalLinerec.Reset();
                GenJournalLinerec.SetRange("Journal Template Name", IntegrationSetupLine."General Journal Template Code");
                GenJournalLinerec.SetRange("Journal Batch Name", IntegrationSetupLine."General Journal Batch Code");
                GenJournalLinerec.SetRange("Document Type", HISCollectionStaging."Document Type");
                GenJournalLinerec.SetRange("Document No.", HISCollectionStaging."Document No.");
                GenJournalLinerec.SetRange("Posting Date", HISCollectionStaging."Document Date");
                HISGLAccountMapping.Reset();
                HISGLAccountMapping.SetRange("Service/Station Head", HISCollectionStaging."HIS Document Type");
                if HISGLAccountMapping.FindFirst() then begin

                    GenJournalLinerec.SetRange("Account Type", HISGLAccountMapping."Account Type");
                    GenJournalLinerec.SetRange("Account No.", HISGLAccountMapping."Account No.");
                    if GenJournalLinerec.FindFirst() then begin
                        GenJournalLinerec.validate(Amount, -HISCollectionStaging.Amount + GenJournalLinerec.Amount);
                        GenJournalLinerec.Modify(true);
                    end else begin
                        GenJournalLine.INIT();
                        GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name", IntegrationSetupLine."General Journal Template Code");
                        GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name", IntegrationSetupLine."General Journal Batch Code");
                        intLineNo += 10000;
                        GenJournalLine."Line No." := intLineNo;
                        GenJournalLine.VALIDATE("Document Type", HISCollectionStaging."Document Type");
                        GenJournalLine.VALIDATE("Document No.", HISCollectionStaging."Document No.");
                        GenJournalLine.VALIDATE("Posting Date", HISCollectionStaging."Document Date");

                        HISGLAccountMapping.Reset();
                        HISGLAccountMapping.SetRange("Service/Station Head", HISCollectionStaging."HIS Document Type");
                        if HISGLAccountMapping.FindFirst() then begin

                            GenJournalLine.VALIDATE("Account Type", HISGLAccountMapping."Account Type");
                            GenJournalLine.VALIDATE("Account No.", HISGLAccountMapping."Account No.");
                        end ELSE
                            Error(DocumentTypeLbl, HISCollectionStaging."HIS Document Type");

                        GenJournalLine.VALIDATE(Amount, -HISCollectionStaging.Amount);
                        GenJournalLine.validate("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
                        GenJournalLine.VALIDATE("Cheque Date", HISCollectionStaging."Cheque Date");
                        GenJournalLine.VALIDATE("Cheque No.", COPYSTR(HISCollectionStaging."Cheque No.", 1, 10));
                        if HISCollectionStaging."Shortcut Dimension 1 Code" <> '' then begin
                            GenJournalLine.VALIDATE("Location Code", HISCollectionStaging."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", HISCollectionStaging."Shortcut Dimension 1 Code");
                        end;

                        if HISCollectionStaging."Shortcut Dimension 1 Code" <> '' then
                            GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", GetMappedDimension(HISCollectionStaging."Shortcut Dimension 2 Code"));

                        GenJournalLine.VALIDATE("External Document No.", HISCollectionStaging."External Document No.");
                        GenJournalLine."E3 Narration" := COPYSTR(HISCollectionStaging."Line Narration", 1, 50);
                        GenJournalLine."E3 HIS Module" := HISCollectionStaging."HIS Module";
                        GenJournalLine."E3 HIS Document Type" := COPYSTR(HISCollectionStaging."HIS Document Type", 1, 60);
                        GenJournalLine."E3 UTR No." := HISCollectionStaging."Cheque No.";
                        GenJournalLine."E3 Sub Group Code" := HISCollectionStaging."Sub Group";
                        GenJournalLine."E3 Receipt No." := COPYSTR(HISCollectionStaging."Receipt No.", 1, 20);
                        GenJournalLine."E3 UHID" := HISCollectionStaging.UHID;
                        GenJournalLine."E3 Validation Key" := HISCollectionStaging."Validation HIS Key";
                        GenJournalLine."E3 Store Code" := HISCollectionStaging."Store Code";
                        GenJournalLine."E3 Patient Name" := HISCollectionStaging."Patient Name";
                        GenJournalLine."E3 Transaction Type" := HISCollectionStaging.TRANSACTION_TYPE;
                        GenJournalLine."E3 Encounter No." := HISCollectionStaging."Encounter No.";
                        GenJournalLine.INSERT();

                    end;
                end;
                HISCollectionStaging."Created By" := USERID;
                HISCollectionStaging."Created Date Time" := CURRENTDATETIME;
                HISCollectionStaging."General Entries Created" := TRUE;
                HISCollectionStaging.MODIFY();
            UNTIL HISCollectionStaging.NEXT() = 0;

    end;

    procedure RevenueInvoiceValidation(RecordType: option; DocumentType: Option; DocumentNo: Code[20])
    var
        RevenueSetup: Record "E3 HIS GL Accounts Mapping";
        HISItemMapping: Record "E3 HIS Item Mapping";
        HISCustMapping: Record "E3 HIS Customer Mapping";
        Customer: Record Customer;
        txtHSNCode: Text[100];
        HSNSAC: Record "HSN/SAC";
        txtSalesAccount: Text[100];
        GSTGroup: Record "GST Group";
        GSTGroupCode: Code[20];
        LineCount: Integer;
    begin
        LineCount := 0;
        txtHSNCode := '';
        txtSalesAccount := '';
        txtHSNCode := '';
        GSTGroupCode := '';
        IntegrationSetup.Get();

        HISRevenueHeader.RESET();
        HISRevenueHeader.SetRange("Record Type", RecordType);
        HISRevenueHeader.SetRange("Document Type", DocumentType);
        HISRevenueHeader.SETRANGE("Document No.", DocumentNo);
        IF HISRevenueHeader.FINDFIRST() THEN BEGIN
            HISRevenueHeader."Error 1" := FALSE;
            HISRevenueHeader."Error 2" := FALSE;
            HISRevenueHeader."Error 3" := FALSE;
            HISRevenueHeader."Error 4" := FALSE;
            HISRevenueHeader."Error Description" := '';
            HISRevenueHeader.MODIFY();
        END;

        HISRevenueLine.RESET();
        HISRevenueLine.SetRange("Record Type", RecordType);
        HISRevenueLine.SetRange("Document Type", DocumentType);
        HISRevenueLine.SETRANGE("Document No.", DocumentNo);
        HISRevenueLine.SetRange("Package Patient", false);  //Check if not required
        IF HISRevenueLine.FINDFIRST() THEN BEGIN
            REPEAT
                LineCount += 1;
                //if IntegrationSetup."Revenue/Rev. Cancel Handling" = IntegrationSetup."Revenue/Rev. Cancel Handling"::"Via Invoices" then begin
                IF HISRevenueLine."HSN Code" <> '' THEN begin
                    if HISRevenueLine."GST Group Code" = '' then
                        GSTGroupCode := 'Must not be Blank';

                    HSNSAC.RESET();
                    HSNSAC.SetRange("GST Group Code", HISRevenueLine."GST Group Code");
                    HSNSAC.SETRANGE(Code, HISRevenueLine."HSN Code");
                    IF NOT HSNSAC.FINDFIRST() THEN
                        txtHSNCode := 'Create New HSN Code'
                END;

                IF HISRevenueLine."GST Group Code" <> '' THEN BEGIN
                    if HISRevenueLine."HSN Code" = '' then
                        txtHSNCode := 'HSN Code must have value.';

                    GSTGroup.RESET();
                    GSTGroup.SETRANGE(GSTGroup.Code, HISRevenueLine."GST Group Code");
                    IF NOT GSTGroup.FINDFIRST() THEN
                        GSTGroupCode := 'Create New GST Group';
                END;
                //End;

                IF HISRevenueLine."Account No." = '' THEN begin
                    HISRevenueHeader.RESET();
                    HISRevenueHeader.SetRange("Record Type", HISRevenueLine."Record Type");
                    HISRevenueHeader.SetRange("Document Type", HISRevenueLine."Document Type");
                    HISRevenueHeader.SETRANGE("Document No.", HISRevenueLine."Document No.");
                    IF HISRevenueHeader.FINDFIRST() THEN begin
                        RevenueSetup.Reset();
                        RevenueSetup.SetRange("Service/Station Head", HISRevenueHeader."HIS Document Type");
                        RevenueSetup.SetRange("HIS Code", HISRevenueLine."Service Item Code");
                        RevenueSetup.SetRange(Package, HISRevenueLine."Package Patient");
                        if not RevenueSetup.FindFirst() then
                            txtSalesAccount := 'Revenue Account Missing'
                        else
                            if (RevenueSetup."Account No." <> '') and (RevenueSetup."Discount G/L Account" <> '') and (RevenueSetup."MOU Discount G/L Account" <> '') then begin
                                HISRevenueLine."Account Type" := RevenueSetup."Account Type";
                                HISRevenueLine."Account No." := RevenueSetup."Account No.";
                                HISRevenueLine."Discount G/L Account" := RevenueSetup."Discount G/L Account";
                                HISRevenueLine."MOU Discount G/L Account" := RevenueSetup."MOU Discount G/L Account";
                                if HISRevenueLine."Shortcut Dimension 1 Code" = '' then
                                    HISRevenueLine."Shortcut Dimension 1 Code" := HISRevenueHeader."Shortcut Dimension 1 Code";
                                HISRevenueLine.Modify(false);
                            end else
                                txtSalesAccount := 'Revenue or Discounts Account Missing';
                    end;
                end;


            UNTIL HISRevenueLine.NEXT() = 0;

            HISRevenueHeader.RESET();
            HISRevenueHeader.SetRange("Record Type", HISRevenueLine."Record Type");
            HISRevenueHeader.SetRange("Document Type", HISRevenueLine."Document Type");
            HISRevenueHeader.SETRANGE("Document No.", HISRevenueLine."Document No.");
            IF HISRevenueHeader.FINDFIRST() THEN begin
                if HISRevenueHeader."No. of Lines" <> LineCount then
                    HISRevenueHeader."Error Description" := 'Line count mismatch.';

                if HISRevenueHeader."Posting Date" = 0D then
                    HISRevenueHeader."Posting Date" := HISRevenueHeader."Document Date";

                if HISRevenueHeader."Location Code" = '' then
                    HISRevenueHeader."Location Code" := HISRevenueHeader."Shortcut Dimension 1 Code";

                if HISRevenueHeader."Customer No." = '' then begin
                    HISCustMapping.Reset();
                    HISCustMapping.SetRange("HIS Code", HISRevenueHeader."Payer Code");
                    if HISCustMapping.FindFirst() then begin
                        Customer.Reset();
                        Customer.SetRange("No.", HISCustMapping."Customer No.");
                        if Customer.FindFirst() then begin
                            HISRevenueHeader."Customer No." := Customer."No.";
                            HISRevenueHeader."Customer Name" := Customer.Name;
                            HISRevenueHeader.Modify();
                        end else
                            HISRevenueHeader."Error Description" := 'Customer does not exists.';
                    end else
                        HISRevenueHeader."Error Description" := 'Customer Mapping Missing';
                end;

                IF (HISRevenueHeader."Customer Name" = '') OR (txtHSNCode <> '') OR (txtSalesAccount <> '') OR (GSTGroupCode <> '') THEN
                    HISRevenueHeader."Error Description" := 'Kindly Check Customer,HSN Code,GST Group Code';
                // ELSE
                //     HISRevenueHeader."Error Description" := '';

                HISRevenueHeader.MODIFY();
            end;
        END ELSE BEGIN
            HISRevenueHeader.RESET();
            HISRevenueHeader.SetRange("Record Type", RecordType);
            HISRevenueHeader.SetRange("Document Type", DocumentType);
            HISRevenueHeader.SETRANGE("Document No.", DocumentNo);
            IF HISRevenueHeader.FINDFIRST() THEN BEGIN
                HISRevenueLine.RESET();
                HISRevenueLine.SetRange("Record Type", HISRevenueHeader."Record Type");
                HISRevenueLine.SetRange("Document Type", HISRevenueHeader."Document Type");
                HISRevenueLine.SETRANGE("Document No.", HISRevenueHeader."Document No.");
                IF NOT HISRevenueLine.FINDFIRST() THEN
                    HISRevenueHeader."Error Description" := 'Integration Line is Empty';
                HISRevenueHeader.MODIFY();
            END;
        END;

        HISRevenueHeader.RESET();
        HISRevenueHeader.SetRange("Record Type", HISRevenueLine."Record Type");
        HISRevenueHeader.SetRange("Document Type", HISRevenueLine."Document Type");
        HISRevenueHeader.SETRANGE("Document No.", HISRevenueLine."Document No.");
        IF HISRevenueHeader.FINDFIRST() THEN BEGIN
            IF (HISRevenueHeader."Customer Name" = '') THEN
                HISRevenueHeader."Error 1" := TRUE
            ELSE
                HISRevenueHeader."Error 1" := FALSE;
            IF (txtSalesAccount <> '') THEN
                HISRevenueHeader."Error 2" := TRUE
            ELSE
                HISRevenueHeader."Error 2" := FALSE;
            IF (txtHSNCode <> '') THEN
                HISRevenueHeader."Error 3" := TRUE
            ELSE
                HISRevenueHeader."Error 3" := FALSE;
            IF (GSTGroupCode <> '') THEN
                HISRevenueHeader."Error 4" := TRUE
            ELSE
                HISRevenueHeader."Error 4" := FALSE;
            HISRevenueHeader.MODIFY();
        END;
        Commit();
    end;

    procedure RevenueInvoiceReValidation(RecordType: option; DocumentType: Option; DocumentNo: Code[20])
    var
        RevenueSetup: Record "E3 HIS GL Accounts Mapping";
        HISItemMapping: Record "E3 HIS Item Mapping";
        HISCustMapping: Record "E3 HIS Customer Mapping";
        txtHSNCode: Text[100];
        HSNSAC: Record "HSN/SAC";
        txtSalesAccount: Text[100];
        GSTGroup: Record "GST Group";
        GSTGroupCode: Code[20];
        txtHSNCodeNew: Text[100];
        Customer: Record Customer;
        LineCount: Integer;
    BEGIN
        LineCount := 0;
        txtHSNCode := '';
        txtSalesAccount := '';
        txtHSNCodeNew := '';
        GSTGroupCode := '';
        IntegrationSetup.Get();

        HISRevenueHeader.RESET();
        HISRevenueHeader.SetRange("Record Type", RecordType);
        HISRevenueHeader.SetRange("Document Type", DocumentType);
        HISRevenueHeader.SETRANGE("Document No.", DocumentNo);
        IF HISRevenueHeader.FINDFIRST() THEN BEGIN
            HISRevenueHeader."Error 1" := FALSE;
            HISRevenueHeader."Error 2" := FALSE;
            HISRevenueHeader."Error 3" := FALSE;
            HISRevenueHeader."Error 4" := FALSE;
            HISRevenueHeader."Error Description" := '';
            HISRevenueHeader.MODIFY();
        END;

        HISRevenueLine.RESET();
        HISRevenueLine.SetRange("Record Type", RecordType);
        HISRevenueLine.SetRange("Document Type", DocumentType);
        HISRevenueLine.SETRANGE("Document No.", DocumentNo);
        HISRevenueLine.SetRange("Package Patient", false);  //Check if exceluded
        IF HISRevenueLine.FINDFIRST() THEN BEGIN
            REPEAT
                LineCount += 1;
                // IF HISRevenueLine."HSN Code" = '' THEN BEGIN
                //     txtHSNCode := 'HSN Code';
                // END;
                //if IntegrationSetup."Revenue/Rev. Cancel Handling" = IntegrationSetup."Revenue/Rev. Cancel Handling"::"Via Invoices" then begin
                if HISRevenueLine."HSN Code" <> '' then begin
                    if HISRevenueLine."GST Group Code" = '' then
                        GSTGroupCode := 'Must not be Blank';

                    HSNSAC.RESET();
                    HSNSAC.SetRange("GST Group Code", HISRevenueLine."GST Group Code");
                    HSNSAC.SETRANGE(Code, HISRevenueLine."HSN Code");
                    IF NOT HSNSAC.FINDFIRST() THEN
                        txtHSNCodeNew := 'HSN Code New';
                end;

                IF HISRevenueLine."GST Group Code" <> '' THEN BEGIN
                    if HISRevenueLine."HSN Code" = '' then
                        txtHSNCodeNew := 'HSN Code must have value.';

                    GSTGroup.Reset();
                    GSTGroup.SetRange(Code, HISRevenueLine."GST Group Code");
                    IF NOT GSTGroup.FINDFIRST() THEN
                        GSTGroupCode := 'GST Group';
                END;
                //End;

                IF HISRevenueLine."Account No." = '' THEN BEGIN
                    HISRevenueHeader.RESET();
                    HISRevenueHeader.SetRange("Record Type", RecordType);
                    HISRevenueHeader.SetRange("Document Type", DocumentType);
                    HISRevenueHeader.SETRANGE("Document No.", DocumentNo);
                    IF HISRevenueHeader.FINDFIRST() THEN begin
                        RevenueSetup.Reset();
                        RevenueSetup.SetRange("Service/Station Head", HISRevenueHeader."HIS Document Type");
                        RevenueSetup.SetRange("HIS Code", HISRevenueLine."Service Item Code");
                        RevenueSetup.SetRange(Package, HISRevenueLine."Package Patient");
                        if not RevenueSetup.FindFirst() then
                            txtSalesAccount := 'Revenue Account Missing'
                        else
                            if (RevenueSetup."Account No." <> '') and (RevenueSetup."Discount G/L Account" <> '') and (RevenueSetup."MOU Discount G/L Account" <> '') then begin
                                HISRevenueLine."Account Type" := RevenueSetup."Account Type";
                                HISRevenueLine."Account No." := RevenueSetup."Account No.";
                                HISRevenueLine."Discount G/L Account" := RevenueSetup."Discount G/L Account";
                                HISRevenueLine."MOU Discount G/L Account" := RevenueSetup."MOU Discount G/L Account";
                                if HISRevenueLine."Shortcut Dimension 1 Code" = '' then
                                    HISRevenueLine."Shortcut Dimension 1 Code" := HISRevenueHeader."Shortcut Dimension 1 Code";
                                HISRevenueLine.Modify(false);
                            end else
                                txtSalesAccount := 'Revenue or Discounts Account Missing';
                    END;
                end;
            UNTIL HISRevenueLine.NEXT() = 0;

            HISRevenueHeader.RESET();
            HISRevenueHeader.SetRange("Record Type", RecordType);
            HISRevenueHeader.SetRange("Document Type", DocumentType);
            HISRevenueHeader.SETRANGE("Document No.", DocumentNo);
            IF HISRevenueHeader.FINDFIRST() THEN begin
                if HISRevenueHeader."No. of Lines" <> LineCount then
                    HISRevenueHeader."Error Description" := 'Line count mismatch.';

                if HISRevenueHeader."Posting Date" = 0D then
                    HISRevenueHeader."Posting Date" := HISRevenueHeader."Document Date";

                if HISRevenueHeader."Location Code" = '' then
                    HISRevenueHeader."Location Code" := HISRevenueHeader."Shortcut Dimension 1 Code";

                if HISRevenueHeader."Customer No." = '' then begin
                    HISCustMapping.Reset();
                    HISCustMapping.SetRange("HIS Code", HISRevenueHeader."Payer Code");
                    if HISCustMapping.FindFirst() then begin
                        Customer.Reset();
                        Customer.SetRange("No.", HISCustMapping."Customer No.");
                        if Customer.FindFirst() then begin
                            HISRevenueHeader."Customer No." := Customer."No.";
                            HISRevenueHeader."Customer Name" := Customer.Name;
                            HISRevenueHeader.Modify();
                        end else
                            HISRevenueHeader."Error Description" := 'Customer does not exists.';
                    end else
                        HISRevenueHeader."Error Description" := 'Customer Mapping Missing';
                end else begin
                    Customer.Reset();
                    Customer.SetRange("No.", HISRevenueHeader."Customer No.");
                    if Customer.FindFirst() then begin
                        HISRevenueHeader."Customer Name" := Customer.Name;
                        HISRevenueHeader.Modify();
                    end;
                end;

                IF (HISRevenueHeader."Customer Name" = '') OR (txtHSNCodeNew <> '') OR (txtSalesAccount <> '') OR (GSTGroupCode <> '') THEN
                    HISRevenueHeader."Error Description" := 'Revalidation Error found';
                // ELSE
                //     HISRevenueHeader."Error Description" := '';

                IF HISRevenueHeader."Customer Name" <> '' THEN BEGIN
                    HISRevenueHeader."Error 1" := FALSE
                END;

                IF txtSalesAccount = '' THEN
                    HISRevenueHeader."Error 2" := FALSE;

                IF txtHSNCodeNew = '' THEN
                    HISRevenueHeader."Error 3" := FALSE;

                IF GSTGroupCode = '' THEN
                    HISRevenueHeader."Error 4" := FALSE;

                HISRevenueHeader.MODIFY();
            end;
        END ELSE BEGIN
            HISRevenueHeader.RESET();
            HISRevenueHeader.SetRange("Record Type", RecordType);
            HISRevenueHeader.SetRange("Document Type", DocumentType);
            HISRevenueHeader.SETRANGE("Document No.", DocumentNo);
            IF HISRevenueHeader.FINDFIRST() THEN BEGIN
                HISRevenueLine.RESET();
                HISRevenueLine.SetRange("Record Type", HISRevenueLine."Record Type");
                HISRevenueLine.SetRange("Document Type", HISRevenueLine."Document Type");
                HISRevenueLine.SETRANGE("Document No.", HISRevenueHeader."Document No.");
                IF NOT HISRevenueLine.FINDFIRST() THEN
                    HISRevenueHeader."Error Description" := 'Integration Line is Empty';
                HISRevenueHeader.MODIFY();
            END;
        END;
        Commit();
    END;

    procedure InitRevenueInvoice(RecordType: Option; DocumentType: Option; DocumentNo: CODE[20])
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        GenJournalLine: Record "Gen. Journal Line";
        InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary;
        PostGenJnlLine: Codeunit "Gen. Jnl.-Post Line";
        AmountToCustomer: Decimal;
        PatientPayble: Decimal;
        LineNo: Integer;
    begin
        AmountToCustomer := 0;
        PatientPayble := 0;
        IntegrationSetup.GET();
        //IntegrationSetup.testfield("Account Type");
        IntegrationSetup.testfield("Account No.");

        RevenueInvoiceValidation(RecordType, documentType, DocumentNo);

        HISRevenueHeader.RESET();
        HISRevenueHeader.SETRANGE(HISRevenueHeader."Document No.", DocumentNo);
        HISRevenueHeader.SETRANGE("Record Type", RecordType);
        HISRevenueHeader.SETRANGE("Document Type", DocumentType);
        HISRevenueHeader.SETRANGE(HISRevenueHeader."Create Revenue", FALSE);
        HISRevenueHeader.SETFILTER(HISRevenueHeader."Customer No.", '<>%1', '');
        HISRevenueHeader.SETFILTER(HISRevenueHeader."Error Description", '%1', '');
        HISRevenueHeader.SETFILTER(HISRevenueHeader."No. of Lines", '<>%1', 0);
        HISRevenueHeader.SETRANGE(HISRevenueHeader."Error 1", FALSE);
        HISRevenueHeader.SETRANGE(HISRevenueHeader."Error 2", FALSE);
        HISRevenueHeader.SETRANGE(HISRevenueHeader."Error 3", FALSE);
        HISRevenueHeader.SETRANGE(HISRevenueHeader."Error 4", FALSE);
        IF HISRevenueHeader.FINDFIRST() THEN BEGIN
            if IntegrationSetup."Revenue/Rev. Cancel Handling" = IntegrationSetup."Revenue/Rev. Cancel Handling"::"Via Invoices" then begin
                SalesHeader.INIT();
                IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::Revenue) AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::Invoice) THEN BEGIN
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice
                END ELSE
                    IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::"Revenue Cancel") AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::"Credit Memo") THEN
                        SalesHeader."Document Type" := SalesHeader."Document Type"::"Credit Memo";

                SalesHeader."No." := HISRevenueHeader."Document No.";
                SalesHeader.INSERT(TRUE);
                SalesHeader.VALIDATE("Sell-to Customer No.", HISRevenueHeader."Customer No.");
                SalesHeader.VALIDATE("Order Date", HISRevenueHeader."Document Date");
                if HISRevenueHeader."Posting Date" <> 0D then
                    SalesHeader.VALIDATE("Posting Date", HISRevenueHeader."Posting Date")
                else
                    SalesHeader.Validate("Posting Date", HISRevenueHeader."Document Date");
                SalesHeader.VALIDATE("External Document No.", HISRevenueHeader."External Document No.");
                if HISRevenueHeader."Location Code" <> '' then
                    SalesHeader.VALIDATE("Location Code", HISRevenueHeader."Location Code")
                else
                    SalesHeader.Validate("Location Code", HISRevenueHeader."Shortcut Dimension 1 Code");
                SalesHeader.VALIDATE(SalesHeader."Shortcut Dimension 1 Code", HISRevenueHeader."Shortcut Dimension 1 Code");
                SalesHeader.VALIDATE(SalesHeader."Shortcut Dimension 2 Code", GetMappedDimension(HISRevenueHeader."Shortcut Dimension 2 Code"));
                SalesHeader.VALIDATE("Posting No. Series", '');
                SalesHeader.VALIDATE("Posting No.", HISRevenueHeader."Document No.");
                SalesHeader.Validate("Reference Invoice No.", HISRevenueHeader."Reference Invoice No.");
                //Code
                //SalesHeader."E3 HIS Module" := HISRevenueHeader."E3 HIS Module";
                SalesHeader."E3 HIS Document Type" := HISRevenueHeader."HIS Document Type";
                SalesHeader."E3 UHID" := HISRevenueHeader."UHID";
                SalesHeader."E3 Patient Name" := HISRevenueHeader."Patient Name";
                SalesHeader."E3 Encounter No." := HISRevenueHeader."Encounter No.";
                SalesHeader."E3 Doctor Name" := HISRevenueHeader.Doctor;
                SalesHeader."E3 Speciality" := HISRevenueHeader."Speciality";
                SalesHeader."E3 Sponsor Code" := HISRevenueHeader."Sponsor Code";
                SalesHeader."E3 Sponsor Name" := HISRevenueHeader."Sponsor Name";
                SalesHeader."E3 Payer Code" := HISRevenueHeader."Payer Code";
                SalesHeader."E3 Payer Name" := HISRevenueHeader."Payer Name";
                SalesHeader.MODIFY();
            end else begin
                IntegrationSetupLine.Reset();
                IntegrationSetupLine.SetRange(Type, IntegrationSetupLine.Type::Revenue);
                IntegrationSetupLine.FindFirst();
                IntegrationSetupLine.TestField("General Journal Template Code");
                IntegrationSetupLine.TestField("General Journal Batch Code");
            end;

            LineNo := 0;
            if IntegrationSetup."Revenue/Rev. Cancel Handling" = IntegrationSetup."Revenue/Rev. Cancel Handling"::"Via Invoices" then begin
                HISRevenueLine.RESET();
                HISRevenueLine.SetRange("Record Type", HISRevenueHeader."Record Type");
                HISRevenueLine.SetRange("document Type", HISRevenueHeader."document Type");
                HISRevenueLine.SETRANGE(HISRevenueLine."Document No.", SalesHeader."No.");
                HISRevenueLine.SetRange("Package Patient", false);
                IF HISRevenueLine.FINDFIRST() THEN
                    REPEAT
                        LineNo += 10000;
                        SalesLine.INIT();
                        SalesLine.VALIDATE("Document Type", SalesHeader."Document Type");
                        SalesLine."Document No." := SalesHeader."No.";
                        SalesLine.VALIDATE("Line No.", LineNo);
                        SalesLine.VALIDATE(Type, SalesLine.Type::"G/L Account");
                        SalesLine.VALIDATE("No.", HISRevenueLine."Account No.");
                        SalesLine.VALIDATE(Quantity, HISRevenueLine.Qty);
                        SalesLine.VALIDATE(SalesLine."Unit Price", HISRevenueLine.Amount);
                        SalesLine.VALIDATE("GST Group Code", DELCHR(CONVERTSTR(HISRevenueLine."GST Group Code", '.', ' ')));
                        SalesLine.VALIDATE("HSN/SAC Code", HISRevenueLine."HSN Code");
                        SalesLine.VALIDATE("Location Code", SalesHeader."Location Code");
                        SalesLine.VALIDATE(SalesLine."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 1 Code");
                        SalesLine.VALIDATE(SalesLine."Shortcut Dimension 2 Code", SalesHeader."Shortcut Dimension 2 Code");
                        SalesLine.Description := COPYSTR(HISRevenueLine."Item Name", 1, 100);
                        SalesLine.VALIDATE(SalesLine."GST Credit", HISRevenueLine."Credit Type");
                        SalesLine.VALIDATE("Line Discount Amount", -1 * HISRevenueLine.Discount);
                        SalesLine.INSERT(TRUE);
                    UNTIL HISRevenueLine.NEXT() = 0;
            end else begin
                InvoicePostingBuffer.DeleteAll();
                AmountToCustomer := 0;
                PatientPayble := 0;

                HISRevenueLine.RESET();
                HISRevenueLine.SetRange("Record Type", HISRevenueHeader."Record Type");
                HISRevenueLine.SetRange("document Type", HISRevenueHeader."document Type");
                HISRevenueLine.SETRANGE(HISRevenueLine."Document No.", HISRevenueHeader."Document No.");
                HISRevenueLine.SetRange("Package Patient", false);
                IF HISRevenueLine.FINDFIRST() THEN
                    REPEAT
                        AmountToCustomer += HISRevenueLine."Payor Payable";
                        PatientPayble += HISRevenueLine."Patient Payable";

                        InvoicePostingBuffer.SetRange("G/L Account", HISRevenueLine."Account No.");
                        InvoicePostingBuffer.SetRange("Global Dimension 1 Code", HISRevenueLine."Shortcut Dimension 1 Code");
                        InvoicePostingBuffer.SetRange("Global Dimension 2 Code", HISRevenueLine."Shortcut Dimension 2 Code");
                        if InvoicePostingBuffer.FindFirst() then begin
                            InvoicePostingBuffer.Amount := InvoicePostingBuffer.Amount + (-(HISRevenueLine.Amount));
                            InvoicePostingBuffer.Modify();
                        end else begin
                            InvoicePostingBuffer.Init();
                            InvoicePostingBuffer."Group ID" := HISRevenueLine."Account No." + ';' + HISRevenueLine."Shortcut Dimension 1 Code" + ';' + HISRevenueLine."Shortcut Dimension 2 Code";
                            InvoicePostingBuffer.Type := InvoicePostingBuffer.Type::"G/L Account";
                            InvoicePostingBuffer."G/L Account" := HISRevenueLine."Account No.";
                            InvoicePostingBuffer."Global Dimension 1 Code" := HISRevenueLine."Shortcut Dimension 1 Code";
                            InvoicePostingBuffer."Global Dimension 2 Code" := HISRevenueLine."Shortcut Dimension 2 Code";
                            InvoicePostingBuffer.Amount := -(HISRevenueLine.Amount);
                            InvoicePostingBuffer.Insert();
                        end;

                        if HISRevenueLine.Discount <> 0 then begin
                            //AmountToCustomer += HISRevenueLine.Discount;
                            InvoicePostingBuffer.SetRange("G/L Account", HISRevenueLine."Discount G/L Account");
                            InvoicePostingBuffer.SetRange("Global Dimension 1 Code", HISRevenueLine."Shortcut Dimension 1 Code");
                            InvoicePostingBuffer.SetRange("Global Dimension 2 Code", HISRevenueLine."Shortcut Dimension 2 Code");
                            if InvoicePostingBuffer.FindFirst() then begin
                                InvoicePostingBuffer.Amount := InvoicePostingBuffer.Amount + (-HISRevenueLine.Discount);
                                InvoicePostingBuffer.Modify();
                            end else begin
                                InvoicePostingBuffer.Init();
                                InvoicePostingBuffer."Group ID" := HISRevenueLine."Account No." + ';' + HISRevenueLine."Shortcut Dimension 1 Code" + ';' + HISRevenueLine."Shortcut Dimension 2 Code" + ';Discount';
                                InvoicePostingBuffer.Type := InvoicePostingBuffer.Type::"G/L Account";
                                InvoicePostingBuffer."G/L Account" := HISRevenueLine."Discount G/L Account";
                                InvoicePostingBuffer."Global Dimension 1 Code" := HISRevenueLine."Shortcut Dimension 1 Code";
                                InvoicePostingBuffer."Global Dimension 2 Code" := HISRevenueLine."Shortcut Dimension 2 Code";
                                InvoicePostingBuffer.Amount := -HISRevenueLine.Discount;
                                InvoicePostingBuffer.Insert();
                            end;
                        end;

                        if HISRevenueLine."MOU Discount" <> 0 then begin
                            //AmountToCustomer += HISRevenueLine.Discount;
                            InvoicePostingBuffer.SetRange("G/L Account", HISRevenueLine."MOU Discount G/L Account");
                            InvoicePostingBuffer.SetRange("Global Dimension 1 Code", HISRevenueLine."Shortcut Dimension 1 Code");
                            InvoicePostingBuffer.SetRange("Global Dimension 2 Code", HISRevenueLine."Shortcut Dimension 2 Code");
                            if InvoicePostingBuffer.FindFirst() then begin
                                InvoicePostingBuffer.Amount := InvoicePostingBuffer.Amount + (-HISRevenueLine."MOU Discount");
                                InvoicePostingBuffer.Modify();
                            end else begin
                                InvoicePostingBuffer.Init();
                                InvoicePostingBuffer."Group ID" := HISRevenueLine."Account No." + ';' + HISRevenueLine."Shortcut Dimension 1 Code" + ';' + HISRevenueLine."Shortcut Dimension 2 Code" + ';MOUDiscount';
                                InvoicePostingBuffer.Type := InvoicePostingBuffer.Type::"G/L Account";
                                InvoicePostingBuffer."G/L Account" := HISRevenueLine."MOU Discount G/L Account";
                                InvoicePostingBuffer."Global Dimension 1 Code" := HISRevenueLine."Shortcut Dimension 1 Code";
                                InvoicePostingBuffer."Global Dimension 2 Code" := HISRevenueLine."Shortcut Dimension 2 Code";
                                InvoicePostingBuffer.Amount := -HISRevenueLine."MOU Discount";
                                InvoicePostingBuffer.Insert();
                            end;
                        end;
                    UNTIL HISRevenueLine.NEXT() = 0;

                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", IntegrationSetupLine."General Journal Template Code");
                GenJournalLine.SetRange("Journal Batch Name", IntegrationSetupLine."General Journal Batch Code");
                if GenJournalLine.FindLast() then
                    LineNo := GenJournalLine."Line No."
                else
                    LineNo := 0;

                InvoicePostingBuffer.Reset();
                InvoicePostingBuffer.SetFilter(Amount, '<>0');
                if InvoicePostingBuffer.FindSet() then
                    repeat
                        LineNo += 10000;
                        GenJournalLine.INIT();
                        GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name", IntegrationSetupLine."General Journal Template Code");
                        GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name", IntegrationSetupLine."General Journal Batch Code");
                        GenJournalLine."Line No." := LineNo;
                        IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::Revenue) AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::Invoice) THEN
                            GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice)
                        ELSE
                            IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::"Revenue Cancel") AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::"Credit Memo") THEN
                                GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::"Credit Memo");

                        GenJournalLine.VALIDATE("Document No.", HISRevenueHeader."Document No.");
                        GenJournalLine.VALIDATE("Document Date", HISRevenueHeader."Document Date");
                        GenJournalLine.VALIDATE("Posting Date", HISRevenueHeader."Posting Date");
                        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                        GenJournalLine.VALIDATE("Account No.", InvoicePostingBuffer."G/L Account");
                        GenJournalLine."Location Code" := HISRevenueHeader."Location Code";
                        GenJournalLine."Your Reference" := HISRevenueHeader."Reference Invoice No.";
                        IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::Revenue) AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::Invoice) THEN
                            GenJournalLine.VALIDATE(Amount, InvoicePostingBuffer.Amount)
                        else
                            GenJournalLine.VALIDATE(Amount, -InvoicePostingBuffer.Amount);
                        //GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::Customer);
                        //GenJournalLine.Validate("Bal. Account No.", HISRevenueHeader."Customer No.");
                        if InvoicePostingBuffer."Global Dimension 1 Code" <> '' then begin
                            GenJournalLine.VALIDATE("Location Code", InvoicePostingBuffer."Global Dimension 1 Code");
                            GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", InvoicePostingBuffer."Global Dimension 1 Code");
                        end;

                        if InvoicePostingBuffer."Global Dimension 2 Code" <> '' then
                            GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", GetMappedDimension(InvoicePostingBuffer."Global Dimension 2 Code"));

                        GenJournalLine.VALIDATE("External Document No.", HISRevenueHeader."External Document No.");

                        GenJournalLine."E3 HIS Document Type" := HISRevenueHeader."HIS Document Type";
                        GenJournalLine."E3 UHID" := HISRevenueHeader."UHID";
                        GenJournalLine."E3 Patient Name" := HISRevenueHeader."Patient Name";
                        GenJournalLine."E3 Encounter No." := HISRevenueHeader."Encounter No.";
                        GenJournalLine."E3 Doctor Name" := HISRevenueHeader.Doctor;
                        GenJournalLine."E3 Speciality" := HISRevenueHeader."Speciality";
                        GenJournalLine."E3 Sponsor Code" := HISRevenueHeader."Sponsor Code";
                        GenJournalLine."E3 Sponsor Name" := HISRevenueHeader."Sponsor Name";
                        GenJournalLine."E3 Payer Code" := HISRevenueHeader."Payer Code";
                        GenJournalLine."E3 Payer Name" := HISRevenueHeader."Payer Name";
                        if IntegrationSetup."Rev./Rev.Cancel Direct Post" then
                            PostGenJnlLine.RunWithCheck(GenJournalLine)
                        else
                            GenJournalLine.INSERT();
                    until InvoicePostingBuffer.Next() = 0;

                if PatientPayble <> 0 then begin
                    LineNo += 10000;
                    GenJournalLine.INIT();
                    GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name", IntegrationSetupLine."General Journal Template Code");
                    GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name", IntegrationSetupLine."General Journal Batch Code");
                    GenJournalLine."Line No." := LineNo;
                    IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::Revenue) AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::Invoice) THEN
                        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice)
                    ELSE
                        IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::"Revenue Cancel") AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::"Credit Memo") THEN
                            GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::"Credit Memo");

                    GenJournalLine.VALIDATE("Document No.", HISRevenueHeader."Document No.");
                    GenJournalLine.VALIDATE("Document Date", HISRevenueHeader."Document Date");
                    GenJournalLine.VALIDATE("Posting Date", HISRevenueHeader."Posting Date");
                    GenJournalLine.VALIDATE("Account Type", IntegrationSetup."Account Type");
                    GenJournalLine.VALIDATE("Account No.", IntegrationSetup."Account No.");
                    GenJournalLine."Location Code" := HISRevenueHeader."Location Code";
                    GenJournalLine."Your Reference" := HISRevenueHeader."Reference Invoice No.";
                    IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::Revenue) AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::Invoice) THEN
                        GenJournalLine.VALIDATE(Amount, PatientPayble)
                    else
                        GenJournalLine.Validate(Amount, -PatientPayble);
                    //GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::Customer);
                    //GenJournalLine.Validate("Bal. Account No.", HISRevenueHeader."Customer No.");
                    if HISRevenueHeader."Shortcut Dimension 1 Code" <> '' then begin
                        GenJournalLine.VALIDATE("Location Code", HISRevenueHeader."Shortcut Dimension 1 Code");
                        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", HISRevenueHeader."Shortcut Dimension 1 Code");
                    end;

                    if HISRevenueHeader."Shortcut Dimension 2 Code" <> '' then
                        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", GetMappedDimension(HISRevenueHeader."Shortcut Dimension 2 Code"));

                    GenJournalLine.VALIDATE("External Document No.", HISRevenueHeader."External Document No.");

                    GenJournalLine."E3 HIS Document Type" := HISRevenueHeader."HIS Document Type";
                    GenJournalLine."E3 UHID" := HISRevenueHeader."UHID";
                    GenJournalLine."E3 Patient Name" := HISRevenueHeader."Patient Name";
                    GenJournalLine."E3 Encounter No." := HISRevenueHeader."Encounter No.";
                    GenJournalLine."E3 Doctor Name" := HISRevenueHeader.Doctor;
                    GenJournalLine."E3 Speciality" := HISRevenueHeader."Speciality";
                    GenJournalLine."E3 Sponsor Code" := HISRevenueHeader."Sponsor Code";
                    GenJournalLine."E3 Sponsor Name" := HISRevenueHeader."Sponsor Name";
                    GenJournalLine."E3 Payer Code" := HISRevenueHeader."Payer Code";
                    GenJournalLine."E3 Payer Name" := HISRevenueHeader."Payer Name";
                    if IntegrationSetup."Rev./Rev.Cancel Direct Post" then
                        PostGenJnlLine.RunWithCheck(GenJournalLine)
                    else
                        GenJournalLine.INSERT();
                end;

                if AmountToCustomer <> 0 then begin
                    LineNo += 10000;
                    GenJournalLine.INIT();
                    GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name", IntegrationSetupLine."General Journal Template Code");
                    GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name", IntegrationSetupLine."General Journal Batch Code");
                    GenJournalLine."Line No." := LineNo;
                    IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::Revenue) AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::Invoice) THEN
                        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice)
                    ELSE
                        IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::"Revenue Cancel") AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::"Credit Memo") THEN
                            GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::"Credit Memo");

                    GenJournalLine.VALIDATE("Document No.", HISRevenueHeader."Document No.");
                    GenJournalLine.VALIDATE("Document Date", HISRevenueHeader."Document Date");
                    GenJournalLine.VALIDATE("Posting Date", HISRevenueHeader."Posting Date");
                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
                    GenJournalLine.VALIDATE("Account No.", HISRevenueHeader."Customer No.");
                    GenJournalLine."Location Code" := HISRevenueHeader."Location Code";
                    GenJournalLine."Your Reference" := HISRevenueHeader."Reference Invoice No.";
                    IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::Revenue) AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::Invoice) THEN
                        GenJournalLine.VALIDATE(Amount, AmountToCustomer)
                    else
                        GenJournalLine.VALIDATE(Amount, -AmountToCustomer);
                    //GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::Customer);
                    //GenJournalLine.Validate("Bal. Account No.", HISRevenueHeader."Customer No.");
                    if HISRevenueHeader."Shortcut Dimension 1 Code" <> '' then begin
                        GenJournalLine.VALIDATE("Location Code", HISRevenueHeader."Shortcut Dimension 1 Code");
                        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", HISRevenueHeader."Shortcut Dimension 1 Code");
                    end;

                    if HISRevenueHeader."Shortcut Dimension 2 Code" <> '' then
                        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", GetMappedDimension(HISRevenueHeader."Shortcut Dimension 2 Code"));

                    GenJournalLine.VALIDATE("External Document No.", HISRevenueHeader."External Document No.");

                    GenJournalLine."E3 HIS Document Type" := HISRevenueHeader."HIS Document Type";
                    GenJournalLine."E3 UHID" := HISRevenueHeader."UHID";
                    GenJournalLine."E3 Patient Name" := HISRevenueHeader."Patient Name";
                    GenJournalLine."E3 Encounter No." := HISRevenueHeader."Encounter No.";
                    GenJournalLine."E3 Doctor Name" := HISRevenueHeader.Doctor;
                    GenJournalLine."E3 Speciality" := HISRevenueHeader."Speciality";
                    GenJournalLine."E3 Sponsor Code" := HISRevenueHeader."Sponsor Code";
                    GenJournalLine."E3 Sponsor Name" := HISRevenueHeader."Sponsor Name";
                    GenJournalLine."E3 Payer Code" := HISRevenueHeader."Payer Code";
                    GenJournalLine."E3 Payer Name" := HISRevenueHeader."Payer Name";
                    if IntegrationSetup."Rev./Rev.Cancel Direct Post" then
                        PostGenJnlLine.RunWithCheck(GenJournalLine)
                    else
                        GenJournalLine.INSERT();
                end;
            end;
            HISRevenueHeader."Create Revenue" := TRUE;
            if IntegrationSetup."Rev./Rev.Cancel Direct Post" then
                HISRevenueHeader."Posted Document No." := HISRevenueHeader."Document No.";
            HISRevenueHeader.MODIFY();
            if IntegrationSetup."Rev./Rev.Cancel Direct Post" then
                Commit();
        END;
    end;

    local procedure GetMappedDimension(HISCCode: Code[20]): Code[20]
    var
        LGeneralLedgerSetup: Record "General Ledger Setup";
        DimensionMapping: Record "E3 HIS GL Accounts Mapping";
    begin
        if HISCCode = '' then
            exit('');

        LGeneralLedgerSetup.Get();

        DimensionMapping.Reset();
        DimensionMapping.SetRange(Type, DimensionMapping.Type::Dimension);
        DimensionMapping.SetRange("Dimension Code", LGeneralLedgerSetup."Global Dimension 2 Code");
        DimensionMapping.SetRange("HIS Code", HISCCode);
        if DimensionMapping.FindFirst() then
            exit(DimensionMapping."Department Code");
    end;

    procedure PostGenJnlLineEntries()
    var
        GenJnlLine: Record "Gen. Journal Line";
        HISIntegrationSetupLine: Record "E3 HIS Integration Setup Line";
        GenJournalLine1: Record "Gen. Journal Line";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
    begin
        IntegrationSetup.GET();
        IntegrationSetup.TESTFIELD("Integration Enabled", TRUE);
        IntegrationSetup.TESTFIELD("Revenue Creation Enabled", TRUE);


        IF NOT (IntegrationSetup."Integration Enabled") AND (IntegrationSetup."Revenue Creation Enabled") THEN
            EXIT;

        GenJnlLine.RESET();
        GenJnlLine.SETFILTER(GenJnlLine."Account No.", '%1', '');
        GenJnlLine.SETFILTER(GenJnlLine.Amount, '%1', 0);
        IF GenJnlLine.FINDFIRST() THEN BEGIN
            GenJnlLine.DELETEALL;
        END;

        HISIntegrationSetupLine.Reset();
        HISIntegrationSetupLine.SetFilter(Type, '<>%1', IntegrationSetupLine.Type::Revenue);
        IF HISIntegrationSetupLine.FindSet() then
            repeat
                GenJnlLine.RESET();
                GenJnlLine.SETRANGE("Journal Template Name", HISIntegrationSetupLine."General Journal Template Code");
                GenJnlLine.SETRANGE("Journal Batch Name", HISIntegrationSetupLine."General Journal Batch Code");
                IF GenJnlLine.FindSet() THEN
                    REPEAT
                        GenJournalLine1.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                        GenJournalLine1.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                        GenJournalLine1.SETRANGE("Document No.", GenJnlLine."Document No.");
                        GenJournalLine1.SETRANGE("Posting Date", GenJnlLine."Posting Date");
                        IF GenJournalLine1.FINDFIRST() THEN
                            REPEAT
                                GenJnlPostBatch.RUN(GenJournalLine1);
                            UNTIL GenJournalLine1.NEXT() = 0;
                    UNTIL GenJnlLine.NEXT() = 0
                else
                    Error('There is no HIS Entries Pending for the Posting');
            until HISIntegrationSetupLine.Next() = 0;

    end;

    procedure CreateAndPostRevenueInvoice(var HISRevenueHeader: Record "E3 LIMS Revenue Header")
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        GenJournalLine: Record "Gen. Journal Line";
        InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary;
        PostGenJnlLine: Codeunit "Gen. Jnl.-Post Line";
        AmountToCustomer: Decimal;
        PatientPayble: Decimal;
        LineNo: Integer;
    begin
        AmountToCustomer := 0;
        PatientPayble := 0;
        IntegrationSetup.GET();
        //IntegrationSetup.testfield("Account Type");
        IntegrationSetup.testfield("Account No.");

        RevenueInvoiceValidation(HISRevenueHeader);

        IF not HISRevenueHeader."Create Revenue" THEN BEGIN
            if IntegrationSetup."Revenue/Rev. Cancel Handling" = IntegrationSetup."Revenue/Rev. Cancel Handling"::"Via Invoices" then begin
                SalesHeader.INIT();
                IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::Revenue) AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::Invoice) THEN BEGIN
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice
                END ELSE
                    IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::"Revenue Cancel") AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::"Credit Memo") THEN
                        SalesHeader."Document Type" := SalesHeader."Document Type"::"Credit Memo";

                SalesHeader."No." := HISRevenueHeader."Document No.";
                SalesHeader.INSERT(TRUE);
                SalesHeader.VALIDATE("Sell-to Customer No.", HISRevenueHeader."Customer No.");
                SalesHeader.VALIDATE("Order Date", HISRevenueHeader."Document Date");
                if HISRevenueHeader."Posting Date" <> 0D then
                    SalesHeader.VALIDATE("Posting Date", HISRevenueHeader."Posting Date")
                else
                    SalesHeader.Validate("Posting Date", HISRevenueHeader."Document Date");
                SalesHeader.VALIDATE("External Document No.", HISRevenueHeader."External Document No.");
                if HISRevenueHeader."Location Code" <> '' then
                    SalesHeader.VALIDATE("Location Code", HISRevenueHeader."Location Code")
                else
                    SalesHeader.Validate("Location Code", HISRevenueHeader."Shortcut Dimension 1 Code");
                SalesHeader.VALIDATE(SalesHeader."Shortcut Dimension 1 Code", HISRevenueHeader."Shortcut Dimension 1 Code");
                SalesHeader.VALIDATE(SalesHeader."Shortcut Dimension 2 Code", GetMappedDimension(HISRevenueHeader."Shortcut Dimension 2 Code"));
                SalesHeader.VALIDATE("Posting No. Series", '');
                SalesHeader.VALIDATE("Posting No.", HISRevenueHeader."Document No.");
                SalesHeader.Validate("Reference Invoice No.", HISRevenueHeader."Reference Invoice No.");
                //Code
                //SalesHeader."E3 HIS Module" := HISRevenueHeader."E3 HIS Module";
                SalesHeader."E3 HIS Document Type" := HISRevenueHeader."HIS Document Type";
                SalesHeader."E3 UHID" := HISRevenueHeader."UHID";
                SalesHeader."E3 Patient Name" := HISRevenueHeader."Patient Name";
                SalesHeader."E3 Encounter No." := HISRevenueHeader."Encounter No.";
                SalesHeader."E3 Doctor Name" := HISRevenueHeader.Doctor;
                SalesHeader."E3 Speciality" := HISRevenueHeader."Speciality";
                SalesHeader."E3 Sponsor Code" := HISRevenueHeader."Sponsor Code";
                SalesHeader."E3 Sponsor Name" := HISRevenueHeader."Sponsor Name";
                SalesHeader."E3 Payer Code" := HISRevenueHeader."Payer Code";
                SalesHeader."E3 Payer Name" := HISRevenueHeader."Payer Name";
                SalesHeader.MODIFY();
            end else begin
                IntegrationSetupLine.Reset();
                IntegrationSetupLine.SetRange(Type, IntegrationSetupLine.Type::Revenue);
                IntegrationSetupLine.FindFirst();
                IntegrationSetupLine.TestField("General Journal Template Code");
                IntegrationSetupLine.TestField("General Journal Batch Code");
            end;

            LineNo := 0;
            if IntegrationSetup."Revenue/Rev. Cancel Handling" = IntegrationSetup."Revenue/Rev. Cancel Handling"::"Via Invoices" then begin
                HISRevenueLine.RESET();
                HISRevenueLine.SetRange("Record Type", HISRevenueHeader."Record Type");
                HISRevenueLine.SetRange("document Type", HISRevenueHeader."document Type");
                HISRevenueLine.SETRANGE(HISRevenueLine."Document No.", SalesHeader."No.");
                HISRevenueLine.SetRange("Package Patient", false);
                IF HISRevenueLine.FINDFIRST() THEN
                    REPEAT
                        LineNo += 10000;
                        SalesLine.INIT();
                        SalesLine.VALIDATE("Document Type", SalesHeader."Document Type");
                        SalesLine."Document No." := SalesHeader."No.";
                        SalesLine.VALIDATE("Line No.", LineNo);
                        SalesLine.VALIDATE(Type, SalesLine.Type::"G/L Account");
                        SalesLine.VALIDATE("No.", HISRevenueLine."Account No.");
                        SalesLine.VALIDATE(Quantity, HISRevenueLine.Qty);
                        SalesLine.VALIDATE(SalesLine."Unit Price", HISRevenueLine.Amount);
                        SalesLine.VALIDATE("GST Group Code", DELCHR(CONVERTSTR(HISRevenueLine."GST Group Code", '.', ' ')));
                        SalesLine.VALIDATE("HSN/SAC Code", HISRevenueLine."HSN Code");
                        SalesLine.VALIDATE("Location Code", SalesHeader."Location Code");
                        SalesLine.VALIDATE(SalesLine."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 1 Code");
                        SalesLine.VALIDATE(SalesLine."Shortcut Dimension 2 Code", SalesHeader."Shortcut Dimension 2 Code");
                        SalesLine.Description := COPYSTR(HISRevenueLine."Item Name", 1, 100);
                        SalesLine.VALIDATE(SalesLine."GST Credit", HISRevenueLine."Credit Type");
                        SalesLine.VALIDATE("Line Discount Amount", -1 * HISRevenueLine.Discount);
                        SalesLine.INSERT(TRUE);
                    UNTIL HISRevenueLine.NEXT() = 0;
            end else begin
                InvoicePostingBuffer.DeleteAll();
                AmountToCustomer := 0;
                PatientPayble := 0;

                HISRevenueLine.RESET();
                HISRevenueLine.SetRange("Record Type", HISRevenueHeader."Record Type");
                HISRevenueLine.SetRange("document Type", HISRevenueHeader."document Type");
                HISRevenueLine.SETRANGE(HISRevenueLine."Document No.", HISRevenueHeader."Document No.");
                HISRevenueLine.SetRange("Package Patient", false);
                IF HISRevenueLine.FINDFIRST() THEN
                    REPEAT
                        AmountToCustomer += HISRevenueLine."Payor Payable";
                        PatientPayble += HISRevenueLine."Patient Payable";

                        InvoicePostingBuffer.SetRange("G/L Account", HISRevenueLine."Account No.");
                        InvoicePostingBuffer.SetRange("Global Dimension 1 Code", HISRevenueLine."Shortcut Dimension 1 Code");
                        InvoicePostingBuffer.SetRange("Global Dimension 2 Code", HISRevenueLine."Shortcut Dimension 2 Code");
                        if InvoicePostingBuffer.FindFirst() then begin
                            InvoicePostingBuffer.Amount := InvoicePostingBuffer.Amount + (-(HISRevenueLine.Amount));
                            InvoicePostingBuffer.Modify();
                        end else begin
                            InvoicePostingBuffer.Init();
                            InvoicePostingBuffer."Group ID" := HISRevenueLine."Account No." + ';' + HISRevenueLine."Shortcut Dimension 1 Code" + ';' + HISRevenueLine."Shortcut Dimension 2 Code";
                            InvoicePostingBuffer.Type := InvoicePostingBuffer.Type::"G/L Account";
                            InvoicePostingBuffer."G/L Account" := HISRevenueLine."Account No.";
                            InvoicePostingBuffer."Global Dimension 1 Code" := HISRevenueLine."Shortcut Dimension 1 Code";
                            InvoicePostingBuffer."Global Dimension 2 Code" := HISRevenueLine."Shortcut Dimension 2 Code";
                            InvoicePostingBuffer.Amount := -(HISRevenueLine.Amount);
                            InvoicePostingBuffer.Insert();
                        end;

                        if HISRevenueLine.Discount <> 0 then begin
                            //AmountToCustomer += HISRevenueLine.Discount;
                            InvoicePostingBuffer.SetRange("G/L Account", HISRevenueLine."Discount G/L Account");
                            InvoicePostingBuffer.SetRange("Global Dimension 1 Code", HISRevenueLine."Shortcut Dimension 1 Code");
                            InvoicePostingBuffer.SetRange("Global Dimension 2 Code", HISRevenueLine."Shortcut Dimension 2 Code");
                            if InvoicePostingBuffer.FindFirst() then begin
                                InvoicePostingBuffer.Amount := InvoicePostingBuffer.Amount + (-HISRevenueLine.Discount);
                                InvoicePostingBuffer.Modify();
                            end else begin
                                InvoicePostingBuffer.Init();
                                InvoicePostingBuffer."Group ID" := HISRevenueLine."Account No." + ';' + HISRevenueLine."Shortcut Dimension 1 Code" + ';' + HISRevenueLine."Shortcut Dimension 2 Code" + ';Discount';
                                InvoicePostingBuffer.Type := InvoicePostingBuffer.Type::"G/L Account";
                                InvoicePostingBuffer."G/L Account" := HISRevenueLine."Discount G/L Account";
                                InvoicePostingBuffer."Global Dimension 1 Code" := HISRevenueLine."Shortcut Dimension 1 Code";
                                InvoicePostingBuffer."Global Dimension 2 Code" := HISRevenueLine."Shortcut Dimension 2 Code";
                                InvoicePostingBuffer.Amount := -HISRevenueLine.Discount;
                                InvoicePostingBuffer.Insert();
                            end;
                        end;

                        if HISRevenueLine."MOU Discount" <> 0 then begin
                            //AmountToCustomer += HISRevenueLine.Discount;
                            InvoicePostingBuffer.SetRange("G/L Account", HISRevenueLine."MOU Discount G/L Account");
                            InvoicePostingBuffer.SetRange("Global Dimension 1 Code", HISRevenueLine."Shortcut Dimension 1 Code");
                            InvoicePostingBuffer.SetRange("Global Dimension 2 Code", HISRevenueLine."Shortcut Dimension 2 Code");
                            if InvoicePostingBuffer.FindFirst() then begin
                                InvoicePostingBuffer.Amount := InvoicePostingBuffer.Amount + (-HISRevenueLine."MOU Discount");
                                InvoicePostingBuffer.Modify();
                            end else begin
                                InvoicePostingBuffer.Init();
                                InvoicePostingBuffer."Group ID" := HISRevenueLine."Account No." + ';' + HISRevenueLine."Shortcut Dimension 1 Code" + ';' + HISRevenueLine."Shortcut Dimension 2 Code" + ';MOUDiscount';
                                InvoicePostingBuffer.Type := InvoicePostingBuffer.Type::"G/L Account";
                                InvoicePostingBuffer."G/L Account" := HISRevenueLine."MOU Discount G/L Account";
                                InvoicePostingBuffer."Global Dimension 1 Code" := HISRevenueLine."Shortcut Dimension 1 Code";
                                InvoicePostingBuffer."Global Dimension 2 Code" := HISRevenueLine."Shortcut Dimension 2 Code";
                                InvoicePostingBuffer.Amount := -HISRevenueLine."MOU Discount";
                                InvoicePostingBuffer.Insert();
                            end;
                        end;
                    UNTIL HISRevenueLine.NEXT() = 0;

                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", IntegrationSetupLine."General Journal Template Code");
                GenJournalLine.SetRange("Journal Batch Name", IntegrationSetupLine."General Journal Batch Code");
                if GenJournalLine.FindLast() then
                    LineNo := GenJournalLine."Line No."
                else
                    LineNo := 0;

                InvoicePostingBuffer.Reset();
                InvoicePostingBuffer.SetFilter(Amount, '<>0');
                if InvoicePostingBuffer.FindSet() then
                    repeat
                        LineNo += 10000;
                        GenJournalLine.INIT();
                        GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name", IntegrationSetupLine."General Journal Template Code");
                        GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name", IntegrationSetupLine."General Journal Batch Code");
                        GenJournalLine."Line No." := LineNo;
                        IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::Revenue) AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::Invoice) THEN
                            GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice)
                        ELSE
                            IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::"Revenue Cancel") AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::"Credit Memo") THEN
                                GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::"Credit Memo");

                        GenJournalLine.VALIDATE("Document No.", HISRevenueHeader."Document No.");
                        GenJournalLine.VALIDATE("Document Date", HISRevenueHeader."Document Date");
                        if HISRevenueHeader."Posting Date" <> 0D then
                            GenJournalLine.VALIDATE("Posting Date", HISRevenueHeader."Posting Date")
                        else
                            GenJournalLine.VALIDATE("Posting Date", HISRevenueHeader."Document Date");
                        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                        GenJournalLine.VALIDATE("Account No.", InvoicePostingBuffer."G/L Account");
                        GenJournalLine."Location Code" := HISRevenueHeader."Location Code";
                        GenJournalLine."Your Reference" := HISRevenueHeader."Reference Invoice No.";
                        IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::Revenue) AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::Invoice) THEN
                            GenJournalLine.VALIDATE(Amount, InvoicePostingBuffer.Amount)
                        else
                            GenJournalLine.VALIDATE(Amount, -InvoicePostingBuffer.Amount);
                        //GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::Customer);
                        //GenJournalLine.Validate("Bal. Account No.", HISRevenueHeader."Customer No.");
                        if InvoicePostingBuffer."Global Dimension 1 Code" <> '' then begin
                            GenJournalLine.VALIDATE("Location Code", InvoicePostingBuffer."Global Dimension 1 Code");
                            GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", InvoicePostingBuffer."Global Dimension 1 Code");
                        end;

                        if InvoicePostingBuffer."Global Dimension 2 Code" <> '' then
                            GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", GetMappedDimension(InvoicePostingBuffer."Global Dimension 2 Code"));

                        GenJournalLine.VALIDATE("External Document No.", HISRevenueHeader."External Document No.");

                        GenJournalLine."E3 HIS Document Type" := HISRevenueHeader."HIS Document Type";
                        GenJournalLine."E3 UHID" := HISRevenueHeader."UHID";
                        GenJournalLine."E3 Patient Name" := HISRevenueHeader."Patient Name";
                        GenJournalLine."E3 Encounter No." := HISRevenueHeader."Encounter No.";
                        GenJournalLine."E3 Doctor Name" := HISRevenueHeader.Doctor;
                        GenJournalLine."E3 Speciality" := HISRevenueHeader."Speciality";
                        GenJournalLine."E3 Sponsor Code" := HISRevenueHeader."Sponsor Code";
                        GenJournalLine."E3 Sponsor Name" := HISRevenueHeader."Sponsor Name";
                        GenJournalLine."E3 Payer Code" := HISRevenueHeader."Payer Code";
                        GenJournalLine."E3 Payer Name" := HISRevenueHeader."Payer Name";
                        if IntegrationSetup."Rev./Rev.Cancel Direct Post" then
                            PostGenJnlLine.RunWithCheck(GenJournalLine)
                        else
                            GenJournalLine.INSERT();
                    until InvoicePostingBuffer.Next() = 0;

                if PatientPayble <> 0 then begin
                    LineNo += 10000;
                    GenJournalLine.INIT();
                    GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name", IntegrationSetupLine."General Journal Template Code");
                    GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name", IntegrationSetupLine."General Journal Batch Code");
                    GenJournalLine."Line No." := LineNo;
                    IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::Revenue) AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::Invoice) THEN
                        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice)
                    ELSE
                        IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::"Revenue Cancel") AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::"Credit Memo") THEN
                            GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::"Credit Memo");

                    GenJournalLine.VALIDATE("Document No.", HISRevenueHeader."Document No.");
                    GenJournalLine.VALIDATE("Document Date", HISRevenueHeader."Document Date");
                    if HISRevenueHeader."Posting Date" <> 0D then
                        GenJournalLine.VALIDATE("Posting Date", HISRevenueHeader."Posting Date")
                    else
                        GenJournalLine.VALIDATE("Posting Date", HISRevenueHeader."Document Date");
                    GenJournalLine.VALIDATE("Account Type", IntegrationSetup."Account Type");
                    GenJournalLine.VALIDATE("Account No.", IntegrationSetup."Account No.");
                    GenJournalLine."Location Code" := HISRevenueHeader."Location Code";
                    GenJournalLine."Your Reference" := HISRevenueHeader."Reference Invoice No.";
                    IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::Revenue) AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::Invoice) THEN
                        GenJournalLine.VALIDATE(Amount, PatientPayble)
                    else
                        GenJournalLine.Validate(Amount, -PatientPayble);
                    //GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::Customer);
                    //GenJournalLine.Validate("Bal. Account No.", HISRevenueHeader."Customer No.");
                    if HISRevenueHeader."Shortcut Dimension 1 Code" <> '' then begin
                        GenJournalLine.VALIDATE("Location Code", HISRevenueHeader."Shortcut Dimension 1 Code");
                        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", HISRevenueHeader."Shortcut Dimension 1 Code");
                    end;

                    if HISRevenueHeader."Shortcut Dimension 2 Code" <> '' then
                        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", GetMappedDimension(HISRevenueHeader."Shortcut Dimension 2 Code"));

                    GenJournalLine.VALIDATE("External Document No.", HISRevenueHeader."External Document No.");

                    GenJournalLine."E3 HIS Document Type" := HISRevenueHeader."HIS Document Type";
                    GenJournalLine."E3 UHID" := HISRevenueHeader."UHID";
                    GenJournalLine."E3 Patient Name" := HISRevenueHeader."Patient Name";
                    GenJournalLine."E3 Encounter No." := HISRevenueHeader."Encounter No.";
                    GenJournalLine."E3 Doctor Name" := HISRevenueHeader.Doctor;
                    GenJournalLine."E3 Speciality" := HISRevenueHeader."Speciality";
                    GenJournalLine."E3 Sponsor Code" := HISRevenueHeader."Sponsor Code";
                    GenJournalLine."E3 Sponsor Name" := HISRevenueHeader."Sponsor Name";
                    GenJournalLine."E3 Payer Code" := HISRevenueHeader."Payer Code";
                    GenJournalLine."E3 Payer Name" := HISRevenueHeader."Payer Name";
                    if IntegrationSetup."Rev./Rev.Cancel Direct Post" then
                        PostGenJnlLine.RunWithCheck(GenJournalLine)
                    else
                        GenJournalLine.INSERT();
                end;

                if AmountToCustomer <> 0 then begin
                    LineNo += 10000;
                    GenJournalLine.INIT();
                    GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name", IntegrationSetupLine."General Journal Template Code");
                    GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name", IntegrationSetupLine."General Journal Batch Code");
                    GenJournalLine."Line No." := LineNo;
                    IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::Revenue) AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::Invoice) THEN
                        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice)
                    ELSE
                        IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::"Revenue Cancel") AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::"Credit Memo") THEN
                            GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::"Credit Memo");

                    GenJournalLine.VALIDATE("Document No.", HISRevenueHeader."Document No.");
                    GenJournalLine.VALIDATE("Document Date", HISRevenueHeader."Document Date");
                    if HISRevenueHeader."Posting Date" <> 0D then
                        GenJournalLine.VALIDATE("Posting Date", HISRevenueHeader."Posting Date")
                    else
                        GenJournalLine.VALIDATE("Posting Date", HISRevenueHeader."Document Date");
                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
                    GenJournalLine.VALIDATE("Account No.", HISRevenueHeader."Customer No.");
                    GenJournalLine."Location Code" := HISRevenueHeader."Location Code";
                    GenJournalLine."Your Reference" := HISRevenueHeader."Reference Invoice No.";
                    IF (HISRevenueHeader."Record Type" = HISRevenueHeader."Record Type"::Revenue) AND (HISRevenueHeader."Document Type" = HISRevenueHeader."Document Type"::Invoice) THEN
                        GenJournalLine.VALIDATE(Amount, AmountToCustomer)
                    else
                        GenJournalLine.VALIDATE(Amount, -AmountToCustomer);
                    //GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::Customer);
                    //GenJournalLine.Validate("Bal. Account No.", HISRevenueHeader."Customer No.");
                    if HISRevenueHeader."Shortcut Dimension 1 Code" <> '' then begin
                        GenJournalLine.VALIDATE("Location Code", HISRevenueHeader."Shortcut Dimension 1 Code");
                        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", HISRevenueHeader."Shortcut Dimension 1 Code");
                    end;

                    if HISRevenueHeader."Shortcut Dimension 2 Code" <> '' then
                        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", GetMappedDimension(HISRevenueHeader."Shortcut Dimension 2 Code"));

                    GenJournalLine.VALIDATE("External Document No.", HISRevenueHeader."External Document No.");

                    GenJournalLine."E3 HIS Document Type" := HISRevenueHeader."HIS Document Type";
                    GenJournalLine."E3 UHID" := HISRevenueHeader."UHID";
                    GenJournalLine."E3 Patient Name" := HISRevenueHeader."Patient Name";
                    GenJournalLine."E3 Encounter No." := HISRevenueHeader."Encounter No.";
                    GenJournalLine."E3 Doctor Name" := HISRevenueHeader.Doctor;
                    GenJournalLine."E3 Speciality" := HISRevenueHeader."Speciality";
                    GenJournalLine."E3 Sponsor Code" := HISRevenueHeader."Sponsor Code";
                    GenJournalLine."E3 Sponsor Name" := HISRevenueHeader."Sponsor Name";
                    GenJournalLine."E3 Payer Code" := HISRevenueHeader."Payer Code";
                    GenJournalLine."E3 Payer Name" := HISRevenueHeader."Payer Name";
                    if IntegrationSetup."Rev./Rev.Cancel Direct Post" then
                        PostGenJnlLine.RunWithCheck(GenJournalLine)
                    else
                        GenJournalLine.INSERT();
                end;
            end;
            HISRevenueHeader."Create Revenue" := TRUE;
            if IntegrationSetup."Rev./Rev.Cancel Direct Post" then
                HISRevenueHeader."Posted Document No." := HISRevenueHeader."Document No.";
            HISRevenueHeader.MODIFY();
            Commit();
        END;
    end;

    procedure RevenueInvoiceValidation(var LocHISRevenueHeader: Record "E3 LIMS Revenue Header")
    var
        RevenueSetup: Record "E3 HIS GL Accounts Mapping";
        HISItemMapping: Record "E3 HIS Item Mapping";
        HISCustMapping: Record "E3 HIS Customer Mapping";
        Customer: Record Customer;
        txtHSNCode: Text[100];
        HSNSAC: Record "HSN/SAC";
        txtSalesAccount: Text[100];
        GSTGroup: Record "GST Group";
        GSTGroupCode: Code[20];
        LineCount: Integer;
    begin
        LineCount := 0;
        txtHSNCode := '';
        txtSalesAccount := '';
        txtHSNCode := '';
        GSTGroupCode := '';
        IntegrationSetup.Get();

        LocHISRevenueHeader."Error 1" := FALSE;
        LocHISRevenueHeader."Error 2" := FALSE;
        LocHISRevenueHeader."Error 3" := FALSE;
        LocHISRevenueHeader."Error 4" := FALSE;
        LocHISRevenueHeader."Error Description" := '';
        LocHISRevenueHeader.MODIFY();

        HISRevenueLine.RESET();
        HISRevenueLine.SetRange("Record Type", LocHISRevenueHeader."Record Type");
        HISRevenueLine.SetRange("Document Type", LocHISRevenueHeader."Document Type");
        HISRevenueLine.SETRANGE("Document No.", LocHISRevenueHeader."Document No.");
        HISRevenueLine.SetRange("Package Patient", false);  //Check if not required
        IF HISRevenueLine.FINDFIRST() THEN BEGIN
            REPEAT
                LineCount += 1;
                if IntegrationSetup."Revenue/Rev. Cancel Handling" = IntegrationSetup."Revenue/Rev. Cancel Handling"::"Via Invoices" then begin
                    IF HISRevenueLine."HSN Code" <> '' THEN begin
                        if HISRevenueLine."GST Group Code" = '' then
                            GSTGroupCode := 'Must not be Blank';

                        HSNSAC.RESET();
                        HSNSAC.SetRange("GST Group Code", HISRevenueLine."GST Group Code");
                        HSNSAC.SETRANGE(Code, HISRevenueLine."HSN Code");
                        IF NOT HSNSAC.FINDFIRST() THEN
                            txtHSNCode := 'Create New HSN Code'
                    END;

                    IF HISRevenueLine."GST Group Code" <> '' THEN BEGIN
                        if HISRevenueLine."HSN Code" = '' then
                            txtHSNCode := 'HSN Code must have value.';

                        GSTGroup.RESET();
                        GSTGroup.SETRANGE(GSTGroup.Code, HISRevenueLine."GST Group Code");
                        IF NOT GSTGroup.FINDFIRST() THEN
                            GSTGroupCode := 'Create New GST Group';
                    END;
                End;

                IF HISRevenueLine."Account No." = '' THEN begin
                    LocHISRevenueHeader.RESET();
                    LocHISRevenueHeader.SetRange("Record Type", HISRevenueLine."Record Type");
                    LocHISRevenueHeader.SetRange("Document Type", HISRevenueLine."Document Type");
                    LocHISRevenueHeader.SETRANGE("Document No.", HISRevenueLine."Document No.");
                    IF LocHISRevenueHeader.FINDFIRST() THEN begin
                        RevenueSetup.Reset();
                        RevenueSetup.SetRange("Service/Station Head", LocHISRevenueHeader."HIS Document Type");
                        RevenueSetup.SetRange("HIS Code", HISRevenueLine."Service Item Code");
                        RevenueSetup.SetRange(Package, HISRevenueLine."Package Patient");
                        if not RevenueSetup.FindFirst() then
                            txtSalesAccount := 'Revenue Account Missing'
                        else
                            if (RevenueSetup."Account No." <> '') and (RevenueSetup."Discount G/L Account" <> '') and (RevenueSetup."MOU Discount G/L Account" <> '') then begin
                                HISRevenueLine."Account Type" := RevenueSetup."Account Type";
                                HISRevenueLine."Account No." := RevenueSetup."Account No.";
                                HISRevenueLine."Discount G/L Account" := RevenueSetup."Discount G/L Account";
                                HISRevenueLine."MOU Discount G/L Account" := RevenueSetup."MOU Discount G/L Account";
                                if HISRevenueLine."Shortcut Dimension 1 Code" = '' then
                                    HISRevenueLine."Shortcut Dimension 1 Code" := LocHISRevenueHeader."Shortcut Dimension 1 Code";
                                HISRevenueLine.Modify(false);
                            end else
                                txtSalesAccount := 'Revenue or Discounts Account Missing';
                    end;
                end;
            UNTIL HISRevenueLine.NEXT() = 0;

            if LocHISRevenueHeader."No. of Lines" <> LineCount then
                LocHISRevenueHeader."Error Description" := 'Line count mismatch.';

            if LocHISRevenueHeader."Posting Date" = 0D then
                LocHISRevenueHeader."Posting Date" := LocHISRevenueHeader."Document Date";

            if LocHISRevenueHeader."Location Code" = '' then
                LocHISRevenueHeader."Location Code" := LocHISRevenueHeader."Shortcut Dimension 1 Code";

            if LocHISRevenueHeader."Customer No." = '' then begin
                HISCustMapping.Reset();
                HISCustMapping.SetRange("HIS Code", LocHISRevenueHeader."Payer Code");
                if HISCustMapping.FindFirst() then begin
                    Customer.Reset();
                    Customer.SetRange("No.", HISCustMapping."Customer No.");
                    if Customer.FindFirst() then begin
                        LocHISRevenueHeader."Customer No." := Customer."No.";
                        LocHISRevenueHeader."Customer Name" := Customer.Name;
                        LocHISRevenueHeader.Modify();
                    end else
                        LocHISRevenueHeader."Error Description" := 'Customer does not exists.';
                end else
                    LocHISRevenueHeader."Error Description" := 'Customer Mapping Missing';
            end;

            IF (LocHISRevenueHeader."Customer Name" = '') OR (txtHSNCode <> '') OR (txtSalesAccount <> '') OR (GSTGroupCode <> '') THEN
                LocHISRevenueHeader."Error Description" := 'Kindly Check Customer,HSN Code,GST Group Code';
            // ELSE
            //     HISRevenueHeader."Error Description" := '';

            LocHISRevenueHeader.MODIFY();
        end;

        HISRevenueLine.RESET();
        HISRevenueLine.SetRange("Record Type", LocHISRevenueHeader."Record Type");
        HISRevenueLine.SetRange("Document Type", LocHISRevenueHeader."Document Type");
        HISRevenueLine.SETRANGE("Document No.", LocHISRevenueHeader."Document No.");
        IF NOT HISRevenueLine.FINDFIRST() THEN begin
            LocHISRevenueHeader."Error Description" := 'Integration Line is Empty';
            LocHISRevenueHeader.MODIFY();
        end;

        IF (LocHISRevenueHeader."Customer Name" = '') THEN
            LocHISRevenueHeader."Error 1" := TRUE
        ELSE
            LocHISRevenueHeader."Error 1" := FALSE;
        IF (txtSalesAccount <> '') THEN
            LocHISRevenueHeader."Error 2" := TRUE
        ELSE
            LocHISRevenueHeader."Error 2" := FALSE;
        IF (txtHSNCode <> '') THEN
            LocHISRevenueHeader."Error 3" := TRUE
        ELSE
            LocHISRevenueHeader."Error 3" := FALSE;
        IF (GSTGroupCode <> '') THEN
            LocHISRevenueHeader."Error 4" := TRUE
        ELSE
            LocHISRevenueHeader."Error 4" := FALSE;
        LocHISRevenueHeader.MODIFY();
        Commit();
    end;


    Var
        IntegrationSetup: Record "E3 HIS Integartion Setup";
        IntegrationSetupLine: Record "E3 HIS Integration Setup Line";
        HISCollectionStaging: Record "E3 HIS Collection Staging";
        HISRevenueHeader: Record "E3 LIMS Revenue Header";
        HISRevenueLine: Record "E3 LIMS Revenue Line";



}