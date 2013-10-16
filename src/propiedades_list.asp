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

'Initialize Page @1-D0A7C8ED
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
Dim propiedadesSearch
Dim propiedades
Dim menu1
Dim ChildControls

Response.ContentType = CCSContentType
Redirect = ""
TemplateFileName = "propiedades_list.html"
Set CCSEvents = CreateObject("Scripting.Dictionary")
PathToCurrentPage = "./"
FileName = "propiedades_list.asp"
PathToRoot = "./"
ScriptPath = Left(Request.ServerVariables("PATH_TRANSLATED"), Len(Request.ServerVariables("PATH_TRANSLATED")) - Len(FileName))
TemplateFilePath = ScriptPath
'End Initialize Page

'Authenticate User @1-2858E0E9
CCSecurityRedirect Empty, "acc_denegado.asp"
'End Authenticate User

'Initialize Objects @1-F748DAAF
BindEvents "Page"
CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInitialize", Nothing)

Set DBConnection1 = New clsDBConnection1
DBConnection1.Open
Set Attributes = New clsAttributes
Attributes("pathToRoot") = PathToRoot

' Controls
Set propiedadesSearch = new clsRecordpropiedadesSearch
Set propiedades = New clsGridpropiedades
Set menu1 = New clsmenu1
Set menu1.Attributes = Attributes
menu1.Initialize "menu1", ""
propiedades.Initialize DBConnection1

' Events
%>
<!-- #INCLUDE VIRTUAL="/search/propiedades_list_events.asp" -->
<%
BindEvents Empty

CCSEventResult = CCRaiseEvent(CCSEvents, "AfterInitialize", Nothing)
'End Initialize Objects

'Execute Components @1-AB637F05
propiedadesSearch.Operation
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

'Show Page @1-AF20F9DF
Attributes.Show HTMLTemplate, "page:"
Set ChildControls = CCCreateCollection(Tpl, Null, ccsParseOverwrite, _
    Array(propiedadesSearch, propiedades, menu1))
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

'UnloadPage Sub @1-DB62BDF9
Sub UnloadPage()
    CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeUnload", Nothing)
    If DBConnection1.State = adStateOpen Then _
        DBConnection1.Close
    Set DBConnection1 = Nothing
    Set CCSEvents = Nothing
    Set Attributes = Nothing
    Set propiedadesSearch = Nothing
    Set propiedades = Nothing
    Set menu1 = Nothing
End Sub
'End UnloadPage Sub

Class clsRecordpropiedadesSearch 'propiedadesSearch Class @2-87B7D89F

'propiedadesSearch Variables @2-66B30BBF

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
    Dim s_valor
    Dim s_tipo
'End propiedadesSearch Variables

'propiedadesSearch Class_Initialize Event @2-EE56F1F9
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
            FormSubmitted = (OperationMode(0) = "propiedadesSearch")
        End If
        If UBound(OperationMode) > 0 Then 
            EditMode = (OperationMode(1) = "Edit")
        End If
        ComponentName = "propiedadesSearch"
        Method = IIf(FormSubmitted, ccsPost, ccsGet)
        Set Button_DoSearch = CCCreateButton("Button_DoSearch", Method)
        Set s_descripcion = CCCreateControl(ccsTextBox, "s_descripcion", Empty, ccsText, Empty, CCGetRequestParam("s_descripcion", Method))
        Set s_valor = CCCreateControl(ccsTextBox, "s_valor", Empty, ccsText, Empty, CCGetRequestParam("s_valor", Method))
        Set s_tipo = CCCreateList(ccsListBox, "s_tipo", Empty, ccsInteger, CCGetRequestParam("s_tipo", Method), Empty)
        s_tipo.BoundColumn = "idTipo"
        s_tipo.TextColumn = "descripcion"
        Set s_tipo.DataSource = CCCreateDataSource(dsTable,DBConnection1, Array("SELECT *  " & _
"FROM tipo_propiedad {SQL_Where} {SQL_OrderBy}", "", ""))
        Set ValidatingControls = new clsControls
        ValidatingControls.addControls Array(s_descripcion, s_valor, s_tipo)
    End Sub
'End propiedadesSearch Class_Initialize Event

'propiedadesSearch Class_Terminate Event @2-0C5D276C
    Private Sub Class_Terminate()
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End propiedadesSearch Class_Terminate Event

