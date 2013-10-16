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

'Initialize Page @1-61F22F0F
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
Dim tipo_propiedadSearch
Dim tipo_propiedad
Dim menu1
Dim ChildControls

Response.ContentType = CCSContentType
Redirect = ""
TemplateFileName = "tipo_propiedad_list.html"
Set CCSEvents = CreateObject("Scripting.Dictionary")
PathToCurrentPage = "./"
FileName = "tipo_propiedad_list.asp"
PathToRoot = "./"
ScriptPath = Left(Request.ServerVariables("PATH_TRANSLATED"), Len(Request.ServerVariables("PATH_TRANSLATED")) - Len(FileName))
TemplateFilePath = ScriptPath
'End Initialize Page

'Authenticate User @1-4F82CB21
CCSecurityRedirect "100", Empty
'End Authenticate User

'Initialize Objects @1-1C7C7B97
BindEvents "Page"
CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInitialize", Nothing)

Set DBConnection1 = New clsDBConnection1
DBConnection1.Open
Set Attributes = New clsAttributes
Attributes("pathToRoot") = PathToRoot

' Controls
Set tipo_propiedadSearch = new clsRecordtipo_propiedadSearch
Set tipo_propiedad = New clsGridtipo_propiedad
Set menu1 = New clsmenu1
Set menu1.Attributes = Attributes
menu1.Initialize "menu1", ""
tipo_propiedad.Initialize DBConnection1

' Events
%>
<!-- #INCLUDE VIRTUAL="/search/tipo_propiedad_list_events.asp" -->
<%
BindEvents Empty

CCSEventResult = CCRaiseEvent(CCSEvents, "AfterInitialize", Nothing)
'End Initialize Objects

'Execute Components @1-502C0E7C
tipo_propiedadSearch.Operation
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

'Show Page @1-5613ED45
Attributes.Show HTMLTemplate, "page:"
Set ChildControls = CCCreateCollection(Tpl, Null, ccsParseOverwrite, _
    Array(tipo_propiedadSearch, tipo_propiedad, menu1))
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

'UnloadPage Sub @1-C6F214D9
Sub UnloadPage()
    CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeUnload", Nothing)
    If DBConnection1.State = adStateOpen Then _
        DBConnection1.Close
    Set DBConnection1 = Nothing
    Set CCSEvents = Nothing
    Set Attributes = Nothing
    Set tipo_propiedadSearch = Nothing
    Set tipo_propiedad = Nothing
    Set menu1 = Nothing
End Sub
'End UnloadPage Sub

Class clsRecordtipo_propiedadSearch 'tipo_propiedadSearch Class @2-8DA5184A

'tipo_propiedadSearch Variables @2-D577D315

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
'End tipo_propiedadSearch Variables

'tipo_propiedadSearch Class_Initialize Event @2-3C7D9AD8
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
            FormSubmitted = (OperationMode(0) = "tipo_propiedadSearch")
        End If
        If UBound(OperationMode) > 0 Then 
            EditMode = (OperationMode(1) = "Edit")
        End If
        ComponentName = "tipo_propiedadSearch"
        Method = IIf(FormSubmitted, ccsPost, ccsGet)
        Set Button_DoSearch = CCCreateButton("Button_DoSearch", Method)
        Set s_descripcion = CCCreateControl(ccsTextBox, "s_descripcion", Empty, ccsText, Empty, CCGetRequestParam("s_descripcion", Method))
        Set ValidatingControls = new clsControls
        ValidatingControls.addControls Array(s_descripcion)
    End Sub
'End tipo_propiedadSearch Class_Initialize Event

'tipo_propiedadSearch Class_Terminate Event @2-0C5D276C
    Private Sub Class_Terminate()
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End tipo_propiedadSearch Class_Terminate Event

'tipo_propiedadSearch Validate Method @2-B9D513CF
    Function Validate()
        Dim Validation
        ValidatingControls.Validate
        CCSEventResult = CCRaiseEvent(CCSEvents, "OnValidate", Me)
        Validate = ValidatingControls.isValid() And (Errors.Count = 0)
    End Function
'End tipo_propiedadSearch Validate Method

