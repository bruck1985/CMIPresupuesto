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
using System.Globalization;
using System.Net.Mime;
using System.IO;
using DevExpress.XtraPrintingLinks;

namespace UI.Web
{
    public partial class SeguimientoAF : System.Web.UI.Page
    {
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
                if (Session["ci_sciaSE"] == null)
                {
                    Session["ci_sciaSE"] = "100000 000";
                    (Lform.FindItemOrGroupByName("Cia") as LayoutItem).Caption = HttpUtility.HtmlDecode("Cluster");
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
            Session["ci_sciaSE"] = CBCia.Value != null ? CBCia.Value.ToString() : "200000 000";
            SQLResultados.DataBind();
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
                Session["nombreDescarga"] = "SeguimientoAF.pdf";
                //WriteResponse(this.Response, ms.ToArray(), System.Net.Mime.DispositionTypeNames.Inline.ToString());
            }
            Response.Write("<script>");
            Response.Write("window.open('DescargaPDF.aspx' ,'_blank')");
            Response.Write("</script>");
            //Response.Redirect("DescargaPDF.aspx");
        }

        public static void WriteResponse(HttpResponse response, byte[] filearray, string type)
        {
            response.ClearContent();
            response.Buffer = true;
            response.Cache.SetCacheability(HttpCacheability.Private);
            response.ContentType = "application/pdf";
            
            ContentDisposition contentDisposition = new ContentDisposition();
            contentDisposition.FileName = "SeguimientoAF.pdf";
            
            contentDisposition.DispositionType = type;
            response.AddHeader("Content-Disposition", contentDisposition.ToString());
            response.BinaryWrite(filearray);
            HttpContext.Current.ApplicationInstance.CompleteRequest();
            try
            {
                response.End();
                response.Flush();
            }
            catch (System.Threading.ThreadAbortException)
            {
            }
        }

        public void grid_data_CustomButtonCallback(object sender, DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;

            //List<object> plist;
            //plist = grid_data.GetSelectedFieldValues(new string[] { "ID_SEGUIMIENTO" });

            string keyEmpresa = grid.GetRowValues(e.VisibleIndex, "CIA").ToString();
            string keyActivoFijo = grid.GetRowValues(e.VisibleIndex, "ACTIVO_FIJO").ToString();
            string keyMejora = grid.GetRowValues(e.VisibleIndex, "MEJORA").ToString();
            string origen = "Seguimiento";
            if (e.ButtonID.Equals("btnArea"))
            {
                ASPxGridView.RedirectOnCallback(string.Format("EditarAreaActivo.aspx?empresa={0}&activo={1}&mejora={2}&origen={3}", keyEmpresa, keyActivoFijo, keyMejora,origen));
            }
            if (e.ButtonID.Equals("btnEstado"))
            {
                ASPxGridView.RedirectOnCallback(string.Format("EditarEstadoActivo.aspx?empresa={0}&activo={1}&mejora={2}&origen={3}", keyEmpresa, keyActivoFijo, keyMejora, origen));
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
            if (e.ButtonID.Equals("btnInventario"))
            {
                ASPxGridView.RedirectOnCallback(string.Format("EditarInventario.aspx?empresa={0}&activo={1}&mejora={2}&origen={3}", keyEmpresa, keyActivoFijo, keyMejora,origen));
            }
        }

        protected void SQLResultados_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows < 1)
            {
                if (Session["ci_sciaSE"].ToString().Equals("200000 000") )
                {
                    lblValidacion.Text = "No se muestran resultados porque no se ha seleccionado un Cluster";
                    PValidacion.ShowOnPageLoad = true;
                }
                else
                {
                    if (Session["ci_sciaSE"].ToString().Equals("100000 000") )
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
    }
}
