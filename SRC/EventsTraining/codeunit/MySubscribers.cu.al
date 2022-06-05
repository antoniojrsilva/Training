codeunit 50141 Mysubscribers
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::MyPublishers, 'OnItemDescription', '', true, true)]
    procedure SeeItemDescription(line: Text[100]);
    begin
        Message('I am here');
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Unit Price', true, true)]
    procedure AnotherOne(Rec: Record Item);
    var
        lblInvalidPrice: Label 'The price must be different from 0';
    begin
        If Rec."Unit Price" = 0 then
            error(lblInvalidPrice);
    end;
}