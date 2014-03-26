<%@ CodePage=1252 %>
<%
'Include Common Files @1-D08CF8BA
%>
<!-- #INCLUDE VIRTUAL="/search/Common.asp"-->
<!-- #INCLUDE VIRTUAL="/search/Cache.asp" -->
<!-- #INCLUDE VIRTUAL="/search/Template.asp" -->
<!-- #INCLUDE VIRTUAL="/search/Sorter.asp" -->
<!-- #INCLUDE VIRTUAL="/search/Navigator.asp" -->
<%
'End Include Common Files

'Initialize Page @1-3E536F06
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
Dim propiedades
Dim ChildControls

Response.ContentType = CCSContentType
Redirect = ""
TemplateFileName = "record.html"
Set CCSEvents = CreateObject("Scripting.Dictionary")
PathToCurrentPage = "./"
FileName = "record.asp"
PathToRoot = "./"
ScriptPath = Left(Request.ServerVariables("PATH_TRANSLATED"), Len(Request.ServerVariables("PATH_TRANSLATED")) - Len(FileName))
TemplateFilePath = ScriptPath
'End Initialize Page

'Initialize Objects @1-435CACC1
BindEvents "Page"
CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInitialize", Nothing)

Set DBConnection1 = New clsDBConnection1
DBConnection1.Open
Set Attributes = New clsAttributes
Attributes("pathToRoot") = PathToRoot

' Controls
Set propiedades = New clsGridpropiedades
propiedades.Initialize DBConnection1

' Events
%>
<!-- #INCLUDE VIRTUAL="/search/record_events.asp" -->
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

'Show Page @1-FAA3E4B7
Attributes.Show HTMLTemplate, "page:"
Set ChildControls = CCCreateCollection(Tpl, Null, ccsParseOverwrite, _
    Array(propiedades))
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

'UnloadPage Sub @1-ABAD9C4F
Sub UnloadPage()
    CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeUnload", Nothing)
    If DBConnection1.State = adStateOpen Then _
        DBConnection1.Close
    Set DBConnection1 = Nothing
    Set CCSEvents = Nothing
    Set Attributes = Nothing
    Set propiedades = Nothing
End Sub
'End UnloadPage Sub

Class clsGridpropiedades 'propiedades Class @2-1018A140

'propiedades Variables @2-16C8ADF8

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
    Dim zona
    Dim dormitorios
    Dim valor
    Dim id
    Dim Image1
    Dim descripcion
    Dim operacion
    Dim tipo
    Dim idPropiedad
    Dim valor_num
    Dim RowCloseTag
    Dim Navigator
'End propiedades Variables

'propiedades Class_Initialize Event @2-EDFDBCAA
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

        Set RowOpenTag = CCCreatePanel("RowOpenTag")
        Set RowComponents = CCCreatePanel("RowComponents")
        Set zona = CCCreateControl(ccsLabel, "zona", Empty, ccsText, Empty, CCGetRequestParam("zona", ccsGet))
        Set dormitorios = CCCreateControl(ccsLabel, "dormitorios", Empty, ccsInteger, Empty, CCGetRequestParam("dormitorios", ccsGet))
        Set valor = CCCreateControl(ccsLabel, "valor", Empty, ccsText, Empty, CCGetRequestParam("valor", ccsGet))
        Set id = CCCreateControl(ccsLabel, "id", Empty, ccsText, Empty, CCGetRequestParam("id", ccsGet))
        Set Image1 = CCCreateControl(ccsImage, "Image1", Empty, ccsText, Empty, CCGetRequestParam("Image1", ccsGet))
        Set descripcion = CCCreateControl(ccsLabel, "descripcion", Empty, ccsText, Empty, CCGetRequestParam("descripcion", ccsGet))
        Set operacion = CCCreateControl(ccsLabel, "operacion", Empty, ccsText, Empty, CCGetRequestParam("operacion", ccsGet))
        Set tipo = CCCreateControl(ccsLabel, "tipo", Empty, ccsText, Empty, CCGetRequestParam("tipo", ccsGet))
        Set idPropiedad = CCCreateControl(ccsHidden, "idPropiedad", Empty, ccsText, Empty, CCGetRequestParam("idPropiedad", ccsGet))
        Set valor_num = CCCreateControl(ccsHidden, "valor_num", Empty, ccsFloat, Empty, CCGetRequestParam("valor_num", ccsGet))
        Set RowCloseTag = CCCreatePanel("RowCloseTag")
        Set Navigator = CCCreateNavigator(ComponentName, "Navigator", FileName, 10, tpCentered)
        Navigator.PageSizes = Array("1", "5", "10", "25", "50")
        RowComponents.AddComponents(Array(zona,dormitorios,valor,id,Image1,descripcion,operacion,tipo,idPropiedad,valor_num))
    IsDSEmpty = True
    End Sub
'End propiedades Class_Initialize Event

'propiedades Initialize Method @2-57CE6952
    Sub Initialize(objConnection)
        If NOT Visible Then Exit Sub

        Set DataSource.Connection = objConnection
        DataSource.PageSize = PageSize
        DataSource.AbsolutePage = PageNumber
    End Sub
'End propiedades Initialize Method

'propiedades Class_Terminate Event @2-B97CC660
    Private Sub Class_Terminate()
        Set CCSEvents = Nothing
        Set DataSource = Nothing
        Set Command = Nothing
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End propiedades Class_Terminate Event

