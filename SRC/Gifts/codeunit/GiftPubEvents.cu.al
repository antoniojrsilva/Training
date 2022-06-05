codeunit 50102 "Gift Published Events"
{
    [IntegrationEvent(true, false)]
    procedure OnBeforeFreeGiftSalesLineAdded(var Rec: Record "Sales Line"; var Handled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    procedure OnAfterFreeGiftSalesLineAdded(var Rec: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(true, false)]
    procedure OnAfterFreeGiftAlert(var Rec: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeFreeGiftAllert(var Rec: Record "Sales Line"; Handled: Boolean)
    begin
    end;
}