'propiedadesSearch Validate Method @2-B9D513CF
    Function Validate()
        Dim Validation
        ValidatingControls.Validate
        CCSEventResult = CCRaiseEvent(CCSEvents, "OnValidate", Me)
        Validate = ValidatingControls.isValid() And (Errors.Count = 0)
    End Function
'End propiedadesSearch Validate Method

'propiedadesSearch Operation Method @2-B1BDEBF2
    Sub Operation()
        If NOT ( Visible AND FormSubmitted ) Then Exit Sub

        If FormSubmitted Then
            PressedButton = "Button_DoSearch"
            If Button_DoSearch.Pressed Then
                PressedButton = "Button_DoSearch"
            End If
        End If
        Redirect = "propiedades_list.asp"
        If Validate() Then
            If PressedButton = "Button_DoSearch" Then
                If NOT Button_DoSearch.OnClick() Then
                    Redirect = ""
                Else
                    Redirect = "propiedades_list.asp?" & CCGetQueryString("Form", Array(PressedButton, "ccsForm", "Button_DoSearch.x", "Button_DoSearch.y", "Button_DoSearch"))
                End If
            End If
        Else
            Redirect = ""
        End If
    End Sub
'End propiedadesSearch Operation Method

'propiedadesSearch Show Method @2-9CB60C08
    Sub Show(Tpl)

        If NOT Visible Then Exit Sub

        EditMode = False
        HTMLFormAction = FileName & "?" & CCAddParam(Request.ServerVariables("QUERY_STRING"), "ccsForm", "propiedadesSearch" & IIf(EditMode, ":Edit", ""))
        Set TemplateBlock = Tpl.Block("Record " & ComponentName)
        If TemplateBlock is Nothing Then Exit Sub
        TemplateBlock.Variable("HTMLFormName") = ComponentName
        TemplateBlock.Variable("HTMLFormEnctype") ="application/x-www-form-urlencoded"
        Set Controls = CCCreateCollection(TemplateBlock, Null, ccsParseOverwrite, _
            Array(s_descripcion, s_tipo, s_valor, Button_DoSearch))
        If Not FormSubmitted Then
        End If
        If FormSubmitted Then
            Errors.AddErrors s_descripcion.Errors
            Errors.AddErrors s_valor.Errors
            Errors.AddErrors s_tipo.Errors
            With TemplateBlock.Block("Error")
                .Variable("Error") = Errors.ToString()
                .Parse False
            End With
        End If
        TemplateBlock.Variable("Action") = IIF(CCSUseAmps, Replace(HTMLFormAction, "&", CCSAmps), HTMLFormAction)

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Me)
        If Visible Then 
            Attributes.Show TemplateBlock, "propiedadesSearch" & ":"
            Controls.Show
        End If
    End Sub
'End propiedadesSearch Show Method

End Class 'End propiedadesSearch Class @2-A61BA892

Class clsGridpropiedades 'propiedades Class @6-1018A140

'propiedades Variables @6-F23E9049

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
    Dim propiedades_Insert
    Dim Sorter_id
    Dim Sorter_idZona
    Dim Sorter_idOperacion
    Dim Sorter_idTipo
    Dim Sorter_descripcion
    Dim Sorter_dormitorios
    Dim Sorter_valor
    Dim Sorter_activo
    Dim Sorter_orden
    Dim id
    Dim idZona
    Dim idOperacion
    Dim idTipo
    Dim descripcion
    Dim dormitorios
    Dim valor
    Dim activo
    Dim orden
    Dim Navigator
    Dim Link1
    Dim moneda
'End propiedades Variables

