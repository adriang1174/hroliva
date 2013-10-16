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

'Initialize Page @1-64674E2D
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
Dim usuarios
Dim ChildControls

Response.ContentType = CCSContentType
Redirect = ""
TemplateFileName = "usuarios_maint.html"
Set CCSEvents = CreateObject("Scripting.Dictionary")
PathToCurrentPage = "./"
FileName = "usuarios_maint.asp"
PathToRoot = "./"
ScriptPath = Left(Request.ServerVariables("PATH_TRANSLATED"), Len(Request.ServerVariables("PATH_TRANSLATED")) - Len(FileName))
TemplateFilePath = ScriptPath
'End Initialize Page

'Authenticate User @1-4F82CB21
CCSecurityRedirect "100", Empty
'End Authenticate User

'Initialize Objects @1-063AD7DE
CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInitialize", Nothing)

Set DBConnection1 = New clsDBConnection1
DBConnection1.Open
Set Attributes = New clsAttributes
Attributes("pathToRoot") = PathToRoot

' Controls
Set usuarios = new clsRecordusuarios
usuarios.Initialize DBConnection1

CCSEventResult = CCRaiseEvent(CCSEvents, "AfterInitialize", Nothing)
'End Initialize Objects

'Execute Components @1-B0D13CC7
usuarios.Operation
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

'Show Page @1-B2CEF680
Attributes.Show HTMLTemplate, "page:"
Set ChildControls = CCCreateCollection(Tpl, Null, ccsParseOverwrite, _
    Array(usuarios))
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

'UnloadPage Sub @1-9C749EB4
Sub UnloadPage()
    CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeUnload", Nothing)
    If DBConnection1.State = adStateOpen Then _
        DBConnection1.Close
    Set DBConnection1 = Nothing
    Set CCSEvents = Nothing
    Set Attributes = Nothing
    Set usuarios = Nothing
End Sub
'End UnloadPage Sub

Class clsRecordusuarios 'usuarios Class @2-C5AB7A90

'usuarios Variables @2-D7759378

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
    Dim login
    Dim password
    Dim idPerfil
    Dim idlogin
'End usuarios Variables

'usuarios Class_Initialize Event @2-A80EB951
    Private Sub Class_Initialize()

        Visible = True
        Set Errors = New clsErrors
        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Attributes = New clsAttributes
        Set DataSource = New clsusuariosDataSource
        Set Command = New clsCommand
        InsertAllowed = True
        UpdateAllowed = True
        DeleteAllowed = True
        ReadAllowed = True
        Dim Method
        Dim OperationMode
        OperationMode = Split(CCGetFromGet("ccsForm", Empty), ":")
        If UBound(OperationMode) > -1 Then 
            FormSubmitted = (OperationMode(0) = "usuarios")
        End If
        If UBound(OperationMode) > 0 Then 
            EditMode = (OperationMode(1) = "Edit")
        End If
        ComponentName = "usuarios"
        Method = IIf(FormSubmitted, ccsPost, ccsGet)
        Set Button_Insert = CCCreateButton("Button_Insert", Method)
        Set Button_Update = CCCreateButton("Button_Update", Method)
        Set Button_Delete = CCCreateButton("Button_Delete", Method)
        Set login = CCCreateControl(ccsTextBox, "login", "Login", ccsText, Empty, CCGetRequestParam("login", Method))
        login.Required = True
        Set password = CCCreateControl(ccsTextBox, "password", "Password", ccsText, Empty, CCGetRequestParam("password", Method))
        password.Required = True
        Set idPerfil = CCCreateList(ccsListBox, "idPerfil", "Id Perfil", ccsInteger, CCGetRequestParam("idPerfil", Method), Empty)
        idPerfil.BoundColumn = "idPerfil"
        idPerfil.TextColumn = "descripcion"
        Set idPerfil.DataSource = CCCreateDataSource(dsTable,DBConnection1, Array("SELECT *  " & _
"FROM perfil {SQL_Where} {SQL_OrderBy}", "", ""))
        idPerfil.Required = True
        Set idlogin = CCCreateControl(ccsTextBox, "idlogin", "Idlogin", ccsInteger, Empty, CCGetRequestParam("idlogin", Method))
        Set ValidatingControls = new clsControls
        ValidatingControls.addControls Array(login, password, idPerfil, idlogin)
    End Sub
