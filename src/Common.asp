<%
Option Explicit

'Include Files @0-188D2C1B
%>
<!-- #INCLUDE VIRTUAL="/search/Adovbs.asp" -->
<!-- #INCLUDE VIRTUAL="/search/Classes.asp" -->
<!-- #INCLUDE VIRTUAL="/search/MD5.asp" -->
<%
'End Include Files

'Script Engine Version Check @0-02EA3A85
If ScriptEngineMajorVersion < 5 Then
  Response.Write "Sorry. This program requires VBScript 5.1 to run.<br>You may upgrade your VBScript at http://msdn.microsoft.com/downloads/list/webdev.asp?frame=true."
  Response.End
Else
  If ScriptEngineMajorVersion & ":" & ScriptEngineMinorVersion = "5:0" Then
    Response.Write "Due to a bug in VBScript 5.0, this program would crash your server. See http://support.microsoft.com/default.aspx?scid=kb;EN-US;q240811.<br>" & _
      "Upgrade your VBScript at http://msdn.microsoft.com/downloads/list/webdev.asp?frame=true."
    Response.End
  End If
End If
'End Script Engine Version Check

'Initialize Common Variables @0-3185B0E5
Dim ServerURL : ServerURL = "www.hrolivapropiedades.com.ar/search/"
Dim SecureURL : SecureURL = ""
Dim InputCodePage : InputCodePage = Session.CodePage
Dim CCSDateConstants
Dim TemplatesRepository
Dim EventCaller
Dim ParentPage
Dim DefaultDateFormat
Dim DefaultBooleanFormat
Dim IsMutipartEncoding
Dim objUpload
Dim UploadedFilesCount
Dim CCSConverter
Dim CCSLocales
Dim CCSStyle
Dim CCSUseAmps
Dim CCSIsXHTML : CCSIsXHTML =False
Dim CCSBr, CCSCheckedHTML, CCSSelected, CCSAmps, CCSContentType, CCSFormFilter
If CCSIsXHTML Then 
  CCSBr = "<br />"
  CCSCheckedHTML = """checked"""
  CCSSelected = """selected"""
  CCSAmps = "&amp;"
  CCSUseAmps = True
Else 
  CCSBr = "<br>"
  CCSCheckedHTML = "CHECKED"
  CCSSelected = "SELECTED"
  CCSAmps = "&"
  CCSUseAmps = False
End If
CCSAmps = "&amp;"
CCSUseAmps = True
IsMutipartEncoding = False
If InStr(Request.ServerVariables("CONTENT_TYPE"), "multipart/form-data") > 0 And CCGetFromGet("ccsForm", "") <> "" Then
  Set objUpload = new clsUploadControl
  UploadedFilesCount = objUpload.FilesCount
  IsMutipartEncoding = True
End If
Set CCSLocales = New clsLocales
With CCSLocales
  .AppPrefix = "buscador_Locales_"
  .PathRes = Server.MapPath("/search/")
  .Locales.Add "es-AR", "AR"
  CCLoadStaticTranslation
  .SelectLocale "es-AR", Array("locale", Empty, "locale", "lang", Empty), 365
  .Locale.Charset = "windows-1252"
  .Locale.CodePage = 1252
End With
CCSStyle = "Simple"
Set TemplatesRepository = New clsCache_FileSystem
DefaultDateFormat = IIF(CCSLocales.Locale.OverrideDateFormats, CCSLocales.Locale.ShortDate, Array("ShortDate"))
DefaultBooleanFormat = CCSLocales.Locale.BooleanFormat
Set CCSConverter = New clsConverter
CCSConverter.DateFormat = DefaultDateFormat
CCSConverter.BooleanFormat = DefaultBooleanFormat


Set CCSDateConstants = New clsCCSDateConstants

Class clsCCSDateConstants

  Public Weekdays
  Public ShortWeekdays
  Public Months
  Public ShortMonths
  Public DateMasks

  Private Sub Class_Initialize()
    ShortWeekdays = CCSLocales.Locale.WeekdayShortNames
    Weekdays = CCSLocales.Locale.WeekdayNames
    ShortMonths =  CCSLocales.Locale.MonthShortNames
    Months = CCSLocales.Locale.MonthNames
    Set DateMasks = CreateObject("Scripting.Dictionary")
    DateMasks("d") = 0
    DateMasks("dd") = 2
    DateMasks("ddd") = 0
    DateMasks("dddd") = 0
    DateMasks("m") = 0
    DateMasks("mm") = 2
    DateMasks("mmm") = 3
    DateMasks("mmmm") = 0
    DateMasks("yy") = 2
    DateMasks("yyyy") = 4
    DateMasks("h") = 0
    DateMasks("hh") = 2
    DateMasks("H") = 0
    DateMasks("HH") = 2
    DateMasks("n") = 0
    DateMasks("nn") = 2
    DateMasks("s") = 0
    DateMasks("ss") = 2
    DateMasks("am/pm") = 2
    DateMasks("AM/PM") = 2
    DateMasks("A/P") = 1
    DateMasks("a/p") = 1
    DateMasks("w") = 0
    DateMasks("q") = 0
    DateMasks("S") = 0
    DateMasks("tt") = 2
    DateMasks("wi") = 2
  End Sub

  Private Sub Class_Terminate()
    Set DateMasks = Nothing
  End Sub

End Class

Const ccsInteger = 1
Const ccsFloat = 2
Const ccsText = 3
Const ccsDate = 4
Const ccsBoolean = 5
Const ccsMemo = 6
Const ccsSingle = 7
Const ccsGet = 1
Const ccsPost = 2

Const calYear = 0
Const calQuarter = 1
Const cal3Month = 2
Const calMonth = 3
Const calWeek = 4
Const calDay = 5
Const CCS_ENCRYPTION_KEY_FOR_COOKIE = "3T2661M073b6K5R3"
Dim cipherbox(255) 'Global array is used for crypting
Dim cipherkey(255) 'Global array is used for crypting
'End Initialize Common Variables

'Set CCSContentType @0-DE7CC0E9
CCSContentType = "text/html"
'End Set CCSContentType

'Connection1 Connection Class @-E0DF025B
Class clsDBConnection1

    Public ConnectionString
    Public User
    Public Password
    Public LastSQL
    Public Errors
    Public Converter
    Public Database

    Private mDateFormat
    Private mBooleanFormat
    Private objConnection
    Private blnState

    Private Sub Class_Initialize()
        ConnectionString = "Provider=SQLOLEDB;Server=localhost;Database=hrolivapropiedades;UID=hrolivapropiedades;PWD=propiedad*123"
        User = ""
        Password = ""
        Set Converter = New clsConverter
        Converter.DateFormat = Array("yyyy", "-", "mm", "-", "dd", " ", "HH", ":", "nn", ":", "ss")
        Converter.BooleanFormat = Array(1, 0, Empty)
        Set objConnection = Server.CreateObject("ADODB.Connection")
        Database = "MSSQLServer"
        Set Errors = New clsErrors
    End Sub

    Public Property Get DateFormat()
      DateFormat = Converter.DateFormat
    End Property

    Public Property Get BooleanFormat()
      BooleanFormat = Converter.BooleanFormat
    End Property

    Sub Open()
        On Error Resume Next
        objConnection.Errors.Clear
        objConnection.Open ConnectionString, User, Password
        If Err.Number <> 0 then
            Response.Write "<div><h2>Unable to establish connection to database.</h2>"
            Response.Write "<ul><li><b>Error information:</b>" & CCSBr
            Response.Write Err.Source & " (0x" & Hex(Err.Number) & ")" & CCSBr
            Response.Write Err.Description & "</li>"
            If Err.Number = -2147467259 then _
            Response.Write "<li><b>Other possible cause of this problem:</b>" & CCSBr & "The database cannot be opened, most likely due to incorrect connection settings or insufficient security set on your database folder or file. " & CCSBr & "For more details please refer to <a href='http://support.microsoft.com/default.aspx?scid=kb;en-us;Q306518'>http://support.microsoft.com/default.aspx?scid=kb;en-us;Q306518</a></li>"
            Response.Write "</ul></div>"
            Response.End
        End If
    End Sub

    Sub Close()
        objConnection.Close
    End Sub

    Function Execute(varCMD)
        Dim ErrorMessage, objResult
        Errors.Clear
        Set objResult = Server.CreateObject("ADODB.Recordset")
        objResult.CursorType = adOpenForwardOnly
        objResult.LockType = adLockReadOnly
        If TypeName(varCMD) = "Command" Then
            Set varCMD.ActiveConnection = objConnection
            Set objResult.Source = varCMD
            LastSQL = varCMD.CommandText
        Else
            Set objResult.ActiveConnection = objConnection
            objResult.Source = varCMD
            LastSQL = varCMD
        End If
        On Error Resume Next
        objResult.Open
        Errors.AddError CCProcessError(objConnection)
        On Error Goto 0
        Set Execute = objResult
    End Function

    Property Get Connection()
        Set Connection = objConnection
    End Property

    Property Get State()
        State = objConnection.State
    End Property

    Function ToSQL(Value, ValueType)
        Dim mValue
        Dim needEscape : needEscape = True
        If TypeName(Value) = "clsSQLParameter" or TypeName(Value) = "clsField" Then 
            mValue = Value.SQLText
             needEscape = False
        Else 
            mValue = Value
        End If
        If CStr(mValue) = "" OR IsEmpty(mValue) Then
            ToSQL = "Null"
        Else
            Select Case ValueType
                Case ccsDate
                    If VarType(mValue)=vbDate And TypeName(Value) <> "clsSQLParameter" Then _
                        mValue = CCFormatDate(mValue, DateFormat)
                Case ccsBoolean
                    If VarType(mValue)=vbBoolean And TypeName(Value) <> "clsSQLParameter" Then _
                        mValue= CCFormatBoolean(mValue, BooleanFormat)
            End Select

            If ValueType = ccsInteger or ValueType = ccsFloat or ValueType = ccsSingle Then
                ToSQL = Replace(mValue, ",", ".")
            ElseIf ValueType = ccsDate Then
                ToSQL = "'" & mValue & "'"
            Else
                If needEscape And CStr(mValue) <> "" Then mValue = EscapeChars(mValue)
                ToSQL = "N'" & mValue & "'"
            End If
        End If
    End Function

    Function ToLikeCriteria(Value, CriteriaType)
        Select Case CriteriaType
            Case opBeginsWith
                ToLikeCriteria =  " like N'" & Value & "%'"
            Case opNotBeginsWith
                ToLikeCriteria =  " not like N'" & Value & "%'"
            Case opEndsWith
                ToLikeCriteria =  " like N'%" & Value & "'"
            Case opNotEndsWith
                ToLikeCriteria =  " not like N'%" & Value & "'"
            Case opContains
                ToLikeCriteria =  " like N'%" & Value & "%'"
            Case opNotContains
                ToLikeCriteria =  " not like N'%" & Value & "%'"
        End Select
    End Function

    Function EscapeChars(Value)
        EscapeChars = Replace(Value, "'", "''")
    End Function

End Class
'End Connection1 Connection Class

'IIf @0-E12349E2
Function IIf(Expression, TrueResult, FalseResult)
  If CBool(Expression) Then
    If IsObject(TrueResult) Then _
      Set IIf = TrueResult _
    Else _
      IIf = TrueResult
  Else
    If IsObject(FalseResult) Then _
      Set IIf = FalseResult _
    Else _
      IIf = FalseResult
  End If
End Function
'End IIf

'Print @0-065FC167
Sub Print(Value)
  Response.Write CStr(Value)
End Sub
'End Print

'CCRaiseEvent @0-5BA4885B
Function CCRaiseEvent(Events, EventName, Caller)
  Dim Result
  Dim EC : Set EC = New clsEventCaller
  If Events.Exists(EventName) Then
    Set EventCaller = Caller
    Set EC.EventRef = Events(EventName)
    Result = EC.Invoke(Caller)
  End If
  Set EventCaller = Nothing
  If VarType(Result) = vbEmpty Then _
    Result = True
  CCRaiseEvent = Result
End Function
'End CCRaiseEvent

'CCFormatError @0-0E129571
Function CCFormatError(Title, Errors)
  Dim Result, i
  Result = "<p>Form: " & CCToHTML(Title) & CCSBr
  For i = 0 To Errors.Count - 1
    Result = Result & "Error: " & Replace(CCToHTML(Replace(Errors.ErrorByNumber(i), CCSBr, vbCrLf)), vbCrLf, CCSBr)
    If i < Errors.Count - 1 Then Result = Result & CCSBr
  Next
  Result = Result & "</p>"
  CCFormatError = Result
End Function
'End CCFormatError

'CCOpenRS @0-CE675EC5
Function CCOpenRS(RecordSet, SQL, Connection, ShowError)
  Dim ErrorMessage, Result
  Result = Empty
  Set RecordSet = Server.CreateObject("ADODB.Recordset")
  On Error Resume Next
  RecordSet.Open SQL, Connection, adOpenForwardOnly, adLockReadOnly, adCmdText
  ErrorMessage = CCProcessError(Connection)
  If NOT IsEmpty(ErrorMessage) Then
    If ShowError Then
      Result = "SQL: " & CommandObject.CommandText & CCSBr & "Error: " & ErrorMessage & CCSBr
    Else
      Result = "Database error." & CCSBr
    End If
  End If
  On Error Goto 0
  CCOpenRS = Result

End Function
'End CCOpenRS

