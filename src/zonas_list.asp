<%@ CodePage=1252 %>
<%
'Include Common Files @1-81E36C68
%>
<!-- #INCLUDE VIRTUAL="/search/Common.asp"-->
<!-- #INCLUDE VIRTUAL="/search/Cache.asp" -->
<!-- #INCLUDE VIRTUAL="/search/Template.asp" -->
<!-- #INCLUDE VIRTUAL="/search/Sorter.asp" -->
<!-- #INCLUDE VIRTUAL="/search/Navigator.asp" -->
<!-- #INCLUDE VIRTUAL="/search/Services.asp" -->
<%
'End Include Common Files

'Initialize Page @1-6E09DAF9
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
Dim zonasSearch
Dim zonas
Dim menu1
Dim ChildControls

Response.ContentType = CCSContentType
Redirect = ""
TemplateFileName = "zonas_list.html"
Set CCSEvents = CreateObject("Scripting.Dictionary")
PathToCurrentPage = "./"
FileName = "zonas_list.asp"
PathToRoot = "./"
ScriptPath = Left(Request.ServerVariables("PATH_TRANSLATED"), Len(Request.ServerVariables("PATH_TRANSLATED")) - Len(FileName))
TemplateFilePath = ScriptPath
'End Initialize Page

'Authenticate User @1-4F82CB21
CCSecurityRedirect "100", Empty
'End Authenticate User

'Initialize Objects @1-EE3A6693
BindEvents "Page"
CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInitialize", Nothing)

Set DBConnection1 = New clsDBConnection1
DBConnection1.Open
Set Attributes = New clsAttributes
Attributes("pathToRoot") = PathToRoot

' Controls
Set zonasSearch = new clsRecordzonasSearch
Set zonas = New clsGridzonas
Set menu1 = New clsmenu1
Set menu1.Attributes = Attributes
menu1.Initialize "menu1", ""
zonas.Initialize DBConnection1

' Events
%>
<!-- #INCLUDE VIRTUAL="/search/zonas_list_events.asp" -->
<%
BindEvents Empty

CCSEventResult = CCRaiseEvent(CCSEvents, "AfterInitialize", Nothing)
'End Initialize Objects

'Execute Components @1-8542BE89
zonasSearch.Operation
menu1.Operations
'End Execute Components

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

'Show Page @1-0EF58CAE
Attributes.Show HTMLTemplate, "page:"
Set ChildControls = CCCreateCollection(Tpl, Null, ccsParseOverwrite, _
    Array(zonasSearch, zonas, menu1))
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

'UnloadPage Sub @1-8E802A48
Sub UnloadPage()
    CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeUnload", Nothing)
    If DBConnection1.State = adStateOpen Then _
        DBConnection1.Close
    Set DBConnection1 = Nothing
    Set CCSEvents = Nothing
    Set Attributes = Nothing
    Set zonasSearch = Nothing
    Set zonas = Nothing
    Set menu1 = Nothing
End Sub
'End UnloadPage Sub

Class clsRecordzonasSearch 'zonasSearch Class @2-FF8306CD

'zonasSearch Variables @2-D577D315

    ' Public variables
    Public ComponentName
    Public HTMLFormAction
    Public PressedButton
    Public Errors
    Public FormSubmitted
    Public EditMode
    Public Visible
    Public Recordset
    Public TemplateBlock
    Public Attributes

    Public CCSEvents
    Private CCSEventResult

    Public InsertAllowed
    Public UpdateAllowed
    Public DeleteAllowed
    Public ReadAllowed
    Public DataSource
    Public Command
    Public ValidatingControls
    Public Controls

    ' Class variables
    Dim Button_DoSearch
    Dim s_descripcion
'End zonasSearch Variables

'zonasSearch Class_Initialize Event @2-6FFD592D
    Private Sub Class_Initialize()

        Visible = True
        Set Errors = New clsErrors
        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Attributes = New clsAttributes
        InsertAllowed = False
        UpdateAllowed = False
        DeleteAllowed = False
        ReadAllowed = True
        Dim Method
        Dim OperationMode
        OperationMode = Split(CCGetFromGet("ccsForm", Empty), ":")
        If UBound(OperationMode) > -1 Then 
            FormSubmitted = (OperationMode(0) = "zonasSearch")
        End If
        If UBound(OperationMode) > 0 Then 
            EditMode = (OperationMode(1) = "Edit")
        End If
        ComponentName = "zonasSearch"
        Method = IIf(FormSubmitted, ccsPost, ccsGet)
        Set Button_DoSearch = CCCreateButton("Button_DoSearch", Method)
        Set s_descripcion = CCCreateControl(ccsTextBox, "s_descripcion", Empty, ccsText, Empty, CCGetRequestParam("s_descripcion", Method))
        Set ValidatingControls = new clsControls
        ValidatingControls.addControls Array(s_descripcion)
    End Sub
