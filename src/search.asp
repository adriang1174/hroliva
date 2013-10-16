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

'Initialize Page @1-96F5BC0C
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
TemplateFileName = "search.html"
Set CCSEvents = CreateObject("Scripting.Dictionary")
PathToCurrentPage = "./"
FileName = "search.asp"
PathToRoot = "./"
ScriptPath = Left(Request.ServerVariables("PATH_TRANSLATED"), Len(Request.ServerVariables("PATH_TRANSLATED")) - Len(FileName))
TemplateFilePath = ScriptPath
'End Initialize Page

'Initialize Objects @1-B0FBE6F7
CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInitialize", Nothing)

Set DBConnection1 = New clsDBConnection1
DBConnection1.Open
Set Attributes = New clsAttributes
Attributes("pathToRoot") = PathToRoot

' Controls
Set propiedades = new clsRecordpropiedades

CCSEventResult = CCRaiseEvent(CCSEvents, "AfterInitialize", Nothing)
'End Initialize Objects

'Execute Components @1-30F35BFC
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

Class clsRecordpropiedades 'propiedades Class @11-806FCECF

'propiedades Variables @11-9C43BB0C

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
    Dim s_idZona
    Dim s_idOperacion
    Dim s_idTipo
    Dim s_dormitorios
    Dim s_idMoneda
    Dim s_valor
    Dim s_valorhasta
'End propiedades Variables

'propiedades Class_Initialize Event @11-C75B368E
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
            FormSubmitted = (OperationMode(0) = "propiedades")
        End If
        If UBound(OperationMode) > 0 Then 
            EditMode = (OperationMode(1) = "Edit")
        End If
        ComponentName = "propiedades"
        Method = IIf(FormSubmitted, ccsPost, ccsGet)
        Set Button_DoSearch = CCCreateButton("Button_DoSearch", Method)
        Set s_idZona = CCCreateList(ccsListBox, "s_idZona", Empty, ccsInteger, CCGetRequestParam("s_idZona", Method), Empty)
        s_idZona.BoundColumn = "idZona"
        s_idZona.TextColumn = "descripcion"
        Set s_idZona.DataSource = CCCreateDataSource(dsTable,DBConnection1, Array("SELECT *  " & _
"FROM zonas {SQL_Where} {SQL_OrderBy}", "", ""))
        Set s_idOperacion = CCCreateList(ccsListBox, "s_idOperacion", Empty, ccsInteger, CCGetRequestParam("s_idOperacion", Method), Empty)
        s_idOperacion.BoundColumn = "idOperacion"
        s_idOperacion.TextColumn = "descripcion"
        Set s_idOperacion.DataSource = CCCreateDataSource(dsTable,DBConnection1, Array("SELECT *  " & _
"FROM operaciones {SQL_Where} {SQL_OrderBy}", "", ""))
        Set s_idTipo = CCCreateList(ccsListBox, "s_idTipo", Empty, ccsInteger, CCGetRequestParam("s_idTipo", Method), Empty)
        s_idTipo.BoundColumn = "idTipo"
        s_idTipo.TextColumn = "descripcion"
        Set s_idTipo.DataSource = CCCreateDataSource(dsTable,DBConnection1, Array("SELECT *  " & _
"FROM tipo_propiedad {SQL_Where} {SQL_OrderBy}", "", ""))
        Set s_dormitorios = CCCreateList(ccsListBox, "s_dormitorios", Empty, ccsInteger, CCGetRequestParam("s_dormitorios", Method), Empty)
        Set s_dormitorios.DataSource = CCCreateDataSource(dsListOfValues, Empty, Array( _
            Array("1", "2", "3", "4"), _
            Array("1", "2", "3", "4")))
        Set s_idMoneda = CCCreateList(ccsListBox, "s_idMoneda", Empty, ccsInteger, CCGetRequestParam("s_idMoneda", Method), Empty)
        s_idMoneda.BoundColumn = "idMoneda"
        s_idMoneda.TextColumn = "descripcion"
        Set s_idMoneda.DataSource = CCCreateDataSource(dsTable,DBConnection1, Array("SELECT *  " & _
"FROM moneda {SQL_Where} {SQL_OrderBy}", "", ""))
        Set s_valor = CCCreateList(ccsListBox, "s_valor", Empty, ccsText, CCGetRequestParam("s_valor", Method), Empty)
        s_valor.BoundColumn = "idRango"
        s_valor.TextColumn = "valor"
        Set s_valor.DataSource = CCCreateDataSource(dsTable,DBConnection1, Array("SELECT *  " & _
"FROM rango_valor {SQL_Where} {SQL_OrderBy}", "", ""))
        Set s_valorhasta = CCCreateList(ccsListBox, "s_valorhasta", Empty, ccsText, CCGetRequestParam("s_valorhasta", Method), Empty)
        s_valorhasta.BoundColumn = "idRango"
        s_valorhasta.TextColumn = "valor"
        Set s_valorhasta.DataSource = CCCreateDataSource(dsTable,DBConnection1, Array("SELECT *  " & _
"FROM rango_valor {SQL_Where} {SQL_OrderBy}", "", ""))
        Set ValidatingControls = new clsControls
        ValidatingControls.addControls Array(s_idZona, s_idOperacion, s_idTipo, s_dormitorios, s_idMoneda, s_valor, s_valorhasta)
    End Sub
