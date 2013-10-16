<?php
//BindEvents Method @1-EB1A6894
function BindEvents()
{
    global $fotos;
    $fotos->Navigator->CCSEvents["BeforeShow"] = "fotos_Navigator_BeforeShow";
    $fotos->CCSEvents["BeforeShowRow"] = "fotos_BeforeShowRow";
}
//End BindEvents Method

//fotos_Navigator_BeforeShow @10-DCA2D288
function fotos_Navigator_BeforeShow(& $sender)
{
    $fotos_Navigator_BeforeShow = true;
    $Component = & $sender;
    $Container = & CCGetParentContainer($sender);
    global $fotos; //Compatibility
//End fotos_Navigator_BeforeShow

//Hide-Show Component @11-0DB41530
    $Parameter1 = $Container->DataSource->PageCount();
    $Parameter2 = 2;
    if (((is_array($Parameter1) || strlen($Parameter1)) && (is_array($Parameter2) || strlen($Parameter2))) && 0 >  CCCompareValues($Parameter1, $Parameter2, ccsInteger))
        $Component->Visible = false;
//End Hide-Show Component

//Close fotos_Navigator_BeforeShow @10-E960FA6B
    return $fotos_Navigator_BeforeShow;
}
//End Close fotos_Navigator_BeforeShow

//fotos_BeforeShowRow @2-D07E8881
function fotos_BeforeShowRow(& $sender)
{
    $fotos_BeforeShowRow = true;
    $Component = & $sender;
    $Container = & CCGetParentContainer($sender);
    global $fotos; //Compatibility
//End fotos_BeforeShowRow

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

//Close fotos_BeforeShowRow @2-2DA55B80
    return $fotos_BeforeShowRow;
}
//End Close fotos_BeforeShowRow


?>
