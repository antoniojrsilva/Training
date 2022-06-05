/// <summary>
/// TableExtension Customer Extention PKT (ID 50100) extends Record MyTargetTable.
/// </summary>
tableextension 50100 "Customer Extention PKT" extends Customer
{
    fields
    {
        field(50100; "Customer Category Code PKT"; Code[20])
        {
            DataClassification = CustomerContent;
            caption = 'Customer Category Code PKT';
            TableRelation = "Customer Category PKT".No where(Blocked = const(false));
        }
    }

    keys
    {
        key(CustomerCategory; "Customer Category Code PKT")
        {

        }
    }
}