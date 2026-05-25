report 50019 "Employee Ledger"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rpt50019.EmployeeLedger.rdlc';
    Caption = 'Employee Ledger';
    ApplicationArea = aLL;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";
            column(Rp_Date; Rp_Date)
            {
            }
            column(CmpName; CmpInfo.Name)
            {
            }
            column(CmpAddr; CmpInfo.Address)
            {
            }
            column(CmpAddr2; CmpInfo."Address 2")
            {
            }
            column(CmpCity; CmpInfo.City + ' ' + CmpInfo."Post Code")
            {
            }
            column(CmpPhone; CmpInfo."Phone No.")
            {
            }
            column(CmpPhone2; CmpInfo."Phone No. 2")
            {
            }
            column(CmpMail; CmpInfo."E-Mail")
            {
            }
            column(CmpPostCode; CmpInfo."Post Code")
            {
            }
            column(CmpCountry; CmpInfo.County)
            {
            }
            column(CmpTinNo; CmpInfo."GST Registration No.")
            {
            }
            column(GSINCmp; CmpInfo."P.A.N. No.")
            {

            }

            column(CmpPicture; CmpInfo.Picture)
            {
            }
            column(Cust_No; "No.")
            {
            }
            column(Cust_Name; Employee.FullName())
            {
            }
            column(Cust_Addr; Address)
            {
            }
            column(Cust_Addr2; "Address 2")
            {
            }

            column(Cust_Addr3; '')
            {
            }
            column(Cust_City; City)
            {
            }
            column(Cust_Post_Code; Employee."Post Code")
            {
            }
            column(Cust_Country; County)
            {
            }
            column(Cust_Contact; Employee."Mobile Phone No.")
            {
            }
            column(Cust_Phone; "Phone No.")
            {
            }
            column(Cust_Mob2; '')
            {
            }
            column(Cust_Email; "E-Mail")
            {
            }

            column(CustOpAmt; CustOpAmt)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(Naration_H; Naration_H)
            {
            }
            dataitem("Employee Ledger Entry"; "Employee Ledger Entry")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", "Posting Date", "Currency Code")
                                    ORDER(Ascending);
                column(LedEntryNo; "Entry No.")
                {
                }
                column(PostingDate_EmployeeLedgerEntry; "Employee Ledger Entry"."Posting Date")
                {
                }
                column(ExternalDocumentNo_EmployeeLedgerEntry; "Employee Ledger Entry"."Document No.")
                {
                }
                column(Posting_Date; FORMAT("Posting Date"))
                {
                }
                column(Doct_Type; DoctType)
                {
                }
                column(Doct_No; "Document No.")
                {
                }
                column(Doct_Desc; Description)
                {
                }
                column(UserIdCrBy; "User ID")
                {
                }
                column(DueDate; FORMAT("Posting Date"))
                {
                }
                column(Amount; Amount)
                {
                }
                column(RunningAmt; RunningAmt)
                {
                }
                column(DrAmt; DrAmt)
                {
                }
                column(CrAmt; CrAmt)
                {
                }
                column(AmtToWords; NoText[1])
                {
                }
                column(NarrarionTeXt; NarrarionTeXt)
                {
                }
                column(CheckNo; CheckNo_Rec)
                {
                }
                column(CheckDate; FORMAT(CheckDate_Rec))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DrAmt := 0;
                    CrAmt := 0;



                    TDSAmnt[1] := 0;
                    TDSAmnt[2] := 0;
                    TDSAmnt[3] := 0;
                    TDSAmnt[4] := 0;
                    TDSAmnt[5] := 0;
                    /*TDSEntry_Rec.RESET;
                    TDSEntry_Rec.SETRANGE("Document No.","Employee Ledger Entry"."Document No.");
                    IF TDSEntry_Rec.FINDFIRST THEN REPEAT
                      Int +=1;
                      TDSAmnt[Int] := TDSEntry_Rec."TDS Amount Including Surcharge";
                      TDSText[Int] := TDSEntry_Rec."TDS Nature of Deduction";
                    UNTIL TDSEntry_Rec.NEXT=0;
                    */
                    /*TDSEntry_Rec.RESET;
                    TDSEntry_Rec.SETRANGE("Document No.","Employee Ledger Entry"."Document No.");
                    TDSEntry_Rec.SETRANGE("TDS Nature of Deduction",'CONT');
                    IF TDSEntry_Rec.FINDFIRST THEN BEGIN
                     TDSAmnt[1] := TDSEntry_Rec."TDS Amount Including Surcharge";
                     TDSText[1] := TDSEntry_Rec."TDS Nature of Deduction";
                    END;
                    TDSEntry_Rec.RESET;
                    TDSEntry_Rec.SETRANGE("Document No.","Employee Ledger Entry"."Document No.");
                    TDSEntry_Rec.SETRANGE("TDS Nature of Deduction",'RENT');
                    IF TDSEntry_Rec.FINDFIRST THEN BEGIN
                     TDSAmnt[2] := TDSEntry_Rec."TDS Amount Including Surcharge";
                     TDSText[2] := TDSEntry_Rec."TDS Nature of Deduction";
                    END;
                    TDSEntry_Rec.RESET;
                    TDSEntry_Rec.SETRANGE("Document No.","Employee Ledger Entry"."Document No.");
                    TDSEntry_Rec.SETRANGE("TDS Nature of Deduction",'PROF');
                    IF TDSEntry_Rec.FINDFIRST THEN BEGIN
                     TDSAmnt[3] := TDSEntry_Rec."TDS Amount Including Surcharge";
                     TDSText[3] := TDSEntry_Rec."TDS Nature of Deduction";
                    END;
                    TDSEntry_Rec.RESET;
                    TDSEntry_Rec.SETRANGE("Document No.","Employee Ledger Entry"."Document No.");
                    TDSEntry_Rec.SETRANGE("TDS Nature of Deduction",'COM');
                    IF TDSEntry_Rec.FINDFIRST THEN BEGIN
                     TDSAmnt[4] := TDSEntry_Rec."TDS Amount Including Surcharge";
                     TDSText[4] := TDSEntry_Rec."TDS Nature of Deduction";
                    END;
                    TDSEntry_Rec.RESET;
                    TDSEntry_Rec.SETRANGE("Document No.","Employee Ledger Entry"."Document No.");
                    TDSEntry_Rec.SETRANGE("TDS Nature of Deduction",'TECHNICAL');
                    IF TDSEntry_Rec.FINDFIRST THEN BEGIN
                     TDSAmnt[5] := TDSEntry_Rec."TDS Amount Including Surcharge";
                     TDSText[5] := TDSEntry_Rec."TDS Nature of Deduction";
                    END;
                    */
                    IF Amount >= 0 THEN
                        DrAmt := Amount
                    ELSE
                        CrAmt := Amount;


                    RunningAmt := RunningAmt + DrAmt + CrAmt;

                    DoctType := FORMAT("Employee Ledger Entry"."Document Type");



                    CheckNo_Rec := '';
                    CheckDate_Rec := 0D;
                    CheckLedgerEntry.RESET;
                    CheckLedgerEntry.SETRANGE("Document No.", "Employee Ledger Entry"."Document No.");
                    IF CheckLedgerEntry.FINDFIRST THEN BEGIN
                        CheckNo_Rec := CheckLedgerEntry."Cheque No.";
                        CheckDate_Rec := CheckLedgerEntry."Cheque Date";
                    END;

                    NarrarionTeXt := '';
                    GLEntries.Reset();
                    GLEntries.SetRange("Document Type", "Employee Ledger Entry"."Document Type");
                    GLEntries.SetRange("Document No.", "Employee Ledger Entry"."Document No.");
                    GLEntries.SetRange("Source Type", GLEntries."Source Type"::Employee);
                    GLEntries.SetRange("Source No.", "Employee Ledger Entry"."Employee No.");
                    IF GLEntries.FindFirst() then begin
                        repeat
                            NarrarionTeXt := GLEntries."E3 Narration";
                        until GLEntries.Next() = 0;
                    end;

                    PostedNarration.Reset();
                    PostedNarration.SetRange("Document Type", "Employee Ledger Entry"."Document Type");
                    PostedNarration.SetRange("Document No.", "Employee Ledger Entry"."Document No.");
                    IF PostedNarration.FindFirst() then begin
                        repeat
                            if NarrarionTeXt = '' then
                                NarrarionTeXt := PostedNarration.Narration
                            else
                                NarrarionTeXt += ' ' + PostedNarration.Narration
                        until PostedNarration.Next() = 0;
                    end;


                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", StartDate, EndDate);
                    RunningAmt := CustOpAmt;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CustOpAmt := 0;
                RunningAmt := 0;
                DetCustLedEnt12.RESET;
                DetCustLedEnt12.SETRANGE(DetCustLedEnt12."Employee No.", "No.");
                DetCustLedEnt12.SETRANGE(DetCustLedEnt12."Posting Date", 0D, StartDate - 1);
                if DetCustLedEnt12.FindFirst() then begin
                    DetCustLedEnt12.CalcFields(Amount);
                    CustOpAmt += DetCustLedEnt12.Amount;

                end;
                TotalAmount := 0;
                DetCustLedEnt.RESET;
                DetCustLedEnt.SETRANGE(DetCustLedEnt."Employee No.", Employee."No.");
                DetCustLedEnt.SETRANGE(DetCustLedEnt."Posting Date", StartDate, EndDate);
                if DetCustLedEnt.FindFirst() then begin
                    DetCustLedEnt.CalcFields(Amount);
                    TotalAmount += DetCustLedEnt.Amount;
                end;

                if TotalAmount = 0 then
                    CurrReport.Skip();



            end;

            trigger OnPreDataItem()
            begin
                IF VendNo <> '' THEN
                    SETRANGE("No.", VendNo);
                CmpInfo.GET;
                CmpInfo.CALCFIELDS(Picture);
                IF Location.GET('Loc02') THEN;
                IF StartDate <> 0D THEN
                    Rp_Date := 'Date ' + FORMAT(StartDate) + ' to ' + FORMAT(EndDate);
                IF Rp_Date = '' THEN
                    Rp_Date := 'Date ' + FORMAT(WORKDATE);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(Employee; VendNo)
                {
                    TableRelation = Employee;
                    ApplicationArea = all;
                }
                field("Start Date"; StartDate)
                {
                    ApplicationArea = all;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = all;
                }
                field(Naration_H; Naration_H)
                {
                    Caption = 'Narration';
                    Visible = false;
                    ApplicationArea = all;

                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        StartDate: Date;
        EndDate: Date;
        DetCustLedEnt: Record "Employee Ledger Entry";
        CustOpAmt: Decimal;
        RunningAmt: Decimal;
        CmpInfo: Record "Company Information";
        VendNo: Code[20];
        DrAmt: Decimal;
        CrAmt: Decimal;
        DoctType: Text;
        NoText: array[2] of Text;
        Currency: Record Currency;
        NarrarionTeXt: Text;
        Location: Record Location;
        TDSAmnt: array[10] of Decimal;
        TDSText: array[10] of Text;
        DetCustLedEnt12: Record "Employee Ledger Entry";
        TDSEntry_Rec: Record "TDS Entry";
        Int: Integer;
        TotalAmount: Decimal;
        GLEntries: Record "G/L Entry";
        Naration_H: Boolean;
        Rp_Date: Text;
        CheckLedgerEntry: Record "Bank Account Ledger Entry";
        CheckNo_Rec: Code[10];
        CheckDate_Rec: Date;
        PostedNarration: Record "Posted Narration";
        RecCompanyName: Code[100];

    procedure SetData(StartDate1: Date; EndDate1: Date; CustomerNo1: Text)
    begin
        StartDate := StartDate1;
        EndDate := EndDate1;
        VendNo := CustomerNo1;
    end;
}

