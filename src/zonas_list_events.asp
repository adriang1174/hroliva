<%
'BindEvents Method @1-BAEF500A
Sub BindEvents(Level)
    If Level="Page" Then
    Else
        Set zonas.Navigator.CCSEvents("BeforeShow") = GetRef("zonas_Navigator_BeforeShow")
    End If
End Sub
'End BindEvents Method

Function zonas_Navigator_BeforeShow(Sender) 'zonas_Navigator_BeforeShow @17-A1A84254

'Hide-Show Component @18-25C49E58
    Dim TotalPages_18_1 : TotalPages_18_1 = CCSConverter.VBSConvert(ccsInteger, zonas.DataSource.Recordset.PageCount)
    Dim Param2_18_2 : Param2_18_2 = CCSConverter.VBSConvert(ccsInteger, 2)
    If  (Not IsEmpty(TotalPages_18_1) And Not IsEmpty(Param2_18_2) And TotalPages_18_1 < Param2_18_2) Then _
        zonas.Navigator.Visible = False
'End Hide-Show Component

End Function 'Close zonas_Navigator_BeforeShow @17-54C34B28


%>
