<%
'BindEvents Method @1-160809BD
Sub BindEvents(Level)
    If Level="Page" Then
    Else
        Set propiedades.Navigator.CCSEvents("BeforeShow") = GetRef("propiedades_Navigator_BeforeShow")
        Set propiedades.CCSEvents("BeforeShowRow") = GetRef("propiedades_BeforeShowRow")
    End If
End Sub
'End BindEvents Method

Function propiedades_Navigator_BeforeShow(Sender) 'propiedades_Navigator_BeforeShow @39-C1359743

'Hide-Show Component @40-57CC7742
    Dim TotalPages_40_1 : TotalPages_40_1 = CCSConverter.VBSConvert(ccsInteger, propiedades.DataSource.Recordset.PageCount)
    Dim Param2_40_2 : Param2_40_2 = CCSConverter.VBSConvert(ccsInteger, 2)
    If  (Not IsEmpty(TotalPages_40_1) And Not IsEmpty(Param2_40_2) And TotalPages_40_1 < Param2_40_2) Then _
        propiedades.Navigator.Visible = False
'End Hide-Show Component

End Function 'Close propiedades_Navigator_BeforeShow @39-54C34B28

Function propiedades_BeforeShowRow(Sender) 'propiedades_BeforeShowRow @6-9D467D32

'Custom Code @43-73254650
' -------------------------
Dim SQL
Dim rs
'---Zona
SQL = "SELECT descripcion FROM zonas WHERE idZona = " & propiedades.idZona.value
Set rs = DBConnection1.Execute(SQL)
If DBConnection1.Errors.Count = 0 Then
	if NOT rs.EOF then
	  propiedades.idZona.value =  rs("descripcion")
	end if
	rs.Close
	set rs = Nothing
end if
'---Operacion
SQL = "SELECT descripcion FROM operaciones WHERE idOperacion = " & propiedades.idOperacion.value
Set rs = DBConnection1.Execute(SQL)
If DBConnection1.Errors.Count = 0 Then
	if NOT rs.EOF then
	  propiedades.idOperacion.value =  rs("descripcion")
	end if
	rs.Close
	set rs = Nothing
end if
'---Tipo
SQL = "SELECT descripcion FROM tipo_propiedad WHERE idTipo = " & propiedades.idTipo.value
Set rs = DBConnection1.Execute(SQL)
If DBConnection1.Errors.Count = 0 Then
	if NOT rs.EOF then
	  propiedades.idTipo.value =  rs("descripcion")
	end if
	rs.Close
	set rs = Nothing
end if
'---Tipo
SQL = "SELECT descripcion FROM moneda WHERE idMoneda = " & propiedades.moneda.value
Set rs = DBConnection1.Execute(SQL)
If DBConnection1.Errors.Count = 0 Then
	if NOT rs.EOF then
	  propiedades.moneda.value =  rs("descripcion")
	end if
	rs.Close
	set rs = Nothing
end if
' -------------------------
'End Custom Code

End Function 'Close propiedades_BeforeShowRow @6-54C34B28


%>
