using BusinessLogic.Clases;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utilitarios.Clases;


namespace UI.Web
{
    public partial class EditarInventario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.Params["empresa"] != null && Request.Params["activo"] != null && Request.Params["mejora"] != null)
                {
                    cargarEmpresas();
                    string empresa = "";
                    string codActivo = "";
                    string mejora = "";
                    empresa = Request.Params["empresa"];
                    codActivo = Request.Params["activo"];
                    mejora = Request.Params["mejora"];
                    Session["origen"] = Request.Params["origen"];

                    ActivoBL objActivo = new ActivoBL();
                    Activo oActivo = new Activo();
                    oActivo = objActivo.obtenerActivo(empresa, codActivo, mejora);
                    cbEmpresas.ValueType = typeof(String);
                    cbEmpresas.Value = oActivo.Empresa;
                    cbEmpresas.Enabled = false;

                    txtCodigoActivo.Text = oActivo.CodActivo;
                    txtCodigoActivo.Enabled = false;

                    txtNombreActivo.Text = oActivo.NombreActivo;
                    txtNombreActivo.Enabled = false;

                    txtCodigoActivoMejora.Text = oActivo.CodActivoMejora;
                    txtCodigoActivoMejora.Enabled = false;

                    txtNombreActivoMejora.Text = oActivo.NombreActivoMejora;
                    txtNombreActivoMejora.Enabled = false;

                    txtResponsableActivo.Text = oActivo.NombreResponsable;
                    txtResponsableActivo.Enabled = false;

                    dtFechaInventario.Value = oActivo.FechaInventario;
                }
            }
        }


        private void cargarEmpresas()
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            String VSQL;
            VSQL = "SELECT CONJUNTO,NOMBRE FROM ERPADMIN.CONJUNTO ORDER BY CONJUNTO";
            SqlConnection conn = new SqlConnection(VconnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = VSQL;
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            cbEmpresas.DataSource = ds;
            cbEmpresas.ValueField = "CONJUNTO";
            cbEmpresas.TextField = "NOMBRE";
            cbEmpresas.DataBind();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            if (Session["origen"].ToString().Equals("Seguimiento"))
            {
                Response.Redirect("SeguimientoAF.aspx");
            }
            else
            {
                Response.Redirect("GestionActivos.aspx");
            }
        }

        protected void Lform_E3_Click(object sender, EventArgs e)
        {
            LayoutItem LiEmpresa = FormLayout.FindItemOrGroupByName("LiEmpresa") as LayoutItem;
            ASPxComboBox cbEmpresa = LiEmpresa.GetNestedControl() as ASPxComboBox;
            string codEmpresa = "";
            if (cbEmpresa != null)
            {
                codEmpresa = cbEmpresa.Value.ToString();
            }

            LayoutItem LiCodigoActivo = FormLayout.FindItemOrGroupByName("LiCodigoActivo") as LayoutItem;
            ASPxTextBox txtCodigoActivo = LiCodigoActivo.GetNestedControl() as ASPxTextBox;
            string codigoActivo = "";
            if (txtCodigoActivo != null)
            {
                codigoActivo = txtCodigoActivo.Value.ToString();
            }

            LayoutItem LiCodigoActivoMejora = FormLayout.FindItemOrGroupByName("LiCodigoActivoMejora") as LayoutItem;
            ASPxTextBox txtCodigoActivoMejora = LiCodigoActivoMejora.GetNestedControl() as ASPxTextBox;
            string codigoActivoMejora = "";
            if (txtCodigoActivoMejora != null)
            {
                codigoActivoMejora = txtCodigoActivoMejora.Value.ToString();
            }

            LayoutItem LiInventario = FormLayout.FindItemOrGroupByName("LiFechaUltimoInventario") as LayoutItem;
            ASPxDateEdit txtInventario = LiInventario.GetNestedControl() as ASPxDateEdit;
            string fecha = "";
            if (txtInventario != null)
            {
                fecha = txtInventario.Value.ToString();
            }
            /*Conexión a la BD*/
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            SqlConnection dbSQL = new SqlConnection(VconnectionString);

            try
            {
                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();
                
                string sentencia = "UPDATE PRUEBAS." + codEmpresa + ".ACTIVO_MEJORA SET RUBRO1_ACTIVO='" + fecha + "' ";
                sentencia = sentencia + " WHERE ACTIVO_FIJO='" + codigoActivo + "' AND MEJORA='" + codigoActivoMejora + "'";

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
            Response.Redirect("SeguimientoAF.aspx");
        }
    }
}