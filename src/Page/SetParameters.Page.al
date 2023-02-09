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

    layout
    {
        area(Content)
        {
            group(Parameters)
            {
                ShowCaption = false;
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
                        //Caption = '1° Integer';
                        ApplicationArea = All;
                        Visible = VisibleInteger1;
                        CaptionClass = '1,5,,' + IntegerCaption[1];
                    }
                    field(Integer2; ArrayOfInteger[2])
                    {
                        //Caption = '2° Integer';
                        ApplicationArea = All;
                        Visible = VisibleInteger2;
                        CaptionClass = '1,5,,' + IntegerCaption[2];
                    }
                    field(Integer3; ArrayOfInteger[3])
                    {
                        //Caption = '3° Integer';
                        ApplicationArea = All;
                        Visible = VisibleInteger3;
                        CaptionClass = '1,5,,' + IntegerCaption[3];
                    }
                    field(Integer4; ArrayOfInteger[4])
                    {
                        //Caption = '4° Integer';
                        ApplicationArea = All;
                        Visible = VisibleInteger4;
                        CaptionClass = '1,5,,' + IntegerCaption[4];
                    }
                    field(Integer5; ArrayOfInteger[5])
                    {
                        //Caption = '5° Integer';
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
        VisibleDataTimeGroup := false;
        VisibleDateTime1 := false;
        VisibleDateTime2 := false;
        VisibleDateTime3 := false;
        VisibleDateTime4 := false;
        VisibleDateTime5 := false;
        VisibleTextGroup := false;
        VisibleText1 := false;
        VisibleText2 := false;
        VisibleText3 := false;
        VisibleText4 := false;
        VisibleText5 := false;
        VisibleIntegerGroup := false;
        VisibleInteger1 := false;
        VisibleInteger2 := false;
        VisibleInteger3 := false;
        VisibleInteger4 := false;
        VisibleInteger5 := false;

        Clear(DateCaption);
        Clear(DateTimeCaption);
        Clear(TextCaption);
        Clear(IntegerCaption);
    end;
    /// <summary>
    /// SetParametersPage.
    /// </summary>
    /// <param name="NoOfParameters">Integer.</param>
    /// <param name="VariableTypes">Enum "Variable Types".</param>
    procedure SetParametersPage(NoOfParameters: Integer; VariableTypes: Enum "Variable Types")
    var
        Text000Err: Label 'Insert at least 1 parameter';
        Text001Err: Label 'This version of app can process at most %1 parameters';
    begin
        if NoOfParameters <= 0 then
            Error(Text000Err);

        if NoOfParameters > 5 then
            Error(Text001Err, 5);

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
        end;

        //Visibilità del singolo campo
        case VariableTypes of
            "Variable Types"::Date:
                case NoOfParameters of
                    1:
                        VisibleDate1 := true;
                    2:
                        begin
                            VisibleDate1 := true;
                            VisibleDate2 := true;
                        end;
                    3:
                        begin
                            VisibleDate1 := true;
                            VisibleDate2 := true;
                            VisibleDate3 := true;
                        end;
                    4:
                        begin
                            VisibleDate1 := true;
                            VisibleDate2 := true;
                            VisibleDate3 := true;
                            VisibleDate4 := true;
                        end;
                    5:
                        begin
                            VisibleDate1 := true;
                            VisibleDate2 := true;
                            VisibleDate3 := true;
                            VisibleDate4 := true;
                            VisibleDate5 := true;
                        end;
                end;
            "Variable Types"::"Date-Time":
                case NoOfParameters of
                    1:
                        VisibleDateTime1 := true;
                    2:
                        begin
                            VisibleDateTime1 := true;
                            VisibleDateTime2 := true;
                        end;
                    3:
                        begin
                            VisibleDateTime1 := true;
                            VisibleDateTime2 := true;
                            VisibleDateTime3 := true;
                        end;
                    4:
                        begin
                            VisibleDateTime1 := true;
                            VisibleDateTime2 := true;
                            VisibleDateTime3 := true;
                            VisibleDateTime4 := true;
                        end;
                    5:
                        begin
                            VisibleDateTime1 := true;
                            VisibleDateTime2 := true;
                            VisibleDateTime3 := true;
                            VisibleDateTime4 := true;
                            VisibleDateTime5 := true;
                        end;
                end;
            "Variable Types"::Text:
                case NoOfParameters of
                    1:
                        VisibleText1 := true;
                    2:
                        begin
                            VisibleText1 := true;
                            VisibleText2 := true;
                        end;
                    3:
                        begin
                            VisibleText1 := true;
                            VisibleText2 := true;
                            VisibleText3 := true;
                        end;
                    4:
                        begin
                            VisibleText1 := true;
                            VisibleText2 := true;
                            VisibleText3 := true;
                            VisibleText4 := true;
                        end;
                    5:
                        begin
                            VisibleText1 := true;
                            VisibleText2 := true;
                            VisibleText3 := true;
                            VisibleText4 := true;
                            VisibleText5 := true;
                        end;
                end;
            "Variable Types"::Integer:
                case NoOfParameters of
                    1:
                        VisibleInteger1 := true;
                    2:
                        begin
                            VisibleInteger1 := true;
                            VisibleInteger2 := true;
                        end;
                    3:
                        begin
                            VisibleInteger1 := true;
                            VisibleInteger2 := true;
                            VisibleInteger3 := true;
                        end;
                    4:
                        begin
                            VisibleInteger1 := true;
                            VisibleInteger2 := true;
                            VisibleInteger3 := true;
                            VisibleInteger4 := true;
                        end;
                    5:
                        begin
                            VisibleInteger1 := true;
                            VisibleInteger2 := true;
                            VisibleInteger3 := true;
                            VisibleInteger4 := true;
                            VisibleInteger5 := true;
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
        end;
    end;

    /// <summary>
    /// SetCaption.
    /// </summary>
    /// <param name="VariableTypes">Enum "Variable Types".</param>
    /// <param name="PositionNo">Integer.</param>
    /// <param name="CaptionValue">Text.</param>
    procedure SetCaption(VariableTypes: Enum "Variable Types"; PositionNo: Integer; CaptionValue: Text)
    begin
        case VariableTypes of
            "Variable Types"::"Date":
                DateCaption[PositionNo] := CaptionValue;
            "Variable Types"::"Date-Time":
                DateTimeCaption[PositionNo] := CaptionValue;
            "Variable Types"::"Text":
                TextCaption[PositionNo] := CaptionValue;
            "Variable Types"::"Integer":
                IntegerCaption[PositionNo] := CaptionValue;
        end;
    end;

    var
        ArrayOfDate: array[5] of Date;
        ArrayOfDateTime: array[5] of DateTime;
        ArrayOfText: array[5] of Text;
        ArrayOfInteger: array[5] of Integer;
        //Caption 
        DateCaption: array[5] of Text;
        DateTimeCaption: array[5] of Text;
        TextCaption: array[5] of Text;
        IntegerCaption: array[5] of Text;
        //Date
        VisibleDateGroup: Boolean;
        VisibleDate1: Boolean;
        VisibleDate2: Boolean;
        VisibleDate3: Boolean;
        VisibleDate4: Boolean;
        VisibleDate5: Boolean;
        //DateTime
        VisibleDataTimeGroup: Boolean;
        VisibleDateTime1: Boolean;
        VisibleDateTime2: Boolean;
        VisibleDateTime3: Boolean;
        VisibleDateTime4: Boolean;
        VisibleDateTime5: Boolean;
        //Boolean
        VisibleTextGroup: Boolean;
        VisibleText1: Boolean;
        VisibleText2: Boolean;
        VisibleText3: Boolean;
        VisibleText4: Boolean;
        VisibleText5: Boolean;
        //Integer
        VisibleIntegerGroup: Boolean;
        VisibleInteger1: Boolean;
        VisibleInteger2: Boolean;
        VisibleInteger3: Boolean;
        VisibleInteger4: Boolean;
        VisibleInteger5: Boolean;

}