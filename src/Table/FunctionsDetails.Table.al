/// <summary>
/// Table Functions Details (ID 80001).
/// </summary>
table 80001 "Functions Details"
{
    DataClassification = CustomerContent;
    LookupPageId = "Functions Details";
    DrillDownPageId = "Functions Details";

    fields
    {
        field(1; "Function Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Function Name';
        }
        field(2; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(3; Name; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(4; "Type"; Enum Types)
        {
            DataClassification = CustomerContent;
            Caption = 'Types';
        }
        field(5; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(6; "Variable Type"; Enum "Variable Types")
        {
            DataClassification = CustomerContent;
            Caption = 'Variable Type';
        }
        field(7; "Record ID"; RecordId)
        {
            DataClassification = CustomerContent;
            Caption = 'Record ID';
        }
    }

    keys
    {
        key(Key1; "Function Name", "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}