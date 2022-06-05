codeunit 50105 "Vendor Quality Management PKT"
{
    procedure ClculateVendorRate(var VendorQuality: Record "Vendor Quality PKT")
    var
        Handled: Boolean;
    begin
        OnBeforeCalculateVendorRate(VendorQuality, Handled);
        VendorRateCalculation(VendorQuality, Handled);
        OnAfterCalculateVendorRate(VendorQuality);
    end;

    local procedure VendorRateCalculation(var VendorQuality: Record "Vendor Quality PKT"; var Handled: Boolean)
    begin
        if Handled then
            exit;
        VendorQuality.Rate := (VendorQuality.ScoreDelivery + VendorQuality.ScoreItemQuality +
                               VendorQuality.ScorePackaging + VendorQuality.ScorePricing) / 4
    end;

    procedure UpdateVendorQualityStatistics(var VendorQuality: Record "Vendor Quality PKT")
    var
        Year: Integer;
        DW: Dialog;
        lblDialogMessage: Label 'Calculating Vendor Statistics...';
    begin
        DW.Open(lblDialogMessage);
        Year := Date2DMY(Today, 3);
        VendorQuality.InvoicedYearN := GetInvoicedAmount(VendorQuality."Vendor No.", DMY2Date(1, 1, Year), TODAY);
        VendorQuality.InvoicedYearN1 := GetInvoicedAmount(VendorQuality."Vendor No.", DMY2Date(1, 1, Year - 1), DMY2Date(31, 12, Year - 1));
        VendorQuality.InvoicedYearN2 := GetInvoicedAmount(VendorQuality."Vendor No.", DMY2Date(1, 1, Year - 2), DMY2Date(31, 12, Year - 2));
        VendorQuality.DueAmount := GetDueAmount(VendorQuality."Vendor No.", false);
        VendorQuality.DueAmount := GetDueAmount(VendorQuality."Vendor No.", true);
        DW.Close();
    end;

    local procedure GetInvoicedAmount(VendorNo: code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Total: Decimal;
    begin
        Total := 0;
        VendorLedgerEntry.SetRange("Vendor No.", VendorNo);
        VendorLedgerEntry.SetFilter("Document Date", '%1..%2', StartDate, EndDate);
        If VendorLedgerEntry.FindSet(false, false) then
            repeat
                Total += VendorLedgerEntry."Purchase (LCY)";
            until VendorLedgerEntry.Next() = 0;
        exit(-Total);
    end;

    local procedure GetDueAmount(VendorNo: Code[20]; Due: Boolean): Decimal
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Total: Decimal;
    begin
        Total := 0;
        VendorLedgerEntry.SetRange("Vendor No.", VendorNo);
        VendorLedgerEntry.SetRange(Open, true);
        if Due then
            VendorLedgerEntry.SetFilter("Due Date", '<%1', Today)
        else
            VendorLedgerEntry.SetFilter("Due Date", '>=%1', Today);
        VendorLedgerEntry.SetAutoCalcFields(VendorLedgerEntry."Remaining Amt. (LCY)");
        if VendorLedgerEntry.FindSet(false, false) then
            repeat
                Total := VendorLedgerEntry."Remaining Amt. (LCY)";
            until VendorLedgerEntry.Next() = 0;
        exit(-Total);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalculateVendorRate(var VendorQuality: Record "Vendor Quality PKT"; Handled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalculateVendorRate(var VendorQuality: Record "Vendor Quality PKT")
    begin
    end;


}
