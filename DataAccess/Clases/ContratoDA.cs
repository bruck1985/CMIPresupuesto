using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilitarios.Clases;

namespace DataAccess.Clases
{
    public class ContratoDA
    {
        private SqlConnection oConexion;
        private SqlCommand oComando;
        private string strConexion;

        public ContratoDA()
        {
            ClsTraductor clsT = new ClsTraductor();
            //strConexion = clsT.TradPass(ConfigurationManager.AppSettings.Get("ConexionSQL").ToString());
            strConexion = clsT.TradPass(ConfigurationManager.AppSettings.Get("ConexionSQLPortal").ToString());
        }

        public Contrato obtenerContrato(int pIdContrato)
        {
            Contrato oContrato = new Contrato();
            string strQuery = string.Empty;
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("obtenerContrato", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@idContrato", pIdContrato);
                dtrResult = oComando.ExecuteReader();
                dtResult.Load(dtrResult);
                if (dtResult.Rows.Count == 0)
                {
                    return null;
                }

                foreach (DataRow dtrFila in dtResult.Rows)
                {
                    oContrato = new Contrato();
                    oContrato.IdContrato = Convert.ToInt32(dtrFila["CONTRATO_ID"].ToString());
                    oContrato.NombreContrato = dtrFila["NOMBRE_CONTRATO"].ToString();
                    oContrato.Pais = dtrFila["PAIS"].ToString();
                    oContrato.Entidad = dtrFila["ENTIDAD"].ToString();
                    oContrato.MonedaLocal = Convert.ToInt32(dtrFila["MONEDA_LOCAL"].ToString());
                    oContrato.DescripcionActivo = dtrFila["DESCRIPCION_ACTIVO"].ToString();
                    oContrato.Arrendador = dtrFila["ARRENDADOR"].ToString();
                    oContrato.ArrendadorAfiliado = dtrFila["ARRENDADOR_AFILIADO"].ToString();
                    oContrato.Subarriendo = Convert.ToInt32(dtrFila["SUBARRIENDO"].ToString());
                    oContrato.CuotaArrendamiento = Convert.ToDecimal(dtrFila["CUOTA_ARRENDAMIENTO"].ToString());
                    oContrato.CantidadArrendamiento = Convert.ToInt32(dtrFila["CANTIDAD_ARRENDAMIENTO"].ToString());
                    oContrato.MonedaArrendamiento = Convert.ToInt32(dtrFila["MONEDA_ARRENDAMIENTO"].ToString());
                    oContrato.FechaInicioArrendamiento = dtrFila["FECHA_INICIO_ARREN"].ToString();
                    oContrato.FechaVencimientoArrendamiento = dtrFila["FECHA_VENCI_ARREN"].ToString();
                    oContrato.MesesTranscurridos = Convert.ToInt32(dtrFila["MESES_TRANSCURRIDOS"].ToString());
                    oContrato.MesesPendientes = Convert.ToInt32(dtrFila["MESES_PENDIENTES"].ToString());
                    oContrato.PlazoContrato = dtrFila["PLAZO_CONTRATO"].ToString();
                    oContrato.MesesEfectivos = Convert.ToInt32(dtrFila["MESES_EFECTIVOS"].ToString());
                    oContrato.FrecuenciaPagos = dtrFila["FRECUENCIA_PAGOS"].ToString();
                    oContrato.GarantiaPagada = Convert.ToInt32(dtrFila["GARANTIA_PAGADA"].ToString());
                    oContrato.MontoGarantiaPagada = Convert.ToDecimal(dtrFila["MONTO_GARANTIA_PAGADA"].ToString());
                    oContrato.CostosIniciales = Convert.ToInt32(dtrFila["COSTOS_INICIALES"].ToString());
                    oContrato.DescripcionCostos = dtrFila["DESCRIPCION_COSTOS"].ToString();
                    oContrato.OpcionCompra = Convert.ToInt32(dtrFila["OPCION_COMPRA"].ToString());
                    oContrato.MontoOpcionCompra = Convert.ToDecimal(dtrFila["MONTO_OPCION_COMPRA"].ToString());
                    oContrato.CostoDesmantelamiento = Convert.ToInt32(dtrFila["COSTO_DESMANTELAMIENTO"].ToString());
                    oContrato.MontoCostoDesmantelamiento = Convert.ToDecimal(dtrFila["MONTO_COSTO_DESMANTELAMIENTO"].ToString());
                    oContrato.ClausulaExtension = Convert.ToInt32(dtrFila["CLAUSULA_EXTENSION"].ToString());
                    oContrato.PlazoClausula = dtrFila["PLAZO_CLAUSULA"].ToString();
                    oContrato.ProbabilidadExtension = Convert.ToInt32(dtrFila["PROBABILIDAD_EXTENSION"].ToString());
                    oContrato.ClausulaTerminacion = Convert.ToInt32(dtrFila["CLAUSULA_TERMINACION"].ToString());
                    oContrato.ProbabilidadTerminacion = Convert.ToInt32(dtrFila["PROBABILIDAD_TERMINACION"].ToString());
                    oContrato.AumentoPagoMinimo = Convert.ToInt32(dtrFila["AUMENTO_PAGO_MINIMO"].ToString());
                    oContrato.PorcentajeAumento = Convert.ToDecimal(dtrFila["PORCENTAJE_AUMENTO"].ToString());
                    oContrato.PerioricidadAumento = dtrFila["PERIORICIDAD_AUMENTO"].ToString();
                    oContrato.CostosIndirectos = Convert.ToInt32(dtrFila["COSTOS_INDIRECTOS"].ToString());
                    oContrato.MontoCostoIndirecto = Convert.ToDecimal(dtrFila["MONTO_COSTO_INDIRECTO"].ToString());
                    oContrato.ValorResidual = Convert.ToInt32(dtrFila["VALOR_RESIDUAL"].ToString());
                    oContrato.MontoValorResidual = Convert.ToDecimal(dtrFila["MONTO_VALOR_RESIDUAL"].ToString());
                    oContrato.CortoPlazo = Convert.ToInt32(dtrFila["CORTO_PLAZO"].ToString());
                    oContrato.BajoValor = Convert.ToInt32(dtrFila["BAJO_VALOR"].ToString());
                    oContrato.TasaAnual = Convert.ToDecimal(dtrFila["TASA_ANUAL"].ToString());
                    oContrato.PerioricidadCuota = Convert.ToInt32(dtrFila["PERIORICIDAD_CUOTA"].ToString());
                    oContrato.TasaDescuento = Convert.ToDecimal(dtrFila["TASA_DESCUENTO"].ToString());
                    oContrato.Empresa = dtrFila["EMPRESA"].ToString();
                }
                return oContrato;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                oConexion.Close();
            }
        }

