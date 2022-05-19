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
    public partial class NuevoContratoNIFF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                cargarEmpresas();
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

        protected void Lform_E3_Click(object sender, EventArgs e)
        {
            LayoutItem nombContrato= FormLayout.FindItemOrGroupByName("LiContrato") as LayoutItem;
            ASPxTextBox txtNombreContrato = nombContrato.GetNestedControl() as ASPxTextBox;

            string contrato = "";
            if (txtNombreContrato!=null)
            {
                contrato = txtNombreContrato.Value.ToString();
            }

            LayoutItem LiEmpresa = FormLayout.FindItemOrGroupByName("LiEmpresa") as LayoutItem;
            ASPxComboBox CboEmpresa = LiEmpresa.GetNestedControl() as ASPxComboBox;
            string empresa = "";
            if (CboEmpresa != null)
            {
                empresa = CboEmpresa.Value.ToString();
            }

            LayoutItem LiPais = FormLayout.FindItemOrGroupByName("LiPais") as LayoutItem;
            ASPxTextBox txtNombrePais = LiPais.GetNestedControl() as ASPxTextBox;
            string nombrePais = "";
            if (txtNombrePais!=null)
            {
                nombrePais = txtNombrePais.Value.ToString();
            }

            LayoutItem LiEntidad = FormLayout.FindItemOrGroupByName("LiEntidad") as LayoutItem;
            ASPxTextBox txtNombreEntidad = LiEntidad.GetNestedControl() as ASPxTextBox;
            string nombreEntidad = "";
            if (txtNombreEntidad != null)
            {
                nombreEntidad = txtNombreEntidad.Value.ToString();
            }

            LayoutItem LiMonedaLocal = FormLayout.FindItemOrGroupByName("LiMonedaLocal") as LayoutItem;
            ASPxComboBox CboMonedaLocal = LiMonedaLocal.GetNestedControl() as ASPxComboBox;
            string monedaLocal = "";
            if (CboMonedaLocal != null)
            {
                monedaLocal = CboMonedaLocal.Value.ToString();
            }

            LayoutItem LiDescripcionActivo = FormLayout.FindItemOrGroupByName("LiDescripcionActivo") as LayoutItem;
            ASPxTextBox txtDescripcionActivo = LiDescripcionActivo.GetNestedControl() as ASPxTextBox;
            string activo = "";
            if (txtDescripcionActivo != null)
            {
                activo = txtDescripcionActivo.Value.ToString();
            }

            LayoutItem LiArrendador = FormLayout.FindItemOrGroupByName("LiArrendador") as LayoutItem;
            ASPxTextBox txtArrendador = LiArrendador.GetNestedControl() as ASPxTextBox;
            string arrendador = "";
            if (txtArrendador != null)
            {
                arrendador = txtArrendador.Value.ToString();
            }

            LayoutItem LiAfiliado = FormLayout.FindItemOrGroupByName("LiAfiliado") as LayoutItem;
            ASPxRadioButtonList rbtnAfiliado = LiAfiliado.GetNestedControl() as ASPxRadioButtonList;
            string esAfiliado = "";
            if (rbtnAfiliado != null)
            {
                esAfiliado = rbtnAfiliado.Value.ToString();
            }

            LayoutItem LiArriendo = FormLayout.FindItemOrGroupByName("LiArriendo") as LayoutItem;
            ASPxRadioButtonList rbtnArriendo = LiArriendo.GetNestedControl() as ASPxRadioButtonList;
            string esArriendo = "";
            if (rbtnArriendo != null)
            {
                esArriendo = rbtnArriendo.Value.ToString();
            }

            LayoutItem LiCuotaArriendo = FormLayout.FindItemOrGroupByName("LiCuotaArriendo") as LayoutItem;
            ASPxSpinEdit spnCuotaArriendo = LiCuotaArriendo.GetNestedControl() as ASPxSpinEdit;
            string cuotaArriendo = "";
            if (spnCuotaArriendo != null)
            {
                cuotaArriendo = spnCuotaArriendo.Value.ToString();
            }

            LayoutItem LiCantidadArrendamientos = FormLayout.FindItemOrGroupByName("LiCantidadArrendamientos") as LayoutItem;
            ASPxSpinEdit txtCantidadArrendamientos = LiCantidadArrendamientos.GetNestedControl() as ASPxSpinEdit;
            string cantidadArrendamientos = "";
            if (txtCantidadArrendamientos != null)
            {
                cantidadArrendamientos = txtCantidadArrendamientos.Value.ToString();
            }

            LayoutItem LiMonedaArrendamiento = FormLayout.FindItemOrGroupByName("LiMonedaArrendamiento") as LayoutItem;
            ASPxComboBox CboMonedaArrendamiento = LiMonedaArrendamiento.GetNestedControl() as ASPxComboBox;
            string monedaArrendamiento = "";
            if (CboMonedaArrendamiento != null)
            {
                monedaArrendamiento = CboMonedaArrendamiento.Value.ToString();
            }

            LayoutItem LifechaInicioArrendamiento = FormLayout.FindItemOrGroupByName("LifechaInicioArrendamiento") as LayoutItem;
            ASPxDateEdit txtFechaInicioArrendamiento = LifechaInicioArrendamiento.GetNestedControl() as ASPxDateEdit;
            string fechaInicioArrendamiento = "";
            if (txtFechaInicioArrendamiento != null)
            {
                fechaInicioArrendamiento = txtFechaInicioArrendamiento.Value.ToString();
            }

            LayoutItem LifechaVencimientoArrendamiento = FormLayout.FindItemOrGroupByName("LifechaVencimientoArrendamiento") as LayoutItem;
            ASPxDateEdit txtFechaFinArrendamiento = LifechaVencimientoArrendamiento.GetNestedControl() as ASPxDateEdit;
            string fechaFinArrendamiento = "";
            if (txtFechaFinArrendamiento != null)
            {
                fechaFinArrendamiento = txtFechaFinArrendamiento.Value.ToString();
            }

            LayoutItem LiMesesTranscurridos = FormLayout.FindItemOrGroupByName("LiMesesTranscurridos") as LayoutItem;
            ASPxSpinEdit spnMesesTranscurridos = LiMesesTranscurridos.GetNestedControl() as ASPxSpinEdit;
            string mesesTranscurridos = "";
            if (spnMesesTranscurridos != null)
            {
                mesesTranscurridos = spnMesesTranscurridos.Value.ToString();
            }

            LayoutItem LiMesesPendientes = FormLayout.FindItemOrGroupByName("LiMesesPendientes") as LayoutItem;
            ASPxSpinEdit spnMesesPendientes = LiMesesPendientes.GetNestedControl() as ASPxSpinEdit;
            string mesesPendientes = "";
            if (spnMesesPendientes != null)
            {
                mesesPendientes = spnMesesPendientes.Value.ToString();
            }

            LayoutItem LiPlazoContrato = FormLayout.FindItemOrGroupByName("LiPlazoContrato") as LayoutItem;
            ASPxRadioButtonList txtPlazoContrato = LiPlazoContrato.GetNestedControl() as ASPxRadioButtonList;
            string plazoContrato = "";
            if (txtPlazoContrato != null)
            {
                plazoContrato = txtPlazoContrato.Value.ToString();
            }

            LayoutItem LiMesesEfectivos = FormLayout.FindItemOrGroupByName("LiMesesEfectivos") as LayoutItem;
            ASPxSpinEdit spnMesesEfectivos = LiMesesEfectivos.GetNestedControl() as ASPxSpinEdit;
            string mesesEfectivos = "";
            if (spnMesesEfectivos != null)
            {
                mesesEfectivos = spnMesesEfectivos.Value.ToString();
            }

            LayoutItem LiFrecuenciaPagos = FormLayout.FindItemOrGroupByName("LiFrecuenciaPagos") as LayoutItem;
            ASPxTextBox txtFrecuenciaPagos = LiFrecuenciaPagos.GetNestedControl() as ASPxTextBox;
            string frecuenciaPagos = "";
            if (txtFrecuenciaPagos != null)
            {
                frecuenciaPagos = txtFrecuenciaPagos.Value.ToString();
            }

            LayoutItem LiExisteGarantiaPagadas = FormLayout.FindItemOrGroupByName("LiExisteGarantiaPagadas") as LayoutItem;
            ASPxRadioButtonList rbtnExisteGarantiaPagadas = LiExisteGarantiaPagadas.GetNestedControl() as ASPxRadioButtonList;
            string existeGarantiaPagadas = "";
            if (rbtnExisteGarantiaPagadas != null)
            {
                existeGarantiaPagadas = rbtnExisteGarantiaPagadas.Value.ToString();
            }

            LayoutItem LiMontoGarantiaPagadas = FormLayout.FindItemOrGroupByName("LiMontoGarantiaPagadas") as LayoutItem;
            ASPxSpinEdit spnMontoGarantiaPagadas = LiMontoGarantiaPagadas.GetNestedControl() as ASPxSpinEdit;
            string montoGarantiaPagadas = "";
            if (spnMontoGarantiaPagadas != null)
            {
                montoGarantiaPagadas = spnMontoGarantiaPagadas.Value.ToString();
            }

            LayoutItem LiExisteCostoIniciales = FormLayout.FindItemOrGroupByName("LiExisteCostoIniciales") as LayoutItem;
            ASPxRadioButtonList rbtnExisteCostoIniciales = LiExisteCostoIniciales.GetNestedControl() as ASPxRadioButtonList;
            string existeCostoIniciales = "";
            if (rbtnExisteCostoIniciales != null)
            {
                existeCostoIniciales = rbtnExisteCostoIniciales.Value.ToString();
            }

            LayoutItem LiDescripcionCostoIniciales = FormLayout.FindItemOrGroupByName("LiDescripcionCostoIniciales") as LayoutItem;
            ASPxTextBox txtDescripcionCostoIniciales = LiDescripcionCostoIniciales.GetNestedControl() as ASPxTextBox;
            string descripcionCostosIniciales = "";
            if (txtDescripcionCostoIniciales != null)
            {
                descripcionCostosIniciales = txtDescripcionCostoIniciales.Value.ToString();
            }

            LayoutItem LiExisteOpcionCompra = FormLayout.FindItemOrGroupByName("LiExisteOpcionCompra") as LayoutItem;
            ASPxRadioButtonList rbtnExisteOpcionCompra = LiExisteOpcionCompra.GetNestedControl() as ASPxRadioButtonList;
            string existeOpcionCompra = "";
            if (rbtnExisteOpcionCompra != null)
            {
                existeOpcionCompra = rbtnExisteOpcionCompra.Value.ToString();
            }

            LayoutItem LiMontoOpcionCompra = FormLayout.FindItemOrGroupByName("LiMontoOpcionCompra") as LayoutItem;
            ASPxSpinEdit spnMontoOpcionCompra = LiMontoOpcionCompra.GetNestedControl() as ASPxSpinEdit;
            string montoOpcionCompra = "";
            if (spnMontoOpcionCompra != null)
            {
                montoOpcionCompra = spnMontoOpcionCompra.Value.ToString();
            }

            LayoutItem LiExisteCostoDesmantelamiento = FormLayout.FindItemOrGroupByName("LiExisteCostoDesmantelamiento") as LayoutItem;
            ASPxRadioButtonList rbtnExisteCostoDesmantelamiento = LiExisteCostoDesmantelamiento.GetNestedControl() as ASPxRadioButtonList;
            string existeCostoDesmantelamiento = "";
            if (rbtnExisteCostoDesmantelamiento != null)
            {
                existeCostoDesmantelamiento = rbtnExisteCostoDesmantelamiento.Value.ToString();
            }

            LayoutItem LiMontoCostoDesmantelamiento = FormLayout.FindItemOrGroupByName("LiMontoCostoDesmantelamiento") as LayoutItem;
            ASPxSpinEdit spnMontoCostoDesmantelamiento = LiMontoCostoDesmantelamiento.GetNestedControl() as ASPxSpinEdit;
            string montoOpcionDesmantelamiento = "";
            if (spnMontoCostoDesmantelamiento != null)
            {
                montoOpcionDesmantelamiento = spnMontoCostoDesmantelamiento.Value.ToString();
            }

            LayoutItem LiExisteExtension = FormLayout.FindItemOrGroupByName("LiExisteExtension") as LayoutItem;
            ASPxRadioButtonList rbtnExisteExtension = LiExisteExtension.GetNestedControl() as ASPxRadioButtonList;
            string existeExtension = "";
            if (rbtnExisteExtension != null)
            {
                existeExtension = rbtnExisteExtension.Value.ToString();
            }

            LayoutItem LiPlazoExtension = FormLayout.FindItemOrGroupByName("LiPlazoExtension") as LayoutItem;
            ASPxTextBox txtPlazoExtension = LiPlazoExtension.GetNestedControl() as ASPxTextBox;
            string plazoExtension = "";
            if (txtPlazoExtension != null)
            {
                plazoExtension = txtPlazoExtension.Value.ToString();
            }

            LayoutItem LiProbabilidadExtension = FormLayout.FindItemOrGroupByName("LiProbabilidadExtension") as LayoutItem;
            ASPxComboBox CboProbabilidadExtension = LiProbabilidadExtension.GetNestedControl() as ASPxComboBox;
            string probabilidadExtension = "";
            if (CboProbabilidadExtension != null)
            {
                probabilidadExtension = CboProbabilidadExtension.Value.ToString();
            }

            LayoutItem LiTerminacion = FormLayout.FindItemOrGroupByName("LiTerminacion") as LayoutItem;
            ASPxRadioButtonList rbtnClausulaTerminacion = LiTerminacion.GetNestedControl() as ASPxRadioButtonList;
            string clausulaterminacion = "";
            if (rbtnClausulaTerminacion != null)
            {
                clausulaterminacion = rbtnClausulaTerminacion.Value.ToString();
            }

            LayoutItem LiProbabilidadTerminacion = FormLayout.FindItemOrGroupByName("LiProbabilidadTerminacion") as LayoutItem;
            ASPxComboBox CboProbabilidadTerminacion = LiProbabilidadTerminacion.GetNestedControl() as ASPxComboBox;
            string probabilidadTerminacion = "";
            if (CboProbabilidadTerminacion != null)
            {
                probabilidadTerminacion = CboProbabilidadTerminacion.Value.ToString();
            }

            LayoutItem LiExistePagoMinimo = FormLayout.FindItemOrGroupByName("LiExistePagoMinimo") as LayoutItem;
            ASPxRadioButtonList rbtnExistePagoMinimo = LiExistePagoMinimo.GetNestedControl() as ASPxRadioButtonList;
            string existePagoMinimo = "";
            if (rbtnExistePagoMinimo != null)
            {
                existePagoMinimo = rbtnExistePagoMinimo.Value.ToString();
            }

            LayoutItem LiPorcentajePagoMinimo = FormLayout.FindItemOrGroupByName("LiPorcentajePagoMinimo") as LayoutItem;
            ASPxSpinEdit spnPorcentajePagoMinimo = LiPorcentajePagoMinimo.GetNestedControl() as ASPxSpinEdit;
            string porcentajePagoMinimo = "";
            if (spnPorcentajePagoMinimo != null)
            {
                porcentajePagoMinimo = spnPorcentajePagoMinimo.Value.ToString();
            }

            LayoutItem LiPerioricidadPagoMinimo = FormLayout.FindItemOrGroupByName("LiPerioricidadPagoMinimo") as LayoutItem;
            ASPxSpinEdit txtPerioricidadPagoMinimo = LiPerioricidadPagoMinimo.GetNestedControl() as ASPxSpinEdit;
            string perioricidadPagoMinimo = "";
            if (txtPerioricidadPagoMinimo != null)
            {
                perioricidadPagoMinimo = txtPerioricidadPagoMinimo.Value.ToString();
            }

            LayoutItem LiTasaDescuento = FormLayout.FindItemOrGroupByName("LiTasaDescuento") as LayoutItem;
            ASPxSpinEdit spnTasaDescuento = LiTasaDescuento.GetNestedControl() as ASPxSpinEdit;
            string tasaDescuento= "";
            if (spnTasaDescuento != null)
            {
                tasaDescuento = spnTasaDescuento.Value.ToString();
            }

            LayoutItem LiExisteCostoIndirectos = FormLayout.FindItemOrGroupByName("LiExisteCostoIndirectos") as LayoutItem;
            ASPxRadioButtonList rbtnExisteCostoIndirectos = LiExisteCostoIndirectos.GetNestedControl() as ASPxRadioButtonList;
            string existeCostoIndirectos = "";
            if (rbtnExisteCostoIndirectos != null)
            {
                existeCostoIndirectos = rbtnExisteCostoIndirectos.Value.ToString();
            }

            LayoutItem LiMontoCostoIndirecto = FormLayout.FindItemOrGroupByName("LiMontoCostoIndirecto") as LayoutItem;
            ASPxSpinEdit spnMontoCostoIndirecto = LiMontoCostoIndirecto.GetNestedControl() as ASPxSpinEdit;
            string montoCostoIndirecto = "";
            if (spnMontoCostoIndirecto != null)
            {
                montoCostoIndirecto = spnMontoCostoIndirecto.Value.ToString();
            }

            LayoutItem LiExisteValorResidual = FormLayout.FindItemOrGroupByName("LiExisteValorResidual") as LayoutItem;
            ASPxRadioButtonList rbtnExisteValorResidual = LiExisteValorResidual.GetNestedControl() as ASPxRadioButtonList;
            string existeValorResidual = "";
            if (rbtnExisteValorResidual != null)
            {
                existeValorResidual = rbtnExisteValorResidual.Value.ToString();
            }

            LayoutItem LiMontoValorResidual = FormLayout.FindItemOrGroupByName("LiMontoValorResidual") as LayoutItem;
            ASPxSpinEdit spnMontoValorResidual = LiMontoValorResidual.GetNestedControl() as ASPxSpinEdit;
            string montoValorResidual = "";
            if (spnMontoValorResidual != null)
            {
                montoValorResidual = spnMontoValorResidual.Value.ToString();
            }

            LayoutItem LiRepresentaCortoPlazo = FormLayout.FindItemOrGroupByName("LiRepresentaCortoPlazo") as LayoutItem;
            ASPxRadioButtonList rbtnRepresentaCortoPlazo = LiRepresentaCortoPlazo.GetNestedControl() as ASPxRadioButtonList;
            string representaCortoPlazo = "";
            if (rbtnRepresentaCortoPlazo != null)
            {
                representaCortoPlazo = rbtnRepresentaCortoPlazo.Value.ToString();
            }

            LayoutItem LiRepresentaBajoValor = FormLayout.FindItemOrGroupByName("LiRepresentaBajoValor") as LayoutItem;
            ASPxRadioButtonList rbtnRepresentaBajoValor = LiRepresentaBajoValor.GetNestedControl() as ASPxRadioButtonList;
            string representaBajoValor = "";
            if (rbtnRepresentaBajoValor != null)
            {
                representaBajoValor = rbtnRepresentaBajoValor.Value.ToString();
            }

            /*Conexión a la BD*/
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;
            SqlConnection dbSQL = new SqlConnection(VconnectionString);
            SqlDataReader MIDataReader;

            try
            {
                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();

                string sentencia = "INSERT INTO CONTRATO_NIIF(NOMBRE_CONTRATO,PAIS,ENTIDAD,MONEDA_LOCAL,";
                sentencia = sentencia + "DESCRIPCION_ACTIVO, ARRENDADOR,ARRENDADOR_AFILIADO,SUBARRIENDO,";
                sentencia = sentencia + "CUOTA_ARRENDAMIENTO,CANTIDAD_ARRENDAMIENTO,MONEDA_ARRENDAMIENTO,";
                sentencia = sentencia + "FECHA_INICIO_ARREN,FECHA_VENCI_ARREN,MESES_TRANSCURRIDOS,MESES_PENDIENTES,";
                sentencia = sentencia + "PLAZO_CONTRATO,MESES_EFECTIVOS,FRECUENCIA_PAGOS,GARANTIA_PAGADA,";
                sentencia = sentencia + "MONTO_GARANTIA_PAGADA,COSTOS_INICIALES,DESCRIPCION_COSTOS,OPCION_COMPRA,";
                sentencia = sentencia + "MONTO_OPCION_COMPRA,COSTO_DESMANTELAMIENTO,MONTO_COSTO_DESMANTELAMIENTO,";
                sentencia = sentencia + "CLAUSULA_EXTENSION,PLAZO_CLAUSULA,PROBABILIDAD_EXTENSION,CLAUSULA_TERMINACION,";
                sentencia = sentencia + "PROBABILIDAD_TERMINACION,AUMENTO_PAGO_MINIMO,PORCENTAJE_AUMENTO,";
                sentencia = sentencia + "PERIORICIDAD_AUMENTO,COSTOS_INDIRECTOS,MONTO_COSTO_INDIRECTO,";
                sentencia = sentencia + "VALOR_RESIDUAL,MONTO_VALOR_RESIDUAL,CORTO_PLAZO,BAJO_VALOR,USUARIO_CREACION,";
                sentencia = sentencia + "FECHA_CREACION,TASA_ANUAL,PERIORICIDAD_CUOTA,TASA_DESCUENTO,EMPRESA) VALUES('" + contrato + "','" + nombrePais + "','" + nombreEntidad + "'," + monedaLocal + ",";
                sentencia = sentencia + "'" + activo + "','" + arrendador + "'," + esAfiliado + "," + esArriendo + ",";
                sentencia = sentencia + cuotaArriendo + "," + cantidadArrendamientos + "," + monedaArrendamiento + ",";

                fechaInicioArrendamiento = fechaInicioArrendamiento.Substring(6, 4) + "-" + fechaInicioArrendamiento.Substring(3, 2) + "-" + fechaInicioArrendamiento.Substring(0, 2);
                fechaFinArrendamiento = fechaFinArrendamiento.Substring(6, 4) + "-" + fechaFinArrendamiento.Substring(3, 2) + "-" + fechaFinArrendamiento.Substring(0, 2);

                sentencia = sentencia + "'" + fechaInicioArrendamiento + "','" + fechaFinArrendamiento + "'," + mesesTranscurridos + "," + mesesPendientes + ",";
                sentencia = sentencia + "'" + plazoContrato + "'," + mesesEfectivos + ",'" + frecuenciaPagos + "'," + existeGarantiaPagadas + ",";
                sentencia = sentencia + montoGarantiaPagadas + "," + existeCostoIniciales + ",'" + descripcionCostosIniciales + "'," + existeOpcionCompra + ",";
                sentencia = sentencia + montoOpcionCompra + "," + existeCostoDesmantelamiento + "," + montoOpcionDesmantelamiento + ",";
                sentencia = sentencia + existeExtension + ",'" + plazoExtension + "'," + probabilidadExtension +"," + clausulaterminacion + ",";
                sentencia = sentencia + probabilidadTerminacion + "," + existePagoMinimo + "," + porcentajePagoMinimo + ",";
                sentencia = sentencia + "'" + perioricidadPagoMinimo + "'," + existeCostoIndirectos + "," + montoCostoIndirecto + ",";
                sentencia = sentencia + existeValorResidual + "," + montoValorResidual + "," + representaCortoPlazo + "," + representaBajoValor + ",'usuario', GETDATE()," + porcentajePagoMinimo + "," + perioricidadPagoMinimo + ",";
                sentencia = sentencia + tasaDescuento +",'" + empresa +"'); ";
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

            /*Se ejecuta el proceso de cuotas anuales*/
            try
            {
                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();

                string sentencia = "PORTAL_CUOTA_ANUAL";
                SqlCommand ComandoConsulta = new SqlCommand();
                ComandoConsulta.CommandType = CommandType.StoredProcedure;
                ComandoConsulta.CommandText = sentencia;
                ComandoConsulta.Connection = dbSQL;
                SqlDataReader dr1 = ComandoConsulta.ExecuteReader();
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
            }
            finally {
                if (dbSQL.State == ConnectionState.Open)
                    dbSQL.Close();
            }

            /*Se ejecuta el proceso de descuento de valor activo*/
            try
            {
                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();

                string sentencia = "PORTAL_DSCTO_VALOR_ACTIVO";
                SqlCommand ComandoConsulta = new SqlCommand();
                ComandoConsulta.CommandType = CommandType.StoredProcedure;
                ComandoConsulta.CommandText = sentencia;
                ComandoConsulta.Connection = dbSQL;
                SqlDataReader dr1 = ComandoConsulta.ExecuteReader();
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

            /*Se ejecuta el proceso de amortización de arrendamiento*/
            try
            {
                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();

                string sentencia = "PORTAL_AMORTIZACION_ARRENDAMIENTO";
                SqlCommand ComandoConsulta = new SqlCommand();
                ComandoConsulta.CommandType = CommandType.StoredProcedure;
                ComandoConsulta.CommandText = sentencia;
                ComandoConsulta.Connection = dbSQL;
                SqlDataReader dr1 = ComandoConsulta.ExecuteReader();
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

            /*Se ejecuta el proceso de arrendamiento corporativo*/
            try
            {
                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();

                string sentencia = "PORTAL_ARRENDAMIENTO_CORPORATIVO";
                SqlCommand ComandoConsulta = new SqlCommand();
                ComandoConsulta.CommandType = CommandType.StoredProcedure;
                ComandoConsulta.CommandText = sentencia;
                ComandoConsulta.Connection = dbSQL;
                SqlDataReader dr1 = ComandoConsulta.ExecuteReader();
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
            Response.Redirect("ContratoNIFF.aspx");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ContratoNIFF.aspx");
        }
    }
}