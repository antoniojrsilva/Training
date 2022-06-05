table 50104 "Gift Campaign"
{
    DataClassification = CustomerContent;
    LookupPageId = "Gift Campaign List PKT";
    DrillDownPageId = "Gift Campaign List PKT";
    Caption = 'Gift Campaign';

    fields
    {
        field(1; "Customer Category PKT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Category';
            TableRelation = "Customer Category PKT".No where(Blocked = const(false), FreeGiftAvailable = const(true));

            trigger OnValidate()
            var
                CustomerCategory: Record "Customer Category PKT";
                lblBlocked: Label 'This Category is Blocked';
                lblNoGifts: Label 'This Category is not enable for Gift Campaigns';
            begin
                If CustomerCategory.Get("Customer Category PKT") then begin
                    if CustomerCategory.Blocked then
                        Message(lblBlocked);
                    if not CustomerCategory.FreeGiftAvailable then
                        Message(lblNoGifts);
                end;
            end;
        }
        field(2; Item; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item';
            TableRelation = Item."No.";
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';

            trigger OnValidate()
            var
                lblStartDateInvalid: Label 'The Start Date is greather than End Date';
            begin
                if "End Date" <> 0D then
                    if "Start Date" > "End Date" then
                        Error(lblStartDateInvalid);
            end;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';

            trigger OnValidate()
            var
                lblEndDateInvalid: Label 'The End Date must be greather than Start Date';
            begin
                if "Start Date" <> 0D then
                    if "Start Date" > "End Date" then
                        Error(lblEndDateInvalid);
            end;
        }
        field(5; "Min Qty Ordered"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum Quantity Ordered';
        }
        field(6; "Gift Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Gift Quantity';
        }
        field(7; Inactive; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inactive';
        }
    }

    keys
    {
        key(PK; "Customer Category PKT", Item, "Start Date", "End Date")
        {
            Clustered = true;
        }
    }
}