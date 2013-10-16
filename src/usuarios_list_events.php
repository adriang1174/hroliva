<?php
//BindEvents Method @1-0864A8AF
function BindEvents()
{
    global $usuarios;
    $usuarios->Navigator->CCSEvents["BeforeShow"] = "usuarios_Navigator_BeforeShow";
}
//End BindEvents Method

//usuarios_Navigator_BeforeShow @18-B4AE346C
function usuarios_Navigator_BeforeShow(& $sender)
{
    $usuarios_Navigator_BeforeShow = true;
    $Component = & $sender;
    $Container = & CCGetParentContainer($sender);
    global $usuarios; //Compatibility
//End usuarios_Navigator_BeforeShow

//Hide-Show Component @19-0DB41530
    $Parameter1 = $Container->DataSource->PageCount();
    $Parameter2 = 2;
    if (((is_array($Parameter1) || strlen($Parameter1)) && (is_array($Parameter2) || strlen($Parameter2))) && 0 >  CCCompareValues($Parameter1, $Parameter2, ccsInteger))
        $Component->Visible = false;
//End Hide-Show Component

//Close usuarios_Navigator_BeforeShow @18-8F8C5B5B
    return $usuarios_Navigator_BeforeShow;
}
//End Close usuarios_Navigator_BeforeShow


?>