'tipo_propiedadSearch Operation Method @2-2A03DE3E
    Sub Operation()
        If NOT ( Visible AND FormSubmitted ) Then Exit Sub

        If FormSubmitted Then
            PressedButton = "Button_DoSearch"
            If Button_DoSearch.Pressed Then
                PressedButton = "Button_DoSearch"
            End If
        End If
        Redirect = "tipo_propiedad_list.asp"
        If Validate() Then
            If PressedButton = "Button_DoSearch" Then
                If NOT Button_DoSearch.OnClick() Then
                    Redirect = ""
                Else
                    Redirect = "tipo_propiedad_list.asp?" & CCGetQueryString("Form", Array(PressedButton, "ccsForm", "Button_DoSearch.x", "Button_DoSearch.y", "Button_DoSearch"))
                End If
            End If
        Else
            Redirect = ""
        End If
    End Sub
'End tipo_propiedadSearch Operation Method

'tipo_propiedadSearch Show Method @2-8BA1485D
    Sub Show(Tpl)

        If NOT Visible Then Exit Sub

        EditMode = False
        HTMLFormAction = FileName & "?" & CCAddParam(Request.ServerVariables("QUERY_STRING"), "ccsForm", "tipo_propiedadSearch" & IIf(EditMode, ":Edit", ""))
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
            Attributes.Show TemplateBlock, "tipo_propiedadSearch" & ":"
            Controls.Show
        End If
    End Sub
'End tipo_propiedadSearch Show Method

End Class 'End tipo_propiedadSearch Class @2-A61BA892

Class clsGridtipo_propiedad 'tipo_propiedad Class @6-1A381AFA

'tipo_propiedad Variables @6-AEF13361

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
    Dim tipo_propiedad_Insert
    Dim Sorter_idTipo
    Dim Sorter_descripcion
    Dim idTipo
    Dim descripcion
    Dim Navigator
'End tipo_propiedad Variables

'tipo_propiedad Class_Initialize Event @6-1E0DC220
    Private Sub Class_Initialize()
        ComponentName = "tipo_propiedad"
        Visible = True
        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Attributes = New clsAttributes
        Set Errors = New clsErrors
        Set DataSource = New clstipo_propiedadDataSource
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
        ActiveSorter = CCGetParam("tipo_propiedadOrder", Empty)
        SortingDirection = CCGetParam("tipo_propiedadDir", Empty)
        If NOT(SortingDirection = "ASC" OR SortingDirection = "DESC") Then _
            SortingDirection = Empty

        Set tipo_propiedad_Insert = CCCreateControl(ccsLink, "tipo_propiedad_Insert", Empty, ccsText, Empty, CCGetRequestParam("tipo_propiedad_Insert", ccsGet))
        Set Sorter_idTipo = CCCreateSorter("Sorter_idTipo", Me, FileName)
        Set Sorter_descripcion = CCCreateSorter("Sorter_descripcion", Me, FileName)
        Set idTipo = CCCreateControl(ccsLink, "idTipo", Empty, ccsInteger, Empty, CCGetRequestParam("idTipo", ccsGet))
        Set descripcion = CCCreateControl(ccsLabel, "descripcion", Empty, ccsText, Empty, CCGetRequestParam("descripcion", ccsGet))
        Set Navigator = CCCreateNavigator(ComponentName, "Navigator", FileName, 10, tpSimple)
        Navigator.PageSizes = Array("1", "5", "10", "25", "50")
    IsDSEmpty = True
    End Sub
'End tipo_propiedad Class_Initialize Event

'tipo_propiedad Initialize Method @6-2AEA3975
    Sub Initialize(objConnection)
        If NOT Visible Then Exit Sub

        Set DataSource.Connection = objConnection
        DataSource.PageSize = PageSize
        DataSource.SetOrder ActiveSorter, SortingDirection
        DataSource.AbsolutePage = PageNumber
    End Sub
'End tipo_propiedad Initialize Method

'tipo_propiedad Class_Terminate Event @6-B97CC660
    Private Sub Class_Terminate()
        Set CCSEvents = Nothing
        Set DataSource = Nothing
        Set Command = Nothing
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End tipo_propiedad Class_Terminate Event

