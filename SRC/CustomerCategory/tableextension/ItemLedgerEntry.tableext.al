tableextension 50101 "Item Ledger Extension PKT" extends "Item Ledger Entry"
{
    fields
    {
        field(50100;
        "Customer Category Code PKT";
        Code[20])
        {
            TableRelation = "Customer Category PKT".No;
            Caption = 'Customer Category';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(FK; "Customer Category Code PKT")
        {

        }
    }
}