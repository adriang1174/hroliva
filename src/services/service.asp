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

'Initialize Page @1-CA71AB12
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
Dim propiedades1
Dim ChildControls

Response.ContentType = CCSContentType
Redirect = ""
TemplateFileName = "service.html"
Set CCSEvents = CreateObject("Scripting.Dictionary")
PathToCurrentPage = "./services/"
FileName = "service.asp"
PathToRoot = "../"
ScriptPath = Left(Request.ServerVariables("PATH_TRANSLATED"), Len(Request.ServerVariables("PATH_TRANSLATED")) - Len(FileName))
TemplateFilePath = ScriptPath
'End Initialize Page

'Initialize Objects @1-548EECF4
CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInitialize", Nothing)

Set DBConnection1 = New clsDBConnection1
DBConnection1.Open
Set Attributes = New clsAttributes
Attributes("pathToRoot") = PathToRoot

' Controls
Set propiedades1 = New clsGridpropiedades1
propiedades1.Initialize DBConnection1

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

'Show Page @1-4656B3DD
Attributes.Show HTMLTemplate, "page:"
Set ChildControls = CCCreateCollection(Tpl, Null, ccsParseOverwrite, _
    Array(propiedades1))
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

'UnloadPage Sub @1-4CA90A71
Sub UnloadPage()
    CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeUnload", Nothing)
    If DBConnection1.State = adStateOpen Then _
        DBConnection1.Close
    Set DBConnection1 = Nothing
    Set CCSEvents = Nothing
    Set Attributes = Nothing
    Set propiedades1 = Nothing
End Sub
'End UnloadPage Sub

Class clsGridpropiedades1 'propiedades1 Class @2-F510B686

'propiedades1 Variables @2-D651E79F

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
    Dim descripcion
'End propiedades1 Variables

'propiedades1 Class_Initialize Event @2-F55C78D6
    Private Sub Class_Initialize()
        ComponentName = "propiedades1"
        Visible = True
        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Attributes = New clsAttributes
        Set Errors = New clsErrors
        Set DataSource = New clspropiedades1DataSource
        Set Command = New clsCommand
        PageSize = CCGetParam(ComponentName & "PageSize", Empty)
        If IsNumeric(PageSize) And Len(PageSize) > 0 Then
            If PageSize <= 0 Then Errors.AddError(CCSLocales.GetText("CCS_GridPageSizeError", Empty))
            If PageSize > 100 Then PageSize = 100
        End If
        If NOT IsNumeric(PageSize) OR IsEmpty(PageSize) Then _
            PageSize = 10 _
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

        Set descripcion = CCCreateControl(ccsLabel, "descripcion", Empty, ccsText, Empty, CCGetRequestParam("descripcion", ccsGet))
    IsDSEmpty = True
    End Sub
'End propiedades1 Class_Initialize Event

'propiedades1 Initialize Method @2-57CE6952
    Sub Initialize(objConnection)
        If NOT Visible Then Exit Sub

        Set DataSource.Connection = objConnection
        DataSource.PageSize = PageSize
        DataSource.AbsolutePage = PageNumber
    End Sub
'End propiedades1 Initialize Method

'propiedades1 Class_Terminate Event @2-B97CC660
    Private Sub Class_Terminate()
        Set CCSEvents = Nothing
        Set DataSource = Nothing
        Set Command = Nothing
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End propiedades1 Class_Terminate Event

'propiedades1 Show Method @2-8B75C900
    Sub Show(Tpl)
        Dim HasNext
        If NOT Visible Then Exit Sub

        Dim RowBlock, SeparatorBlock


        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeSelect", Me)
        Set Recordset = DataSource.Open(Command)
        If DataSource.Errors.Count = 0 Then IsDSEmpty = Recordset.EOF

        Set TemplateBlock = Tpl.Block("Grid " & ComponentName)
        If TemplateBlock is Nothing Then Exit Sub
        Set RowBlock = TemplateBlock.Block("Row")
        Set SeparatorBlock = TemplateBlock.Block("Separator")
        Set RowControls = CCCreateCollection(RowBlock, Null, ccsParseAccumulate, _
            Array(descripcion))

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Me)
        If NOT Visible Then Exit Sub

        RowControls.PreserveControlsVisible
        Errors.AddErrors DataSource.Errors
        If Errors.Count > 0 Then
            TemplateBlock.HTML = CCFormatError("Grid " & ComponentName, Errors)
        Else
            HasNext = HasNextRow()
            ForceIteration = False
            Do While ForceIteration Or HasNext
                Attributes("rowNumber") = ShownRecords + 1
                If HasNext Then
                    descripcion.Value = Recordset.Fields("descripcion")
                End If
                CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShowRow", Me)
                Attributes.Show TemplateBlock.Block("Row"), "propiedades1:"
                RowControls.Show
                If HasNext Then Recordset.MoveNext
                ShownRecords = ShownRecords + 1

                ' Parse Separator
                If NOT Recordset.EOF AND ShownRecords < PageSize Then _
                    SeparatorBlock.ParseTo ccsParseAccumulate, RowBlock
                HasNext = HasNextRow()
            Loop
            Attributes.Show TemplateBlock, "propiedades1:"
            TemplateBlock.Parse ccsParseOverwrite
        End If

    End Sub
'End propiedades1 Show Method

'propiedades1 PageSize Property Let @2-54E46DD6
    Public Property Let PageSize(NewValue)
        VarPageSize = NewValue
        DataSource.PageSize = NewValue
    End Property
'End propiedades1 PageSize Property Let

'propiedades1 PageSize Property Get @2-9AA1D1E9
    Public Property Get PageSize()
        PageSize = VarPageSize
    End Property
'End propiedades1 PageSize Property Get

'propiedades1 RowNumber Property Get @2-F32EE2C6
    Public Property Get RowNumber()
        RowNumber = ShownRecords + 1
    End Property
'End propiedades1 RowNumber Property Get

'propiedades1 HasNextRow Function @2-9BECE27A
    Public Function HasNextRow()
        HasNextRow = NOT Recordset.EOF AND ShownRecords < PageSize
    End Function
'End propiedades1 HasNextRow Function

End Class 'End propiedades1 Class @2-A61BA892

Class clspropiedades1DataSource 'propiedades1DataSource Class @2-1CA20EC8

'DataSource Variables @2-80EF482C
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
    Public descripcion
'End DataSource Variables

'DataSource Class_Initialize Event @2-3A9EBFDB
    Private Sub Class_Initialize()

        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Fields = New clsFields
        Set Recordset = New clsDataSource
        Set Recordset.DataSource = Me
        Set Errors = New clsErrors
        Set Connection = Nothing
        AllParamsSet = True
        Set descripcion = CCCreateField("descripcion", "descripcion", ccsText, Empty, Recordset)
        Fields.AddFields Array(descripcion)

        SQL = "SELECT TOP {SqlParam_endRecord} *  " & vbLf & _
        "FROM propiedades {SQL_Where} {SQL_OrderBy}"
        CountSQL = "SELECT COUNT(*) " & vbLf & _
        "FROM propiedades"
        Where = ""
        Order = ""
        StaticOrder = ""
    End Sub
'End DataSource Class_Initialize Event

'BuildTableWhere Method @2-98E5A92F
    Public Sub BuildTableWhere()
    End Sub
'End BuildTableWhere Method

'Open Method @2-6EA306C4
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

End Class 'End propiedades1DataSource Class @2-A61BA892


%>
