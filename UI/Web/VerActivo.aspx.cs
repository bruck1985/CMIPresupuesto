using BusinessLogic.Clases;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utilitarios.Clases;

namespace UI.Web
{
    public partial class VerActivo : System.Web.UI.Page
    {
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
            if (Request.Params["empresa"] != null && Request.Params["activo"] != null && Request.Params["mejora"] != null)
            {
                cargarEmpresas();
                string empresa = "";
                string activo = "";
                string mejora = "";
                empresa = Request.Params["empresa"];
                activo = Request.Params["activo"];
                mejora = Request.Params["mejora"];
                Session["origen"] = Request.Params["origen"];
                ActivoBL objActivo = new ActivoBL();
                DataTable oActivo = new DataTable();
                oActivo = objActivo.obtenerActivoMejora(empresa, activo, mejora);
                cbEmpresas.ValueType = typeof(String);
                cbEmpresas.Value = oActivo.Rows[0].ItemArray[0].ToString();
                cbEmpresas.Enabled = false;

                txtCodigoActivo.Text = oActivo.Rows[0].ItemArray[2].ToString();
                txtCodigoActivo.Enabled = false;

                txtNombreActivo.Text = oActivo.Rows[0].ItemArray[3].ToString();
                txtNombreActivo.Enabled = false;

                txtCodigoMejora.Text = oActivo.Rows[0].ItemArray[41].ToString();
                txtCodigoMejora.Enabled = false;

                txtNombreMejora.Text = oActivo.Rows[0].ItemArray[42].ToString();
                txtNombreMejora.Enabled = false;

                txtTipoActivo.Text = oActivo.Rows[0].ItemArray[4].ToString();
                txtTipoActivo.Enabled = false;

                txtFechaAdquisicion.Text = oActivo.Rows[0].ItemArray[5].ToString();
                txtFechaAdquisicion.Enabled = false;

                txtFechaActivacion.Text = oActivo.Rows[0].ItemArray[6].ToString();
                txtFechaActivacion.Enabled = false;

                txtFechaUltimoMantenimiento.Text = oActivo.Rows[0].ItemArray[7].ToString();
                txtFechaUltimoMantenimiento.Enabled = false;

                txtFechaProximoMantenimiento.Text = oActivo.Rows[0].ItemArray[8].ToString();
                txtFechaProximoMantenimiento.Enabled = false;

                txtCodigoBarras.Text = oActivo.Rows[0].ItemArray[9].ToString();
                txtCodigoBarras.Enabled = false;

                txtResponsable.Text = oActivo.Rows[0].ItemArray[10].ToString();
                txtResponsable.Enabled = false;

                txtNumeroSerie.Text = oActivo.Rows[0].ItemArray[11].ToString();
                txtNumeroSerie.Enabled = false;

                txtUbicacion.Text = oActivo.Rows[0].ItemArray[12].ToString();
                txtUbicacion.Enabled = false;

                txtProveedor.Text = oActivo.Rows[0].ItemArray[13].ToString();
                txtProveedor.Enabled = false;

                txtClasificacion.Text = oActivo.Rows[0].ItemArray[14].ToString();
                txtClasificacion.Enabled = false;

                txtTipoDepreciacionFiscal.Text = oActivo.Rows[0].ItemArray[15].ToString();
                txtTipoDepreciacionFiscal.Enabled = false;

                txtPlazoVidaUtilFiscal.Text = oActivo.Rows[0].ItemArray[16].ToString();
                txtPlazoVidaUtilFiscal.Enabled = false;

                txtCostoLocalFiscal.Text = oActivo.Rows[0].ItemArray[17].ToString();
                txtCostoLocalFiscal.Enabled = false;

                txtCostoDolarFiscal.Text = oActivo.Rows[0].ItemArray[18].ToString();
                txtCostoDolarFiscal.Enabled = false;

                txtValorRescateLocalFiscal.Text = oActivo.Rows[0].ItemArray[19].ToString();
                txtValorRescateLocalFiscal.Enabled = false;

                txtValorRescateDolarFiscal.Text = oActivo.Rows[0].ItemArray[20].ToString();
                txtValorRescateDolarFiscal.Enabled = false;

                txtAsientoIngresoFiscal.Text = oActivo.Rows[0].ItemArray[21].ToString();
                txtAsientoIngresoFiscal.Enabled = false;

                txtUltimaDepreciacionFiscal.Text = oActivo.Rows[0].ItemArray[22].ToString();
                txtUltimaDepreciacionFiscal.Enabled = false;

                txtUltimaRevaluacionFiscal.Text = oActivo.Rows[0].ItemArray[23].ToString();
                txtUltimaRevaluacionFiscal.Enabled = false;

                txtTipoIndicePrecioFiscal.Text = oActivo.Rows[0].ItemArray[24].ToString();
                txtTipoIndicePrecioFiscal.Enabled = false;

                txtFechaRetiroFiscal.Text = oActivo.Rows[0].ItemArray[25].ToString();
                txtFechaRetiroFiscal.Enabled = false;

                txtUsuarioRetiroFiscal.Text = oActivo.Rows[0].ItemArray[26].ToString();
                txtUsuarioRetiroFiscal.Enabled = false;

                txtAsientoRetiroFiscal.Text = oActivo.Rows[0].ItemArray[27].ToString();
                txtAsientoRetiroFiscal.Enabled = false;

                txtTipoDepreciacionFinanciera.Text = oActivo.Rows[0].ItemArray[28].ToString();
                txtTipoDepreciacionFinanciera.Enabled = false;

                txtVidaUtilFinanciera.Text = oActivo.Rows[0].ItemArray[29].ToString();
                txtVidaUtilFinanciera.Enabled = false;

                txtCostoLocalFinanciera.Text = oActivo.Rows[0].ItemArray[30].ToString();
                txtCostoLocalFinanciera.Enabled = false;

                txtCostoDolarFinanciera.Text = oActivo.Rows[0].ItemArray[31].ToString();
                txtCostoDolarFinanciera.Enabled = false;

                txtValorRescateLocalFinanciera.Text = oActivo.Rows[0].ItemArray[32].ToString();
                txtValorRescateLocalFinanciera.Enabled = false;

                txtValorRescateDolarFinanciera.Text = oActivo.Rows[0].ItemArray[33].ToString();
                txtValorRescateDolarFinanciera.Enabled = false;

                txtAsientoIngresoFinanciera.Text = oActivo.Rows[0].ItemArray[34].ToString();
                txtAsientoIngresoFinanciera.Enabled = false;

                txtUltimaDepreciacionFinanciera.Text = oActivo.Rows[0].ItemArray[35].ToString();
                txtUltimaDepreciacionFinanciera.Enabled = false;

                txtUltimaRevaluacionFinanciera.Text = oActivo.Rows[0].ItemArray[36].ToString();
                txtUltimaRevaluacionFinanciera.Enabled = false;

                txtUsuarioRetiroFinanciera.Text = oActivo.Rows[0].ItemArray[37].ToString();
                txtUsuarioRetiroFinanciera.Enabled = false;

                txtAsientoRetiroFinanciera.Text = oActivo.Rows[0].ItemArray[38].ToString();
                txtAsientoRetiroFinanciera.Enabled = false;

                txtValorLibrosLocal.Text = oActivo.Rows[0].ItemArray[44].ToString(); ;
                txtValorLibrosLocal.Enabled = false;

                txtValorLibrosDolar.Text = oActivo.Rows[0].ItemArray[45].ToString();
                txtValorLibrosDolar.Enabled = false;

                txtEstado.Text = oActivo.Rows[0].ItemArray[46].ToString(); 
                txtEstado.Enabled = false;

                txtNombreResponsable.Text = oActivo.Rows[0].ItemArray[47].ToString(); 
                txtNombreResponsable.Enabled = false;

                txtNombreUbicacion.Text = oActivo.Rows[0].ItemArray[48].ToString(); 
                txtNombreUbicacion.Enabled = false;

                txtFechaUltimoInventario.Text = oActivo.Rows[0].ItemArray[43].ToString();
                txtFechaUltimoInventario.Enabled = false;
            }
        }

        private void cargarEmpresas()
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

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
    }
}
