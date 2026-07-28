pageextension 50078 "E3 Payment Journal" extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Void &All Checks")
        {
            action("Axis Print Check")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Multiple Vendor Check Print A';
                Image = Report;
                RunObject = report "Axis Bank Check_M";
                RunPageMode = Edit;
            }
            action("Check Print Check")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Check Print H';
                Image = Report;
                RunObject = report "Bank Check H";
                RunPageMode = Edit;
            }
        }
        addafter("Test Report")
        {
            action("Bank Payment NotePad")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Payment NotePad';
                Image = XmlPort;
                //RunObject = xmlport "3E Bank Payment Notepad";
                RunPageMode = Edit;
            }
        }
    }
}