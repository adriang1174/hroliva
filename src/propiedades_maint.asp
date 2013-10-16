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

'Initialize Page @1-DC5F5D64
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
Dim menu1
Dim propiedades
Dim ChildControls

Response.ContentType = CCSContentType
Redirect = ""
TemplateFileName = "propiedades_maint.html"
Set CCSEvents = CreateObject("Scripting.Dictionary")
PathToCurrentPage = "./"
FileName = "propiedades_maint.asp"
PathToRoot = "./"
ScriptPath = Left(Request.ServerVariables("PATH_TRANSLATED"), Len(Request.ServerVariables("PATH_TRANSLATED")) - Len(FileName))
TemplateFilePath = ScriptPath
'End Initialize Page

'Initialize Objects @1-4A6B9A83
CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInitialize", Nothing)

Set DBConnection1 = New clsDBConnection1
DBConnection1.Open
Set Attributes = New clsAttributes
Attributes("pathToRoot") = PathToRoot

' Controls
Set menu1 = New clsmenu1
Set menu1.Attributes = Attributes
menu1.Initialize "menu1", ""
Set propiedades = new clsRecordpropiedades
propiedades.Initialize DBConnection1

CCSEventResult = CCRaiseEvent(CCSEvents, "AfterInitialize", Nothing)
'End Initialize Objects

'Execute Components @1-67972D2C
menu1.Operations
propiedades.Operation
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

'Show Page @1-2C2B63E2
Attributes.Show HTMLTemplate, "page:"
Set ChildControls = CCCreateCollection(Tpl, Null, ccsParseOverwrite, _
    Array(menu1, propiedades))
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

'UnloadPage Sub @1-DF0727F4
Sub UnloadPage()
    CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeUnload", Nothing)
    If DBConnection1.State = adStateOpen Then _
        DBConnection1.Close
    Set DBConnection1 = Nothing
    Set CCSEvents = Nothing
    Set Attributes = Nothing
    Set menu1 = Nothing
    Set propiedades = Nothing
End Sub
'End UnloadPage Sub

Class clsRecordpropiedades 'propiedades Class @3-806FCECF

'propiedades Variables @3-1F5A4921

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
    Dim Button_Insert
    Dim Button_Update
    Dim Button_Delete
    Dim id
    Dim idZona
    Dim idOperacion
    Dim idTipo
    Dim descripcion
    Dim dormitorios
    Dim valor
    Dim valor_num
    Dim idMoneda
    Dim activo
    Dim orden
'End propiedades Variables

