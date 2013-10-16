<%
'BindEvents Method @1-2DEE1598
Sub BindEvents(Level)
    If Level="Page" Then
    Else
        Set fotos.Navigator.CCSEvents("BeforeShow") = GetRef("fotos_Navigator_BeforeShow")
        Set fotos.CCSEvents("BeforeShowRow") = GetRef("fotos_BeforeShowRow")
    End If
End Sub
'End BindEvents Method

Function fotos_Navigator_BeforeShow(Sender) 'fotos_Navigator_BeforeShow @10-7E93F318

'Hide-Show Component @11-5242F942
    Dim TotalPages_11_1 : TotalPages_11_1 = CCSConverter.VBSConvert(ccsInteger, fotos.DataSource.Recordset.PageCount)
    Dim Param2_11_2 : Param2_11_2 = CCSConverter.VBSConvert(ccsInteger, 2)
    If  (Not IsEmpty(TotalPages_11_1) And Not IsEmpty(Param2_11_2) And TotalPages_11_1 < Param2_11_2) Then _
        fotos.Navigator.Visible = False
'End Hide-Show Component

End Function 'Close fotos_Navigator_BeforeShow @10-54C34B28

Function fotos_BeforeShowRow(Sender) 'fotos_BeforeShowRow @2-13E87023

'Gallery Layout @4-BF14602B
    CCManageGalleryPanels fotos, fotos.Attributes("numberOfColumns"), fotos.RowOpenTag, fotos.RowCloseTag, fotos.RowComponents
'End Gallery Layout

End Function 'Close fotos_BeforeShowRow @2-54C34B28


%>
