page 50103 "Gift Campaign List PKT"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Gift Campaign";
    Caption = 'Gift Campaigns';
    AdditionalSearchTerms = 'promotions, marketing';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Customer Category PKT"; Rec."Customer Category PKT")
                {
                    ApplicationArea = All;
                }
                field(Item; Rec.Item)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Min Qty Ordered"; Rec."Min Qty Ordered")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Gift Quantity"; Rec."Gift Quantity")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field(Inactive; Rec.Inactive)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    views
    {
        view(ActiveCampaigns)
        {
            Caption = 'Active Gift Campaigns';
            Filters = where(Inactive = const(false));
        }
        view(InactiveCampaigns)
        {
            Caption = 'Inactive Gift Campaigns';
            Filters = where(Inactive = const(true));
        }
    }
}