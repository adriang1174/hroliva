<?php
//BindEvents Method @1-397EAC53
function BindEvents()
{
    global $CCSEvents;
    $CCSEvents["AfterInitialize"] = "Page_AfterInitialize";
}
//End BindEvents Method

//Page_AfterInitialize @1-0F3D020A
function Page_AfterInitialize(& $sender)
{
    $Page_AfterInitialize = true;
    $Component = & $sender;
    $Container = & CCGetParentContainer($sender);
    global $attach; //Compatibility
//End Page_AfterInitialize

//Custom Code @30-2A29BDB7
$conn = new clsDBConnection1();
$sql = "DELETE FROM fotos where idFoto = " . CCGetFromGet("del",0);
$conn->query($sql);

/*  / -------------------------
 +Dim SQL
+Dim Connection
+ if CCGetFromGet("del",0) > 0 then 
+   		Set Connection = New clsDBConnection1
+		Connection.Open
+   		SQL = "DELETE FROM fotos where idFoto = " & CCGetFromGet("del",0)
+		Connection.Execute(SQL)
+		'ErrorMessage = CCProcessError(Connection)
+		Connection.Close
+  		Set Connection = Nothing
+ end if

*/
//End Custom Code

//Close Page_AfterInitialize @1-379D319D
    return $Page_AfterInitialize;
}
//End Close Page_AfterInitialize


?>