'CCOpenRSFromCmd @0-A15335B4
Function CCOpenRSFromCmd(RecordSet, CommandObject, ShowError)

  Dim ErrorMessage, Result
  Result = Empty
  Set RecordSet = Server.CreateObject("ADODB.Recordset")
  On Error Resume Next
  RecordSet.CursorType = adOpenForwardOnly
  RecordSet.LockType = adLockReadOnly
  RecordSet.Open CommandObject
  ErrorMessage = CCProcessError(CommandObject.ActiveConnection)
  If NOT IsEmpty(ErrorMessage) Then
    If ShowError Then
      Result = "SQL: " & CommandObject.CommandText & CCSBr & "Error: " & ErrorMessage & CCSBr
    Else
      Result = "Database error." & CCSBr
    End If
  End If
  On Error Goto 0
  CCOpenRSFromCmd = Result

End Function
'End CCOpenRSFromCmd

'CCExecCmd @0-A47C856B
Function CCExecCmd(CommandObject, ShowError)
  Dim ErrorMessage, Result
  Result = Empty
  On Error Resume Next
  CommandObject.Execute
  ErrorMessage = CCProcessError(CommandObject.ActiveConnection)
  If NOT IsEmpty(ErrorMessage) Then 
    If ShowError Then
      Result = "SQL: " & CommandObject.CommandText & CCSBr & "Error: " & ErrorMessage & CCSBr
    Else
      Result = "Database error." & CCSBr
    End If
  End If
  On Error Goto 0
  CCExecCmd = Result
End Function
'End CCExecCmd

'CCExecSQL @0-B07835E6
Function CCExecSQL(SQL, Connection, ShowError)
  Dim ErrorMessage, Result
  Result = Empty
  On Error Resume Next
  Connection.Execute(SQL)
  ErrorMessage = CCProcessError(Connection)
  If NOT IsEmpty(ErrorMessage) Then
    If ShowError Then
      Result = "SQL: " & SQL & CCSBr & "Error: " & ErrorMessage & CCSBr
    Else
      Result = "Database error." & CCSBr
    End If
  End If
  On Error Goto 0
  CCExecSQL = Result
End Function
'End CCExecSQL

'CCToHTML @0-44D2E9F4
Function CCToHTML(Value)
  If IsNull(Value) Then Value = ""
  CCToHTML = Server.HTMLEncode(Value)
End Function
'End CCToHTML

'CCToURL @0-65A12C1D
Function CCToURL(Value)
  If IsNull(Value) Then Value = ""
  CCToURL = CCURLEncode(Value)
End Function
'End CCToURL

