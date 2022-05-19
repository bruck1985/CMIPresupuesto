using BusinessLogic.Clases;
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
    public partial class VerContratoNIFF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params["id"]!=null)
            {
                cargarEmpresas();
                string valor = "";
                valor = Request.Params["id"];
                ContratoBL objContrato = new ContratoBL();
                Contrato oContrato = new Contrato();
                oContrato = objContrato.obtenerContrato(Convert.ToInt32(valor));
                cbEmpresas.ValueType = typeof(String);
                cbEmpresas.Value = oContrato.Empresa;
                cbEmpresas.Enabled = false;
                txtNombreContrato.Text = oContrato.NombreContrato;
                txtNombreContrato.Enabled = false;
                txtPais.Text = oContrato.Pais;
                txtPais.Enabled = false;
                txtEntidad.Text = oContrato.Entidad;
                txtEntidad.Enabled = false;
                cbMonedaLocal.ValueType = typeof(Int32);
                cbMonedaLocal.Value = oContrato.MonedaLocal;
                cbMonedaLocal.Enabled = false;
                txtDescripcionActivo.Text = oContrato.DescripcionActivo;
                txtDescripcionActivo.Enabled = false;
                txtArrendador.Text = oContrato.Arrendador;
                txtArrendador.Enabled = false;
                rbtArrendador.Value = oContrato.ArrendadorAfiliado;
                rbtArrendador.Enabled = false;
                rbtnSubarriendo.Value = oContrato.Subarriendo.ToString();
                rbtnSubarriendo.Enabled = false;
                txtCuotaMensual.Text = oContrato.CuotaArrendamiento.ToString();
                txtCuotaMensual.Enabled = false;
                txtCantidadArrendamientos.Text = oContrato.CantidadArrendamiento.ToString();
                txtCantidadArrendamientos.Enabled = false;
                cbMonedaArrendamiento.ValueType = typeof(Int32);
                cbMonedaArrendamiento.Value = oContrato.MonedaArrendamiento;
                cbMonedaArrendamiento.Enabled = false;
                FechaInicial.Value = DateTime.Parse(oContrato.FechaInicioArrendamiento);
                FechaInicial.Enabled = false;
                FechaFinal.Value = DateTime.Parse(oContrato.FechaVencimientoArrendamiento);
                FechaFinal.Enabled = false;
                txtMesesTranscurridos.Text = oContrato.MesesTranscurridos.ToString();
                txtMesesTranscurridos.Enabled = false;
                txtMesesPendientes.Text = oContrato.MesesPendientes.ToString();
                txtMesesPendientes.Enabled = false;
                rbtnMayorAnio.Value = oContrato.PlazoContrato.ToString();
                rbtnMayorAnio.Enabled = false;
                txtMesesEfectivos.Text = oContrato.MesesEfectivos.ToString();
                txtMesesEfectivos.Enabled = false;
                txtFrecuenciaPagos.Text = oContrato.FrecuenciaPagos;
                txtFrecuenciaPagos.Enabled = false;
                rbtGarantias.Value = oContrato.GarantiaPagada.ToString();
                rbtGarantias.Enabled = false;
                txtGarantiaPagada.Text = oContrato.MontoGarantiaPagada.ToString();
                txtGarantiaPagada.Enabled = false;
                rbtnCostos.Value = oContrato.CostosIniciales.ToString();
                rbtnCostos.Enabled = false;
                txtDescripcionCostosIniciales.Text = oContrato.DescripcionCostos;
                txtDescripcionCostosIniciales.Enabled = false;
                rbtnOpcionCompra.Value = oContrato.OpcionCompra.ToString();
                rbtnOpcionCompra.Enabled = false;
                txtMontoOpcionCompra.Text = oContrato.MontoOpcionCompra.ToString();
                txtMontoOpcionCompra.Enabled = false;
                rbtnCostoDesmantelamiento.Value = oContrato.CostoDesmantelamiento.ToString();
                rbtnCostoDesmantelamiento.Enabled = false;
                txtCostoDesmantelamiento.Text = oContrato.MontoCostoDesmantelamiento.ToString();
                txtCostoDesmantelamiento.Enabled = false;
                rbtnClausulaExtension.Value = oContrato.ClausulaExtension.ToString();
                rbtnClausulaExtension.Enabled = false;
                txtPlazoClausulaExtension.Text = oContrato.PlazoClausula;
                txtPlazoClausulaExtension.Enabled = false;
                cboProbabilidadExtension.ValueType = typeof(Int32);
                cboProbabilidadExtension.Value = oContrato.ProbabilidadExtension;
                cboProbabilidadExtension.Enabled = false;
                rbtnTerminacionAnticipada.Value = oContrato.ClausulaTerminacion.ToString();
                rbtnTerminacionAnticipada.Enabled = false;
                cboProbabilidadTerminacion.ValueType = typeof(Int32);
                cboProbabilidadTerminacion.Value = oContrato.ProbabilidadTerminacion;
                cboProbabilidadTerminacion.Enabled = false;
                rbtnAumentoPagoMinimo.Value = oContrato.AumentoPagoMinimo.ToString();
                rbtnAumentoPagoMinimo.Enabled = false;
                txtPorcentajePagoMinimo.Text = oContrato.PorcentajeAumento.ToString();
                txtPorcentajePagoMinimo.Enabled = false;
                txtPeriocidadAumentoPagoMinimo.Text = oContrato.PerioricidadAumento;
                txtPeriocidadAumentoPagoMinimo.Enabled = false;
                txtTasaDescuento.Text = oContrato.TasaDescuento.ToString();
                txtTasaDescuento.Enabled = false;
                rbtnCostosIndirectos.Value = oContrato.CostosIndirectos.ToString();
                rbtnCostosIndirectos.Enabled = false;
                txtCostoIndirecto.Text = oContrato.MontoCostoIndirecto.ToString();
                txtCostoIndirecto.Enabled = false;
                rbtnValorResidual.Value = oContrato.ValorResidual.ToString();
                rbtnValorResidual.Enabled = false;
                txtValorResidual.Text = oContrato.MontoValorResidual.ToString();
                txtValorResidual.Enabled = false;
                rbtnArrendamientoCorto.Value = oContrato.CortoPlazo.ToString();
                rbtnArrendamientoCorto.Enabled = false;
                rbtnArredamientoBajo.Value = oContrato.BajoValor.ToString();
                rbtnArredamientoBajo.Enabled = false;
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
    }
}