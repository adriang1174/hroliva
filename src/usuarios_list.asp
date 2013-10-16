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

'Initialize Page @1-649500C8
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
TemplateFileName = "usuarios_list.html"
Set CCSEvents = CreateObject("Scripting.Dictionary")
PathToCurrentPage = "./"
FileName = "usuarios_list.asp"
PathToRoot = "./"
ScriptPath = Left(Request.ServerVariables("PATH_TRANSLATED"), Len(Request.ServerVariables("PATH_TRANSLATED")) - Len(FileName))
TemplateFilePath = ScriptPath
'End Initialize Page

'Authenticate User @1-4F82CB21
CCSecurityRedirect "100", Empty
'End Authenticate User

'Initialize Objects @1-F96385A9
BindEvents "Page"
CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInitialize", Nothing)

Set DBConnection1 = New clsDBConnection1
DBConnection1.Open
Set Attributes = New clsAttributes
Attributes("pathToRoot") = PathToRoot

' Controls
Set usuarios = New clsGridusuarios
usuarios.Initialize DBConnection1

' Events
%>
<!-- #INCLUDE VIRTUAL="/search/usuarios_list_events.asp" -->
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

Class clsGridusuarios 'usuarios Class @2-809123B7

'usuarios Variables @2-40DECA3D

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
    Dim usuarios_Insert
    Dim Sorter_idlogin
    Dim Sorter_password
    Dim Sorter_idPerfil
    Dim Sorter_login
    Dim idlogin
    Dim password
    Dim idPerfil
    Dim login
    Dim Navigator
'End usuarios Variables

'usuarios Class_Initialize Event @2-5996367E
    Private Sub Class_Initialize()
        ComponentName = "usuarios"
        Visible = True
        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Attributes = New clsAttributes
        Set Errors = New clsErrors
        Set DataSource = New clsusuariosDataSource
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
        ActiveSorter = CCGetParam("usuariosOrder", Empty)
        SortingDirection = CCGetParam("usuariosDir", Empty)
        If NOT(SortingDirection = "ASC" OR SortingDirection = "DESC") Then _
            SortingDirection = Empty

        Set usuarios_Insert = CCCreateControl(ccsLink, "usuarios_Insert", Empty, ccsText, Empty, CCGetRequestParam("usuarios_Insert", ccsGet))
        Set Sorter_idlogin = CCCreateSorter("Sorter_idlogin", Me, FileName)
        Set Sorter_password = CCCreateSorter("Sorter_password", Me, FileName)
        Set Sorter_idPerfil = CCCreateSorter("Sorter_idPerfil", Me, FileName)
        Set Sorter_login = CCCreateSorter("Sorter_login", Me, FileName)
        Set idlogin = CCCreateControl(ccsLink, "idlogin", Empty, ccsInteger, Empty, CCGetRequestParam("idlogin", ccsGet))
        Set password = CCCreateControl(ccsLabel, "password", Empty, ccsText, Empty, CCGetRequestParam("password", ccsGet))
        Set idPerfil = CCCreateControl(ccsLabel, "idPerfil", Empty, ccsInteger, Empty, CCGetRequestParam("idPerfil", ccsGet))
        Set login = CCCreateControl(ccsLabel, "login", Empty, ccsText, Empty, CCGetRequestParam("login", ccsGet))
        Set Navigator = CCCreateNavigator(ComponentName, "Navigator", FileName, 10, tpSimple)
        Navigator.PageSizes = Array("1", "5", "10", "25", "50")
    IsDSEmpty = True
    End Sub
'End usuarios Class_Initialize Event

'usuarios Initialize Method @2-2AEA3975
    Sub Initialize(objConnection)
        If NOT Visible Then Exit Sub

        Set DataSource.Connection = objConnection
        DataSource.PageSize = PageSize
        DataSource.SetOrder ActiveSorter, SortingDirection
        DataSource.AbsolutePage = PageNumber
    End Sub
'End usuarios Initialize Method

'usuarios Class_Terminate Event @2-B97CC660
    Private Sub Class_Terminate()
        Set CCSEvents = Nothing
        Set DataSource = Nothing
        Set Command = Nothing
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End usuarios Class_Terminate Event

