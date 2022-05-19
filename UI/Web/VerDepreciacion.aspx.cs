using BusinessLogic.Clases;
using DevExpress.Export;
using DevExpress.XtraPrinting;
using System;
using System.Collections;
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
    public partial class VerDepreciacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                grid_data.DataBind();
            }
            if (Request.Params["id"] != null)
            {
                Session["ContratoDepreciacion"] = Request.Params["id"];
                DS_Depreciacion_Contrato.DataBind();

                /*Cargar Datos del Contrato*/
                string valor = "";
                valor = Request.Params["id"];
                ContratoBL objContrato = new ContratoBL();
                Contrato oContrato = new Contrato();
                oContrato = objContrato.obtenerContrato(Convert.ToInt32(valor));
                txtNombreContrato.Text = oContrato.NombreContrato;
                txtNombreContrato.Enabled = false;
                txtPais.Text = oContrato.Pais;
                txtPais.Enabled = false;
                txtEntidad.Text = oContrato.Entidad;
                txtEntidad.Enabled = false;
                txtCuotaMensual.Text = oContrato.CuotaArrendamiento.ToString();
                txtCuotaMensual.Enabled = false;
            }
        }

        protected void BTAceptar_Click(object sender, EventArgs e)
        {
            Procesar();
        }

        private void Procesar()
        {
            int contador = 0;
            string empresa = "";
            string paquete = ConfigurationManager.AppSettings["PAQUETE"].ToString();
            string tipoAsiento = ConfigurationManager.AppSettings["TIPOASIENTO"].ToString();
            string descripcion = ConfigurationManager.AppSettings["DESCRIPCION_ASIENTO"].ToString();
            string centroCostoHaber = String.Empty;
            string cuentaContableHaber = String.Empty;
            string centroCostoDebe = String.Empty;
            string cuentaContableDebe = String.Empty;
            try
            {
                List<object> plist;
                ArrayList totalVals = new ArrayList();
                plist = grid_data.GetSelectedFieldValues("ID");
                EliminarTablaCargadorAsientos();
                foreach (int item in plist)
                {
                    ContratoBL objContrato = new ContratoBL();
                    Depreciacion oDepreciacion = new Depreciacion();
                    oDepreciacion = objContrato.obtenerDepreciacion(item);
                    if (oDepreciacion.Estado == 2)
                    {
                        //Es un registro procesado
                        contador = contador + 1;
                    }
                    empresa = oDepreciacion.Empresa;
                }

                if (contador > 0) //entre los registros seleccionados hay algunos que son procesados
                {
                    PMensaje.ShowOnPageLoad = true;
                    //return;
                }
                else
                {
                    string concepto = "DEP";
                    /*Obtenemos las configuraciones del centro de costo y cuenta contable*/
                    ContratoBL objConfiguracion = new ContratoBL();
                    ConfiguracionContable configuracionHaber = new ConfiguracionContable();
                    configuracionHaber = objConfiguracion.obtenerConfiguracion(empresa, "H",concepto);
                    ConfiguracionContable configuracionDebe = new ConfiguracionContable();
                    configuracionDebe = objConfiguracion.obtenerConfiguracion(empresa, "S",concepto);
                    if (configuracionDebe == null || configuracionHaber == null)
                    {
                        PConfiguracion.ShowOnPageLoad = true;
                        //return;
                    }
                    else
                    {
                        foreach (int item in plist)
                        {
                            string fechaContabilizacion = "";
                            ContratoBL objContrato = new ContratoBL();
                            Depreciacion oDepreciacion = new Depreciacion();
                            oDepreciacion = objContrato.obtenerDepreciacion(item);

                            string VconnectionString;
                            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;
                            SqlConnection dbSQL = new SqlConnection(VconnectionString);
                            try
                            {
                                if (dbSQL.State != ConnectionState.Open)
                                    dbSQL.Open();

                                DateTime fecha = new DateTime(oDepreciacion.Anio, oDepreciacion.Mes, 1);
                                DateTime ultimoDia = fecha.AddMonths(1).AddDays(-1);
                                fechaContabilizacion = oDepreciacion.Anio.ToString() + oDepreciacion.Mes.ToString().PadLeft(2, '0') + ultimoDia.Day.ToString().PadLeft(2, '0');
                                string periodo = oDepreciacion.Anio.ToString() + oDepreciacion.Mes.ToString().PadLeft(2, '0');
                                string sentencia = "INSERT INTO CARGADOR_ASIENTOS(FECHA_CONTABILIZACION,PERIODO,SOCIEDAD,";
                                sentencia = sentencia + " INDICADOR,IMPORTE_LOCAL,MONEDA_LOCAL,IMPORTE_TRANSACCION,";
                                sentencia = sentencia + " MONEDA_TRANSACCION,CENTRO_COSTO, CUENTA,ESTADO,CIA) VALUES ('";
                                sentencia = sentencia + fechaContabilizacion + "','" + periodo + "','" + oDepreciacion.Empresa + "',";
                                sentencia = sentencia + "'H'," + oDepreciacion.ValorPresente + ",'USD'," + oDepreciacion.ValorPresente + ",";
                                sentencia = sentencia + "'USD','" + configuracionHaber.CentroCosto + "','" + configuracionHaber.CuentaContable + "','P','" + oDepreciacion.Empresa + "');";

                                SqlCommand ComandoConsulta = new SqlCommand();
                                ComandoConsulta.CommandText = sentencia;
                                ComandoConsulta.Connection = dbSQL;
                                ComandoConsulta.ExecuteNonQuery();

                                /*S*/
                                string sentencia2 = "INSERT INTO CARGADOR_ASIENTOS(FECHA_CONTABILIZACION,PERIODO,SOCIEDAD,";
                                sentencia2 = sentencia2 + " INDICADOR,IMPORTE_LOCAL,MONEDA_LOCAL,IMPORTE_TRANSACCION,";
                                sentencia2 = sentencia2 + " MONEDA_TRANSACCION,CENTRO_COSTO, CUENTA,ESTADO,CIA) VALUES ('";
                                sentencia2 = sentencia2 + fechaContabilizacion + "','" + periodo + "','" + oDepreciacion.Empresa + "',";
                                sentencia2 = sentencia2 + "'S'," + oDepreciacion.ValorPresente + ",'USD'," + oDepreciacion.ValorPresente + ",";
                                sentencia2 = sentencia2 + "'USD','" + configuracionDebe.CentroCosto + "','" + configuracionDebe.CuentaContable + "','P','" + oDepreciacion.Empresa + "');";

                                SqlCommand ComandoConsulta2 = new SqlCommand();
                                ComandoConsulta2.CommandText = sentencia2;
                                ComandoConsulta2.Connection = dbSQL;
                                ComandoConsulta2.ExecuteNonQuery();

                                /*Se actualiza el estado del registro*/
                                objContrato.actualizarEstadoDepreciacion(item);
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
                        }
                        /*Se ejecuta el procedimiento que recorrerá la tabla intermedia de cargador de asientos*/
                        ContratoBL objContrato2 = new ContratoBL();
                        objContrato2.procesarCargadorAsiento(empresa, paquete, tipoAsiento, descripcion);
                        DS_Depreciacion_Contrato.DataBind();
                        PExito.ShowOnPageLoad = true;
                    }
                }

            }
            catch (Exception ex)
            {
                PError.ShowOnPageLoad = true;
            }
        }

        private void EliminarTablaCargadorAsientos()
        {
            /*Conexión a la BD*/
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;
            SqlConnection dbSQL = new SqlConnection(VconnectionString);
            SqlDataReader MIDataReader;

            /*Se ejecuta el proceso de cuotas anuales*/
            try
            {
                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();

                string sentencia = "PORTAL_DELETE_CARGADOR_ASIENTOS";
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
        }

        protected void Lform_E1_Click(object sender, EventArgs e)
        {
            ASPxGridViewExporter1.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }
    }
}