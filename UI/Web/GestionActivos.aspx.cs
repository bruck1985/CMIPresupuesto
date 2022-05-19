using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using DevExpress.Export;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.IO.Compression;
using System.IO;
using System.Globalization;
using DevExpress.XtraPrintingLinks;

namespace UI.Web
{
    public partial class GestionActivos : System.Web.UI.Page
    {
        const string UploadDirectory = "~/UploadControl/UploadImages/";
        private string CurrentCiactaID
        {
            get { return Session["CurrentCiactaID"] == null ? String.Empty : Session["CurrentCiactaID"].ToString(); }
            set
            {
                Session["CurrentCiactaID"] = value;
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            CultureInfo newCulture = (CultureInfo)CultureInfo.CurrentCulture.Clone();
            newCulture.NumberFormat.NumberGroupSeparator = ",";
            newCulture.NumberFormat.NumberDecimalSeparator = ".";

            System.Threading.Thread.CurrentThread.CurrentCulture = newCulture;
            System.Threading.Thread.CurrentThread.CurrentUICulture = newCulture;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["ci_sciaCA"] == null)
                {
                    int existe = verificarAsignacionClusterUsuario();
                    if (existe>0)
                    {
                        Session["ci_sciaCA"] = "1 1";
                        Session["ci_departamento"] = "1 1";
                        Session["ci_tipo"] = "0";
                        (Lform.FindItemOrGroupByName("Cia") as LayoutItem).Caption = HttpUtility.HtmlDecode("Cluster");
                    }
                    else
                    {
                        Response.Redirect("AccesoRestringuido.aspx");
                    }
                }
            }
        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {
            BuscarDocumentos();
        }

        private void BuscarDocumentos()
        {
            LayoutItem itemCia = Lform.FindItemOrGroupByName("Cia") as LayoutItem;
            ASPxDropDownEdit CBCia = itemCia.GetNestedControl() as ASPxDropDownEdit;
            Session["ci_sciaCA"] = CBCia.Value != null ? CBCia.Value.ToString() : "0 0";
            Session["ci_tipo"] = "1";
            LayoutItem itemDepartamento = Lform.FindItemOrGroupByName("Departamento") as LayoutItem;
            ASPxDropDownEdit CBDepartamento = itemDepartamento.GetNestedControl() as ASPxDropDownEdit;
            Session["ci_departamento"] = CBDepartamento.Value != null ? CBDepartamento.Value.ToString() : "0 0";
        }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
        }

        protected void btnExportarPdf_E3_ClickExc(object sender, EventArgs e)
        {
            /*grid_data_exp.Landscape = true;
            grid_data_exp.Styles.Default.Font.Size = 6;
            grid_data_exp.WritePdfToResponse(new PdfExportOptions() { });*/
            using (MemoryStream ms = new MemoryStream())
            {
                PrintableComponentLinkBase pcl = new PrintableComponentLinkBase(new PrintingSystemBase());
                pcl.Component = grid_data_exp;
                pcl.Margins.Left = pcl.Margins.Right = 50;
                pcl.Landscape = true;
                pcl.CreateDocument(false);
                pcl.PrintingSystemBase.Document.AutoFitToPagesWidth = 1;
                pcl.ExportToPdf(ms);
                Session["binaryData"] = ms.ToArray();
                Session["nombreDescarga"] = "Activos.pdf";
                //WriteResponse(this.Response, ms.ToArray(), System.Net.Mime.DispositionTypeNames.Inline.ToString());
            }
            //Response.Redirect("DescargaPDF.aspx");
            Response.Write("<script>");
            Response.Write("window.open('DescargaPDF.aspx' ,'_blank')");
            Response.Write("</script>");
        }

        protected void grid_data_CustomButtonCallback(object sender, DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            string keyEmpresa = grid.GetRowValues(e.VisibleIndex, "CIA").ToString();
            string keyActivoFijo = grid.GetRowValues(e.VisibleIndex, "ACTIVO_FIJO").ToString();
            string keyMejora = grid.GetRowValues(e.VisibleIndex, "MEJORA").ToString();
            string origen = "Gestion";

            if (e.ButtonID.Equals("btnArea"))
            {
                ASPxGridView.RedirectOnCallback(string.Format("EditarAreaActivo.aspx?empresa={0}&activo={1}&mejora={2}&origen={3}", keyEmpresa,keyActivoFijo,keyMejora,origen));
            }
            if (e.ButtonID.Equals("btnEstado"))
            {
                ASPxGridView.RedirectOnCallback(string.Format("EditarEstadoActivo.aspx?empresa={0}&activo={1}&mejora={2}&origen={3}", keyEmpresa, keyActivoFijo, keyMejora,origen));
            }
            if (e.ButtonID.Equals("btnResponsable"))
            {
                ASPxGridView.RedirectOnCallback(string.Format("EditarResponsableActivo.aspx?empresa={0}&activo={1}&mejora={2}&origen={3}", keyEmpresa, keyActivoFijo, keyMejora,origen));
            }
            if (e.ButtonID.Equals("btnDetalle"))
            {
                ASPxGridView.RedirectOnCallback(string.Format("VerActivo.aspx?empresa={0}&activo={1}&mejora={2}&origen={3}", keyEmpresa, keyActivoFijo, keyMejora, origen));
            }
            if (e.ButtonID.Equals("btnAcciones"))
            {
                ASPxGridView.RedirectOnCallback(string.Format("VerAccionesActivos.aspx?empresa={0}&activo={1}&origen={2}", keyEmpresa, keyActivoFijo,origen));
            }
        }

