<?php
//BindEvents Method @1-12A59E21
function BindEvents()
{
    global $tipo_propiedad;
    $tipo_propiedad->Navigator->CCSEvents["BeforeShow"] = "tipo_propiedad_Navigator_BeforeShow";
}
//End BindEvents Method

//tipo_propiedad_Navigator_BeforeShow @17-7FB0E68B
function tipo_propiedad_Navigator_BeforeShow(& $sender)
{
    $tipo_propiedad_Navigator_BeforeShow = true;
    $Component = & $sender;
    $Container = & CCGetParentContainer($sender);
    global $tipo_propiedad; //Compatibility
//End tipo_propiedad_Navigator_BeforeShow

//Hide-Show Component @18-0DB41530
    $Parameter1 = $Container->DataSource->PageCount();
    $Parameter2 = 2;
    if (((is_array($Parameter1) || strlen($Parameter1)) && (is_array($Parameter2) || strlen($Parameter2))) && 0 >  CCCompareValues($Parameter1, $Parameter2, ccsInteger))
        $Component->Visible = false;
//End Hide-Show Component

//Close tipo_propiedad_Navigator_BeforeShow @17-9AB805FC
    return $tipo_propiedad_Navigator_BeforeShow;
}
//End Close tipo_propiedad_Navigator_BeforeShow


?>