'End propiedades Class_Initialize Event

'propiedades Class_Terminate Event @11-0C5D276C
    Private Sub Class_Terminate()
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End propiedades Class_Terminate Event

'propiedades Validate Method @11-B9D513CF
    Function Validate()
        Dim Validation
        ValidatingControls.Validate
        CCSEventResult = CCRaiseEvent(CCSEvents, "OnValidate", Me)
        Validate = ValidatingControls.isValid() And (Errors.Count = 0)
    End Function
'End propiedades Validate Method

'propiedades Operation Method @11-9D719A51
    Sub Operation()
        If NOT ( Visible AND FormSubmitted ) Then Exit Sub

        If FormSubmitted Then
            PressedButton = "Button_DoSearch"
            If Button_DoSearch.Pressed Then
                PressedButton = "Button_DoSearch"
            End If
        End If
        Redirect = "record.asp"
        If Validate() Then
            If PressedButton = "Button_DoSearch" Then
                If NOT Button_DoSearch.OnClick() Then
                    Redirect = ""
                Else
                    Redirect = "record.asp?" & CCGetQueryString("Form", Array(PressedButton, "ccsForm"))
                End If
            End If
        Else
            Redirect = ""
        End If
    End Sub
'End propiedades Operation Method

'propiedades Show Method @11-C57364A6
    Sub Show(Tpl)

        If NOT Visible Then Exit Sub

        EditMode = False
        HTMLFormAction = FileName & "?" & CCAddParam(Request.ServerVariables("QUERY_STRING"), "ccsForm", "propiedades" & IIf(EditMode, ":Edit", ""))
        Set TemplateBlock = Tpl.Block("Record " & ComponentName)
        If TemplateBlock is Nothing Then Exit Sub
        TemplateBlock.Variable("HTMLFormName") = ComponentName
        TemplateBlock.Variable("HTMLFormEnctype") ="application/x-www-form-urlencoded"
        Set Controls = CCCreateCollection(TemplateBlock, Null, ccsParseOverwrite, _
            Array(s_idZona, s_idOperacion, s_idTipo, s_dormitorios, s_idMoneda, s_valor, s_valorhasta, Button_DoSearch))
        If Not FormSubmitted Then
        End If
        If FormSubmitted Then
            Errors.AddErrors s_idZona.Errors
            Errors.AddErrors s_idOperacion.Errors
            Errors.AddErrors s_idTipo.Errors
            Errors.AddErrors s_dormitorios.Errors
            Errors.AddErrors s_idMoneda.Errors
            Errors.AddErrors s_valor.Errors
            Errors.AddErrors s_valorhasta.Errors
            With TemplateBlock.Block("Error")
                .Variable("Error") = Errors.ToString()
                .Parse False
            End With
        End If
        TemplateBlock.Variable("Action") = IIF(CCSUseAmps, Replace(HTMLFormAction, "&", CCSAmps), HTMLFormAction)

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Me)
        If Visible Then 
            Attributes.Show TemplateBlock, "propiedades" & ":"
            Controls.Show
        End If
    End Sub
'End propiedades Show Method

End Class 'End propiedades Class @11-A61BA892


%>
