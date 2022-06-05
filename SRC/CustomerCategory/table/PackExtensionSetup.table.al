table 50103 "Packt Extension Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Packt Extension Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Minimun Accepted Vendor Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimun Accepted Vendor Rate for Purchases';
        }
        field(3; "Gift Tolerance Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Gift Tolerance Quantity for Sales';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}