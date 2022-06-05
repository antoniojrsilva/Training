report 50111 "Item Ledger Entry Analysis"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Item Ledger Entry Analysis';
    DefaultLayout = RDLC;
    RDLCLayout = './SRC/CustomerCategory/report/ItemLedgerEntryAnalysis.rdl';

    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            column(ItemNo_ItemLedgerEntry; "Item No.")
            {
                IncludeCaption = true;
            }
            column(PostingDate_ItemLedgerEntry; "Posting Date")
            {
                IncludeCaption = true;
            }
            column(EntryType_ItemLedgerEntry; "Entry Type")
            {
                IncludeCaption = true;
            }
            column(CustCatPKT_ItemLedgerEntry; "Customer Category Code PKT")
            {
                IncludeCaption = true;
            }
            column(DocumentNo_ItemLedgerEntry; "Document No.")
            {
                IncludeCaption = true;
            }
            column(Description_ItemLedgerEntry; Description)
            {
                IncludeCaption = true;
            }
            column(LocationCode_ItemLedgerEntry; "Location Code")
            {
                IncludeCaption = true;
            }
            column(Quantity_ItemLedgerEntry; Quantity)
            {
                IncludeCaption = true;
            }
            column(COMPANYNAME; CompanyName)
            {

            }
            column(includeLogo; includeLogo)
            {

            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {

            }
        }
    }
    labels
    {
        PageNo = 'Page';
        BCReportName = 'Item Ledger Entry Analysis';
    }
    var
        CompanyInfo: Record "Company Information";
        includeLogo: Boolean;
}