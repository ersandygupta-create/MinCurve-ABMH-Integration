codeunit 50003 "E3 Akhil Integration Mgmt."
{

    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        if not EDCAkhilSetup.Get() then
            exit;

        if not EDCAkhilSetup."Integration Enabled" then
            exit;

        case Rec."Parameter String" of
            'Supplier', 'supplier', 'SUPPLIER':
                if EDCAkhilSetup."Vendor Master API Enabled" then
                    SyncSupplier(Rec);
            'FailOverSupplier', 'failoversupplier', 'FAILOVERSUPPLIER':
                if EDCAkhilSetup."Vendor Master API Enabled" then
                    SupplierUpdateToHIS();
        end;
    end;

    var
        EDCAkhilSetup: Record "E3 Akhil Integration Setup";


    [NonDebuggable]
    local procedure GetAuthorizationText(): Text
    var
        Base64Converter: Codeunit "Base64 Convert";
        Authorization: Text;
        BasicCred: Text;
    begin
        EDCAkhilSetup.get();
        EDCAkhilSetup.TestField(Username);
        EDCAkhilSetup.TestField(Password);

        BasicCred := EDCAkhilSetup.Username + ':' + EDCAkhilSetup.Password;
        Authorization := 'Basic ' + Base64Converter.ToBase64(BasicCred); //, TextEncoding::UTF8);

        exit(Authorization);
    end;

    // [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterInsertEvent', '', false, false)]
    // local procedure EDCSupplierOnInsert(var Rec: Record Vendor; RunTrigger: Boolean)
    // var
    //     EDCSupplierLog: Record "E3 API Supplier Update Log";
    // begin
    //     if not EDCAkhilSetup.Get() then
    //         exit;

    //     if not EDCAkhilSetup."Integration Enabled" then
    //         exit;

    //     EDCSupplierLog.Init();
    //     EDCSupplierLog.TransferFields(Rec);
    //     EDCSupplierLog."Unique Log No." := 1;
    //     EDCSupplierLog."Entry Type" := EDCSupplierLog."Entry Type"::New;
    //     if not EDCSupplierLog.Insert() then
    //         EDCSupplierLog.Modify();

    //     //EnqueueVendorJobEntry(EDCSupplierLog);
    // end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterModifyEvent', '', false, false)]
    local procedure EDCSupplierOnModify(var xRec: Record Vendor; var Rec: Record Vendor; RunTrigger: Boolean)
    var
        EDCVendAddress: Record "Order Address";
        EDCSupplierLog: Record "E3 API Supplier Update Log";
        EDCVendBank: Record "Vendor Bank Account";
        EDCUpdateNeeded: Boolean;
        EDCUniqueID: Integer;
    begin
        if not EDCAkhilSetup.Get() then
            exit;

        if not EDCAkhilSetup."Integration Enabled" then
            exit;

        if not EDCAkhilSetup."Vendor Master API Enabled" then
            exit;

        EDCUpdateNeeded :=
          (Rec.Name <> xRec.Name) or
          (Rec."Name 2" <> xRec."Name 2") or
          (Rec."Phone No." <> xRec."Phone No.") or
          (Rec."Mobile Phone No." <> xRec."Mobile Phone No.") or
          (Rec."Fax No." <> xRec."Fax No.") or
          (Rec."E-Mail" <> xRec."E-Mail") or
          (Rec."P.A.N. No." <> xRec."P.A.N. No.") or
          (Rec."Vendor Posting Group" <> xRec."Vendor Posting Group") or
          (Rec."Payment Terms Code" <> xRec."Payment Terms Code") or
          (Rec."Preferred Bank Account Code" <> xRec."Preferred Bank Account Code") or
          (Rec."GST Vendor Type" <> xRec."GST Vendor Type") or
          (Rec."DL No." <> xRec."DL No.");

        if EDCUpdateNeeded then begin
            EDCVendAddress.Reset();
            EDCVendAddress.SetRange("Vendor No.", Rec."No.");
            if EDCVendAddress.FindSet() then
                repeat
                    CreateSupplierLog(EDCVendAddress);
                until EDCVendAddress.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Order Address", 'OnAfterModifyEvent', '', false, false)]
    local procedure EDCSupplierAddressOnModify(var xRec: Record "Order Address"; var Rec: Record "Order Address"; RunTrigger: Boolean)
    var

        EDCUpdateNeeded: Boolean;
    begin
        if not EDCAkhilSetup.Get() then
            exit;

        if not EDCAkhilSetup."Integration Enabled" then
            exit;

        if not EDCAkhilSetup."Vendor Master API Enabled" then
            exit;

        EDCUpdateNeeded :=
          (Rec.Name <> xRec.Name) or
          (Rec."Name 2" <> xRec."Name 2") or
          (Rec.Address <> xRec.Address) or
          (Rec."Address 2" <> xRec."Address 2") or
          (Rec.City <> xRec.City) or
          (Rec."Country/Region Code" <> xRec."Country/Region Code") or
          (Rec."Post Code" <> xRec."Post Code") or
          (Rec.State <> xRec.State) or
          (Rec."GST Registration No." <> xRec."GST Registration No.");

        if EDCUpdateNeeded then
            CreateSupplierLog(Rec);

    end;

    [EventSubscriber(ObjectType::Table, Database::"Vendor Bank Account", 'OnAfterModifyEvent', '', false, false)]
    local procedure EDCSupplierBankAccOnModify(var xRec: Record "Vendor Bank Account"; var Rec: Record "Vendor Bank Account"; RunTrigger: Boolean)
    var
        EDCVendAddress: Record "Order Address";
        EDCVend: Record Vendor;
        EDCVendBank: Record "Vendor Bank Account";
        EDCUpdateNeeded: Boolean;
    begin
        if not EDCAkhilSetup.Get() then
            exit;

        if not EDCAkhilSetup."Integration Enabled" then
            exit;

        if not EDCAkhilSetup."Vendor Master API Enabled" then
            exit;

        EDCVend.Get(Rec."Vendor No.");
        if EDCVend."Preferred Bank Account Code" <> Rec.Code then
            exit;

        EDCUpdateNeeded :=
          (Rec.Name <> xRec.Name) or
          (Rec.City <> xRec.City) or
          (Rec."Post Code" <> xRec."Post Code") or
          (Rec."Bank Account No." <> xRec."Bank Account No.") or
          (Rec."Bank Branch No." <> xRec."Bank Branch No.") or
          (Rec."E3 IFSC Code" <> xRec."E3 IFSC Code");

        if EDCUpdateNeeded then begin
            EDCVendAddress.Reset();
            EDCVendAddress.SetRange("Vendor No.", Rec."Vendor No.");
            if EDCVendAddress.FindSet() then
                repeat
                    CreateSupplierLog(EDCVendAddress);
                until EDCVendAddress.Next() = 0;
        end;
    end;

    procedure SupplierSyncAll(var VendRec: Record Vendor)
    var
        EDCSupplierLog: Record "E3 API Supplier Update Log";
        xEDCSupplierLog: Record "E3 API Supplier Update Log";
    begin
        CreateSupplierLog(VendRec);
        xEDCSupplierLog.SetRange("No.", VendRec."No.");
        xEDCSupplierLog.SetRange("Entry Type", xEDCSupplierLog."Entry Type"::Update);
        xEDCSupplierLog.SetRange("Sync Status", xEDCSupplierLog."Sync Status"::" ");
        if xEDCSupplierLog.FindFirst() then begin
            SendSupplierDetails(xEDCSupplierLog);
            EDCSupplierLog := xEDCSupplierLog;
            EDCSupplierLog.Modify(false);
        end;

    end;

    local procedure CreateSupplierLog(VendRec: Record Vendor)
    var
        EDCSupplierLog: Record "E3 API Supplier Update Log";
        xEDCSupplierLog: Record "E3 API Supplier Update Log";
        EDCVendBank: Record "Vendor Bank Account";
        EDCUniqueID: Integer;
    begin
        xEDCSupplierLog.SetRange("No.", VendRec."No.");
        xEDCSupplierLog.SetRange("Sync Status", xEDCSupplierLog."Sync Status"::" ");
        if xEDCSupplierLog.FindFirst() then begin
            EDCSupplierLog.TransferFields(VendRec);
            EDCSupplierLog."Unique Log No." := xEDCSupplierLog."Unique Log No.";
        end else begin
            EDCSupplierLog.SetRange("No.", VendRec."No.");
            if EDCSupplierLog.FindLast() then
                EDCUniqueID := EDCSupplierLog."Unique Log No." + 1
            else
                EDCUniqueID := 1;

            EDCSupplierLog.Init();
            EDCSupplierLog.TransferFields(VendRec);
            EDCSupplierLog."Unique Log No." := EDCUniqueID;
            EDCSupplierLog."Entry Type" := EDCSupplierLog."Entry Type"::Update;
            EDCSupplierLog.Insert();
        end;

        if VendRec."Preferred Bank Account Code" <> '' then begin
            EDCVendBank.get(VendRec."No.", VendRec."Preferred Bank Account Code");
            EDCSupplierLog.BankAccountNo := EDCVendBank."Bank Account No.";
            EDCSupplierLog.BankAccountName := EDCVendBank.Name;
            EDCSupplierLog.BankBranchNo := EDCVendBank."Bank Branch No.";
            EDCSupplierLog.BankCity := EDCVendBank.City;
            EDCSupplierLog.BankPostCode := EDCVendBank."Post Code";
            EDCSupplierLog.IFSCCode := EDCVendBank."E3 IFSC Code";
        end else begin
            EDCSupplierLog.BankAccountNo := '';
            EDCSupplierLog.BankAccountName := '';
            EDCSupplierLog.BankBranchNo := '';
            EDCSupplierLog.BankCity := '';
            EDCSupplierLog.BankPostCode := '';
            EDCSupplierLog.IFSCCode := '';
        end;
        EDCSupplierLog.Modify(false);

        //EnqueueVendorJobEntry(EDCSupplierLog);
    end;

    local procedure CreateSupplierLog(VendAddRec: Record "Order Address")
    var
        EDCSupplierLog: Record "E3 API Supplier Update Log";
        xEDCSupplierLog: Record "E3 API Supplier Update Log";
        TempVendRec: Record Vendor temporary;
        VendRec: Record Vendor;
        EDCVendBank: Record "Vendor Bank Account";
        EDCUniqueID: Integer;
    begin
        VendRec.get(VendAddRec."Vendor No.");

        TempVendRec.DeleteAll();
        TempVendRec.Init();
        TempVendRec := VendRec;
        TempVendRec.Insert(false);
        TempVendRec.Address := VendAddRec.Address;
        TempVendRec."Address 2" := VendAddRec."Address 2";
        TempVendRec.City := VendAddRec.City;
        TempVendRec."Post Code" := VendAddRec."Post Code";
        TempVendRec."Country/Region Code" := VendAddRec."Country/Region Code";
        TempVendRec."State Code" := VendAddRec.State;
        TempVendRec."GST Registration No." := VendAddRec."GST Registration No.";
        TempVendRec.Modify(false);

        xEDCSupplierLog.SetRange("No.", VendRec."No.");
        xEDCSupplierLog.SetRange("Address Code", VendAddRec."Code");
        xEDCSupplierLog.SetRange("Sync Status", xEDCSupplierLog."Sync Status"::" ");
        if xEDCSupplierLog.FindFirst() then begin
            EDCSupplierLog.TransferFields(TempVendRec);
            EDCSupplierLog."Unique Log No." := xEDCSupplierLog."Unique Log No.";
            EDCSupplierLog."Address Code" := VendAddRec."Code";
            EDCSupplierLog."Address Name" := VendAddRec.Name;
        end else begin
            EDCSupplierLog.SetRange("No.", VendRec."No.");
            if EDCSupplierLog.FindLast() then
                EDCUniqueID := EDCSupplierLog."Unique Log No." + 1
            else
                EDCUniqueID := 1;

            EDCSupplierLog.Init();
            EDCSupplierLog.TransferFields(TempVendRec);
            EDCSupplierLog."Unique Log No." := EDCUniqueID;
            EDCSupplierLog."Entry Type" := EDCSupplierLog."Entry Type"::Update;
            EDCSupplierLog."Address Code" := VendAddRec."Code";
            EDCSupplierLog."Address Name" := VendAddRec.Name;
            EDCSupplierLog.Insert();
        end;

        if VendRec."Preferred Bank Account Code" <> '' then begin
            EDCVendBank.get(VendRec."No.", VendRec."Preferred Bank Account Code");
            EDCSupplierLog.BankAccountNo := EDCVendBank."Bank Account No.";
            EDCSupplierLog.BankAccountName := EDCVendBank.Name;
            EDCSupplierLog.BankBranchNo := EDCVendBank."Bank Branch No.";
            EDCSupplierLog.BankCity := EDCVendBank.City;
            EDCSupplierLog.BankPostCode := EDCVendBank."Post Code";
            EDCSupplierLog.IFSCCode := EDCVendBank."E3 IFSC Code";
        end else begin
            EDCSupplierLog.BankAccountNo := '';
            EDCSupplierLog.BankAccountName := '';
            EDCSupplierLog.BankBranchNo := '';
            EDCSupplierLog.BankCity := '';
            EDCSupplierLog.BankPostCode := '';
            EDCSupplierLog.IFSCCode := '';
        end;
        EDCSupplierLog.Modify(false);

        //EnqueueVendorJobEntry(EDCSupplierLog);
    end;

    procedure EnqueueVendorJobEntry(APIVendorUpdateLog: Record "E3 API Supplier Update Log"): Guid
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobDesLbl: Label 'Vendor %1 - Update %2 ', Locked = true;
    begin
        Clear(JobQueueEntry.ID);
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := CODEUNIT::"E3 Akhil Integration Mgmt.";
        JobQueueEntry."Parameter String" := 'SUPPLIER';
        JobQueueEntry."Record ID to Process" := APIVendorUpdateLog.RecordId;
        JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime + 30000;
        JobQueueEntry."Notify On Success" := true;
        JobQueueEntry."Job Queue Category Code" := '';
        JobQueueEntry.Description := StrSubstNo(JobDesLbl, APIVendorUpdateLog."No.", Format(APIVendorUpdateLog."Unique Log No."));
        JobQueueEntry."User Session ID" := SessionId();
        CODEUNIT.Run(CODEUNIT::"Job Queue - Enqueue", JobQueueEntry);
        exit(JobQueueEntry.ID)
    end;

    local procedure SyncSupplier(var JobQueueEntry: Record "Job Queue Entry")
    var
        EDCSupplierLog: Record "E3 API Supplier Update Log";
        RecRef: RecordRef;
        SavedLockTimeout: Boolean;
    begin
        JobQueueEntry.TestField("Record ID to Process");
        RecRef.Get(JobQueueEntry."Record ID to Process");
        RecRef.SetTable(EDCSupplierLog);
        EDCSupplierLog.Find;

        if EDCSupplierLog."Sync Status" <> EDCSupplierLog."Sync Status"::" " then
            exit;

        SavedLockTimeout := LockTimeout;
        if not SendSupplierDetails(EDCSupplierLog) then
            Error(GetLastErrorText())
        else
            EDCSupplierLog.Modify(false);
        LockTimeout(SavedLockTimeout);
    end;

    local procedure SupplierUpdateToHIS()
    var
        SupplierUpdateLog: Record "E3 API Supplier Update Log";
        xSupplierUpdateLog: Record "E3 API Supplier Update Log";
    begin
        if not EDCAkhilSetup."Vendor Master API Enabled" then
            exit;

        xSupplierUpdateLog.Reset();
        xSupplierUpdateLog.SetRange("Sync Status", xSupplierUpdateLog."Sync Status"::" ");
        if xSupplierUpdateLog.FindSet() then
            repeat
                if SendSupplierDetails(xSupplierUpdateLog) then begin
                    SupplierUpdateLog := xSupplierUpdateLog;
                    SupplierUpdateLog.Modify(false);
                end;
            until xSupplierUpdateLog.Next() = 0;
    end;

    procedure SendSupplierDetails(var SupplierUpdateLog: Record "E3 API Supplier Update Log"): Boolean
    var
        HttpWebClient: HttpClient;
        HttpWebContent: HttpContent;
        ContentHeaders: HttpHeaders;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        J: Integer;
        JArray: JsonArray;
        JChildObj: JsonObject;
        JObject: JsonObject;
        CJToken: JsonToken;
        JToken: JsonToken;
        ConnectionMsg: Label 'The web service returned an error message:\\Status code: %1\Description: %2';
        Authoriztion: Text;
        IsSuccess: Text;
        JsonResponse: Text;
        ReqPayload: Text;
    begin
        EDCAkhilSetup.Get();
        if not EDCAkhilSetup."Integration Enabled" then
            exit;

        if not EDCAkhilSetup."Vendor Master API Enabled" then
            exit;

        EDCAkhilSetup.TestField("Vendor Master API");

        Clear(JObject);
        Clear(JChildObj);
        Clear(JArray);

        JChildObj.Add('UniqueID', SupplierUpdateLog."Unique Log No.");
        JChildObj.Add('FacilityMappingCode', 'VEN');
        JChildObj.Add('SupplierCode', SupplierUpdateLog."No.");
        JChildObj.Add('SupplierName', SupplierUpdateLog.Name);
        JChildObj.Add('SupplierName2', SupplierUpdateLog."Name 2");
        JChildObj.Add('AddressCode', SupplierUpdateLog."Address Code");
        JChildObj.Add('AddressName', SupplierUpdateLog."Address Name");
        JChildObj.Add('SupplierAddress1', SupplierUpdateLog.Address);
        JChildObj.Add('SupplierAddress2', SupplierUpdateLog."Address 2");
        JChildObj.Add('SupplierAddress3', '');
        JChildObj.Add('City', SupplierUpdateLog.City);
        JChildObj.Add('State', SupplierUpdateLog."State Code");
        JChildObj.Add('Country', SupplierUpdateLog."Country/Region Code");
        JChildObj.Add('ZipID', SupplierUpdateLog."Post Code");
        JChildObj.Add('Phone', SupplierUpdateLog."Phone No.");
        JChildObj.Add('Mobile', SupplierUpdateLog."Mobile Phone No.");
        JChildObj.Add('Email', SupplierUpdateLog."E-Mail");
        JChildObj.Add('Fax', SupplierUpdateLog."Fax No.");
        //JChildObj.Add('IsSupplierInterState', '');
        JChildObj.Add('StateCode', SupplierUpdateLog."State Code");
        JChildObj.Add('DLNO', SupplierUpdateLog."DL No.");
        JChildObj.Add('PanNo', SupplierUpdateLog."P.A.N. No.");
        JChildObj.Add('SaleTaxNo', SupplierUpdateLog."Tax Code");
        JChildObj.Add('GSTIN', SupplierUpdateLog."GST Registration No.");
        JChildObj.Add('VendorPostingGroup', SupplierUpdateLog."Vendor Posting Group");
        JChildObj.Add('PaymentTermsCode', SupplierUpdateLog."Payment Terms Code");
        JChildObj.Add('GSTVendorType', format(SupplierUpdateLog."GST Vendor Type"));
        JChildObj.Add('BankAccountNo', SupplierUpdateLog.BankAccountNo);
        JChildObj.Add('BankAccountName', SupplierUpdateLog.BankAccountName);
        JChildObj.Add('BankBranchNo', SupplierUpdateLog.BankBranchNo);
        JChildObj.Add('IFSCCode', SupplierUpdateLog.IFSCCode);
        JChildObj.Add('BankPostCode', SupplierUpdateLog.BankPostCode);
        JChildObj.Add('BankCity', SupplierUpdateLog.BankCity);
        JChildObj.Add('ProcessIndicator', 'R');
        JChildObj.Add('CreationDate', format(DT2Date(SupplierUpdateLog."Last Modified Date Time"), 0, '<Day,2>-<Month,2>-<Year4>'));
        JChildObj.Add('CreationTime', format(DT2Time(SupplierUpdateLog."Last Modified Date Time")));
        JChildObj.Add('ErrorMsg', '');
        JArray.Add(JChildObj);
        JObject.Add('SupplierMaster', JArray);

        JObject.WriteTo(ReqPayload);

        if GuiAllowed then
            Message(ReqPayload);

        HttpWebContent.WriteFrom(ReqPayload);
        HttpWebContent.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');
        HttpWebClient.DefaultRequestHeaders().Add('Authorization', GetAuthorizationText());
        RequestMessage.Content := HttpWebContent;
        RequestMessage.SetRequestUri(EDCAkhilSetup."Vendor Master API");
        RequestMessage.Method := 'POST';
        HttpWebClient.Send(RequestMessage, ResponseMessage);

        if not ResponseMessage.IsSuccessStatusCode then begin
            SupplierUpdateLog."Sync Status" := SupplierUpdateLog."Sync Status"::Error;
            SupplierUpdateLog."Error Message" := CopyStr(ResponseMessage.ReasonPhrase, 1, 250);
            // error(ConnectionMsg,
            //       ResponseMessage.HttpStatusCode,
            //       ResponseMessage.ReasonPhrase);
        end else begin
            HttpWebContent := ResponseMessage.Content;
            HttpWebContent.ReadAs(JsonResponse);

            if GuiAllowed then
                Message(JsonResponse);

            Clear(JObject);
            JObject.ReadFrom(JsonResponse);
            if JObject.SelectToken('SupplierMasterStatus', JToken) then
                if JToken.IsArray then
                    JToken.AsArray().WriteTo(JsonResponse)
                else
                    JsonResponse := JToken.AsValue().AsText();

            Clear(JArray);
            Clear(JObject);
            Clear(JToken);
            JArray.ReadFrom(JsonResponse);
            for J := 0 to JArray.Count - 1 do begin
                JArray.Get(J, JToken);

                JObject := JToken.AsObject();
                IF JObject.SelectToken('ErrorMsg', CJToken) then
                    IsSuccess := CJToken.AsValue().AsText();

                if IsSuccess = 'Supplier Created Successfully' then begin
                    SupplierUpdateLog."Sync Status" := SupplierUpdateLog."Sync Status"::Synced;
                    exit(true);
                end;
            end;
        end;

        exit(false);
    end;
}
