Public Partial Class Seg_usuarios_menu
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub GPermisos_CustomCallback(ByVal sender As System.Object, ByVal e As DevExpress.Web.ASPxGridViewCustomCallbackEventArgs) Handles GPermisos.CustomCallback
        buscar()
    End Sub
    Private Sub Buscar()
        Dim Vmenu As String
        Dim MIDataReader As Oracle.DataAccess.Client.OracleDataReader
        Dim Cerr As Integer = 0
        Dim Merr As String = "OK"
        Dim RowIndice As Integer
        Try
            VconnectionString = ConfigurationManager.ConnectionStrings("AvonConnection").ConnectionString
            dbSQL = New Oracle.DataAccess.Client.OracleConnection
            dbSQL.ConnectionString = VconnectionString
            If Not dbSQL.State = ConnectionState.Open Then
                dbSQL.Open()
            End If
            Dim ComandoConsulta As Oracle.DataAccess.Client.OracleCommand = New Oracle.DataAccess.Client.OracleCommand
            ComandoConsulta.CommandText = "select id_menu from comercial.COM_USUARIOS_PERMISOS where USUARIO = '" & CBUsuarios.Value.ToString.ToUpper & "'"
            ComandoConsulta.Connection = dbSQL

            MIDataReader = ComandoConsulta.ExecuteReader
            'aspxboxlist.Text = "0"
            'GFlow.DataBind()
            GPermisos.Selection.UnselectAll()

            If Not MIDataReader Is Nothing Then
                While MIDataReader.Read
                    Vmenu = MIDataReader.GetValue(0).ToString
                    RowIndice = GPermisos.FindVisibleIndexByKeyValue(Vmenu)

                    GPermisos.Selection.SelectRow(RowIndice)

                    'GFlow.Selection.SelectRowByKey(Val(MIDataReader.GetValue(0).ToString))

                    'GFlow.Selection.SelectRowByKey(Val(MIDataReader.GetValue(0).ToString))

                    'aspxboxlist.Text = aspxboxlist.Text & "," & Varticulo.ToString
                End While
                MIDataReader.Close()
            End If
            ComandoConsulta = Nothing

            'GFlow.Selection.SelectAll()


        Catch ex As Exception
        Finally
            If dbSQL.State = ConnectionState.Open Then
                dbSQL.Close()
            End If

        End Try
    End Sub

    Private Sub Menu_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.MenuItemEventArgs) Handles Menu.ItemClick
        If (e.Item.Name = "BTEXCEL") Then
            Exportar(False, 1)
        ElseIf (e.Item.Name = "BTGUARDAR") Then
            Guardar()
        End If

    End Sub
    Private Sub Exportar(ByVal saveAs As Boolean, ByVal TIPO As Integer)
        Using stream As New IO.MemoryStream()

            Dim contentType As String = "", fileName As String = ""
            Select Case TIPO
                Case 0
                    contentType = "application/pdf"
                    fileName = "Documento.pdf"
                    Exportador.WritePdf(stream)
                Case 1
                    contentType = "application/ms-excel"
                    fileName = "Documento.xls"
                    Exportador.WriteXlsToResponse()
                Case 2
                    contentType = "multipart/related"
                    fileName = "Documento.mht"
                    'Exportador.WriteMht(stream, "utf-8", "ASPxPivotGrid Printing Sample", True)
                Case 3
                    contentType = "text/enriched"
                    fileName = "Documento.rtf"
                    'Exportador.ExportToRtf(stream)
                Case 4
                    contentType = "text/plain"
                    fileName = "Documento.txt"
                    'Exportador.ExportToText(stream)
                Case 5 ' TODO
                    contentType = "text/html"
                    fileName = "PivotGrid.htm"
                    'Exportador.WriteXls(stream, "utf-8", "Documento", True)
            End Select

            Dim buffer() As Byte = stream.GetBuffer()

            Dim disposition As String
            If saveAs Then
                disposition = "attachment"
            Else
                disposition = "inline"
            End If
            Response.Clear()
            Response.Buffer = False
            Response.AppendHeader("Content-Type", contentType)
            Response.AppendHeader("Content-Transfer-Encoding", "binary")
            Response.AppendHeader("Content-Disposition", disposition & "; filename=" & fileName)
            Response.BinaryWrite(buffer)
            Response.End()
        End Using
    End Sub
    Private Sub Guardar()
        Dim PUSuario As String = ""
        Dim Cerr As Integer = 0
        Dim Merr As String = "OK"
        Dim ii As Integer = 0

        Try
            Dim plist As List(Of Object)
            Dim totalVals As New ArrayList
            'plist = GPermisos.GetSelectedFieldValues(New String() {"ID_MENU"})
            plist = GPermisos.GetSelectedFieldValues("ID_MENU")
            EjecutarSelectVista("Delete COM_USUARIOS_PERMISOS where USUARIO = '" & CBUsuarios.Value.ToString.ToUpper & "'")
            For Each item As String In plist
                EjecutarSelectVista("INSERT INTO COM_USUARIOS_PERMISOS (USUARIO, ID_MENU) VALUES ('" & CBUsuarios.Value.ToString.ToUpper & "','" & item & "')")
            Next
            EjecutarSelectVista("INSERT INTO COM_USUARIOS (USUARIO, NOMBRE, ORACLE) VALUES ('" & CBUsuarios.Value.ToString.ToUpper & "','" & CBUsuarios.Value.ToString.ToUpper & "','S')")

        Catch ex As Exception

        End Try
    End Sub
End Class