'usuarios Show Method @2-1B66222D
    Sub Show(Tpl)
        Dim HasNext
        If NOT Visible Then Exit Sub

        Dim RowBlock


        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeSelect", Me)
        Set Recordset = DataSource.Open(Command)
        If DataSource.Errors.Count = 0 Then IsDSEmpty = Recordset.EOF

        Set TemplateBlock = Tpl.Block("Grid " & ComponentName)
        If TemplateBlock is Nothing Then Exit Sub
        Set RowBlock = TemplateBlock.Block("Row")
        Set StaticControls = CCCreateCollection(TemplateBlock, Null, ccsParseOverwrite, _
            Array(usuarios_Insert, Sorter_idlogin, Sorter_password, Sorter_idPerfil, Sorter_login, Navigator))
            
            usuarios_Insert.Parameters = CCGetQueryString("QueryString", Array("idlogin", "ccsForm"))
            usuarios_Insert.Page = "usuarios_maint.asp"
            Navigator.PageSize = PageSize
            Navigator.SetDataSource Recordset
        Set RowControls = CCCreateCollection(RowBlock, Null, ccsParseAccumulate, _
            Array(idlogin, password, idPerfil, login))

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Me)
        If NOT Visible Then Exit Sub

        RowControls.PreserveControlsVisible
        Errors.AddErrors DataSource.Errors
        If Errors.Count > 0 Then
            TemplateBlock.HTML = CCFormatError("Grid " & ComponentName, Errors)
        Else

            ' Show NoRecords block if no records are found
            If Recordset.EOF Then
                Attributes.Show TemplateBlock, "usuarios:"
                TemplateBlock.Block("NoRecords").Parse ccsParseOverwrite
            End If
            HasNext = HasNextRow()
            ForceIteration = False
            Do While ForceIteration Or HasNext
                Attributes("rowNumber") = ShownRecords + 1
                If HasNext Then
                    idlogin.Value = Recordset.Fields("idlogin")
                    idlogin.Parameters = CCGetQueryString("QueryString", Array("ccsForm"))
                    idlogin.Parameters = CCAddParam(idlogin.Parameters, "idlogin", Recordset.Fields("idlogin_param1"))
                    idlogin.Page = "usuarios_maint.asp"
                    password.Value = Recordset.Fields("password")
                    idPerfil.Value = Recordset.Fields("idPerfil")
                    login.Value = Recordset.Fields("login")
                End If
                CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShowRow", Me)
                Attributes.Show TemplateBlock.Block("Row"), "usuarios:"
                RowControls.Show
                If HasNext Then Recordset.MoveNext
                ShownRecords = ShownRecords + 1
                HasNext = HasNextRow()
            Loop
            Attributes.Show TemplateBlock, "usuarios:"
            StaticControls.Show
        End If

    End Sub
'End usuarios Show Method

'usuarios PageSize Property Let @2-54E46DD6
    Public Property Let PageSize(NewValue)
        VarPageSize = NewValue
        DataSource.PageSize = NewValue
    End Property
'End usuarios PageSize Property Let

'usuarios PageSize Property Get @2-9AA1D1E9
    Public Property Get PageSize()
        PageSize = VarPageSize
    End Property
'End usuarios PageSize Property Get

'usuarios RowNumber Property Get @2-F32EE2C6
    Public Property Get RowNumber()
        RowNumber = ShownRecords + 1
    End Property
'End usuarios RowNumber Property Get

'usuarios HasNextRow Function @2-9BECE27A
    Public Function HasNextRow()
        HasNextRow = NOT Recordset.EOF AND ShownRecords < PageSize
    End Function
'End usuarios HasNextRow Function

End Class 'End usuarios Class @2-A61BA892

Class clsusuariosDataSource 'usuariosDataSource Class @2-4AD1647E

'DataSource Variables @2-A8A74E2B
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
    Public idlogin
    Public idlogin_param1
    Public password
    Public idPerfil
    Public login
'End DataSource Variables

'DataSource Class_Initialize Event @2-F51656F6
    Private Sub Class_Initialize()

        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Fields = New clsFields
        Set Recordset = New clsDataSource
        Set Recordset.DataSource = Me
        Set Errors = New clsErrors
        Set Connection = Nothing
        AllParamsSet = True
        Set idlogin = CCCreateField("idlogin", "idlogin", ccsInteger, Empty, Recordset)
        Set idlogin_param1 = CCCreateField("idlogin_param1", "idlogin", ccsText, Empty, Recordset)
        Set password = CCCreateField("password", "password", ccsText, Empty, Recordset)
        Set idPerfil = CCCreateField("idPerfil", "idPerfil", ccsInteger, Empty, Recordset)
        Set login = CCCreateField("login", "login", ccsText, Empty, Recordset)
        Fields.AddFields Array(idlogin, idlogin_param1, password, idPerfil, login)
        Orders = Array( _ 
            Array("Sorter_idlogin", "idlogin", ""), _
            Array("Sorter_password", "password", ""), _
            Array("Sorter_idPerfil", "idPerfil", ""), _
            Array("Sorter_login", "login", ""))

        SQL = "SELECT TOP {SqlParam_endRecord} idlogin, password, idPerfil, login  " & vbLf & _
        "FROM usuarios {SQL_Where} {SQL_OrderBy}"
        CountSQL = "SELECT COUNT(*) " & vbLf & _
        "FROM usuarios"
        Where = ""
        Order = ""
        StaticOrder = ""
    End Sub
'End DataSource Class_Initialize Event

'SetOrder Method @2-68FC9576
    Sub SetOrder(Column, Direction)
        Order = Recordset.GetOrder(Order, Column, Direction, Orders)
    End Sub
'End SetOrder Method

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

End Class 'End usuariosDataSource Class @2-A61BA892


%>