'End zonasSearch Class_Initialize Event

'zonasSearch Class_Terminate Event @2-0C5D276C
    Private Sub Class_Terminate()
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End zonasSearch Class_Terminate Event

'zonasSearch Validate Method @2-B9D513CF
    Function Validate()
        Dim Validation
        ValidatingControls.Validate
        CCSEventResult = CCRaiseEvent(CCSEvents, "OnValidate", Me)
        Validate = ValidatingControls.isValid() And (Errors.Count = 0)
    End Function
'End zonasSearch Validate Method

'zonasSearch Operation Method @2-FED2B5FE
    Sub Operation()
        If NOT ( Visible AND FormSubmitted ) Then Exit Sub

        If FormSubmitted Then
            PressedButton = "Button_DoSearch"
            If Button_DoSearch.Pressed Then
                PressedButton = "Button_DoSearch"
            End If
        End If
        Redirect = "zonas_list.asp"
        If Validate() Then
            If PressedButton = "Button_DoSearch" Then
                If NOT Button_DoSearch.OnClick() Then
                    Redirect = ""
                Else
                    Redirect = "zonas_list.asp?" & CCGetQueryString("Form", Array(PressedButton, "ccsForm", "Button_DoSearch.x", "Button_DoSearch.y", "Button_DoSearch"))
                End If
            End If
        Else
            Redirect = ""
        End If
    End Sub
'End zonasSearch Operation Method

'zonasSearch Show Method @2-D4C893F7
    Sub Show(Tpl)

        If NOT Visible Then Exit Sub

        EditMode = False
        HTMLFormAction = FileName & "?" & CCAddParam(Request.ServerVariables("QUERY_STRING"), "ccsForm", "zonasSearch" & IIf(EditMode, ":Edit", ""))
        Set TemplateBlock = Tpl.Block("Record " & ComponentName)
        If TemplateBlock is Nothing Then Exit Sub
        TemplateBlock.Variable("HTMLFormName") = ComponentName
        TemplateBlock.Variable("HTMLFormEnctype") ="application/x-www-form-urlencoded"
        Set Controls = CCCreateCollection(TemplateBlock, Null, ccsParseOverwrite, _
            Array(s_descripcion, Button_DoSearch))
        If Not FormSubmitted Then
        End If
        If FormSubmitted Then
            Errors.AddErrors s_descripcion.Errors
            With TemplateBlock.Block("Error")
                .Variable("Error") = Errors.ToString()
                .Parse False
            End With
        End If
        TemplateBlock.Variable("Action") = IIF(CCSUseAmps, Replace(HTMLFormAction, "&", CCSAmps), HTMLFormAction)

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Me)
        If Visible Then 
            Attributes.Show TemplateBlock, "zonasSearch" & ":"
            Controls.Show
        End If
    End Sub
'End zonasSearch Show Method

End Class 'End zonasSearch Class @2-A61BA892

Class clsGridzonas 'zonas Class @6-D59032E9

'zonas Variables @6-54502B97

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
    Public ActiveSorter, SortingDirection
    Public Recordset

    Private CCSEventResult

    ' Grid Controls
    Public StaticControls, RowControls
    Dim zonas_Insert
    Dim Sorter_idZona
    Dim Sorter_descripcion
    Dim idZona
    Dim descripcion
    Dim Navigator
'End zonas Variables

