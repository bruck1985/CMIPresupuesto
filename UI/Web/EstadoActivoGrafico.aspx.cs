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
    public partial class EstadoActivoGrafico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["ci_sciaG"] == null)
                {
                    Session["ci_sciaG"] = "";
                    Session["ci_sciaF"] = "";
                    Session["ci_scategoriaG"] = "";
                    (Lform.FindItemOrGroupByName("Cia") as LayoutItem).Caption = HttpUtility.HtmlDecode("Compañía");
                }
            }
        }

        protected void cbCompania_ValueChanged(object sender, EventArgs e)
        {

        }

        protected void cbCompania_SelectedIndexChanged(object sender, EventArgs e)
        {
            LayoutItem itemCia = Lform.FindItemOrGroupByName("Cia") as LayoutItem;
            ASPxComboBox CBCia = itemCia.GetNestedControl() as ASPxComboBox;
            string compania = CBCia.Value.ToString();
            /*Session["ci_sciaF"] = CBCia.Value != null ? CBCia.Value.ToString() : "XXX;";
            SQLCategoria.DataBind();*/

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            SqlConnection dbSQL = new SqlConnection(VconnectionString);
            try
            {
                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();

                String VSQL;
                VSQL = "SELECT ta.tipo_activo, ta.descripcion from Pruebas." + compania + ".tipo_activo ta ";
                VSQL = VSQL + " ORDER BY 1 ASC; ";
                SqlConnection conn = new SqlConnection(VconnectionString);
                SqlDataAdapter da = new SqlDataAdapter();
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = VSQL;
                da.SelectCommand = cmd;
                DataSet ds = new DataSet();
                da.Fill(ds);
                DataTable dt = new DataTable();
                dt = ds.Tables[0];

                /*cbCategoria.TextField = "descripcion";
                cbCategoria.ValueField = "tipo_activo";
                cbCategoria.DataSource = dt;
                cbCategoria.DataBind();*/
            }
            catch (Exception ex)
            { 
            
            }
            finally
            {
                if (dbSQL.State == ConnectionState.Open)
                    dbSQL.Close();
            }
        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {
            BuscarEstados();
        }

        private void BuscarEstados()
        {
            LayoutItem itemCia = Lform.FindItemOrGroupByName("Cia") as LayoutItem;
            ASPxDropDownEdit CBCia = itemCia.GetNestedControl() as ASPxDropDownEdit;
            Session["ci_sciaG"] = CBCia.Value != null ? CBCia.Value.ToString() : "";

            LayoutItem itemCategoria = Lform.FindItemOrGroupByName("Categoria") as LayoutItem;
            ASPxDropDownEdit CBCategoria = itemCategoria.GetNestedControl() as ASPxDropDownEdit;
            Session["ci_scategoriaG"] = CBCategoria.Value != null ? CBCategoria.Value.ToString() : "";
        }
    }
}
