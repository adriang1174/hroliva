<?php
//BindEvents Method @1-E89E2C62
function BindEvents()
{
    global $contacto;
    $contacto->ds->CCSEvents["AfterExecuteInsert"] = "contacto_ds_AfterExecuteInsert";
}
//End BindEvents Method

//contacto_ds_AfterExecuteInsert @2-6323B06D
function contacto_ds_AfterExecuteInsert(& $sender)
{
    $contacto_ds_AfterExecuteInsert = true;
    $Component = & $sender;
    $Container = & CCGetParentContainer($sender);
    global $contacto; //Compatibility
//End contacto_ds_AfterExecuteInsert

//Custom Code @9-2A29BDB7
// -------------------------
    // Write your own code here.
// -------------------------
//End Custom Code

//Close contacto_ds_AfterExecuteInsert @2-3CFCD8A7
    return $contacto_ds_AfterExecuteInsert;
}
//End Close contacto_ds_AfterExecuteInsert


?>