'tipo_propiedad Show Method @6-B635DD36
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
            Array(tipo_propiedad_Insert, Sorter_idTipo, Sorter_descripcion, Navigator))
            
            tipo_propiedad_Insert.Parameters = CCGetQueryString("QueryString", Array("idTipo", "ccsForm"))
            tipo_propiedad_Insert.Page = "tipo_propiedad_maint.asp"
            Navigator.PageSize = PageSize
            Navigator.SetDataSource Recordset
        Set RowControls = CCCreateCollection(RowBlock, Null, ccsParseAccumulate, _
            Array(idTipo, descripcion))

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Me)
        If NOT Visible Then Exit Sub

        RowControls.PreserveControlsVisible
        Errors.AddErrors DataSource.Errors
        If Errors.Count > 0 Then
            TemplateBlock.HTML = CCFormatError("Grid " & ComponentName, Errors)
        Else

            ' Show NoRecords block if no records are found
            If Recordset.EOF Then
                Attributes.Show TemplateBlock, "tipo_propiedad:"
                TemplateBlock.Block("NoRecords").Parse ccsParseOverwrite
            End If
            HasNext = HasNextRow()
            ForceIteration = False
            Do While ForceIteration Or HasNext
                Attributes("rowNumber") = ShownRecords + 1
                If HasNext Then
                    idTipo.Value = Recordset.Fields("idTipo")
                    idTipo.Parameters = CCGetQueryString("QueryString", Array("ccsForm"))
                    idTipo.Parameters = CCAddParam(idTipo.Parameters, "idTipo", Recordset.Fields("idTipo_param1"))
                    idTipo.Page = "tipo_propiedad_maint.asp"
                    descripcion.Value = Recordset.Fields("descripcion")
                End If
                CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShowRow", Me)
                Attributes.Show TemplateBlock.Block("Row"), "tipo_propiedad:"
                RowControls.Show
                If HasNext Then Recordset.MoveNext
                ShownRecords = ShownRecords + 1
                HasNext = HasNextRow()
            Loop
            Attributes.Show TemplateBlock, "tipo_propiedad:"
            StaticControls.Show
        End If

    End Sub
'End tipo_propiedad Show Method

'tipo_propiedad PageSize Property Let @6-54E46DD6
    Public Property Let PageSize(NewValue)
        VarPageSize = NewValue
        DataSource.PageSize = NewValue
    End Property
'End tipo_propiedad PageSize Property Let

'tipo_propiedad PageSize Property Get @6-9AA1D1E9
    Public Property Get PageSize()
        PageSize = VarPageSize
    End Property
'End tipo_propiedad PageSize Property Get

'tipo_propiedad RowNumber Property Get @6-F32EE2C6
    Public Property Get RowNumber()
        RowNumber = ShownRecords + 1
    End Property
'End tipo_propiedad RowNumber Property Get

'tipo_propiedad HasNextRow Function @6-9BECE27A
    Public Function HasNextRow()
        HasNextRow = NOT Recordset.EOF AND ShownRecords < PageSize
    End Function
'End tipo_propiedad HasNextRow Function

End Class 'End tipo_propiedad Class @6-A61BA892

Class clstipo_propiedadDataSource 'tipo_propiedadDataSource Class @6-6AC6044F

'DataSource Variables @6-798C6964
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
    Public idTipo
    Public idTipo_param1
    Public descripcion
'End DataSource Variables

'DataSource Class_Initialize Event @6-3123063E
    Private Sub Class_Initialize()

        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Fields = New clsFields
        Set Recordset = New clsDataSource
        Set Recordset.DataSource = Me
        Set Errors = New clsErrors
        Set Connection = Nothing
        AllParamsSet = True
        Set idTipo = CCCreateField("idTipo", "idTipo", ccsInteger, Empty, Recordset)
        Set idTipo_param1 = CCCreateField("idTipo_param1", "idTipo", ccsText, Empty, Recordset)
        Set descripcion = CCCreateField("descripcion", "descripcion", ccsText, Empty, Recordset)
        Fields.AddFields Array(idTipo, idTipo_param1, descripcion)
        Set Parameters = Server.CreateObject("Scripting.Dictionary")
        Set WhereParameters = Nothing
        Orders = Array( _ 
            Array("Sorter_idTipo", "idTipo", ""), _
            Array("Sorter_descripcion", "descripcion", ""))

        SQL = "SELECT TOP {SqlParam_endRecord} idTipo, descripcion  " & vbLf & _
        "FROM tipo_propiedad {SQL_Where} {SQL_OrderBy}"
        CountSQL = "SELECT COUNT(*) " & vbLf & _
        "FROM tipo_propiedad"
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

End Class 'End tipo_propiedadDataSource Class @6-A61BA892

'Include Page Implementation @20-F9BD05CE
%>
<!-- #INCLUDE VIRTUAL="/search/menu1.asp" -->
<%
'End Include Page Implementation


%>
