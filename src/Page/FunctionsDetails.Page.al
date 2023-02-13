/// <summary>
/// Page Functions Details (ID 80002).
/// </summary>
page 80002 "Functions Details"
{
    PageType = ListPart;
    SourceTable = "Functions Details";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Type"; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}