'CCEscapeLOV @0-B9505CBC
Function CCEscapeLOV(Value)
  CCEscapeLOV = Replace(Replace(CStr(Value), "\", "\\"), ";", "\;")
End Function
'End CCEscapeLOV

'CCUnEscapeLOV @0-4C1E08FE
Function CCUnEscapeLOV(Value)
  CCUnEscapeLOV = Replace(Replace(CStr(Value), "\;", ";"), "\\", "\")
End Function
'End CCUnEscapeLOV

'CCGetValueHTML @0-30C69AED
Function CCGetValueHTML(RecordSet, FieldName)
  CCGetValueHTML = CCToHTML(CCGetValue(RecordSet, FieldName))
End Function
'End CCGetValueHTML

'CCGetValue @0-6DE3A4C2
Function CCGetValue(RecordSet, FieldName)
  Dim Result
  On Error Resume Next
  If RecordSet Is Nothing Then
    CCGetValue = Empty
  ElseIf (NOT RecordSet.EOF) AND (FieldName <> "") Then
    Result = RecordSet(FieldName)
    If IsEmpty(Result) And CCRegExpTest(FieldName, "^[\[`].*[\]`]$", True, True) Then _
      Result = RecordSet(Mid(FieldName, 2, Len(FieldName) - 2))
    If IsNull(Result) Then _
      Result = Empty
    CCGetValue = Result
  Else
    CCGetValue = Empty
  End If
  On Error Goto 0
End Function
'End CCGetValue

'CCGetDate @0-4102C01B
Function CCGetDate(RecordSet, FieldName, arrDateFormat)
  Dim Result  
  Result = CCGetValue(RecordSet, FieldName)
  If Not IsEmpty(arrDateFormat) Then 
    If Not (VarType(Result) = vbDate OR VarType(Result) = vbEmpty) Then _
      If CCValidateDate(Result, arrDateFormat) Then _
        Result = CCParseDate(Result, arrDateFormat)
  End If
  CCGetDate = Result
End Function
'End CCGetDate

'CCGetBoolean @0-C64EED38
Function CCGetBoolean(RecordSet, FieldName, BooleanFormat)
  Dim Result
  Result = CCGetValue(RecordSet, FieldName)
  CCGetBoolean = CCParseBoolean(Result, BooleanFormat)
End Function
'End CCGetBoolean

'CCGetParam @0-07E4C55C
Function CCGetParam(ParameterName, DefaultValue)
  Dim ParameterValue : ParameterValue = ""
  If IsMutipartEncoding Then
    If Request.QueryString(ParameterName).Count > 0 Then 
      ParameterValue = Request.QueryString(ParameterName)
    Else
      ParameterValue = objUpload.Form(ParameterName)
    End If
    If ParameterValue = "" Then ParameterValue = DefaultValue
  Else
    If Request.QueryString(ParameterName).Count > 0 Then 
      ParameterValue = Request.QueryString(ParameterName)
    ElseIf Request.Form(ParameterName).Count > 0 Then
      ParameterValue = Request.Form(ParameterName)
    Else 
      ParameterValue = DefaultValue
    End If
  End If

  CCGetParam = ParameterValue
End Function
'End CCGetParam

'CCGetRequestParams @0-74FBFB23
Function CCGetRequestParams(ParameterName, Method)
  Dim ParamCount 
  If Method = ccsGet Then
    ParamCount = Request.QueryString(ParameterName).Count
  ElseIf Method = ccsPost Then
    If IsMutipartEncoding Then
      Dim TempArray
      TempArray = Split(objUpload.Form(ParameterName), ", ")
      ParamCount = UBound(TempArray) + 1
    Else
      ParamCount = Request.Form(ParameterName).Count
    End If 
  End If 
  If ParamCount<=1 Then 
    CCGetRequestParams=CCGetRequestParam(ParameterName, Method)
  Else
    CCGetRequestParams=CCGetRequestMultipleParam(ParameterName, Method)
  End If 
End Function
'End CCGetRequestParams

'CCGetFromPost @0-EB8B7999
Function CCGetFromPost(ParameterName, DefaultValue)
  Dim ParameterValue : ParameterValue = Empty

  If IsMutipartEncoding Then
    ParameterValue = objUpload.Form(ParameterName)
    If ParameterValue = "" Then ParameterValue = DefaultValue
  Else
    ParameterValue = Request.Form(ParameterName)
    If IsEmpty(ParameterValue) Then 
      ParameterValue = DefaultValue
    End If
  End If

  CCGetFromPost = ParameterValue
End Function
'End CCGetFromPost

'CCGetFromGet @0-F6BB8115
Function CCGetFromGet(ParameterName, DefaultValue)
  Dim ParameterValue : ParameterValue = Empty
  ParameterValue = Request.QueryString(ParameterName)
  If IsEmpty(ParameterValue) Then _
    ParameterValue = DefaultValue
  CCGetFromGet = ParameterValue
End Function
'End CCGetFromGet

'CCGetFromGet @0-98B3E80A
Function CCGetFromGetFirst(ParameterName, DefaultValue)
  Dim ParameterValue : ParameterValue = Empty
  If Request.QueryString(ParameterName).Count = 1 Then 
    ParameterValue = Request.QueryString(ParameterName)
  ElseIf Request.QueryString(ParameterName).Count > 1 Then 
    ParameterValue = Request.QueryString(ParameterName)(1)
  End If
  If IsEmpty(ParameterValue) Then _
    ParameterValue = DefaultValue
  CCGetFromGetFirst = ParameterValue
End Function
'End CCGetFromGet

'CCGetCookie @0-A1C61499
Function CCGetCookie(Name)
 Dim q
 For Each q in Request.Cookies
   If (q = Name And Request.Cookies(q) <> "") Then 
     CCGetCookie = Request.Cookies(q)
     Exit Function
   End If
 Next
 CCGetCookie = Empty
End Function
'End CCGetCookie

'CCToSQL @0-131A8AA9
Function CCToSQL(Value, ValueType)
  If CStr(Value) = "" OR IsEmpty(Value) Then
   CCToSQL = "Null"
  Else
    If ValueType = "Integer" or ValueType = "Float" Then
      CCToSQL = Replace(CDbl(Value), ",", ".")
    ElseIf  ValueType = "Single" Then 
      CCToSQL = Replace(CSng(Value), ",", ".")
    Else 
      CCToSQL = "'" & Replace(Value, "'", "''") & "'"
    End If
  End If
End Function
'End CCToSQL

'CCDLookUp @0-49D86A74
Function CCDLookUp(ColumnName, TableName, Where, Connection)
  Dim RecordSet
  Dim Result
  Dim SQL
  Dim ErrorMessage

  SQL = "SELECT " & ColumnName 
  If Len(CStr(TableName)) > 0 Then SQL = SQL & " FROM "  & TableName 
  If Len(CStr(Where))     > 0 Then SQL = SQL & " WHERE " & Where

  Set RecordSet = Connection.Execute(SQL)
  ErrorMessage = CCProcessError(Connection)
  If NOT IsEmpty(ErrorMessage) Then
    PrintDBError "CCDLookUp function", CCToHTML(SQL), ErrorMessage
  End If
  On Error Goto 0
  Result = CCGetValue(RecordSet, 0)
  CCDLookUp = Result
End Function
'End CCDLookUp

'Min @0-D2DE75DE
Function Min(Value1, Value2)
  Dim result
  If IsEmpty(Value1) Then Min = Value2
  If IsEmpty(Value2) Then Min = Value1
  If Not IsEmpty(Value1) And Not IsEmpty(Value2) Then 
    If Value1 < Value2 Then 
      Min = Value1
    Else
      Min = Value2
    End If
  End If
End Function
'End Min

'Max @0-E097390A
Function Max(Value1, Value2)
  Dim result
  If IsEmpty(Value1) Then Max = Value2
  If IsEmpty(Value2) Then Max = Value1
  If Not IsEmpty(Value1) And Not IsEmpty(Value2) Then 
    If Value1 > Value2 Then 
      Max = Value1
    Else
      Max = Value2
    End If
  End If
End Function
'End Max

'CCGetOriginalFileName @0-3A7CB06E
Function CCGetOriginalFileName(Value)
  If CCRegExpTest(Value, "^\d{14,}\.", True,True) Then
    CCGetOriginalFileName = Mid(Value, InStr(Value,".")+1)   
  Else 
   CCGetOriginalFileName = Value
  End If
End Function
'End CCGetOriginalFileName

'PrintDBError @0-E1073A82
Sub PrintDBError(Source, SQL, ErrorMessage)
  Dim CommandText
  Dim SourceText
  Dim ErrorText

  If Source <> "" Then SourceText = "<b>Source:</b> " & Source & CCSBr
  If SQL <> "" Then CommandText = "<b>Command Text:</b> " & SQL & CCSBr
  If ErrorMessage <> "" Then ErrorText = "<b>Error description:</b> " & CCToHTML(ErrorMessage) & "</div>"

  Response.Write "<div style=""background-color: rgb(250, 250, 250); " & _
    "border: solid 1px rgb(200, 200, 200);"">" & SourceText
  Response.Write CommandText & ErrorText
End Sub
'End PrintDBError

'CCGetCheckBoxValue @0-E17ABD19
Function CCGetCheckBoxValue(Value, CheckedValue, UncheckedValue, ValueType)
  If isEmpty(Value) Then
    If UncheckedValue = "" Then
      CCGetCheckBoxValue = "Null"
    Else
      If ValueType = "Integer" or ValueType = "Float" or ValueType = "Single" Then
        CCGetCheckBoxValue = UncheckedValue
      Else
        CCGetCheckBoxValue = "'" & Replace(UncheckedValue, "'", "''") & "'"
      End If
    End If
  Else
    If CheckedValue = "" Then
      CCGetCheckBoxValue = "Null"
    Else
      If ValueType = "Integer" OR ValueType = "Float"  OR ValueType = "Single" Then
        CCGetCheckBoxValue = CheckedValue
      Else
        CCGetCheckBoxValue = "'" & Replace(CheckedValue, "'", "''") & "'"
      End If
    End If
  End If
End Function
'End CCGetCheckBoxValue

'CCGetValFromLOV @0-5041B9C1
Function CCGetValFromLOV(Value, ListOfValues)
  Dim I
  Dim Result : Result = ""
  If (Ubound(ListOfValues) MOD 2) = 1 Then
    For I = 0 To Ubound(ListOfValues) Step 2
      If CStr(Value) = CStr(ListOfValues(I)) Then Result = ListOfValues(I + 1)
    Next
  End If
  CCGetValFromLOV = Result  
End Function
'End CCGetValFromLOV

'CCProcessError @0-A3A2654C
Function CCProcessError(Connection)
  If Connection.Errors.Count > 0 Then
    If TypeName(Connection) = "Connection" Then
      CCProcessError = Connection.Errors(0).Description & " (" & Connection.Errors(0).Source & ")"
    Else
      CCProcessError = Connection.Errors.ToString
    End If
  ElseIf NOT (Err.Description = "") Then
    CCProcessError = Err.Description
  Else
    CCProcessError = Empty
  End If
end Function
'End CCProcessError

'CCGetRequestParam @0-1DD6A561
Function CCGetRequestParam(ParameterName, Method)
  Dim ParameterValue

  If Method = ccsGet Then
    ParameterValue = Request.QueryString(ParameterName)
  ElseIf Method = ccsPost Then
    If IsMutipartEncoding Then
      ParameterValue = objUpload.Form(ParameterName)
      If Len(ParameterValue) = 0 Then 
        If Not IsEmpty(objUpload.Files(ParameterName)) Then ParameterValue = objUpload.Files(ParameterName).FileName
      End If
    Else
      ParameterValue = Request.Form(ParameterName)
    End If
  End If
  If CStr(ParameterValue) = "" Then _
    ParameterValue = Empty

  CCGetRequestParam = ParameterValue
End Function


Function CCGetRequestMultipleParam(ParameterName, Method)
  Dim ParameterValues(), ParamCount, i 

  If Method = ccsGet Then
    ParamCount = Request.QueryString(ParameterName).Count
    ReDim ParameterValues (ParamCount)
    For i = 1 To ParamCount
      ParameterValues(i) = Request.QueryString(ParameterName)(i)
      If CStr(ParameterValues(i)) = "" Then ParameterValues(i) = Empty
    Next
  ElseIf Method = ccsPost Then

    If IsMutipartEncoding Then
      Dim TempArray
      TempArray = Split(objUpload.Form(ParameterName), ", ")
      ParamCount = UBound(TempArray) + 1
      ReDim ParameterValues (ParamCount)
      For i = 0 to ParamCount - 1
        ParameterValues(i+1) = TempArray(i)
      Next
    Else
      ParamCount = Request.Form(ParameterName).Count
      ReDim ParameterValues (ParamCount)
      For i = 1 To ParamCount
        ParameterValues(i) = Request.Form(ParameterName)(i)
        If CStr(ParameterValues(i)) = "" Then ParameterValues(i) = Empty
      Next
    End If

  End If

  CCGetRequestMultipleParam = ParameterValues
End Function
'End CCGetRequestParam

'CCIsDefined @0-519FFE4F
  Function CCIsDefined(ParameterName, Scope)
   Select Case Scope
     Case "URL" 
        CCIsDefined = Not IsEmpty(Request.QueryString(ParameterName))
     Case "Form","Control"
        If IsMutipartEncoding Then
    	  CCIsDefined = Not IsEmpty(objUpload.Form(ParameterName))
	Else
    	  CCIsDefined = Not IsEmpty(Request.Form(ParameterName))
    	End If
     Case "Session"
    	CCIsDefined = Not IsEmpty(Session(ParameterName))
     Case "Application"
        CCIsDefined = Not IsEmpty(Application(ParameterName))
     Case "Cookie"
        CCIsDefined = Request.Cookies(ParameterName).HasKeys
     Case Else
        CCIsDefined = True
     End Select
  End Function
'End CCIsDefined

'CCAddGlobalRemoveParameter @0-B0F76355
  Dim GlobalRemoveParameters
  GlobalRemoveParameters=Array()

  Function CCAddGlobalRemoveParameter(newElement)
    ReDim Preserve GlobalRemoveParameters( UBound(GlobalRemoveParameters) + 1 )
    GlobalRemoveParameters( UBound(GlobalRemoveParameters) ) = newElement
  End Function
'End CCAddGlobalRemoveParameter

'CCGetQueryString @0-87E8E299
Function CCGetQueryString(CollectionName, RemoveParameters)
  Dim QueryString, PostData, DuplicatedElements, l1, l2, j

  l1 = UBound(GlobalRemoveParameters)
  If l1 >= 0 Then 
    l1 = UBound(GlobalRemoveParameters)-LBound(GlobalRemoveParameters)+1
    If TypeName(RemoveParameters) <> "Variant()" Then _
      RemoveParameters = Split(RemoveParameters, ";")
    l2=UBound(RemoveParameters)-LBound(RemoveParameters)+1
    If UBound(RemoveParameters)>=0 Then
      Redim  Preserve RemoveParameters(l1 + l2)
      For j = LBound(GlobalRemoveParameters) To UBound(GlobalRemoveParameters)
        RemoveParameters(l2 + j) = GlobalRemoveParameters(j)
      Next
    Else 
      RemoveParameters = GlobalRemoveParameters
    End If	
  End if


  If CollectionName = "Form" Then
    QueryString = CCCollectionToString(Request.Form, RemoveParameters)
  ElseIf CollectionName = "QueryString" Then
    QueryString = CCCollectionToString(Request.QueryString, RemoveParameters)
  ElseIf CollectionName = "All" Then
    Dim RemoveParametersArray
    If TypeName(RemoveParameters) = "Variant()" Then RemoveParametersArray = RemoveParameters _
    Else RemoveParametersArray = Split(RemoveParameters, ";")
    QueryString = CCCollectionToString(Request.QueryString, RemoveParametersArray)
    DuplicatedElements = CCGetDuplicatedElementsNames(Request.Form, Request.QueryString)
    PostData = CCCollectionToString(Request.Form, IIf(Join(RemoveParametersArray, ";")<>"" And DuplicatedElements<>"", Split(Join(RemoveParametersArray, ";")+";"+DuplicatedElements, ";"), RemoveParametersArray))
    If Len(PostData) > 0 and Len(QueryString) > 0 Then _
      QueryString = QueryString & "&" & PostData _
    Else _
      QueryString = QueryString & PostData
  Else
    Err.Raise 1050, "Common Functions. CCGetQueryString Function", _
      "The CollectionName contains an illegal value."
  End If

  CCGetQueryString = QueryString
End Function
'End CCGetQueryString

'CCDuplicateElementsNames @0-930C346B
Function CCGetDuplicatedElementsNames(ParametersCollection1, ParametersCollection2)
  Dim ItemName, ItemValue, Result, Remove, I

  For Each ItemName In ParametersCollection1
    If ParametersCollection2(ItemName).Count > 0 Then
      Result = Result & ";" & ItemName
    End If
  Next

  If Len(Result) > 0 Then _
    Result = Mid(Result, 2)
  CCGetDuplicatedElementsNames = Result
End Function
'End CCDuplicateElementsNames

'CCCollectionToString @0-27665AFA
Function CCCollectionToString(ParametersCollection, RemoveParameters)
  Dim ItemName, ItemValue, Result, Remove, I

  For Each ItemName In ParametersCollection
    Remove = false
    If IsArray(RemoveParameters) Then
      For I = 0 To UBound(RemoveParameters)
        If RemoveParameters(I) = ItemName Then 
          Remove = True
          Exit For
        End If
      Next
    End If
    If Not Remove Then
      If ParametersCollection(ItemName).Count = 1 Then
        Result = Result & _
          "&" & CCURLEncode(ItemName) & "=" & CCURLEncode(ParametersCollection(ItemName))
      Else
        For Each ItemValue In ParametersCollection(ItemName)
          Result = Result & _
            "&" & CCURLEncode(ItemName) & "=" & CCURLEncode(ItemValue)
        Next
      End If
    End If
  Next

  If Len(Result) > 0 Then _
    Result = Mid(Result, 2)
  CCCollectionToString = Result
End Function
'End CCCollectionToString

'CCAddZero @0-B5648418
Function CCAddZero(Value, ResultLength)
  Dim CountZero, I

  CountZero = ResultLength - Len(Value)
  For I = 1 To CountZero
    Value = "0" & Value
  Next 
  CCAddZero = Value
End Function
'End CCAddZero

'CCGetAMPM @0-CB6EA5BF
Function CCGetAMPM(HoursNumber, AnteMeridiem, PostMeridiem)
  If HoursNumber >= 0 And HoursNumber < 12 Then
    CCGetAMPM = AnteMeridiem
  Else
    CCGetAMPM = PostMeridiem
  End If
End Function
'End CCGetAMPM

'CC12Hour @0-12B00AFF
Function CC12Hour(HoursNumber)
  If HoursNumber = 0 Then
    HoursNumber = 12
  ElseIf HoursNumber > 12 Then
    HoursNumber = HoursNumber - 12
  End If
  CC12Hour = HoursNumber 
End Function
'End CC12Hour

'CCDBFormatByType @0-531721B5
Function CCDBFormatByType(Variable)
  Dim Result
  If VarType(Variable) = vbString Then
    If LCase(Variable) = "null" Then
      Result = Variable
    Else
      Result = "'" & Variable & "'"
    End If
  Else
    Result = CStr(Variable)
  End If
  CCDBFormatByType = Result
End Function

'End CCDBFormatByType

'CCFormatDate @0-2C65B861
Function CCFormatDate(DateToFormat, FormatMask)
  Dim ResultArray(), I, Result
  If VarType(DateToFormat) = vbEmpty Then
    Result = Empty
  ElseIf VarType(DateToFormat) <> vbDate Then
    Err.Raise 4000, "Common Functions. CCFormatDate function","Type mismatch."
  ElseIf IsEmpty(FormatMask) Then
    Result = CStr(DateToFormat)
  Else
    If CCSLocales.Locale.OverrideDateFormats Then
      Select Case FormatMask(0)
        Case "LongDate" FormatMask = CCSLocales.Locale.LongDate
        Case "LongTime" FormatMask = CCSLocales.Locale.LongTime
        Case "ShortDate" FormatMask = CCSLocales.Locale.ShortDate
        Case "ShortTime" FormatMask = CCSLocales.Locale.ShortTime
        Case "GeneralDate" FormatMask = CCSLocales.Locale.GeneralDate
	Case "ReportDate" FormatMask=Split(Join(CCSLocales.Locale.ShortDate,"|") & "| |" & Join(CCSLocales.Locale.ShortTime,"|"), "|")
      End Select
    End If
    ReDim ResultArray(UBound(FormatMask))
    For I = 0 To UBound(FormatMask)
      Select Case FormatMask(I)
        Case "d" ResultArray(I) = Day(DateToFormat)
        Case "w" ResultArray(I) = Weekday(DateToFormat)
        Case "m" ResultArray(I) = Month(DateToFormat)
        Case "q" ResultArray(I) = Fix((Month(DateToFormat) + 2) / 3)
        Case "y" ResultArray(I) = (DateDiff("d", DateSerial(Year(DateToFormat), 1, 1), DateSerial(Year(DateToFormat), Month(DateToFormat), Day(DateToFormat))) + 1)
        Case "h" ResultArray(I) = CC12Hour(Hour(DateToFormat))
        Case "H" ResultArray(I) = Hour(DateToFormat)
        Case "n" ResultArray(I) = Minute(DateToFormat)
        Case "s" ResultArray(I) = Second(DateToFormat)
        Case "wi" ResultArray(I) = CCSLocales.Locale.WeekdayNarrowNames(Weekday(DateToFormat) - 1)
        Case "dd" ResultArray(I) = CCAddZero(Day(DateToFormat), 2)
        Case "ww" ResultArray(I) = (DateDiff("ww", DateSerial(Year(DateToFormat), 1, 1), DateSerial(Year(DateToFormat), Month(DateToFormat),Day(DateToFormat))) + 1)
        Case "mm" ResultArray(I) = CCAddZero(Month(DateToFormat), 2)
        Case "yy" ResultArray(I) = Right(Year(DateToFormat), 2)
        Case "hh" ResultArray(I) = CCAddZero(CC12Hour(Hour(DateToFormat)), 2)
        Case "HH" ResultArray(I) = CCAddZero(Hour(DateToFormat), 2)
        Case "nn" ResultArray(I) = CCAddZero(Minute(DateToFormat), 2)
        Case "ss" ResultArray(I) = CCAddZero(Second(DateToFormat), 2)
        Case "S" ResultArray(I) = "000"
        Case "ddd" ResultArray(I) = CCSLocales.Locale.WeekdayShortNames(Weekday(DateToFormat) - 1)
        Case "mmm" ResultArray(I) = CCSLocales.Locale.MonthShortNames(Month(DateToFormat) - 1)
        Case "A/P" ResultArray(I) = CCGetAMPM(Hour(DateToFormat), "A", "P")
        Case "a/p" ResultArray(I) = CCGetAMPM(Hour(DateToFormat), "a", "p")
        Case "dddd" ResultArray(I) = CCSLocales.Locale.WeekdayNames(Weekday(DateToFormat) - 1)
        Case "mmmm" ResultArray(I) = CCSLocales.Locale.MonthNames(Month(DateToFormat) - 1)
        Case "yyyy" ResultArray(I) = Year(DateToFormat)
        Case "AM/PM" ResultArray(I) = CCGetAMPM(Hour(DateToFormat), "AM", "PM")
        Case "am/pm" ResultArray(I) = CCGetAMPM(Hour(DateToFormat), "am", "pm")
        Case "LongDate" ResultArray(I) = FormatDateTime(DateToFormat, vbLongDate)
        Case "LongTime" ResultArray(I) = FormatDateTime(DateToFormat, vbLongTime)
        Case "ShortDate" ResultArray(I) = FormatDateTime(DateToFormat, vbShortDate)
        Case "ShortTime" ResultArray(I) = FormatDateTime(DateToFormat, vbShortTime)
        Case "GeneralDate" ResultArray(I) = FormatDateTime(DateToFormat, vbGeneralDate)
        Case "ReportDate" ResultArray(I) = FormatDateTime(DateToFormat, vbShortDate) & " " & FormatDateTime(DateToFormat, vbShortTime)      
        Case "tt" ResultArray(I) = CCGetAMPM(Hour(DateToFormat), CCSLocales.Locale.AMDesignator, CCSLocales.Locale.PMDesignator) 
        Case Else
          If Left(FormatMask(I), 1) = "\" Then _
            ResultArray(I) = Mid(FormatMask(I), 1) _
          Else
            ResultArray(I) = FormatMask(I)
      End Select
    Next
    Result = Join(ResultArray, "")
  End If
  CCFormatDate = Result
End Function
'End CCFormatDate

'CCFormatBoolean @0-635596FD
Function CCFormatBoolean(BooleanValue, arrFormat)
  Dim Result, TrueValue, FalseValue, EmptyValue

  If IsEmpty(arrFormat) Then
    Result = CStr(BooleanValue)
  Else
    TrueValue = arrFormat(0)
    FalseValue = arrFormat(1)
    EmptyValue = arrFormat(2)
    If IsEmpty(BooleanValue) Then
      Result = EmptyValue
    Else
      If BooleanValue Then _
        Result = TrueValue _
      Else _
        Result = FalseValue
    End If
  End If
  CCFormatBoolean = Result
End Function
'End CCFormatBoolean

'CCFormatNumber @0-BC58654D
Function CCFormatNumber(NumToFormat, FormatArray)
  Dim IsNegative
  Dim IsExtendedFormat, IsDecimalSeparator, DecimalSeparator, IsPeriodSeparator, PeriodSeparator
  Dim DefaultDecimal, LeftPart, RightPart, NumberToFormat
  NumberToFormat = NumToFormat

  If IsEmpty(NumberToFormat) Then
    CCFormatNumber = ""
    Exit Function
  End If

  If IsArray(FormatArray) Then
    IsExtendedFormat = FormatArray(0)
    IsNegative = (NumberToFormat < 0)
    NumberToFormat = ABS(NumberToFormat) * FormatArray(7)
  
    If IsExtendedFormat Then ' Extended format
      IsDecimalSeparator = FormatArray(1)
      IsPeriodSeparator = FormatArray(3)  

      If CCSLocales.Locale.OverrideNumberFormats Then 
        DecimalSeparator = CCSLocales.Locale.DecimalSeparator
        PeriodSeparator = CCSLocales.Locale.GroupSeparator
      Else 
        DecimalSeparator = FormatArray(2)
        PeriodSeparator = FormatArray(4)
      End If

      Dim BeforeDecimal, AfterDecimal
      Dim ObligatoryBeforeDecimal, DigitsBeforeDecimal, ObligatoryAfterDecimal, DigitsAfterDecimal
      Dim I, Z
      BeforeDecimal = FormatArray(5)
      AfterDecimal = FormatArray(6)
      If IsArray(BeforeDecimal) Then
        For I = 0 To UBound(BeforeDecimal)
          If BeforeDecimal(I) = "0" Then
            ObligatoryBeforeDecimal = ObligatoryBeforeDecimal + 1
            DigitsBeforeDecimal = DigitsBeforeDecimal + 1
          ElseIf BeforeDecimal(I) = "#" Then
            DigitsBeforeDecimal = DigitsBeforeDecimal + 1
          End If
        Next      
      End If 

      If CCSLocales.Locale.OverrideNumberFormats And IsArray(AfterDecimal) Then 
        ReDim Preserve AfterDecimal(CCSLocales.Locale.DecimalDigits)
        For I = 0 To UBound(AfterDecimal)
          If AfterDecimal(I) = "" Then _
            AfterDecimal(I)="0"
        Next
      End If 

      If IsArray(AfterDecimal) Then
        For I = 0 To UBound(AfterDecimal)
          If AfterDecimal(I) = "0" Then
            ObligatoryAfterDecimal = ObligatoryAfterDecimal + 1
            DigitsAfterDecimal = DigitsAfterDecimal + 1
          ElseIf AfterDecimal(I) = "#" Then
            DigitsAfterDecimal = DigitsAfterDecimal + 1
          End If
        Next      
      End If 
  
      Dim Result, DefaultValue

      NumberToFormat = FormatNumber(NumberToFormat, DigitsAfterDecimal, False, False, False)

      DefaultDecimal = Mid(FormatNumber(10001/10, 1, True, False, True), 6, 1)
      If Not InStr(CStr(NumberToFormat), DefaultDecimal) = 0 Then
        Dim NumberParts : NumberParts = Split(CStr(NumberToFormat), DefaultDecimal)
        LeftPart = CStr(NumberParts(0))
        RightPart = CStr(NumberParts(1))
      Else
        LeftPart = CStr(NumberToFormat)
      End If

      Dim J : J = Len(LeftPart)
    
      If IsDecimalSeparator And DecimalSeparator = "" Then
        DefaultValue = CStr(FormatNumber(10001/10, 1, True, False, True))
        DecimalSeparator = Mid(DefaultValue, 6, 1)
      End If
    
      If IsPeriodSeparator And PeriodSeparator = "" Then
        DefaultValue = CStr(FormatNumber(10001/10, 1, True, False, True))
        PeriodSeparator = Mid(DefaultValue, 2, 1)
      End If  
    
      If IsArray(BeforeDecimal) Then
        Dim RankNumber : RankNumber = 0
        For I  = UBound(BeforeDecimal) To 0 Step -1
          If BeforeDecimal(i) = "#" Or BeforeDecimal(i) = "0" Then
            If DigitsBeforeDecimal = 1 And J > 1 Then
              If Not IsPeriodSeparator Then
                Result = Left(LeftPart, j) & Result
              Else
                For z = J To 1 Step -1
                  RankNumber = RankNumber + 1
                  If RankNumber Mod 3 = 1 And RankNumber - 3 > 0 Then
                    Result = Mid(LeftPart, z, 1) & PeriodSeparator & Result
                  Else
                    Result = Mid(LeftPart, z, 1) & Result
                  End If
                Next
              End If
            ElseIf J > 0 Then
              RankNumber = RankNumber + 1
              If RankNumber Mod 3 = 1 And RankNumber - 3 > 0 And IsPeriodSeparator Then
                Result = Mid(LeftPart, j, 1) & PeriodSeparator & Result
              Else
                Result = Mid(LeftPart, j, 1) & Result
              End If
              J = J - 1
              ObligatoryBeforeDecimal = ObligatoryBeforeDecimal - 1
              DigitsBeforeDecimal = DigitsBeforeDecimal - 1
            Else
              If ObligatoryBeforeDecimal > 0 Then
                RankNumber = RankNumber + 1
                If RankNumber Mod 3 = 1 And RankNumber - 3 > 0 And IsPeriodSeparator Then
                  Result = "0" & PeriodSeparator & Result
                Else
                  Result = "0" & Result
                End If
                ObligatoryBeforeDecimal = ObligatoryBeforeDecimal - 1
                DigitsBeforeDecimal = DigitsBeforeDecimal - 1
              End If
            End If
          Else
            BeforeDecimal(I) = Replace(BeforeDecimal(I), "##", "#")
            BeforeDecimal(I) = Replace(BeforeDecimal(I), "00", "0")
            Result = BeforeDecimal(I) & Result
          End If
        Next
      End If
    
      ' Left part after decimal
      Dim RightResult, IsRightResult : RightResult = "" : IsRightResult = False
      If IsArray(AfterDecimal) Then
        Dim IsZero : IsZero = True
        For I = UBound(AfterDecimal) To 0 Step -1
          If AfterDecimal(I) = "#" Or AfterDecimal(I) = "0" Then
            If DigitsAfterDecimal > ObligatoryAfterDecimal Then
              If Not Mid(RightPart, DigitsAfterDecimal, 1) = "0" Then IsZero = False
              If Not IsZero Then 
                RightResult = Mid(RightPart, DigitsAfterDecimal, 1) & RightResult
                IsRightResult = True
              End If
              DigitsAfterDecimal = DigitsAfterDecimal - 1
            Else
              RightResult = Mid(RightPart, DigitsAfterDecimal, 1) & RightResult
              DigitsAfterDecimal = DigitsAfterDecimal - 1
              IsRightResult = True
            End If
          Else
            AfterDecimal(I) = Replace(AfterDecimal(I), "##", "#")
            AfterDecimal(I) = Replace(AfterDecimal(I), "00", "0")
            RightResult = AfterDecimal(I) & RightResult
          End If
        Next
      End If

      If IsRightResult Then Result = Result & DecimalSeparator
      Result = Result & RightResult

      If NOT FormatArray(10) AND IsNegative Then _
         Result = "-" & Result

    Else ' Simple format

      If CCSLocales.Locale.OverrideNumberFormats And CInt(FormatArray(1)) <> 0 Then 
        FormatArray(1) = CCSLocales.Locale.DecimalDigits
      End If 

      If Not FormatArray(3) AND IsNegative Then _
        Result = "-" & FormatArray(5) & FormatNumber(NumberToFormat, FormatArray(1), FormatArray(2), False, FormatArray(4)) & FormatArray(6) _
      Else _
        Result = FormatArray(5) & FormatNumber(NumberToFormat, FormatArray(1), FormatArray(2), False, FormatArray(4)) & FormatArray(6)


      If CCSLocales.Locale.OverrideNumberFormats Then 
        DefaultDecimal = Mid(FormatNumber(10001/10, 1, True, False, True), 6, 1)
        If InStr(CStr(Result), DefaultDecimal) > 0 Then
          Result = Split(CStr(Result), DefaultDecimal)
        End If
        If FormatArray(4) Then 
           DefaultValue = CStr(FormatNumber(10001/10, 1, True, False, True))
           PeriodSeparator = Mid(DefaultValue, 2, 1)
           If IsArray(Result) Then 
             Result(0) = Replace(Result(0), PeriodSeparator, CCSLocales.Locale.GroupSeparator) 
           Else 
             Result = Replace(Result, PeriodSeparator, CCSLocales.Locale.GroupSeparator) 
           End If
        End If
        If IsArray(Result) Then _
          Result = Join(Result, CCSLocales.Locale.DecimalSeparator)
      End If
    End If
    If Not FormatArray(8) Then Result = Server.HTMLEncode(Result)
    If Not CStr(FormatArray(9)) = "" Then _
      Result = "<span style=""color: " & FormatArray(9) & """>" & Result & "</span>"
  Else
    Result = CStr(NumberToFormat)
    If CCSLocales.Locale.OverrideNumberFormats Then 
      Result = Replace(Result, ",", CCSLocales.Locale.DecimalSeparator)
      Result = Replace(Result, ".", CCSLocales.Locale.DecimalSeparator)
    End If
  End If
  CCFormatNumber = Result

End Function
'End CCFormatNumber

'CCParseBoolean @0-33711A62
Function CCParseBoolean(Value, FormatMask)
  Dim Result
  Result = Empty
  If VarType(Value) = vbBoolean Then
    Result = Value
  Else
    If IsEmpty(FormatMask) Then
      Result = CBool(Value)
    Else
      If IsEmpty(Value) Then
        If CStr(FormatMask(0)) = "null" Then _
          Result = True
        If CStr(FormatMask(1)) = "null" Then _
          Result = False
      Else
        If CStr(Value) = CStr(FormatMask(0)) Then 
          Result = True
        ElseIf CStr(Value) = CStr(FormatMask(1)) Then
          Result = False
        End If
      End If
    End If
  End If
  CCParseBoolean = Result
End Function
'End CCParseBoolean

'CCParseDate @0-B0351854
Function CCParseDate(ParsingDate, FormatMask)
  Dim ResultDate, ResultDateArray(8)
  Dim MaskPart, MaskLength, TokenLength
  Dim IsError
  Dim DatePosition, MaskPosition
  Dim Delimiter, BeginDelimiter
  Dim MonthNumber, MonthName, MonthArray
  Dim DatePartStr

  Dim IS_DATE_POS, YEAR_POS, MONTH_POS, DAY_POS, IS_TIME_POS, HOUR_POS, MINUTE_POS, SECOND_POS

  IS_DATE_POS = 0 : YEAR_POS = 1 : MONTH_POS = 2 : DAY_POS = 3
  IS_TIME_POS = 4 : HOUR_POS = 5 : MINUTE_POS = 6 : SECOND_POS = 7

  If VarType(ParsingDate) = vbDate Then 
     CCParseDate = ParsingDate
     Exit Function
  End If

  If IsEmpty(FormatMask) Then
    If CStr(ParsingDate) = "" Then _
      ResultDate = Empty _
    Else _
      ResultDate = CDate(ParsingDate)
  ElseIf CStr(ParsingDate) = "" Then
    ResultDate = Empty
  Else
    If CCSLocales.Locale.OverrideDateFormats Then
      Select Case FormatMask(0)
        Case "LongDate" FormatMask = CCSLocales.Locale.LongDate
        Case "LongTime" FormatMask = CCSLocales.Locale.LongTime
        Case "ShortDate" FormatMask = CCSLocales.Locale.ShortDate
        Case "ShortTime" FormatMask = CCSLocales.Locale.ShortTime
        Case "GeneralDate" FormatMask = CCSLocales.Locale.GeneralDate
      End Select
    ElseIf (FormatMask(0) = "GeneralDate" Or FormatMask(0) = "LongDate" _
      Or FormatMask(0) = "ShortDate" Or FormatMask(0) = "LongTime" _ 
      Or FormatMask(0) = "ShortTime") And Not CStr(ParsingDate) = "" Then
         If Not IsDate(ParsingDate) Then  Err.Raise 4000, "Common Functions. ParseDate function", "Mask mismatch."  
         CCParseDate = CDate(ParsingDate)
         Exit Function
    End If
    DatePosition = 1
    MaskPosition = 0
    MaskLength = UBound(FormatMask)
    IsError = False

    ' Default date
    ResultDateArray(IS_DATE_POS) = False
    ResultDateArray(IS_TIME_POS) = False
    ResultDateArray(YEAR_POS) = 0 : ResultDateArray(MONTH_POS) = 12 : ResultDateArray(DAY_POS) = 1
    ResultDateArray(HOUR_POS) = 0 : ResultDateArray(MINUTE_POS) = 0 : ResultDateArray(SECOND_POS) = 0

    While (MaskPosition <= MaskLength) AND NOT IsError
      MaskPart = FormatMask(MaskPosition)
      If CCSDateConstants.DateMasks.Exists(MaskPart) Then
        TokenLength = CCSDateConstants.DateMasks(MaskPart)
        If TokenLength > 0 Then
          DatePartStr = Mid(ParsingDate, DatePosition, TokenLength)
          DatePosition = DatePosition + TokenLength
        Else
          If MaskPosition < MaskLength Then
            Delimiter = FormatMask(MaskPosition + 1)
            BeginDelimiter = InStr(DatePosition, ParsingDate, Delimiter)
            If BeginDelimiter = 0 Then
              Err.Raise 4000, "Common Functions. ParseDate function","Mask mismatch."
            Else
              DatePartStr = Mid(ParsingDate, DatePosition, BeginDelimiter - DatePosition)
              DatePosition = BeginDelimiter
            End If
          Else
            DatePartStr = Mid(ParsingDate, DatePosition)
            DatePosition = DatePosition &  Len(DatePartStr)
          End If
        End If
        Select Case MaskPart
          Case "d", "dd"
            ResultDateArray(DAY_POS) = CInt(DatePartStr)
            ResultDateArray(IS_DATE_POS) = True
          Case "ddd", "dddd"
            Dim DayArray, DayNumber, DayName
            DayNumber = 0
            DayName = UCase(DatePartStr)
            If MaskPart = "ddd" Then _
              DayArray = CCSLocales.Locale.WeekdayShortNames _
            Else _
              DayArray = CCSLocales.Locale.WeekdayNames
            While DayNumber < 6 AND UCase(DayArray(DayNumber)) <> DayName
              DayNumber = DayNumber + 1
            Wend
            If DayNumber = 6 Then
            If UCase(DayArray(6)) <> DayName Then _
              Err.Raise 4000, "Common Functions. ParseDate function","Mask mismatch."
            End If
          Case "m", "mm"
            ResultDateArray(MONTH_POS) = CInt(DatePartStr)
            ResultDateArray(IS_DATE_POS) = True
          Case "mmm", "mmmm"
            MonthNumber = 0
            MonthName = UCase(DatePartStr)
            If MaskPart = "mmm" Then _
              MonthArray = CCSLocales.Locale.MonthShortNames _
            Else _
              MonthArray = CCSLocales.Locale.MonthNames
            While MonthNumber < 11 AND UCase(MonthArray(MonthNumber)) <> MonthName
              MonthNumber = MonthNumber + 1
            Wend
            If MonthNumber = 11 Then
              If UCase(MonthArray(11)) <> MonthName Then _
                Err.Raise 4000, "Common Functions. ParseDate function", "Mask mismatch."
            End If
            ResultDateArray(MONTH_POS) = MonthNumber + 1
            ResultDateArray(IS_DATE_POS) = True
          Case "yyyy"
            ResultDateArray(YEAR_POS) = CInt(DatePartStr)
            ResultDateArray(IS_DATE_POS) = True
          Case "yy"
            If CInt(DatePartStr) >= 50 Then ResultDateArray(YEAR_POS) = 1900 + CInt(DatePartStr) _
            Else ResultDateArray(YEAR_POS) = 2000 + CInt(DatePartStr)
            ResultDateArray(IS_DATE_POS) = True
          Case "h", "hh"
            If CInt(DatePartStr) = 12 Then _
              ResultDateArray(HOUR_POS) = 0 _
            Else _
              ResultDateArray(HOUR_POS) = CInt(DatePartStr)
            ResultDateArray(IS_TIME_POS) = True
          Case "H", "HH"
            ResultDateArray(HOUR_POS) = CInt(DatePartStr)
            ResultDateArray(IS_TIME_POS) = True
          Case "n", "nn"
            ResultDateArray(MINUTE_POS) = CInt(DatePartStr)
            ResultDateArray(IS_TIME_POS) = True
          Case "s", "ss"
            ResultDateArray(SECOND_POS) = CInt(DatePartStr)
            ResultDateArray(IS_TIME_POS) = True
          Case "am/pm", "a/p", "AM/PM", "A/P"
            If Left(LCase(DatePartStr), 1) = "p" Then
              ResultDateArray(HOUR_POS) = ResultDateArray(HOUR_POS) + 12
            ElseIf Left(LCase(DatePartStr), 1) = "a" Then
              ResultDateArray(HOUR_POS) = ResultDateArray(HOUR_POS)
            End If
            ResultDateArray(IS_TIME_POS) = True
          Case "tt" 
            If DatePartStr = CCSLocales.Locale.PMDesignator Then _ 
              ResultDateArray(HOUR_POS) = ResultDateArray(HOUR_POS) + 12
            ResultDateArray(IS_TIME_POS) = True
          Case "w", "q","S"
            ' Do Nothing
          Case Else
            IsError = IsError And DatePartStr = MaskPart
        End Select
      Else
        DatePartStr = Mid(ParsingDate, DatePosition, Len(FormatMask(MaskPosition)))
        DatePosition = DatePosition + Len(FormatMask(MaskPosition))
        If FormatMask(MaskPosition) <> DatePartStr Then _
          IsError = True
      End If
      MaskPosition = MaskPosition + 1
    Wend

    If Len(ParsingDate) - DatePosition >= 0  Then IsError = True
    If IsError Then Err.Raise 4001, "Common Functions. CCParseDate Function", "Unable to parse the date value."

    If ResultDateArray(IS_DATE_POS) AND ResultDateArray(IS_TIME_POS) Then
      ResultDate = DateSerial(ResultDateArray(YEAR_POS), ResultDateArray(MONTH_POS), ResultDateArray(DAY_POS))
      ResultDate = DateAdd("h", ResultDateArray(HOUR_POS), ResultDate)
      ResultDate = DateAdd("n", ResultDateArray(MINUTE_POS), ResultDate)
      ResultDate = DateAdd("s", ResultDateArray(SECOND_POS), ResultDate)
      If NOT(Year(ResultDate) = ResultDateArray(YEAR_POS) _
        AND Month(ResultDate) = ResultDateArray(MONTH_POS) _
        AND Day(ResultDate) = ResultDateArray(DAY_POS) _
        AND Hour(ResultDate) = ResultDateArray(HOUR_POS) _
        AND Minute(ResultDate) = ResultDateArray(MINUTE_POS) _
        AND Second(ResultDate) = ResultDateArray(SECOND_POS)) _
      Then _
        Err.Raise 4001,"Common Functions. CCParseDate Function", "Unable to parse the date value."
    ElseIf ResultDateArray(IS_TIME_POS) Then 
      ResultDate = TimeSerial(ResultDateArray(HOUR_POS), ResultDateArray(MINUTE_POS), ResultDateArray(SECOND_POS))
      If NOT(Hour(ResultDate) = ResultDateArray(HOUR_POS) _
        AND Minute(ResultDate) = ResultDateArray(MINUTE_POS) _
        AND Second(ResultDate) = ResultDateArray(SECOND_POS)) _
      Then _
        Err.Raise 4001,"Common Functions. CCParseDate Function", "Unable to parse the date value."
    ElseIf ResultDateArray(IS_DATE_POS) Then
      ResultDate = DateSerial(ResultDateArray(YEAR_POS), ResultDateArray(MONTH_POS), ResultDateArray(DAY_POS))
      If NOT(Year(ResultDate) = ResultDateArray(YEAR_POS) _
        AND Month(ResultDate) = ResultDateArray(MONTH_POS) _
        AND Day(ResultDate) = ResultDateArray(DAY_POS)) _
      Then _
        Err.Raise 4001, "Common Functions. CCParseDate Function", "Unable to parse the date value."
    End If
  End If
  CCParseDate = ResultDate
End Function
'End CCParseDate

'CCParseNumber @0-E572BD07
Function CCParseNumber(NumberValue, FormatArray, DataType)
  Dim Result, NumberValueType, NumberVal
  NumberValueType = VarType(NumberValue)
  If NumberValueType = vbInteger OR NumberValueType = vbLong _
    OR NumberValueType = vbSingle OR NumberValueType = vbSingle _
    OR NumberValueType = vbCurrency OR NumberValueType = vbDecimal _
    OR NumberValueType = vbByte Then
    If DataType = ccsInteger Then
      Result = CLng(NumberValue)
    ElseIf DataType = ccsFloat Then
      Result = CDbl(NumberValue)
    ElseIf DataType = ccsSingle Then
      Result = CSng(NumberValue)
    End If
  Else
    If Not CStr(NumberValue) = "" Then
      Dim DefaultValue, DefaultDecimal
      Dim DecimalSeparator, PeriodSeparator, PrePart, PostPart
      DecimalSeparator = "" : PeriodSeparator = "" : PrePart="" : PostPart=""
      If IsArray(FormatArray) Then
        If FormatArray(0) Then
          If CCSLocales.Locale.OverrideNumberFormats Then 
            DecimalSeparator = CCSLocales.Locale.DecimalSeparator
            PeriodSeparator = CCSLocales.Locale.GroupSeparator
          Else 
            DecimalSeparator = FormatArray(2)
            PeriodSeparator = FormatArray(4)
          End If
        Else
          If CCSLocales.Locale.OverrideNumberFormats Then 
            DecimalSeparator = CCSLocales.Locale.DecimalSeparator
            PeriodSeparator = CCSLocales.Locale.GroupSeparator
          End If
          PrePart = FormatArray(5)
          PostPart = FormatArray(6)
        End If
      End If
      NumberVal = NumberValue
      If Not CStr(PeriodSeparator) = "" Then NumberVal = Replace(NumberVal, PeriodSeparator, "")
      If Not CStr(DecimalSeparator) = "" Then 
        DefaultValue = CStr(FormatNumber(10001/10, 1, True, False, True))
        DefaultDecimal = Mid(DefaultValue, 6, 1)
        NumberVal = Replace(NumberVal, DecimalSeparator, DefaultDecimal)
      End If
      If Not CStr(PrePart) = "" Then NumberVal = Replace(NumberVal, PrePart, "")
      If Not CStr(PostPart) = "" Then NumberVal = Replace(NumberVal, PostPart, "")
      If DataType = ccsInteger Then
        Result = CLng(NumberVal)
      ElseIf DataType = ccsFloat Then
        Result = CDbl(NumberVal)
      ElseIf DataType = ccsSingle Then
        Result = CSng(NumberVal)
      End If
      If IsArray(FormatArray) Then Result = Result/FormatArray(7)
    Else
      Result = Empty
    End If
  End If
  CCParseNumber = Result
End Function
'End CCParseNumber

'CCParseInteger @0-42815927
Function CCParseInteger(NumberValue, FormatArray)
  CCParseInteger = CCParseNumber(NumberValue, FormatArray, ccsInteger)
End Function
'End CCParseInteger

'CCParseFloat @0-56667DF0
Function CCParseFloat(NumberValue, FormatArray)
  CCParseFloat = CCParseNumber(NumberValue, FormatArray, ccsFloat)
End Function
'End CCParseFloat

'CCParseSingle @0-0142EA0D
Function CCParseSingle(NumberValue, FormatArray)
  CCParseSingle = CCParseNumber(NumberValue, FormatArray, ccsSingle)
End Function
'End CCParseSingle

'CCValidateDate @0-B1691F92
Function CCValidateDate(ValidatingDate, FormatMask)
  Dim MaskPosition, I, Result, OneChar, IsSeparator
  Dim RegExpPattern, RegExpObject, Matches
  Dim ParsedTestDate, FormattedTestDate

  IsSeparator = False

  If ValidatingDate = "" OR IsEmpty(ValidatingDate) Then
    Result = True
  ElseIf IsEmpty(FormatMask) Then
    Result = IsDate(ValidatingDate)
  Else
    If CCSLocales.Locale.OverrideDateFormats Then
      Select Case FormatMask(0)
        Case "LongDate" FormatMask = CCSLocales.Locale.LongDate
        Case "LongTime" FormatMask = CCSLocales.Locale.LongTime
        Case "ShortDate" FormatMask = CCSLocales.Locale.ShortDate
        Case "ShortTime" FormatMask = CCSLocales.Locale.ShortTime
        Case "GeneralDate" FormatMask = CCSLocales.Locale.GeneralDate
      End Select
    ElseIf FormatMask(0) = "GeneralDate" Or FormatMask(0) = "LongDate" _
       Or FormatMask(0) = "ShortDate" Or FormatMask(0) = "LongTime" _ 
       Or FormatMask(0) = "ShortTime" Then
       CCValidateDate = IsDate(ValidatingDate)
       Exit Function
    End If
    ParsedTestDate = CCParseDate(ValidatingDate, FormatMask)
    FormattedTestDate = CCFormatDate(ParsedTestDate, FormatMask)
    Result = FormattedTestDate = ValidatingDate
  End If
  CCValidateDate = Result
End Function
'End CCValidateDate

'CCValidateNumber @0-7E5286B0
Function CCValidateNumber(NumberValue, FormatArray)
  Dim Result, NumberValueType
  Dim PrePart : PrePart="" 
  Dim PostPart : PostPart=""
  NumberValueType = VarType(NumberValue)
  If NumberValueType = vbInteger OR NumberValueType = vbLong _
    OR NumberValueType = vbSingle OR NumberValueType = vbSingle _
    OR NumberValueType = vbCurrency OR NumberValueType = vbDecimal _
    OR NumberValueType = vbByte Then
      Result = True
  Else
    If Not CStr(NumberValue) = "" Then
      Dim DefaultValue, DefaultDecimal
      Dim DecimalSeparator, PeriodSeparator
      DecimalSeparator = "" : PeriodSeparator = ""
      If IsArray(FormatArray) Then
        If FormatArray(0) Then
          If CCSLocales.Locale.OverrideNumberFormats Then 
            DecimalSeparator = CCSLocales.Locale.DecimalSeparator
            PeriodSeparator = CCSLocales.Locale.GroupSeparator
          Else 
            DecimalSeparator = FormatArray(2)
            PeriodSeparator = FormatArray(4)
          End If
	Else
          PrePart = FormatArray(5)
          PostPart = FormatArray(6)
          If CCSLocales.Locale.OverrideNumberFormats Then 
            DecimalSeparator = CCSLocales.Locale.DecimalSeparator
            PeriodSeparator = CCSLocales.Locale.GroupSeparator
          End If
        End If
      End If
      If Not CStr(DecimalSeparator) = "" Then 
        DefaultValue = CStr(FormatNumber(10001/10, 1, True, False, True))
        DefaultDecimal = Mid(DefaultValue, 6, 1)
        NumberValue = Replace(NumberValue, DecimalSeparator, DefaultDecimal)
      End If
      If Not CStr(PeriodSeparator) = "" Then NumberValue = Replace(NumberValue, PeriodSeparator, "")
      If Not CStr(PrePart) = "" Then NumberValue = Replace(NumberValue, PrePart, "")
      If Not CStr(PostPart) = "" Then NumberValue = Replace(NumberValue, PostPart, "")
      Result = IsNumeric(NumberValue)
    Else
      Result = True
    End If
  End If
  CCValidateNumber = Result
End Function
'End CCValidateNumber

'CCValidateBoolean @0-B8DE2060
Function CCValidateBoolean(Value, FormatMask)
  Dim Result: Result = False

  If VarType(Value) = vbBoolean Then
    Result = True
  Else
    If IsEmpty(FormatMask) Then
      On Error Resume Next
      Result = CBool(Value)
      Result = Not(Err > 0)
    Else
      If IsEmpty(Value) Or CStr(Value) = "" Then
        Result = (CStr(FormatMask(0)) = "null") Or (CStr(FormatMask(0)) = "Undefined") Or (CStr(FormatMask(0)) = "")
        Result = Result Or (CStr(FormatMask(1)) = "null") Or (CStr(FormatMask(1)) = "Undefined") Or (CStr(FormatMask(1)) = "")
        If UBound(FormatMask) = 2 Then _
          Result = Result Or (CStr(FormatMask(2)) = "null") Or (CStr(FormatMask(2)) = "Undefined") Or (CStr(FormatMask(2)) = "")
      Else
        Result = (CStr(Value) = CStr(FormatMask(0))) Or (CStr(Value) = CStr(FormatMask(1)))
        If UBound(FormatMask) = 2 Then _
          Result = Result Or (CStr(Value) = CStr(FormatMask(2)))
      End If
    End If
  End If
  CCValidateBoolean = Result
End Function
'End CCValidateBoolean

'CCAddParam @0-27BF1CE0
Function CCAddParam(QueryString, ParameterName, ParameterValue)
  Dim Result, ParameterValues, i, j, re, i1
  If Len(QueryString)>0 Then QueryString = "&" & QueryString 
  Result = CCRegExpReplaceGlobal(QueryString, "&" & ParameterName & "=[^&]*", "&", True)
  Result = CCRegExpReplaceGlobal(Result, "&$", "", True)

  If Not IsArray(ParameterValue)  Then 		  
    ParameterValues = Split(CStr(ParameterValue), ", ")
    i1 = 0
  Else 
    ParameterValues = ParameterValue
    i1 = 1
  End If  
  If UBound(ParameterValues) > 0 Then
    For i = i1 To UBound(ParameterValues)
      Result = Result & "&" & CCURLEncode(ParameterName) & "=" & CCURLEncode(ParameterValues(i))
    Next
  Else
    Result = Result & "&" & CCURLEncode(ParameterName) & "=" & CCURLEncode(ParameterValue)
  End If
  Result = CCRegExpReplaceGlobal(CCRegExpReplaceGlobal(Result, "&{2,}", "&", True), "\?&", "?", True)
  If Left(Result, 1) = "&"  Then 
    Result = Mid(Result, 2)
  End If
  CCAddParam = Result
End Function
'End CCAddParam

'CCRemoveParam @0-215A3357
Function CCRemoveParam(QueryString, ParameterName)
  Dim Result
  Result  = CCRegExpReplaceGlobal(QueryString, "(?=&)?" & ParameterName & "=[^&]*&?", "", True)
  If Left(Result, 1) = "&"  Then _
    Result = Mid(Result, 2)
  CCRemoveParam = Result
End Function
'End CCRemoveParam

'CCRegExpTest @0-9EAA5A2D
Function CCRegExpTest(TestValue, RegExpMask, IgnoreCase, GlobalTest)
  Dim Result
  If Not CStr(TestValue) = "" Then
    Dim RegExpObject
    Set RegExpObject = New RegExp
    RegExpObject.Pattern = RegExpMask
    RegExpObject.IgnoreCase = IgnoreCase
    RegExpObject.Global = GlobalTest
    Result = RegExpObject.Test(CStr(TestValue)) 
    Set RegExpObject = Nothing
  Else
    Result = True    
  End If
  CCRegExpTest = Result
End Function
  

'End CCRegExpTest

'CCRegExpReplace @0-C56ABB12
Function CCRegExpReplace(TestValue, RegExpMask, NewValue,IgnoreCase)
  Dim Result
  If Not CStr(TestValue) = "" Then
    Dim RegExpObject
    Set RegExpObject = New RegExp
    RegExpObject.Pattern = RegExpMask
    RegExpObject.IgnoreCase = IgnoreCase
    Result = RegExpObject.Replace(CStr(TestValue),CStr(NewValue)) 
    Set RegExpObject = Nothing
  Else
    Result = ""    
  End If
  CCRegExpReplace = Result
End Function

'End CCRegExpReplace

'CCURLEncode @0-1D590936
Function CCUrlEncode(S)
  CCURLEncode = Replace(Server.URLEncode(S),"%5F" ,"_") 
End Function
'End CCURLEncode

'CCRegExpReplaceGlobal @0-70DFD185
Function CCRegExpReplaceGlobal(TestValue, RegExpMask, NewValue,IgnoreCase)
  Dim Result
  If Not CStr(TestValue) = "" Then
    Dim RegExpObject
    Set RegExpObject = New RegExp
    RegExpObject.Pattern = RegExpMask
    RegExpObject.IgnoreCase = IgnoreCase
    RegExpObject.Global = True
    Result = RegExpObject.Replace(CStr(TestValue),CStr(NewValue)) 
    Set RegExpObject = Nothing
  Else
    Result = ""    
  End If
  CCRegExpReplaceGlobal = Result
End Function


'End CCRegExpReplaceGlobal

'CheckSSL @0-4BE3AE1D
Sub CheckSSL()
  If Not UCase(Request.ServerVariables("HTTPS")) = "ON" Then
    Response.Write "SSL connection error. This page can be accessed only via secured connection."
    Response.End
  End If
End Sub

'End CheckSSL

'setInclPath @0-FBAFFC8F

Function setInclPath(o, n)
 Dim aro, arn, j, path
 Dim Reverse : Reverse=False
 If o = "" Then 
    setInclPath = n
    Exit Function
 End If 

 If Right(o, 1) = "/" Then o = Left(o, Len(o) - 1)
 If Right(n, 1) = "/" Then n = Left(n, Len(n) - 1)
 aro = Split(o, "/")
 arn = Split(n, "/")

 For j = LBound(arn) To UBound(arn)
    If Left(arn(j), 2) = ".." Then
      If Left(aro(UBound(aro)), 2) = ".." Then 
        ReDim Preserve aro(UBound(aro) + 1)
        aro(UBound(aro)) = arn(j)
      Else 
        If UBound(aro)>0 Then 
		    ReDim Preserve aro(UBound(aro) - 1)
        ElseIf Reverse Then 
          ReDim Preserve aro(UBound(aro))
          aro(UBound(aro)) = arn(j)
        Else 
          Reverse=True
          ReDim Preserve aro(0)
          aro(0)=""
        End If
      End If
   ElseIf Left(arn(j), 1) = "." Then
   ElseIf Trim(arn(j)) <> "" Then
      ReDim Preserve aro(UBound(aro) + 1)
     aro(UBound(aro)) = arn(j)
   End If
 Next
 path = Join(aro, "/")
 If path <> "" Then path = path & "/"
 setInclPath = path
End Function

'End setInclPath

'CCGetUserLogin @0-4306ED6C
Function CCGetUserLogin()
    CCGetUserLogin = Session("UserLogin")
End Function
'End CCGetUserLogin

'CCSecurityRedirect @0-1E875EE5
Sub CCSecurityRedirect(GroupsAccess, URL)
    Dim ErrorType
    Dim RetLink
    Dim RetLinkParams
    Dim Link
    ErrorType = CCSecurityAccessCheck(GroupsAccess)
    If NOT (ErrorType = "success") Then
        If IsEmpty(URL) Then _
            Link = ServerURL & "login.asp" _
        Else _
            Link = URL
        RetLink = Request.ServerVariables("SCRIPT_NAME")
        RetLinkParams = CCRemoveParam(Request.ServerVariables("QUERY_STRING"), "ccsForm")
        If NOT (RetLinkParams = "") Then _
            RetLink = RetLink & "?" & RetLinkParams
        Response.Redirect(Link & "?ret_link=" & _
            CCURLEncode(RetLink) & "&type=" & ErrorType)
    End If
End Sub
'End CCSecurityRedirect

'CCGetUserID @0-449B3B19
Function CCGetUserID()
    CCGetUserID = Session("UserID")
End Function
'End CCGetUserID

'CCSecurityAccessCheck @0-8A7701BE
Function CCSecurityAccessCheck(GroupsAccess)
    Dim ErrorType
    Dim GroupID
    ErrorType = "success"
    If IsEmpty(CCGetUserID()) Then
        ErrorType = "notLogged"
    Else
        GroupID = CCGetGroupID()
        If IsEmpty(GroupID) Then
            ErrorType = "groupIDNotSet"
        Else
            If NOT CCUserInGroups(GroupID, GroupsAccess) Then
                ErrorType = "illegalGroup"
            End If
        End If
    End If
    CCSecurityAccessCheck = ErrorType
End Function
'End CCSecurityAccessCheck

'CCGetGroupID @0-B2650479
Function CCGetGroupID()
CCGetGroupID = Session("GroupID")
End Function
'End CCGetGroupID

'CCUserInGroups @0-D62B622E
Function CCUserInGroups(GroupID, GroupsAccess)
Dim Result
If NOT IsEmpty(GroupsAccess) Then
Result = NOT (InStr(";" & GroupsAccess & ";", ";" & GroupID & ";") = 0)
Else
Result = True
End If
CCUserInGroups = Result
End Function
'End CCUserInGroups

'CCLoginUser @0-FE2747D0
Function CCLoginUser(Login, Password)
    Dim Result
    Dim SQL
    Dim RecordSet
    Dim Connection
    Dim UserIDField
    Dim GroupIDField
    
    Set Connection = New clsDBConnection1
    Connection.Open
    SQL = "SELECT idlogin, [idPerfil] FROM usuarios WHERE login='" & Replace(Login, "'", "''") & "' AND password='" & Replace(Password, "'", "''") & "'"
    Set RecordSet = Connection.Execute(SQL)
    Result = (Connection.Errors.Count = 0)
    If Result Then _
        Result = NOT RecordSet.EOF
    If Result Then
        UserIDField = CStr(RecordSet("idlogin").Value)
        Session("UserID") = UserIDField
        Session("UserLogin") = Login
        Set GroupIDField = RecordSet("idPerfil")
        Select Case GroupIDField.Type
            Case adBigInt, adUnsignedBigInt
                GroupIDField = CLng(GroupIDField.Value)
            Case adBoolean
                GroupIDField = CBool(GroupIDField.Value)
            Case adBSTR, adChar, adVarChar, adLongVarChar, adLongVarWChar, adVarWChar, adWChar
                GroupIDField = CStr(GroupIDField.Value)
            Case adCurrency
                GroupIDField = CCur(GroupIDField.Value)
            Case adDate, adDBDate
                GroupIDField = CDate(GroupIDField.Value)
            Case adDecimal, adDouble, adNumeric, adVarNumeric
                GroupIDField = CDbl(GroupIDField.Value)
            Case adEmpty
                GroupIDField = Empty
            Case adInteger, adSmallInt, adTinyInt, adUnsignedInt, adUnsignedSmallInt
                GroupIDField = CInt(GroupIDField.Value)
            Case adSingle
                GroupIDField = CSng(GroupIDField.Value)
            Case adUnsignedTinyInt
                GroupIDField = CByte(GroupIDField.Value)
            Case Else
                GroupIDField = GroupIDField.Value
        End Select
        Session("GroupID") = GroupIDField
    End If
    If RecordSet.State = adStateOpen Then _
        RecordSet.Close
    Set RecordSet = Nothing
    If Connection.State = adStateOpen Then _
        Connection.Close
    Set Connection = Nothing
    CCLoginUser = Result
End Function
'End CCLoginUser

'CCLogoutUser @0-DB93CE50
Sub CCLogoutUser()
    Session("UserID") = Empty
    Session("UserLogin") = Empty
    Session("GroupID") = Empty
End Sub
'End CCLogoutUser

'CCCipherInit @0-F36831BB

Sub CCCipherInit(key) 
    Dim temp, idx1, idx2, keyLength
    keyLength = len(key) 
    For idx1 = 0 To 255 
 	cipherbox(idx1) = idx1
	cipherkey(idx1) = asc(mid(key, (idx1 mod keyLength)+1, 1)) 
    Next 
    idx2 = 0 
    For idx1 = 0 To 255 
 	idx2 = (idx2 + cipherbox(idx1) + cipherkey(idx1)) Mod 256 
	temp = cipherbox(idx1) 
	cipherbox(idx1) = cipherbox(idx2) 
	cipherbox(idx2) = temp 
    Next 
End Sub 

'End CCCipherInit

'CCEncryptString @0-75754C0F
Function CCEncryptString(inputString, key) 
     If inputString = "" Then 
	 CCEncryptString =""
     Else 
         CCEncryptString = CCBytesToHex(CCCipherEnDeCrypt(inputString, key))
     End If
End Function

'End CCEncryptString

'CCDecryptString @0-85F8C7E4
Function CCDecryptString(inputString, key) 
     If inputString = "" Then 
	 CCDecryptString = ""
     Else 
         CCDecryptString = CCBytesToString(CCCipherEnDeCrypt(CCHexToBytes(inputString), key))
     End If
End Function

'End CCDecryptString

'CCCipherEnDeCrypt @0-6B9D257B
Function CCCipherEnDeCrypt(inputString, key) 
    dim temp, a, i, j, k, crypted 
    dim result() 
    i = 0 
    j = 0 
    CCCipherInit key
    For a = 1 To Len(inputString) 
        i = (i + 1) Mod 256 
        j = (j + cipherbox(i)) Mod 256 
        temp = cipherbox(i) 
        cipherbox(i) = cipherbox(j) 
        cipherbox(j) = temp 
        k = cipherbox((cipherbox(i) + cipherbox(j)) Mod 256) 
        crypted = Asc(Mid(inputString, a, 1)) Xor k 
	reDim preserve result(a)
        result(a-1) = crypted
    Next 
    CCCipherEnDeCrypt = result
End Function

'End CCCipherEnDeCrypt

'CCBytesToString @0-05A77A39
Function CCBytesToString(bytesArray)
	Dim i, result, size, tmp, arraySize
	arraySize = ubound(bytesArray)
	For i = 0 to arraySize-1
		result = result & chr(bytesArray(i))
	Next
	CCBytesToString = result
End Function

'End CCBytesToString

'CCBytesToHex @0-BB9C0FD8
Function CCBytesToHex(bytesArray)
	dim i, result, size, tmp, arraySize
	arraySize = ubound(bytesArray)
	for i = 0 to arraySize-1
        	tmp = hex(bytesArray(i))
		result = result & String(2-len(tmp),"0") & tmp
	next
	CCBytesToHex = result
End Function

'End CCBytesToHex

'CCHexToBytes @0-3D6C6246
Function CCHexToBytes(hexString) 
	Dim bytes()
    	ReDim bytes(len(hexString)/2)
	Dim i
	Dim num
	Dim result
   	For i = 1 To Len(hexString) Step 2
         num = CCHexToInt(Mid(hexString, i, 1)) * 16
	 num = num + CCHexToInt(Mid(hexString, i+1, 1))
         result = result & Chr(num)
    	Next
	CCHexToBytes = result
End Function

'End CCHexToBytes

'CCHexToInt @0-6F17DE65
Function CCHexToInt(hexSymb)
	Select Case LCase(hexSymb)
		Case "0" CCHexToInt = 0
		Case "1" CCHexToInt = 1
		Case "2" CCHexToInt = 2
		Case "3" CCHexToInt = 3
		Case "4" CCHexToInt = 4
		Case "5" CCHexToInt = 5
		Case "6" CCHexToInt = 6
		Case "7" CCHexToInt = 7
		Case "8" CCHexToInt = 8
		Case "9" CCHexToInt = 9
		Case "a" CCHexToInt = 10
		Case "b" CCHexToInt = 11
		Case "c" CCHexToInt = 12
		Case "d" CCHexToInt = 13
		Case "e" CCHexToInt = 14
		Case "f" CCHexToInt = 15
	End Select
End Function

'End CCHexToInt

'CCCreateALCookie @0-5D87D173
Sub  CCCreateALCookie(Login, Password, ExpirationDate)
    
   Dim s : s = CCEncryptString(Login, CCS_ENCRYPTION_KEY_FOR_COOKIE)  & ":" & _
               CCEncryptString(Password, CCS_ENCRYPTION_KEY_FOR_COOKIE) & ":" & _ 
               CCGetTimeStamp(ExpirationDate)
   Response.Cookies("buscadorLogin") = CCEncryptString(s, CCS_ENCRYPTION_KEY_FOR_COOKIE)
   Response.Cookies("buscadorLogin").Expires = ExpirationDate

End Sub

'End CCCreateALCookie

'CCGetTimeStamp @0-8CEA8247
Function CCGetTimeStamp(d)
  CCGetTimeStamp = DateDiff("s", DateSerial(1970,1,1), d)
End Function

'End CCGetTimeStamp

'CCGetDateFromTimeStamp @0-1E5FA5CE
Function CCGetDateFromTimeStamp(ts)
  CCGetDateFromTimeStamp = DateAdd("s", ts, DateSerial(1970,1,1))
End Function

'End CCGetDateFromTimeStamp

'GetCCSType @0-8E845BA4
Function GetCCSType(adType)
  Dim Res : Res =ccsText
  Select Case adType
   Case adBigInt
      Res = ccsInteger
   Case adChar
      Res = ccsText
   Case adDate
      Res = ccsDate
   Case adDecimal
      Res = ccsFloat
   Case adDouble
      Res = ccsFloat
   Case adNumeric
      Res = ccsFloat
   Case adSmallInt
      Res = ccsInteger
   Case adTinyInt
      Res = ccsInteger
   Case adVarChar
      Res = ccsText
   Case adBoolean
      Res = ccsBoolean
   Case adDBTimeStamp
      Res = ccsDate
   Case adInteger
      Res = ccsInteger
   Case adWChar
      Res = ccsText
   Case adBSTR
      Res = ccsText
   Case adSingle
      Res = ccsSingle
   Case adDate
      Res = ccsDate
   Case Else
      Res = ccsText
  End Select
  GetCCSType = Res
End Function
'End GetCCSType

'CCGetFormatStr @0-4618C2F1
Function CCGetFormatStr(Format)
  Dim Result
  If IsEmpty(Format) Then
    Result = ""
  Else
    Select Case Format(0)
      Case "LongDate" Result = Join(CCSLocales.Locale.LongDate, "")
      Case "LongTime" Result = Join(CCSLocales.Locale.LongTime, "")
      Case "ShortDate" Result = Join(CCSLocales.Locale.ShortDate, "")
      Case "ShortTime" Result = Join(CCSLocales.Locale.ShortTime, "")
      Case "GeneralDate" Result = Join(CCSLocales.Locale.GeneralDate, "")
      Case Else Result = Join(Format, "")
    End Select  
  End If
  CCGetFormatStr = Result
End Function
'End CCGetFormatStr

'CCLoadStaticTranslation @0-CDDE9833
  Public Function CCLoadStaticTranslation()
    Dim Keys(105)
    Dim Vals(105)
    
    Keys(1) = "ccs_asc" : Vals(1) = "Ascendente"
    Keys(2) = "ccs_bytes" : Vals(2) = "bytes"
    Keys(3) = "ccs_cancel" : Vals(3) = "Cancelar"
    Keys(4) = "ccs_cannotseek" : Vals(4) = "Registro especificado no encontrado."
    Keys(5) = "ccs_captcha_controlvalidation" : Vals(5) = "El valor entrado no coincide con el valor de la imagen."
    Keys(6) = "ccs_clear" : Vals(6) = "Limpiar"
    Keys(7) = "ccs_customlinkfield" : Vals(7) = "Detalles"
    Keys(8) = "ccs_customoperationerror_missingparameters" : Vals(8) = "Faltan uno o mas parametros para proceder a la actualizacion/eliminacion. La aplicación ha fallado."
    Keys(9) = "ccs_databasecommanderror" : Vals(9) = "Error de comando de base de datos."
    Keys(10) = "ccs_datepickernav61" : Vals(10) = "El selector de fecha no es compatible con Netscape 6.1"
    Keys(11) = "ccs_delete" : Vals(11) = "Borrar"
    Keys(12) = "ccs_deleteconfirmation" : Vals(12) = "Borrar registro?"
    Keys(13) = "ccs_desc" : Vals(13) = "Descendente"
    Keys(14) = "ccs_directoryformprefix" : Vals(14) = "Directorio"
    Keys(15) = "ccs_directoryformsuffix" : Vals(15) = "Directorio"
    Keys(16) = "ccs_filenotfound" : Vals(16) = "El archivo {0} especificado en {1} no se encontró."
    Keys(17) = "ccs_filesfoldernotfound" : Vals(17) = "Imposible transferir el archivo del campo {0} - la carpeta de destino no existe."
    Keys(18) = "ccs_filter" : Vals(18) = "Palabra clave"
    Keys(19) = "ccs_first" : Vals(19) = "Inicio"
    Keys(20) = "ccs_formatinfo" : Vals(20) = "es-AR|es|AR|1;0;|2|,|.|Enero;Febrero;Marzo;Abril;Mayo;Junio;Julio;Agosto;Septiembre;Octubre;Noviembre;Diciembre|Ene;Feb;Mar;Abr;May;Jun;Jul;Ago;Sep;Oct;Nov;Dic|Domingo;Lunes;Martes;Miércoles;Jueves;Viernes;Sábado|Dom;Lun;Mar;Mié;Jue;Vie;Sáb|dd!/!mm!/!yyyy|dddd!, !dd! de !mmmm! de !yyyy|hh!:!nn! !tt|hh!:!nn!:!ss! !tt|0|a.m.|p.m.|windows-1252|1252|1|0|D;L;M;M;J;V;S|11274"
    Keys(21) = "ccs_galleryformprefix" : Vals(21) = ""
    Keys(22) = "ccs_galleryformsuffix" : Vals(22) = "Galeria"
    Keys(23) = "ccs_gridformpostfix" : Vals(23) = ""
    Keys(24) = "ccs_gridformprefix" : Vals(24) = ""
    Keys(25) = "ccs_gridformsuffix" : Vals(25) = "Lista de"
    Keys(26) = "ccs_gridpagenumbererror" : Vals(26) = "Numero de pagina invalido"
    Keys(27) = "ccs_gridpagesizeerror" : Vals(27) = "(CCS06) Tamaño de pagina invalido"
    Keys(28) = "ccs_incorrectemailformat" : Vals(28) = "Email no valido en el campo {0}."
    Keys(29) = "ccs_incorrectformat" : Vals(29) = "El valor en el campo {0} no es valido. use el siguiente formato:: {1}."
    Keys(30) = "ccs_incorrectphoneformat" : Vals(30) = "El campo {0} tiene un formato invalido."
    Keys(31) = "ccs_incorrectvalue" : Vals(31) = "El campo {0} no es valido."
    Keys(32) = "ccs_incorrectzipformat" : Vals(32) = "El campo {0} tiene un formato invalido."
    Keys(33) = "ccs_insert" : Vals(33) = "Agregar"
    Keys(34) = "ccs_insertlink" : Vals(34) = "Agregar Nuevo"
    Keys(35) = "ccs_insufficientpermissions" : Vals(35) = "Insuficientes permisos para transferir el archivo del campo {0}."
    Keys(36) = "ccs_languageid" : Vals(36) = "es"
    Keys(37) = "ccs_largefile" : Vals(37) = "El tamaño del archivo en el campo {0} es muy grande."
    Keys(38) = "ccs_last" : Vals(38) = "Final"
    Keys(39) = "ccs_localeid" : Vals(39) = "es-AR"
    Keys(40) = "ccs_login" : Vals(40) = "Login"
    Keys(41) = "ccs_login_autologin_caption" : Vals(41) = "Recordarme el password"
    Keys(42) = "ccs_login_form_caption" : Vals(42) = "Login"
    Keys(43) = "ccs_loginbtn" : Vals(43) = "Login"
    Keys(44) = "ccs_loginerror" : Vals(44) = "Login o Password incorrecto."
    Keys(45) = "ccs_logoutbtn" : Vals(45) = "Logout"
    Keys(46) = "ccs_main" : Vals(46) = "Inicio"
    Keys(47) = "ccs_maskvalidation" : Vals(47) = "La validación fallo en el campo {0}."
    Keys(48) = "ccs_maximumlength" : Vals(48) = "La longitud de {0} no puede ser mayor de {1} caracteres."
    Keys(49) = "ccs_maximumvalue" : Vals(49) = "El valor de {0} no puede ser más alto de {1}."
    Keys(50) = "ccs_minimumlength" : Vals(50) = "La longitud de {0} no puede ser menor de {1} caracteres."
    Keys(51) = "ccs_minimumvalue" : Vals(51) = "El valor de {0} no puede menor de {1}."
    Keys(52) = "ccs_more" : Vals(52) = "Más..."
    Keys(53) = "ccs_next" : Vals(53) = "Siguiente"
    Keys(54) = "ccs_nextmonthhint" : Vals(54) = "Siguiente mes"
    Keys(55) = "ccs_nextquarterhint" : Vals(55) = "Siguiente trimestre"
    Keys(56) = "ccs_nextthreemonthshint" : Vals(56) = "Siguentes tres meses"
    Keys(57) = "ccs_nextyearhint" : Vals(57) = "Siguiente año"
    Keys(58) = "ccs_nocategories" : Vals(58) = "Categorias no encontradas"
    Keys(59) = "ccs_norecords" : Vals(59) = "No hay registros"
    Keys(60) = "ccs_of" : Vals(60) = "de"
    Keys(61) = "ccs_operationerror" : Vals(61) = "No se puede llevar a cabo esta {0} operacion. Uno o mas parametros no han sido especificados."
    Keys(62) = "ccs_password" : Vals(62) = "Password"
    Keys(63) = "ccs_previous" : Vals(63) = "Anterior"
    Keys(64) = "ccs_prevmonthhint" : Vals(64) = "Mes anterior"
    Keys(65) = "ccs_prevquarterhint" : Vals(65) = "Trimestre anterior"
    Keys(66) = "ccs_prevthreemonthshint" : Vals(66) = "Tres meses anteriores"
    Keys(67) = "ccs_prevyearhint" : Vals(67) = "Año anterior"
    Keys(68) = "ccs_recordformpostfix" : Vals(68) = ""
    Keys(69) = "ccs_recordformprefix" : Vals(69) = "Agregar/Editar"
    Keys(70) = "ccs_recordformprefix2" : Vals(70) = "Ver"
    Keys(71) = "ccs_recordformsuffix" : Vals(71) = ""
    Keys(72) = "ccs_recperpage" : Vals(72) = "Registro por página"
    Keys(73) = "ccs_rememberlogin" : Vals(73) = "Recordar mi Login y Password"
    Keys(74) = "ccs_reportformprefix" : Vals(74) = ""
    Keys(75) = "ccs_reportformsuffix" : Vals(75) = ""
    Keys(76) = "ccs_reportpagenumber1" : Vals(76) = "Page"
    Keys(77) = "ccs_reportpagenumber2" : Vals(77) = "of"
    Keys(78) = "ccs_reportprintlink" : Vals(78) = "Version imprimible"
    Keys(79) = "ccs_reportsubtotal" : Vals(79) = "Sub Total"
    Keys(80) = "ccs_reporttotal" : Vals(80) = "Total"
    Keys(81) = "ccs_requiredfield" : Vals(81) = "El campo {0} es necesario."
    Keys(82) = "ccs_requiredfieldupload" : Vals(82) = "El archivo adjunto en el campo {0} es necesario."
    Keys(83) = "ccs_requiredsmtpserver_or_dir" : Vals(83) = "Por favor, especifique el servidor SMTP o seleccionelo del directorio"
    Keys(84) = "ccs_search" : Vals(84) = "Buscar"
    Keys(85) = "ccs_searchformpostfix" : Vals(85) = ""
    Keys(86) = "ccs_searchformprefix" : Vals(86) = ""
    Keys(87) = "ccs_searchformsuffix" : Vals(87) = "Buscar"
    Keys(88) = "ccs_selectfield" : Vals(88) = "Seleccionar Campo"
    Keys(89) = "ccs_selectorder" : Vals(89) = "Seleccionar Orden"
    Keys(90) = "ccs_selectvalue" : Vals(90) = "Seleccionar Valor"
    Keys(91) = "ccs_sortby" : Vals(91) = "Ordenar por"
    Keys(92) = "ccs_sortdir" : Vals(92) = "Forma de Orden"
    Keys(93) = "ccs_submitconfirmation" : Vals(93) = "Enviar registro?"
    Keys(94) = "ccs_tempfoldernotfound" : Vals(94) = "Insuficientes permisos para transferir el archivo del campo {0} - el archivo temporal destino no existe."
    Keys(95) = "ccs_tempinsufficientpermissions" : Vals(95) = "Insuficientes permisos para transferir el archivo del campo {0} en la carpeta temporal."
    Keys(96) = "ccs_today" : Vals(96) = "Hoy"
    Keys(97) = "ccs_totalrecords" : Vals(97) = "Total de Registros:"
    Keys(98) = "ccs_uniquevalue" : Vals(98) = "El campo {0} ya existe."
    Keys(99) = "ccs_update" : Vals(99) = "Enviar"
    Keys(100) = "ccs_uploadcomponenterror" : Vals(100) = "Ocurrió un error mientras se iniciaba la transferencia del componente."
    Keys(101) = "ccs_uploadcomponentnotfound" : Vals(101) = "%s transfiriendo componente """"%s"""" no se encontró. Seleccione otro o instale el componente."
    Keys(102) = "ccs_uploadingerror" : Vals(102) = "Ocurrio un error al transferir el archivo del campo {0}. Descripción del error: {1}."
    Keys(103) = "ccs_uploadingtempfoldererror" : Vals(103) = "Ocurrio un error al cargar el ficheros especificado en {0} en la carpeta temporal. Descripcion del error: {1}."
    Keys(104) = "ccs_wrongtype" : Vals(104) = "Es tipo de archivo en el campo {0} no está permitido."
    Keys(105) = "text1" : Vals(105) = """Acceso denegado"""
    CCSLocales.SetKeyVals Keys, Vals  
  End Function
'End CCLoadStaticTranslation

'CCSelectStyle @0-057EC372
  Const CCS_SS_RequestParameterName = 0
  Const CCS_SS_CookieName = 1
  Const CCS_SS_SessionName = 2

  Public Sub CCSelectStyle(Path, Default, Names, CookieExpired)
    Dim strStyle : strStyle = Empty
    Dim FSO
    Set FSO = Server.CreateObject("Scripting.FileSystemObject")
    If Not IsEmpty(Names(CCS_SS_RequestParameterName)) Then
      strStyle = TestStyle(FSO, Path, Request.QueryString(Names(CCS_SS_RequestParameterName)), Default)
    End If
    If IsEmpty(strStyle) And Not IsEmpty(Names(CCS_SS_CookieName)) Then _
      strStyle = TestStyle(FSO, Path, Request.Cookies(Names(CCS_SS_CookieName)), Default)
    If IsEmpty(strStyle) And Not IsEmpty(Names(CCS_SS_SessionName)) Then _
      strStyle = TestStyle(FSO, Path, Session(Names(CCS_SS_SessionName)), Default)
    If IsEmpty(strStyle) Then _
      strStyle = Default

    If Not IsEmpty(Names(CCS_SS_CookieName)) Then 
       If Request.Cookies(Names(CCS_SS_CookieName)) <> strStyle Then 
         Response.Cookies(Names(CCS_SS_CookieName)) = strStyle
         If Not IsEmpty(CookieExpired) Then _
           Response.Cookies(Names(CCS_SS_CookieName)).Expires = DateAdd("d", CookieExpired, Now())
       End If
    End If
    If Not IsEmpty(Names(CCS_SS_SessionName)) Then _
       Session(Names(CCS_SS_SessionName)) = strStyle
    CCSStyle  = Replace(strStyle," ", "%20")
    Set FSO = Nothing
  End Sub

  Function TestStyle(FSO, Path, Name, Default)
     Dim Res : Res = Empty
     If Len(Name) > 0 Then  
       Name = Trim(Name)
       If CCRegExpTest(Name, "[A-z0-9 ]{1,255}.", True,True) Then
         If FSO.FileExists(Path & Name & "/Style.css") Then 
           Res = Name
         Else 
           Res = Default
         End If
       End If
    End If
    TestStyle = Res
  End Function  

'End CCSelectStyle

'CCManageGalleryPanels @0-B9961E45
  Sub CCManageGalleryPanels(Grid, NumberOfColumns, OpenPanel, ClosePanel, ControlsPanel) 
    If IsNumeric(NumberOfColumns)  Then
    	OpenPanel.Visible = Grid.RowNumber mod NumberOfColumns = 1 Or NumberOfColumns = 1
    	ClosePanel.Visible = Grid.RowNumber mod NumberOfColumns = 0
	ControlsPanel.Visible = Grid.HasNextRow()
   	If NumberOfColumns > 1 Then Grid.ForceIteration = Grid.RowNumber mod NumberOfColumns <> 0
    End If	
  End Sub

'End CCManageGalleryPanels

'Image size functions @0-B4EAD400
Function isJPG(nmfile)
        If inStr(uCase(nmfile), ".JPG") <> 0 Then
                isJPG = true
        Else
                isJPG = false
        End If
End Function


Function isPNG(nmfile)
        If inStr(uCase(nmfile), ".PNG") <> 0 Then
                isPNG = true
        Else
                isPNG = false
        End If
End Function


Function isGIF(nmfile)
        If inStr(uCase(nmfile), ".GIF") <> 0 Then
                isGIF = true
        Else
                isGIF = false
        End If
End Function


Function isBMP(nmfile)
        If inStr(uCase(nmfile), ".BMP") <> 0 Then
                isBMP = true
        Else
                isBMP = false
        End If
End Function


Function isWMF(nmfile)
        If inStr(uCase(nmfile), ".WMF") <> 0 Then
                isWMF = true
        Else
                isWMF = false
        End If
End Function


Function isWebImg(f)
        If isGIF(f) Or isJPG(f) Or isPNG(f) Or isBMP(f) Or isWMF(f) Then
                isWebImg = true
        Else
                isWebImg = true
        End If
End Function


Function ReadImg(nmfile)
	Dim FSO
	Set FSO = Server.CreateObject("Scripting.FileSystemObject")
	If Not FSO.FileExists(nmfile) Then
		ReadImg = Empty	
		Set FSO = Nothing
		Exit Function
	End If

        If isGIF(nmfile) Then
                ReadImg = ReadGIF(nmfile)
        Else
                If isJPG(nmfile) Then
                        ReadImg = ReadJPG(nmfile)
                Else
                        If isPNG(nmfile) Then
                        ReadImg = ReadPNG(nmfile)
                        Else
                                If isBMP(nmfile) Then
                                        ReadImg = ReadPNG(nmfile)
                                Else
                                        If isWMF(nmfile) Then
                                                ReadImg = ReadWMF(nmfile)
                                        Else
                                                ReadImg = Array(0,0)
                                        End If
                                End If
                        End If
                End If
        End If
End Function


Function ReadPNG(nmfile)
  Dim fso, ts, s, HW, nbytes
        HW = Array("","")
        s=LoadImgContent(nmfile, 24)
        s = RightB(s, 8)
        HW(0) = HexToDec(HexAt(s,3) & HexAt(s,4))
        HW(1) = HexToDec(HexAt(s,7) & HexAt(s,8))
  ReadPNG = HW
End Function


Function ReadGIF(nmfile)
  Dim fso, ts, s, HW, nbytes
        HW = Array("","")
        s=LoadImgContent(nmfile, 10)
        s = RightB(s, 4)
        HW(0) = HexToDec(HexAt(s,2) & HexAt(s,1))
        HW(1) = HexToDec(HexAt(s,4) & HexAt(s,3))
  ReadGIF = HW
End Function


Function ReadWMF(nmfile)
  Dim fso, ts, s, HW, nbytes
        HW = Array("","")
        s=LoadImgContent(nmfile, 14)
        s = RightB(s, 4)
        HW(0) = HexToDec(HexAt(s,2) & HexAt(s,1))
        HW(1) = HexToDec(HexAt(s,4) & HexAt(s,3))
  ReadWMF = HW
End Function


Function ReadBMP(nmfile)
  Dim fso, ts, s, HW, nbytes
        HW = Array("","")
        s=LoadImgContent(nmfile, 24)
        s = RightB(s, 8)
        HW(0) = HexToDec(HexAt(s,4) & HexAt(s,3))
        HW(1) = HexToDec(HexAt(s,8) & HexAt(s,7))
  ReadBMP = HW
End Function


Function isDigit(c)
        If inStr("0123456789", c) <> 0 Then
                isDigit = true
        Else
                isDigit = false
        End If
End Function


Function isHex(c)
        If inStr("0123456789ABCDEFabcdef", c) <> 0 Then
                isHex = true
        Else
                ishex = false
        End If
End Function


Function HexToDec(cadhex)
        Dim n, i, ch, decimal
        decimal = 0
        n = Len(cadhex)
        For i=1 To n
                ch = Mid(cadhex, i, 1)
                If isHex(ch) Then
                        decimal = decimal * 16
                        If isDigit(ch) Then
                                decimal = decimal + ch
                        Else
                                decimal = decimal + Asc(uCase(ch)) - Asc("A")
                        End If
                Else
                        HexToDec = -1
                End If
        Next
        HexToDec = decimal
End Function


Function LoadImgContent(file, maxb) 
    Dim Strm
    Set Strm = Server.CreateObject("ADODB.Stream")
    Strm.Open
    Strm.Type = adTypeBinary
    Strm.LoadFromFile file
    LoadImgContent=Strm.Read(maxb)
    Strm.Close
    Set Strm = Nothing
End Function


Function ReadJPG(file) 
    Const maxJpegSearch = 2048 
    Dim fso, ts, s, HW, nbytes, x, SOF 
    HW = Array("","") 
    s=LoadImgContent(file, maxJpegSearch)
    for x = 1 to Len(s) - 1 
        if AscB(MidB(s, x, 1)) = &hFF then 
            if AscB(MidB(s, x + 1, 1)) >= &hC0 AND _ 
            AscB(MidB(s, x + 1, 1)) <= &hCF AND _ 
            AscB(MidB(s, x + 1, 1)) <> &hC4 then 
                SOF = x 
                exit for 
            end if 
        end if 
    next 
    if SOF > 0 then 
        s = MidB(s, SOF + 5, 4) 
        HW(0) = HexToDec(HexAt(s,3) & HexAt(s,4)) 
        HW(1) = HexToDec(HexAt(s,1) & HexAt(s,2)) 
    else 
        HW(0) = -1 
        HW(1) = -1 
    end if 
    ReadJPG = HW 
End Function

Function HexAt(s, n)
        HexAt = Hex(AscB(MidB(s, n,1)))
End Function



'End Image size functions


%>
