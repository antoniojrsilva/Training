pageextension 50102 "Sales Order PKT" extends "Sales Order"
{
    actions
    {
        addlast(processing)
        {
            action(JSONFile)
            {
                Caption = 'Create JSON file';
                ToolTip = 'Create JSON file for this Sales Order';
                ApplicationArea = All;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    JSONFile: Codeunit "Create JSON Sales Order";
                begin
                    JSONFile.CreateJSONOrder(Rec."No.");
                end;
            }
            action(AddFreeGifts)
            {
                Caption = 'Add Free Gifts';
                ToolTip = 'Adds Free Gifts to the current Sales Order based on active Campaigns';
                ApplicationArea = All;
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    GiftManagement.AddGifts(Rec);
                end;
            }
        }
    }

    var
        GiftManagement: Codeunit "GiftManagement PKT";
}