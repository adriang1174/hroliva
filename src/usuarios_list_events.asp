<%
'BindEvents Method @1-E478345E
Sub BindEvents(Level)
    If Level="Page" Then
    Else
        Set usuarios.Navigator.CCSEvents("BeforeShow") = GetRef("usuarios_Navigator_BeforeShow")
    End If
End Sub
'End BindEvents Method

Function usuarios_Navigator_BeforeShow(Sender) 'usuarios_Navigator_BeforeShow @18-F8B72729

'Hide-Show Component @19-0893BC5A
    Dim TotalPages_19_1 : TotalPages_19_1 = CCSConverter.VBSConvert(ccsInteger, usuarios.DataSource.Recordset.PageCount)
    Dim Param2_19_2 : Param2_19_2 = CCSConverter.VBSConvert(ccsInteger, 2)
    If  (Not IsEmpty(TotalPages_19_1) And Not IsEmpty(Param2_19_2) And TotalPages_19_1 < Param2_19_2) Then _
        usuarios.Navigator.Visible = False
'End Hide-Show Component

End Function 'Close usuarios_Navigator_BeforeShow @18-54C34B28


%>
