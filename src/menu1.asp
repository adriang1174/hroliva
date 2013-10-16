<%
Class clsmenu1 'menu1 Class @1-D42033D5

'Page Variables @1-F1FB7248
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
    Dim Menu1
    Dim ChildControls
    Public Visible
    Public Page
    Public Name
    Public CacheAction
    Private TemplatePathValue
'End Page Variables

'Page Class_Initialize Event @1-BA59E01D
    Private Sub Class_Initialize()
        Visible = True
        Set Page = Me
        Set ParentPage = Me
        TemplatePathValue = ""
        Redirect = ""
        TemplateFileName = "menu1.html"
        Set CCSEvents = CreateObject("Scripting.Dictionary")
        PathToCurrentPage = "./"
    End Sub
'End Page Class_Initialize Event

'Page Class_Terminate Event @1-54C2D173
    Private Sub Class_Terminate()
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeUnload", Me)
        Set Page = Nothing
        If NOT Visible Then _
            Exit Sub
        If DBConnection1.State = adStateOpen Then _
            DBConnection1.Close
        Set DBConnection1 = Nothing
        Set CCSEvents = Nothing
        Set Menu1 = Nothing
    End Sub
'End Page Class_Terminate Event

'Page BindEvents Method @1-D8FDB1E8
    Sub BindEvents()
        CCSEventResult = CCRaiseEvent(CCSEvents, "AfterInitialize", Me)
    End Sub
'End Page BindEvents Method

'Operations Method @1-E8B9371E
    Function Operations()
        If NOT Visible Then _ 
            Exit Function
        Operations = Redirect
    End Function
'End Operations Method

'Initialize Method @1-BAF510D6
    Sub Initialize(Name, Path)
        Me.Name = Name
        TemplatePathValue = Path
        If NOT Visible Then _
            Exit Sub
        Set DBConnection1 = New clsDBConnection1
        DBConnection1.Open

        ' Create Components
        Set Menu1 = New clsMenuMenu1
        Set Menu1.Page = Me
        BindEvents
        Menu1.Initialize DBConnection1
        Set HTMLTemplate = new clsTemplate
        Set HTMLTemplate.Cache = TemplatesRepository
        HTMLTemplate.LoadTemplate TemplateFilePath & TemplatePathValue & TemplateFileName
        HTMLTemplate.SetVar "@CCS_PathToRoot", PathToRoot
        Set Tpl = HTMLTemplate.Block("main")
        CCSEventResult = CCRaiseEvent(CCSEvents, "OnInitializeView", Me)
    End Sub
'End Initialize Method

'Page Show Method @1-570229B4
    Sub Show(MainTpl)
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Me)
        If NOT Visible Then _
            Exit Sub
        Set ChildControls = CCCreateCollection(Tpl, Null, ccsParseOverwrite, _
            Array(Menu1))
        ChildControls.Show
        Attributes.Show HTMLTemplate, "page:"
        HTMLTemplate.Parse "main", False
        MainTpl.Variable(Name) = HTMLTemplate.GetVar("main")
    End Sub
'End Page Show Method

'Let TemplatePath Property @1-520E3E1A
    Property Let TemplatePath(NewTemplatePath)
        TemplatePathValue = NewTemplatePath
    End Property
'End Let TemplatePath Property

'Get TemplatePath Property @1-9428206A
    Property Get TemplatePath
        TemplatePath = TemplatePathValue
    End Property
'End Get TemplatePath Property