'propiedades Class_Initialize Event @3-23BD35A4
    Private Sub Class_Initialize()

        Visible = True
        Set Errors = New clsErrors
        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Attributes = New clsAttributes
        Set DataSource = New clspropiedadesDataSource
        Set Command = New clsCommand
        InsertAllowed = True
        UpdateAllowed = True
        DeleteAllowed = True
        ReadAllowed = True
        Dim Method
        Dim OperationMode
        OperationMode = Split(CCGetFromGet("ccsForm", Empty), ":")
        If UBound(OperationMode) > -1 Then 
            FormSubmitted = (OperationMode(0) = "propiedades")
        End If
        If UBound(OperationMode) > 0 Then 
            EditMode = (OperationMode(1) = "Edit")
        End If
        ComponentName = "propiedades"
        Method = IIf(FormSubmitted, ccsPost, ccsGet)
        Set Button_Insert = CCCreateButton("Button_Insert", Method)
        Set Button_Update = CCCreateButton("Button_Update", Method)
        Set Button_Delete = CCCreateButton("Button_Delete", Method)
        Set id = CCCreateControl(ccsTextBox, "id", "Id", ccsText, Empty, CCGetRequestParam("id", Method))
        id.Required = True
        Set idZona = CCCreateList(ccsListBox, "idZona", "Id Zona", ccsInteger, CCGetRequestParam("idZona", Method), Empty)
        idZona.BoundColumn = "idZona"
        idZona.TextColumn = "descripcion"
        Set idZona.DataSource = CCCreateDataSource(dsTable,DBConnection1, Array("SELECT *  " & _
"FROM zonas {SQL_Where} {SQL_OrderBy}", "", ""))
        idZona.Required = True
        Set idOperacion = CCCreateList(ccsListBox, "idOperacion", "Id Operacion", ccsInteger, CCGetRequestParam("idOperacion", Method), Empty)
        idOperacion.BoundColumn = "idOperacion"
        idOperacion.TextColumn = "descripcion"
        Set idOperacion.DataSource = CCCreateDataSource(dsTable,DBConnection1, Array("SELECT *  " & _
"FROM operaciones {SQL_Where} {SQL_OrderBy}", "", ""))
        idOperacion.Required = True
        Set idTipo = CCCreateList(ccsListBox, "idTipo", "Id Tipo", ccsInteger, CCGetRequestParam("idTipo", Method), Empty)
        idTipo.BoundColumn = "idTipo"
        idTipo.TextColumn = "descripcion"
        Set idTipo.DataSource = CCCreateDataSource(dsTable,DBConnection1, Array("SELECT *  " & _
"FROM tipo_propiedad {SQL_Where} {SQL_OrderBy}", "", ""))
        idTipo.Required = True
        Set descripcion = CCCreateControl(ccsTextArea, "descripcion", "Descripcion", ccsText, Empty, CCGetRequestParam("descripcion", Method))
        descripcion.Required = True
        Set dormitorios = CCCreateControl(ccsTextBox, "dormitorios", "Dormitorios", ccsInteger, Empty, CCGetRequestParam("dormitorios", Method))
        Set valor = CCCreateControl(ccsTextBox, "valor", "Valor", ccsText, Empty, CCGetRequestParam("valor", Method))
        Set valor_num = CCCreateControl(ccsTextBox, "valor_num", "Valor Num", ccsFloat, Empty, CCGetRequestParam("valor_num", Method))
        Set idMoneda = CCCreateList(ccsListBox, "idMoneda", "Id Moneda", ccsInteger, CCGetRequestParam("idMoneda", Method), Empty)
        idMoneda.BoundColumn = "idMoneda"
        idMoneda.TextColumn = "descripcion"
        Set idMoneda.DataSource = CCCreateDataSource(dsTable,DBConnection1, Array("SELECT *  " & _
"FROM moneda {SQL_Where} {SQL_OrderBy}", "", ""))
        Set activo = CCCreateControl(ccsCheckBox, "activo", Empty, ccsInteger, Empty, CCGetRequestParam("activo", Method))
        activo.CheckedValue = 1
        activo.UncheckedValue = 0
        Set orden = CCCreateControl(ccsTextBox, "orden", "Orden", ccsInteger, Empty, CCGetRequestParam("orden", Method))
        Set ValidatingControls = new clsControls
        ValidatingControls.addControls Array(id, idZona, idOperacion, idTipo, descripcion, dormitorios, valor, _
             valor_num, idMoneda, activo, orden)
    End Sub
'End propiedades Class_Initialize Event

'propiedades Initialize Method @3-94A365A6
    Sub Initialize(objConnection)

        If NOT Visible Then Exit Sub


        Set DataSource.Connection = objConnection
        With DataSource
            .Parameters("urlid") = CCGetRequestParam("id", ccsGET)
        End With
    End Sub
'End propiedades Initialize Method

'propiedades Class_Terminate Event @3-0C5D276C
    Private Sub Class_Terminate()
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End propiedades Class_Terminate Event

'propiedades Validate Method @3-B9D513CF
    Function Validate()
        Dim Validation
        ValidatingControls.Validate
        CCSEventResult = CCRaiseEvent(CCSEvents, "OnValidate", Me)
        Validate = ValidatingControls.isValid() And (Errors.Count = 0)
    End Function
'End propiedades Validate Method

'propiedades Operation Method @3-F022148F
    Sub Operation()
        If NOT ( Visible AND FormSubmitted ) Then Exit Sub

        If FormSubmitted Then
            PressedButton = IIf(EditMode, "Button_Update", "Button_Insert")
            If Button_Insert.Pressed Then
                PressedButton = "Button_Insert"
            ElseIf Button_Update.Pressed Then
                PressedButton = "Button_Update"
            ElseIf Button_Delete.Pressed Then
                PressedButton = "Button_Delete"
            End If
        End If
        Redirect = FileName & "?" & CCGetQueryString("QueryString", Array("ccsForm", "Button_Insert.x", "Button_Insert.y", "Button_Insert", "Button_Update.x", "Button_Update.y", "Button_Update", "Button_Delete.x", "Button_Delete.y", "Button_Delete"))
        If PressedButton = "Button_Delete" Then
            If NOT Button_Delete.OnClick OR NOT DeleteRow() Then
                Redirect = ""
            End If
        ElseIf Validate() Then
            If PressedButton = "Button_Insert" Then
                If NOT Button_Insert.OnClick() OR NOT InsertRow() Then
                    Redirect = ""
                End If
            ElseIf PressedButton = "Button_Update" Then
                If NOT Button_Update.OnClick() OR NOT UpdateRow() Then
                    Redirect = ""
                End If
            End If
        Else
            Redirect = ""
        End If
    End Sub
