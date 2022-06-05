codeunit 50100 "Customer Category Mgt PKT"
{
    procedure CreateDefaultCategory()
    var
        CustomerCategory: Record "Customer Category PKT";
    begin
        CustomerCategory.No := 'DEFAULT';
        CustomerCategory.Description := 'Default Customer Category';
        CustomerCategory.Default := true;
        if CustomerCategory.Insert then;
    end;

    procedure AssignDefaultCategory(CustomerNo: Code[20])
    var
        Customer: Record Customer;
        CustomerCategory: Record "Customer Category PKT";
    begin
        Customer.Get(CustomerNo);
        CustomerCategory.SetRange(Default, true);
        if CustomerCategory.FindFirst() then begin
            Customer."Customer Category Code PKT" := CustomerCategory.No;
            Customer.Modify();
        end
    end;

    procedure AssignDefaultCategory()
    var
        Customer: Record Customer;
        CustomerCategory: Record "Customer Category PKT";
    begin
        CustomerCategory.SetRange(Default, true);
        if CustomerCategory.FindFirst() then begin
            Customer.SetRange("Customer Category Code PKT", '');
            Customer.ModifyAll("Customer Category Code PKT", CustomerCategory.No, true);
        end;
    end;

    procedure GetTotalCustomerWithoutCategory(): Integer
    var
        Customer: Record Customer;
    begin
        Customer.SetRange("Customer Category Code PKT", '');
        exit(Customer.Count);
    end;

    procedure GetSalesAmount(CustomerCategoryCode: Code[20]): Decimal
    var
        SalesLine: Record "Sales Line";
        Customer: Record Customer;
        TotalAmount: Decimal;
    begin
        Customer.SetCurrentKey("Customer Category Code PKT");
        Customer.SetRange("Customer Category Code PKT", CustomerCategoryCode);
        if Customer.FindSet(false, false) then
            repeat
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Sell-to Customer No.", Customer."No.");
                if SalesLine.FindSet(false, false) then
                    repeat
                        TotalAmount += SalesLine."Line Amount";
                    until SalesLine.Next() = 0;
            until Customer.Next() = 0;
    end;
}