pageextension 50140 MyCustomerExt extends "Item Card"
{
    layout
    {
        modify(Description)
        {
            trigger OnBeforeValidate();
            var
                Publisher: Codeunit MyPublishers;
            begin
                Publisher.OnItemDescription(Rec.Description);
            end;
        }
    }
}