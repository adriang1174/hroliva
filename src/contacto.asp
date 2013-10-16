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

'Initialize Page @1-34ACE3CF
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
Dim contacto
Dim menu1
Dim ChildControls

Response.ContentType = CCSContentType
Redirect = ""
TemplateFileName = "contacto.html"
Set CCSEvents = CreateObject("Scripting.Dictionary")
PathToCurrentPage = "./"
FileName = "contacto.asp"
PathToRoot = "./"
ScriptPath = Left(Request.ServerVariables("PATH_TRANSLATED"), Len(Request.ServerVariables("PATH_TRANSLATED")) - Len(FileName))
TemplateFilePath = ScriptPath
'End Initialize Page

'Initialize Objects @1-2857E0D6
BindEvents "Page"
CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInitialize", Nothing)

Set DBConnection1 = New clsDBConnection1
DBConnection1.Open
Set Attributes = New clsAttributes
Attributes("pathToRoot") = PathToRoot

' Controls
Set contacto = new clsRecordcontacto
Set menu1 = New clsmenu1
Set menu1.Attributes = Attributes
menu1.Initialize "menu1", ""
contacto.Initialize DBConnection1

' Events
%>
<!-- #INCLUDE VIRTUAL="/search/contacto_events.asp" -->
<%
BindEvents Empty

CCSEventResult = CCRaiseEvent(CCSEvents, "AfterInitialize", Nothing)
'End Initialize Objects

'Execute Components @1-C37186B4
contacto.Operation
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

'Show Page @1-44D4F5E8
Attributes.Show HTMLTemplate, "page:"
Set ChildControls = CCCreateCollection(Tpl, Null, ccsParseOverwrite, _
    Array(contacto, menu1))
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

'UnloadPage Sub @1-DB6DFE2C
Sub UnloadPage()
    CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeUnload", Nothing)
    If DBConnection1.State = adStateOpen Then _
        DBConnection1.Close
    Set DBConnection1 = Nothing
    Set CCSEvents = Nothing
    Set Attributes = Nothing
    Set contacto = Nothing
    Set menu1 = Nothing
End Sub
'End UnloadPage Sub

Class clsRecordcontacto 'contacto Class @2-EC1CB45E

'contacto Variables @2-22D51DF3

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
    Dim nombre
    Dim email
    Dim telefono
    Dim consulta
'End contacto Variables

'contacto Class_Initialize Event @2-5039F477
    Private Sub Class_Initialize()

        Visible = True
        Set Errors = New clsErrors
        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Attributes = New clsAttributes
        Set DataSource = New clscontactoDataSource
        Set Command = New clsCommand
        InsertAllowed = True
        UpdateAllowed = False
        DeleteAllowed = False
        ReadAllowed = False
        Dim Method
        Dim OperationMode
        OperationMode = Split(CCGetFromGet("ccsForm", Empty), ":")
        If UBound(OperationMode) > -1 Then 
            FormSubmitted = (OperationMode(0) = "contacto")
        End If
        If UBound(OperationMode) > 0 Then 
            EditMode = (OperationMode(1) = "Edit")
        End If
        ComponentName = "contacto"
        Method = IIf(FormSubmitted, ccsPost, ccsGet)
        Set Button_Insert = CCCreateButton("Button_Insert", Method)
        Set nombre = CCCreateControl(ccsTextBox, "nombre", "Nombre", ccsText, Empty, CCGetRequestParam("nombre", Method))
        Set email = CCCreateControl(ccsTextBox, "email", "Email", ccsText, Empty, CCGetRequestParam("email", Method))
        Set telefono = CCCreateControl(ccsTextBox, "telefono", "Telefono", ccsText, Empty, CCGetRequestParam("telefono", Method))
        Set consulta = CCCreateControl(ccsTextArea, "consulta", "Consulta", ccsMemo, Empty, CCGetRequestParam("consulta", Method))
        Set ValidatingControls = new clsControls
        ValidatingControls.addControls Array(nombre, email, telefono, consulta)
    End Sub
'End contacto Class_Initialize Event

