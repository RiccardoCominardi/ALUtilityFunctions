/// <summary>
/// Enum Variable Types (ID 80000).
/// </summary>
enum 80000 "Variable Types"
{
    Extensible = true;

    value(0; "Date")
    {
        Caption = 'Date';
    }
    value(1; "Date-Time")
    {
        Caption = 'Date-Time';
    }
    value(3; "Text")
    {
        Caption = 'Text';
    }
    value(4; "Integer")
    {
        Caption = 'Integer';
    }
    value(5; "Variant")
    {
        Caption = 'Variant';
    }
    value(6; "Boolean")
    {
        Caption = 'Boolean';
    }
}