'propiedades Class_Initialize Event @6-DD988294
    Private Sub Class_Initialize()
        ComponentName = "propiedades"
        Visible = True
        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Attributes = New clsAttributes
        Set Errors = New clsErrors
        Set DataSource = New clspropiedadesDataSource
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
        ActiveSorter = CCGetParam("propiedadesOrder", Empty)
        SortingDirection = CCGetParam("propiedadesDir", Empty)
        If NOT(SortingDirection = "ASC" OR SortingDirection = "DESC") Then _
            SortingDirection = Empty

        Set propiedades_Insert = CCCreateControl(ccsLink, "propiedades_Insert", Empty, ccsText, Empty, CCGetRequestParam("propiedades_Insert", ccsGet))
        Set Sorter_id = CCCreateSorter("Sorter_id", Me, FileName)
        Set Sorter_idZona = CCCreateSorter("Sorter_idZona", Me, FileName)
        Set Sorter_idOperacion = CCCreateSorter("Sorter_idOperacion", Me, FileName)
        Set Sorter_idTipo = CCCreateSorter("Sorter_idTipo", Me, FileName)
        Set Sorter_descripcion = CCCreateSorter("Sorter_descripcion", Me, FileName)
        Set Sorter_dormitorios = CCCreateSorter("Sorter_dormitorios", Me, FileName)
        Set Sorter_valor = CCCreateSorter("Sorter_valor", Me, FileName)
        Set Sorter_activo = CCCreateSorter("Sorter_activo", Me, FileName)
        Set Sorter_orden = CCCreateSorter("Sorter_orden", Me, FileName)
        Set id = CCCreateControl(ccsLink, "id", Empty, ccsText, Empty, CCGetRequestParam("id", ccsGet))
        Set idZona = CCCreateControl(ccsLabel, "idZona", Empty, ccsText, Empty, CCGetRequestParam("idZona", ccsGet))
        Set idOperacion = CCCreateControl(ccsLabel, "idOperacion", Empty, ccsText, Empty, CCGetRequestParam("idOperacion", ccsGet))
        Set idTipo = CCCreateControl(ccsLabel, "idTipo", Empty, ccsText, Empty, CCGetRequestParam("idTipo", ccsGet))
        Set descripcion = CCCreateControl(ccsLabel, "descripcion", Empty, ccsText, Empty, CCGetRequestParam("descripcion", ccsGet))
        Set dormitorios = CCCreateControl(ccsLabel, "dormitorios", Empty, ccsInteger, Empty, CCGetRequestParam("dormitorios", ccsGet))
        Set valor = CCCreateControl(ccsLabel, "valor", Empty, ccsText, Empty, CCGetRequestParam("valor", ccsGet))
        Set activo = CCCreateControl(ccsLabel, "activo", Empty, ccsInteger, Empty, CCGetRequestParam("activo", ccsGet))
        Set orden = CCCreateControl(ccsLabel, "orden", Empty, ccsInteger, Empty, CCGetRequestParam("orden", ccsGet))
        Set Navigator = CCCreateNavigator(ComponentName, "Navigator", FileName, 10, tpSimple)
        Navigator.PageSizes = Array("1", "5", "10", "25", "50")
        Set Link1 = CCCreateControl(ccsLink, "Link1", Empty, ccsText, Empty, CCGetRequestParam("Link1", ccsGet))
        Set moneda = CCCreateControl(ccsLabel, "moneda", Empty, ccsText, Empty, CCGetRequestParam("moneda", ccsGet))
    IsDSEmpty = True
    End Sub
'End propiedades Class_Initialize Event

'propiedades Initialize Method @6-2AEA3975
    Sub Initialize(objConnection)
        If NOT Visible Then Exit Sub

        Set DataSource.Connection = objConnection
        DataSource.PageSize = PageSize
        DataSource.SetOrder ActiveSorter, SortingDirection
        DataSource.AbsolutePage = PageNumber
    End Sub
'End propiedades Initialize Method

'propiedades Class_Terminate Event @6-B97CC660
    Private Sub Class_Terminate()
        Set CCSEvents = Nothing
        Set DataSource = Nothing
        Set Command = Nothing
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End propiedades Class_Terminate Event