'contacto Initialize Method @2-94A365A6
    Sub Initialize(objConnection)

        If NOT Visible Then Exit Sub


        Set DataSource.Connection = objConnection
        With DataSource
            .Parameters("urlid") = CCGetRequestParam("id", ccsGET)
        End With
    End Sub
'End contacto Initialize Method

'contacto Class_Terminate Event @2-0C5D276C
    Private Sub Class_Terminate()
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End contacto Class_Terminate Event

'contacto Validate Method @2-B9D513CF
    Function Validate()
        Dim Validation
        ValidatingControls.Validate
        CCSEventResult = CCRaiseEvent(CCSEvents, "OnValidate", Me)
        Validate = ValidatingControls.isValid() And (Errors.Count = 0)
    End Function
'End contacto Validate Method

'contacto Operation Method @2-ECCB0A70
    Sub Operation()
        If NOT ( Visible AND FormSubmitted ) Then Exit Sub

        If FormSubmitted Then
            PressedButton = "Button_Insert"
            If Button_Insert.Pressed Then
                PressedButton = "Button_Insert"
            End If
        End If
        Redirect = "gracias.asp?" & CCGetQueryString("QueryString", Array("ccsForm", "Button_Insert.x", "Button_Insert.y", "Button_Insert"))
        If Validate() Then
            If PressedButton = "Button_Insert" Then
                If NOT Button_Insert.OnClick() OR NOT InsertRow() Then
                    Redirect = ""
                End If
            End If
        Else
            Redirect = ""
        End If
    End Sub
'End contacto Operation Method

'contacto InsertRow Method @2-B96349AB
    Function InsertRow()
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInsert", Me)
        If NOT InsertAllowed Then InsertRow = False : Exit Function
        DataSource.nombre.Value = nombre.Value
        DataSource.email.Value = email.Value
        DataSource.telefono.Value = telefono.Value
        DataSource.consulta.Value = consulta.Value
        DataSource.Insert(Command)


        CCSEventResult = CCRaiseEvent(CCSEvents, "AfterInsert", Me)
        If DataSource.Errors.Count > 0 Then
            Errors.AddErrors(DataSource.Errors)
            DataSource.Errors.Clear
        End If
        InsertRow = (Errors.Count = 0)
    End Function
'End contacto InsertRow Method

'contacto Show Method @2-69AF6CA2
    Sub Show(Tpl)

        If NOT Visible Then Exit Sub

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeSelect", Me)
        Set Recordset = DataSource.Open(Command)
        EditMode = Recordset.EditMode(ReadAllowed)
        HTMLFormAction = FileName & "?" & CCAddParam(Request.ServerVariables("QUERY_STRING"), "ccsForm", "contacto" & IIf(EditMode, ":Edit", ""))
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
            Array(nombre, email, telefono, consulta, Button_Insert))
        If EditMode AND ReadAllowed Then
            If Errors.Count = 0 Then
                If Recordset.Errors.Count > 0 Then
                    With TemplateBlock.Block("Error")
                        .Variable("Error") = Recordset.Errors.ToString
                        .Parse False
                    End With
                ElseIf Recordset.CanPopulate() Then
                    If Not FormSubmitted Then
                        nombre.Value = Recordset.Fields("nombre")
                        email.Value = Recordset.Fields("email")
                        telefono.Value = Recordset.Fields("telefono")
                        consulta.Value = Recordset.Fields("consulta")
                    End If
                Else
                    EditMode = False
                End If
            End If
        End If
        If Not FormSubmitted Then
        End If
        If FormSubmitted Then
            Errors.AddErrors nombre.Errors
            Errors.AddErrors email.Errors
            Errors.AddErrors telefono.Errors
            Errors.AddErrors consulta.Errors
            Errors.AddErrors DataSource.Errors
            With TemplateBlock.Block("Error")
                .Variable("Error") = Errors.ToString()
                .Parse False
            End With
        End If
        TemplateBlock.Variable("Action") = IIF(CCSUseAmps, Replace(HTMLFormAction, "&", CCSAmps), HTMLFormAction)
        Button_Insert.Visible = NOT EditMode AND InsertAllowed

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Me)
        If Visible Then 
            Attributes.Show TemplateBlock, "contacto" & ":"
            Controls.Show
        End If
    End Sub
