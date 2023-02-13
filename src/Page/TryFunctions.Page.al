/// <summary>
/// Page Try Functions (ID 80000).
/// </summary>
/*
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

    layout
    {
        area(Content)
        {
            group(Functions)
            {
                Caption = 'Functions';
                group(Dates)
                {
                    Caption = 'Dates';
                    field(Dates1; ArrayFunctions[1])
                    {
                        ApplicationArea = All;
                        ToolTip = 'Click to start the execution of the function';
                        ShowCaption = false;
                        Editable = false;

                        trigger OnDrillDown()
                        begin
                            Clear(SetParameters);
                            Clear(ArrayOfVariants);
                            SetParameters.InitiParameters();
                            SetParameters.SetParametersPage(1, VariableTypes::Date);
                            SetParameters.SetCaption(VariableTypes::Date, 1, 'DateToFormat');
                            SetParameters.Caption(ArrayFunctions[1]);
                            SetParameters.RunModal();
                            SetParameters.GetArrayOf(ArrayOfVariants, VariableTypes::Date);
                            Message(ResultLbl + GenericFunctions.FormatDateIntoTxt(ArrayOfVariants[1]));
                        end;
                    }
                    field(Dates2; ArrayFunctions[2])
                    {
                        ApplicationArea = All;
                        ToolTip = 'Click to start the execution of the function';
                        ShowCaption = false;
                        Editable = false;

                        trigger OnDrillDown()
                        begin
                            Clear(SetParameters);
                            Clear(ArrayOfVariants);
                            SetParameters.InitiParameters();
                            SetParameters.SetParametersPage(2, VariableTypes::Date);
                            SetParameters.SetCaption(VariableTypes::Date, 1, 'FromDate');
                            SetParameters.SetCaption(VariableTypes::Date, 2, 'ToDate');
                            SetParameters.Caption(ArrayFunctions[2]);
                            SetParameters.RunModal();
                            SetParameters.GetArrayOf(ArrayOfVariants, VariableTypes::Date);
                            Message(ResultLbl + Format(GenericFunctions.DiffInMonthBetween2Dates(ArrayOfVariants[1], ArrayOfVariants[2])));
                        end;
                    }
                    field(Dates3; ArrayFunctions[3])
                    {
                        ApplicationArea = All;
                        ToolTip = 'Click to start the execution of the function';
                        ShowCaption = false;
                        Editable = false;

                        trigger OnDrillDown()
                        var
                            Text000Lbl: Label '\Go to sites https://www.epochconverter.com/ to see the result';
                        begin
                            Clear(SetParameters);
                            Clear(ArrayOfVariants);
                            SetParameters.InitiParameters();
                            SetParameters.SetParametersPage(1, VariableTypes::"Date-Time");
                            SetParameters.SetCaption(VariableTypes::"Date-Time", 1, 'FromDateTime');
                            SetParameters.Caption(ArrayFunctions[3]);
                            SetParameters.RunModal();
                            SetParameters.GetArrayOf(ArrayOfVariants, VariableTypes::"Date-Time");
                            Message(ResultLbl + Format(GenericFunctions.GetUnixTimeStampText(ArrayOfVariants[1])) + Text000Lbl);
                        end;
                    }
                }
                group(String)
                {
                    Caption = 'String';
                    field(String1; ArrayFunctions[4])
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        Editable = false;

                        trigger OnDrillDown()
                        begin
                            Clear(SetParameters);
                            Clear(ArrayOfVariants);
                            SetParameters.InitiParameters();
                            SetParameters.SetParametersPage(2, VariableTypes::Text);
                            SetParameters.SetCaption(VariableTypes::Text, 1, 'StringToProcess');
                            SetParameters.SetCaption(VariableTypes::Text, 2, 'txtCharsToKeep');
                            SetParameters.Caption(ArrayFunctions[4]);
                            SetParameters.RunModal();
                            SetParameters.GetArrayOf(ArrayOfVariants, VariableTypes::Text);
                            Message(ResultLbl + GenericFunctions.KeepOnlyAllowedChar(ArrayOfVariants[1], ArrayOfVariants[2]));
                        end;
                    }
                    field(String2; ArrayFunctions[9])
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        Editable = false;

                        trigger OnDrillDown()
                        begin
                            Message(ResultLbl + GenericFunctions.GetRandomDigit());
                        end;
                    }
                    field(String3; ArrayFunctions[10])
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        Editable = false;

                        trigger OnDrillDown()
                        begin
                            Clear(SetParameters);
                            Clear(ArrayOfVariants);
                            SetParameters.InitiParameters();
                            SetParameters.SetParametersPage(3, VariableTypes::Text);
                            SetParameters.SetCaption(VariableTypes::Text, 1, 'String');
                            SetParameters.SetCaption(VariableTypes::Text, 2, 'FindWhat');
                            SetParameters.SetCaption(VariableTypes::Text, 3, 'ReplaceWith');
                            SetParameters.Caption(ArrayFunctions[10]);
                            SetParameters.RunModal();
                            SetParameters.GetArrayOf(ArrayOfVariants, VariableTypes::Text);
                            Message(ResultLbl + GenericFunctions.ReplaceString(ArrayOfVariants[1], ArrayOfVariants[2], ArrayOfVariants[3]));
                        end;
                    }
                    field(String4; ArrayFunctions[11])
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        Editable = false;

                        trigger OnDrillDown()
                        begin
                            Clear(SetParameters);
                            Clear(ArrayOfVariants);
                            SetParameters.InitiParameters();
                            SetParameters.SetParametersPage(1, VariableTypes::Text);
                            SetParameters.SetCaption(VariableTypes::Text, 1, 'Name');
                            SetParameters.Caption(ArrayFunctions[11]);
                            SetParameters.RunModal();
                            SetParameters.GetArrayOf(ArrayOfVariants, VariableTypes::Text);
                            Message(ResultLbl + GenericFunctions.ReverseString(ArrayOfVariants[1]));
                        end;
                    }
                    field(String5; ArrayFunctions[12])
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        Editable = false;

                        trigger OnDrillDown()
                        begin
                            Clear(SetParameters);
                            Clear(ArrayOfVariants);
                            SetParameters.InitiParameters();
                            SetParameters.SetParametersPage(2, VariableTypes::Text);
                            SetParameters.SetCaption(VariableTypes::Text, 1, 'String');
                            SetParameters.SetCaption(VariableTypes::Text, 2, 'SubString');
                            SetParameters.Caption(ArrayFunctions[12]);
                            SetParameters.RunModal();
                            SetParameters.GetArrayOf(ArrayOfVariants, VariableTypes::Text);
                            Message(ResultLbl + Format(GenericFunctions.ReverseStrPos(ArrayOfVariants[1], ArrayOfVariants[2])));
                        end;
                    }
                }
                group("Fields")
                {
                    Caption = 'Fields';
                    field(Fields1; ArrayFunctions[5])
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        Editable = false;

                        trigger OnDrillDown()
                        var
                            Customer: Record Customer;
                            Text000Lbl: Label 'Customer 10000 not exist';
                        begin
                            Clear(SetParameters);
                            Clear(ArrayOfVariants);
                            if not Customer.Get('10000') then begin //Work in Cronus DB 
                                Message(Text000Lbl);
                                exit;
                            end;
                            SetParameters.InitiParameters();
                            SetParameters.SetParametersPage(1, VariableTypes::Integer);
                            SetParameters.SetParametersPage(1, VariableTypes::Text);
                            SetParameters.SetCaption(VariableTypes::Integer, 1, 'FilterFieldID');
                            SetParameters.SetCaption(VariableTypes::Text, 1, 'FilterFieldValue');
                            SetParameters.Caption(ArrayFunctions[5]);
                            SetParameters.RunModal();
                            SetParameters.GetArrayOf(ArrayOfVariants, VariableTypes::Integer);
                            SetParameters.GetArrayOf(ArrayOfVariants2, VariableTypes::Text);
                            Message(ResultLbl + Format(GenericFunctions.CheckFilterField(Customer, ArrayOfVariants[1], ArrayOfVariants2[1])));
                        end;
                    }
                }
                group("Files")
                {
                    Caption = 'Files';
                    field(Files1; ArrayFunctions[6])
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        Editable = false;

                        trigger OnDrillDown()
                        var
                            PurchaseHeader: Record "Purchase Header";
                            DocumentAttachment: Record "Document Attachment";
                            Text000Lbl: Label 'Purchase Order 104001 not exist';
                            Text001Lbl: Label 'Purchase Order 104001 does not have any attachments';
                            Text002Lbl: Label '\Go to sites https://base64.guru/converter/decode/file to see the result';
                        begin
                            Clear(SetParameters);
                            Clear(ArrayOfVariants);
                            if not PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, '104001') then begin //Work in Cronus DB 
                                Message(Text000Lbl);
                                exit;
                            end;

                            DocumentAttachment.Reset();
                            DocumentAttachment.SetRange("Table ID", Database::"Purchase Header");
                            DocumentAttachment.SetRange("Document Type", PurchaseHeader."Document Type");
                            DocumentAttachment.SetRange("No.", PurchaseHeader."No.");
                            if DocumentAttachment.IsEmpty() then begin
                                Message(Text001Lbl);
                                exit;
                            end;

                            GenericFunctions.SetAttachmentsText(PurchaseHeader, ArrayOfVariants[1]);
                            Message(ResultLbl + Format(ArrayOfVariants[1]) + Text002Lbl);
                        end;
                    }
                    field(Files2; ArrayFunctions[7])
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        Editable = false;

                        trigger OnDrillDown()
                        var
                            PurchaseHeader: Record "Purchase Header";
                            Text000Lbl: Label 'Purchase Order 104001 not exist';
                            Text001Lbl: Label 'Go to the Purchase Order 104001 and take a look at the attachments factbox';
                        begin
                            Clear(SetParameters);
                            Clear(ArrayOfVariants);
                            if not PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, '104001') then begin //Work in Cronus DB 
                                Message(Text000Lbl);
                                exit;
                            end;

                            SetParameters.SetParametersPage(3, VariableTypes::Text);
                            SetParameters.SetCaption(VariableTypes::Text, 1, 'AttachmentsInBase64');
                            SetParameters.SetCaption(VariableTypes::Text, 2, 'ParFileName');
                            SetParameters.SetCaption(VariableTypes::Text, 3, 'FileType');
                            SetParameters.Caption(ArrayFunctions[7]);
                            SetParameters.RunModal();
                            SetParameters.GetArrayOf(ArrayOfVariants, VariableTypes::Text);

                            GenericFunctions.ImportAttachmentsFromBase64(PurchaseHeader, ArrayOfVariants[1], ArrayOfVariants[2], ArrayOfVariants[3]);
                            Message(ResultLbl + Text001Lbl);
                        end;
                    }
                    field(Files3; ArrayFunctions[8])
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        Editable = false;

                        trigger OnDrillDown()
                        begin
                            GenericFunctions.ImportAttachmentsFromZip();
                        end;
                    }
                    field(Files4; ArrayFunctions[13])
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        Editable = false;

                        trigger OnDrillDown()
                        var
                            PurchaseHeader: Record "Purchase Header";
                            Text000Lbl: Label 'Purchase Order 104001 not exist';
                        begin
                            if not PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, '104001') then begin //Work in Cronus DB 
                                Message(Text000Lbl);
                                exit;
                            end;
                            GenericFunctions.ExportExcel(PurchaseHeader);
                        end;
                    }
                    field(Files5; ArrayFunctions[14])
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        Editable = false;
                        Visible = IsSaasEnvironment;
                        trigger OnDrillDown()
                        begin
                            Clear(SetParameters);
                            Clear(ArrayOfVariants);
                            SetParameters.InitiParameters();
                            SetParameters.SetParametersPage(1, VariableTypes::Text);
                            SetParameters.SetCaption(VariableTypes::Text, 1, 'BarcodeString');
                            SetParameters.Caption(ArrayFunctions[14]);
                            SetParameters.RunModal();
                            SetParameters.GetArrayOf(ArrayOfVariants, VariableTypes::Text);
                            Message(ResultLbl + Format(GenericFunctions.StringToBarcode(ArrayOfVariants[1])));
                        end;
                    }
                }
            }
            repeater(FunctionsDoc)
            {
                Caption = 'Documentation';
                field(FunctionName; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(NoOfParameter; NoOfParameters)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'No. Parameters';
                }
                field(CurrFunctionDocParameters; CurrFunctionDocPar)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Parameters';
                }
                field(CurrFunctionDocReturn; CurrFunctionDocRet)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Return Value';
                }
            }
        }
    }

    local procedure InitFunctionsArray()
    var
        FormatDateIntoTxtLbl: Label 'FormatDateIntoTxt';
        DiffInMonthBetween2DatesLbl: Label 'DiffInMonthBetween2Dates';
        GetUnixTimeStampTextLbl: Label 'GetUnixTimeStampText';
        KeepOnlyAllowedCharLbl: Label 'KeepOnlyAllowedChar';
        CheckFilterFieldLbl: Label 'CheckFilterField';
        SetAttachmentsTextLbl: Label 'SetAttachmentsText';
        ImportAttachmentsFromBase64Lbl: Label 'ImportAttachmentsFromBase64';
        ImportAttachmentsFromZipLbl: Label 'ImportAttachmentsFromZip';
        GetRandomDigitLbl: Label 'GetRandomDigit';
        ReplaceStringLbl: Label 'ReplaceString';
        ReverseStringLbl: Label 'ReverseString';
        ReverseStrPosLbl: Label 'ReverseStrPos';
        ExportExcelLbl: Label 'ExportExcel';
        StringToBarcodeLbl: Label 'StringToBarcode';
    begin
        ArrayFunctions[1] := FormatDateIntoTxtLbl;
        ArrayFunctions[2] := DiffInMonthBetween2DatesLbl;
        ArrayFunctions[3] := GetUnixTimeStampTextLbl;
        ArrayFunctions[4] := KeepOnlyAllowedCharLbl;
        ArrayFunctions[5] := CheckFilterFieldLbl;
        ArrayFunctions[6] := SetAttachmentsTextLbl;
        ArrayFunctions[7] := ImportAttachmentsFromBase64Lbl;
        ArrayFunctions[8] := ImportAttachmentsFromZipLbl;
        ArrayFunctions[9] := GetRandomDigitLbl;
        ArrayFunctions[10] := ReplaceStringLbl;
        ArrayFunctions[11] := ReverseStringLbl;
        ArrayFunctions[12] := ReverseStrPosLbl;
        ArrayFunctions[13] := ExportExcelLbl;
        ArrayFunctions[14] := StringToBarcodeLbl;
    end;

    trigger OnOpenPage()
    var
        EnvironmentInformation: Codeunit "Environment Information";
    begin
        IsSaasEnvironment := EnvironmentInformation.IsSaaSInfrastructure();
        InitFunctionsArray();
        InitFunctionsDocumentation();
    end;

    trigger OnAfterGetRecord()
    begin
        CurrFunctionDocPar := '';
        CurrFunctionDocRet := '';
        NoOfParameters := 0;

        case Rec.Name of
            ArrayFunctions[1]:
                begin
                    NoOfParameters := 1;
                    CurrFunctionDocPar := DocFunctionPar1;
                    CurrFunctionDocRet := DocFunctionRet1;
                end;
            ArrayFunctions[2]:
                begin
                    NoOfParameters := 2;
                    CurrFunctionDocPar := DocFunctionPar2;
                    CurrFunctionDocRet := DocFunctionRet2;
                end;
            ArrayFunctions[3]:
                begin
                    NoOfParameters := 1;
                    CurrFunctionDocPar := DocFunctionPar3;
                    CurrFunctionDocRet := DocFunctionRet3;
                end;
            ArrayFunctions[4]:
                begin
                    NoOfParameters := 2;
                    CurrFunctionDocPar := DocFunctionPar4;
                    CurrFunctionDocRet := DocFunctionRet4;
                end;
            ArrayFunctions[5]:
                begin
                    NoOfParameters := 3;
                    CurrFunctionDocPar := DocFunctionPar5;
                    CurrFunctionDocRet := DocFunctionRet5;
                end;
            ArrayFunctions[6]:
                begin
                    NoOfParameters := 1;
                    CurrFunctionDocPar := DocFunctionPar6;
                    CurrFunctionDocRet := DocFunctionRet6;
                end;
            ArrayFunctions[7]:
                begin
                    NoOfParameters := 4;
                    CurrFunctionDocPar := DocFunctionPar7;
                    CurrFunctionDocRet := '';
                end;
            ArrayFunctions[8]:
                begin
                    NoOfParameters := 0;
                    CurrFunctionDocPar := DocFunctionPar8;
                    CurrFunctionDocRet := '';
                end;
            ArrayFunctions[9]:
                begin
                    NoOfParameters := 0;
                    CurrFunctionDocPar := '';
                    CurrFunctionDocRet := DocFunctionRet9;
                end;
            ArrayFunctions[10]:
                begin
                    NoOfParameters := 3;
                    CurrFunctionDocPar := DocFunctionPar10;
                    CurrFunctionDocRet := DocFunctionRet10;
                end;
            ArrayFunctions[11]:
                begin
                    NoOfParameters := 1;
                    CurrFunctionDocPar := DocFunctionPar11;
                    CurrFunctionDocRet := DocFunctionRet11;
                end;
            ArrayFunctions[12]:
                begin
                    NoOfParameters := 2;
                    CurrFunctionDocPar := DocFunctionPar12;
                    CurrFunctionDocRet := DocFunctionRet12;
                end;
            ArrayFunctions[13]:
                begin
                    NoOfParameters := 1;
                    CurrFunctionDocPar := DocFunctionPar13;
                    CurrFunctionDocRet := '';
                end;
            ArrayFunctions[14]:
                begin
                    NoOfParameters := 1;
                    CurrFunctionDocPar := DocFunctionPar14;
                    CurrFunctionDocRet := DocFunctionPar14;
                end;
        end;
    end;

    var
        GenericFunctions: Codeunit "Generic Functions";
        SetParameters: Page "Set Parameters";
        VariableTypes: Enum "Variable Types";
        IsSaasEnvironment: Boolean;
        ArrayFunctions: array[100] of Text[100];
        ArrayOfVariants: array[5] of Variant;
        ArrayOfVariants2: array[5] of Variant;
        CurrFunctionDocPar: Text;
        CurrFunctionDocRet: Text;
        NoOfParameters: Integer;
        DocFunctionPar1: Label '"DateToFormat" --> Date';
        DocFunctionPar2: Label '"FromDate" --> Date; "ToDate" --> Date';
        DocFunctionPar3: Label '"FromDateTime" --> DateTime';
        DocFunctionPar4: Label '"StringToProcess" --> Text; "txtCharsToKeep" --> Text';
        DocFunctionPar5: Label '"SourceRecord" --> Fixed Customer with code 10000; "FilterFieldID" --> Integer; "FilterFieldValue" --> Integer';
        DocFunctionPar6: Label '"PurchaseHeader" --> Fixed Purchase Order with code 104001';
        DocFunctionPar7: Label '"PurchaseHeader" --> Fixed Purchase Order with code 104001; "AttachmentsInBase64" --> Text; "ParFileName" --> Text ;"FileType" --> Text';
        DocFunctionPar8: Label 'The filename inside the zip must have the same name as an existing customer inside Business Central';
        DocFunctionPar10: Label '"String" --> Text[250]; "FindWhat" --> Text; "ReplaceWith" --> Text';
        DocFunctionPar11: Label '"Name" --> Text[100]';
        DocFunctionPar12: Label '"String" --> Text; "SubString" --> Text';
        DocFunctionPar13: Label '"PurchaseHeader" --> Fixed Purchase Order with code 104001';
        DocFunctionPar14: Label '"BarcodeString" --> Text; Fixed type of barcode: Code39';
        DocFunctionRet1: Label '"DateTxt" --> Text';
        DocFunctionRet2: Label '"NumberOfMonth" --> Integer';
        DocFunctionRet3: Label '"Result" --> Text';
        DocFunctionRet4: Label '"Result" --> Text';
        DocFunctionRet5: Label '"Result" --> Boolean';
        DocFunctionRet6: Label '"AttachmentsText" --> Text';
        DocFunctionRet9: Label '"Result" --> Boolean';
        DocFunctionRet10: Label '"NewString" --> Text[250]';
        DocFunctionRet11: Label '"ReversedName" --> Text[100]';
        DocFunctionRet12: Label '"Position" --> Integer';
        DocFunctionRet14: Label '"EncodedText" --> Text';
        ResultLbl: Label 'Result:\';
}
*/