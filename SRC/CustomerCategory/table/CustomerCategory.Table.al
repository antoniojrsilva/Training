/// <summary>
/// Table Customer Category PKT (ID 50100).
/// </summary>
table 50100 "Customer Category PKT"
{
    DataClassification = CustomerContent;
    Caption = 'Customer Category';

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; Default; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Default';
        }
        field(4; EnableNewsletter; Enum NewsletterType)
        {
            DataClassification = CustomerContent;
            Caption = 'Enable Newsletter';
        }
        field(5; FreeGiftAvailable; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Free Gifts Available';
        }
        field(6; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
        }
        field(10; TotaCustomersForCategory; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Customer Category Code PKT" = field(No)));
            Caption = 'No. of associated customers';
        }
    }
    //NOTE: 
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
        key(K2; Description)
        {
            Unique = true;
        }
    }

    procedure GetSalesAmount(): Decimal
    var
        CustomerCategoryMgt: Codeunit "Customer Category Mgt PKT";
    begin
        exit(CustomerCategoryMgt.GetSalesAmount(Rec.No))
    end;
}

enum 50100 NewsletterType
{
    Extensible = true;
    value(0; None)
    {
        Caption = 'None';
    }
    value(1; Full)
    {
        Caption = 'Full';
    }
    value(2; Limited)
    {
        Caption = 'Limited';
    }
}









