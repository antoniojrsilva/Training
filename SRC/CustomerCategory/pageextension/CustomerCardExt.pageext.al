pageextension 50100 "Customer Card Extension" extends "Customer Card"
{
    layout
    {
        modify(Name)
        {
            trigger OnAfterValidate()
            var
                TranslationManagement: Codeunit TranslationManagement;
                lblCompanyDetails: Label 'Do you want to retrieve company details?';
            begin
                if Rec.Name.EndsWith('.com') then
                    if Confirm(lblCompanyDetails, false) then
                        TranslationManagement.LookupAddressInfo(Rec.Name, Rec);
            end;
        }

        addlast(General)
        {
            field("Customer Category Code PKT"; Rec."Customer Category Code PKT")
            {
                ApplicationArea = All;
                ToolTip = 'Customer Category';
            }
        }
    }

    actions
    {
        addlast(Approval)
        {
            action("Assign default category")
            {
                Image = ChangeCustomer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Caption = 'Assign Default Category';
                ToolTip = 'Assigns Default Category to the current Customer';

                trigger OnAction()
                var
                    CustomerCategoryMgt: Codeunit "Customer Category Mgt PKT";
                begin
                    CustomerCategoryMgt.AssignDefaultCategory(Rec."No.");
                end;
            }
        }
    }

}