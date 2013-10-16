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

'Initialize Page @1-A911A21F
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

' Page controls
Dim propiedades
Dim Link1
Dim ChildControls

Response.ContentType = CCSContentType
Redirect = ""
TemplateFileName = "search2.html"
Set CCSEvents = CreateObject("Scripting.Dictionary")
PathToCurrentPage = "./"
FileName = "search2.asp"
PathToRoot = "./"
ScriptPath = Left(Request.ServerVariables("PATH_TRANSLATED"), Len(Request.ServerVariables("PATH_TRANSLATED")) - Len(FileName))
TemplateFilePath = ScriptPath
'End Initialize Page

'Initialize Objects @1-250F597D
CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeInitialize", Nothing)

Set Attributes = New clsAttributes
Attributes("pathToRoot") = PathToRoot

' Controls
Set propiedades = new clsRecordpropiedades
Set Link1 = CCCreateControl(ccsLink, "Link1", Empty, ccsText, Empty, CCGetRequestParam("Link1", ccsGet))

Link1.Parameters = CCGetQueryString("QueryString", Array("ccsForm"))
Link1.Page = "record.asp"

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

'Show Page @1-862A92E0
Attributes.Show HTMLTemplate, "page:"
Set ChildControls = CCCreateCollection(Tpl, Null, ccsParseOverwrite, _
    Array(propiedades, Link1))
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

'UnloadPage Sub @1-3F201AF4
Sub UnloadPage()
    CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeUnload", Nothing)
    Set CCSEvents = Nothing
    Set Attributes = Nothing
    Set propiedades = Nothing
End Sub
'End UnloadPage Sub

Class clsRecordpropiedades 'propiedades Class @2-806FCECF

'propiedades Variables @2-1BC2ADE7

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
    Dim s_valor
'End propiedades Variables

'propiedades Class_Initialize Event @2-A1E0543B
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
        Set s_valor = CCCreateControl(ccsTextBox, "s_valor", Empty, ccsText, Empty, CCGetRequestParam("s_valor", Method))
        Set ValidatingControls = new clsControls
        ValidatingControls.addControls Array(s_valor)
    End Sub
'End propiedades Class_Initialize Event

'propiedades Class_Terminate Event @2-0C5D276C
    Private Sub Class_Terminate()
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End propiedades Class_Terminate Event

'propiedades Validate Method @2-B9D513CF
    Function Validate()
        Dim Validation
        ValidatingControls.Validate
        CCSEventResult = CCRaiseEvent(CCSEvents, "OnValidate", Me)
        Validate = ValidatingControls.isValid() And (Errors.Count = 0)
    End Function
'End propiedades Validate Method

'propiedades Operation Method @2-F28A6A94
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
                    Redirect = "record.asp?" & CCGetQueryString("Form", Array(PressedButton, "ccsForm", "Button_DoSearch.x", "Button_DoSearch.y", "Button_DoSearch"))
                End If
            End If
        Else
            Redirect = ""
        End If
    End Sub
'End propiedades Operation Method

'propiedades Show Method @2-86D922E4
    Sub Show(Tpl)

        If NOT Visible Then Exit Sub

        EditMode = False
        HTMLFormAction = FileName & "?" & CCAddParam(Request.ServerVariables("QUERY_STRING"), "ccsForm", "propiedades" & IIf(EditMode, ":Edit", ""))
        Set TemplateBlock = Tpl.Block("Record " & ComponentName)
        If TemplateBlock is Nothing Then Exit Sub
        TemplateBlock.Variable("HTMLFormName") = ComponentName
        TemplateBlock.Variable("HTMLFormEnctype") ="application/x-www-form-urlencoded"
        Set Controls = CCCreateCollection(TemplateBlock, Null, ccsParseOverwrite, _
            Array(s_valor, Button_DoSearch))
        If Not FormSubmitted Then
        End If
        If FormSubmitted Then
            Errors.AddErrors s_valor.Errors
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

End Class 'End propiedades Class @2-A61BA892


%>