'End usuarios Class_Initialize Event

'usuarios Initialize Method @2-24CFCC9C
    Sub Initialize(objConnection)

        If NOT Visible Then Exit Sub


        Set DataSource.Connection = objConnection
        With DataSource
            .Parameters("urlidlogin") = CCGetRequestParam("idlogin", ccsGET)
        End With
    End Sub
'End usuarios Initialize Method

'usuarios Class_Terminate Event @2-0C5D276C
    Private Sub Class_Terminate()
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End usuarios Class_Terminate Event

'usuarios Validate Method @2-B9D513CF
    Function Validate()
        Dim Validation
        ValidatingControls.Validate
        CCSEventResult = CCRaiseEvent(CCSEvents, "OnValidate", Me)
        Validate = ValidatingControls.isValid() And (Errors.Count = 0)
    End Function
'End usuarios Validate Method

'usuarios Operation Method @2-BA6A150A
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
        Redirect = "usuarios_list.asp?" & CCGetQueryString("QueryString", Array("ccsForm", "Button_Insert.x", "Button_Insert.y", "Button_Insert", "Button_Update.x", "Button_Update.y", "Button_Update", "Button_Delete.x", "Button_Delete.y", "Button_Delete"))
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
'End usuarios Operation Method

'usuarios InsertRow Method @2-D76E8C66
    Function InsertRow()
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInsert", Me)
        If NOT InsertAllowed Then InsertRow = False : Exit Function
        DataSource.login.Value = login.Value
        DataSource.password.Value = password.Value
        DataSource.idPerfil.Value = idPerfil.Value
        DataSource.idlogin.Value = idlogin.Value
        DataSource.Insert(Command)


        CCSEventResult = CCRaiseEvent(CCSEvents, "AfterInsert", Me)
        If DataSource.Errors.Count > 0 Then
            Errors.AddErrors(DataSource.Errors)
            DataSource.Errors.Clear
        End If
        InsertRow = (Errors.Count = 0)
    End Function
'End usuarios InsertRow Method

'usuarios UpdateRow Method @2-A5606E56
    Function UpdateRow()
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeUpdate", Me)
        If NOT UpdateAllowed Then UpdateRow = False : Exit Function
        DataSource.login.Value = login.Value
        DataSource.password.Value = password.Value
        DataSource.idPerfil.Value = idPerfil.Value
        DataSource.idlogin.Value = idlogin.Value
        DataSource.Update(Command)


        CCSEventResult = CCRaiseEvent(CCSEvents, "AfterUpdate", Me)
        If DataSource.Errors.Count > 0 Then
            Errors.AddErrors(DataSource.Errors)
            DataSource.Errors.Clear
        End If
        UpdateRow = (Errors.Count = 0)
    End Function
'End usuarios UpdateRow Method

'usuarios DeleteRow Method @2-D5C1DF24
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
'End usuarios DeleteRow Method