'End propiedades Operation Method

'propiedades InsertRow Method @3-C9BB7EFD
    Function InsertRow()
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInsert", Me)
        If NOT InsertAllowed Then InsertRow = False : Exit Function
        DataSource.id.Value = id.Value
        DataSource.idZona.Value = idZona.Value
        DataSource.idOperacion.Value = idOperacion.Value
        DataSource.idTipo.Value = idTipo.Value
        DataSource.descripcion.Value = descripcion.Value
        DataSource.dormitorios.Value = dormitorios.Value
        DataSource.valor.Value = valor.Value
        DataSource.valor_num.Value = valor_num.Value
        DataSource.idMoneda.Value = idMoneda.Value
        DataSource.activo.Value = activo.Value
        DataSource.orden.Value = orden.Value
        DataSource.Insert(Command)


        CCSEventResult = CCRaiseEvent(CCSEvents, "AfterInsert", Me)
        If DataSource.Errors.Count > 0 Then
            Errors.AddErrors(DataSource.Errors)
            DataSource.Errors.Clear
        End If
        InsertRow = (Errors.Count = 0)
    End Function
'End propiedades InsertRow Method

'propiedades UpdateRow Method @3-DAA57203
    Function UpdateRow()
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeUpdate", Me)
        If NOT UpdateAllowed Then UpdateRow = False : Exit Function
        DataSource.id.Value = id.Value
        DataSource.idZona.Value = idZona.Value
        DataSource.idOperacion.Value = idOperacion.Value
        DataSource.idTipo.Value = idTipo.Value
        DataSource.descripcion.Value = descripcion.Value
        DataSource.dormitorios.Value = dormitorios.Value
        DataSource.valor.Value = valor.Value
        DataSource.valor_num.Value = valor_num.Value
        DataSource.idMoneda.Value = idMoneda.Value
        DataSource.activo.Value = activo.Value
        DataSource.orden.Value = orden.Value
        DataSource.Update(Command)


        CCSEventResult = CCRaiseEvent(CCSEvents, "AfterUpdate", Me)
        If DataSource.Errors.Count > 0 Then
            Errors.AddErrors(DataSource.Errors)
            DataSource.Errors.Clear
        End If
        UpdateRow = (Errors.Count = 0)
    End Function
'End propiedades UpdateRow Method

'propiedades DeleteRow Method @3-D5C1DF24
    Function DeleteRow()
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeDelete", Me)
        If NOT DeleteAllowed Then DeleteRow = False : Exit Function
        DataSource.Delete(Command)


        CCSEventResult = CCRaiseEvent(CCSEvents, "AfterDelete", Me)
        If DataSource.Errors.Count > 0 Then
            Errors.AddErrors(DataSource.Errors)
            DataSource.Errors.Clear
        End If
        DeleteRow = (Errors.Count = 0)
    End Function
'End propiedades DeleteRow Method