'propiedades Show Method @6-24159ED6
    Sub Show(Tpl)
        Dim HasNext
        If NOT Visible Then Exit Sub

        Dim RowBlock

        With DataSource
            .Parameters("urls_valor") = CCGetRequestParam("s_valor", ccsGET)
            .Parameters("urls_tipo") = CCGetRequestParam("s_tipo", ccsGET)
            .Parameters("urls_descripcion") = CCGetRequestParam("s_descripcion", ccsGET)
        End With

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeSelect", Me)
        Set Recordset = DataSource.Open(Command)
        If DataSource.Errors.Count = 0 Then IsDSEmpty = Recordset.EOF

        Set TemplateBlock = Tpl.Block("Grid " & ComponentName)
        If TemplateBlock is Nothing Then Exit Sub
        Set RowBlock = TemplateBlock.Block("Row")
        Set StaticControls = CCCreateCollection(TemplateBlock, Null, ccsParseOverwrite, _
            Array(propiedades_Insert, Sorter_id, Sorter_idZona, Sorter_idOperacion, Sorter_idTipo, Sorter_descripcion, Sorter_dormitorios, Sorter_valor, Sorter_activo, Sorter_orden, Navigator))
            
            propiedades_Insert.Parameters = CCGetQueryString("QueryString", Array("id", "ccsForm"))
            propiedades_Insert.Page = "propiedades_maint.asp"
            Navigator.PageSize = PageSize
            Navigator.SetDataSource Recordset
        Set RowControls = CCCreateCollection(RowBlock, Null, ccsParseAccumulate, _
            Array(id, idZona, idOperacion, idTipo, descripcion, dormitorios, valor, activo, orden, Link1, moneda))

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Me)
        If NOT Visible Then Exit Sub

        RowControls.PreserveControlsVisible
        Errors.AddErrors DataSource.Errors
        If Errors.Count > 0 Then
            TemplateBlock.HTML = CCFormatError("Grid " & ComponentName, Errors)
        Else

            ' Show NoRecords block if no records are found
            If Recordset.EOF Then
                Attributes.Show TemplateBlock, "propiedades:"
                TemplateBlock.Block("NoRecords").Parse ccsParseOverwrite
            End If
            HasNext = HasNextRow()
            ForceIteration = False
            Do While ForceIteration Or HasNext
                Attributes("rowNumber") = ShownRecords + 1
                If HasNext Then
                    id.Value = Recordset.Fields("id")
                    id.Parameters = CCGetQueryString("QueryString", Array("ccsForm"))
                    id.Parameters = CCAddParam(id.Parameters, "id", Recordset.Fields("id_param1"))
                    id.Page = "propiedades_maint.asp"
                    idZona.Value = Recordset.Fields("idZona")
                    idOperacion.Value = Recordset.Fields("idOperacion")
                    idTipo.Value = Recordset.Fields("idTipo")
                    descripcion.Value = Recordset.Fields("descripcion")
                    dormitorios.Value = Recordset.Fields("dormitorios")
                    valor.Value = Recordset.Fields("valor")
                    activo.Value = Recordset.Fields("activo")
                    orden.Value = Recordset.Fields("orden")
                    
                    Link1.Parameters = CCGetQueryString("QueryString", Array("ccsForm"))
                    Link1.Parameters = CCAddParam(Link1.Parameters, "id", Recordset.Fields("Link1_param1"))
                    Link1.Page = "attach.asp"
                    moneda.Value = Recordset.Fields("moneda")
                End If
                CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShowRow", Me)
                Attributes.Show TemplateBlock.Block("Row"), "propiedades:"
                RowControls.Show
                If HasNext Then Recordset.MoveNext
                ShownRecords = ShownRecords + 1
                HasNext = HasNextRow()
            Loop
            Attributes.Show TemplateBlock, "propiedades:"
            StaticControls.Show
        End If

    End Sub
'End propiedades Show Method

'propiedades PageSize Property Let @6-54E46DD6
    Public Property Let PageSize(NewValue)
        VarPageSize = NewValue
        DataSource.PageSize = NewValue
    End Property
'End propiedades PageSize Property Let

'propiedades PageSize Property Get @6-9AA1D1E9
    Public Property Get PageSize()
        PageSize = VarPageSize
    End Property
'End propiedades PageSize Property Get

'propiedades RowNumber Property Get @6-F32EE2C6
    Public Property Get RowNumber()
        RowNumber = ShownRecords + 1
    End Property
'End propiedades RowNumber Property Get

'propiedades HasNextRow Function @6-9BECE27A
    Public Function HasNextRow()
        HasNextRow = NOT Recordset.EOF AND ShownRecords < PageSize
    End Function
'End propiedades HasNextRow Function

End Class 'End propiedades Class @6-A61BA892

Class clspropiedadesDataSource 'propiedadesDataSource Class @6-B58C0B7E

