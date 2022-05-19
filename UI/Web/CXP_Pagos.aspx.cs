using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using DevExpress.Export;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Collections;
using System.IO;
using System.Text;
using System.IO.Compression;
using DevExpress.Utils.Zip;
using DevExpress.Web.Internal;
using DevExpress.Utils;
//using DevExpress.Utils.Compress;

namespace UI.Web
{
    public partial class CXP_Pagos: System.Web.UI.Page
    {

        private string CurrentCiactaID
        {

            get { return Session["CurrentCiactaID"] == null ? String.Empty : Session["CurrentCiactaID"].ToString(); }
            set
            {
                Session["CurrentCiactaID"] = value;
                String[] campos = value.Split(';');
                Session["cov2_cia"] = campos[0];
                Session["cxp12_proveedor"] = campos[1];
                Session["cxp12_documento"] = campos[2];
                Session["cxp12_tipo"] = campos[3];
                

            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["ci_scia2"] = "%";
                Session["CBCia24"] = "CROMSA";
                Session["ci_sfec1"] = DateTime.Today.AddMonths(-1).ToString("dd/MM/yyyy");    //DateTime.Now.ToString("dd/MM/yyyy");
                Session["ci_sfec2"] = DateTime.Now.ToString("dd/MM/yyyy");
                Session["ci_stipo"] = "A";
                SQLCompania.DataBind();

                ((Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Today.AddMonths(-1);
                ((Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Now;
                Session["lista_ci_scia1"] = "ddd ffffff";
            }
        }


        protected void DetailsButton_Load(object sender, EventArgs e)
        {
            ASPxButton btn = sender as ASPxButton;
            GridViewDataItemTemplateContainer container = btn.NamingContainer as GridViewDataItemTemplateContainer;
            string cadenaCiaCtaID = DataBinder.Eval(container.DataItem, "CIA").ToString() + ";" + DataBinder.Eval(container.DataItem, "ORDEN_COMPRA").ToString();
            btn.ClientSideEvents.Click = String.Format("function (s, e) {{ Popup.PerformCallback('{0}'); Popup.Show(); }}", cadenaCiaCtaID);

        }

        protected void DetailsButton_Load2(object sender, EventArgs e)
        {
        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {

            LayoutItem itemFechaInicial = Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem;
            ASPxDateEdit CBFechaInicial = itemFechaInicial.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemFechaFinal = Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem;
            ASPxDateEdit CBFechaFinal = itemFechaFinal.GetNestedControl() as ASPxDateEdit;
          
            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            ASPxComboBox CBCiaOri = itemCiaOri.GetNestedControl() as ASPxComboBox;

            LayoutItem itemcbctaban = Lform.FindItemOrGroupByName("ctaban") as LayoutItem;
            ASPxComboBox CBcbctaban = itemcbctaban.GetNestedControl() as ASPxComboBox;

            if (CBFechaInicial != null)
            {
                if (CBCiaOri.Value != null)
                {
                    Session["CBCia28"] = CBCiaOri.Value != null ? CBCiaOri.Value.ToString() : "XXX;";
                }
                else
                {
                    Session["CBCia28"] = "XXX XXXXXXXXXX";
                }
                Session["ci_sfec1"] = CBFechaInicial.Value != null ? CBFechaInicial.Date.ToString("dd/MM/yyyy") : string.Empty;
                Session["ci_sfec2"] = CBFechaFinal.Value != null ? CBFechaFinal.Date.ToString("dd/MM/yyyy") : string.Empty;
            }

        }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
            /* DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
             PivotCompra.OptionsView.HideAllTotals();
             System.IO.MemoryStream stream = new System.IO.MemoryStream();
             ASPxPivExp1.ExportToXlsx(stream);
             WriteToResponse("ReporteOrdenCompra.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
             PivotCompra.OptionsView.ShowAllTotals(); */
        }

        protected void ExportExcel1_Click(object sender, EventArgs e)
        {

            //ASPxPivotGridExp1.ExportToXlsx("DetalleCtaExp.xlsx");
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //ASPxPivotGridExp1.ExportToXlsx(stream);
            //WriteToResponse("ReporteDetalleCta1.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);

        }

        protected void ExportExcel2_Click(object sender, EventArgs e)
        {
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //ASPxPivotGridExp2.ExportToXlsx(stream);
            //WriteToResponse("ReporteDetalleCta1.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
        }

        protected void WriteToResponse(string fileName, bool saveAsFile, string fileFormat, System.IO.MemoryStream stream)
        {
            if (Page == null || Page.Response == null) return;
            string disposition = saveAsFile ? "attachment" : "inline";
            Response.Clear();
            Response.Buffer = false;
            Response.AppendHeader("Content-Type", string.Format("application/{0}", fileFormat));
            Response.AppendHeader("Content-Transfer-Encoding", "binary");
            Response.AppendHeader("Content-Disposition", string.Format("{0}; filename={1}", disposition, fileName));
            Response.BinaryWrite(stream.ToArray());
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.SuppressContent = true;
            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }


        protected void Popup_WindowCallback(object source, PopupWindowCallbackArgs e)
        {
            CurrentCiactaID = e.Parameter;
            DetailsApply();
        }

        protected void DetailGrid_Init(object sender, EventArgs e)
        {
            DetailsApply();
        }

        private void DetailsApply()
        {
            if (!String.IsNullOrEmpty(CurrentCiactaID))
            {

                String[] campos = CurrentCiactaID.Split(';');

                Session["cov2_cia"] = campos[0];
                Session["cxp12_proveedor"] = campos[1];
                Session["cxp12_documento"] = campos[2];
                Session["cxp12_tipo"] = campos[3];

                SQL_Data_CTA_Detalle1.SelectParameters["PCia1"].DefaultValue = campos[0];
                SQL_Data_CTA_Detalle1.SelectParameters["Pproveedor"].DefaultValue = campos[1];
                SQL_Data_CTA_Detalle1.SelectParameters["PDocumento"].DefaultValue = campos[2];
                SQL_Data_CTA_Detalle1.SelectParameters["Ptipo"].DefaultValue = campos[3];

                SQL_Data_CTA_Detalle1.DataBind();


                SQL_Data_CRE_Linea.SelectParameters["PCia1"].DefaultValue = campos[0];
                SQL_Data_CRE_Linea.SelectParameters["Pproveedor"].DefaultValue = campos[1];

                SQL_Data_CRE_Linea.DataBind();
                ASPxGridView1.DataBind();
                Pmensaje.Text = "";
            }
        }

        protected void Cmbcentrocosto_Callback(object source, CallbackEventArgsBase e)
        {

            if (string.IsNullOrEmpty(e.Parameter)) return;
            Session["CIAS_OC_PRES"] = e.Parameter.ToString();
            SQLDocumentosCxP.DataBind();
            (((Lform.FindItemOrGroupByName("centrocosto") as LayoutItem).GetNestedControl() as ASPxDropDownEdit).FindControl("listBoxcc") as ASPxListBox).DataBind();
        }

        protected void ASPxFormLayout1_E4_Click(object sender, EventArgs e)
        {
         /*   string PERR = "0";
            string PMerr = "ok";
            string PUser;
            PUser = "JMZ";

            EjecutarApruebaOrden(PUser, Session["cov2_cia"].ToString(), Session["cov2_orden_compra"].ToString(), out PERR, out PMerr);

            Pmensaje.Text = PMerr;
            if (PERR.Trim() == "0")
            {
                SQL_Data_CTA_Detalle1.DataBind();
                SQL_Data_OC_Doc_Adjuntos.DataBind();
                SQL_Data_OC_Linea.DataBind();
                ASPxFormLayout1.DataBind();
                SQLCompras.DataBind();
                GridCompras.DataBind();
            }*/
        }

        private void EjecutarApruebaOrden(string PUSUARIO, string PCIA, string PORDEN_COMPRA, out string PERR, out string PMERR)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "ok";

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.[dbo].[PORTAL_OC_APROBAR]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PCIA", PCIA);
                command.Parameters.AddWithValue("@PORDEN_COMPRA", PORDEN_COMPRA);
                command.Parameters.AddWithValue("@PUsuario", PUSUARIO);
                command.Parameters.Add("@PError", SqlDbType.Char, 10);
                command.Parameters["@PError"].Direction = ParameterDirection.Output;
                command.Parameters.Add("@PMerr", SqlDbType.Char, 2000);
                command.Parameters["@PMerr"].Direction = ParameterDirection.Output;
                conn.Open();
                command.ExecuteNonQuery();

                vErr = (string)command.Parameters["@PError"].Value;
                VMerr = (string)command.Parameters["@PMerr"].Value;
            }
            PERR = vErr;
            PMERR = VMerr;
        }

        protected void ASPxFormLayout1_E2_Click(object sender, EventArgs e)
        {
            string PERR = "0";
            string PMerr = "ok";
            string PUser;
            PUser = Session["nombreUsuario"].ToString();

            EjecutarPorAprobarOrden(PUser, Session["cov2_cia"].ToString(), Session["cov2_orden_compra"].ToString(), out PERR, out PMerr);

            Pmensaje.Text = PMerr;
            if (PERR.Trim() == "0")
            {
                SQL_Data_CTA_Detalle1.DataBind();
                SQL_Data_CRE_Linea.DataBind();
                ASPxFormLayout1.DataBind();
                SQLDocumentosCxP.DataBind();
                GridCompras.DataBind();
            }
        }

        private void EjecutarPorAprobarOrden(string PUSUARIO, string PCIA, string PORDEN_COMPRA, out string PERR, out string PMERR)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "ok";

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.[dbo].[PORTAL_OC_PORAPROBAR]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PCIA", PCIA);
                command.Parameters.AddWithValue("@PORDEN_COMPRA", PORDEN_COMPRA);
                command.Parameters.AddWithValue("@PUsuario", PUSUARIO);
                command.Parameters.Add("@PError", SqlDbType.Char, 10);
                command.Parameters["@PError"].Direction = ParameterDirection.Output;
                command.Parameters.Add("@PMerr", SqlDbType.Char, 2000);
                command.Parameters["@PMerr"].Direction = ParameterDirection.Output;
                conn.Open();
                command.ExecuteNonQuery();
                vErr = (string)command.Parameters["@PError"].Value;
                VMerr = (string)command.Parameters["@PMerr"].Value;
            }
            PERR = vErr;
            PMERR = VMerr;
        }

