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

namespace UI.Web
{
    public partial class NuevaConfiguracion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                cargarEmpresas();
                cargarConceptos();
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
            LayoutItem LiEmpresa = FormLayout.FindItemOrGroupByName("LiEmpresa") as LayoutItem;
            ASPxComboBox CboEmpresa = LiEmpresa.GetNestedControl() as ASPxComboBox;
            string empresa = "";
            if (CboEmpresa != null)
            {
                empresa = CboEmpresa.Value.ToString();
            }

            LayoutItem LiTipo = FormLayout.FindItemOrGroupByName("LiTipo") as LayoutItem;
            ASPxComboBox CbTipo = LiTipo.GetNestedControl() as ASPxComboBox;
            string tipo = "";
            if (CbTipo != null)
            {
                tipo = CbTipo.Value.ToString();
            }

            LayoutItem LiConcepto = FormLayout.FindItemOrGroupByName("LiConcepto") as LayoutItem;
            ASPxComboBox CbConcepto = LiConcepto.GetNestedControl() as ASPxComboBox;
            string concepto = "";
            if (CbConcepto != null)
            {
                concepto = CbConcepto.Value.ToString();
            }

            LayoutItem LiCentroCosto = FormLayout.FindItemOrGroupByName("LiCentroCosto") as LayoutItem;
            ASPxTextBox txtCentroCosto = LiCentroCosto.GetNestedControl() as ASPxTextBox;
            string centroCosto = "";
            if (txtCentroCosto != null)
            {
                centroCosto = txtCentroCosto.Value.ToString();
            }

            LayoutItem LiCuentaContable = FormLayout.FindItemOrGroupByName("LiCuentaContable") as LayoutItem;
            ASPxTextBox txtCuentaContable = LiCuentaContable.GetNestedControl() as ASPxTextBox;
            string cuentaContable = "";
            if (txtCuentaContable != null)
            {
                cuentaContable = txtCuentaContable.Value.ToString();
            }

            ContratoBL oContrato = new ContratoBL();
            int resultado = oContrato.verificarExistenciaConfiguracion(empresa, tipo, Convert.ToInt32(concepto));
            if (resultado==1)
            {
                PAdvertencia.ShowOnPageLoad = true;
            }
            else
            {
                if (resultado==2)
                {
                    PError.ShowOnPageLoad = true;
                }
                else
                {
                    /*Conexión a la BD*/
                    string VconnectionString;
                    VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;
                    SqlConnection dbSQL = new SqlConnection(VconnectionString);

                    try
                    {
                        if (dbSQL.State != ConnectionState.Open)
                            dbSQL.Open();

                        string sentencia = "INSERT INTO CONFIGURACION_CENTRO_CUENTA(CIA,TIPO,CENTRO_COSTO,CUENTA,";
                        sentencia = sentencia + "ID_CONCEPTO) VALUES('" + empresa + "','" + tipo + "','" + centroCosto + "'," + cuentaContable + ",";
                        sentencia = sentencia + concepto + ");";
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
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ConfiguracionCuentaCentro.aspx");
        }
    }
}