'propiedades Show Method @3-526D7776
    Sub Show(Tpl)

        If NOT Visible Then Exit Sub

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeSelect", Me)
        Set Recordset = DataSource.Open(Command)
        EditMode = Recordset.EditMode(ReadAllowed)
        HTMLFormAction = FileName & "?" & CCAddParam(Request.ServerVariables("QUERY_STRING"), "ccsForm", "propiedades" & IIf(EditMode, ":Edit", ""))
        Set TemplateBlock = Tpl.Block("Record " & ComponentName)
        If TemplateBlock is Nothing Then Exit Sub
        TemplateBlock.Variable("HTMLFormName") = ComponentName
        TemplateBlock.Variable("HTMLFormEnctype") ="application/x-www-form-urlencoded"
        If DataSource.Errors.Count > 0 Then
            Errors.AddErrors(DataSource.Errors)
            DataSource.Errors.Clear
            With TemplateBlock.Block("Error")
                .Variable("Error") = Errors.ToString
                .Parse False
            End With
        End If
        Set Controls = CCCreateCollection(TemplateBlock, Null, ccsParseOverwrite, _
            Array(id,  idZona,  idOperacion,  idTipo,  descripcion,  dormitorios,  valor, _
                 valor_num,  idMoneda,  activo,  orden,  Button_Insert,  Button_Update,  Button_Delete))
        If EditMode AND ReadAllowed Then
            If Errors.Count = 0 Then
                If Recordset.Errors.Count > 0 Then
                    With TemplateBlock.Block("Error")
                        .Variable("Error") = Recordset.Errors.ToString
                        .Parse False
                    End With
                ElseIf Recordset.CanPopulate() Then
                    If Not FormSubmitted Then
                        id.Value = Recordset.Fields("id")
                        idZona.Value = Recordset.Fields("idZona")
                        idOperacion.Value = Recordset.Fields("idOperacion")
                        idTipo.Value = Recordset.Fields("idTipo")
                        descripcion.Value = Recordset.Fields("descripcion")
                        dormitorios.Value = Recordset.Fields("dormitorios")
                        valor.Value = Recordset.Fields("valor")
                        valor_num.Value = Recordset.Fields("valor_num")
                        idMoneda.Value = Recordset.Fields("idMoneda")
                        activo.Value = Recordset.Fields("activo")
                        orden.Value = Recordset.Fields("orden")
                    End If
                Else
                    EditMode = False
                End If
            End If
        End If
        If Not FormSubmitted Then
        End If
        If FormSubmitted Then
            Errors.AddErrors id.Errors
            Errors.AddErrors idZona.Errors
            Errors.AddErrors idOperacion.Errors
            Errors.AddErrors idTipo.Errors
            Errors.AddErrors descripcion.Errors
            Errors.AddErrors dormitorios.Errors
            Errors.AddErrors valor.Errors
            Errors.AddErrors valor_num.Errors
            Errors.AddErrors idMoneda.Errors
            Errors.AddErrors activo.Errors
            Errors.AddErrors orden.Errors
            Errors.AddErrors DataSource.Errors
            With TemplateBlock.Block("Error")
                .Variable("Error") = Errors.ToString()
                .Parse False
            End With
        End If
        TemplateBlock.Variable("Action") = IIF(CCSUseAmps, Replace(HTMLFormAction, "&", CCSAmps), HTMLFormAction)
        Button_Insert.Visible = NOT EditMode AND InsertAllowed
        Button_Update.Visible = EditMode AND UpdateAllowed
        Button_Delete.Visible = EditMode AND DeleteAllowed

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Me)
        If Visible Then 
            Attributes.Show TemplateBlock, "propiedades" & ":"
            Controls.Show
        End If
    End Sub
'End propiedades Show Method

End Class 'End propiedades Class @3-A61BA892

Class clspropiedadesDataSource 'propiedadesDataSource Class @3-B58C0B7E

'DataSource Variables @3-0B9F6918
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
    Public idZona
    Public idOperacion
    Public idTipo
    Public descripcion
    Public dormitorios
    Public valor
    Public valor_num
    Public idMoneda
    Public activo
    Public orden
'End DataSource Variables

