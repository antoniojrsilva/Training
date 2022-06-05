codeunit 60100 "Customer Category PKT"
{
    // [FEATURE] Customer Category
    Subtype = Test;

    var
        LibraryUtility: Codeunit "Library - Utility";
        LibrarySales: Codeunit "Library - Sales";
        Assert: Codeunit Assert;

    [Test]
    procedure AssignNonBlockedCustomerCategoryToCustomer()
    var
        Customer: Record Customer;
        CategoryCreated: Code[10];
    begin
        // [Scenario #0001] Assign non-blocked customer category to customer
        // [Given] A non-blocked customer category
        CategoryCreated := CreateNonBlockedCategory();
        // [Given] A customer
        CreateCustomer(Customer);
        // [When] Set customer category on customer
        SetCustomerCategoryOnCustomer(Customer, CategoryCreated);
        // [Then] Customer category on customer
        VerifyCustomerCategoryOnCustomer(Customer."No.", CategoryCreated);
    end;

    [Test]
    procedure AssignBlockedCustomerCategoryToCustomer()
    // [Feature] Customer Category
    var
        Customer: Record Customer;
        CategoryCreated: Code[10];
    begin
        // [Scenario #0002] Assign a blocked category to customer
        // [Given] A blocked customer category
        CategoryCreated := CreateBlockedCategory();
        // [Given] A customer
        CreateCustomer(Customer);
        // [When] Set customer category on customer
        SetCustomerCategoryOnCustomer(Customer, CategoryCreated);
        // [Then] Blocked category error thrown
        VerifyCustomerCategoryOnCustomer(Customer."No.", CategoryCreated);
    end;

    [Test]
    procedure AssignDefaultCategoryToCustomerFromCustomerCard()
    // [Feature] Assign by UI default category to a customer
    var
        Customer: Record Customer;
        CategoryCreated: Code[10];
    begin
        // [Scenario #0003] Assign default category to customer from customer card
        // [Given] A non-blocked default customer category
        CategoryCreated := CreateDefaultCategory();
        // [Given] A Customer with a non default category
        CreateCustomerWithNoDefaultCategory(Customer);
        // [When] Assign defaultcategory to a customer
        SelectAssignDefaultCategoryActionOnCustomerCard(Customer."No.");
        // [Then] Customer has default category
        VerifyCustomerHasDefaultCustomerCategory(Customer."No.", CategoryCreated);
    end;

    local procedure CreateNonBlockedCategory(): Code[20]
    var
        Customercategory: Record "Customer Category PKT";
    begin
        Customercategory.Init();
        Customercategory.Validate(No, LibraryUtility.GenerateRandomCode(Customercategory.FieldNo(No), Database::"Customer Category PKT"));
        Customercategory.Validate(Description, Customercategory.No);
        Customercategory.Insert();
        exit(CustomerCategory.No);
    end;

    local procedure CreateBlockedCategory(): Code[20]
    var
        CustomerCategory: Record "Customer Category PKT";
    begin
        CustomerCategory.Init();
        CustomerCategory.Validate(No, LibraryUtility.GenerateRandomCode(CustomerCategory.FieldNo(No), Database::"Customer Category PKT"));
        CustomerCategory.Validate(Description, CustomerCategory.No);
        CustomerCategory.Blocked := true;
        CustomerCategory.Insert();
        exit(CustomerCategory.No);
    end;

    local procedure CreateDefaultCategory(): Code[20]
    var
        CustomerCategory: Record "Customer Category PKT";
    begin
        CustomerCategory.Init();
        CustomerCategory.Validate(No, LibraryUtility.GenerateRandomCode(CustomerCategory.FieldNo(No), Database::"Customer Category PKT"));
        CustomerCategory.Validate(Description, CustomerCategory.No);
        CustomerCategory.Default := true;
        CustomerCategory.Insert();
        exit(CustomerCategory.No);
    end;

    local procedure CreateCustomer(var Customer: Record Customer): Code[20]
    begin
        LibrarySales.CreateCustomer(Customer);
        exit(Customer."No.");
    end;

    local procedure CreateCustomerWithNoDefaultCategory(var Customer: Record Customer)
    begin
        CreateCustomer(Customer);
    end;

    local procedure SetCustomerCategoryOnCustomer(var Customer: Record Customer; CategoryCreated: Code[20])
    begin
        Customer.Validate("Customer Category Code PKT", CategoryCreated);
        Customer.Modify();
    end;

    local procedure SelectAssignDefaultCategoryActionOnCustomerCard(CustomerNo: Code[20])
    var
        CustomerCard: TestPage "Customer Card";
    begin
        CustomerCard.OpenView();
        CustomerCard.GoToKey(CustomerNo);
        CustomerCard."Assign default category".Invoke();
    end;

    local procedure VerifyCustomerCategoryOnCustomer(CustomerNo: Code[20]; CustomerCategory: Code[20])
    var
        Customer: Record Customer;
        FieldOnTableTxt: Label '%1 on %2';
    begin
        If Customer.Get(CustomerNo) then begin
            Assert.AreEqual(CustomerCategory, Customer."Customer Category Code PKT",
                            StrSubstNo(FieldOnTableTxt, Customer.FieldCaption("Customer Category Code PKT"), Customer.TableCaption()));
        end;
    end;

    local procedure VerifyCustomerHasDefaultCustomerCategory(CustomerNo: Code[20]; DefaultCustomerCategoryCode: Code[20])
    begin
        VerifyCustomerCategoryOnCustomer(CustomerNo, DefaultCustomerCategoryCode);
    end;
}