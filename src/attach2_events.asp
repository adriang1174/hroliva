<%
'BindEvents Method @1-C9658ED5
Sub BindEvents(Level)
    If Level="Page" Then
        Set CCSEvents("AfterInitialize") = GetRef("Page_AfterInitialize")
    Else
    End If
End Sub
'End BindEvents Method

Function Page_AfterInitialize(Sender) 'Page_AfterInitialize @1-5C791CCC

'Custom Code @30-73254650
' -------------------------
Dim SQL
Dim Connection
 if CCGetFromGet("del",0) > 0 then 
   		Set Connection = New clsDBConnection1
		Connection.Open
   		SQL = "DELETE FROM fotos where idFoto = " & CCGetFromGet("del",0)
		Connection.Execute(SQL)
		'ErrorMessage = CCProcessError(Connection)
		Connection.Close
  		Set Connection = Nothing
 end if
' -------------------------
'End Custom Code

End Function 'Close Page_AfterInitialize @1-54C34B28


%>