'DataSource Class_Initialize Event @3-C7B20022
    Private Sub Class_Initialize()

        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Fields = New clsFields
        Set Recordset = New clsDataSource
        Set Recordset.DataSource = Me
        Set Errors = New clsErrors
        Set Connection = Nothing
        AllParamsSet = True
        Set id = CCCreateField("id", "id", ccsText, Empty, Recordset)
        Set idZona = CCCreateField("idZona", "idZona", ccsInteger, Empty, Recordset)
        Set idOperacion = CCCreateField("idOperacion", "idOperacion", ccsInteger, Empty, Recordset)
        Set idTipo = CCCreateField("idTipo", "idTipo", ccsInteger, Empty, Recordset)
        Set descripcion = CCCreateField("descripcion", "descripcion", ccsText, Empty, Recordset)
        Set dormitorios = CCCreateField("dormitorios", "dormitorios", ccsInteger, Empty, Recordset)
        Set valor = CCCreateField("valor", "valor", ccsText, Empty, Recordset)
        Set valor_num = CCCreateField("valor_num", "valor_num", ccsFloat, Empty, Recordset)
        Set idMoneda = CCCreateField("idMoneda", "idMoneda", ccsInteger, Empty, Recordset)
        Set activo = CCCreateField("activo", "activo", ccsInteger, Empty, Recordset)
        Set orden = CCCreateField("orden", "orden", ccsInteger, Empty, Recordset)
        Fields.AddFields Array(id,  idZona,  idOperacion,  idTipo,  descripcion,  dormitorios,  valor, _
             valor_num,  idMoneda,  activo,  orden)
        Set InsertOmitIfEmpty = CreateObject("Scripting.Dictionary")
        InsertOmitIfEmpty.Add "id", True
        InsertOmitIfEmpty.Add "idZona", True
        InsertOmitIfEmpty.Add "idOperacion", True
        InsertOmitIfEmpty.Add "idTipo", True
        InsertOmitIfEmpty.Add "descripcion", True
        InsertOmitIfEmpty.Add "dormitorios", True
        InsertOmitIfEmpty.Add "valor", True
        InsertOmitIfEmpty.Add "valor_num", True
        InsertOmitIfEmpty.Add "idMoneda", True
        InsertOmitIfEmpty.Add "activo", False
        InsertOmitIfEmpty.Add "orden", True
        Set UpdateOmitIfEmpty = CreateObject("Scripting.Dictionary")
        UpdateOmitIfEmpty.Add "id", True
        UpdateOmitIfEmpty.Add "idZona", True
        UpdateOmitIfEmpty.Add "idOperacion", True
        UpdateOmitIfEmpty.Add "idTipo", True
        UpdateOmitIfEmpty.Add "descripcion", True
        UpdateOmitIfEmpty.Add "dormitorios", True
        UpdateOmitIfEmpty.Add "valor", True
        UpdateOmitIfEmpty.Add "valor_num", True
        UpdateOmitIfEmpty.Add "idMoneda", True
        UpdateOmitIfEmpty.Add "activo", False
        UpdateOmitIfEmpty.Add "orden", True
        Set Parameters = Server.CreateObject("Scripting.Dictionary")
        Set WhereParameters = Nothing

        SQL = "SELECT *  " & vbLf & _
        "FROM propiedades {SQL_Where} {SQL_OrderBy}"
        Where = ""
        Order = ""
        StaticOrder = ""
    End Sub
'End DataSource Class_Initialize Event

'BuildTableWhere Method @3-5E93F459
    Public Sub BuildTableWhere()
        Dim WhereParams

        If Not WhereParameters Is Nothing Then _
            Exit Sub
        Set WhereParameters = new clsSQLParameters
        With WhereParameters
            Set .Connection = Connection
            Set .ParameterSources = Parameters
            Set .DataSource = Me
            .AddParameter 1, "urlid", ccsInteger, Empty, Empty, Empty, False
            AllParamsSet = .AllParamsSet
            .Criterion(1) = .Operation(opEqual, False, "[idPropiedad]", .getParamByID(1))
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

'Open Method @3-48A2DA7D
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
        BuildTableWhere
        Cmd.Where = Where
        Cmd.OrderBy = Order
        If(Len(StaticOrder)>0) Then
            If Len(Order)>0 Then Cmd.OrderBy = ", "+Cmd.OrderBy
            Cmd.OrderBy = StaticOrder + Cmd.OrderBy
        End If
        Cmd.Options("TOP") = True
        If Not AllParamsSet Then
            Set Open = New clsEmptyDataSource
            Exit Function
        End If
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeExecuteSelect", Me)
        If Errors.Count = 0 And CCSEventResult Then _
            Set Recordset = Cmd.Exec(Errors)
        CCSEventResult = CCRaiseEvent(CCSEvents, "AfterExecuteSelect", Me)
        Set Recordset.FieldsCollection = Fields
        Set Open = Recordset
    End Function
'End Open Method

'DataSource Class_Terminate Event @3-41B4B08D
    Private Sub Class_Terminate()
        If Recordset.State = adStateOpen Then _
            Recordset.Close
        Set Recordset = Nothing
        Set Parameters = Nothing
        Set Errors = Nothing
    End Sub
'End DataSource Class_Terminate Event

'Delete Method @3-D1A3EB6C
    Sub Delete(Cmd)
        CmdExecution = True
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeBuildDelete", Me)
        Set Cmd.Connection = Connection
        Cmd.CommandOperation = cmdExec
        Cmd.CommandType = dsTable
        Cmd.CommandParameters = Empty
        BuildTableWhere
        If NOT AllParamsSet Then
            Errors.AddError(CCSLocales.GetText("CCS_CustomOperationError_MissingParameters", Empty))
        End If
        Cmd.SQL = "DELETE FROM propiedades" & IIf(Len(Where) > 0, " WHERE " & Where, "")
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeExecuteDelete", Me)
        If Errors.Count = 0  And CmdExecution Then
            Cmd.Exec(Errors)
            CCSEventResult = CCRaiseEvent(CCSEvents, "AfterExecuteDelete", Me)
        End If
    End Sub