        protected void ASPxFileManager1_FileDownloading(object source, FileManagerFileDownloadingEventArgs e)
        {
            e.InputStream.Position = 0;
            Stream csStream = new GZipStream(e.InputStream, CompressionMode.Decompress);
             e.OutputStream = csStream;
        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            byte[] bytes;
            string fileName, contentType;
            fileName = "Err";
            bytes = new Byte[16 * 1024 - 1]; 
            string VconnectionString;
            string data;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            string strCon = VconnectionString;
            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(strCon))
            {
                con.Open();
                string strcmd = "Select top(1) NOMBRE, convert(varbinary(max), CONTENIDO, 1) CONTENIDO FROM pruebas.cromsa.[DOC_ADJUNTO] D, pruebas.cromsa.orden_compra C  where D.tabla = 'ORDEN_COMPRA' and D.row_id = C.RowPointer and c.orden_compra = 'OC008135'";
                using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(strcmd, con))
                {
                    using (System.Data.SqlClient.SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            fileName = (string)r["NOMBRE"];
                            bytes = (byte[])r["CONTENIDO"];
                            data = Encoding.UTF8.GetString(bytes);        
                        }
                    }
                }
            }

            Response.Clear();
            Response.ContentType = "application/txt";
            Response.AddHeader("Content-Disposition", "attachment; filename=" + fileName);
            Response.AddHeader("Content-Length", bytes.Length.ToString());
            //Response.ContentEncoding = System.Text.Encoding   //System.Text.Encoding.UTF8;
            Response.BinaryWrite(bytes);
            Response.Flush();
            Response.Close();
            Response.End();
        }

        protected void ASPxFormLayout1_E1_Click(object sender, EventArgs e)
        {
        }

        private void EjecutarAplicarDocumento( string PDOCUMENTO, string PTIPO, string PKEYDOC, string PUSUARIO, out string PERR, out string PMERR)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "ok";
            try
            {

                using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.[dbo].[PORTAL_DOCUMENTOS_CPD_APLICAR]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PDocumento", PDOCUMENTO);
                command.Parameters.AddWithValue("@Ptipo", PTIPO);
                command.Parameters.AddWithValue("@PKeydoc", PKEYDOC);
                command.Parameters.AddWithValue("@PUSUARIO", PUSUARIO);
                command.Parameters.Add("@PError", SqlDbType.Char, 10);
                command.Parameters["@PError"].Direction = ParameterDirection.Output;
                command.Parameters.Add("@PMerr", SqlDbType.Char, 2000);
                command.Parameters["@PMerr"].Direction = ParameterDirection.Output;
                conn.Open();
                command.ExecuteNonQuery();
                vErr = (string)command.Parameters["@PError"].Value;
                VMerr = (string)command.Parameters["@PMerr"].Value;
            }

            PERR = vErr;
            PMERR = VMerr;
            }
            catch (Exception ex)
            {
                PERR = "-99";
                PMERR = ex.Message;
            }

        }

        protected void BTAceptar_Click(object sender, EventArgs e)
        {
            string PERR = "0";
            string PMerr = "ok";
            string PUser;
            PUser = Session["nombreUsuario"].ToString();

            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "ok";
            try
                {
                    List<object> plist;
                    ArrayList totalVals = new ArrayList();
                    // plist = GPermisos.GetSelectedFieldValues(New String() {"ID_MENU"})
                    plist = ASPxGridView1.GetSelectedFieldValues("KEYDOC");


                    //EjecutarSelectVista("Delete COM_USUARIOS_PERMISOS where USUARIO = '" + CBUsuarios.Value.ToString.ToUpper + "'");
                    LayoutItem itemDoc = ASPxFormLayout1.FindItemOrGroupByName("DOCUMENTO") as LayoutItem;
                    ASPxTextBox TxDocumento = itemDoc.GetNestedControl() as ASPxTextBox;

                    LayoutItem itemTipo = ASPxFormLayout1.FindItemOrGroupByName("TIPO") as LayoutItem;
                   ASPxTextBox TxTipo = itemTipo.GetNestedControl() as ASPxTextBox;



                foreach (string item in plist)
                {
                    EjecutarAplicarDocumento(TxDocumento.Value.ToString(), TxTipo.Value.ToString(), item, PUser, out PERR, out PMerr);
                    if (PERR.Trim() != "0")
                    {
                        Pmensaje.Text = PMerr;
                        return;
                    }
                }
                //EjecutarSelectVista("INSERT INTO COM_USUARIOS_PERMISOS (USUARIO, ID_MENU) VALUES ('" + CBUsuarios.Value.ToString.ToUpper + "','" + item + "')");
                //EjecutarSelectVista("INSERT INTO COM_USUARIOS (USUARIO, NOMBRE, ORACLE) VALUES ('" + CBUsuarios.Value.ToString.ToUpper + "','" + CBUsuarios.Value.ToString.ToUpper + "','S')");
                Pmensaje.Text = PMerr;
                    if (PERR.Trim() == "0")
                    {
                       SQL_Data_CTA_Detalle1.DataBind();
                       SQL_Data_CRE_Linea.DataBind();
                        ASPxFormLayout1.DataBind();
                       SQLDocumentosCxP.DataBind();
                       GridCompras.DataBind();
                    ASPxGridView1.DataBind();

                }


            }
            catch (Exception ex)
                {
                }
       

        }

        protected void ASPxButton2_Click1(object sender, EventArgs e)
        {
            string PERR = "0";
            string PMerr = "ok";
            string PUser;
            PUser = Session["nombreUsuario"].ToString();

            EjecutarApruebaOrden(PUser, Session["cov2_cia"].ToString(), Session["cov2_orden_compra"].ToString(), out PERR, out PMerr);

            Pmensaje.Text = PMerr;
            if (PERR.Trim() == "0")
            {
                SQL_Data_CTA_Detalle1.DataBind();
                SQL_Data_CRE_Linea.DataBind();
                ASPxFormLayout1.DataBind();
                SQLDocumentosCxP.DataBind();
                GridCompras.DataBind();
            }
        }

        protected void ASPxButton4_Click(object sender, EventArgs e)
        {
            string PERR = "0";
            string PMerr = "ok";
            string PUser;
            PUser = Session["nombreUsuario"].ToString();
            Pmensaje.Text = PMerr;
            if (PERR.Trim() == "0")
            {
                SQL_Data_CTA_Detalle1.DataBind();
                SQL_Data_CRE_Linea.DataBind();
                ASPxFormLayout1.DataBind();
                SQLDocumentosCxP.DataBind();
                GridCompras.DataBind();
            }
        }

        protected void CBListaAbuelo_Callback(object sender, CallbackEventArgsBase e)
        {
            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
            ASPxComboBox CBUsuarios = itemCiaOri.GetNestedControl() as ASPxComboBox;
            string text = e.Parameter;
            Session["CBCia24"] = CBUsuarios.Value != null ? CBUsuarios.Value.ToString() : "";
            Session["PAdicional241"] = text;
            DS_Proveedor.DataBind();
            CBListaAbuelo.JSProperties["cpText"] = text;
        }

        protected void CBListaPadre_Callback(object sender, CallbackEventArgsBase e)
        {
            string text = e.Parameter;
            string abulocod;
            string pCIA = Session["CBCia24"].ToString();
            Session["PAbuelo24"] = text;
            Session["PAdicional242"] = "";
            DS_CentrosCostoLista2.DataBind();
            CBListaPadre.DataBind();
            CBListaPadre.JSProperties["cpTextcbp"] = "";
        }

        protected void cb_cta_banc_Callback(object sender, CallbackEventArgsBase e)
        {
            string PCia = e.Parameter;
            Session["CBCia28"] = PCia != null ? PCia : "XXX";
            DS_CuentaBanco_CB.SelectParameters["PCia1"].DefaultValue = PCia;
            DS_CuentaBanco_CB.DataBind();

            LayoutItem itemcbctaban = Lform.FindItemOrGroupByName("ctaban") as LayoutItem;
            ASPxComboBox CBcbctaban = itemcbctaban.GetNestedControl() as ASPxComboBox;

            CBcbctaban.DataBind();
        }

        protected void Lform_E7_Click(object sender, EventArgs e)
        {
            generarDocumentosTEF();
        }

        private void generarDocumentosTEF()
        {
            string listaEmpresas;
            listaEmpresas = "";
            string nombreEmpresaArchivo = "";
            string pais = "";
            string NroTEF = "";
            string monedaCuenta = "";
            string empresaCuenta = "";
            string VconnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            try
            {
                if (ValidarRegistrosSeleccionados())
                {
                    /*Si existen registros seleccionados*/
                    /*Se valida que se haya seleccionado una cuenta de banco*/
                    if (ValidarCuentaBanco())
                    {
                        /*Si existe una cuenta de banco selecionada*/
                        /*Validar que se haya colocado el valor del número */
                        if (ValidarCuentaNumeroDocumento())
                        {
                            if (ValidarNumeroEnvio())
                            {
                                List<object> plist;
                                plist = GridCompras.GetSelectedFieldValues("KEYDOC");
                                /*Se obtiene todas las empresas distintas que han sido seleccionadas*/
                                int contador = 0;
                                foreach (string item in plist)
                                {
                                    string[] valores = item.Split(';');
                                    bool existe = false;
                                    existe = listaEmpresas.Contains(valores[0]);
                                    if (!existe)
                                    {
                                        if (contador == 0)
                                        {
                                            listaEmpresas = valores[0];
                                            contador = 1;
                                        }
                                        else
                                        {
                                            listaEmpresas = listaEmpresas + ";" + valores[0];
                                        }
                                    }
                                }

                                string[] empresas = listaEmpresas.Split(';');
                                foreach (string empresa in empresas)
                                {
                                    SqlConnection dbSQL = new SqlConnection(VconnectionString);
                                    SqlCommand cmd = new SqlCommand();
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    cmd.CommandText = "PORTAL.dbo.VALIDAR_PERMISO_GENERAR_TEF";
                                    cmd.Connection = dbSQL;
                                    nombreEmpresaArchivo = empresa;
                                    empresaCuenta = empresa;
                                    cmd.Parameters.AddWithValue("@PCia", empresa);
                                    cmd.Parameters.AddWithValue("@PUsuario", Session["nombreUsuario"].ToString());
                                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                                    DataTable dt = new DataTable();
                                    sda.Fill(dt);
                                    if (dt.Rows.Count == 0)
                                    {
                                        lblMensaje.Text = "El usuario no cuenta con permiso a la empresa " + empresa + " para poder realizar la generación de los TEFs.";
                                        PValidacion.ShowOnPageLoad = true;
                                        return;
                                    }

                                    /*Validar si la empresa pertenece a Nicaragua, Panamá o Costa Rica*/
                                    SqlConnection dbSQL4 = new SqlConnection(VconnectionString);
                                    SqlCommand cmd4 = new SqlCommand();
                                    cmd4.CommandType = CommandType.StoredProcedure;
                                    cmd4.CommandText = "PORTAL.dbo.PORTAL_OBTENER_PAIS_EMPRESA";
                                    cmd4.Connection = dbSQL4;
                                    cmd4.Parameters.AddWithValue("@PCia", empresa);
                                    SqlDataAdapter sda4 = new SqlDataAdapter(cmd4);
                                    DataTable dt4 = new DataTable();
                                    sda4.Fill(dt4);
                                    if (dt4.Rows.Count == 0)
                                    {
                                        lblMensaje.Text = "No se encuentra la empresa, no se puede continuar con el proceso. ";
                                        PValidacion.ShowOnPageLoad = true;
                                        return;
                                    }
                                    else
                                    {
                                        pais = dt4.Rows[0].ItemArray[0].ToString().ToUpper();
                                        if (pais.Equals("NICARAGUA") || pais.Equals("COSTA RICA") || pais.Equals("PANAMA"))
                                        {

                                        }
                                        else
                                        {
                                            lblMensaje.Text = "El proceso no puede ejecutarse, ya que el proceso solo es aplicable a Empresas de Nicaragua, Costa Rica o Panama y la empresa " + empresa + " no pertenece a ninguno de esos paises.";
                                            PValidacion.ShowOnPageLoad = true;
                                            return;
                                        }
                                    }
                                }

                                /*Obtener Moneda de la Cuenta a Pagar*/
                                LayoutItem itemcbctaban2 = Lform.FindItemOrGroupByName("ctaban") as LayoutItem;
                                ASPxComboBox CBcbctaban2 = itemcbctaban2.GetNestedControl() as ASPxComboBox;
                                monedaCuenta = ObtenerMonedaCuenta(empresaCuenta, CBcbctaban2.Value.ToString());
                                foreach (string item3 in plist)
                                {
                                    string[] valores3 = item3.Split(';');
                                    string proveedor3 = valores3[1].ToString();
                                    string moneda3 = valores3[4].ToString();
                                    /*Se verifica que la moneda de la cuenta sea igual a la de los registros seleccionados*/
                                    if (monedaCuenta.Trim().ToString().Equals(moneda3.Trim().ToString()))
                                    {

                                    }
                                    else
                                    {
                                        lblMensaje.Text = "El tipo de moneda de los registros seleccionados no coincide con el tipo de moneda de la Cuenta Bancaria.";
                                        PValidacion.ShowOnPageLoad = true;
                                        return;
                                    }

                                    string resultado = ObtenerProveedorCuenta(empresaCuenta, proveedor3, moneda3);
                                    if (resultado.Equals("1"))
                                    {

                                    }
                                    else
                                    {
                                        lblMensaje.Text = "El proveedor " + proveedor3 + " no tiene una cuenta bancaria con la moneda " + moneda3 + ", registrele una cuenta para poder continuar.";
                                        PValidacion.ShowOnPageLoad = true;
                                        return;
                                    }
                                }

                                /*Se elimina datos previos de la tabla temporal */
                                eliminarTablaTemporal();
                                /*Se procede a consolidar los montos de facturas de los proveedores con la misma moneda*/
                                foreach (string item2 in plist)
                                {
                                    string[] valores = item2.Split(';');
                                    string compania = valores[0].ToString();
                                    string proveedor = valores[1].ToString();
                                    string documento = valores[2].ToString();
                                    string tipo = valores[3].ToString();
                                    string moneda = valores[4].ToString();
                                    string monto = valores[5].ToString();

                                    SqlConnection dbSQL = new SqlConnection(VconnectionString);
                                    dbSQL.Open();
                                    SqlCommand cmd = new SqlCommand();
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    cmd.CommandText = "PORTAL.dbo.PORTAL_CONSOLIDAR_TEF_PREVIO";
                                    cmd.Connection = dbSQL;
                                    cmd.Parameters.AddWithValue("@PCia", compania);
                                    cmd.Parameters.AddWithValue("@PProveedor", proveedor);
                                    cmd.Parameters.AddWithValue("@PMoneda", moneda);
                                    cmd.Parameters.AddWithValue("@PMonto", monto);
                                    cmd.Parameters.AddWithValue("@PUsuario", Session["nombreUsuario"].ToString());
                                    cmd.ExecuteNonQuery();
                                    dbSQL.Close();
                                }

                                /*Se valida que existan los proveedores en el esquema*/
                                DataTable dtPendientes = obtenerConsolidadoPagosPendientes();
                                string nombresProveedor = "";
                                string contribuyente = "";
                                string codEmpresa = "";
                                int i = 0;
                                foreach (DataRow fila in dtPendientes.Rows)
                                {
                                    codEmpresa = fila.ItemArray[0].ToString();
                                    string codProveedor = fila.ItemArray[1].ToString();
                                    SqlConnection dbSQL8 = new SqlConnection(VconnectionString);
                                    SqlCommand cmd8 = new SqlCommand();
                                    cmd8.CommandType = CommandType.StoredProcedure;
                                    cmd8.CommandText = "PORTAL.dbo.PORTAL_GET_PROVEEDOR_EMPRESA";
                                    cmd8.Connection = dbSQL8;
                                    cmd8.Parameters.AddWithValue("@PCia", codEmpresa);
                                    cmd8.Parameters.AddWithValue("@PProveedor", codProveedor);
                                    SqlDataAdapter sda8 = new SqlDataAdapter(cmd8);
                                    DataTable dt8 = new DataTable();
                                    sda8.Fill(dt8);
                                    if (dt8.Rows.Count == 0)
                                    {
                                        lblMensaje.Text = "El proveedor no existe en la empresa.";
                                        PValidacion.ShowOnPageLoad = true;
                                        return;
                                    }
                                    else
                                    {
                                        if (i == 0)
                                        {
                                            nombresProveedor = dt8.Rows[0].ItemArray[1].ToString();
                                        }
                                        else
                                        {
                                            nombresProveedor = nombresProveedor + ", " + dt8.Rows[0].ItemArray[1].ToString();
                                        }
                                        contribuyente = dt8.Rows[0].ItemArray[2].ToString();
                                        i = i + 1;
                                    }
                                }

                                /*Se procede a generar el Asiento del TEF conjuntamente con el Movimiento del Banco*/
                                decimal montoTotal = 0;
                                foreach (DataRow fila in dtPendientes.Rows)
                                {
                                    montoTotal = montoTotal + decimal.Parse(fila.ItemArray[3].ToString());
                                }

                                string asientoGeneral = "";
                                LayoutItem itemcbctaban1 = Lform.FindItemOrGroupByName("ctaban") as LayoutItem;
                                ASPxComboBox CBcbctaban1 = itemcbctaban1.GetNestedControl() as ASPxComboBox;
                                string nroCuentaBanco = CBcbctaban1.Value.ToString();

                                LayoutItem itemnrodoc1 = Lform.FindItemOrGroupByName("numplan") as LayoutItem;
                                ASPxTextBox CBnrodoc1 = itemnrodoc1.GetNestedControl() as ASPxTextBox;
                                string NroDocumentoTEF = CBnrodoc1.Value.ToString();
                                NroDocumentoTEF = NroDocumentoTEF.PadLeft(4, '0');

                                LayoutItem itemnrodoc2 = Lform.FindItemOrGroupByName("numenvio") as LayoutItem;
                                ASPxTextBox CBnrodoc2 = itemnrodoc2.GetNestedControl() as ASPxTextBox;
                                string NroDocumentoTEF2 = CBnrodoc2.Value.ToString();
                                NroDocumentoTEF2 = NroDocumentoTEF2.PadLeft(5, '0');

                                NroDocumentoTEF = NroDocumentoTEF + NroDocumentoTEF2;

                                /*Generamos el asiento General y Mov Bancos*/
                                SqlConnection dbSQLA = new SqlConnection(VconnectionString);
                                dbSQLA.Open();
                                SqlCommand cmdA = new SqlCommand();
                                cmdA.CommandType = CommandType.StoredProcedure;
                                cmdA.CommandText = "PORTAL.dbo.PORTAL_TEF_CABECERA_ASIENTO";
                                cmdA.Connection = dbSQLA;
                                cmdA.Parameters.AddWithValue("@PCia", codEmpresa);
                                cmdA.Parameters.AddWithValue("@PMONEDA", monedaCuenta);
                                cmdA.Parameters.AddWithValue("@PMONTO", montoTotal.ToString());
                                cmdA.Parameters.AddWithValue("@PCUENTA_BANCO", nroCuentaBanco);
                                cmdA.Parameters.AddWithValue("@PNUMERO", NroDocumentoTEF);
                                cmdA.Parameters.AddWithValue("@PREFERENCIA", nombresProveedor);
                                cmdA.Parameters.AddWithValue("@PCONTRIBUYENTE", contribuyente);
                                cmdA.Parameters.AddWithValue("@PUsuario", Session["nombreUsuario"].ToString());
                                cmdA.Parameters.Add("@PError", SqlDbType.Char, 10);
                                cmdA.Parameters["@PError"].Direction = ParameterDirection.Output;
                                cmdA.Parameters.Add("@PMerr", SqlDbType.Char, 2000);
                                cmdA.Parameters["@PMerr"].Direction = ParameterDirection.Output;
                                cmdA.ExecuteNonQuery();
                                string vErr;
                                vErr = (string)cmdA.Parameters["@PError"].Value;
                                if (!vErr.Trim().ToString().Equals("0"))
                                {
                                    lblMensaje.Text = "Ocurrió un error al registrar el Asiento TEF, no se completo el proceso.";
                                    PValidacion.ShowOnPageLoad = true;
                                    return;
                                }
                                asientoGeneral = (string)cmdA.Parameters["@PMerr"].Value;
                                dbSQLA.Close();


                                /*Se procede a generar el archivo TEF para cada línea de la tabla temporal*/
                                dtPendientes = obtenerConsolidadoPagosPendientes();
                                int consecutivo = 1;
                                foreach (DataRow item in dtPendientes.Rows)
                                {
                                    string nombreEmpresa = item.ItemArray[0].ToString();
                                    string proveedor = item.ItemArray[1].ToString();
                                    string moneda = item.ItemArray[2].ToString();
                                    string monto = item.ItemArray[3].ToString();

                                    LayoutItem itemnrodoc = Lform.FindItemOrGroupByName("numplan") as LayoutItem;
                                    ASPxTextBox CBnrodoc = itemnrodoc.GetNestedControl() as ASPxTextBox;
                                    string NroDocumento = CBnrodoc.Value.ToString();
                                    NroDocumento = NroDocumento.PadLeft(4, '0');

                                    LayoutItem itemcbctaban = Lform.FindItemOrGroupByName("ctaban") as LayoutItem;
                                    ASPxComboBox CBcbctaban = itemcbctaban.GetNestedControl() as ASPxComboBox;
                                    string nroCuenta = CBcbctaban.Value.ToString();

                                    LayoutItem itemnrodoc6 = Lform.FindItemOrGroupByName("numenvio") as LayoutItem;
                                    ASPxTextBox CBnrodoc6 = itemnrodoc6.GetNestedControl() as ASPxTextBox;
                                    string NroDocumentoTEF6 = CBnrodoc6.Value.ToString();
                                    NroDocumentoTEF6 = NroDocumentoTEF6.PadLeft(5, '0');

                                    NroDocumento = NroDocumento + NroDocumentoTEF6;

                                    SqlConnection dbSQL = new SqlConnection(VconnectionString);
                                    dbSQL.Open();
                                    SqlCommand cmd = new SqlCommand();
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    //cmd.CommandText = "PORTAL.dbo.PORTAL_TEF_CREAR";
                                    cmd.CommandText = "PORTAL.dbo.PORTAL_DETALLE_TEF_CREAR";
                                    cmd.Connection = dbSQL;
                                    cmd.Parameters.AddWithValue("@PCia", nombreEmpresa);
                                    cmd.Parameters.AddWithValue("@PPROVEEDOR", proveedor);
                                    cmd.Parameters.AddWithValue("@PCUENTA_BANCO", nroCuenta);
                                    cmd.Parameters.AddWithValue("@PMONEDA", moneda);
                                    cmd.Parameters.AddWithValue("@PCONSECUTIVO", consecutivo);
                                    cmd.Parameters.AddWithValue("@PASIENTO", asientoGeneral);
                                    cmd.Parameters.AddWithValue("@PNUMERO", NroDocumento);
                                    cmd.Parameters.AddWithValue("@PAPLICACION", "Pago al proveedor : " + proveedor);
                                    cmd.Parameters.AddWithValue("@PMONTO", monto);
                                    cmd.Parameters.AddWithValue("@PUsuario", Session["nombreUsuario"].ToString());
                                    cmd.Parameters.Add("@PError", SqlDbType.Char, 10);
                                    cmd.Parameters["@PError"].Direction = ParameterDirection.Output;
                                    cmd.Parameters.Add("@PMerr", SqlDbType.Char, 2000);
                                    cmd.Parameters["@PMerr"].Direction = ParameterDirection.Output;
                                    cmd.ExecuteNonQuery();
                                    string vErr2;
                                    string VMerr;
                                    vErr2 = (string)cmd.Parameters["@PError"].Value;
                                    VMerr = (string)cmd.Parameters["@PMerr"].Value;

                                    dbSQL.Close();
                                    consecutivo = consecutivo + 2;
                                }

                                /*Se realiza la aplicación de los créditos con el TEF creado*/
                                LayoutItem itemnrodoc3 = Lform.FindItemOrGroupByName("numplan") as LayoutItem;
                                ASPxTextBox CBnrodoc3 = itemnrodoc3.GetNestedControl() as ASPxTextBox;
                                string NroDocumento3 = CBnrodoc3.Value.ToString();
                                NroDocumento3 = NroDocumento3.PadLeft(4, '0');

                                LayoutItem itemnrodoc7 = Lform.FindItemOrGroupByName("numenvio") as LayoutItem;
                                ASPxTextBox CBnrodoc7 = itemnrodoc7.GetNestedControl() as ASPxTextBox;
                                string NroDocumentoTEF7 = CBnrodoc7.Value.ToString();
                                NroDocumentoTEF7 = NroDocumentoTEF7.PadLeft(5, '0');

                                NroDocumento3 = NroDocumento3 + NroDocumentoTEF7;

                                foreach (string item2 in plist)
                                {
                                    string[] valores = item2.Split(';');
                                    string compania = valores[0].ToString();
                                    string proveedor2 = valores[1].ToString();
                                    string documento = valores[2].ToString();
                                    string tipo = valores[3].ToString();
                                    string moneda2 = valores[4].ToString();
                                    string monto2 = valores[5].ToString();
                                    string tipoCambio = valores[6].ToString();

                                    //if (compania.Trim().ToString().Equals(nombreEmpresa.Trim().ToString()) && proveedor2.Trim().ToString().Equals(proveedor.Trim().ToString()) & moneda.Trim().ToString().Equals(moneda2.Trim().ToString()))
                                    //{
                                    string keyDoc = compania + ";" + proveedor2 + ";" + documento + ";" + tipo;
                                    //string keyDoc = compania + ";" + proveedor2 + ";" + NroDocumento + ";" + "TEF";
                                    /*Se realiza la aplicación de los documentos*/
                                    string VconnectionString2;
                                    VconnectionString2 = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
                                    SqlConnection dbSQL2 = new SqlConnection(VconnectionString);
                                    dbSQL2.Open();
                                    SqlCommand cmd2 = new SqlCommand();
                                    cmd2.CommandType = CommandType.StoredProcedure;
                                    cmd2.CommandText = "PORTAL.dbo.PORTAL_DOCUMENTOS_CPD_APLICAR";
                                    cmd2.Connection = dbSQL2;
                                    cmd2.Parameters.AddWithValue("@PDocumento", NroDocumento3);
                                    //cmd2.Parameters.AddWithValue("@PDocumento", documento);
                                    //cmd2.Parameters.AddWithValue("@Ptipo", tipo);
                                    cmd2.Parameters.AddWithValue("@Ptipo", "TEF");
                                    cmd2.Parameters.AddWithValue("@PKeydoc", keyDoc);
                                    cmd2.Parameters.AddWithValue("@PUSUARIO", Session["nombreUsuario"].ToString());
                                    cmd2.Parameters.AddWithValue("@PTIPO_CAMBIO_APLICAR", tipoCambio);
                                    cmd2.Parameters.Add("@PError", SqlDbType.Char, 10);
                                    cmd2.Parameters["@PError"].Direction = ParameterDirection.Output;
                                    cmd2.Parameters.Add("@PMerr", SqlDbType.Char, 2000);
                                    cmd2.Parameters["@PMerr"].Direction = ParameterDirection.Output;
                                    cmd2.ExecuteNonQuery();
                                    string vErr3;
                                    string VMerr2;
                                    vErr3 = (string)cmd2.Parameters["@PError"].Value;
                                    VMerr2 = (string)cmd2.Parameters["@PMerr"].Value;
                                    dbSQL2.Close();
                                    // }
                                }


                                /*Generamos el asiento General y Mov Bancos*/
                                SqlConnection dbSQLB = new SqlConnection(VconnectionString);
                                dbSQLB.Open();
                                SqlCommand cmdB = new SqlCommand();
                                cmdB.CommandType = CommandType.StoredProcedure;
                                cmdB.CommandText = "PORTAL.dbo.PORTAL_ACTUALIZAR_TEF";
                                cmdB.Connection = dbSQLB;
                                cmdB.Parameters.AddWithValue("@PCia", codEmpresa);
                                cmdB.Parameters.AddWithValue("@PAsiento", asientoGeneral);
                                cmdB.Parameters.AddWithValue("@PUsuario", Session["nombreUsuario"].ToString());
                                cmdB.Parameters.Add("@PError", SqlDbType.Char, 10);
                                cmdB.Parameters["@PError"].Direction = ParameterDirection.Output;
                                cmdB.Parameters.Add("@PMerr", SqlDbType.Char, 2000);
                                cmdB.Parameters["@PMerr"].Direction = ParameterDirection.Output;
                                cmdB.ExecuteNonQuery();
                                string vErr4;
                                string vMess4;
                                vErr4 = (string)cmdA.Parameters["@PError"].Value;
                                vMess4 = (string)cmdA.Parameters["@PMerr"].Value;
                                dbSQLB.Close();

                                /*Se genera el archivo de texto y se realiza la descarga*/
                                LayoutItem itemnrodoc9 = Lform.FindItemOrGroupByName("numplan") as LayoutItem;
                                ASPxTextBox CBnrodoc9 = itemnrodoc9.GetNestedControl() as ASPxTextBox;
                                NroTEF = CBnrodoc9.Value.ToString();
                                NroTEF = NroTEF.PadLeft(4, '0');

                                LayoutItem itemnrodoc10 = Lform.FindItemOrGroupByName("numenvio") as LayoutItem;
                                ASPxTextBox CBnrodoc10 = itemnrodoc10.GetNestedControl() as ASPxTextBox;
                                string NroDocumentoTEF10 = CBnrodoc10.Value.ToString();
                                NroDocumentoTEF10 = NroDocumentoTEF10.PadLeft(5, '0');


                                DataTable dtLineas = obtenerLineasTEF(codEmpresa, "TEF", NroTEF + NroDocumentoTEF10, pais,NroTEF, NroDocumentoTEF10);
                                Response.ContentEncoding = System.Text.Encoding.UTF8;
                                string fileName = string.Format("{0}{1}", System.IO.Path.GetTempPath(), pais + "_" + nombreEmpresaArchivo + ".txt");
                                //using (System.IO.StreamWriter writer = new System.IO.StreamWriter(fileName, false, Response.ContentEncoding))
                                using (System.IO.StreamWriter writer = new System.IO.StreamWriter(fileName,false,Encoding.Default))
                                {
                                    foreach (DataRow item in dtLineas.Rows)
                                    {
                                        string linea = item.ItemArray[0].ToString().Replace("XXXX", NroTEF);
                                        linea = linea.Replace("YYYYY", NroDocumentoTEF10);
                                        //writer.WriteLine(item.ItemArray[0].ToString().Replace("XXXX",NroTEF).Replace("YYYYY",NroDocumentoTEF10));
                                        writer.WriteLine(linea);
                                    }
                                } //Important! writer.Dispose is called automatically here

                                Response.Clear();
                                Response.AddHeader("content-disposition", "attachment; filename=" + pais + "_" + nombreEmpresaArchivo + ".txt");
                                Response.ContentType = "text/plain";
                                Response.Charset = "utf-8";
                                Response.WriteFile(fileName);
                                Response.End();
                                // and think about doing this, sooner or later:
                                System.IO.File.Delete(fileName);


                                /************************************************/
                                LayoutItem itemFechaInicial = Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem;
                                ASPxDateEdit CBFechaInicial = itemFechaInicial.GetNestedControl() as ASPxDateEdit;

                                LayoutItem itemFechaFinal = Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem;
                                ASPxDateEdit CBFechaFinal = itemFechaFinal.GetNestedControl() as ASPxDateEdit;

                                LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
                                ASPxComboBox CBCiaOri = itemCiaOri.GetNestedControl() as ASPxComboBox;

                                LayoutItem itemcbctaban9 = Lform.FindItemOrGroupByName("ctaban") as LayoutItem;
                                ASPxComboBox CBcbctaban9 = itemcbctaban9.GetNestedControl() as ASPxComboBox;

                                if (CBFechaInicial != null)
                                {
                                    if (CBCiaOri.Value != null)
                                    {
                                        Session["CBCia28"] = CBCiaOri.Value != null ? CBCiaOri.Value.ToString() : "XXX;";
                                    }
                                    else
                                    {
                                        Session["CBCia28"] = "XXX XXXXXXXXXX";
                                    }
                                    Session["ci_sfec1"] = CBFechaInicial.Value != null ? CBFechaInicial.Date.ToString("dd/MM/yyyy") : string.Empty;
                                    Session["ci_sfec2"] = CBFechaFinal.Value != null ? CBFechaFinal.Date.ToString("dd/MM/yyyy") : string.Empty;
                                }
                                SQLDocumentosCxP.DataBind();
                                GridCompras.DataBind();

                                txtEnvio.Text = "";
                                Lform_E4.Text = "";
                                /********************************************/
                                
                                eliminarTablaTemporal();
                            }
                            else
                            {
                                lblMensaje.Text = "Tiene que ingresar el numero de Envio, por favor validar.";
                                PValidacion.ShowOnPageLoad = true;
                                return;
                            }
                        }
                        else
                        {
                            lblMensaje.Text = "Tiene que ingresar el código de Num Plan, por favor validar.";
                            PValidacion.ShowOnPageLoad = true;
                            return;
                        }
                    }
                    else
                    {
                        lblMensaje.Text = "No existen una cuenta de banco seleccionada, por favor validar.";
                        PValidacion.ShowOnPageLoad = true;
                        return;
                    }
                }
                else
                {
                    /*No existen registros seleccionados*/
                    lblMensaje.Text = "No existen registros seleccionados, por favor, validar.";
                    PValidacion.ShowOnPageLoad = true;
                    return;
                }
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
                //throw;
            }
        }


        private string ObtenerMonedaCuenta(string cia, string cuenta)
        {
            string VconnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            try
            {
                SqlConnection dbSQL = new SqlConnection(VconnectionString);
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "PORTAL.dbo.PORTAL_OBTENER_MONEDA_CUENTA";
                cmd.Connection = dbSQL;
                cmd.Parameters.AddWithValue("@pesquema", cia);
                cmd.Parameters.AddWithValue("@pcuenta", cuenta);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                System.Data.DataTable dt = new System.Data.DataTable();
                sda.Fill(dt);
                string resultado = dt.Rows[0].ItemArray[0].ToString();
                return resultado;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return "";
            }
        }

        private string ObtenerProveedorCuenta(string cia, string proveedor, string moneda)
        {
            string VconnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            try
            {
                SqlConnection dbSQL = new SqlConnection(VconnectionString);
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "PORTAL.dbo.PORTAL_OBTENER_PROVEEDOR_CUENTA_MONEDA";
                cmd.Connection = dbSQL;
                cmd.Parameters.AddWithValue("@pesquema", cia);
                cmd.Parameters.AddWithValue("@pproveedor", proveedor);
                cmd.Parameters.AddWithValue("@pmoneda", moneda);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                System.Data.DataTable dt = new System.Data.DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count==0)
                {
                    return "0";
                }
                else
                {
                    return "1";
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return "";
            }
        }

        private void eliminarTablaTemporal()
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            SqlConnection dbSQL = new SqlConnection(VconnectionString);
            try
            {
                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();

                string sentencia = "";
                sentencia = "DELETE FROM PORTAL.dbo.TMP_PROCESAR_TEF WHERE UPPER(USUARIO_PROCESO)=UPPER('" + Session["nombreUsuario"].ToString() + "');";
                SqlCommand ComandoConsulta = new SqlCommand();
                ComandoConsulta.CommandText = sentencia;
                ComandoConsulta.Connection = dbSQL;
                ComandoConsulta.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
            }
            finally
            {
                if (dbSQL.State == ConnectionState.Open)
                    dbSQL.Close();
            }
        }

        private bool ValidarRegistrosSeleccionados()
        {
            List<object> plist;
            try
            {
                /*Verificamos que existe alguna empresa seleccionada*/
                plist = GridCompras.GetSelectedFieldValues("KEYDOC");
                int contador = 0;
                foreach (string item in plist)
                {
                    contador = contador + 1;
                }
                if (contador==0)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
                return false;
            }
        }

        private bool ValidarCuentaBanco()
        {
            try
            {
                LayoutItem itemcbctaban = Lform.FindItemOrGroupByName("ctaban") as LayoutItem;
                ASPxComboBox CBcbctaban = itemcbctaban.GetNestedControl() as ASPxComboBox;

                if (CBcbctaban.Value != null)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
                return false;
            }
        }

        private bool ValidarCuentaNumeroDocumento()
        {
            try
            {
                LayoutItem itemnrodoc = Lform.FindItemOrGroupByName("numplan") as LayoutItem;
                ASPxTextBox CBnrodoc = itemnrodoc.GetNestedControl() as ASPxTextBox;

                if (CBnrodoc.Value != null)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
                return false;
            }
        }

        private bool ValidarNumeroEnvio()
        {
            try
            {
                LayoutItem itemnrodoc = Lform.FindItemOrGroupByName("numenvio") as LayoutItem;
                ASPxTextBox CBnrodoc = itemnrodoc.GetNestedControl() as ASPxTextBox;

                if (CBnrodoc.Value != null)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
                return false;
            }
        }

        private DataTable obtenerConsolidadoPagosPendientes()
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            String VSQL;
            VSQL = "SELECT COMPANIA,PROVEEDOR,MONEDA,MONTO,USUARIO_PROCESO FROM PORTAL.dbo.TMP_PROCESAR_TEF WHERE UPPER(USUARIO_PROCESO)=UPPER('" + Session["nombreUsuario"].ToString() + "');";
            SqlConnection conn = new SqlConnection(VconnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = VSQL;
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            return ds.Tables[0];
        }

        private DataTable obtenerLineasTEF(string empresa,string tipo, string numero, string pais, string numPlan, string numEnvio)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            SqlConnection dbSQL4 = new SqlConnection(VconnectionString);
            SqlCommand cmd4 = new SqlCommand();
            cmd4.CommandType = CommandType.StoredProcedure;
            cmd4.CommandText = "PORTAL.dbo.PORTAL_OBTENER_DOCUMENTOS_TEXTO";
            cmd4.Connection = dbSQL4;
            cmd4.Parameters.AddWithValue("@PCia", empresa);
            cmd4.Parameters.AddWithValue("@PTipo", tipo);
            cmd4.Parameters.AddWithValue("@PNumero", numero);
            cmd4.Parameters.AddWithValue("@PPais", pais);
            cmd4.Parameters.AddWithValue("@PNumPlan", numPlan);
            cmd4.Parameters.AddWithValue("@PEnvio", numEnvio);
            SqlDataAdapter sda4 = new SqlDataAdapter(cmd4);
            DataTable dt4 = new DataTable();
            sda4.Fill(dt4);
            return dt4;
        }
    }
}
