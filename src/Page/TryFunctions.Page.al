/// <summary>
/// Page Try Functions (ID 80000).
/// </summary>
page 80000 "Try Functions"
{
    Caption = 'Try Functions';
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = Functions;
#pragma warning disable AL0254 // TODO: - Temporary fields with limitated record
    SourceTableView = sorting(Category);
#pragma warning restore AL0254 // TODO: - Temporary fields with limitated record
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Functions)
            {
                Caption = 'Functions';
                field(FunctionName; Rec.Name)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        PrepareParametersPage(Rec.Name);
                        ExecuteFunctions(Rec.Name);
                    end;
                }
            }
            part(FunctionsDetails; "Functions Details")
            {
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "Function Name" = field(Name);
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.LoadFunctions();
    end;

    local procedure PrepareParametersPage(FunctionName: Text[50])
    var
        FunctionsDetails: Record "Functions Details";
    begin
        FunctionsDetails.Reset();
        FunctionsDetails.SetRange("Function Name", FunctionName);
        FunctionsDetails.SetRange(Type, FunctionsDetails.Type::Parameter);
        if not FunctionsDetails.IsEmpty() then begin
            SetParameters.InitiParameters();
            FunctionsDetails.FindSet();
            repeat
                SetParameters.SetVisibleParameters(FunctionsDetails."Variable Type");
                SetParameters.SetCaption(FunctionsDetails."Variable Type", FunctionsDetails.Name);
                case FunctionsDetails."Variable Type" of
                    "Variable Types"::Variant:
                        SetParameters.SetRecordID(FunctionsDetails."Record ID");
                end;
            until FunctionsDetails.Next() = 0;
            SetParameters.Caption(FunctionsDetails."Function Name");
            SetParameters.RunModal();
        end;
    end;

    local procedure ExecuteFunctions(FunctionName: Text[50])
    var
        GenericFunctions: Codeunit "Generic Functions";
        ResultText: Text;
        ResultLbl: Label 'Result:\';
        Text000Lbl: Label '\Go to sites https://www.epochconverter.com/ to see the result';
        Text001Lbl: Label 'Excel Exported';
        Text002Lbl: Label 'Go to %1 and take a look at the attachments factbox';
        Text003Lbl: Label 'Attachments Imported';
        Text004Lbl: Label '\Go to sites https://base64.guru/converter/decode/file to see the result';
        IsHandled: Boolean;
    begin
        OnBeforeExecuteFunctions(IsHandled, FunctionName);
        if IsHandled then
            exit;

        case FunctionName of
            'DiffInMonthBetween2Dates':
                begin
                    SetParameters.GetArrayOf(ArrayOfVariants1, VariableTypesNoFld::Date);
                    ResultText := Format(GenericFunctions.DiffInMonthBetween2Dates(ArrayOfVariants1[1], ArrayOfVariants1[2]));
                end;
            'FormatDateIntoTxt':
                begin
                    SetParameters.GetArrayOf(ArrayOfVariants1, VariableTypesNoFld::Date);
                    ResultText := GenericFunctions.FormatDateIntoTxt(ArrayOfVariants1[1]);
                end;
            'GetUnixTimeStampText':
                begin
                    SetParameters.GetArrayOf(ArrayOfVariants1, VariableTypesNoFld::"Date-Time");
                    ResultText := Format(GenericFunctions.GetUnixTimeStampText(ArrayOfVariants1[1]));
                    if ResultText <> '' then
                        ResultText += Text000Lbl;
                end;
            'GetRandomDigit':
                ResultText := GenericFunctions.GetRandomDigit();

            'KeepOnlyAllowedChar':
                begin
                    SetParameters.GetArrayOf(ArrayOfVariants1, VariableTypesNoFld::Text);
                    ResultText := GenericFunctions.KeepOnlyAllowedChar(ArrayOfVariants1[1], ArrayOfVariants1[2]);
                end;
            'ReplaceString':
                begin
                    SetParameters.GetArrayOf(ArrayOfVariants1, VariableTypesNoFld::Text);
                    ResultText := GenericFunctions.ReplaceString(ArrayOfVariants1[1], ArrayOfVariants1[2], ArrayOfVariants1[3]);
                end;
            'ReverseString':
                begin
                    SetParameters.GetArrayOf(ArrayOfVariants1, VariableTypesNoFld::Text);
                    ResultText := GenericFunctions.ReverseString(ArrayOfVariants1[1]);
                end;
            'ReverseStrPos':
                begin
                    SetParameters.GetArrayOf(ArrayOfVariants1, VariableTypesNoFld::Text);
                    ResultText := Format(GenericFunctions.ReverseStrPos(ArrayOfVariants1[1], ArrayOfVariants1[2]));
                end;
            'CheckFilterField':
                begin
                    EvaluateRecordIDFromFunction(ArrayOfVariants1, FunctionName);
                    SetParameters.GetArrayOf(ArrayOfVariants2, VariableTypesNoFld::Integer);
                    SetParameters.GetArrayOf(ArrayOfVariants3, VariableTypesNoFld::Text);
                    ResultText := Format(GenericFunctions.CheckFilterField(ArrayOfVariants1[1], ArrayOfVariants2[1], ArrayOfVariants3[1]));
                end;
            'ExportExcel':
                begin
                    EvaluateRecordIDFromFunction(ArrayOfVariants1, FunctionName);
                    GenericFunctions.ExportExcel(ArrayOfVariants1[1]);
                    ResultText := Text001Lbl;
                end;
            'ImportAttachmentsFromBase64':
                begin
                    EvaluateRecordIDFromFunction(ArrayOfVariants1, FunctionName);
                    SetParameters.GetArrayOf(ArrayOfVariants2, VariableTypesNoFld::Text);
                    GenericFunctions.ImportAttachmentsFromBase64(ArrayOfVariants1[1], ArrayOfVariants2[1], ArrayOfVariants2[2], ArrayOfVariants2[3]);
                    ResultText := StrSubstNo(Text002Lbl, FormatRecordIDFromVariant(ArrayOfVariants1, 1));
                end;
            'ImportAttachmentsFromZip':
                begin
                    GenericFunctions.ImportAttachmentsFromZip();
                    ResultText := Text003Lbl;
                end;
            'SetAttachmentsText':
                begin
                    EvaluateRecordIDFromFunction(ArrayOfVariants1, FunctionName);
                    GenericFunctions.SetAttachmentsText(ArrayOfVariants1[1], ArrayOfVariants2[1]);
                    ResultText := Format(ArrayOfVariants2[1]);
                    if ResultText <> '' then
                        ResultText += Text004Lbl;
                end;
            'StringToBarcode':
                begin
                    SetParameters.GetArrayOf(ArrayOfVariants1, VariableTypesNoFld::Text);
                    ResultText := Format(GenericFunctions.StringToBarcode(ArrayOfVariants1[1]));
                end;
        end;

        OnBeforeShowResult(IsHandled, ResultText);
        if IsHandled then
            exit;

        if ResultText <> '' then
            Message(ResultLbl + ResultText);
    end;

    local procedure EvaluateRecordIDFromFunction(var ArrayOfVariant: array[5] of Variant; FunctionName: Text[50])
    var
        FunctionsDetails: Record "Functions Details";
        RefRecordID: RecordId;
        RecRef: RecordRef;
        Customer: Record Customer;
        PurchaseHeader: Record "Purchase Header";
        i: Integer;
    begin
        Clear(RefRecordID);
        Clear(ArrayOfVariant);
        i := 0;
        FunctionsDetails.Reset();
        FunctionsDetails.SetRange("Function Name", FunctionName);
        FunctionsDetails.SetRange(Type, FunctionsDetails.Type::Parameter);
        FunctionsDetails.SetFilter("Record ID", '<> %1', RefRecordID);
        if not FunctionsDetails.IsEmpty() then begin
            FunctionsDetails.FindSet();
            repeat
                i += 1;
                RecRef.Get(FunctionsDetails."Record ID");
                case RecRef.Number of
                    DataBase::Customer:
                        begin
                            RecRef.SetTable(Customer);
                            ArrayOfVariant[i] := Customer;
                        end;
                    Database::"Purchase Header":
                        begin
                            RecRef.SetTable(PurchaseHeader);
                            ArrayOfVariant[i] := PurchaseHeader;
                        end;
                end;
            until FunctionsDetails.Next() = 0;
        end;
    end;

    local procedure FormatRecordIDFromVariant(ArrayOfVariant: array[5] of Variant; Position: Integer): Text;
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(ArrayOfVariant[Position]);
        exit(Format(RecRef.RecordId));
    end;

    #region Events
    [IntegrationEvent(false, false)]
    local procedure OnBeforeExecuteFunctions(var IsHandled: Boolean; FunctionName: Text[50])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowResult(var IsHandled: Boolean; ResultText: Text)
    begin
    end;
    #endregion Events
    var
        VariableTypesNoFld: Enum "Variable Types";
        GenericFunctions: Codeunit "Generic Functions";
        SetParameters: Page "Set Parameters";
        ArrayOfVariants1: array[5] of Variant;
        ArrayOfVariants2: array[5] of Variant;
        ArrayOfVariants3: array[5] of Variant;
        ArrayOfVariants4: array[5] of Variant;
        ArrayOfVariants5: array[5] of Variant;
}