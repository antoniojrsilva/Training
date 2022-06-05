/// <summary>
/// Page Customer Category List PKT (ID 50100).
/// </summary>
page 50100 "Customer Category List PKT"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Customer Category PKT";
    Caption = 'Customer Category List';
    CardPageId = "Customer Category Card PKT";
    AdditionalSearchTerms = 'ranking, categorization';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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
                }
                field(TotaCustomersForCategory; Rec.TotaCustomersForCategory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Total Customers for Category';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Default Category")
            {
                ApplicationArea = All;
                Image = CreateForm;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Create default category';
                Caption = 'Create default category';

                trigger OnAction();
                var
                    CustManagment: Codeunit "Customer Category Mgt PKT";
                begin
                    CustManagment.CreateDefaultCategory();
                end;
            }
        }
    }
}