'DataSource Variables @6-F22CED0B
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
    Public id
    Public id_param1
    Public idZona
    Public idOperacion
    Public idTipo
    Public descripcion
    Public dormitorios
    Public valor
    Public activo
    Public orden
    Public Link1_param1
    Public moneda
'End DataSource Variables

'DataSource Class_Initialize Event @6-DC4D4A16
    Private Sub Class_Initialize()

        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Fields = New clsFields
        Set Recordset = New clsDataSource
        Set Recordset.DataSource = Me
        Set Errors = New clsErrors
        Set Connection = Nothing
        AllParamsSet = True
        Set id = CCCreateField("id", "id", ccsText, Empty, Recordset)
        Set id_param1 = CCCreateField("id_param1", "idPropiedad", ccsText, Empty, Recordset)
        Set idZona = CCCreateField("idZona", "idZona", ccsText, Empty, Recordset)
        Set idOperacion = CCCreateField("idOperacion", "idOperacion", ccsText, Empty, Recordset)
        Set idTipo = CCCreateField("idTipo", "idTipo", ccsText, Empty, Recordset)
        Set descripcion = CCCreateField("descripcion", "descripcion", ccsText, Empty, Recordset)
        Set dormitorios = CCCreateField("dormitorios", "dormitorios", ccsInteger, Empty, Recordset)
        Set valor = CCCreateField("valor", "valor", ccsText, Empty, Recordset)
        Set activo = CCCreateField("activo", "activo", ccsInteger, Empty, Recordset)
        Set orden = CCCreateField("orden", "orden", ccsInteger, Empty, Recordset)
        Set Link1_param1 = CCCreateField("Link1_param1", "idPropiedad", ccsText, Empty, Recordset)
        Set moneda = CCCreateField("moneda", "idMoneda", ccsText, Empty, Recordset)
        Fields.AddFields Array(id,  id_param1,  idZona,  idOperacion,  idTipo,  descripcion,  dormitorios, _
             valor,  activo,  orden,  moneda,  Link1_param1)
        Set Parameters = Server.CreateObject("Scripting.Dictionary")
        Set WhereParameters = Nothing
        Orders = Array( _ 
            Array("Sorter_id", "id", ""), _
            Array("Sorter_idZona", "idZona", ""), _
            Array("Sorter_idOperacion", "idOperacion", ""), _
            Array("Sorter_idTipo", "idTipo", ""), _
            Array("Sorter_descripcion", "descripcion", ""), _
            Array("Sorter_dormitorios", "dormitorios", ""), _
            Array("Sorter_valor", "valor", ""), _
            Array("Sorter_activo", "activo", ""), _
            Array("Sorter_orden", "orden", ""))

        SQL = "SELECT TOP {SqlParam_endRecord} id, idZona, idOperacion, idTipo, descripcion, dormitorios, valor, activo, orden, idMoneda, idPropiedad  " & vbLf & _
        "FROM propiedades {SQL_Where} {SQL_OrderBy}"
        CountSQL = "SELECT COUNT(*) " & vbLf & _
        "FROM propiedades"
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

'BuildTableWhere Method @6-341EF7CF
    Public Sub BuildTableWhere()
        Dim WhereParams

        If Not WhereParameters Is Nothing Then _
            Exit Sub
        Set WhereParameters = new clsSQLParameters
        With WhereParameters
            Set .Connection = Connection
            Set .ParameterSources = Parameters
            Set .DataSource = Me
            .AddParameter 1, "urls_valor", ccsText, Empty, Empty, Empty, False
            .AddParameter 2, "urls_tipo", ccsInteger, Empty, Empty, Empty, False
            .AddParameter 3, "urls_descripcion", ccsText, Empty, Empty, Empty, False
            .Criterion(1) = .Operation(opContains, False, "valor", .getParamByID(1))
            .Criterion(2) = .Operation(opContains, False, "[idTipo]", .getParamByID(2))
            .Criterion(3) = .Operation(opContains, False, "id", .getParamByID(3))
            .AssembledWhere = .opAND(False, .opAND(False, .Criterion(1), .Criterion(2)), .Criterion(3))
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

End Class 'End propiedadesDataSource Class @6-A61BA892

'Include Page Implementation @46-F9BD05CE
%>
<!-- #INCLUDE VIRTUAL="/search/menu1.asp" -->
<%
'End Include Page Implementation


%>