'propiedades Show Method @2-FF826503
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
            Array(Navigator))
            Navigator.PageSize = PageSize
            Navigator.SetDataSource Recordset
        Set RowControls = CCCreateCollection(RowBlock, Null, ccsParseAccumulate, _
            Array(RowOpenTag, RowComponents, RowCloseTag))
        Attributes("numberOfColumns") = 1

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
                    zona.Value = Recordset.Fields("zona")
                    dormitorios.Value = Recordset.Fields("dormitorios")
                    valor.Value = Recordset.Fields("valor")
                    id.Value = Recordset.Fields("id")
                    
                    descripcion.Value = Recordset.Fields("descripcion")
                    operacion.Value = Recordset.Fields("operacion")
                    tipo.Value = Recordset.Fields("tipo")
                    idPropiedad.Value = Recordset.Fields("idPropiedad")
                    valor_num.Value = Recordset.Fields("valor_num")
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

'propiedades PageSize Property Let @2-54E46DD6
    Public Property Let PageSize(NewValue)
        VarPageSize = NewValue
        DataSource.PageSize = NewValue
    End Property
'End propiedades PageSize Property Let

'propiedades PageSize Property Get @2-9AA1D1E9
    Public Property Get PageSize()
        PageSize = VarPageSize
    End Property
'End propiedades PageSize Property Get

'propiedades RowNumber Property Get @2-F32EE2C6
    Public Property Get RowNumber()
        RowNumber = ShownRecords + 1
    End Property
'End propiedades RowNumber Property Get

'propiedades HasNextRow Function @2-9BECE27A
    Public Function HasNextRow()
        HasNextRow = NOT Recordset.EOF AND ShownRecords < PageSize
    End Function
'End propiedades HasNextRow Function

End Class 'End propiedades Class @2-A61BA892

Class clspropiedadesDataSource 'propiedadesDataSource Class @2-B58C0B7E

'DataSource Variables @2-3744C671
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
    Public zona
    Public dormitorios
    Public valor
    Public id
    Public descripcion
    Public operacion
    Public tipo
    Public idPropiedad
    Public valor_num
'End DataSource Variables

'DataSource Class_Initialize Event @2-42C1AC56
    Private Sub Class_Initialize()

        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Fields = New clsFields
        Set Recordset = New clsDataSource
        Set Recordset.DataSource = Me
        Set Errors = New clsErrors
        Set Connection = Nothing
        AllParamsSet = True
        Set zona = CCCreateField("zona", "zonas_descripcion", ccsText, Empty, Recordset)
        Set dormitorios = CCCreateField("dormitorios", "dormitorios", ccsInteger, Empty, Recordset)
        Set valor = CCCreateField("valor", "valor", ccsText, Empty, Recordset)
        Set id = CCCreateField("id", "id", ccsText, Empty, Recordset)
        Set descripcion = CCCreateField("descripcion", "descripcion", ccsText, Empty, Recordset)
        Set operacion = CCCreateField("operacion", "operaciones_descripcion", ccsText, Empty, Recordset)
        Set tipo = CCCreateField("tipo", "tipo_propiedad_descripcion", ccsText, Empty, Recordset)
        Set idPropiedad = CCCreateField("idPropiedad", "idPropiedad", ccsText, Empty, Recordset)
        Set valor_num = CCCreateField("valor_num", "valor_num", ccsFloat, Empty, Recordset)
        Fields.AddFields Array(zona, dormitorios, valor, id, descripcion, operacion, tipo, idPropiedad, valor_num)

        SQL = "SELECT TOP {SqlParam_endRecord} zonas.descripcion AS zonas_descripcion, operaciones.descripcion AS operaciones_descripcion, tipo_propiedad.descripcion AS tipo_propiedad_descripcion, " & vbLf & _
        "moneda.descripcion AS moneda_descripcion, idPropiedad, id, propiedades.idZona AS propiedades_idZona, propiedades.idOperacion AS propiedades_idOperacion, " & vbLf & _
        "propiedades.idTipo AS propiedades_idTipo, propiedades.descripcion AS descripcion, dormitorios, valor AS valor, propiedades.idMoneda AS propiedades_idMoneda, " & vbLf & _
        "activo, orden, valor_num  " & vbLf & _
        "FROM (((propiedades INNER JOIN zonas ON " & vbLf & _
        "propiedades.idZona = zonas.idZona) INNER JOIN operaciones ON " & vbLf & _
        "propiedades.idOperacion = operaciones.idOperacion) INNER JOIN tipo_propiedad ON " & vbLf & _
        "propiedades.idTipo = tipo_propiedad.idTipo) INNER JOIN moneda ON " & vbLf & _
        "propiedades.idMoneda = moneda.idMoneda {SQL_Where} {SQL_OrderBy}"
        CountSQL = "SELECT COUNT(*) " & vbLf & _
        "FROM (((propiedades INNER JOIN zonas ON " & vbLf & _
        "propiedades.idZona = zonas.idZona) INNER JOIN operaciones ON " & vbLf & _
        "propiedades.idOperacion = operaciones.idOperacion) INNER JOIN tipo_propiedad ON " & vbLf & _
        "propiedades.idTipo = tipo_propiedad.idTipo) INNER JOIN moneda ON " & vbLf & _
        "propiedades.idMoneda = moneda.idMoneda"
        Where = ""
        Order = "orden"
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

End Class 'End propiedadesDataSource Class @2-A61BA892


%>


