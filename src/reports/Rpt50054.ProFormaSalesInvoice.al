report 50054 "E3 Pro Forma Sales Invoice"
{
    Caption = 'Pro Forma Sales Invoice';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Rpt50054.ProFormaSalesInvoice.rdl';

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = where("Document Type" = const(Invoice));
            RequestFilterFields = "No.";

            column(DocumentNo; "No.") { }
            column(DocumentDate; "Document Date") { }
            column(PostingDate; "Posting Date") { }
            column(ExternalDocumentNo; "External Document No.") { }

            column(SellToCustomerNo; "Sell-to Customer No.") { }
            column(SellToCustomerName; "Sell-to Customer Name") { }
            column(SellToCustomerName2; "Sell-to Customer Name 2") { }
            column(SellToAddress; "Sell-to Address") { }
            column(SellToAddress2; "Sell-to Address 2") { }
            column(SellToCity; "Sell-to City") { }
            column(SellToPostCode; "Sell-to Post Code") { }
            column(SellToState; "Sell-to County") { }
            column(Sell_to_E_Mail; "Sell-to E-Mail") { }
            column(Sell_to_Phone_No_; "Sell-to Phone No.") { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(SellCustomer_GST_Reg__No_; "Customer GST Reg. No.") { }

            column(BillToName; "Bill-to Name") { }
            column(BillToAddress; "Bill-to Address") { }
            column(BillToAddress2; "Bill-to Address 2") { }
            column(BillToCity; "Bill-to City") { }

            column(LocationCode; "Location Code") { }
            column(PaymentTermsCode; "Payment Terms Code") { }
            column(ShipmentMethodCode; "Shipment Method Code") { }

            column(CurrencyCode; "Currency Code") { }

            column(CompanyName; CompanyInfo.Name) { }
            column(CompPicture; CompanyInfo.Picture) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyAddress2; CompanyInfo."Address 2") { }
            column(CompanyCity; CompanyInfo.City) { }
            column(CompanyPostCode; CompanyInfo."Post Code") { }
            column(CompanyPhone; CompanyInfo."Phone No.") { }
            column(CompanyEmail; CompanyInfo."E-Mail") { }
            column(CompanyGST; CompanyInfo."GST Registration No.") { }

            column(TotalAmount; TotalAmount) { }
            column(TotalGST; TotalGST) { }
            column(GrandTotal; GrandTotal) { }

            dataitem(SalesLine; "Sales Line")
            {
                DataItemLink =
                    "Document Type" = field("Document Type"),
                    "Document No." = field("No.");

                DataItemTableView = sorting("Document Type", "Document No.", "Line No.")
                                    where(Type = filter(<> " "));

                column(LineNo; "Line No.") { }
                column(Type; Type) { }
                column(No; "No.") { }
                column(Description; Description) { }
                column(Description2; "Description 2") { }
                column(UnitofMeasure; "Unit of Measure") { }
                column(Quantity; Quantity) { }
                column(UnitPrice; "Unit Price") { }
                column(LineDiscount; "Line Discount %") { }
                column(LineAmount; "Line Amount") { }
                column(Amount; Amount) { }
                column(AmountIncludingVAT; "Amount Including VAT") { }
                column(VATPercent; "VAT %") { }
                column(CGSTAmount; CGSTAmount) { }
                column(SGSTAmount; SGSTAmount) { }
                column(IGSTAmount; IGSTAmount) { }
                column(CessAmount; CessAmount) { }

                trigger OnAfterGetRecord()
                begin
                    TotalAmount += Amount;
                    TotalGST += "Amount Including VAT" - Amount;
                    GrandTotal += "Amount Including VAT";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Clear(TotalAmount);
                Clear(TotalGST);
                Clear(GrandTotal);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        TotalAmount: Decimal;
        TotalGST: Decimal;
        GrandTotal: Decimal;
        CGSTAmount: Decimal;
        SGSTAmount: Decimal;
        IGSTAmount: Decimal;
        CessAmount: Decimal;
}