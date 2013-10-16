<%
'BindEvents Method @1-456982D7
Sub BindEvents(Level)
    If Level="Page" Then
    Else
        Set tipo_propiedad.Navigator.CCSEvents("BeforeShow") = GetRef("tipo_propiedad_Navigator_BeforeShow")
    End If
End Sub
'End BindEvents Method

Function tipo_propiedad_Navigator_BeforeShow(Sender) 'tipo_propiedad_Navigator_BeforeShow @17-EF6A0120

'Hide-Show Component @18-6479E599
    Dim TotalPages_18_1 : TotalPages_18_1 = CCSConverter.VBSConvert(ccsInteger, tipo_propiedad.DataSource.Recordset.PageCount)
    Dim Param2_18_2 : Param2_18_2 = CCSConverter.VBSConvert(ccsInteger, 2)
    If  (Not IsEmpty(TotalPages_18_1) And Not IsEmpty(Param2_18_2) And TotalPages_18_1 < Param2_18_2) Then _
        tipo_propiedad.Navigator.Visible = False
'End Hide-Show Component

End Function 'Close tipo_propiedad_Navigator_BeforeShow @17-54C34B28


%>