'End Delete Method

'Update Method @3-0784A528
    Sub Update(Cmd)
        CmdExecution = True
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeBuildUpdate", Me)
        Set Cmd.Connection = Connection
        Cmd.CommandOperation = cmdExec
        Cmd.CommandType = dsTable
        Cmd.CommandParameters = Empty
        BuildTableWhere
        If NOT AllParamsSet Then
            Errors.AddError(CCSLocales.GetText("CCS_CustomOperationError_MissingParameters", Empty))
        End If
        Dim IsDef_id : IsDef_id = CCIsDefined("id", "Form")
        Dim IsDef_idZona : IsDef_idZona = CCIsDefined("idZona", "Form")
        Dim IsDef_idOperacion : IsDef_idOperacion = CCIsDefined("idOperacion", "Form")
        Dim IsDef_idTipo : IsDef_idTipo = CCIsDefined("idTipo", "Form")
        Dim IsDef_descripcion : IsDef_descripcion = CCIsDefined("descripcion", "Form")
        Dim IsDef_dormitorios : IsDef_dormitorios = CCIsDefined("dormitorios", "Form")
        Dim IsDef_valor : IsDef_valor = CCIsDefined("valor", "Form")
        Dim IsDef_valor_num : IsDef_valor_num = CCIsDefined("valor_num", "Form")
        Dim IsDef_idMoneda : IsDef_idMoneda = CCIsDefined("idMoneda", "Form")
        Dim IsDef_activo : IsDef_activo = CCIsDefined("activo", "Form")
        Dim IsDef_orden : IsDef_orden = CCIsDefined("orden", "Form")
        If Not UpdateOmitIfEmpty("id") Or IsDef_id Then Cmd.AddSQLStrings "id=" & Connection.ToSQL(id, id.DataType), Empty
        If Not UpdateOmitIfEmpty("idZona") Or IsDef_idZona Then Cmd.AddSQLStrings "[idZona]=" & Connection.ToSQL(idZona, idZona.DataType), Empty
        If Not UpdateOmitIfEmpty("idOperacion") Or IsDef_idOperacion Then Cmd.AddSQLStrings "[idOperacion]=" & Connection.ToSQL(idOperacion, idOperacion.DataType), Empty
        If Not UpdateOmitIfEmpty("idTipo") Or IsDef_idTipo Then Cmd.AddSQLStrings "[idTipo]=" & Connection.ToSQL(idTipo, idTipo.DataType), Empty
        If Not UpdateOmitIfEmpty("descripcion") Or IsDef_descripcion Then Cmd.AddSQLStrings "descripcion=" & Connection.ToSQL(descripcion, descripcion.DataType), Empty
        If Not UpdateOmitIfEmpty("dormitorios") Or IsDef_dormitorios Then Cmd.AddSQLStrings "dormitorios=" & Connection.ToSQL(dormitorios, dormitorios.DataType), Empty
        If Not UpdateOmitIfEmpty("valor") Or IsDef_valor Then Cmd.AddSQLStrings "valor=" & Connection.ToSQL(valor, valor.DataType), Empty
        If Not UpdateOmitIfEmpty("valor_num") Or IsDef_valor_num Then Cmd.AddSQLStrings "valor_num=" & Connection.ToSQL(valor_num, valor_num.DataType), Empty
        If Not UpdateOmitIfEmpty("idMoneda") Or IsDef_idMoneda Then Cmd.AddSQLStrings "[idMoneda]=" & Connection.ToSQL(idMoneda, idMoneda.DataType), Empty
        If Not UpdateOmitIfEmpty("activo") Or IsDef_activo Then Cmd.AddSQLStrings "activo=" & Connection.ToSQL(activo, activo.DataType), Empty
        If Not UpdateOmitIfEmpty("orden") Or IsDef_orden Then Cmd.AddSQLStrings "orden=" & Connection.ToSQL(orden, orden.DataType), Empty
        CmdExecution = Cmd.PrepareSQL("Update", "propiedades", Where)
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeExecuteUpdate", Me)
        If Errors.Count = 0  And CmdExecution Then
            Cmd.Exec(Errors)
            CCSEventResult = CCRaiseEvent(CCSEvents, "AfterExecuteUpdate", Me)
        End If
    End Sub