'End contacto Show Method

End Class 'End contacto Class @2-A61BA892

Class clscontactoDataSource 'contactoDataSource Class @2-DAB42147

'DataSource Variables @2-6CC31BD3
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
    Public nombre
    Public email
    Public telefono
    Public consulta
'End DataSource Variables

'DataSource Class_Initialize Event @2-F8DD05BD
    Private Sub Class_Initialize()

        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Fields = New clsFields
        Set Recordset = New clsDataSource
        Set Recordset.DataSource = Me
        Set Errors = New clsErrors
        Set Connection = Nothing
        AllParamsSet = True
        Set nombre = CCCreateField("nombre", "nombre", ccsText, Empty, Recordset)
        Set email = CCCreateField("email", "email", ccsText, Empty, Recordset)
        Set telefono = CCCreateField("telefono", "telefono", ccsText, Empty, Recordset)
        Set consulta = CCCreateField("consulta", "consulta", ccsMemo, Empty, Recordset)
        Fields.AddFields Array(nombre, email, telefono, consulta)
        Set InsertOmitIfEmpty = CreateObject("Scripting.Dictionary")
        InsertOmitIfEmpty.Add "nombre", True
        InsertOmitIfEmpty.Add "email", True
        InsertOmitIfEmpty.Add "telefono", True
        InsertOmitIfEmpty.Add "consulta", True
        Set Parameters = Server.CreateObject("Scripting.Dictionary")
        Set WhereParameters = Nothing

        SQL = "SELECT *  " & vbLf & _
        "FROM contacto {SQL_Where} {SQL_OrderBy}"
        Where = ""
        Order = ""
        StaticOrder = ""
    End Sub
'End DataSource Class_Initialize Event

'BuildTableWhere Method @2-337E81CA
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

'Insert Method @2-9DF8E0F5
    Sub Insert(Cmd)
        CmdExecution = True
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeBuildInsert", Me)
        Set Cmd.Connection = Connection
        Cmd.CommandOperation = cmdExec
        Cmd.CommandType = dsTable
        Cmd.CommandParameters = Empty
        Cmd.Prepared = True
        Dim IsDef_nombre : IsDef_nombre = CCIsDefined("nombre", "Form")
        Dim IsDef_email : IsDef_email = CCIsDefined("email", "Form")
        Dim IsDef_telefono : IsDef_telefono = CCIsDefined("telefono", "Form")
        Dim IsDef_consulta : IsDef_consulta = CCIsDefined("consulta", "Form")
        If Not InsertOmitIfEmpty("nombre") Or IsDef_nombre Then Cmd.AddSQLStrings "nombre", Connection.ToSQL(nombre, nombre.DataType)
        If Not InsertOmitIfEmpty("email") Or IsDef_email Then Cmd.AddSQLStrings "email", Connection.ToSQL(email, email.DataType)
        If Not InsertOmitIfEmpty("telefono") Or IsDef_telefono Then Cmd.AddSQLStrings "telefono", Connection.ToSQL(telefono, telefono.DataType)
        If Not InsertOmitIfEmpty("consulta") Or IsDef_consulta Then Cmd.AddSQLStrings "consulta", "?"
        CmdExecution = Cmd.PrepareSQL("Insert", "contacto", Empty)
        Cmd.CommandParameters = Array( _
            IIF(IsDef_consulta,Array("consulta", adLongVarChar, adParamInput,2147483647, consulta.Value), Empty) _
        )
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeExecuteInsert", Me)
        If Errors.Count = 0  And CmdExecution Then
            Cmd.Exec(Errors)
            CCSEventResult = CCRaiseEvent(CCSEvents, "AfterExecuteInsert", Me)
        End If
    End Sub
'End Insert Method

End Class 'End contactoDataSource Class @2-A61BA892

'Include Page Implementation @10-F9BD05CE
%>
<!-- #INCLUDE VIRTUAL="/search/menu1.asp" -->
<%
'End Include Page Implementation


%>
