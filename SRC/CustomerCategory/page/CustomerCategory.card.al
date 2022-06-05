page 50101 "Customer Category Card PKT"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Customer Category PKT";
    Caption = 'Customer Category Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Default; Rec.Default)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(EnableNewsletter; Rec.EnableNewsletter)
                {
                    ApplicationArea = All;
                }
                field(FreeGiftAvailable; Rec.FreeGiftAvailable)
                {
                    ApplicationArea = All;
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
            }
            group(Statistics)
            {
                Caption = 'Statistics';
                field(TotaCustomersForCategory; Rec.TotaCustomersForCategory)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TotalSalesAmount; TotalSalesAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Total Sales Order Amount';
                    Editable = false;
                    Style = Strong;
                }
            }
        }

    }

    var
        TotalSalesAmount: Decimal;

    trigger OnAfterGetRecord()
    begin
        TotalSalesAmount := Rec.GetSalesAmount();
    end;
}