'TemplateURL Property @1-CFFB06B3
    Property Get TemplateURL
        TemplateURL = Replace(TemplatePathValue, "\", "/")
    End Property
'End TemplateURL Property

End Class 'End menu1 Class @1-A61BA892

Class clsMenuMenu1 'Menu1 Class @2-F12D1CEE

'Menu1 Variables @2-1AC8260D

    ' Public variables
    Public ComponentName, CCSEvents
    Public Visible, Errors
    Public DataSource
    Public Command
    Public TemplateBlock
    Public IsDSEmpty
    Public ForceIteration
    Public Attributes
    Private ShownRecords
    Public Page
    Public Recordset

    Private CCSEventResult

    ' Menu Controls
    Public StaticControls, RowControls
    Dim ItemLink
    Dim RSMenu
    Dim MenuArray
    Dim Rows
'End Menu1 Variables

'Menu1 Class_Initialize Event @2-7EAA38FA
    Private Sub Class_Initialize()
        ComponentName = "Menu1"
        Visible = True
        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Attributes = New clsAttributes
        Set Errors = New clsErrors
        Set DataSource = New clsMenu1DataSource
        Set Command = New clsCommand

        Set ItemLink = CCCreateControl(ccsLink, "ItemLink", Empty, ccsText, Empty, CCGetRequestParam("ItemLink", ccsGet))
        IsDSEmpty = True
        DataSource.AbsolutePage = 1
    End Sub
'End Menu1 Class_Initialize Event

'Menu1 Initialize Method @2-05754AED
    Sub Initialize(objConnection)
        If NOT Visible Then Exit Sub

        Set DataSource.Connection = objConnection
    End Sub
'End Menu1 Initialize Method

'Menu1 Class_Terminate Event @2-B97CC660
    Private Sub Class_Terminate()
        Set CCSEvents = Nothing
        Set DataSource = Nothing
        Set Command = Nothing
        Set Errors = Nothing
        Set Attributes = Nothing
    End Sub
'End Menu1 Class_Terminate Event

'Menu1 Show Method @2-AD40825C
    Sub Show(Tpl)
        Dim HasNext
        If NOT Visible Then Exit Sub

        Dim ItemBlock, OpenLevelBlock, CloseItemBlock, CloseLevelBlock


        Set TemplateBlock = Tpl.Block("Menu " & ComponentName)
        If TemplateBlock is Nothing Then Exit Sub
        Set ItemBlock = TemplateBlock.Block("Item")
        Set OpenLevelBlock = ItemBlock.Block("OpenLevel")
        Set CloseItemBlock = ItemBlock.Block("CloseItem")
        Set CloseLevelBlock = ItemBlock.Block("CloseLevel")
        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeSelect", Me)
        Set Recordset = DataSource.Open(Command)
        If DataSource.Errors.Count = 0 Then IsDSEmpty = Recordset.EOF
        Rows = Recordset.Recordset.GetRows
        Set RowControls = CCCreateCollection(ItemBlock, Null, ccsParseAccumulate, _
            Array(ItemLink))

        'Create Array from datasource
        Dim f,i
        Dim indexParentID
        Dim indexID
        For i = 0 To  Recordset.Recordset.Fields.Count-1
            If Recordset.Recordset.Fields(i).Name = "idParentCat" Then indexParentID = i
            If Recordset.Recordset.Fields(i).Name = "idCat" Then indexID = i
        Next
        Set MenuArray = New clsDynamicArray
        For i = 0 to UBound(Rows,2)
            If IsNull(Rows(indexParentID, i)) or Rows(indexParentID, i)="" Then
                MenuArray.Add(CCCreateMenuNode(Rows(indexParentID, i), Rows(indexID, i),Rows, i))
            Else
                AddNode MenuArray, CCCreateMenuNode(Rows(indexParentID, i), Rows(indexID, i),Rows, i), 2
            End If
        Next

        'Create new Recordset
        Set rsMenu = CreateObject("ADODB.Recordset")
        For Each f In Recordset.Recordset.Fields
            rsMenu.Fields.Append f.name, f.Type, f.DefinedSize, f.Attributes
            If f.Type = adNumeric Or f.Type = adDecimal Then
                rsMenu.Fields(.Fields.Count - 1).Precision = f.Precision
                rsMenu.Fields(.Fields.Count - 1).NumericScale = f.NumericScale
            End If
        Next
        With rsMenu
            .Fields.Append "CCS_Level", adInteger

            .CursorType = adOpenStatic
            .LockType = adLockOptimistic
            .ActiveConnection = Nothing
            .CursorLocation = aduseclient
            .Open
        End With
        TransformToFlat MenuArray, 1, Recordset.Recordset.Fields
        Attributes("MenuType") = "menu_htb"
        Set Recordset.Recordset = rsMenu
        Recordset.Recordset.MoveFirst

        CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Me)
        If NOT Visible Then Exit Sub

        RowControls.PreserveControlsVisible
        Errors.AddErrors DataSource.Errors
        If Errors.Count > 0 Then
            TemplateBlock.HTML = CCFormatError("Menu " & ComponentName, Errors)
        Else
            Dim  PrevLevel, CurrentLevel, NextLevel
            PrevLevel = 1
            HasNext = HasNextRow()
            ForceIteration = False
            Do While ForceIteration Or HasNext
                CurrentLevel= RecordSet.RecordSet("CCS_Level")
                Attributes("Item_Level") = CurrentLevel
                Attributes("rowNumber") = ShownRecords + 1
                Attributes("Target") = ""
                If Not OpenLevelBlock is Nothing Then
                    OpenLevelBlock.Clear
                    If Recordset.Recordset("CCS_Level") - PrevLevel > 0 Then
                        Attributes.Show OpenLevelBlock, "Menu1:"
                        OpenLevelBlock.Show
                    End If
                    prevLevel = CurrentLevel
                End If
                If HasNext Then
                    ItemLink.Value = Recordset.Fields("ItemLink")
                    ItemLink.Parameters = CCGetQueryString("QueryString", Array("ccsForm"))
                    ItemLink.Page = Recordset.Fields("ubicacion")
                End If
                CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShowRow", Me)
                If HasNext Then Recordset.MoveNext
                HasNext = HasNextRow()
                If HasNext Then
                    NextLevel = RecordSet.RecordSet("CCS_Level")
                    Attributes("Submenu") = IIF(NextLevel-CurrentLevel > 0 , "submenu", "")
                Else
                    NextLevel = 1
                End If
                If Not CloseLevelBlock is Nothing Then
                    CloseLevelBlock.Clear
                    If  NextLevel < CurrentLevel  Then
                        For i = 1 To   CurrentLevel - NextLevel
                            CloseLevelBlock.Parse True
                        Next
                    End If
                End If
                If Not CloseItemBlock is Nothing Then
                    CloseItemBlock.Clear
                    If  NextLevel <= CurrentLevel  Then
                        CloseItemBlock.Show
                    End If
                End If
                ShownRecords = ShownRecords + 1
                Attributes.Show ItemBlock, "Menu1:"
                RowControls.Show
            Loop
            Attributes.Show TemplateBlock, "Menu1:"
            TemplateBlock.Parse ccsParseOverwrite
        End If

    End Sub
