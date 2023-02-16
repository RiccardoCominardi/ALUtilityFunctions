/// <summary>
/// Table Functions (ID 80000).
/// </summary>
table 80000 Functions
{
    Caption = 'Functions';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Name; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(2; Category; Enum Categories)
        {
            DataClassification = CustomerContent;
            Caption = 'Category';
        }
        field(3; Parameters; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Functions Details" where(Name = field(Name), Type = const(Parameter)));
            Editable = false;
            Caption = 'Parameters';
        }
        field(4; "Return Value"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Functions Details".Name where(Name = field(Name), Type = const("Return Value")));
            Editable = false;
            Caption = 'Return Value';
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }

    #region Functions

    /// <summary>
    /// LoadFunctions.
    /// </summary>
    procedure LoadFunctions()
    var
        Functions: Record Functions;
        EnvironmentInfo: Codeunit "Environment Information";
        CurrFunctionEntryNo: Integer;
        Categories: Enum Categories;
        VariableTypes: Enum "Variable Types";
        Types: Enum Types;
        NewRecordID: RecordID;
        IsHandled: Boolean;
    begin
        //Rigenero ogni volta le funzioni
        OnBeforeLoadFunctions(IsHandled);
        if IsHandled then
            exit;

        Functions.Reset();
        Functions.DeleteAll(true);
        Clear(NewRecordID);

        CreateFunction('FormatDateIntoTxt', Categories::DateFunctions);
        CreateParameter('FormatDateIntoTxt', Types::Parameter, 'DateToFormat', VariableTypes::Date, '', NewRecordID);
        CreateParameter('FormatDateIntoTxt', Types::"Return Value", 'DateTxt', VariableTypes::Text, '', NewRecordID);

        CreateFunction('DiffInMonthBetween2Dates', Categories::DateFunctions);
        CreateParameter('DiffInMonthBetween2Dates', Types::Parameter, 'FromDate', VariableTypes::Date, '', NewRecordID);
        CreateParameter('DiffInMonthBetween2Dates', Types::Parameter, 'ToDate', VariableTypes::Date, '', NewRecordID);
        CreateParameter('DiffInMonthBetween2Dates', Types::"Return Value", 'NumberOfMonth', VariableTypes::Integer, '', NewRecordID);

        CreateFunction('GetUnixTimeStampText', Categories::DateFunctions);
        CreateParameter('GetUnixTimeStampText', Types::Parameter, 'FromDateTime', VariableTypes::"Date-Time", '', NewRecordID);
        CreateParameter('GetUnixTimeStampText', Types::"Return Value", 'Result', VariableTypes::Text, '', NewRecordID);

        CreateFunction('KeepOnlyAllowedChar', Categories::StringFunctions);
        CreateParameter('KeepOnlyAllowedChar', Types::Parameter, 'StringToProcess', VariableTypes::Text, '', NewRecordID);
        CreateParameter('KeepOnlyAllowedChar', Types::Parameter, 'txtCharsToKeep', VariableTypes::Text, '', NewRecordID);
        CreateParameter('KeepOnlyAllowedChar', Types::"Return Value", 'Result', VariableTypes::Text, '', NewRecordID);

        CreateFunction('GetRandomDigit', Categories::StringFunctions);
        CreateParameter('GetRandomDigit', Types::"Return Value", 'Result', VariableTypes::Text, '', NewRecordID);

        CreateFunction('ReplaceString', Categories::StringFunctions);
        CreateParameter('ReplaceString', Types::Parameter, 'String', VariableTypes::Text, '', NewRecordID);
        CreateParameter('ReplaceString', Types::Parameter, 'FindWhat', VariableTypes::Text, '', NewRecordID);
        CreateParameter('ReplaceString', Types::Parameter, 'ReplaceWith', VariableTypes::Text, '', NewRecordID);
        CreateParameter('ReplaceString', Types::"Return Value", 'NewString', VariableTypes::Text, '', NewRecordID);

        CreateFunction('ReverseString', Categories::StringFunctions);
        CreateParameter('ReverseString', Types::Parameter, 'Name', VariableTypes::Text, '', NewRecordID);
        CreateParameter('ReverseString', Types::"Return Value", 'ReversedName', VariableTypes::Text, '', NewRecordID);

        CreateFunction('ReverseStrPos', Categories::StringFunctions);
        CreateParameter('ReverseStrPos', Types::Parameter, 'String', VariableTypes::Text, '', NewRecordID);
        CreateParameter('ReverseStrPos', Types::"Return Value", 'Position', VariableTypes::Integer, '', NewRecordID);

        CreateFunction('CheckFilterField', Categories::FieldManagement);
        CreateParameter('CheckFilterField', Types::Parameter, 'SourceRecord', VariableTypes::Variant, '', SetFixedRecordID(Database::"Customer"));
        CreateParameter('CheckFilterField', Types::Parameter, 'FilterFieldID', VariableTypes::Integer, '', NewRecordID);
        CreateParameter('CheckFilterField', Types::Parameter, 'FilterFieldValue', VariableTypes::Text, '', NewRecordID);
        CreateParameter('CheckFilterField', Types::"Return Value", 'Result', VariableTypes::Boolean, '', NewRecordID);

        CreateFunction('ImportAttachmentsFromZip', Categories::FileManagement);

        CreateFunction('SetAttachmentsText', Categories::FileManagement);
        CreateParameter('SetAttachmentsText', Types::Parameter, 'SourceRecord', VariableTypes::Variant, '', SetFixedRecordID(Database::"Purchase Header"));
        CreateParameter('SetAttachmentsText', Types::Parameter, 'AttachmentsText', VariableTypes::Text, '', NewRecordID);
        CreateParameter('SetAttachmentsText', Types::"Return Value", 'AttachmentsText', VariableTypes::Text, '', NewRecordID);

        CreateFunction('ImportAttachmentsFromBase64', Categories::FileManagement);
        CreateParameter('ImportAttachmentsFromBase64', Types::Parameter, 'SourceRecord', VariableTypes::Variant, '', SetFixedRecordID(Database::"Purchase Header"));
        CreateParameter('ImportAttachmentsFromBase64', Types::Parameter, 'AttachmentsInBase64', VariableTypes::Text, '', NewRecordID);
        CreateParameter('ImportAttachmentsFromBase64', Types::Parameter, 'ParFileName', VariableTypes::Text, '', NewRecordID);
        CreateParameter('ImportAttachmentsFromBase64', Types::Parameter, 'FileType', VariableTypes::Text, '', NewRecordID);

        CreateFunction('ExportExcel', Categories::FileManagement);
        CreateParameter('ExportExcel', Types::Parameter, 'SourceRecord', VariableTypes::Variant, '', SetFixedRecordID(Database::"Purchase Header"));

        if EnvironmentInfo.IsSaaSInfrastructure() then begin
            CreateFunction('StringToBarcode', Categories::FileManagement);
            CreateParameter('StringToBarcode', Types::Parameter, 'BarcodeString', VariableTypes::Text, '', NewRecordID);
            CreateParameter('StringToBarcode', Types::"Return Value", 'EncodedText', VariableTypes::Text, '', NewRecordID);
        end;

        OnAfterLoadFunctions();
    end;

    /// <summary>
    /// SetFixedRecordID.
    /// </summary>
    /// <param name="TableID">Integer.</param>
    /// <returns>Return value of type RecordId.</returns>
    procedure SetFixedRecordID(TableID: Integer): RecordId
    var
        Customer: Record Customer;
        PurchaseHeader: Record "Purchase Header";
        CustomRecordID: RecordId;
        IsHandled: Boolean;
    begin
        OnBeforeSetRecordID(TableID, CustomRecordID, IsHandled);
        if IsHandled then
            exit(CustomRecordID);

        case TableID of
            DataBase::Customer:
                begin
                    Customer.Get('10000');
                    exit(Customer.RecordId);
                end;
            Database::"Purchase Header":
                begin
                    PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, '104001');
                    exit(PurchaseHeader.RecordId);
                end;
        end;
    end;

    /// <summary>
    /// CreateFunction.
    /// </summary>
    /// <param name="ParName">Text[50].</param>
    /// <param name="ParCategories">Enum Categories.</param>
    procedure CreateFunction(ParName: Text[50]; ParCategories: Enum Categories);
    var
        Functions: Record Functions;
        Text000Err: Label 'Already exist a function with name %1';
    begin
        Functions.Reset();
        if Functions.Get(ParName) then
            Error(Text000Err, ParName);

        Functions.Init();
        Functions.Validate(Name, ParName);
        Functions.Validate(Category, ParCategories);
        Functions.Insert();
    end;

    /// <summary>
    /// CreateParameter.
    /// </summary>
    /// <param name="FunctionName">Text[50].</param>
    /// <param name="ParTypes">Enum Types.</param>
    /// <param name="ParName">Text[50].</param>
    /// <param name="ParDescription">Text[250].</param>
    /// <param name="VariableTypes">Enum "Variable Types".</param>
    /// <param name="ParRecordID">recordid.</param>
    procedure CreateParameter(FunctionName: Text[50]; ParTypes: Enum Types; ParName: Text[50]; VariableTypes: Enum "Variable Types"; ParDescription: Text[250]; ParRecordID: RecordID)
    var
        FunctionsDetails: Record "Functions Details";
        NextEntryNo: Integer;
    begin
        CheckCorrectFunctionStructure(FunctionName, ParTypes);

        FunctionsDetails.Reset();
        FunctionsDetails.SetRange("Function Name", FunctionName);
        if FunctionsDetails.FindLast() then
            NextEntryNo := FunctionsDetails."Entry No." + 1
        else
            NextEntryNo := 1;

        FunctionsDetails.Init();
        FunctionsDetails.Validate("Function Name", FunctionName);
        FunctionsDetails.Validate("Entry No.", NextEntryNo);
        FunctionsDetails.Validate(Type, ParTypes);
        FunctionsDetails.Validate(Name, ParName);
        FunctionsDetails.Validate(Description, ParDescription);
        FunctionsDetails.Validate("Variable Type", VariableTypes);
        FunctionsDetails.Validate("Record ID", ParRecordID);
        FunctionsDetails.Insert();
    end;

    local procedure CheckCorrectFunctionStructure(FunctionName: Text[50]; ParTypes: Enum Types)
    var
        FunctionsDetails: Record "Functions Details";
        RecordNumber: Integer;
        Text000Err: Label 'Can be managed at most 5 parameters for function.\Error in function: %1';
        Text001Err: Label 'Function can have at most 1 return value.\Error in function: %1';
    begin
        FunctionsDetails.Reset();
        FunctionsDetails.SetRange("Function Name", FunctionName);
        FunctionsDetails.SetRange(Type, ParTypes);
        if FunctionsDetails.IsEmpty() then
            exit;

        RecordNumber := FunctionsDetails.Count();
        case ParTypes of
            Types::Parameter:
                if RecordNumber = 5 then
                    Error(Text000Err, FunctionName);
            Types::"Return Value":
                if RecordNumber = 1 then
                    Error(Text001Err, FunctionName);
        end;
    end;
    #endregion Functions

    #region Events

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLoadFunctions(var IsHanlded: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLoadFunctions()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSetRecordID(TableID: Integer; var ParRecordID: RecordId; var IsHandled: Boolean)
    begin
    end;

    #endregion Events

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        FunctionDetails: Record "Functions Details";
    begin
        FunctionDetails.Reset();
        FunctionDetails.SetRange("Function Name", Rec.Name);
        FunctionDetails.DeleteAll(true);
    end;

    trigger OnRename()
    var
        Text000Err: Label 'Rename is not allowed';
    begin
        Error(Text000Err);
    end;

}