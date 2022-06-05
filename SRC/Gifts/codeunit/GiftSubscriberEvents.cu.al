codeunit 50103 "Gift Subscriber Events"
{

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity', false, false)]
    procedure CheckGiftEligibility(var Rec: Record "Sales Line")
    var
        GiftCampaign: Record "Gift Campaign";
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        Handled: Boolean;
    begin
        If (Rec.Type = Rec.Type::Item) and (Customer.get(Rec."No.")) then begin
            SalesHeader.Get(Rec."Document Type", Rec."Document No.");
            GiftCampaign.SetRange("Customer Category PKT", Customer."Customer Category Code PKT");
            GiftCampaign.SetRange(Item, Rec."No.");
            GiftCampaign.SetFilter("Start Date", '<=%1', SalesHeader."Order Date");
            GiftCampaign.SetFilter("End Date", '>=%1', SalesHeader."Order Date");
            GiftCampaign.SetRange(Inactive, false);
            GiftCampaign.SetFilter("Min Qty Ordered", '>%1', Rec.Quantity);
            if GiftCampaign.FindFirst() then begin
                //TODO:
                //OnBeforeFreeGiftAllert(Rec, Handled);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, dataBase::Customer, 'OnAfterValidateEvent', 'Post Code', false, false)]
    local procedure ValidatepostCodeViaAzureFunction(var Rec: Record Customer)
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Json: Text;
        JsonObj: JsonObject;
        Jtoken: JsonToken;
        FunctionURL: Label 'http://postcodevalidator.azurewebsites.net/api/postcodevalidator?code=';
        InvalidResponseError: Label 'Invalid Response from Azure Function';
        InvalidCodeError: Label 'Invalid Post Code. Please reinsert';
        TokenNotFoundError: Label 'Token not found in Json';
    begin
        Client.Get(FunctionURL + Rec."Post Code", Response);
        Response.Content.ReadAs(Json);
        if not JsonObj.ReadFrom(Json) then
            Error(InvalidResponseError);
        if not JsonObj.get('IsValid', Jtoken) then
            Error(TokenNotFoundError);
        if not Jtoken.AsValue().AsBoolean() then
            Error(InvalidCodeError);
    end;
}