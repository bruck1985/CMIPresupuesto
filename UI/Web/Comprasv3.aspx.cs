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
    public partial class Comprasv3 : System.Web.UI.Page
    {
        const string UploadDirectory = "~/UploadControl/UploadImages/";
        private string CurrentCiactaID
        {

            get { return Session["CurrentCiactaID"] == null ? String.Empty : Session["CurrentCiactaID"].ToString(); }
            set
            {
                Session["CurrentCiactaID"] = value;
                String[] campos = value.Split(';');
                Session["CI_Det_Cia1"] = campos[0];
                Session["CI_OrdenCompra"] = campos[1];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["nombreUsuario"] = "JMZ";
            if (!IsPostBack)
            {
                Session["ci_scia2"] = "%";
                Session["ci_sfec1"] = DateTime.Today.AddMonths(-1).ToString("dd/MM/yyyy");    //DateTime.Now.ToString("dd/MM/yyyy");
                Session["ci_sfec2"] = DateTime.Now.ToString("dd/MM/yyyy");
                Session["ci_stipo"] = "A";
                SQLCompania.DataBind();

                ((Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Today.AddMonths(-1);
                ((Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Now;

                //(((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxDropDownEdit).FindControl("listBox") as ASPxListBox).SelectAll();   //.Value = " % ";
                //                ((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxGridLookup).Value = "";

                ((Lform.FindItemOrGroupByName("CB_Tipo_Reporte") as LayoutItem).GetNestedControl() as ASPxComboBox).Value = "A";


                Session["lista_ci_scia1"] = "ddd ffffff";
             


            }

        }

        static byte[] Compress(byte[] data)
        {
            using (var compressedStream = new MemoryStream())
            using (var zipStream = new GZipStream(compressedStream, CompressionMode.Compress))
            {
                zipStream.Write(data, 0, data.Length);
                zipStream.Close();
                return compressedStream.ToArray();
            }
        }

        protected void UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            string resultExtension = Path.GetExtension(e.UploadedFile.FileName);
            string resultFileName = e.UploadedFile.FileName;
            string resultFileUrl = UploadDirectory + resultFileName;
            string resultFilePath = MapPath(resultFileUrl);
            byte[] fileBytes = e.UploadedFile.FileBytes;
            //  e.UploadedFile.SaveAs(resultFilePath);

            fileBytes = Compress(fileBytes);

            //Stream csStream = new GZipStream(fileBytes, CompressionMode.Compress);
            //e.OutputStream = csStream;

            CrearImagenBase(Session["cov2_cia"].ToString(), Session["cov2_orden_compra"].ToString(), resultFileName, fileBytes);
         //   UploadingUtils.RemoveFileWithDelay(resultFileName, resultFilePath, 5);

            string name = e.UploadedFile.FileName;
            string url = ResolveClientUrl(resultFileUrl);
            long sizeInKilobytes = e.UploadedFile.ContentLength / 1024;
            string sizeText = sizeInKilobytes.ToString() + " KB";
            e.CallbackData = name + "|" + url + "|" + sizeText;
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


            LayoutItem itemtiporep = Lform.FindItemOrGroupByName("CB_Tipo_Reporte") as LayoutItem;
            ASPxComboBox CBtiporep = itemtiporep.GetNestedControl() as ASPxComboBox;

            LayoutItem itemDepOri = Lform.FindItemOrGroupByName("centrocosto") as LayoutItem;
            ASPxDropDownEdit CBDepOri = itemDepOri.GetNestedControl() as ASPxDropDownEdit;




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
                Session["ci_stipo"] = CBtiporep.Value != null ? CBtiporep.Value.ToString() : string.Empty;
                Session["cov2_departamento"] = CBDepOri.Value != null ? CBDepOri.Value.ToString() : "XXX;";


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
                Session["cov2_orden_compra"] = campos[1];

                SQL_Data_CTA_Detalle1.SelectParameters["PCia1"].DefaultValue = campos[0];
                SQL_Data_CTA_Detalle1.SelectParameters["POrden_Compra"].DefaultValue = campos[1];
                SQL_Data_CTA_Detalle1.DataBind();

                SQL_Data_OC_Doc_Adjuntos.SelectParameters["PCia1"].DefaultValue = campos[0];
                SQL_Data_OC_Doc_Adjuntos.SelectParameters["PORDEN_COMPRA"].DefaultValue = campos[1];
                SQL_Data_OC_Doc_Adjuntos.DataBind();


                SQL_Data_OC_Linea.SelectParameters["PCia1"].DefaultValue = campos[0];
                SQL_Data_OC_Linea.SelectParameters["POrden_Compra"].DefaultValue = campos[1];

                SQL_Data_OC_Linea.DataBind();
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
            SQLDepartamento.DataBind();
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


        private void EjecutarApruebaOrden(string PUSUARIO, string PCIA, string PORDEN_COMPRA, out string PERR, out string PMERR)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
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


        private void CrearImagenBase (string PCIA, string PORDEN_COMPRA, string PNOMBRE, byte[] PIMAGEN)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "ok";


            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.[dbo].[PORTAL_DOCUMENTOS_ADJUNTOS_CREAR]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PCia1", PCIA);
                command.Parameters.AddWithValue("@PORDEN_COMPRA", PORDEN_COMPRA);
                command.Parameters.AddWithValue("@PNOMBRE", PNOMBRE);
                command.Parameters.AddWithValue("@PCONTENIDO", PIMAGEN);


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
                SQL_Data_OC_Doc_Adjuntos.DataBind();
                SQL_Data_OC_Linea.DataBind();
                ASPxFormLayout1.DataBind();
                SQLCompras.DataBind();
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



        private void EjecutarReversionOC(string PUSUARIO, string PCIA, string PORDEN_COMPRA, out string PERR, out string PMERR)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "ok";


            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.[dbo].[PORTAL_OC_APROBAR_REVERSION]", conn)
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

        protected void BTAceptar_Click(object sender, EventArgs e)
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
                SQL_Data_OC_Doc_Adjuntos.DataBind();
                SQL_Data_OC_Linea.DataBind();
                ASPxFormLayout1.DataBind();
                SQLCompras.DataBind();
                GridCompras.DataBind();

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
                SQL_Data_OC_Doc_Adjuntos.DataBind();
                SQL_Data_OC_Linea.DataBind();
                ASPxFormLayout1.DataBind();
                SQLCompras.DataBind();
                GridCompras.DataBind();
            }
        }

        protected void ASPxButton4_Click(object sender, EventArgs e)
        {
            string PERR = "0";
            string PMerr = "ok";
            string PUser;
            PUser = Session["nombreUsuario"].ToString();

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

        }

        protected void ASPxFileManager1_CustomCallback(object sender, CallbackEventArgsBase e)
        {
            SQL_Data_OC_Doc_Adjuntos.DataBind();
            ASPxFileManager1.DataBind();
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