'usuarios Show Method @2-9D867D44
    Sub Show(Tpl)

        If NOT Visible Then Exit Sub

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeSelect", Me)
        Set Recordset = DataSource.Open(Command)
        EditMode = Recordset.EditMode(ReadAllowed)
        HTMLFormAction = FileName & "?" & CCAddParam(Request.ServerVariables("QUERY_STRING"), "ccsForm", "usuarios" & IIf(EditMode, ":Edit", ""))
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
            Array(login, password, idPerfil, idlogin, Button_Insert, Button_Update, Button_Delete))
        If EditMode AND ReadAllowed Then
            If Errors.Count = 0 Then
                If Recordset.Errors.Count > 0 Then
                    With TemplateBlock.Block("Error")
                        .Variable("Error") = Recordset.Errors.ToString
                        .Parse False
                    End With
                ElseIf Recordset.CanPopulate() Then
                    If Not FormSubmitted Then
                        login.Value = Recordset.Fields("login")
                        password.Value = Recordset.Fields("password")
                        idPerfil.Value = Recordset.Fields("idPerfil")
                        idlogin.Value = Recordset.Fields("idlogin")
                    End If
                Else
                    EditMode = False
                End If
            End If
        End If
        If Not FormSubmitted Then
        End If
        If FormSubmitted Then
            Errors.AddErrors login.Errors
            Errors.AddErrors password.Errors
            Errors.AddErrors idPerfil.Errors
            Errors.AddErrors idlogin.Errors
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
            Attributes.Show TemplateBlock, "usuarios" & ":"
            Controls.Show
        End If
    End Sub
'End usuarios Show Method

End Class 'End usuarios Class @2-A61BA892

Class clsusuariosDataSource 'usuariosDataSource Class @2-4AD1647E

'DataSource Variables @2-6857018F
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
    Public login
    Public password
    Public idPerfil
    Public idlogin
'End DataSource Variables

'DataSource Class_Initialize Event @2-1EC0B48A
    Private Sub Class_Initialize()

        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Fields = New clsFields
        Set Recordset = New clsDataSource
        Set Recordset.DataSource = Me
        Set Errors = New clsErrors
        Set Connection = Nothing
        AllParamsSet = True
        Set login = CCCreateField("login", "login", ccsText, Empty, Recordset)
        Set password = CCCreateField("password", "password", ccsText, Empty, Recordset)
        Set idPerfil = CCCreateField("idPerfil", "idPerfil", ccsInteger, Empty, Recordset)
        Set idlogin = CCCreateField("idlogin", "idlogin", ccsInteger, Empty, Recordset)
        Fields.AddFields Array(login, password, idPerfil, idlogin)
        Set InsertOmitIfEmpty = CreateObject("Scripting.Dictionary")
        InsertOmitIfEmpty.Add "login", True
        InsertOmitIfEmpty.Add "password", True
        InsertOmitIfEmpty.Add "idPerfil", True
        InsertOmitIfEmpty.Add "idlogin", True
        Set UpdateOmitIfEmpty = CreateObject("Scripting.Dictionary")
        UpdateOmitIfEmpty.Add "login", True
        UpdateOmitIfEmpty.Add "password", True
        UpdateOmitIfEmpty.Add "idPerfil", True
        UpdateOmitIfEmpty.Add "idlogin", True
        Set Parameters = Server.CreateObject("Scripting.Dictionary")
        Set WhereParameters = Nothing

        SQL = "SELECT *  " & vbLf & _
        "FROM usuarios {SQL_Where} {SQL_OrderBy}"
        Where = ""
        Order = ""
        StaticOrder = ""
    End Sub
'End DataSource Class_Initialize Event

'BuildTableWhere Method @2-4CEBA10A
    Public Sub BuildTableWhere()
        Dim WhereParams

        If Not WhereParameters Is Nothing Then _
            Exit Sub
        Set WhereParameters = new clsSQLParameters
        With WhereParameters
            Set .Connection = Connection
            Set .ParameterSources = Parameters
            Set .DataSource = Me
            .AddParameter 1, "urlidlogin", ccsInteger, Empty, Empty, Empty, False
            AllParamsSet = .AllParamsSet
            .Criterion(1) = .Operation(opEqual, False, "idlogin", .getParamByID(1))
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

'Open Method @2-48A2DA7D
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

'DataSource Class_Terminate Event @2-41B4B08D
    Private Sub Class_Terminate()
        If Recordset.State = adStateOpen Then _
            Recordset.Close
        Set Recordset = Nothing
        Set Parameters = Nothing
        Set Errors = Nothing
    End Sub