'End Update Method

'Insert Method @3-35B59765
    Sub Insert(Cmd)
        CmdExecution = True
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeBuildInsert", Me)
        Set Cmd.Connection = Connection
        Cmd.CommandOperation = cmdExec
        Cmd.CommandType = dsTable
        Cmd.CommandParameters = Empty
        Dim IsDef_id : IsDef_id = CCIsDefined("id", "Form")
        Dim IsDef_idZona : IsDef_idZona = CCIsDefined("idZona", "Form")
        Dim IsDef_idOperacion : IsDef_idOperacion = CCIsDefined("idOperacion", "Form")
        Dim IsDef_idTipo : IsDef_idTipo = CCIsDefined("idTipo", "Form")
        Dim IsDef_descripcion : IsDef_descripcion = CCIsDefined("descripcion", "Form")
        Dim IsDef_dormitorios : IsDef_dormitorios = CCIsDefined("dormitorios", "Form")
        Dim IsDef_valor : IsDef_valor = CCIsDefined("valor", "Form")
        Dim IsDef_valor_num : IsDef_valor_num = CCIsDefined("valor_num", "Form")
        Dim IsDef_idMoneda : IsDef_idMoneda = CCIsDefined("idMoneda", "Form")
        Dim IsDef_activo : IsDef_activo = CCIsDefined("activo", "Form")
        Dim IsDef_orden : IsDef_orden = CCIsDefined("orden", "Form")
        If Not InsertOmitIfEmpty("id") Or IsDef_id Then Cmd.AddSQLStrings "id", Connection.ToSQL(id, id.DataType)
        If Not InsertOmitIfEmpty("idZona") Or IsDef_idZona Then Cmd.AddSQLStrings "[idZona]", Connection.ToSQL(idZona, idZona.DataType)
        If Not InsertOmitIfEmpty("idOperacion") Or IsDef_idOperacion Then Cmd.AddSQLStrings "[idOperacion]", Connection.ToSQL(idOperacion, idOperacion.DataType)
        If Not InsertOmitIfEmpty("idTipo") Or IsDef_idTipo Then Cmd.AddSQLStrings "[idTipo]", Connection.ToSQL(idTipo, idTipo.DataType)
        If Not InsertOmitIfEmpty("descripcion") Or IsDef_descripcion Then Cmd.AddSQLStrings "descripcion", Connection.ToSQL(descripcion, descripcion.DataType)
        If Not InsertOmitIfEmpty("dormitorios") Or IsDef_dormitorios Then Cmd.AddSQLStrings "dormitorios", Connection.ToSQL(dormitorios, dormitorios.DataType)
        If Not InsertOmitIfEmpty("valor") Or IsDef_valor Then Cmd.AddSQLStrings "valor", Connection.ToSQL(valor, valor.DataType)
        If Not InsertOmitIfEmpty("valor_num") Or IsDef_valor_num Then Cmd.AddSQLStrings "valor_num", Connection.ToSQL(valor_num, valor_num.DataType)
        If Not InsertOmitIfEmpty("idMoneda") Or IsDef_idMoneda Then Cmd.AddSQLStrings "[idMoneda]", Connection.ToSQL(idMoneda, idMoneda.DataType)
        If Not InsertOmitIfEmpty("activo") Or IsDef_activo Then Cmd.AddSQLStrings "activo", Connection.ToSQL(activo, activo.DataType)
        If Not InsertOmitIfEmpty("orden") Or IsDef_orden Then Cmd.AddSQLStrings "orden", Connection.ToSQL(orden, orden.DataType)
        CmdExecution = Cmd.PrepareSQL("Insert", "propiedades", Empty)
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeExecuteInsert", Me)
        If Errors.Count = 0  And CmdExecution Then
            Cmd.Exec(Errors)
            CCSEventResult = CCRaiseEvent(CCSEvents, "AfterExecuteInsert", Me)
        End If
    End Sub
'End Insert Method

End Class 'End propiedadesDataSource Class @3-A61BA892

'Include Page Implementation @2-F9BD05CE
%>
<!-- #INCLUDE VIRTUAL="/search/menu1.asp" -->
<%
'End Include Page Implementation


%>
