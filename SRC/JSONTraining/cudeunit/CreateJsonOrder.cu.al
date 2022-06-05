codeunit 50120 "Create JSON Sales Order"
{
    procedure CreateJSONOrder(OrderNo: code[20])
    var
        JsonObjectHeader: JsonObject;
        JsonObjectLines: JsonObject;
        JsonOrderArray: JsonArray;
        JsonArrayLines: JsonArray;
        SalesHeader: Record "Sales Header";
        SalesLines: Record "Sales Line";
        TempBlob: Codeunit "Temp Blob";
        Instr: InStream;
        Outstr: OutStream;
        FileName: Text[100];
        Path: Text[100];
        Result: Text;
    begin
        //Start File to Download
        FileName := 'SO' + Format(OrderNo) + '.json';
        Path := '';

        if SalesHeader.Get(SalesHeader."Document Type"::Order, OrderNo) then begin
            JsonObjectHeader.Add('sales_order_no', SalesHeader."No.");
            JsonObjectHeader.Add('bill_to_customer_no', SalesHeader."Bill-to Customer No.");
            JsonObjectHeader.Add('bill_to_name', SalesHeader."Bill-to Name");
            JsonObjectHeader.Add('order_date', SalesHeader."Order Date");
            JsonOrderArray.Add(JsonObjectHeader);

            SalesLines.SetRange("Document Type", SalesLines."Document Type"::Order);
            SalesLines.SetRange("Document No.", OrderNo);
            if SalesLines.FindSet(false, false) then begin
                JsonObjectLines.Add('line_no', '');
                JsonObjectLines.Add('item_no', '');
                JsonObjectLines.Add('description', '');
                JsonObjectLines.Add('location_code', '');
                JsonObjectLines.Add('quantity', '');
                repeat
                    JsonObjectLines.Replace('line_no', SalesLines."Line No.");
                    JsonObjectLines.Replace('item_no', SalesLines."No.");
                    JsonObjectLines.Replace('description', SalesLines.Description);
                    JsonObjectLines.Replace('location_code', SalesLines."Location Code");
                    JsonObjectLines.Replace('quantity', SalesLines.Quantity);
                    JsonArrayLines.Add(JsonObjectLines);
                until SalesLines.Next() = 0;
            end;
            JsonOrderArray.Add(JsonArrayLines);
        end;
        //Create a Text from Outstream
        TempBlob.CreateOutStream(Outstr);
        JsonOrderArray.WriteTo(Outstr);
        Outstr.WriteText(Result);
        //Load the Outstream to Instream
        TempBlob.CreateInStream(Instr);
        Instr.ReadText(Result);
        DownloadFromStream(Instr, 'Download JSON Sales Order', '', '', FileName);
    end;
}