'zonas Class_Initialize Event @6-238E71B7
    Private Sub Class_Initialize()
        ComponentName = "zonas"
        Visible = True
        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Attributes = New clsAttributes
        Set Errors = New clsErrors
        Set DataSource = New clszonasDataSource
        Set Command = New clsCommand
        PageSize = CCGetParam(ComponentName & "PageSize", Empty)
        If IsNumeric(PageSize) And Len(PageSize) > 0 Then
            If PageSize <= 0 Then Errors.AddError(CCSLocales.GetText("CCS_GridPageSizeError", Empty))
            If PageSize > 100 Then PageSize = 100
        End If
        If NOT IsNumeric(PageSize) OR IsEmpty(PageSize) Then _
            PageSize = 20 _
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
        ActiveSorter = CCGetParam("zonasOrder", Empty)
        SortingDirection = CCGetParam("zonasDir", Empty)
        If NOT(SortingDirection = "ASC" OR SortingDirection = "DESC") Then _
            SortingDirection = Empty

        Set zonas_Insert = CCCreateControl(ccsLink, "zonas_Insert", Empty, ccsText, Empty, CCGetRequestParam("zonas_Insert", ccsGet))
        Set Sorter_idZona = CCCreateSorter("Sorter_idZona", Me, FileName)
        Set Sorter_descripcion = CCCreateSorter("Sorter_descripcion", Me, FileName)
        Set idZona = CCCreateControl(ccsLink, "idZona", Empty, ccsInteger, Empty, CCGetRequestParam("idZona", ccsGet))
        Set descripcion = CCCreateControl(ccsLabel, "descripcion", Empty, ccsText, Empty, CCGetRequestParam("descripcion", ccsGet))
        Set Navigator = CCCreateNavigator(ComponentName, "Navigator", FileName, 10, tpSimple)
        Navigator.PageSizes = Array("1", "5", "10", "25", "50")
    IsDSEmpty = True
    End Sub
'End zonas Class_Initialize Event

'zonas Initialize Method @6-2AEA3975
    Sub Initialize(objConnection)
        If NOT Visible Then Exit Sub

        Set DataSource.Connection = objConnection
        DataSource.PageSize = PageSize
        DataSource.SetOrder ActiveSorter, SortingDirection
        DataSource.AbsolutePage = PageNumber
    End Sub
'End zonas Initialize Method

'zonas Class_Terminate Event @6-B97CC660
    Private Sub Class_Terminate()
        Set CCSEvents = Nothing
        Set DataSource = Nothing
        Set Command = Nothing
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End zonas Class_Terminate Event

'zonas Show Method @6-181E6946
    Sub Show(Tpl)
        Dim HasNext
        If NOT Visible Then Exit Sub

        Dim RowBlock

        With DataSource
            .Parameters("urls_descripcion") = CCGetRequestParam("s_descripcion", ccsGET)
        End With

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeSelect", Me)
        Set Recordset = DataSource.Open(Command)
        If DataSource.Errors.Count = 0 Then IsDSEmpty = Recordset.EOF

        Set TemplateBlock = Tpl.Block("Grid " & ComponentName)
        If TemplateBlock is Nothing Then Exit Sub
        Set RowBlock = TemplateBlock.Block("Row")
        Set StaticControls = CCCreateCollection(TemplateBlock, Null, ccsParseOverwrite, _
            Array(zonas_Insert, Sorter_idZona, Sorter_descripcion, Navigator))
            
            zonas_Insert.Parameters = CCGetQueryString("QueryString", Array("idZona", "ccsForm"))
            zonas_Insert.Page = "zonas_maint.asp"
            Navigator.PageSize = PageSize
            Navigator.SetDataSource Recordset
        Set RowControls = CCCreateCollection(RowBlock, Null, ccsParseAccumulate, _
            Array(idZona, descripcion))

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Me)
        If NOT Visible Then Exit Sub

        RowControls.PreserveControlsVisible
        Errors.AddErrors DataSource.Errors
        If Errors.Count > 0 Then
            TemplateBlock.HTML = CCFormatError("Grid " & ComponentName, Errors)
        Else

            ' Show NoRecords block if no records are found
            If Recordset.EOF Then
                Attributes.Show TemplateBlock, "zonas:"
                TemplateBlock.Block("NoRecords").Parse ccsParseOverwrite
            End If
            HasNext = HasNextRow()
            ForceIteration = False
            Do While ForceIteration Or HasNext
                Attributes("rowNumber") = ShownRecords + 1
                If HasNext Then
                    idZona.Value = Recordset.Fields("idZona")
                    idZona.Parameters = CCGetQueryString("QueryString", Array("ccsForm"))
                    idZona.Parameters = CCAddParam(idZona.Parameters, "idZona", Recordset.Fields("idZona_param1"))
                    idZona.Page = "zonas_maint.asp"
                    descripcion.Value = Recordset.Fields("descripcion")
                End If
                CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShowRow", Me)
                Attributes.Show TemplateBlock.Block("Row"), "zonas:"
                RowControls.Show
                If HasNext Then Recordset.MoveNext
                ShownRecords = ShownRecords + 1
                HasNext = HasNextRow()
            Loop
            Attributes.Show TemplateBlock, "zonas:"
            StaticControls.Show
        End If

    End Sub
