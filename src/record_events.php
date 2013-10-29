<?php
//BindEvents Method @1-45D66EA8
function BindEvents()
{
    global $propiedades;
    $propiedades->CCSEvents["BeforeShowRow"] = "propiedades_BeforeShowRow";
    $propiedades->ds->CCSEvents["BeforeBuildSelect"] = "propiedades_ds_BeforeBuildSelect";
}
//End BindEvents Method

//propiedades_BeforeShowRow @2-67E075E3
function propiedades_BeforeShowRow(& $sender)
{
    $propiedades_BeforeShowRow = true;
    $Component = & $sender;
    $Container = & CCGetParentContainer($sender);
    global $propiedades; //Compatibility
//End propiedades_BeforeShowRow

//Gallery Layout @4-6715D311
    $NumberOfColumns = $Component->Attributes->GetText("numberOfColumns");
    if (isset($Component->RowOpenTag))
        $Component->RowOpenTag->Visible = ($Component->RowNumber % $NumberOfColumns) == 1;
    if (isset($Component->AltRowOpenTag))
        $Component->AltRowOpenTag->Visible = ($Component->RowNumber % $NumberOfColumns) == 1;
    if (isset($Component->RowCloseTag))
        $Component->RowCloseTag->Visible = (($Component->RowNumber % $NumberOfColumns) == 0);
    if (isset($Component->AltRowCloseTag))
        $Component->AltRowCloseTag->Visible = (($Component->RowNumber % $NumberOfColumns) == 0);
    if (isset($Component->RowComponents))
        $Component->RowComponents->Visible = !$Component->ForceIteration;
    if (isset($Component->AltRowComponents))
        $Component->AltRowComponents->Visible = !$Component->ForceIteration;
    $Component->ForceIteration = (($Component->RowNumber >= $Component->PageSize) || !$Component->DataSource->has_next_record()) && ($Component->RowNumber % $NumberOfColumns);
//End Gallery Layout

//Custom Code @36-2A29BDB7
// -------------------------
$conn = new clsDBConnection1();
$sql = "SELECT url FROM fotos where id = " . $propiedades->idPropiedad->GetValue();
$conn->query($sql);
$Result = $conn->next_record();
if ($Result) 
	$propiedades->Image1->SetValue($conn->f('url'));
else
	$propiedades->Image1->SetValue("nodisp.jpg");
 /*
 Dim SQL
+Dim rs
+  
+SQL = "SELECT url FROM fotos where id = " & propiedades.DataSource.idPropiedad.Value
+
+Set rs = DBConnection1.Execute(SQL)
+If DBConnection1.Errors.Count = 0 Then
+	if NOT rs.EOF then
+	  propiedades.Image1.Value = rs("url")
+    else
+	  propiedades.Image1.Value = "nodisp.jpg"
+	end if
+	rs.Close
+	set rs = Nothing
+end if
+
+(null)
+SQL = "SELECT descripcion FROM moneda where idMoneda in(select idMoneda from propiedades where idPropiedad = " & propiedades.DataSource.idPropiedad.Value & ")"
+Set rs = DBConnection1.Execute(SQL)
+If DBConnection1.Errors.Count = 0 Then
+	if NOT rs.EOF then
+	  'propiedades.Image1.Value = rs("url")
+	  propiedades.valor.Value = rs("descripcion")& " " &propiedades.valor.Value
+	end if
+	rs.Close
+	set rs = Nothing
+end if
+
+'Si corresponde colocamos "Consulte"
+if propiedades.DataSource.valor_num.Value > 90000 then
+	propiedades.valor.Value = "Consulte"
+	'propiedades.valor.Value = propiedades.DataSource.valor_num.Value
+end if
+' -------------------------
*/
// -------------------------
//End Custom Code

//Close propiedades_BeforeShowRow @2-E06366FE
    return $propiedades_BeforeShowRow;
}
//End Close propiedades_BeforeShowRow

