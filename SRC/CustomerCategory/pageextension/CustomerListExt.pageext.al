pageextension 50103 "Customer List Extension" extends "Customer List"
{
    actions
    {
        addlast(Processing)
        {
            action("Assign Default Category")
            {
                Image = ChangeCustomer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Caption = 'Assign Default Category to all Customers';
                ToolTip = 'Assigns the Default Category to all Customers';

                trigger OnAction()
                var
                    CustomerCategoryMgt: Codeunit "Customer Category Mgt PKT";
                begin
                    CustomerCategoryMgt.AssignDefaultCategory();
                end;
            }
        }
    }
    views
    {
        addlast
        {
            view(CustomersWithoutCategory)
            {
                Caption = 'Customers without Category assigned';
                Filters = where("Customer Category Code PKT" = filter(''));
            }
        }
    }
}