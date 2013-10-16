<?php
//BindEvents Method @1-7F840D2C
function BindEvents()
{
    global $propiedades;
    $propiedades->Navigator->CCSEvents["BeforeShow"] = "propiedades_Navigator_BeforeShow";
    $propiedades->CCSEvents["BeforeShowRow"] = "propiedades_BeforeShowRow";
}
//End BindEvents Method

//propiedades_Navigator_BeforeShow @39-FEBD95FB
function propiedades_Navigator_BeforeShow(& $sender)
{
    $propiedades_Navigator_BeforeShow = true;
    $Component = & $sender;
    $Container = & CCGetParentContainer($sender);
    global $propiedades; //Compatibility
//End propiedades_Navigator_BeforeShow

//Hide-Show Component @40-0DB41530
    $Parameter1 = $Container->DataSource->PageCount();
    $Parameter2 = 2;
    if (((is_array($Parameter1) || strlen($Parameter1)) && (is_array($Parameter2) || strlen($Parameter2))) && 0 >  CCCompareValues($Parameter1, $Parameter2, ccsInteger))
        $Component->Visible = false;
//End Hide-Show Component

//Close propiedades_Navigator_BeforeShow @39-0FA16ECE
    return $propiedades_Navigator_BeforeShow;
}
//End Close propiedades_Navigator_BeforeShow

//propiedades_BeforeShowRow @6-67E075E3
function propiedades_BeforeShowRow(& $sender)
{
    $propiedades_BeforeShowRow = true;
    $Component = & $sender;
    $Container = & CCGetParentContainer($sender);
    global $propiedades; //Compatibility
//End propiedades_BeforeShowRow

//Custom Code @43-2A29BDB7
// -------------------------
    // Write your own code here.
// -------------------------
//End Custom Code

//Close propiedades_BeforeShowRow @6-E06366FE
    return $propiedades_BeforeShowRow;
}
//End Close propiedades_BeforeShowRow


?>
