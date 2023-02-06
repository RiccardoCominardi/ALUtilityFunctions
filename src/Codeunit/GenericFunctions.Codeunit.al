/// <summary>
/// Codeunit Generic Functions (ID 80000).
/// </summary>
codeunit 80000 "Generic Functions"
{
    trigger OnRun()
    begin

    end;

    #region DateFunctions
    /// <summary>
    /// FormatDateIntoTxt.
    /// </summary>
    /// <param name="DateToFormat">Date.</param>
    /// <returns>Return variable DateTxt of type Text.</returns>
    procedure FormatDateIntoTxt(DateToFormat: Date) DateTxt: Text
    begin
        //Example: DateToFormat = '10/10/22' --> Result = '10.10.2022'
        DateTxt := Format(DateToFormat, 0, '<day,2>.<month,2>.<year4>');
    end;

    /// <summary>
    /// DiffInMonthBetween2Dates.
    /// </summary>
    /// <param name="FromDate">Date.</param>
    /// <param name="ToDate">Date.</param>
    /// <returns>Return variable NumberOfMonth of type Integer.</returns>
    procedure DiffInMonthBetween2Dates(FromDate: Date; ToDate: Date) NumberOfMonth: Integer
    begin
        //Example: FromDate = 01/10/22, ToDate = 01/05/23 --> NumberOfMonth = 7
        NumberOfMonth := ((Date2DMY(ToDate, 3) - Date2DMY(FromDate, 3)) * 12) + (Date2DMY(ToDate, 2) - Date2DMY(FromDate, 2));
    end;

    /// <summary>
    /// GetUnixTimeStampText.
    /// </summary>
    /// <param name="FromDateTime">DateTime.</param>
    /// <returns>Return value of type Text.</returns>
    procedure GetUnixTimeStampText(FromDateTime: DateTime) Result: Text
    var
        TypeHelper: Codeunit "Type Helper";
        OriginDateTime: DateTime;
        TimeZoneOffset: Duration;
        TimeStampText: Text;
        TimeStampDecimal: Decimal;
    begin
        //Return a string like this 1662039688900 that indicates the current date-time 
        //To check the conversion go to this link https://www.epochconverter.com/
        TypeHelper.GetUserTimezoneOffset(TimeZoneOffset);
        OriginDateTime := CreateDateTime(DMY2Date(1, 1, 1970), 0T);
        OriginDateTime := OriginDateTime + TimeZoneOffset;
        TimeStampDecimal := FromDateTime - OriginDateTime;
        TimeStampText := Format(TimeStampDecimal);

        Result := DelChr(TimeStampText, '=', '.');
        Result := DelChr(TimeStampText, '=', ',');
        Result := CopyStr(Result, 1, 10);
        exit(Result);
    end;
    #endregion DateFunctions

    #region StringFunctions
    /// <summary>
    /// KeepOnlyAllowedChar.
    /// </summary>
    /// <param name="StringToProcess">Text.</param>
    /// <param name="txtCharsToKeep">Text.</param>
    /// <returns>Return variable Result of type Text.</returns>
    procedure KeepOnlyAllowedChar(StringToProcess: Text; txtCharsToKeep: Text) Result: Text
    begin
        //Insert into txtCharsToKeep all characters that will never be deleted. DelChr is Case - Sensitive
        //Example: StringToProcess = 'Riccardo', txtCharsToKeep = 'rac' --> Result = 'ccar'
        //txtCharsToKeep := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\|!"£$€%&/()=?*^+-<>@àèéòìùÁÉÍÓÚÀÈÌÒÙ.-_,; ''';
        Result := DelChr(StringToProcess, '=', DelChr(StringToProcess, '=', txtCharsToKeep));
    end;

    /// <summary>
    /// GetRandomDigit.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetRandomDigit() Result: Text
    var
        RandomDigit: Text[50];
    begin
        RandomDigit := CreateGuid();
        RandomDigit := DelChr(RandomDigit, '=', '{}-01');
        RandomDigit := CopyStr(RandomDigit, 1, MaxStrLen(RandomDigit));
        Result := RandomDigit;
        exit(Result);
    end;

    /// <summary>
    /// ReplaceString.
    /// </summary>
    /// <param name="String">Text[250].</param>
    /// <param name="FindWhat">Text[250].</param>
    /// <param name="ReplaceWith">Text[250].</param>
    /// <returns>Return variable NewString of type Text[250].</returns>
    procedure ReplaceString(String: Text[250]; FindWhat: Text[250]; ReplaceWith: Text[250]) NewString: Text[250]
    var
        FindPos: Integer;
    begin
        FindPos := StrPos(String, FindWhat);
        while FindPos > 0 do begin
            NewString += DelStr(String, FindPos) + ReplaceWith;
            String := CopyStr(String, FindPos + StrLen(FindWhat));
            FindPos := StrPos(String, FindWhat);
        end;
        NewString += String;
    end;

    #endregion StringFunctions

    #region FieldManagement

    /// <summary>
    /// CheckFilterField.
    /// </summary>
    /// <param name="SourceRecord">Variant.</param>
    /// <param name="FilterFieldID">Integer.</param>
    /// <param name="FilterFieldValue">Text.</param>
    /// <returns>Return variable Result of type Boolean.</returns>
    procedure CheckFilterField(SourceRecord: Variant; FilterFieldID: Integer; FilterFieldValue: Text) Result: Boolean
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        //Check if a field value is contained in and advanced filter
        //Example: Check if customer 1000 is contained in the filter 1000..3000
        Clear(RecRef);
        RecRef.GetTable(SourceRecord);
        RecRef.SetRecFilter();
        FldRef := RecRef.Field(FilterFieldID);
        FldRef.SetFilter(FilterFieldValue);
        Result := not RecRef.IsEmpty();
        exit(Result);
    end;
    #endregion FieldManagement

    #region FileManagement
    /// <summary>
    /// ImportAttachmentsFromZip.
    /// </summary>
    procedure ImportAttachmentsFromZip()
    var
        FileMgt: Codeunit "File Management";
        DataCompression: Codeunit "Data Compression";
        TempBlob: Codeunit "Temp Blob";
        EntryList: List of [Text];
        EntryListKey: Text;
        ZipFileName: Text;
        FileName: Text;
        FileExtension: Text;
        InStream: InStream;
        EntryOutStream: OutStream;
        EntryInStream: InStream;
        Length: Integer;
        SelectZIPFileMsg: Label 'Select ZIP File';
        FileCount: Integer;
        Cust: Record Customer;
        DocAttach: Record "Document Attachment";
        NoCustError: Label 'Customer %1 does not exist.';
        ImportedMsg: Label '%1 attachments Imported successfully.';
    begin
        //Upload zip file
        if not UploadIntoStream(SelectZIPFileMsg, '', 'Zip Files|*.zip', ZipFileName, InStream) then
            Error('');

        //Extract zip file and store files to list type
        DataCompression.OpenZipArchive(InStream, false);
        DataCompression.GetEntryList(EntryList);

        FileCount := 0;

        //Loop files from the list type
        foreach EntryListKey in EntryList do begin
            FileName := CopyStr(FileMgt.GetFileNameWithoutExtension(EntryListKey), 1, MaxStrLen(FileName)); //I nomi file del contenuto, in questo caso, devono avere il medesimo nome del codice cliente 
            FileExtension := CopyStr(FileMgt.GetExtension(EntryListKey), 1, MaxStrLen(FileExtension));
            TempBlob.CreateOutStream(EntryOutStream);
            DataCompression.ExtractEntry(EntryListKey, EntryOutStream, Length);
            TempBlob.CreateInStream(EntryInStream);

            //Import each file where you want
            if not Cust.Get(FileName) then
                Error(NoCustError, FileName);
            Clear(DocAttach);
            DocAttach.Init();
            DocAttach.Validate("Table ID", Database::Customer);
            DocAttach.Validate("No.", FileName);
            DocAttach.Validate("File Name", FileName);
            DocAttach.Validate("File Extension", FileExtension);
            DocAttach."Document Reference ID".ImportStream(EntryInStream, FileName);
            DocAttach.Insert(true);
            FileCount += 1;
        end;

        //Close the zip file
        DataCompression.CloseZipArchive();

        if FileCount > 0 then
            Message(ImportedMsg, FileCount);
    end;

    /// <summary>
    /// SetAttachmentsText.
    /// </summary>
    /// <param name="PurchaseHeader">Record "Purchase Header".</param>
    /// <param name="AttachmentsText">VAR Text.</param>
    procedure SetAttachmentsText(PurchaseHeader: Record "Purchase Header"; var AttachmentsText: Text);
    var
        DocumentAttachment: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        ZipTempBlob: Codeunit "Temp Blob";
        TypeHelper: Codeunit "Type Helper";
        DataCompression: Codeunit "Data Compression";
        Base64Convert: Codeunit "Base64 Convert";
        DocumentStream: OutStream;
        InStr: InStream;
        OuStr: OutStream;
    begin
        //Export document standard table "Document Attachment" into base64.
        //If the file are more than once, the document will be grouped in a zip file
        //This is an exampe with purchase orders
        AttachmentsText := '';

        DocumentAttachment.Reset();
        DocumentAttachment.SetRange("Table ID", Database::"Purchase Header");
        DocumentAttachment.SetRange("Document Type", PurchaseHeader."Document Type");
        DocumentAttachment.SetRange("No.", PurchaseHeader."No.");
        if DocumentAttachment.IsEmpty() then
            exit;

        IF DocumentAttachment.Count() = 1 then begin
            DocumentAttachment.FindFirst();
            TempBlob.CreateOutStream(DocumentStream);
            DocumentAttachment."Document Reference ID".ExportStream(DocumentStream);
            TempBlob.CreateInStream(InStr);

            AttachmentsText := Base64Convert.ToBase64(InStr);
        end else
            if DocumentAttachment.FindSet() then begin
                DataCompression.CreateZipArchive();
                repeat
                    Clear(DocumentStream);
                    Clear(TempBlob);
                    TempBlob.CreateOutStream(DocumentStream);
                    DocumentAttachment."Document Reference ID".ExportStream(DocumentStream);
                    TempBlob.CreateInStream(InStr);
                    DataCompression.AddEntry(InStr, DocumentAttachment."File Name" + '.' + DocumentAttachment."File Extension");
                until DocumentAttachment.Next() = 0;
                Clear(InStr);
                ZipTempBlob.CreateOutStream(OuStr);
                DataCompression.SaveZipArchive(OuStr);
                ZipTempBlob.CreateInStream(InStr);
                AttachmentsText := Base64Convert.ToBase64(InStr);
            end;
    end;

    /// <summary>
    /// ImportAttachmentsFromBase64.
    /// </summary>
    /// <param name="PurchaseHeader">Record "Purchase Header".</param>
    /// <param name="AttachmentsInBase64">Text.</param>
    /// <param name="ParFileName">Text.</param>
    /// <param name="FileType">Text.</param>
    procedure ImportAttachmentsFromBase64(PurchaseHeader: Record "Purchase Header"; AttachmentsInBase64: Text; ParFileName: Text; FileType: Text);
    var
        DocumentAttachment: Record "Document Attachment";
        TempCompanyInformation: Record "Company Information" temporary;
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
        DataCompression: Codeunit "Data Compression";
        B64OutStr: OutStream;
        OutStr: OutStream;
        TempBlobOutStr: OutStream;
        InStr: InStream;
        RecRef: RecordRef;
        "---DecodeFileFromBase64---": Integer;
        Base64Convert: Codeunit "Base64 Convert";
        "---ZipManagement---": Integer;
        EntryList: List of [Text];
        EntryListKey: Text;
        ZipFileName: Text;
        FileName: Text;
        FileExtension: Text;
        InStream: InStream;
        EntryOutStream: OutStream;
        EntryInStream: InStream;
        Length: Integer;
        FileCount: Integer;

    begin
        //ParFileName è utilizzato solo in caso di file singoli. In caso di zip il nome del file viene preso in automatico dalla procedura

        // From InBase64 to BLOB
        /*//Pezzo di codice per salvarsi il Base64 in un campo fisico. Non necessario per l'import efettivo in BC del documento 
        ProkuriaDataLog.CALCFIELDS("Base64 Attachments");
        ProkuriaDataLog."Base64 Attachments".CREATEOUTSTREAM(B64OutStr, TEXTENCODING::UTF8);
        B64OutStr.WRITETEXT(GlobalAttachments);
        */

        //Download file into blob (zip or single file)
        TempCompanyInformation.CALCFIELDS(Picture); //Qualsiasi tabella con un campo blob può essere utilizzata. Serve solo per salavrsi il contenuto del Base64 convertito
        TempCompanyInformation.Picture.CreateOutStream(OutStr);
        Base64Convert.FromBase64(AttachmentsInBase64, OutStr);

        //Gestione zip per importare ogni singolo allegato sull'ordine
        RecRef.GetTable(PurchaseHeader);
        TempCompanyInformation.Picture.CreateInStream(InStr);
        if FileType = '.zip' then begin

            //Extract zip file and store files to list type
            DataCompression.OpenZipArchive(InStr, false);
            DataCompression.GetEntryList(EntryList);

            FileCount := 0;

            //Loop files from the list type
            foreach EntryListKey in EntryList do begin
                FileName := CopyStr(FileManagement.GetFileNameWithoutExtension(EntryListKey), 1, MaxStrLen(FileName));
                FileExtension := CopyStr(FileManagement.GetExtension(EntryListKey), 1, MaxStrLen(FileExtension));
                TempBlob.CreateOutStream(EntryOutStream);
                DataCompression.ExtractEntry(EntryListKey, EntryOutStream, Length);
                TempBlob.CreateInStream(EntryInStream);

                //Import each file where you want
                Clear(DocumentAttachment);
                DocumentAttachment.Init();
                DocumentAttachment.Validate("Table ID", Database::"Purchase Header");
                DocumentAttachment.Validate("No.", PurchaseHeader."No.");
                DocumentAttachment.Validate("Document Type", DocumentAttachment."Document Type"::Order);
                DocumentAttachment.Validate("File Name", FileName);
                DocumentAttachment.Validate("File Extension", FileExtension);
                DocumentAttachment."Document Reference ID".ImportStream(EntryInStream, FileName);
                DocumentAttachment.Insert(true);
                FileCount += 1;
            end;

            //Close the zip file
            DataCompression.CloseZipArchive();
        end else begin
            Clear(TempBlob);
            TempBlob.CreateOutStream(TempBlobOutStr);
            CopyStream(TempBlobOutStr, InStr);
            Clear(DocumentAttachment);

            DocumentAttachment.Init();
            DocumentAttachment.Validate("Table ID", Database::"Purchase Header");
            DocumentAttachment.Validate("No.", PurchaseHeader."No.");
            DocumentAttachment.Validate("Document Type", DocumentAttachment."Document Type"::Order);
            DocumentAttachment.Validate("File Name", ParFileName);
            DocumentAttachment.Validate("File Extension", FileType);
            DocumentAttachment."Document Reference ID".ImportStream(InStr, FileName);
            DocumentAttachment.Insert(true);
        end;
    end;

    /*
    //Tradurre questo codice in modo compilabile x saas per importare i documenti
    LOCAL PROCEDURE InsertAttachmentsWithDLL@1101318012(VAR ProkuriaDataLog@1101318001 : Record 50031;PurchaseHeader@1101318000 : Record 38);
    VAR
      TempBlob@1101318008 : TEMPORARY Record 99008535;
      DocumentAttachment@1101318010 : Record 1173;
      FileManagement@1101318004 : Codeunit 419;
      B64OutStr@1101318002 : OutStream;
      OutStr@1101318003 : OutStream;
      TempBlobOutStr@1101318009 : OutStream;
      InStr@1101318005 : InStream;
      RecRef@1101318006 : RecordRef;
      "---DecodeFileFromBase64---"@1101318015 : Integer;
      Convert@1101318020 : DotNet "'mscorlib'.System.Convert";
      Bytes@1101318018 : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
      MemStream@1101318016 : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.MemoryStream";
      "---ZipManagement---"@1101318012 : Integer;
      NrFiles@1101318013 : Integer;
      ZipArchive@1101318014 : DotNet "'System.IO.Compression, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.Compression.ZipArchive";
      FileList@1101318017 : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Collections.Generic.IReadOnlyList`1";
      ZipArchiveEntry@1101318019 : DotNet "'System.IO.Compression, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.Compression.ZipArchiveEntry";
      FileStream@1101318021 : InStream;
      i@1101318011 : Integer;
      TenantMedia@1101318007 : Record 2000000184;
      tenantOutsr@1101318022 : OutStream;
      ErrorText@1101318023 : Text;
    BEGIN
      // From InBase64 to BLOB
      ProkuriaDataLog.CALCFIELDS("Base64 Attachments");
      ProkuriaDataLog."Base64 Attachments".CREATEOUTSTREAM(B64OutStr, TEXTENCODING::UTF8);
      B64OutStr.WRITETEXT(GlobalAttachments);

      //Download file into blob (zip or single file)
      ProkuriaDataLog.CALCFIELDS(Attachments);
      Bytes := Convert.FromBase64String(GlobalAttachments);
      MemStream := MemStream.MemoryStream(Bytes);
      ProkuriaDataLog.Attachments.CREATEOUTSTREAM(OutStr);
      TenantMedia.Content.CREATEOUTSTREAM(tenantOutsr);
      MemStream.WriteTo(OutStr);
      MemStream.WriteTo(tenantOutsr);

      //Gestione zip per importare ogni singolo allegato sull'ordine
      IF ProkuriaDataLog."File Type" = '.zip' THEN BEGIN
        RecRef.GETTABLE(PurchaseHeader);
        ProkuriaDataLog.Attachments.CREATEINSTREAM(InStr);
        ZipArchive := ZipArchive.ZipArchive(InStr);
        NrFiles := ZipArchive.Entries.Count;
        FileList := ZipArchive.Entries;
        FOR i := 0 TO NrFiles - 1 DO BEGIN
          ZipArchiveEntry := FileList.Item(i);
          FileStream := ZipArchiveEntry.Open;
          TempBlob.INIT();
          TempBlob.Blob.CREATEOUTSTREAM(TempBlobOutStr);
          COPYSTREAM(TempBlobOutStr, FileStream);
          CLEAR(DocumentAttachment);
          DocumentAttachment.SaveAttachment(RecRef, ZipArchiveEntry.Name, TempBlob);
        END;
      END ELSE BEGIN 
        TempBlob.INIT();
        TempBlob.Blob.CREATEOUTSTREAM(TempBlobOutStr);
        COPYSTREAM(TempBlobOutStr, InStr);
        CLEAR(DocumentAttachment);
        DocumentAttachment.SaveAttachment(RecRef, ProkuriaDataLog."Filename Attachment" + ProkuriaDataLog."File Type", TempBlob); 
      END;
    END;
    */
    #endregion FileManagement
    var
        myInt: Integer;
}