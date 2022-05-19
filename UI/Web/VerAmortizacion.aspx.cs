using BusinessLogic.Clases;
using DevExpress.Export;
using DevExpress.Web;
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
    public partial class VerAmortizacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                grid_data.DataBind();
            }
            if (Request.Params["id"] != null)
            {
                Session["ContratoAmortizacion"] = Request.Params["id"];
                DS_Amortizacion_Contrato.DataBind();

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
                    Amortizacion oAmortizacion = new Amortizacion();
                    oAmortizacion = objContrato.obtenerAmortizacion(item);
                    if (oAmortizacion.Estado==2)
                    {
                        //Es un registro procesado
                        contador = contador + 1;
                    }
                    empresa = oAmortizacion.Empresa;
                }

                if (contador>0) //entre los registros seleccionados hay algunos que son procesados
                {
                    PMensaje.ShowOnPageLoad = true;
                    //return;
                }
                else
                {
                    /*Obtenemos las configuraciones del centro de costo y cuenta contable*/
                    ContratoBL objConfiguracion = new ContratoBL();
                    string concepto = "AMO";
                    ConfiguracionContable configuracionHaber = new ConfiguracionContable();
                    configuracionHaber = objConfiguracion.obtenerConfiguracion(empresa, "H",concepto);
                    ConfiguracionContable configuracionDebe = new ConfiguracionContable();
                    configuracionDebe = objConfiguracion.obtenerConfiguracion(empresa, "S",concepto);
                    if (configuracionDebe==null || configuracionHaber==null)
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
                            Amortizacion oAmortizacion = new Amortizacion();
                            oAmortizacion = objContrato.obtenerAmortizacion(item);

                            string VconnectionString;
                            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;
                            SqlConnection dbSQL = new SqlConnection(VconnectionString);
                            try
                            {
                                if (dbSQL.State != ConnectionState.Open)
                                    dbSQL.Open();

                                DateTime fecha = new DateTime(oAmortizacion.Anio, oAmortizacion.Mes, 1);
                                DateTime ultimoDia = fecha.AddMonths(1).AddDays(-1);
                                fechaContabilizacion = oAmortizacion.Anio.ToString() + oAmortizacion.Mes.ToString().PadLeft(2, '0') + ultimoDia.Day.ToString().PadLeft(2, '0');
                                string periodo = oAmortizacion.Anio.ToString() + oAmortizacion.Mes.ToString().PadLeft(2, '0');
                                string sentencia = "INSERT INTO CARGADOR_ASIENTOS(FECHA_CONTABILIZACION,PERIODO,SOCIEDAD,";
                                sentencia = sentencia + " INDICADOR,IMPORTE_LOCAL,MONEDA_LOCAL,IMPORTE_TRANSACCION,";
                                sentencia = sentencia + " MONEDA_TRANSACCION,CENTRO_COSTO, CUENTA,ESTADO,CIA) VALUES ('";
                                sentencia = sentencia + fechaContabilizacion + "','" + periodo + "','" + oAmortizacion.Empresa + "',";
                                sentencia = sentencia + "'H'," + oAmortizacion.MontoAmortizacion + ",'USD'," + oAmortizacion.MontoAmortizacion + ",";
                                sentencia = sentencia + "'USD','" + configuracionHaber.CentroCosto + "','" + configuracionHaber.CuentaContable + "','P','" + oAmortizacion.Empresa + "');";

                                SqlCommand ComandoConsulta = new SqlCommand();
                                ComandoConsulta.CommandText = sentencia;
                                ComandoConsulta.Connection = dbSQL;
                                ComandoConsulta.ExecuteNonQuery();

                                /*S*/
                                string sentencia2 = "INSERT INTO CARGADOR_ASIENTOS(FECHA_CONTABILIZACION,PERIODO,SOCIEDAD,";
                                sentencia2 = sentencia2 + " INDICADOR,IMPORTE_LOCAL,MONEDA_LOCAL,IMPORTE_TRANSACCION,";
                                sentencia2 = sentencia2 + " MONEDA_TRANSACCION,CENTRO_COSTO, CUENTA,ESTADO,CIA) VALUES ('";
                                sentencia2 = sentencia2 + fechaContabilizacion + "','" + periodo + "','" + oAmortizacion.Empresa + "',";
                                sentencia2 = sentencia2 + "'S'," + oAmortizacion.MontoAmortizacion + ",'USD'," + oAmortizacion.MontoAmortizacion + ",";
                                sentencia2 = sentencia2 + "'USD','" + configuracionDebe.CentroCosto + "','" + configuracionDebe.CuentaContable + "','P','" + oAmortizacion.Empresa + "');";

                                SqlCommand ComandoConsulta2 = new SqlCommand();
                                ComandoConsulta2.CommandText = sentencia2;
                                ComandoConsulta2.Connection = dbSQL;
                                ComandoConsulta2.ExecuteNonQuery();

                                /*Se actualiza el estado del registro*/
                                objContrato.actualizarEstadoAmortizacion(item);
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
                        DS_Amortizacion_Contrato.DataBind();
                        PExito.ShowOnPageLoad = true;
                        //DS_Amortizacion_Contrato.DataBind();
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

        protected void BTAceptar_Click(object sender, EventArgs e)
        {
            Procesar();
        }

        protected void Lform_E1_Click(object sender, EventArgs e)
        {
            ASPxGridViewExporter1.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }
    }
}