//propiedades_ds_BeforeBuildSelect @2-F1755D4E
function propiedades_ds_BeforeBuildSelect(& $sender)
{
    $propiedades_ds_BeforeBuildSelect = true;
    $Component = & $sender;
    $Container = & CCGetParentContainer($sender);
    global $propiedades; //Compatibility
//End propiedades_ds_BeforeBuildSelect

//Custom Code @56-2A29BDB7
$propiedades->DataSource->Where = 'propiedades.activo = 1';
if (CCGetFromGet('s_idZona','') <> '')
	$propiedades->DataSource->Where .= " AND propiedades.idZona =" .CCGetFromGet('s_idZona','');
if (CCGetFromGet('s_idOperacion','') <> '')
	$propiedades->DataSource->Where .= " AND propiedades.idOperacion =" .CCGetFromGet('s_idOperacion','');
if (CCGetFromGet('s_idTipo','') <> '')
	$propiedades->DataSource->Where .= " AND propiedades.idTipo =" .CCGetFromGet('s_idTipo','');
if (CCGetFromGet('s_dormitorios','') <> '')
	$propiedades->DataSource->Where .= " AND propiedades.dormitorios =" .CCGetFromGet('s_dormitorios','');
if (CCGetFromGet('s_idMoneda','') <> '')
	$propiedades->DataSource->Where .= " AND propiedades.idMoneda =" .CCGetFromGet('s_idMoneda','');
if (CCGetFromGet('s_valor','') <> '' and CCGetFromGet('s_valor','') <> '6')
	$propiedades->DataSource->Where .= " AND (valor_num >= (select convert(decimal,replace(valor,'.','')) from rango_valor where idRango = " .CCGetFromGet('s_valor','')."))";
if (CCGetFromGet('s_valorhasta','') <> '' and CCGetFromGet('s_valorhasta','') <> '6')
	$propiedades->DataSource->Where .= " AND (valor_num <= (select convert(decimal,replace(valor,'.','')) from rango_valor where idRango = " .CCGetFromGet('s_valorhasta','')."))";

//Modifico el orden por valor_num
$propiedades->DataSource->Order = 'valor_num';


/* / -------------------------

+propiedades.DataSource.Where =  "propiedades.activo = 1"
+if CCGetFromGet("s_idZona","") <> empty then
+	propiedades.DataSource.Where = propiedades.DataSource.Where & " AND propiedades.idZona =" &CCGetFromGet("s_idZona","")
+end if
+if CCGetFromGet("s_idOperacion","") <> empty then
+	propiedades.DataSource.Where = propiedades.DataSource.Where & " AND propiedades.idOperacion =" &CCGetFromGet("s_idOperacion","")
+end if
+if CCGetFromGet("s_idTipo","") <> empty then
+	propiedades.DataSource.Where = propiedades.DataSource.Where & " AND propiedades.idTipo =" &CCGetFromGet("s_idTipo","")
+end if
+if CCGetFromGet("s_dormitorios","") <> empty then
+	propiedades.DataSource.Where = propiedades.DataSource.Where & " AND propiedades.dormitorios =" &CCGetFromGet("s_dormitorios","")
+end if
+if CCGetFromGet("s_idMoneda","") <> empty  then
+	propiedades.DataSource.Where = propiedades.DataSource.Where & " AND propiedades.idMoneda = " &CCGetFromGet("s_idMoneda","")
+end if
+'
+(null)
+'
+if (CCGetFromGet("s_valor","") <> empty)  And (CCGetFromGet("s_valor","") <> "6") then
+	'propiedades.DataSource.Where = propiedades.DataSource.Where & " AND ( valor like '%Cons%' OR convert(varchar,len(valor))+replace(valor,'.','') >= (select convert(varchar,len(valor))+replace(valor,'.','') from rango_valor where idRango = " &CCGetFromGet("s_valor","")&"))"
+	propiedades.DataSource.Where = propiedades.DataSource.Where & " AND (valor_num >= (select convert(decimal,replace(valor,'.','')) from rango_valor where idRango = " &CCGetFromGet("s_valor","")&"))"
+end if
+if (CCGetFromGet("s_valorhasta","") <> empty)  And (CCGetFromGet("s_valorhasta","") <> "6") then
+	'propiedades.DataSource.Where = propiedades.DataSource.Where & " AND ( valor like '%Cons%' OR convert(varchar,len(valor))+replace(valor,'.','') <= (select convert(varchar,len(valor))+replace(valor,'.','') from rango_valor where idRango = " &CCGetFromGet("s_valorhasta","")&"))"
+	propiedades.DataSource.Where = propiedades.DataSource.Where & " AND (valor_num <= (select convert(decimal,replace(valor,'.','')) from rango_valor where idRango = " &CCGetFromGet("s_valorhasta","")&"))"
+end if
+
+'Modifico el orden por valor_num
+' propiedades.DataSource.Order = "convert(varchar,len(valor))+replace(valor,'.','')"
+propiedades.DataSource.Order = "valor_num"
+'response.write propiedades.DataSource.Where
+' -------------------------

*/
//End Custom Code

//Close propiedades_ds_BeforeBuildSelect @2-8F90BEC3
    return $propiedades_ds_BeforeBuildSelect;
}
//End Close propiedades_ds_BeforeBuildSelect


?>
