table 50102 "Vendor Quality PKT"
{
    DataClassification = CustomerContent;
    Caption = 'Vendor Quality';

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor No.';
            TableRelation = Vendor."No.";
        }
        field(2; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
        }
        field(3; "Vendor Activity Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Activity Description';
        }
        field(4; ScoreItemQuality; Integer)
        {
            Caption = 'Score Item Quality';
            DataClassification = CustomerContent;
            MinValue = 1;
            MaxValue = 10;
            trigger OnValidate()
            begin
                UpdateVendorRate();
            end;
        }
        field(5; ScoreDelivery; Integer)
        {
            Caption = 'Delivery On Time Score';
            MinValue = 1;
            MaxValue = 10;
            trigger OnValidate()
            begin
                UpdateVendorRate();
            end;
        }
        field(6; ScorePackaging; Integer)
        {
            Caption = 'Packaging Score';
            DataClassification = CustomerContent;
            MinValue = 1;
            MaxValue = 10;
            trigger OnValidate()
            begin
                UpdateVendorRate();
            end;
        }
        field(7; ScorePricing; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Pricing Score';
            MinValue = 1;
            MaxValue = 10;
            trigger OnValidate()
            begin
                UpdateVendorRate();
            end;
        }
        field(8; Rate; Decimal)
        {
            Caption = 'Vendor Rate';
            DataClassification = CustomerContent;

        }
        field(10; UpdateDate; Datetime)
        {
            Caption = 'Update Date';
            DataClassification = CustomerContent;
        }
        field(11; InvoicedYearN; Decimal)
        {
            Caption = 'Invoice for Current Year (N)';
            DataClassification = CustomerContent;
        }
        field(12; InvoicedYearN1; Decimal)
        {
            Caption = 'Invoice for Year N-1';
            DataClassification = CustomerContent;
        }
        field(13; InvoicedYearN2; Decimal)
        {
            Caption = 'Invoice for Year N-2';
            DataClassification = CustomerContent;
        }
        field(14; DueAmount; Decimal)
        {
            Caption = 'Due Amount';
            DataClassification = CustomerContent;
        }
        field(15; AmountNotDue; Decimal)
        {
            Caption = 'Amount to pay (not due)';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Vendor No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        UpdateDate := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        UpdateDate := CurrentDateTime;
    end;

    local procedure UpdateVendorRate()
    var
        VendorQualityMgt: Codeunit "Vendor Quality Management PKT";
    begin
        VendorQualityMgt.ClculateVendorRate(Rec);
    end;
}