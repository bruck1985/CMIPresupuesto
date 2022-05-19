using BusinessLogic.Clases;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utilitarios.Clases;

namespace UI.Web
{
    public partial class EditarConfiguracion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params["id"] != null)
            {
                cargarEmpresas();
                cargarConceptos();
                string valor = "";
                valor = Request.Params["id"];
                ContratoBL objContrato = new ContratoBL();
                ConfiguracionContable oConfiguracion = new ConfiguracionContable();
                oConfiguracion = objContrato.obtenerConfiguracion(Convert.ToInt32(valor));
                cbEmpresas.ValueType = typeof(String);
                cbEmpresas.Value = oConfiguracion.Empresa;
                cbEmpresas.Enabled = false;

                cbTipo.ValueType = typeof(String);
                cbTipo.Value = oConfiguracion.Tipo;
                cbTipo.Enabled = false;

                cbConcepto.ValueType = typeof(Int32);
                cbConcepto.Value = oConfiguracion.ConceptoId;
                cbConcepto.Enabled = false;

                txtCentroCosto.Text = oConfiguracion.CentroCosto;
                txtCentroCosto.Enabled = false;
                txtCuentaContable.Text = oConfiguracion.CuentaContable;
                txtCuentaContable.Enabled = false;

                IdConfiguracion["hidden_value"] = valor;
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

        private void cargarConceptos()
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;
            String VSQL;
            VSQL = "SELECT ID_CONCEPTO,NOMBRE_CONCEPTO FROM CONCEPTO_CONTRATO";
            SqlConnection conn = new SqlConnection(VconnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = VSQL;
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            cbConcepto.DataSource = ds;
            cbConcepto.ValueField = "ID_CONCEPTO";
            cbConcepto.TextField = "NOMBRE_CONCEPTO";
            cbConcepto.DataBind();
        }

        protected void Lform_E3_Click(object sender, EventArgs e)
        {
            LayoutItem LiCentroCosto = FormLayout.FindItemOrGroupByName("LiNuevoCentroCosto") as LayoutItem;
            ASPxTextBox txtCentroCosto = LiCentroCosto.GetNestedControl() as ASPxTextBox;
            string centroCosto = "";
            if (txtCentroCosto != null)
            {
                centroCosto = txtCentroCosto.Value.ToString();
            }

            LayoutItem LiCuentaContable = FormLayout.FindItemOrGroupByName("LiNuevoCuentaContable") as LayoutItem;
            ASPxTextBox txtNuevaCuentaContable = LiCuentaContable.GetNestedControl() as ASPxTextBox;
            string cuentaContable = "";
            if (txtCuentaContable != null)
            {
                cuentaContable = txtNuevaCuentaContable.Value.ToString();
            }

            string idConfiguracion = IdConfiguracion.Get("hidden_value").ToString();

            /*Conexión a la BD*/
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;
            SqlConnection dbSQL = new SqlConnection(VconnectionString);

            try
            {
                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();

                string sentencia = "UPDATE CONFIGURACION_CENTRO_CUENTA SET CENTRO_COSTO='" + centroCosto + "', CUENTA='" + cuentaContable + "' ";
                sentencia = sentencia + " WHERE ID=" + idConfiguracion;
                SqlCommand ComandoConsulta = new SqlCommand();
                ComandoConsulta.CommandText = sentencia;
                ComandoConsulta.Connection = dbSQL;
                ComandoConsulta.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
                //throw;
            }
            finally
            {
                if (dbSQL.State == ConnectionState.Open)
                    dbSQL.Close();
            }

            Response.Redirect("ConfiguracionCuentaCentro.aspx");

        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ConfiguracionCuentaCentro.aspx");
        }
    }
}