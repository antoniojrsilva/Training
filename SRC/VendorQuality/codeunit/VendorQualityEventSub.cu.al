codeunit 50107 "Vendor Quality Event Sub"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeManualReleasePurchaseDoc', '', false, false)]
    procedure QualityCheckForReleasingPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    var
        VendorQuality: Record "Vendor Quality PKT";
        PacktSetup: Record "Packt Extension Setup";
        ErrNoMinimumRate: Label 'Vendor %1 has a rate of %2 and it''s under the required minimum value (%3)';
    begin
        PacktSetup.Get();
        if VendorQuality.Get(PurchaseHeader."Buy-from Vendor No.") then begin
            if VendorQuality.Rate < PacktSetup."Minimun Accepted Vendor Rate" then
                Error(ErrNoMinimumRate, PurchaseHeader."Buy-from Vendor No.",
                Format(VendorQuality.Rate), Format(PacktSetup."Minimun Accepted Vendor Rate"));
        end;
    end;
}