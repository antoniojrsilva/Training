/// <summary>
/// Page Packt Extension Setup (ID 50102).
/// </summary>
page 50102 "Packt Extension Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Packt Extension Setup";
    Caption = 'Packt Extension Setup';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Minimun Accepted Vendor Rate"; Rec."Minimun Accepted Vendor Rate")
                {
                    ApplicationArea = All;
                }
                field("Gift Tolerance Qty"; Rec."Gift Tolerance Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}