'End Menu1 Show Method

'Menu1 HasNextRow Function @2-5E30721E
    Public Function HasNextRow()
        HasNextRow = NOT Recordset.EOF
    End Function
'End Menu1 HasNextRow Function

'Menu1 AddNode Function @2-6D16DC2A
    Private Function  AddNode(MenuArray, Node, Level)
        Dim i
        For i=0 To MenuArray.Count-1
            If MenuArray.Item(i).Id = Node.ParentId Then
                If  MenuArray.Item(i).CCS_Children is Nothing Then _
                    Set MenuArray.Item(i).CCS_Children = New clsDynamicArray
                Node.Level = Level
                MenuArray.Item(i).CCS_Children.Add(Node)
            ElseIf Not MenuArray.Item(i).CCS_Children is Nothing Then
                AddNode MenuArray.Item(i).CCS_Children, Node, Level+1
            End If
        Next
    End Function
'End Menu1 AddNode Function

'Menu1 TransformToFlat Function @2-C96522E2
    Private Function TransformToFlat(MenuArray, Level, Fields)
        Dim i, c, Rec
        For i = 0 To MenuArray.Count-1
            Rec = MenuArray.Item(i).Record
            rsMenu.AddNew
            For c = 0 To  UBound(Rec)
                rsMenu(Fields(c).name) = Rec(c)
            Next
            rsMenu("CCS_Level") = Level
            rsMenu.Update
            If Not MenuArray.Item(i).CCS_Children is Nothing Then _
                 TransformToFlat MenuArray.Item(i).CCS_Children, Level + 1, Fields
        Next
    End Function
'End Menu1 TransformToFlat Function

End Class 'End Menu1 Class @2-A61BA892

Class clsMenu1DataSource 'Menu1DataSource Class @2-53479A12

'DataSource Variables @2-AE686B16
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
    Public ItemLink
'End DataSource Variables

'DataSource Class_Initialize Event @2-244CA51E
    Private Sub Class_Initialize()

        Set CCSEvents = CreateObject("Scripting.Dictionary")
        Set Fields = New clsFields
        Set Recordset = New clsDataSource
        Set Recordset.DataSource = Me
        Set Errors = New clsErrors
        Set Connection = Nothing
        AllParamsSet = True
        Set ItemLink = CCCreateField("ItemLink", "descripcion", ccsText, Empty, Recordset)
        Fields.AddFields Array(ItemLink)

        SQL = "SELECT *  " & vbLf & _
        "FROM menu_cat {SQL_Where} {SQL_OrderBy}"
        CountSQL = "SELECT COUNT(*) " & vbLf & _
        "FROM menu_cat"
        Where = ""
        Order = ""
        StaticOrder = ""
    End Sub
'End DataSource Class_Initialize Event

'BuildTableWhere Method @2-98E5A92F
    Public Sub BuildTableWhere()
    End Sub
'End BuildTableWhere Method

'Open Method @2-89803B1E
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

End Class 'End Menu1DataSource Class @2-A61BA892


%>
