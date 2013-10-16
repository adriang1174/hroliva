<%
'BindEvents Method @1-52BD0A85
Sub BindEvents(Level)
    If Level="Page" Then
    Else
        Set contacto.DataSource.CCSEvents("AfterExecuteInsert") = GetRef("contacto_DataSource_AfterExecuteInsert")
    End If
End Sub
'End BindEvents Method

Function contacto_DataSource_AfterExecuteInsert(Sender) 'contacto_DataSource_AfterExecuteInsert @2-DE5F9234

'Custom Code @9-73254650
' -------------------------
' Write your own code here.
' -------------------------
'End Custom Code

End Function 'Close contacto_DataSource_AfterExecuteInsert @2-54C34B28


%>