'End DataSource Class_Terminate Event

'Delete Method @2-C0AE3A77
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
        Cmd.SQL = "DELETE FROM usuarios" & IIf(Len(Where) > 0, " WHERE " & Where, "")
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeExecuteDelete", Me)
        If Errors.Count = 0  And CmdExecution Then
            Cmd.Exec(Errors)
            CCSEventResult = CCRaiseEvent(CCSEvents, "AfterExecuteDelete", Me)
        End If
    End Sub
'End Delete Method

'Update Method @2-1FF15658
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
        Dim IsDef_login : IsDef_login = CCIsDefined("login", "Form")
        Dim IsDef_password : IsDef_password = CCIsDefined("password", "Form")
        Dim IsDef_idPerfil : IsDef_idPerfil = CCIsDefined("idPerfil", "Form")
        Dim IsDef_idlogin : IsDef_idlogin = CCIsDefined("idlogin", "Form")
        If Not UpdateOmitIfEmpty("login") Or IsDef_login Then Cmd.AddSQLStrings "login=" & Connection.ToSQL(login, login.DataType), Empty
        If Not UpdateOmitIfEmpty("password") Or IsDef_password Then Cmd.AddSQLStrings "password=" & Connection.ToSQL(password, password.DataType), Empty
        If Not UpdateOmitIfEmpty("idPerfil") Or IsDef_idPerfil Then Cmd.AddSQLStrings "[idPerfil]=" & Connection.ToSQL(idPerfil, idPerfil.DataType), Empty
        If Not UpdateOmitIfEmpty("idlogin") Or IsDef_idlogin Then Cmd.AddSQLStrings "idlogin=" & Connection.ToSQL(idlogin, idlogin.DataType), Empty
        CmdExecution = Cmd.PrepareSQL("Update", "usuarios", Where)
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeExecuteUpdate", Me)
        If Errors.Count = 0  And CmdExecution Then
            Cmd.Exec(Errors)
            CCSEventResult = CCRaiseEvent(CCSEvents, "AfterExecuteUpdate", Me)
        End If
    End Sub
'End Update Method

'Insert Method @2-6C4DF25B
    Sub Insert(Cmd)
        CmdExecution = True
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeBuildInsert", Me)
        Set Cmd.Connection = Connection
        Cmd.CommandOperation = cmdExec
        Cmd.CommandType = dsTable
        Cmd.CommandParameters = Empty
        Dim IsDef_login : IsDef_login = CCIsDefined("login", "Form")
        Dim IsDef_password : IsDef_password = CCIsDefined("password", "Form")
        Dim IsDef_idPerfil : IsDef_idPerfil = CCIsDefined("idPerfil", "Form")
        Dim IsDef_idlogin : IsDef_idlogin = CCIsDefined("idlogin", "Form")
        If Not InsertOmitIfEmpty("login") Or IsDef_login Then Cmd.AddSQLStrings "login", Connection.ToSQL(login, login.DataType)
        If Not InsertOmitIfEmpty("password") Or IsDef_password Then Cmd.AddSQLStrings "password", Connection.ToSQL(password, password.DataType)
        If Not InsertOmitIfEmpty("idPerfil") Or IsDef_idPerfil Then Cmd.AddSQLStrings "[idPerfil]", Connection.ToSQL(idPerfil, idPerfil.DataType)
        If Not InsertOmitIfEmpty("idlogin") Or IsDef_idlogin Then Cmd.AddSQLStrings "idlogin", Connection.ToSQL(idlogin, idlogin.DataType)
        CmdExecution = Cmd.PrepareSQL("Insert", "usuarios", Empty)
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeExecuteInsert", Me)
        If Errors.Count = 0  And CmdExecution Then
            Cmd.Exec(Errors)
            CCSEventResult = CCRaiseEvent(CCSEvents, "AfterExecuteInsert", Me)
        End If
    End Sub
'End Insert Method

End Class 'End usuariosDataSource Class @2-A61BA892


%>
