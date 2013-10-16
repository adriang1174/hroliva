<%

'Navigator Class @0-DDC4C366
Const tpSimple   = 00001
Const tpCentered = 00002
Const tpMoving   = 00003
Const tpManual   = 00004

Function CCCreateNavigator(Target, Name, FileName, NumberPages, NavigatorType)
  Dim Navigator
  Set Navigator = New clsNavigator
  Navigator.Init Target, Name, FileName, NumberPages, NavigatorType
  Set CCCreateNavigator = Navigator
End Function

Class clsNavigator
  Public ComponentName, CCSEvents
  Public Visible

  Public QueryString
  Public NavigatorBlock
  Public FirstOn, FirstOff, PrevOn, PrevOff, NextOn, NextOff, LastOn, LastOff
  Public Pages, PageOn, PageOff, Page_Parameter
  Public PageSize
  Public PageSizes

  Dim TargetName
  Dim DataSource
  Dim PageNumber
  Dim FileName
  Dim NumberPages
  Dim NavigatorType
  Dim PagesCount
  Dim Attributes

  Private CCSEventResult
        
  Private Sub Class_Initialize()
    Set CCSEvents = CreateObject("Scripting.Dictionary")
    Set DataSource = Nothing
    Set Attributes = New clsAttributes
    PageSizes = Array(1, 5, 10, 25, 50)
    Visible = True
  End Sub

  Private Function GetLink(Par)
    If CCSUseAmps then 
      GetLink = Replace(Par, "&", "&amp;")
    Else 
      GetLink = Par
    End If
  End Function

  Sub Show(Template)
    Dim LastPage
    Dim BeginPage, EndPage, J, Prefix, Item, TargetNamePage

    QueryString = CCGetQueryString("QueryString", Array(TargetName & "Page", "ccsForm"))
    Set NavigatorBlock = Template.Block("Navigator " & ComponentName)
    Prefix = ComponentName & ":"

    With NavigatorBlock
      Set FirstOn = .Block("First_On")
      Set FirstOff = .Block("First_Off")
      Set PrevOn = .Block("Prev_On")
      Set PrevOff = .Block("Prev_Off")
      Set NextOn = .Block("Next_On")
      Set NextOff = .Block("Next_Off")
      Set LastOn = .Block("Last_On")
      Set LastOff = .Block("Last_Off")
      Set Pages = .Block("Pages")
      Set Page_Parameter = .Block("Page_Parameter")
    End With
    TargetNamePage =TargetName & "Page"
    If Not Page_Parameter Is Nothing Then 
       For Each Item In Request.QueryString
   	 If Item <> TargetNamePage And  Item <> TargetName & "PageSize" Then
	   Page_Parameter.Variable("Name") = CCUrlEncode(Item)
	   Page_Parameter.Variable("Value") = CCUrlEncode(Request.QueryString(Item))
 	   Page_Parameter.Parse True
 	 End If
       Next
    End If


    Dim OpenOption, CloseOption, Options, Selected
    If CCSIsXHTML Then
      OpenOption = "<option value"
      CloseOption = "</option>"
    Else 
      OpenOption = "<OPTION VALUE"
      CloseOption = "</OPTION>"
    End If

    Options = ""
    For j = LBound(PageSizes) To UBound(PageSizes)
      If CStr(PageSize) = CStr(PageSizes(j)) Then 
        Selected = " " & CCSSelected
      Else 
        Selected = ""
      End If
      Options = Options &  OpenOption & "="""  &  CStr(PageSizes(j)) _
            & """" & Selected & ">" & CStr(PageSizes(j)) & CloseOption & vbNewLine
    Next
    NavigatorBlock.Variable("PageSize_Options") =  Options	    
    NavigatorBlock.Variable("FormName") =  TargetName	    
	

    If Not FirstOn Is Nothing Then 
      FirstOn.Clear
      Attributes.Show FirstOn, Prefix
    End If
    If Not FirstOff Is Nothing Then 
      FirstOff.Clear
      Attributes.Show FirstOff, Prefix
    End If
    If Not PrevOn Is Nothing Then 
      PrevOn.Clear
      Attributes.Show PrevOn, Prefix
    End If
    If Not PrevOff Is Nothing Then 
      PrevOff.Clear 
      Attributes.Show PrevOff, Prefix
    End If
    If Not NextOn Is Nothing Then 
      NextOn.Clear
      Attributes.Show NextOn, Prefix
    End If
    If Not NextOff Is Nothing Then 
      NextOff.Clear 
      Attributes.Show NextOff, Prefix
    End If
    If Not LastOn Is Nothing Then 
      LastOn.Clear
      Attributes.Show LastOn, Prefix
    End If
    If Not LastOff Is Nothing Then 
      LastOff.Clear 
      Attributes.Show LastOff, Prefix
    End If
    If Not Pages Is Nothing Then 
      Pages.Clear
      Attributes.Show Pages, Prefix
    End If
    If PageNumber < 1 Then PageNumber = 1
    
    CCSEventResult = CCRaiseEvent(CCSEvents, "BeforeShow", Me)

    Attributes.Show Pages, Prefix

    If Not Visible Then Exit Sub
    
    If Not DataSource is Nothing Then
      LastPage = DataSource.PageCount
      If LastPage = 0 Then
        If Not DataSource.RecordSet.Eof Then LastPage = PageNumber + 1
        If LastPage = 0 Then LastPage = 1
      End If
    Else
      LastPage = PagesCount
    End If

    ' Parse First and Prev blocks
    If PageNumber <= 1 Then
      If NOT FirstOff IS Nothing Then FirstOff.Visible = True
      If NOT PrevOff IS Nothing Then PrevOff.Visible = True
    Else
      If NOT FirstOn IS Nothing Then 
        With FirstOn
          .Variable("First_URL") = FileName & "?" & GetLink(CCAddParam(QueryString, TargetNamePage, "1"))
          .Visible = True
        End With
      End If
      If NOT PrevOn IS Nothing Then
        With PrevOn
          .Variable("Prev_URL") = FileName & "?" & GetLink(CCAddParam(QueryString, TargetNamePage, PageNumber - 1))
          .Visible = True
        End With
      End If
    End If

    If NavigatorType = tpSimple Then
      ' Set Page Number
      Set Pages = NavigatorBlock.Block("Pages")
      If Not Pages Is Nothing Then 
        Attributes.Show Pages, Prefix
        Set PageOff = Pages.Block("Page_Off")
	If Not PageOff Is Nothing Then
	  Attributes.Show PageOff, Prefix
  	  PageOff.Variable("Page_Number") = PageNumber
	  PageOff.ParseTo True, Pages
	End If
      Else
        NavigatorBlock.Variable("Page_Number") = PageNumber
      End If
    ElseIf NavigatorType = tpCentered OR NavigatorType = tpMoving Then
      Set Pages = NavigatorBlock.Block("Pages")
      If NOT Pages IS Nothing Then
        Attributes.Show Pages, Prefix
        Set PageOn = Pages.Block("Page_On")
        Set PageOff = Pages.Block("Page_Off")

        If NOT (PageOn IS Nothing OR PageOff IS Nothing) Then

          Select Case NavigatorType

            Case tpCentered
              BeginPage = PageNumber - (NumberPages - 1) \ 2
              If BeginPage < 1 Then BeginPage = 1
              EndPage = BeginPage + NumberPages - 1
              If EndPage > LastPage Then 
                BeginPage = BeginPage - EndPage + LastPage
                If BeginPage < 1 Then BeginPage = 1
                EndPage = LastPage
              End If
              For J = BeginPage To EndPage
                If CLng(J) = CLng(PageNumber) Then
	          Attributes.Show PageOff, Prefix
                  With PageOff
                    .Variable("Page_Number") = J
                    .ParseTo True, Pages
                  End With
                Else
       	          Attributes.Show PageOn, Prefix
                  With PageOn
                    .Variable("Page_Number") = J
                    .Variable("Page_URL") = FileName & "?" & GetLink(CCAddParam(QueryString, TargetNamePage, J))
                    .ParseTo True, Pages
                  End With
                End If
              Next

            Case tpMoving
              Dim GroupNumber, GroupFloat
              GroupFloat = PageNumber / NumberPages 
              GroupNumber = Int(GroupFloat)
              If GroupFloat > GroupNumber Then GroupNumber = GroupNumber + 1
              BeginPage = 1 + NumberPages * (GroupNumber - 1)
              EndPage = NumberPages * GroupNumber
              If BeginPage < 1 Then BeginPage = 1
              If EndPage > LastPage Then EndPage = LastPage
              If BeginPage > 1 Then
     	        Attributes.Show PageOn, Prefix
                With PageOn
                  .Variable("Page_Number") = "&lt;" & (BeginPage - 1)
                  .Variable("Page_URL") = FileName & "?" & GetLink(CCAddParam(QueryString, TargetNamePage, BeginPage - 1))
                  .ParseTo True, Pages
                End With
              End If
              For J = BeginPage To EndPage
                If CLng(J) = CLng(PageNumber) Then
     	          Attributes.Show PageOff, Prefix
                  With PageOff
                    .Variable("Page_Number") = J
                    .ParseTo True, Pages
                  End With
                Else
     	          Attributes.Show PageOn, Prefix
                  With PageOn
                    .Variable("Page_Number") = J
                    .Variable("Page_URL") = FileName & "?" & GetLink(CCAddParam(QueryString, TargetNamePage, J))
                    .ParseTo True, Pages
                  End With
                End If
              Next
              If EndPage < LastPage Then
  	       Attributes.Show PageOn, Prefix
                With PageOn
                  .Variable("Page_Number") = (EndPage + 1) & "&gt;"
                  .Variable("Page_URL") = FileName & "?" & GetLink(CCAddParam(QueryString, TargetNamePage, EndPage + 1))
                  .ParseTo True, Pages
                End With
              End If
          End Select
        End If
      Else
        NavigatorBlock.Variable("Page_Number") = PageNumber
      End If
    End If

    ' Set Total Pages
    NavigatorBlock.Variable("Total_Pages") = LastPage

    ' Parse Last and Next blocks
    If CLng(PageNumber) >= CLng(LastPage) Then
      If NOT NextOff IS Nothing Then NextOff.Visible = True
      If NOT LastOff IS Nothing Then LastOff.Visible = True
    Else
      If NOT NextOn IS Nothing Then 
        With NextOn
          .Variable("Next_URL") = FileName & "?" & GetLink(CCAddParam(QueryString, TargetNamePage, PageNumber + 1))
          .Visible = True
        End With
      End If
      If NOT LastOn IS Nothing Then 
        With LastOn
          .Variable("Last_URL") = FileName & "?" & GetLink(CCAddParam(QueryString, TargetNamePage, LastPage))
          .Visible = True
        End With
      End If
    End If

    NavigatorBlock.Visible = True
    Attributes.Show NavigatorBlock, ComponentName & ":"
  End Sub

  Sub SetDataSource ( objDataSource )
    Set DataSource = objDataSource
    Visible =  DataSource.PageCount > 1
  End Sub

  Sub Init ( Target, Name, NewFileName, NewNumberPages, NewNavigatorType )
    TargetName = Target
    ComponentName = Name
    FileName      = NewFileName
    NumberPages   = NewNumberPages
    NavigatorType = NewNavigatorType
    PageNumber = CCGetParam(TargetName & "Page", 1)
    If Not IsNumeric(PageNumber) AND Len(PageNumber) > 0 Then
      PageNumber = 1
    ElseIf Len(PageNumber) > 0 Then
      If PageNumber > 0 Then PageNumber = CInt(PageNumber) Else PageNumber = 1
    Else
      PageNumber = 1
    End If
  End Sub

  Private Sub Class_Terminate()
    Set DataSource = Nothing
    Set Attributes = Nothing
  End Sub

End Class
'End Navigator Class


%>
