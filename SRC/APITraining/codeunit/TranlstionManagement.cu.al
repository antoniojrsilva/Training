codeunit 50108 TranslationManagement
{
    procedure LookupAddressInfo(Name: Text; var Customer: Record Customer)
    var
        Client: HttpClient;
        Content: HttpContent;
        ResponseMessage: HttpResponseMessage;
        Result: Text;
        JContent: JsonObject;
        JDetails: JsonObject;
        JNames: JsonObject;
        JName: JsonValue;
        JPhones: JsonArray;
        JPhone: JsonObject;
        FullName: Text;
        lblConnectionError: Label 'Error connecting to the Web Service.';
        lblInvalidResponse: Label 'Invalid response from Web Service';
    //tozes
    begin
        //Content to look for
        Content.WriteFrom('{"email":"' + Name + '"}');

        //Connection to server posting the content and wait for a response
        Client.DefaultRequestHeaders().Add('Authorization', 'Bearer oIWAp4G4HFOGgQSu6RNwGevnLrAz8tMv');
        Client.Post('https://api.fullcontact.com/v3/person.enrich', Content, ResponseMessage);
        if not ResponseMessage.IsSuccessStatusCode() then
            Error(lblConnectionError);
        //Copy the JSON content to Result
        ResponseMessage.Content().ReadAs(Result);

        //See if the Result have some Content
        if not JContent.ReadFrom(Result) then
            Error(lblInvalidResponse);
        //
        JDetails := GetTokenAsObject(JContent, 'details', 'Invalid response from Web Service');
        //
        JNames := GetTokenAsObject(JDetails, 'name', 'No Name available');
        //
        JName := GetValueElement(JNames, 'full', 'No Full Name');
        //FullName := GetTokenAsText(JNames, 'full', 'No Full Name');
        //
        //JPhones := GetTokenAsArray(JDetails, 'phones', '');
        //
        //JPhone := GetArrayElementAsObject(JPhones, 0, '');
    end;

    procedure GetTokenAsText(JsonObject: JsonObject; TokenKey: Text; Error: Text): Text;
    var
        JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            if Error <> '' then
                Error(Error);
        exit('');
        exit(JsonToken.AsValue().AsText())
    end;

    procedure GetTokenAsObject(JsonObject: JsonObject; TokenKey: Text; Error: Text): JsonObject;
    var
        JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            if Error <> '' then
                Error(Error);
        exit(JsonToken.AsObject());
    end;

    procedure GetTokenAsArray(JsonObject: JsonObject; TokenKey: Text; Error: Text): JsonArray;
    var
        JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            if Error <> '' then
                Error(Error);
        exit(JsonToken.AsArray())
    end;

    procedure GetArrayElementAsObject(JsonArray: JsonArray; Index: Integer; Error: Text): JsonObject;
    var
        JsonToken: JsonToken;
    begin
        if not JsonArray.Get(Index, JsonToken) then
            if Error <> '' then
                Error(Error);
        exit(JsonToken.AsObject());
    end;

    procedure GetValueElement(JsonObject: JsonObject; TokenKey: Text; Error: Text): JsonValue
    var
        JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            if Error <> '' then
                Error(Error);
        exit(JsonToken.AsValue());
    end;
}