'End zonas Show Method

'zonas PageSize Property Let @6-54E46DD6
    Public Property Let PageSize(NewValue)
        VarPageSize = NewValue
        DataSource.PageSize = NewValue
    End Property
'End zonas PageSize Property Let

'zonas PageSize Property Get @6-9AA1D1E9
    Public Property Get PageSize()
        PageSize = VarPageSize
    End Property
'End zonas PageSize Property Get

'zonas RowNumber Property Get @6-F32EE2C6
    Public Property Get RowNumber()
        RowNumber = ShownRecords + 1
    End Property
'End zonas RowNumber Property Get

'zonas HasNextRow Function @6-9BECE27A
    Public Function HasNextRow()
        HasNextRow = NOT Recordset.EOF AND ShownRecords < PageSize
    End Function
'End zonas HasNextRow Function

End Class 'End zonas Class @6-A61BA892

Class clszonasDataSource 'zonasDataSource Class @6-57EC98EF

'DataSource Variables @6-E89983B2
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
    Public idZona
    Public idZona_param1
    Public descripcion
'End DataSource Variables

'DataSource Class_Initialize Event @6-1E7FC193
    Private Sub Class_Initialize()

        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Fields = New clsFields
        Set Recordset = New clsDataSource
        Set Recordset.DataSource = Me
        Set Errors = New clsErrors
        Set Connection = Nothing
        AllParamsSet = True
        Set idZona = CCCreateField("idZona", "idZona", ccsInteger, Empty, Recordset)
        Set idZona_param1 = CCCreateField("idZona_param1", "idZona", ccsText, Empty, Recordset)
        Set descripcion = CCCreateField("descripcion", "descripcion", ccsText, Empty, Recordset)
        Fields.AddFields Array(idZona, idZona_param1, descripcion)
        Set Parameters = Server.CreateObject("Scripting.Dictionary")
        Set WhereParameters = Nothing
        Orders = Array( _ 
            Array("Sorter_idZona", "idZona", ""), _
            Array("Sorter_descripcion", "descripcion", ""))

        SQL = "SELECT TOP {SqlParam_endRecord} idZona, descripcion  " & vbLf & _
        "FROM zonas {SQL_Where} {SQL_OrderBy}"
        CountSQL = "SELECT COUNT(*) " & vbLf & _
        "FROM zonas"
        Where = ""
        Order = ""
        StaticOrder = ""
    End Sub
'End DataSource Class_Initialize Event

'SetOrder Method @6-68FC9576
    Sub SetOrder(Column, Direction)
        Order = Recordset.GetOrder(Order, Column, Direction, Orders)
    End Sub
'End SetOrder Method

'BuildTableWhere Method @6-B8660571
    Public Sub BuildTableWhere()
        Dim WhereParams

        If Not WhereParameters Is Nothing Then _
            Exit Sub
        Set WhereParameters = new clsSQLParameters
        With WhereParameters
            Set .Connection = Connection
            Set .ParameterSources = Parameters
            Set .DataSource = Me
            .AddParameter 1, "urls_descripcion", ccsText, Empty, Empty, Empty, False
            .Criterion(1) = .Operation(opContains, False, "descripcion", .getParamByID(1))
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

'Open Method @6-40984FC5
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

'DataSource Class_Terminate Event @6-41B4B08D
    Private Sub Class_Terminate()
        If Recordset.State = adStateOpen Then _
            Recordset.Close
        Set Recordset = Nothing
        Set Parameters = Nothing
        Set Errors = Nothing
    End Sub
'End DataSource Class_Terminate Event

End Class 'End zonasDataSource Class @6-A61BA892

'Include Page Implementation @20-F9BD05CE
%>
<!-- #INCLUDE VIRTUAL="/search/menu1.asp" -->
<%
'End Include Page Implementation


%>