        public List<CuotaAnual> obtenerCuotasAnualesContrato(int pIdContrato)
        {
            List<CuotaAnual> lstCuotas = new List<CuotaAnual>();
            string strQuery = string.Empty;
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_LISTAR_CUOTA_ANUAL", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@idContrato", pIdContrato);
                dtrResult = oComando.ExecuteReader();
                dtResult.Load(dtrResult);
                if (dtResult.Rows.Count == 0)
                {
                    return null;
                }

                foreach (DataRow dtrFila in dtResult.Rows)
                {
                    CuotaAnual oCuota = new CuotaAnual();
                    oCuota.Anio = Convert.ToInt32(dtrFila["ANIO"].ToString());
                    oCuota.NroCuota = Convert.ToInt32(dtrFila["NRO_CUOTA"].ToString());
                    oCuota.MontoCuotaAnual = Decimal.Parse(dtrFila["CUOTA_ANUAL"].ToString());
                    oCuota.PrimerTramo = Decimal.Parse(dtrFila["PRIMER_TRAMO"].ToString());
                    oCuota.SegundoTramo = Decimal.Parse(dtrFila["SEGUNDO_TRAMO"].ToString());
                    oCuota.CuotaAnualFinal = Decimal.Parse(dtrFila["CUOTA_ANUAL_FINAL"].ToString());
                    lstCuotas.Add(oCuota);
                }
                return lstCuotas;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                oConexion.Close();
            }
        }

        public List<Valor_Activo> obtenerDescuentoValorActivo(int pIdContrato)
        {
            List<Valor_Activo> lstValores = new List<Valor_Activo>();
            string strQuery = string.Empty;
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_LISTAR_DSCTO_VALOR_ACTIVO", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@idContrato", pIdContrato);
                dtrResult = oComando.ExecuteReader();
                dtResult.Load(dtrResult);
                if (dtResult.Rows.Count == 0)
                {
                    return null;
                }

                foreach (DataRow dtrFila in dtResult.Rows)
                {
                    Valor_Activo oValor = new Valor_Activo();
                    oValor.Anio = Convert.ToInt32(dtrFila["ANIO"].ToString());
                    oValor.Mes = dtrFila["MES"].ToString();
                    oValor.NroCuota = Convert.ToInt32(dtrFila["NRO_CUOTA"].ToString());
                    oValor.CuotaAnual = Decimal.Parse(dtrFila["CUOTA_ANUAL"].ToString());
                    oValor.ValorPresente = Decimal.Parse(dtrFila["VALOR_PRESENTE"].ToString());
                    lstValores.Add(oValor);
                }
                return lstValores;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                oConexion.Close();
            }
        }

        public List<Amortizacion> obtenerAmortizacionContrato(int pIdContrato)
        {
            List<Amortizacion> lstValores = new List<Amortizacion>();
            string strQuery = string.Empty;
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_LISTAR_AMORTIZACION", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@idContrato", pIdContrato);
                dtrResult = oComando.ExecuteReader();
                dtResult.Load(dtrResult);
                if (dtResult.Rows.Count == 0)
                {
                    return null;
                }

                foreach (DataRow dtrFila in dtResult.Rows)
                {
                    Amortizacion oValor = new Amortizacion();
                    oValor.NroCuota = Convert.ToInt32(dtrFila["NRO_CUOTA"].ToString());
                    oValor.Anio = Convert.ToInt32(dtrFila["ANIO"].ToString());
                    oValor.ValorCuota = Convert.ToDecimal(dtrFila["VALOR_CUOTA"].ToString());
                    oValor.Interes = Decimal.Parse(dtrFila["INTERES"].ToString());
                    oValor.MontoAmortizacion = Decimal.Parse(dtrFila["AMORTIZACION"].ToString());
                    oValor.Saldo = Decimal.Parse(dtrFila["SALDO"].ToString());
                    lstValores.Add(oValor);
                }
                return lstValores;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                oConexion.Close();
            }
        }

        public List<Arrendamiento> obtenerArrendamiento(int pIdContrato)
        {
            List<Arrendamiento> lstValores = new List<Arrendamiento>();
            string strQuery = string.Empty;
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_LISTAR_ARRENDAMIENTO_CORPORATIVO", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@idContrato", pIdContrato);
                dtrResult = oComando.ExecuteReader();
                dtResult.Load(dtrResult);
                if (dtResult.Rows.Count == 0)
                {
                    return null;
                }

                foreach (DataRow dtrFila in dtResult.Rows)
                {
                    Arrendamiento oValor = new Arrendamiento();
                    oValor.Anio = Convert.ToInt32(dtrFila["ANIO"].ToString());
                    oValor.GastoInteres = Convert.ToDecimal(dtrFila["GASTO_INTERES"].ToString());
                    oValor.GastoDepreciacion = Convert.ToDecimal(dtrFila["GASTO_DEPRECIACION"].ToString());
                    oValor.TotalGasto = Decimal.Parse(dtrFila["TOTAL_GASTO"].ToString());
                    oValor.Correlativo = Convert.ToInt32(dtrFila["CORRELATIVO"].ToString());
                    oValor.GastoAlquiler = Decimal.Parse(dtrFila["GASTO_ALQUILER"].ToString());
                    oValor.MejorUtilidad = Decimal.Parse(dtrFila["MEJOR_UTILIDAD"].ToString());
                    oValor.Tipo = dtrFila["TIPO"].ToString();
                    lstValores.Add(oValor);
                }
                return lstValores;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                oConexion.Close();
            }
        }

        public Amortizacion obtenerAmortizacion(int pId)
        {
            Amortizacion oValor = new Amortizacion();
            string strQuery = string.Empty;
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_LISTAR_AMORTIZACION_ID", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@id", pId);
                dtrResult = oComando.ExecuteReader();
                dtResult.Load(dtrResult);
                if (dtResult.Rows.Count == 0)
                {
                    return null;
                }

                foreach (DataRow dtrFila in dtResult.Rows)
                {
                    oValor = new Amortizacion();
                    oValor.NroCuota = Convert.ToInt32(dtrFila["NRO_CUOTA"].ToString());
                    oValor.Anio = Convert.ToInt32(dtrFila["ANIO"].ToString());
                    oValor.ValorCuota = Convert.ToDecimal(dtrFila["VALOR_CUOTA"].ToString());
                    oValor.Interes = Decimal.Parse(dtrFila["INTERES"].ToString());
                    oValor.MontoAmortizacion = Decimal.Parse(dtrFila["AMORTIZACION"].ToString());
                    oValor.Saldo = Decimal.Parse(dtrFila["SALDO"].ToString());
                    oValor.Estado = Convert.ToInt32(dtrFila["ESTADO"].ToString());
                    oValor.Empresa = dtrFila["EMPRESA"].ToString();
                    oValor.Mes = Convert.ToInt32(dtrFila["MES"].ToString());
                }
                return oValor;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return null;
            }
            finally
            {
                oConexion.Close();
            }
        }

        public void actualizarEstadoAmortizacion(int pId)
        {
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_UPDATE_AMORTIZACION_ID", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@id", pId);
                oComando.ExecuteReader();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                oConexion.Close();
            }
        }

        public void actualizarEstadoDepreciacion(int pId)
        {
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_UPDATE_DEPRECIACION_ID", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@id", pId);
                oComando.ExecuteReader();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                oConexion.Close();
            }
        }

        public void actualizarEstadoInteres(int pId)
        {
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_UPDATE_INTERES_ID", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@id", pId);
                oComando.ExecuteReader();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                oConexion.Close();
            }
        }

        public void procesarCargadorAsiento(string strCia, string strPaquete, string strTipoAsiento,string strPreferencia)
        {
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_CARGA_ASIENTOS2", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@PCia", strCia);
                oComando.Parameters.AddWithValue("@PPAQUETE", strPaquete);
                oComando.Parameters.AddWithValue("@Ptipo_asiento", strTipoAsiento);
                oComando.Parameters.AddWithValue("@PREFERENCIA", strPreferencia);
                oComando.Parameters.AddWithValue("@PERROR", "");
                oComando.Parameters.AddWithValue("@PMERR", "");
                oComando.ExecuteReader();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                oConexion.Close();
            }
        }

        public ConfiguracionContable obtenerConfiguracion(string empresa, string tipo,string concepto)
        {
            ConfiguracionContable oValor= new ConfiguracionContable();
            string strQuery = string.Empty;
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_LISTAR_CONFIGURACION_VAL", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@cia", empresa);
                oComando.Parameters.AddWithValue("@tipo", tipo);
                oComando.Parameters.AddWithValue("@concepto", concepto);
                dtrResult = oComando.ExecuteReader();
                dtResult.Load(dtrResult);
                if (dtResult.Rows.Count == 0)
                {
                    return null;
                }

                foreach (DataRow dtrFila in dtResult.Rows)
                {
                    oValor = new ConfiguracionContable();
                    oValor.CentroCosto = dtrFila["CENTRO_COSTO"].ToString();
                    oValor.CuentaContable = dtrFila["CUENTA"].ToString();
                }
                
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return null;
            }
            finally
            {
                oConexion.Close();
            }
            return oValor;
        }

        public Depreciacion obtenerDepreciacion(int pId)
        {
            Depreciacion oValor = new Depreciacion();
            string strQuery = string.Empty;
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_LISTAR_DEPRECIACION_ID", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@id", pId);
                dtrResult = oComando.ExecuteReader();
                dtResult.Load(dtrResult);
                if (dtResult.Rows.Count == 0)
                {
                    return null;
                }

                foreach (DataRow dtrFila in dtResult.Rows)
                {
                    oValor = new Depreciacion();
                    oValor.NroCuota = Convert.ToInt32(dtrFila["NRO_CUOTA"].ToString());
                    oValor.Anio = Convert.ToInt32(dtrFila["ANIO"].ToString());
                    oValor.CuotaAnual = Convert.ToDecimal(dtrFila["CUOTA_ANUAL"].ToString());
                    oValor.ValorPresente = Decimal.Parse(dtrFila["VALOR_PRESENTE"].ToString());
                    oValor.Estado = Convert.ToInt32(dtrFila["ESTADO"].ToString());
                    oValor.Empresa = dtrFila["EMPRESA"].ToString();
                    oValor.Mes = Convert.ToInt32(dtrFila["MES"].ToString());
                }
                return oValor;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return null;
            }
            finally
            {
                oConexion.Close();
            }
        }

        public Interes obtenerInteres(int pId)
        {
            Interes oValor = new Interes();
            string strQuery = string.Empty;
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_LISTAR_INTERES_ID", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@id", pId);
                dtrResult = oComando.ExecuteReader();
                dtResult.Load(dtrResult);
                if (dtResult.Rows.Count == 0)
                {
                    return null;
                }

                foreach (DataRow dtrFila in dtResult.Rows)
                {
                    oValor = new Interes();
                    oValor.Id = Convert.ToInt32(dtrFila["ID"].ToString());
                    oValor.IdContrato = Convert.ToInt32(dtrFila["CONTRATO_ID"].ToString());
                    oValor.Anio = Convert.ToInt32(dtrFila["ANIO"].ToString());
                    oValor.GastoInteres = Decimal.Parse(dtrFila["GASTO_INTERES"].ToString());
                    oValor.GastoDepreciacion = Decimal.Parse(dtrFila["GASTO_DEPRECIACION"].ToString());
                    oValor.TotalGasto = Decimal.Parse(dtrFila["TOTAL_GASTO"].ToString());
                    oValor.Correlativo = Convert.ToInt32(dtrFila["CORRELATIVO"].ToString());
                    oValor.GastoAlquiler = Decimal.Parse(dtrFila["GASTO_ALQUILER"].ToString());
                    oValor.MejorUtilidad = Decimal.Parse(dtrFila["MEJOR_UTILIDAD"].ToString());
                    oValor.Tipo = dtrFila["TIPO"].ToString();
                    oValor.Estado = Convert.ToInt32(dtrFila["ESTADO"].ToString());
                    oValor.Empresa = dtrFila["EMPRESA"].ToString();
                    oValor.Mes = Convert.ToInt32(dtrFila["MES"].ToString());
                }
                return oValor;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return null;
            }
            finally
            {
                oConexion.Close();
            }
        }

        public int verificarExistenciaConfiguracion(string empresa, string tipo, int concepto)
        {
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_CONFIGURACION_EXISTENCIA", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@empresa", empresa);
                oComando.Parameters.AddWithValue("@tipo", tipo);
                oComando.Parameters.AddWithValue("@concepto", concepto);
                dtrResult = oComando.ExecuteReader();
                dtResult.Load(dtrResult);
                if (dtResult.Rows.Count == 0)
                {
                    return 0;
                }
                else
                {
                    return 1;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return 2;
            }
            finally
            {
                oConexion.Close();
            }
        }

        public ConfiguracionContable obtenerConfiguracion(int id)
        {
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();
            ConfiguracionContable oValor = new ConfiguracionContable();
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_CONFIGURACION_ID", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@id", id);
                dtrResult = oComando.ExecuteReader();
                dtResult.Load(dtrResult);
                if (dtResult.Rows.Count == 0)
                {
                    return null;
                }

                foreach (DataRow dtrFila in dtResult.Rows)
                {
                    oValor = new ConfiguracionContable();
                    oValor.Empresa = dtrFila["CIA"].ToString();
                    oValor.Tipo = dtrFila["TIPO"].ToString();
                    oValor.CentroCosto = dtrFila["CENTRO_COSTO"].ToString();
                    oValor.CuentaContable = dtrFila["CUENTA"].ToString();
                    oValor.ConceptoId = Convert.ToInt32(dtrFila["ID_CONCEPTO"].ToString());
                }
                return oValor;

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return null;
            }
            finally
            {
                oConexion.Close();
            }
        }

    }
}
