<%
'BindEvents Method @1-634A3324
Sub BindEvents(Level)
    If Level="Page" Then
    Else
        Set propiedades.CCSEvents("BeforeShowRow") = GetRef("propiedades_BeforeShowRow")
        Set propiedades.DataSource.CCSEvents("BeforeBuildSelect") = GetRef("propiedades_DataSource_BeforeBuildSelect")
    End If
End Sub
'End BindEvents Method

Function propiedades_BeforeShowRow(Sender) 'propiedades_BeforeShowRow @2-9D467D32

'Gallery Layout @4-41878FC4
    CCManageGalleryPanels propiedades, propiedades.Attributes("numberOfColumns"), propiedades.RowOpenTag, propiedades.RowCloseTag, propiedades.RowComponents
'End Gallery Layout

'Custom Code @36-73254650
' -------------------------
Dim SQL
Dim rs
  
SQL = "SELECT url FROM fotos where id = " & propiedades.DataSource.idPropiedad.Value

Set rs = DBConnection1.Execute(SQL)
If DBConnection1.Errors.Count = 0 Then
	if NOT rs.EOF then
	  propiedades.Image1.Value = rs("url")
    else
	  propiedades.Image1.Value = "nodisp.jpg"
	end if
	rs.Close
	set rs = Nothing
end if

'Agregamos $ o U$s según corresponda
SQL = "SELECT descripcion FROM moneda where idMoneda in(select idMoneda from propiedades where idPropiedad = " & propiedades.DataSource.idPropiedad.Value & ")"
Set rs = DBConnection1.Execute(SQL)
If DBConnection1.Errors.Count = 0 Then
	if NOT rs.EOF then
	  'propiedades.Image1.Value = rs("url")
	  propiedades.valor.Value = rs("descripcion")& " " &propiedades.valor.Value
	end if
	rs.Close
	set rs = Nothing
end if

'Si corresponde colocamos "Consulte" - Lo sacamos por pesificaci—n
'if propiedades.DataSource.valor_num.Value > 90000 then
'	propiedades.valor.Value = "Consulte"
'	'propiedades.valor.Value = propiedades.DataSource.valor_num.Value
'end if
' -------------------------
'End Custom Code

End Function 'Close propiedades_BeforeShowRow @2-54C34B28

Function propiedades_DataSource_BeforeBuildSelect(Sender) 'propiedades_DataSource_BeforeBuildSelect @2-0230252B

'Custom Code @56-73254650
' -------------------------

propiedades.DataSource.Where =  "propiedades.activo = 1"
if CCGetFromGet("s_ref","") <> empty  then
	propiedades.DataSource.Where = propiedades.DataSource.Where & " AND propiedades.id = '" &CCGetFromGet("s_ref","") & "'"
end if
if CCGetFromGet("s_idZona","") <> empty then
	propiedades.DataSource.Where = propiedades.DataSource.Where & " AND propiedades.idZona =" &CCGetFromGet("s_idZona","")
end if
if CCGetFromGet("s_idOperacion","") <> empty then
	propiedades.DataSource.Where = propiedades.DataSource.Where & " AND propiedades.idOperacion =" &CCGetFromGet("s_idOperacion","")
end if
if CCGetFromGet("s_idTipo","") <> empty then
	propiedades.DataSource.Where = propiedades.DataSource.Where & " AND propiedades.idTipo =" &CCGetFromGet("s_idTipo","")
end if
if CCGetFromGet("s_dormitorios","") <> empty then
	propiedades.DataSource.Where = propiedades.DataSource.Where & " AND propiedades.dormitorios =" &CCGetFromGet("s_dormitorios","")
end if
if CCGetFromGet("s_idMoneda","") <> empty  then
	propiedades.DataSource.Where = propiedades.DataSource.Where & " AND propiedades.idMoneda = " &CCGetFromGet("s_idMoneda","")
end if
'
' Modifcamos para que la búsqueda sea ahora por valor_num
'
if (CCGetFromGet("s_valor","") <> empty)  And (CCGetFromGet("s_valor","") <> "6") then
	'propiedades.DataSource.Where = propiedades.DataSource.Where & " AND ( valor like '%Cons%' OR convert(varchar,len(valor))+replace(valor,'.','') >= (select convert(varchar,len(valor))+replace(valor,'.','') from rango_valor where idRango = " &CCGetFromGet("s_valor","")&"))"
	propiedades.DataSource.Where = propiedades.DataSource.Where & " AND (valor_num >= (select convert(decimal,replace(valor,'.','')) from rango_valor where idRango = " &CCGetFromGet("s_valor","")&"))"
end if
if (CCGetFromGet("s_valorhasta","") <> empty)  And (CCGetFromGet("s_valorhasta","") <> "6") then
	'propiedades.DataSource.Where = propiedades.DataSource.Where & " AND ( valor like '%Cons%' OR convert(varchar,len(valor))+replace(valor,'.','') <= (select convert(varchar,len(valor))+replace(valor,'.','') from rango_valor where idRango = " &CCGetFromGet("s_valorhasta","")&"))"
	propiedades.DataSource.Where = propiedades.DataSource.Where & " AND (valor_num <= (select convert(decimal,replace(valor,'.','')) from rango_valor where idRango = " &CCGetFromGet("s_valorhasta","")&"))"
end if

'Modifico el orden por valor_num
' propiedades.DataSource.Order = "convert(varchar,len(valor))+replace(valor,'.','')"
propiedades.DataSource.Order = "valor_num"
'response.write propiedades.datasource.sql
' -------------------------
'End Custom Code

End Function 'Close propiedades_DataSource_BeforeBuildSelect @2-54C34B28

'DEL  ' -------------------------
'DEL  'response.write propiedades.datasource.sql
'DEL  ' -------------------------



%>


