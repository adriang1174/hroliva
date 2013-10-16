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

'Initialize Page @1-3265EB6B
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
Dim Login
Dim ChildControls

Response.ContentType = CCSContentType
Redirect = ""
TemplateFileName = "login.html"
Set CCSEvents = CreateObject("Scripting.Dictionary")
PathToCurrentPage = "./"
FileName = "login.asp"
PathToRoot = "./"
ScriptPath = Left(Request.ServerVariables("PATH_TRANSLATED"), Len(Request.ServerVariables("PATH_TRANSLATED")) - Len(FileName))
TemplateFilePath = ScriptPath
'End Initialize Page

'Initialize Objects @1-E3ECDC96
BindEvents "Page"
CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInitialize", Nothing)

Set DBConnection1 = New clsDBConnection1
DBConnection1.Open
Set Attributes = New clsAttributes
Attributes("pathToRoot") = PathToRoot

' Controls
Set Login = new clsRecordLogin
Login.Initialize DBConnection1

' Events
%>
<!-- #INCLUDE VIRTUAL="/search/login_events.asp" -->
<%
BindEvents Empty

CCSEventResult = CCRaiseEvent(CCSEvents, "AfterInitialize", Nothing)
'End Initialize Objects

'Execute Components @1-6AA0DE03
Login.Operation
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

'Show Page @1-65A9CCBF
Attributes.Show HTMLTemplate, "page:"
Set ChildControls = CCCreateCollection(Tpl, Null, ccsParseOverwrite, _
    Array(Login))
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

'UnloadPage Sub @1-EC030EDC
Sub UnloadPage()
    CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeUnload", Nothing)
    If DBConnection1.State = adStateOpen Then _
        DBConnection1.Close
    Set DBConnection1 = Nothing
    Set CCSEvents = Nothing
    Set Attributes = Nothing
    Set Login = Nothing
End Sub
'End UnloadPage Sub

Class clsRecordLogin 'Login Class @2-D3C99874

'Login Variables @2-FE415474

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
    Dim Button_DoLogin
    Dim login
    Dim password
'End Login Variables

'Login Class_Initialize Event @2-1E044FCE
    Private Sub Class_Initialize()

        Visible = True
        Set Errors = New clsErrors
        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Attributes = New clsAttributes
        Set DataSource = New clsLoginDataSource
        Set Command = New clsCommand
        InsertAllowed = False
        UpdateAllowed = False
        DeleteAllowed = False
        ReadAllowed = True
        Dim Method
        Dim OperationMode
        OperationMode = Split(CCGetFromGet("ccsForm", Empty), ":")
        If UBound(OperationMode) > -1 Then 
            FormSubmitted = (OperationMode(0) = "Login")
        End If
        If UBound(OperationMode) > 0 Then 
            EditMode = (OperationMode(1) = "Edit")
        End If
        ComponentName = "Login"
        Method = IIf(FormSubmitted, ccsPost, ccsGet)
        Set Button_DoLogin = CCCreateButton("Button_DoLogin", Method)
        Set login = CCCreateControl(ccsTextBox, "login", Empty, ccsText, Empty, CCGetRequestParam("login", Method))
        login.Required = True
        Set password = CCCreateControl(ccsTextBox, "password", Empty, ccsText, Empty, CCGetRequestParam("password", Method))
        password.Required = True
        Set ValidatingControls = new clsControls
        ValidatingControls.addControls Array(login, password)
    End Sub
'End Login Class_Initialize Event

'Login Initialize Method @2-36D27969
    Sub Initialize(objConnection)

        If NOT Visible Then Exit Sub


        Set DataSource.Connection = objConnection
        With DataSource
        End With
    End Sub
'End Login Initialize Method

'Login Class_Terminate Event @2-0C5D276C
    Private Sub Class_Terminate()
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End Login Class_Terminate Event

'Login Validate Method @2-B9D513CF
    Function Validate()
        Dim Validation
        ValidatingControls.Validate
        CCSEventResult = CCRaiseEvent(CCSEvents, "OnValidate", Me)
        Validate = ValidatingControls.isValid() And (Errors.Count = 0)
    End Function
'End Login Validate Method

'Login Operation Method @2-7E4BE8CA
    Sub Operation()
        If NOT ( Visible AND FormSubmitted ) Then Exit Sub

        If FormSubmitted Then
            PressedButton = "Button_DoLogin"
            If Button_DoLogin.Pressed Then
                PressedButton = "Button_DoLogin"
            End If
        End If
        Redirect = "propiedades_list.asp"
        If Validate() Then
            If PressedButton = "Button_DoLogin" Then
                If NOT Button_DoLogin.OnClick() Then
                    Redirect = ""
                End If
            End If
        Else
            Redirect = ""
        End If
    End Sub
'End Login Operation Method

'Login Show Method @2-0F6CB6ED
    Sub Show(Tpl)

        If NOT Visible Then Exit Sub

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeSelect", Me)
        Set Recordset = DataSource.Open(Command)
        EditMode = Recordset.EditMode(ReadAllowed)
        HTMLFormAction = FileName & "?" & CCAddParam(Request.ServerVariables("QUERY_STRING"), "ccsForm", "Login" & IIf(EditMode, ":Edit", ""))
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
            Array(login, password, Button_DoLogin))
        If EditMode AND ReadAllowed Then
            If Errors.Count = 0 Then
                If Recordset.Errors.Count > 0 Then
                    With TemplateBlock.Block("Error")
                        .Variable("Error") = Recordset.Errors.ToString
                        .Parse False
                    End With
                ElseIf Recordset.CanPopulate() Then
                    If Not FormSubmitted Then
                        
                        
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
            Errors.AddErrors DataSource.Errors
            With TemplateBlock.Block("Error")
                .Variable("Error") = Errors.ToString()
                .Parse False
            End With
        End If
        TemplateBlock.Variable("Action") = IIF(CCSUseAmps, Replace(HTMLFormAction, "&", CCSAmps), HTMLFormAction)

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Me)
        If Visible Then 
            Attributes.Show TemplateBlock, "Login" & ":"
            Controls.Show
        End If
    End Sub
'End Login Show Method

End Class 'End Login Class @2-A61BA892

Class clsLoginDataSource 'LoginDataSource Class @2-5D4A1816

'DataSource Variables @2-51A7ED8F
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
'End DataSource Variables

'DataSource Class_Initialize Event @2-42495AE3
    Private Sub Class_Initialize()

        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Fields = New clsFields
        Set Recordset = New clsDataSource
        Set Recordset.DataSource = Me
        Set Errors = New clsErrors
        Set Connection = Nothing
        AllParamsSet = True
        Fields.AddFields Array()

        SQL = "SELECT *  " & vbLf & _
        "FROM usuarios {SQL_Where} {SQL_OrderBy}"
        Where = ""
        Order = ""
        StaticOrder = ""
    End Sub
'End DataSource Class_Initialize Event

'BuildTableWhere Method @2-98E5A92F
    Public Sub BuildTableWhere()
    End Sub
'End BuildTableWhere Method

'Open Method @2-5DD0F01A
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

End Class 'End LoginDataSource Class @2-A61BA892


%>
