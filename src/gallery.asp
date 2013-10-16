<%@ CodePage=1252 %>
<%
'Include Common Files @1-1E030DF9
%>
<!-- #INCLUDE VIRTUAL="/search/Common.asp"-->
<!-- #INCLUDE VIRTUAL="/search/Cache.asp" -->
<!-- #INCLUDE VIRTUAL="/search/Template.asp" -->
<!-- #INCLUDE VIRTUAL="/search/Sorter.asp" -->
<!-- #INCLUDE VIRTUAL="/search/Navigator.asp" -->
<%
'End Include Common Files

'Initialize Page @1-A05626B6
' Variables
Dim PathToRoot, ScriptPath, TemplateFilePath
Dim FileName
Dim Redirect
Dim Tpl, HTMLTemplate
Dim TemplateFileName
Dim ComponentName
Dim PathToCurrentPage
Dim Attributes

' Events
Dim CCSEvents
Dim CCSEventResult

' Connections
Dim DBConnection1

' Page controls
Dim fotos
Dim ChildControls

Response.ContentType = CCSContentType
Redirect = ""
TemplateFileName = "gallery.html"
Set CCSEvents = CreateObject("Scripting.Dictionary")
PathToCurrentPage = "./"
FileName = "gallery.asp"
PathToRoot = "./"
ScriptPath = Left(Request.ServerVariables("PATH_TRANSLATED"), Len(Request.ServerVariables("PATH_TRANSLATED")) - Len(FileName))
TemplateFilePath = ScriptPath
'End Initialize Page

'Initialize Objects @1-A4DA00A0
BindEvents "Page"
CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInitialize", Nothing)

Set DBConnection1 = New clsDBConnection1
DBConnection1.Open
Set Attributes = New clsAttributes
Attributes("pathToRoot") = PathToRoot

' Controls
Set fotos = New clsGridfotos
fotos.Initialize DBConnection1

' Events
%>
<!-- #INCLUDE VIRTUAL="/search/gallery_events.asp" -->
<%
BindEvents Empty

CCSEventResult = CCRaiseEvent(CCSEvents, "AfterInitialize", Nothing)
'End Initialize Objects

'Go to destination page @1-6D35F4FD
If NOT ( Redirect = "" ) Then
    UnloadPage
    Response.Redirect Redirect
End If
'End Go to destination page

'Initialize HTML Template @1-2E9DB4BC
CCSEventResult = CCRaiseEvent(CCSEvents, "OnInitializeView", Nothing)
Set HTMLTemplate = new clsTemplate
Set HTMLTemplate.Cache = TemplatesRepository
HTMLTemplate.LoadTemplate TemplateFilePath & TemplateFileName
HTMLTemplate.SetVar "@CCS_PathToRoot", PathToRoot
Set Tpl = HTMLTemplate.Block("main")
CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Nothing)
'End Initialize HTML Template

'Show Page @1-3E6D5E04
Attributes.Show HTMLTemplate, "page:"
Set ChildControls = CCCreateCollection(Tpl, Null, ccsParseOverwrite, _
    Array(fotos))
ChildControls.Show
Dim MainHTML
HTMLTemplate.Parse "main", False
MainHTML = HTMLTemplate.GetHTML("main")
CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeOutput", Nothing)
If CCSEventResult Then Response.Write MainHTML
'End Show Page

'Unload Page @1-CB210C62
UnloadPage
Set Tpl = Nothing
Set HTMLTemplate = Nothing
'End Unload Page

'UnloadPage Sub @1-18A425E2
Sub UnloadPage()
    CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeUnload", Nothing)
    If DBConnection1.State = adStateOpen Then _
        DBConnection1.Close
    Set DBConnection1 = Nothing
    Set CCSEvents = Nothing
    Set Attributes = Nothing
    Set fotos = Nothing
End Sub
'End UnloadPage Sub

Class clsGridfotos 'fotos Class @2-FFB24342

'fotos Variables @2-6ECBF711

    ' Private variables
    Private VarPageSize
    ' Public variables
    Public ComponentName, CCSEvents
    Public Visible, Errors
    Public DataSource
    Public PageNumber
    Public Command
    Public TemplateBlock
    Public IsDSEmpty
    Public ForceIteration
    Public Attributes
    Private ShownRecords
    Public Recordset

    Private CCSEventResult

    ' Grid Controls
    Public StaticControls, RowControls
    Dim RowOpenTag
    Dim RowComponents
    Dim url
    Dim RowCloseTag
    Dim Navigator
'End fotos Variables

