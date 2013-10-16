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
    // Write your own code here.
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
// -------------------------
    // Write your own code here.
// -------------------------
//End Custom Code

//Close propiedades_ds_BeforeBuildSelect @2-8F90BEC3
    return $propiedades_ds_BeforeBuildSelect;
}
//End Close propiedades_ds_BeforeBuildSelect


?>
