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

namespace UI.Web
{
    public partial class BuscarActivos : System.Web.UI.Page
    {
        private string CurrentCiactaID
        {
            get { return Session["CurrentCiactaID"] == null ? String.Empty : Session["CurrentCiactaID"].ToString(); }
            set
            {
                Session["CurrentCiactaID"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["ci_sciaB"] == null)
                {
                    int existe = verificarAsignacionClusterUsuario();
                    if (existe > 0)
                    {
                        Session["ci_sciaB"] = "200000 000";
                        (Lform.FindItemOrGroupByName("Cia") as LayoutItem).Caption = HttpUtility.HtmlDecode("Cluster");
                    }
                    else
                    {
                        Response.Redirect("AccesoRestringuido.aspx");
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

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {
            BuscarDocumentos();
        }

        private void BuscarDocumentos()
        {
            LayoutItem itemCia = Lform.FindItemOrGroupByName("Cia") as LayoutItem;
            ASPxDropDownEdit CBCia = itemCia.GetNestedControl() as ASPxDropDownEdit;
            Session["ci_sciaB"] = CBCia.Value != null ? CBCia.Value.ToString() : "100000 000";
        }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
        }

        protected void btnExportarPdf_E3_ClickExc(object sender, EventArgs e)
        {
            grid_data_exp.Landscape = true;
            grid_data_exp.Styles.Default.Font.Size = 6;
            grid_data_exp.WritePdfToResponse(new PdfExportOptions() { });
        }

        protected void SQLResultados_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows < 1)
            {
                if (Session["ci_sciaB"].ToString().Equals("100000 000") )
                {
                    lblValidacion.Text = "No se muestran resultados porque no se ha seleccionado un Cluster.";
                    PValidacion.ShowOnPageLoad = true;
                }
                else
                {
                    if (Session["ci_sciaB"].ToString().Equals("200000 000"))
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