'fotos Class_Initialize Event @2-0F4F048B
    Private Sub Class_Initialize()
        ComponentName = "fotos"
        Visible = True
        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Attributes = New clsAttributes
        Set Errors = New clsErrors
        Set DataSource = New clsfotosDataSource
        Set Command = New clsCommand
        PageSize = CCGetParam(ComponentName & "PageSize", Empty)
        If IsNumeric(PageSize) And Len(PageSize) > 0 Then
            If PageSize <= 0 Then Errors.AddError(CCSLocales.GetText("CCS_GridPageSizeError", Empty))
            If PageSize > 100 Then PageSize = 100
        End If
        If NOT IsNumeric(PageSize) OR IsEmpty(PageSize) Then _
            PageSize = 1 _
        Else _
            PageSize = CInt(PageSize)
        PageNumber = CCGetParam(ComponentName & "Page", 1)
        If Not IsNumeric(PageNumber) And Len(PageNumber) > 0 Then
            Errors.AddError(CCSLocales.GetText("CCS_GridPageNumberError", Empty))
            PageNumber = 1
        ElseIf Len(PageNumber) > 0 Then
            If PageNumber > 0 Then
                PageNumber = CInt(PageNumber)
            Else
                Errors.AddError(CCSLocales.GetText("CCS_GridPageNumberError", Empty))
                PageNumber = 1
            End If
        Else
            PageNumber = 1
        End If

        Set RowOpenTag = CCCreatePanel("RowOpenTag")
        Set RowComponents = CCCreatePanel("RowComponents")
        Set url = CCCreateControl(ccsImage, "url", Empty, ccsText, Empty, CCGetRequestParam("url", ccsGet))
        Set RowCloseTag = CCCreatePanel("RowCloseTag")
        Set Navigator = CCCreateNavigator(ComponentName, "Navigator", FileName, 10, tpSimple)
        Navigator.PageSizes = Array("1", "5", "10", "25", "50")
        RowComponents.AddComponent(url)
    IsDSEmpty = True
    End Sub
'End fotos Class_Initialize Event

'fotos Initialize Method @2-57CE6952
    Sub Initialize(objConnection)
        If NOT Visible Then Exit Sub

        Set DataSource.Connection = objConnection
        DataSource.PageSize = PageSize
        DataSource.AbsolutePage = PageNumber
    End Sub
'End fotos Initialize Method

'fotos Class_Terminate Event @2-B97CC660
    Private Sub Class_Terminate()
        Set CCSEvents = Nothing
        Set DataSource = Nothing
        Set Command = Nothing
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End fotos Class_Terminate Event

'fotos Show Method @2-BF742125
    Sub Show(Tpl)
        Dim HasNext
        If NOT Visible Then Exit Sub

        Dim RowBlock

        With DataSource
            .Parameters("urlp") = CCGetRequestParam("p", ccsGET)
        End With

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeSelect", Me)
        Set Recordset = DataSource.Open(Command)
        If DataSource.Errors.Count = 0 Then IsDSEmpty = Recordset.EOF

        Set TemplateBlock = Tpl.Block("Grid " & ComponentName)
        If TemplateBlock is Nothing Then Exit Sub
        Set RowBlock = TemplateBlock.Block("Row")
        Set StaticControls = CCCreateCollection(TemplateBlock, Null, ccsParseOverwrite, _
            Array(Navigator))
            Navigator.PageSize = PageSize
            Navigator.SetDataSource Recordset
        Set RowControls = CCCreateCollection(RowBlock, Null, ccsParseAccumulate, _
            Array(RowOpenTag, RowComponents, RowCloseTag))

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Me)
        If NOT Visible Then Exit Sub

        RowControls.PreserveControlsVisible
        Errors.AddErrors DataSource.Errors
        If Errors.Count > 0 Then
            TemplateBlock.HTML = CCFormatError("Grid " & ComponentName, Errors)
        Else

            ' Show NoRecords block if no records are found
            If Recordset.EOF Then
                Attributes.Show TemplateBlock, "fotos:"
                TemplateBlock.Block("NoRecords").Parse ccsParseOverwrite
            End If
            HasNext = HasNextRow()
            ForceIteration = False
            Do While ForceIteration Or HasNext
                Attributes("rowNumber") = ShownRecords + 1
                If HasNext Then
                    url.Value = Recordset.Fields("url")
                End If
                CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShowRow", Me)
                Attributes.Show TemplateBlock.Block("Row"), "fotos:"
                RowControls.Show
                If HasNext Then Recordset.MoveNext
                ShownRecords = ShownRecords + 1
                HasNext = HasNextRow()
            Loop
            Attributes.Show TemplateBlock, "fotos:"
            StaticControls.Show
        End If

    End Sub
'End fotos Show Method

'fotos PageSize Property Let @2-54E46DD6
    Public Property Let PageSize(NewValue)
        VarPageSize = NewValue
        DataSource.PageSize = NewValue
    End Property
'End fotos PageSize Property Let

