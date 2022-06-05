codeunit 50101 "GiftManagement PKT"
{
    procedure AddGifts(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        Handled: Boolean;
        Publisher: Codeunit "Gift Published Events";
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter("Line Discount %", '<>100');
        if SalesLine.FindSet(false, false) then
            repeat
                Publisher.OnBeforeFreeGiftSalesLineAdded(SalesLine, Handled);
                AddFreeGiftSalesLine(SalesLine, Handled);
                Publisher.OnAfterFreeGiftSalesLineAdded(SalesLine);
            until SalesLine.Next() = 0;
    end;

    local procedure AddFreeGiftSalesLine(var SalesLine: Record "Sales Line"; Handled: Boolean);
    var
        GiftCampaign: Record "Gift Campaign";
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
        SalesLineGift: Record "Sales Line";
        LineNo: Integer;
    begin
        if Handled then
            exit;
        SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        Customer.get(Salesheader."Sell-to Customer No.");
        GiftCampaign.SetRange("Customer Category PKT", Customer."Customer Category Code PKT");
        GiftCampaign.SetRange(Item, SalesLine."No.");
        GiftCampaign.SetFilter("Start Date", '<=%1', SalesHeader."Order Date");
        GiftCampaign.SetFilter("End Date", '>=%1', SalesHeader."Order Date");
        GiftCampaign.SetRange(Inactive, false);
        GiftCampaign.SetFilter("Min Qty Ordered", '<=%1', SalesLine.Quantity);
        if GiftCampaign.FindFirst() then begin
            LineNo := GetLastSalesDocumentLineNo(SalesHeader) + 10000;
            SalesLineGift.Init();
            SalesLineGift.TransferFields(SalesLine);
            SalesLineGift."Line No." := LineNo;
            SalesLineGift.Validate(Quantity, GiftCampaign."Gift Quantity");
            SalesLineGift.Validate("Line Discount %", 100);
            if SalesLineGift.Insert() then;
        end;
    end;

    local procedure GetLastSalesDocumentLineNo(SalesHeader: Record "Sales Header"): Integer
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindLast() then
            exit(SalesLine."Line No.")
        else
            exit(0);
    end;

    procedure DoGiftCheck(var SalesLine: Record "Sales Line"; var GiftCampaign: Record "Gift Campaign"; var Handled: Boolean)
    var
        PackSetup: Record "Packt Extension Setup";
        lblGiftAlert: Label 'Attention: there is an active promotion for item %1. if you buy %2 you can have a gift of %3';
    begin
        if Handled then
            exit;
        PackSetup.Get();
        if (SalesLine.Quantity < GiftCampaign."Min Qty Ordered") and (GiftCampaign."Min Qty Ordered" - SalesLine.Quantity <= PackSetup."Gift Tolerance Qty") then
            Message(lblGiftAlert, SalesLine."No.", Format(GiftCampaign."Min Qty Ordered"), Format(GiftCampaign."Gift Quantity"));
    end;
}