        protected void btnBuscarRandom_Click(object sender, EventArgs e)
        {
            LayoutItem itemCia = Lform.FindItemOrGroupByName("Cia") as LayoutItem;
            ASPxDropDownEdit CBCia = itemCia.GetNestedControl() as ASPxDropDownEdit;
            Session["ci_sciaCA"] = CBCia.Value != null ? CBCia.Value.ToString() : "XXX;";
            Session["ci_tipo"] = "2";
        }

        protected void ASPxFileManager1_FileDownloading(object source, FileManagerFileDownloadingEventArgs e)
        {
            e.InputStream.Position = 0;
            Stream csStream = new GZipStream(e.InputStream, CompressionMode.Decompress);
            e.OutputStream = csStream;
        }

        protected void ASPxFileManager1_CustomCallback(object sender, CallbackEventArgsBase e)
        {
            SQL_Data_AF_Doc_Adjuntos.DataBind();
            ASPxFileManager1.DataBind();
        }

        protected void UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            string resultExtension = Path.GetExtension(e.UploadedFile.FileName);
            string resultFileName = e.UploadedFile.FileName;
            string resultFileUrl = UploadDirectory + resultFileName;
            string resultFilePath = MapPath(resultFileUrl);
            byte[] fileBytes = e.UploadedFile.FileBytes;
            fileBytes = Compress(fileBytes);

            CrearImagenBase(Session["CodigoCia"].ToString(), Session["CodigoAF"].ToString(), resultFileName, fileBytes);

            string name = e.UploadedFile.FileName;
            string url = ResolveClientUrl(resultFileUrl);
            long sizeInKilobytes = e.UploadedFile.ContentLength / 1024;
            string sizeText = sizeInKilobytes.ToString() + " KB";
            e.CallbackData = name + "|" + url + "|" + sizeText;
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

        private void CrearImagenBase(string PCIA, string PACTIVO_FIJO, string PNOMBRE, byte[] PIMAGEN)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "ok";
            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.[dbo].[PORTAL_DOCUMENTOS_ADJUNTOS_AF_CREAR]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PCia1", PCIA);
                command.Parameters.AddWithValue("@PACTIVO_FIJO", PACTIVO_FIJO);
                command.Parameters.AddWithValue("@PNOMBRE", PNOMBRE);
                command.Parameters.AddWithValue("@PCONTENIDO", PIMAGEN);

                command.Parameters.Add("@PError", SqlDbType.Char, 10);
                command.Parameters["@PError"].Direction = ParameterDirection.Output;
                command.Parameters.Add("@PMerr", SqlDbType.Char, 2000);
                command.Parameters["@PMerr"].Direction = ParameterDirection.Output;
                conn.Open();
                command.ExecuteNonQuery();

                vErr = (string)command.Parameters["@PError"].Value;
                VMerr = (string)command.Parameters["@PMerr"].Value;
            }
        }

        protected void Popup_WindowCallback(object source, PopupWindowCallbackArgs e)
        {
            CurrentCiactaID = e.Parameter;
            DetailsApply();
        }

        private void DetailsApply()
        {
            if (!String.IsNullOrEmpty(CurrentCiactaID))
            {

                String[] campos = CurrentCiactaID.Split(';');

                Session["CodigoCia"] = campos[0];
                Session["CodigoAF"] = campos[1];
                SQL_Data_AF_Doc_Adjuntos.SelectParameters["PCia1"].DefaultValue = campos[0];
                SQL_Data_AF_Doc_Adjuntos.SelectParameters["PACTIVO_FIJO"].DefaultValue = campos[1];
                SQL_Data_AF_Doc_Adjuntos.DataBind();

            }
        }

        protected void SQLResultados_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows < 1)
            {
                if (Session["ci_sciaCA"].ToString().Equals("0 0") || Session["ci_departamento"].ToString().Equals("0 0"))
                {
                    lblValidacion.Text = "No se muestran resultados porque no se ha seleccionado Usuario o Departamento.";
                    PValidacion.ShowOnPageLoad = true;
                }
                else
                {
                    if (Session["ci_sciaCA"].ToString().Equals("1 1") || Session["ci_departamento"].ToString().Equals("1 1"))
                    {

                    }
                    else
                    {
                        lblValidacion.Text = "No se encontraron resultados.";
                        PValidacion.ShowOnPageLoad = true;
                    }
                }
                
            }
        }

        private int verificarAsignacionClusterUsuario()
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            String VSQL;
            VSQL = "SELECT COUNT(*) AS EXISTE FROM PORTAL.dbo.CLUSTER_AF C INNER JOIN PORTAL.dbo.DETALLE_CLUSTER_AF D ON D.CLUSTER_ID = C.CLUSTER_ID ";
            VSQL = VSQL + " INNER JOIN PORTAL.dbo.Departamento_Usuario_AF DU ON DU.Compania = D.CIA WHERE DU.NombreUsuario ='" + Session["nombreUsuario"].ToString() + "'";
            SqlConnection conn = new SqlConnection(VconnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = VSQL;
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);


            int resultado = Convert.ToInt32(ds.Tables[0].Rows[0].ItemArray[0].ToString());
            return resultado;
        }
    }
}
