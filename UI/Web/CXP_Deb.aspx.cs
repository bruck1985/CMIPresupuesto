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
//using DevExpress.Utils.Compress;

namespace UI.Web
{
    public partial class CXP_Deb: System.Web.UI.Page
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

                //(((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxDropDownEdit).FindControl("listBox") as ASPxListBox).SelectAll();   //.Value = " % ";
                //                ((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxGridLookup).Value = "";

            

                Session["lista_ci_scia1"] = "ddd ffffff";
              //  Session["nombreUsuario"] = "LRF";


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
            //    ASPxButton btn = sender as ASPxButton;
            //    GridViewDataItemTemplateContainer container = btn.NamingContainer as GridViewDataItemTemplateContainer;
            //    string cadenaCiaCtaID = DataBinder.Eval(container.DataItem, "CIA").ToString() + ";" + DataBinder.Eval(container.DataItem, "Cuenta_Contable").ToString() + ";" + DataBinder.Eval(container.DataItem, "CIA2").ToString() + ";" + DataBinder.Eval(container.DataItem, "Cuenta_Contable2").ToString();
            //    btn.ClientSideEvents.Click = String.Format("function (s, e) {{ Popup.PerformCallback('{0}'); Popup.Show(); }}", cadenaCiaCtaID);

        }





        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {

            LayoutItem itemFechaInicial = Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem;
            ASPxDateEdit CBFechaInicial = itemFechaInicial.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemFechaFinal = Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem;
            ASPxDateEdit CBFechaFinal = itemFechaFinal.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            ASPxDropDownEdit CBCiaOri = itemCiaOri.GetNestedControl() as ASPxDropDownEdit;






            //ASPxDateEdit CBFechaInicial = GetNestedEditor(Lform, "FechaInicial");
            if (CBFechaInicial != null)
            {
                if (CBCiaOri.Value != null)
                {
                    Session["lista_ci_scia1"] = CBCiaOri.Value != null ? CBCiaOri.Value.ToString() : "XXX;";
                }
                else
                {
                    Session["lista_ci_scia1"] = "XXX XXXXXXXXXX";
                }
                Session["ci_sfec1"] = CBFechaInicial.Value != null ? CBFechaInicial.Date.ToString("dd/MM/yyyy") : string.Empty;
                Session["ci_sfec2"] = CBFechaFinal.Value != null ? CBFechaFinal.Date.ToString("dd/MM/yyyy") : string.Empty;


            }

        }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            //grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });

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


                //              SQL_Data_OC_Linea.SelectParameters["PCia1"].DefaultValue = campos[0];
                //              SQL_Data_OC_Linea.SelectParameters["POrden_Compra"].DefaultValue = campos[1];

                //              SQL_Data_OC_Linea.DataBind();
                //SQL_Data_CTA_Detalle1.SelectParameters["cia1"].DefaultValue = campos[1];
                //SQL_Data_CTA_Detalle1.SelectParameters["cia1"].DefaultValue = campos[1];

                //PivotDetalleCta1.DataBind();
                Pmensaje.Text = "";
            }
        }

        protected void Cmbcentrocosto_Callback(object source, CallbackEventArgsBase e)
        {

            if (string.IsNullOrEmpty(e.Parameter)) return;
            //SQLDepartamento.SelectParameters["PCia1"].DefaultValue = e.Parameter.ToString();
            Session["CIAS_OC_PRES"] = e.Parameter.ToString();
            SQLDocumentosCxP.DataBind();
            //SQLDepartamento2.DataBind();
            (((Lform.FindItemOrGroupByName("centrocosto") as LayoutItem).GetNestedControl() as ASPxDropDownEdit).FindControl("listBoxcc") as ASPxListBox).DataBind();


            //            AccessDataSourceCities.SelectParameters[0].DefaultValue = country;
            //            CmbCity.DataBind();
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


        private void EjecutarCreaTEF(string PUSUARIO, string PCIA, string PPROVEEDOR, string PMONEDA, string PNUMERO, string PAPLICACION, string PMONTO, string PCUENTA_BANCO, out string PERR, out string PMERR)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "ok";


            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.[dbo].[PORTAL_TEF_CREAR]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PCIA", PCIA);
                command.Parameters.AddWithValue("@PPROVEEDOR", PPROVEEDOR);
                command.Parameters.AddWithValue("@PMONEDA", PMONEDA);
                command.Parameters.AddWithValue("@PNUMERO", PNUMERO);
                command.Parameters.AddWithValue("@PAPLICACION", PAPLICACION);
                command.Parameters.AddWithValue("@PMONTO", PMONTO);
                command.Parameters.AddWithValue("@PCUENTA_BANCO", PCUENTA_BANCO);
                command.Parameters.AddWithValue("@PUsuario", PUSUARIO);
                command.Parameters.Add("@PError", SqlDbType.Char, 10);
                command.Parameters["@PError"].Direction = ParameterDirection.Output;


                //                command.Parameters.AddWithValue("@PErr", vErr);


                command.Parameters.Add("@PMerr", SqlDbType.Char, 2000);
                command.Parameters["@PMerr"].Direction = ParameterDirection.Output;


                //                command.Parameters.AddWithValue("@PMerr", VMerr);



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
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
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


                //                command.Parameters.AddWithValue("@PErr", vErr);


                command.Parameters.Add("@PMerr", SqlDbType.Char, 2000);
                command.Parameters["@PMerr"].Direction = ParameterDirection.Output;


                //                command.Parameters.AddWithValue("@PMerr", VMerr);



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
            //Byte[] data = new Byte[0];
            //data = (Byte[])(dataSet.Tables[0].Rows[0]["pic"]);
            //MemoryStream mem = new MemoryStream(data);
            //yourPictureBox.Image = Image.FromStream(mem);


            //byte[] fileBytes = CardView.GetCardValues(container.VisibleIndex, fileColumn) as byte[];

            e.InputStream.Position = 0;
            Stream csStream = new GZipStream(e.InputStream, CompressionMode.Decompress);
             e.OutputStream = csStream;
            //            e.OutputStream = AddWatermarkToImage(e.InputStream);


            //     var fileStream = e.InputStream;
            //TryChangeStreamPositionToStart(fileStream);
            //fileStream.Position = 0;
            //if (!fileStream.CanSeek)
            //    fileStream = new KnownLengthStream(fileStream, e.File.Length);
            //    GZipStream. Add(GetPhysicalSafeUniqFileName(file.Name, fileNamesCache), file.LastWriteTime, fileStream);


            //e.OutputStream = e.InputStream;

            //MemoryStream ms = new e.InputStream; //MemoryStream((byte[])dt.Rows[0]["ImageData"]);

        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            //            string VconnectionString;
            //            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            //            using (SqlConnection conn = new SqlConnection(VconnectionString))
            //            {
            //                conn.Open();
            //                using (SqlCommand cmd = new SqlCommand("Select top(1) [CONTENIDO] FROM pruebas.cromsa.[DOC_ADJUNTO] D, pruebas.cromsa.orden_compra C  where D.tabla = 'ORDEN_COMPRA' and D.row_id = C.RowPointer and c.orden_compra = 'OC008364'", conn))
            //                {

            ////                    SqlCommand command1 = new SqlCommand("select imgfile from myimages where imgname=@param", connection);
            //                    byte[] img = (byte[])cmd.ExecuteScalar();
            //                    MemoryStream str = new MemoryStream();
            //                    str.Write(img, 0, img.Length);
            //                    //Bitmap bit = new Bitmap(str);
            //                    //connection.Close();
            //                    //pictureBox1.Image = img;

            //                }
            //                conn.Close();
            //            }

            //byte[] filebyte = null;
//            int id = int.Parse((sender as LinkButton).CommandArgument);
            byte[] bytes;
            string fileName, contentType;
            fileName = "Err";
            bytes = new Byte[16 * 1024 - 1]; 
            string VconnectionString;
            string data;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            //string guid = Request.QueryString["file"];
            //string fileName = "ERROR";
            //byte[] data = new byte[] { 0, 0, 0, 0 };
            string strCon = VconnectionString;
            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(strCon))
            {
                con.Open();
                string strcmd = "Select top(1) NOMBRE, convert(varbinary(max), CONTENIDO, 1) CONTENIDO FROM pruebas.cromsa.[DOC_ADJUNTO] D, pruebas.cromsa.orden_compra C  where D.tabla = 'ORDEN_COMPRA' and D.row_id = C.RowPointer and c.orden_compra = 'OC008135'";
                using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(strcmd, con))
                {
                    //cmd.Parameters.AddWithValue("@ID", guid);
                    using (System.Data.SqlClient.SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            fileName = (string)r["NOMBRE"];
                            bytes = (byte[])r["CONTENIDO"];
                            data = Encoding.UTF8.GetString(bytes);
                            //filebyte = System.IO.File.ReadAllBytes( (byte[])r["CONTENIDO"]) ;
                         
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




/*            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/txt";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
            Response.BinaryWrite(bytes);
            Response.Flush();
            Response.End();*/


        }

        protected void ASPxFormLayout1_E1_Click(object sender, EventArgs e)
        {

/*
            string PERR = "0";
            string PMerr = "ok";
            string PUser;
            PUser = "JMZ";

            EjecutarReversionOC(PUser, Session["cov2_cia"].ToString(), Session["cov2_orden_compra"].ToString(), out PERR, out PMerr);

            Pmensaje.Text = PMerr;
            if (PERR.Trim() == "0")
            {
                SQL_Data_CTA_Detalle1.DataBind();
                SQL_Data_OC_Doc_Adjuntos.DataBind();
                SQL_Data_OC_Linea.DataBind();
                ASPxFormLayout1.DataBind();
                SQLCompras.DataBind();
                GridCompras.DataBind();

            }


            */
        }



        private void EjecutarAplicarDocumento( string PDOCUMENTO, string PTIPO, string PKEYDOC, string PUSUARIO, string PTipoCambio, out string PERR, out string PMERR)
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
                command.Parameters.AddWithValue("@PTIPO_CAMBIO_APLICAR", "1"); 
                command.Parameters.Add("@PError", SqlDbType.Char, 10);
                command.Parameters["@PError"].Direction = ParameterDirection.Output;


                //                command.Parameters.AddWithValue("@PErr", vErr);


                command.Parameters.Add("@PMerr", SqlDbType.Char, 2000);
                command.Parameters["@PMerr"].Direction = ParameterDirection.Output;


                //                command.Parameters.AddWithValue("@PMerr", VMerr);



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

                LayoutItem itemTipoCambio = ASPxFormLayout1.FindItemOrGroupByName("PTIPO_CAMBIO") as LayoutItem;
                ASPxSpinEdit TxTipoCambio = itemTipoCambio.GetNestedControl() as ASPxSpinEdit;



                foreach (string item in plist)
                {
                    EjecutarAplicarDocumento(TxDocumento.Value.ToString(), TxTipo.Value.ToString(), item, PUser, TxTipoCambio.Value.ToString(), out PERR, out PMerr);
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
            string PProveedor;
            string PUser;
            String[] campos = CBListaAbuelo.Value.ToString().Split(';');

            PUser = Session["nombreUsuario"].ToString().ToUpper();

            PProveedor = campos[0];


            EjecutarCreaTEF(PUser, CBCia_TEF.Value.ToString(), PProveedor, CBListaMoneda.Value.ToString(), tbnumero.Text, tbaplicacion.Text, tbmonto.Text, CBCuentaBanco.Value.ToString(), out PERR, out PMerr);

            PmensajeTEF.Text = PMerr;
            if (PERR.Trim() == "0")
            {
                CBCia_TEF.Value = null;
                CBListaAbuelo.Value = null;
                CBListaMoneda.Value = null;
                tbnumero.Text = null;
                tbaplicacion.Text = null;
                tbmonto.Text = null;
                CBCuentaBanco.Value = null;

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

        //    LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
        //    ASPxComboBox CBUsuarios = itemCiaOri.GetNestedControl() as ASPxComboBox;

            string text = e.Parameter;


            Session["CBCiatef"] = text != null ? text : "";
            //Session["PAdicional241"] = text;


            //Session["PCuentaini24"] = txCuentaIni.Value != null ? txCuentaIni.Value.ToString() : "";
            //Session["PCuentafin24"] = txCuentaFin.Value != null ? txCuentaFin.Value.ToString() : "";

            DS_Proveedor.DataBind();
            CBListaAbuelo.DataBind();
            DS_Monedas.DataBind();
            CBListaMoneda.DataBind();
            DS_CuentaBanco.DataBind();
            CBCuentaBanco.DataBind();
            //CBListaAbuelo.DataBind();
            CBListaAbuelo.JSProperties["cpText"] = text;
        }

        protected void CBListaPadre_Callback(object sender, CallbackEventArgsBase e)
        {
            string text = e.Parameter;
            string abulocod;

            Session["CBCiatef"] = text != null ? text : "";
            //    string Abuelo = Session["PAdicional241"].ToString();

            //Session["PAbuelo24"] = Abuelo.Substring(0, 3);
            //abulocod = Abuelo.Substring(0, 3);
            Session["PAbuelo24"] = text;
            Session["PAdicional242"] = "";

            DS_Monedas.DataBind();
            CBListaMoneda.DataBind();
            //CBListaAbuelo.DataBind();
            CBListaMoneda.JSProperties["cpTextcbp"] = "";
        }

        protected void CBCuentaBanco_Callback(object sender, CallbackEventArgsBase e)
        {

            string text = e.Parameter;
            string[] vtext = text.Split(';');

            Session["CBCiatef"] = vtext[0] != null ? vtext[0].ToString() : "";
            Session["PMoneda"] = vtext[1] != null ? vtext[1].ToString() : "";

            DS_CuentaBanco.DataBind();
            CBCuentaBanco.DataBind();
        }

        protected void ASPxGridViewCre_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            string text = e.Parameters;
            string[] vtext = text.Split(';');
            Session["CBCiatef"] = vtext[0] != null ? vtext[0].ToString() : "";
            Session["cxp12_proveedord"] = vtext[1] != null ? vtext[1].ToString() : "";
            SQL_Data_CRE_Linea_2.DataBind();
            ASPxGridViewCre.DataBind();
        }




        /*public void SaveStreamToFile(string fileFullPath, Stream stream)
        {
            if (stream.Length == 0)
                return;

            // Create a FileStream object to write a stream to a file  
            using (FileStream fileStream = System.IO.File.Create(fileFullPath, System.Convert.ToInt32(Conversion.Fix(stream.Length))))
            {
                // Fill the bytes[] array with the stream data  
                byte[] bytesInStream = new byte[stream.Length - 1 + 1];
                stream.Read(bytesInStream, 0, System.Convert.ToInt32(Conversion.Fix(bytesInStream.Length)));

                // Use FileStream object to write to the specified file  
                fileStream.Write(bytesInStream, 0, bytesInStream.Length);
            }
        } */


    }
}