'fotos PageSize Property Get @2-9AA1D1E9
    Public Property Get PageSize()
        PageSize = VarPageSize
    End Property
'End fotos PageSize Property Get

'fotos RowNumber Property Get @2-F32EE2C6
    Public Property Get RowNumber()
        RowNumber = ShownRecords + 1
    End Property
'End fotos RowNumber Property Get

'fotos HasNextRow Function @2-9BECE27A
    Public Function HasNextRow()
        HasNextRow = NOT Recordset.EOF AND ShownRecords < PageSize
    End Function
'End fotos HasNextRow Function

End Class 'End fotos Class @2-A61BA892

Class clsfotosDataSource 'fotosDataSource Class @2-3112BDA6

'DataSource Variables @2-41954030
    Public Errors, Connection, Parameters, CCSEvents

    Public Recordset
    Public SQL, CountSQL, Order, Where, Orders, StaticOrder
    Public PageSize
    Public PageCount
    Public AbsolutePage
    Public Fields
    Dim WhereParameters
    Public AllParamsSet
    Public CmdExecution
    Public InsertOmitIfEmpty
    Public UpdateOmitIfEmpty

    Private CurrentOperation
    Private CCSEventResult

    ' Datasource fields
    Public url
'End DataSource Variables

'DataSource Class_Initialize Event @2-10E222AE
    Private Sub Class_Initialize()

        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Fields = New clsFields
        Set Recordset = New clsDataSource
        Set Recordset.DataSource = Me
        Set Errors = New clsErrors
        Set Connection = Nothing
        AllParamsSet = True
        Set url = CCCreateField("url", "url", ccsText, Empty, Recordset)
        Fields.AddFields Array(url)
        Set Parameters = Server.CreateObject("Scripting.Dictionary")
        Set WhereParameters = Nothing

        SQL = "SELECT TOP {SqlParam_endRecord} *  " & vbLf & _
        "FROM fotos {SQL_Where} {SQL_OrderBy}"
        CountSQL = "SELECT COUNT(*) " & vbLf & _
        "FROM fotos"
        Where = ""
        Order = ""
        StaticOrder = ""
    End Sub
'End DataSource Class_Initialize Event

'BuildTableWhere Method @2-AB4C5D1F
    Public Sub BuildTableWhere()
        Dim WhereParams

        If Not WhereParameters Is Nothing Then _
            Exit Sub
        Set WhereParameters = new clsSQLParameters
        With WhereParameters
            Set .Connection = Connection
            Set .ParameterSources = Parameters
            Set .DataSource = Me
            .AddParameter 1, "urlp", ccsInteger, Empty, Empty, -1, False
            .Criterion(1) = .Operation(opEqual, False, "id", .getParamByID(1))
            .AssembledWhere = .Criterion(1)
            WhereParams = .AssembledWhere
            If Len(Where) > 0 Then 
                If Len(WhereParams) > 0 Then _
                    Where = Where & " AND " & WhereParams
            Else
                If Len(WhereParams) > 0 Then _
                    Where = WhereParams
            End If
        End With
    End Sub
'End BuildTableWhere Method

'Open Method @2-40984FC5
    Function Open(Cmd)
        Errors.Clear
        If Connection Is Nothing Then
            Set Open = New clsEmptyDataSource
            Exit Function
        End If
        Set Cmd.Connection = Connection
        Cmd.CommandOperation = cmdOpen
        Cmd.PageSize = PageSize
        Cmd.ActivePage = AbsolutePage
        Cmd.CommandType = dsTable
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeBuildSelect", Me)
        Cmd.SQL = SQL
        Cmd.CountSQL = CountSQL
        BuildTableWhere
        Cmd.Where = Where
        Cmd.OrderBy = Order
        If(Len(StaticOrder)>0) Then
            If Len(Order)>0 Then Cmd.OrderBy = ", "+Cmd.OrderBy
            Cmd.OrderBy = StaticOrder + Cmd.OrderBy
        End If
        Cmd.Options("TOP") = True
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeExecuteSelect", Me)
        If Errors.Count = 0 And CCSEventResult Then _
            Set Recordset = Cmd.Exec(Errors)
        CCSEventResult = CCRaiseEvent(CCSEvents, "AfterExecuteSelect", Me)
        Set Recordset.FieldsCollection = Fields
        Set Open = Recordset
    End Function
'End Open Method

'DataSource Class_Terminate Event @2-41B4B08D
    Private Sub Class_Terminate()
        If Recordset.State = adStateOpen Then _
            Recordset.Close
        Set Recordset = Nothing
        Set Parameters = Nothing
        Set Errors = Nothing
    End Sub
'End DataSource Class_Terminate Event

End Class 'End fotosDataSource Class @2-A61BA892


%>
