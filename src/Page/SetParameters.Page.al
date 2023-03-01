/// <summary>
/// Page Set Parameters (ID 80001).
/// </summary>
page 80001 "Set Parameters"
{
    //Created 5 parameters for each type of variable
    PageType = Worksheet;
    SourceTable = Integer;
    SourceTableTemporary = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            group(Parameters)
            {
                ShowCaption = false;
                group(Records)
                {
                    Caption = 'Records';
                    Visible = VisibleRecordGroup;
                    field(Record1; ArrayOfRecord[1])
                    {
                        ApplicationArea = All;
                        Visible = VisibleRecord1;
                        CaptionClass = '1,5,,' + RecordCaption[1];
                        Editable = false;
                    }
                    field(Record2; ArrayOfRecord[2])
                    {
                        ApplicationArea = All;
                        Visible = VisibleRecord2;
                        CaptionClass = '1,5,,' + RecordCaption[2];
                        Editable = false;
                    }
                    field(Record3; ArrayOfRecord[3])
                    {
                        ApplicationArea = All;
                        Visible = VisibleRecord3;
                        CaptionClass = '1,5,,' + RecordCaption[3];
                    }
                    field(Record4; ArrayOfRecord[4])
                    {
                        ApplicationArea = All;
                        Visible = VisibleRecord4;
                        CaptionClass = '1,5,,' + RecordCaption[4];
                    }
                    field(Record5; ArrayOfRecord[5])
                    {
                        ApplicationArea = All;
                        Visible = VisibleRecord5;
                        CaptionClass = '1,5,,' + RecordCaption[5];
                    }
                }
                group(Dates)
                {
                    Caption = 'Dates';
                    Visible = VisibleDateGroup;
                    field(Date1; ArrayOfDate[1])
                    {
                        ApplicationArea = All;
                        Visible = VisibleDate1;
                        CaptionClass = '1,5,,' + DateCaption[1];
                    }
                    field(Date2; ArrayOfDate[2])
                    {
                        ApplicationArea = All;
                        Visible = VisibleDate2;
                        CaptionClass = '1,5,,' + DateCaption[2];
                    }
                    field(Date3; ArrayOfDate[3])
                    {
                        ApplicationArea = All;
                        Visible = VisibleDate3;
                        CaptionClass = '1,5,,' + DateCaption[3];
                    }
                    field(Date4; ArrayOfDate[4])
                    {
                        ApplicationArea = All;
                        Visible = VisibleDate4;
                        CaptionClass = '1,5,,' + DateCaption[4];
                    }
                    field(Date5; ArrayOfDate[5])
                    {
                        ApplicationArea = All;
                        Visible = VisibleDate5;
                        CaptionClass = '1,5,,' + DateCaption[5];
                    }
                }
                group(DateTimes)
                {
                    Caption = 'Date - Time';
                    Visible = VisibleDataTimeGroup;
                    field(DateTime1; ArrayOfDateTime[1])
                    {
                        ApplicationArea = All;
                        Visible = VisibleDateTime1;
                        CaptionClass = '1,5,,' + DateTimeCaption[1];
                    }
                    field(DateTime2; ArrayOfDateTime[2])
                    {
                        ApplicationArea = All;
                        Visible = VisibleDateTime2;
                        CaptionClass = '1,5,,' + DateTimeCaption[2];
                    }
                    field(DateTime3; ArrayOfDateTime[3])
                    {
                        ApplicationArea = All;
                        Visible = VisibleDateTime3;
                        CaptionClass = '1,5,,' + DateTimeCaption[3];
                    }
                    field(DateTime4; ArrayOfDateTime[4])
                    {
                        ApplicationArea = All;
                        Visible = VisibleDateTime4;
                        CaptionClass = '1,5,,' + DateTimeCaption[4];
                    }
                    field(DateTime5; ArrayOfDateTime[5])
                    {
                        ApplicationArea = All;
                        Visible = VisibleDateTime5;
                        CaptionClass = '1,5,,' + DateTimeCaption[5];
                    }
                }
                group(String)
                {
                    Caption = 'String';
                    Visible = VisibleTextGroup;
                    field(Text1; ArrayOfText[1])
                    {
                        ApplicationArea = All;
                        Visible = VisibleText1;
                        CaptionClass = '1,5,,' + TextCaption[1];
                    }
                    field(Text2; ArrayOfText[2])
                    {
                        ApplicationArea = All;
                        Visible = VisibleText2;
                        CaptionClass = '1,5,,' + TextCaption[2];
                    }
                    field(Text3; ArrayOfText[3])
                    {
                        ApplicationArea = All;
                        Visible = VisibleText3;
                        CaptionClass = '1,5,,' + TextCaption[3];
                    }
                    field(Text4; ArrayOfText[4])
                    {
                        ApplicationArea = All;
                        Visible = VisibleText4;
                        CaptionClass = '1,5,,' + TextCaption[4];
                    }
                    field(Text5; ArrayOfText[5])
                    {
                        ApplicationArea = All;
                        Visible = VisibleText5;
                        CaptionClass = '1,5,,' + TextCaption[5];
                    }
                }
                group(Integers)
                {
                    Caption = 'Integer';
                    Visible = VisibleIntegerGroup;
                    field(Integer1; ArrayOfInteger[1])
                    {
                        ApplicationArea = All;
                        Visible = VisibleInteger1;
                        CaptionClass = '1,5,,' + IntegerCaption[1];
                    }
                    field(Integer2; ArrayOfInteger[2])
                    {
                        ApplicationArea = All;
                        Visible = VisibleInteger2;
                        CaptionClass = '1,5,,' + IntegerCaption[2];
                    }
                    field(Integer3; ArrayOfInteger[3])
                    {
                        ApplicationArea = All;
                        Visible = VisibleInteger3;
                        CaptionClass = '1,5,,' + IntegerCaption[3];
                    }
                    field(Integer4; ArrayOfInteger[4])
                    {
                        ApplicationArea = All;
                        Visible = VisibleInteger4;
                        CaptionClass = '1,5,,' + IntegerCaption[4];
                    }
                    field(Integer5; ArrayOfInteger[5])
                    {
                        ApplicationArea = All;
                        Visible = VisibleInteger5;
                        CaptionClass = '1,5,,' + IntegerCaption[5];
                    }
                }
            }
        }
    }

    /// <summary>
    /// InitiParameters.
    /// </summary>
    procedure InitiParameters()
    begin
        VisibleDateGroup := false;
        VisibleDate1 := false;
        VisibleDate2 := false;
        VisibleDate3 := false;
        VisibleDate4 := false;
        VisibleDate5 := false;
        DateCounter := 0;

        VisibleDataTimeGroup := false;
        VisibleDateTime1 := false;
        VisibleDateTime2 := false;
        VisibleDateTime3 := false;
        VisibleDateTime4 := false;
        VisibleDateTime5 := false;
        DateTimeCounter := 0;

        VisibleTextGroup := false;
        VisibleText1 := false;
        VisibleText2 := false;
        VisibleText3 := false;
        VisibleText4 := false;
        VisibleText5 := false;
        TextCounter := 0;

        VisibleIntegerGroup := false;
        VisibleInteger1 := false;
        VisibleInteger2 := false;
        VisibleInteger3 := false;
        VisibleInteger4 := false;
        VisibleInteger5 := false;
        IntegerCounter := 0;

        VisibleRecordGroup := false;
        VisibleRecord1 := false;
        VisibleRecord2 := false;
        VisibleRecord3 := false;
        VisibleRecord4 := false;
        VisibleRecord5 := false;
        RecordCounter := 0;

        Clear(DateCaption);
        Clear(DateTimeCaption);
        Clear(TextCaption);
        Clear(IntegerCaption);
    end;
    /// <summary>
    /// SetVisibleParameters.
    /// </summary>
    /// <param name="VariableTypes">Enum "Variable Types".</param>
    procedure SetVisibleParameters(VariableTypes: Enum "Variable Types")
    begin
        //Visibilità del gruppo
        case VariableTypes of
            "Variable Types"::"Date":
                VisibleDateGroup := true;
            "Variable Types"::"Date-Time":
                VisibleDataTimeGroup := true;
            "Variable Types"::"Text":
                VisibleTextGroup := true;
            "Variable Types"::"Integer":
                VisibleIntegerGroup := true;
            VariableTypes::"Variant":
                VisibleRecordGroup := true;
        end;

        //Visibilità del singolo campo
        case VariableTypes of
            "Variable Types"::Date:
                begin
                    DateCounter += 1;
                    case DateCounter of
                        1:
                            VisibleDate1 := true;
                        2:
                            VisibleDate2 := true;
                        3:
                            VisibleDate3 := true;
                        4:
                            VisibleDate4 := true;
                        5:
                            VisibleDate5 := true;
                    end;
                end;
            "Variable Types"::"Date-Time":
                begin
                    DateTimeCounter += 1;
                    case DateTimeCounter of
                        1:
                            VisibleDateTime1 := true;
                        2:
                            VisibleDateTime2 := true;
                        3:
                            VisibleDateTime3 := true;
                        4:
                            VisibleDateTime4 := true;
                        5:
                            VisibleDateTime5 := true;
                    end;
                end;
            "Variable Types"::Text:
                begin
                    TextCounter += 1;
                    case TextCounter of
                        1:
                            VisibleText1 := true;
                        2:
                            VisibleText2 := true;
                        3:
                            VisibleText3 := true;
                        4:
                            VisibleText4 := true;
                        5:
                            VisibleText5 := true;
                    end;
                end;
            "Variable Types"::Integer:
                begin
                    IntegerCounter += 1;
                    case IntegerCounter of
                        1:
                            VisibleInteger1 := true;
                        2:
                            VisibleInteger2 := true;
                        3:
                            VisibleInteger3 := true;
                        4:
                            VisibleInteger4 := true;
                        5:
                            VisibleInteger5 := true;
                    end;
                end;
            "Variable Types"::"Variant":
                begin
                    RecordCounter += 1;
                    case RecordCounter of
                        1:
                            VisibleRecord1 := true;
                        2:
                            VisibleRecord2 := true;
                        3:
                            VisibleRecord3 := true;
                        4:
                            VisibleRecord4 := true;
                        5:
                            VisibleRecord5 := true;
                    end;
                end;
        end;
    end;

    /// <summary>
    /// GetArrayOf.
    /// </summary>
    /// <param name="ArrayOfVariant">VAR array[5] of Variant.</param>
    /// <param name="VariableTypes">Enum "Variable Types".</param>
    procedure GetArrayOf(var ArrayOfVariant: array[5] of Variant; VariableTypes: Enum "Variable Types")
    var
        i: Integer;
    begin
        case VariableTypes of
            "Variable Types"::"Date":
                for i := 1 to 5 do
                    ArrayOfVariant[i] := ArrayOfDate[i];
            "Variable Types"::"Date-Time":
                for i := 1 to 5 do
                    ArrayOfVariant[i] := ArrayOfDateTime[i];
            "Variable Types"::"Text":
                for i := 1 to 5 do
                    ArrayOfVariant[i] := ArrayOfText[i];
            "Variable Types"::"Integer":
                for i := 1 to 5 do
                    ArrayOfVariant[i] := ArrayOfInteger[i];
        //Array of Record is not editable so is not return. 
        end;
    end;

    /// <summary>
    /// SetCaption.
    /// </summary>
    /// <param name="VariableTypes">Enum "Variable Types".</param>
    /// <param name="CaptionValue">Text.</param>
    procedure SetCaption(VariableTypes: Enum "Variable Types"; CaptionValue: Text)
    begin
        case VariableTypes of
            "Variable Types"::"Date":
                DateCaption[DateCounter] := CaptionValue;
            "Variable Types"::"Date-Time":
                DateTimeCaption[DateTimeCounter] := CaptionValue;
            "Variable Types"::"Text":
                TextCaption[TextCounter] := CaptionValue;
            "Variable Types"::"Integer":
                IntegerCaption[IntegerCounter] := CaptionValue;
            "Variable Types"::"Variant":
                RecordCaption[RecordCounter] := CaptionValue;
        end;
    end;

    /// <summary>
    /// SetRecordID.
    /// </summary>
    /// <param name="ParRecordID">RecordId.</param>
    procedure SetRecordID(ParRecordID: RecordId)
    begin
        ArrayOfRecord[RecordCounter] := Format(ParRecordID);
    end;

    var
        ArrayOfDate: array[5] of Date;
        ArrayOfDateTime: array[5] of DateTime;
        ArrayOfText: array[5] of Text;
        ArrayOfInteger: array[5] of Integer;
        ArrayOfRecord: array[5] of Text; //Format of a RecordID record
        //Caption 
        DateCaption: array[5] of Text;
        DateTimeCaption: array[5] of Text;
        TextCaption: array[5] of Text;
        IntegerCaption: array[5] of Text;
        RecordCaption: array[5] of Text;
        //Date
        VisibleDateGroup: Boolean;
        VisibleDate1: Boolean;
        VisibleDate2: Boolean;
        VisibleDate3: Boolean;
        VisibleDate4: Boolean;
        VisibleDate5: Boolean;
        DateCounter: Integer;
        //DateTime
        VisibleDataTimeGroup: Boolean;
        VisibleDateTime1: Boolean;
        VisibleDateTime2: Boolean;
        VisibleDateTime3: Boolean;
        VisibleDateTime4: Boolean;
        VisibleDateTime5: Boolean;
        DateTimeCounter: Integer;
        //Boolean
        VisibleTextGroup: Boolean;
        VisibleText1: Boolean;
        VisibleText2: Boolean;
        VisibleText3: Boolean;
        VisibleText4: Boolean;
        VisibleText5: Boolean;
        TextCounter: Integer;
        //Integer
        VisibleIntegerGroup: Boolean;
        VisibleInteger1: Boolean;
        VisibleInteger2: Boolean;
        VisibleInteger3: Boolean;
        VisibleInteger4: Boolean;
        VisibleInteger5: Boolean;
        IntegerCounter: Integer;
        //Record
        VisibleRecordGroup: Boolean;
        VisibleRecord1: Boolean;
        VisibleRecord2: Boolean;
        VisibleRecord3: Boolean;
        VisibleRecord4: Boolean;
        VisibleRecord5: Boolean;
        RecordCounter: Integer;
}