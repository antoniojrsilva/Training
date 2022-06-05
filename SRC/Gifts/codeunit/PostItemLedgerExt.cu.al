codeunit 50104 "Post Item Ledeger Extension"
{

    Permissions = tabledata "Item Ledger Entry" = m;

    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", 'OnAfterInsertEvent', '', false, false)]
    procedure OnAfterItemLedgerEntryInsert(var Rec: Record "Item Ledger Entry")
    var

        Customer: Record Customer;
    begin

        if Rec."Entry Type" = Rec."Entry Type"::Sale then begin
            if Customer.get(Rec."Source No.") then begin
                Rec."Customer Category Code PKT" := Customer."Customer Category Code PKT";
                Rec.Modify()
            end;
        end;
    end;
}