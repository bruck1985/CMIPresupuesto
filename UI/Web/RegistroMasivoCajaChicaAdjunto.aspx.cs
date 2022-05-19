using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using DevExpress.Export;
using DevExpress.Utils.Serializing;
using DevExpress.XtraPivotGrid;
using DevExpress.XtraPivotGrid.Data;
using DevExpress.XtraReports.UI;
using dxKB2796;
using DevExpress.XtraReports.UI.PivotGrid;
using DevExpress.Web.ASPxPivotGrid;
using System.IO;
using static DevExpress.CodeParser.CodeStyle.Formatting.Rules.Spacing;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using DevExpress.Spreadsheet;
using DevExpress.Spreadsheet.Export;
using System.IO.Compression;

namespace UI.Web
{
    public partial class RegistroMasivoCajaChicaAdjunto : System.Web.UI.Page
    {

        const string UploadDirectory = "~/UploadControl/UploadImages/";
        private string CurrentCiactaID
        {

            get { return Session["CurrentCiactaID"] == null ? String.Empty : Session["CurrentCiactaID"].ToString(); }
            set
            {
                Session["CurrentCiactaID"] = value;
                String[] campos = value.Split(';');
                Session["CodigoCargadorVale"] = campos[0];
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Eliminar_Tabla_Temporal();
                SQLConta.DataBind();
            }
        }

        void book_InvalidFormatException(object sender, SpreadsheetInvalidFormatExceptionEventArgs e)
        {

        }

        public string revisarExcel(string path, string filename)
        {
            int num = 0;
            string str = "OK";
            string text = "";

            Workbook xlWorkBook = new Workbook();

            int vErr;
            string VMerr;
            vErr = 0;
            VMerr = "ok";

            xlWorkBook.InvalidFormatException += book_InvalidFormatException;
            xlWorkBook.LoadDocument(path);

            System.Globalization.CultureInfo currentCulture = System.Threading.Thread.CurrentThread.CurrentCulture;
            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US");

            try
            {
                DevExpress.Spreadsheet.Worksheet xlWorkSheet = xlWorkBook.Worksheets.ActiveWorksheet;

                text = "Errores encontrados: " + "\r\n";
                int num2 = 0;
                int num3 = 0;
                int AA = 2;
                int num5 = 0;
                if (num3 == 0)
                {
                    AA = 1;
                    do
                    {
                        /*string pcaja_chica = (xlWorkSheet.Cells[AA, 0].Value) != null ? (xlWorkSheet.Cells[AA, 0].Value).ToString() : string.Empty;
                        string pfecha = (xlWorkSheet.Cells[AA, 1]).Value != null ? (xlWorkSheet.Cells[AA, 1].Value).ToString() : string.Empty;
                        string pdepartamento = (xlWorkSheet.Cells[AA, 2]).Value != null ? (xlWorkSheet.Cells[AA, 2].Value).ToString() : string.Empty;
                        string pconcepto_vale = (xlWorkSheet.Cells[AA, 3]).Value != null ? (xlWorkSheet.Cells[AA, 3].Value).ToString() : string.Empty;
                        string pbeneficiario = (xlWorkSheet.Cells[AA, 4]).Value != null ? (xlWorkSheet.Cells[AA, 4].Value).ToString() : string.Empty;
                        string ppresupuesto = (xlWorkSheet.Cells[AA, 5]).Value != null ? (xlWorkSheet.Cells[AA, 5].Value).ToString() : string.Empty;
                        string pfecha_vale = (xlWorkSheet.Cells[AA, 6]).Value != null ? (xlWorkSheet.Cells[AA, 6].Value).ToString() : string.Empty;
                        string pmonto_vale = (xlWorkSheet.Cells[AA, 7]).Value != null ? (xlWorkSheet.Cells[AA, 7].Value).ToString() : string.Empty;
                        string pnit = (xlWorkSheet.Cells[AA, 8]).Value != null ? (xlWorkSheet.Cells[AA, 8].Value).ToString() : string.Empty;
                        string ptipo_documento = (xlWorkSheet.Cells[AA, 9]).Value != null ? (xlWorkSheet.Cells[AA, 9].Value).ToString() : string.Empty;
                        string pnro_documento = (xlWorkSheet.Cells[AA, 10]).Value != null ? (xlWorkSheet.Cells[AA, 10].Value).ToString() : string.Empty;
                        string pcentro_costo = (xlWorkSheet.Cells[AA, 11]).Value != null ? (xlWorkSheet.Cells[AA, 11].Value).ToString() : string.Empty;
                        string pcuenta_contable = (xlWorkSheet.Cells[AA, 12]).Value != null ? (xlWorkSheet.Cells[AA, 12].Value).ToString() : string.Empty;
                        string pdetalle = (xlWorkSheet.Cells[AA, 13]).Value != null ? (xlWorkSheet.Cells[AA, 13].Value).ToString() : string.Empty;
                        string pmonto_original = (xlWorkSheet.Cells[AA, 14]).Value != null ? (xlWorkSheet.Cells[AA, 14].Value).ToString() : string.Empty;
                        string pmonto_caja_chica = (xlWorkSheet.Cells[AA, 15]).Value != null ? (xlWorkSheet.Cells[AA, 15].Value).ToString() : string.Empty;
                        string ptipo_impuesto = (xlWorkSheet.Cells[AA, 16]).Value != null ? (xlWorkSheet.Cells[AA, 16].Value).ToString() : string.Empty;
                        string psubtotal = (xlWorkSheet.Cells[AA, 17]).Value != null ? (xlWorkSheet.Cells[AA, 17].Value).ToString() : string.Empty;
                        string pimpuestoIVA = (xlWorkSheet.Cells[AA, 18]).Value != null ? (xlWorkSheet.Cells[AA, 18].Value).ToString() : string.Empty;
                        string pimpuestoConsumo = (xlWorkSheet.Cells[AA, 19]).Value != null ? (xlWorkSheet.Cells[AA, 19].Value).ToString() : string.Empty;
                        string ptipo_afectacion = (xlWorkSheet.Cells[AA, 20]).Value != null ? (xlWorkSheet.Cells[AA, 20].Value).ToString() : string.Empty;
                        string pactividad_comercial = (xlWorkSheet.Cells[AA, 21]).Value != null ? (xlWorkSheet.Cells[AA, 21].Value).ToString() : string.Empty;
                        string pconsecutivo_vale = (xlWorkSheet.Cells[AA, 22]).Value != null ? (xlWorkSheet.Cells[AA, 22].Value).ToString() : string.Empty;
                        string pactividadD104 = (xlWorkSheet.Cells[AA, 23]).Value != null ? (xlWorkSheet.Cells[AA, 23].Value).ToString() : string.Empty;*/

                        string pdepartamento = (xlWorkSheet.Cells[AA, 0]).Value != null ? (xlWorkSheet.Cells[AA, 0].Value).ToString() : string.Empty;
                        string pcaja_chica = (xlWorkSheet.Cells[AA, 1].Value) != null ? (xlWorkSheet.Cells[AA, 1].Value).ToString() : string.Empty;
                        string pconsecutivo_vale = (xlWorkSheet.Cells[AA, 2]).Value != null ? (xlWorkSheet.Cells[AA, 2].Value).ToString() : string.Empty;
                        string pfechaEmision = (xlWorkSheet.Cells[AA, 3]).Value != null ? (xlWorkSheet.Cells[AA, 3].Value).ToString() : string.Empty;
                        string pfechaLiquidacion = (xlWorkSheet.Cells[AA, 4]).Value != null ? (xlWorkSheet.Cells[AA, 4].Value).ToString() : string.Empty;
                        string pconcepto_vale = (xlWorkSheet.Cells[AA, 5]).Value != null ? (xlWorkSheet.Cells[AA, 5].Value).ToString() : string.Empty;
                        string pbeneficiario = (xlWorkSheet.Cells[AA, 6]).Value != null ? (xlWorkSheet.Cells[AA, 6].Value).ToString() : string.Empty;
                        string pmonto_total_caja = (xlWorkSheet.Cells[AA, 7]).Value != null ? (xlWorkSheet.Cells[AA, 7].Value).ToString() : string.Empty;
                        string pmonto_total_local = (xlWorkSheet.Cells[AA, 8]).Value != null ? (xlWorkSheet.Cells[AA, 8].Value).ToString() : string.Empty;
                        string pmonto_total_dolares = (xlWorkSheet.Cells[AA, 9]).Value != null ? (xlWorkSheet.Cells[AA, 9].Value).ToString() : string.Empty;
                        string ptipo_cambio_dolar = (xlWorkSheet.Cells[AA, 10]).Value != null ? (xlWorkSheet.Cells[AA, 10].Value).ToString() : string.Empty;
                        string ppresupuesto = (xlWorkSheet.Cells[AA, 11]).Value != null ? (xlWorkSheet.Cells[AA, 11].Value).ToString() : string.Empty;
                        string plinea = (xlWorkSheet.Cells[AA, 12]).Value != null ? (xlWorkSheet.Cells[AA, 12].Value).ToString() : string.Empty;
                        string pcentro_costo = (xlWorkSheet.Cells[AA, 13]).Value != null ? (xlWorkSheet.Cells[AA, 13].Value).ToString() : string.Empty;
                        string pcuenta_contable = (xlWorkSheet.Cells[AA, 14]).Value != null ? (xlWorkSheet.Cells[AA, 14].Value).ToString() : string.Empty;
                        string pnit = (xlWorkSheet.Cells[AA, 15]).Value != null ? (xlWorkSheet.Cells[AA, 15].Value).ToString() : string.Empty;
                        string pnro_documento = (xlWorkSheet.Cells[AA, 16]).Value != null ? (xlWorkSheet.Cells[AA, 16].Value).ToString() : string.Empty;
                        string ptipo_documento = (xlWorkSheet.Cells[AA, 17]).Value != null ? (xlWorkSheet.Cells[AA, 17].Value).ToString() : string.Empty;
                        string pmonto_total_linea = (xlWorkSheet.Cells[AA, 18]).Value != null ? (xlWorkSheet.Cells[AA, 18].Value).ToString() : string.Empty;
                        string pconcepto_linea_vale = (xlWorkSheet.Cells[AA, 19]).Value != null ? (xlWorkSheet.Cells[AA, 19].Value).ToString() : string.Empty;
                        string pdetalle = (xlWorkSheet.Cells[AA, 20]).Value != null ? (xlWorkSheet.Cells[AA, 20].Value).ToString() : string.Empty;
                        string pfecha_vale_linea = (xlWorkSheet.Cells[AA, 21]).Value != null ? (xlWorkSheet.Cells[AA, 21].Value).ToString() : string.Empty;
                        string ptipo_impuesto = (xlWorkSheet.Cells[AA, 22]).Value != null ? (xlWorkSheet.Cells[AA, 22].Value).ToString() : string.Empty;
                        string psubtotal = (xlWorkSheet.Cells[AA, 23]).Value != null ? (xlWorkSheet.Cells[AA, 23].Value).ToString() : string.Empty;
                        string pimpuestoIVA = (xlWorkSheet.Cells[AA, 24]).Value != null ? (xlWorkSheet.Cells[AA, 24].Value).ToString() : string.Empty;
                        string pimpuestoConsumo = (xlWorkSheet.Cells[AA, 25]).Value != null ? (xlWorkSheet.Cells[AA, 25].Value).ToString() : string.Empty;
                        string ptipo_afectacion = (xlWorkSheet.Cells[AA, 26]).Value != null ? (xlWorkSheet.Cells[AA, 26].Value).ToString() : string.Empty;
                        string pactividad_comercial = (xlWorkSheet.Cells[AA, 27]).Value != null ? (xlWorkSheet.Cells[AA, 27].Value).ToString() : string.Empty;
                        string pactividadD104 = (xlWorkSheet.Cells[AA, 28]).Value != null ? (xlWorkSheet.Cells[AA, 28].Value).ToString() : string.Empty;

                        /*if (pfecha == string.Empty || pfecha_vale == string.Empty)
                        {
                            text = "La fecha del vale o fecha de registro del vale se encuentra vacio, por favor verificar.";
                            break;
                        }
                        if (pfecha.Length > 10)
                        {
                            pfecha = pfecha.Substring(0, 10).Replace('-', '/');
                        }
                        if (pfecha_vale.Length > 10)
                        {
                            pfecha_vale = pfecha_vale.Substring(0, 10).Replace('-', '/');
                        }
                        string[] fecha1 = pfecha.Split('/');
                        pfecha = String.Format("{0:00}", Convert.ToInt32(fecha1[0].ToString())) + "/" + String.Format("{0:00}", Convert.ToInt32(fecha1[1].ToString())) + "/" + fecha1[2];
                        string[] fecha2 = pfecha_vale.Split('/');
                        pfecha_vale = String.Format("{0:00}", Convert.ToInt32(fecha2[0].ToString())) + "/" + String.Format("{0:00}", Convert.ToInt32(fecha2[1].ToString())) + "/" + fecha2[2];*/

                        if (pfechaEmision == string.Empty)
                        {
                            text = "La fecha de Emisión del Vale se encuentra vacio, por favor verificar.";
                            break;
                        }
                        if (pfechaLiquidacion == string.Empty)
                        {
                            text = "La fecha de Liquidación del Vale se encuentra vacio, por favor verificar.";
                            break;
                        }
                        if (pfecha_vale_linea == string.Empty)
                        {
                            text = "La fecha de la línea del Vale se encuentra vacio, por favor verificar.";
                            break;
                        }

                        if (pfechaEmision.Length > 10)
                        {
                            pfechaEmision = pfechaEmision.Substring(0, 10).Replace('-', '/');
                        }
                        if (pfechaLiquidacion.Length > 10)
                        {
                            pfechaLiquidacion = pfechaLiquidacion.Substring(0, 10).Replace('-', '/');
                        }
                        if (pfecha_vale_linea.Length > 10)
                        {
                            pfecha_vale_linea = pfecha_vale_linea.Substring(0, 10).Replace('-', '/');
                        }
                        string[] fecha1 = pfechaEmision.Split('/');
                        pfechaEmision = String.Format("{0:00}", Convert.ToInt32(fecha1[0].ToString())) + "/" + String.Format("{0:00}", Convert.ToInt32(fecha1[1].ToString())) + "/" + fecha1[2];
                        string[] fecha2 = pfechaLiquidacion.Split('/');
                        pfechaLiquidacion = String.Format("{0:00}", Convert.ToInt32(fecha2[0].ToString())) + "/" + String.Format("{0:00}", Convert.ToInt32(fecha2[1].ToString())) + "/" + fecha2[2];
                        string[] fecha3 = pfecha_vale_linea.Split('/');
                        pfecha_vale_linea = String.Format("{0:00}", Convert.ToInt32(fecha3[0].ToString())) + "/" + String.Format("{0:00}", Convert.ToInt32(fecha3[1].ToString())) + "/" + fecha3[2];

                        //Inserta_Cajes_Temporal(pcaja_chica, pfecha, pdepartamento, pconcepto_vale, pbeneficiario, ppresupuesto, pfecha_vale, pmonto_vale, pnit, ptipo_documento, pnro_documento, pcentro_costo, pcuenta_contable, pdetalle, pmonto_original, pmonto_caja_chica, ptipo_impuesto, ptipo_afectacion, psubtotal, pimpuestoIVA, pimpuestoConsumo, pactividad_comercial, pconsecutivo_vale, pactividadD104);
                        Inserta_Cajas_Temporal(pdepartamento, pcaja_chica, pconsecutivo_vale, pfechaEmision, pfechaLiquidacion, pconcepto_vale, pbeneficiario,
                                    pmonto_total_caja, pmonto_total_local, pmonto_total_dolares, ptipo_cambio_dolar, ppresupuesto, plinea, pcentro_costo,
                                    pcuenta_contable, pnit, pnro_documento, ptipo_documento, pmonto_total_linea, pconcepto_linea_vale, pdetalle, pfecha_vale_linea,
                                    ptipo_impuesto, psubtotal, pimpuestoIVA, pimpuestoConsumo, ptipo_afectacion, pactividad_comercial, pactividadD104);

                        num5 += 1;
                        AA += 1;
                    }
                    while (AA <= 2000);
                    if (num3 == 0)
                    {
                        if (num != 0)
                        {
                            text += str;
                        }
                        else
                        {
                            if (num != 0)
                            {
                                text += str;
                            }
                            else
                            {
                                CargarCabeceraDetalleCajasChicas();
                                text = "Archivo " + filename + " Cargado Exitosamente. Hacer clic en el botón Actualizar para visualizar los registros cargados.";
                            }
                        } 
                    }
                }

                System.Threading.Thread.CurrentThread.CurrentCulture = currentCulture;
                releaseObject(xlWorkBook);
                releaseObject(xlWorkSheet);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                string VconnectionString;
                //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
                VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
                String VSQL;
                VSQL = "delete from PORTAL.dbo.CARGADOR_VALES_MASICO";
                using (var conn = new SqlConnection(VconnectionString))
                using (var command = new SqlCommand(VSQL, conn)
                {
                    CommandType = CommandType.Text
                })
                {
                    conn.Open();
                    command.ExecuteNonQuery();
                }
                text = ex.Message;
            }
            return text;
        }

        private string CargarCabeceraDetalleCajasChicas()
        {

            string VconnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "Archivo cargado.";

            try
            {
                using (var conn = new SqlConnection(VconnectionString))
                using (var command = new SqlCommand("PORTAL.[dbo].[PORTAL_PRE_CARGA_VALES]", conn)
                {
                    CommandType = CommandType.StoredProcedure
                })
                {
                    command.Parameters.AddWithValue("@PUsuario", Session["nombreUsuario"].ToString().ToUpper());
                    command.Parameters.Add("@PERROR", SqlDbType.Char, 2000);
                    command.Parameters["@PERROR"].Direction = ParameterDirection.Output;
                    conn.Open();
                    command.ExecuteNonQuery();

                    vErr = (string)command.Parameters["@PERROR"].Value;
                    return vErr.Trim().ToString();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return "ERROR";
            }
        }

        private void releaseObject(object obj)
        {
            try
            {
                System.Runtime.InteropServices.Marshal.ReleaseComObject(System.Runtime.CompilerServices.RuntimeHelpers.GetObjectValue(obj));
                obj = null;
            }
            catch (Exception expr_11)
            {
                obj = null;
            }
            finally
            {
                System.GC.Collect();
            }
        }

        /*private void Inserta_Cajes_Temporal(string pcaja_chica, string pfecha, string pdepartamento, string pconcepto_vale, string pbeneficiario, string ppresupuesto,
                                            string pfecha_vale, string pmonto_vale, string pnit, string ptipo_documento, string pnro_documento,
                                            string pcentro_costo, string pcuenta_contable, string pdetalle, string pmonto_original,
                                            string pmonto_caja_chica, string ptipo_impuesto, string ptipo_afectacion, string psubtotal, string pmontoIVA, string pmontoConsumo,
                                            string pactividad_comercial, string pconsecutivo_vale, string pactividadD104)*/
        private void Inserta_Cajas_Temporal(string pdepartamento, string pcaja_chica, string pconsecutivo_vale, string pfechaEmision, string pfechaLiquidacion,
                                            string pconcepto_vale, string pbeneficiario, string pmonto_total_caja, string pmonto_total_local, string pmonto_total_dolares,
                                            string ptipo_cambio_dolar, string ppresupuesto, string plinea, string pcentro_costo, string pcuenta_contable, string pnit,
                                            string pnro_documento, string ptipo_documento, string pmonto_total_linea, string pconcepto_linea_vale, string pdetalle,
                                            string pfecha_vale_linea, string ptipo_impuesto, string psubtotal, string pimpuestoIVA, string pimpuestoConsumo,
                                            string ptipo_afectacion, string pactividad_comercial, string pactividadD104)
        {

            string VconnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;

            String VSQL;
            /*if (psubtotal.Equals(""))
            {
                psubtotal = "0";
            }
            if (pmontoIVA.Equals(""))
            {
                pmontoIVA = "0";
            }
            if (pmontoConsumo.Equals(""))
            {
                pmontoConsumo = "0";
            }*/
            if (pmonto_total_caja.Equals(""))
            {
                pmonto_total_caja = "0";
            }
            if (pmonto_total_local.Equals(""))
            {
                pmonto_total_local = "0";
            }
            if (pmonto_total_dolares.Equals(""))
            {
                pmonto_total_dolares = "0";
            }
            if (ptipo_cambio_dolar.Equals(""))
            {
                ptipo_cambio_dolar = "0";
            }
            if (pmonto_total_linea.Equals(""))
            {
                pmonto_total_linea = "0";
            }
            if (psubtotal.Equals(""))
            {
                psubtotal = "0";
            }
            if (pimpuestoIVA.Equals(""))
            {
                pimpuestoIVA = "0";
            }
            if (pimpuestoConsumo.Equals(""))
            {
                pimpuestoConsumo = "0";
            }

            /*VSQL = "insert into PORTAL.dbo.CARGADOR_VALES (CAJA_CHICA,FECHA_REGISTRO,DEPARTAMENTO,CONCEPTO_VALE,BENEFICIARIO,PRESUPUESTO,FECHA_VALE,";
            VSQL = VSQL + "MONTO_VALE,NIT,TIPO_DOCUMENTO,DOCS_SOPORTE,CENTRO_COSTO,CUENTA_CONTABLE,DETALLE,MONTO_ORIGINAL_DOC,MONTO_MONEDA_CAJA_CHICA,";
            VSQL = VSQL + "TIPO_IMPUESTO,TIPO_AFECTACION,USUARIO,ACTIVIDAD_COMERCIAL,SUBTOTAL,IMPUESTO_IVA,IMPUESTO_CONSUMO,CONSECUTIVO_VALE,ACTIVIDAD_D104) ";
            VSQL = VSQL + " VALUES ('" + pcaja_chica + "',convert(date,'" + pfecha.ToString().Replace('/', '-') + "',103),'" + pdepartamento + "','" + pconcepto_vale + "','" + pbeneficiario + "','" + ppresupuesto + "',convert(date,'" + pfecha_vale.ToString().Replace('/', '-') + "',103),";
            VSQL = VSQL + pmonto_vale + ",'" + pnit + "','" + ptipo_documento + "','" + pnro_documento + "','" + pcentro_costo + "','" + pcuenta_contable + "','" + pdetalle + "'," + pmonto_original + "," + pmonto_caja_chica + ",";
            VSQL = VSQL + "'" + ptipo_impuesto + "','" + ptipo_afectacion + "','" + Session["nombreUsuario"].ToString().ToUpper() + "',";
            VSQL = VSQL + "'" + pactividad_comercial + "'," + psubtotal + "," + pmontoIVA + "," + pmontoConsumo + ",'" + pconsecutivo_vale + "','" + pactividadD104 + "')";*/
            VSQL = "insert into PORTAL.dbo.CARGADOR_VALES_MASIVO (USUARIO, DEPARTAMENTO, CAJA_CHICA, CONSECUTIVO_VALE, FECHA_EMISION, FECHA_LIQUIDACION,";
            VSQL = VSQL + "CONCEPTO_VALE, BENEFICIARIO, MONTO_TOTAL_CAJA, MONTO_TOTAL_LOCAL, MONTO_TOTAL_DOLAR, TIPO_CAMBIO_DOLAR,PRESUPUESTO, LINEA,";
            VSQL = VSQL + "CENTRO_COSTO, CUENTA_CONTABLE, CONTRIBUYENTE, NRO_DOCUMENTO,TIPO_DOCUMENTO, MONTO_TOTAL_LINEA, CONCEPTO_LINEA_VALE, DETALLE,";
            VSQL = VSQL + "FECHA_LINEA_VALE, TIPO_IMPUESTO, SUB_TOTAL_LINEA, IMPUESTO_IVA_LINEA, IMPUESTO_CONSUMO_LINEA, TIPO_AFECTACION, ";
            VSQL = VSQL + "ACTIVIDAD_COMERCIAL_LINEA, ACTIVIDAD_D104_LINEA) ";
            VSQL = VSQL + " VALUES ('" + Session["nombreUsuario"].ToString().ToUpper() + "','" + pdepartamento + "','" + pcaja_chica + "','" + pconsecutivo_vale + "', convert(date,'" + pfechaEmision.ToString().Replace('/', '-') + "',103) , convert(date,'" + pfechaLiquidacion.ToString().Replace('/', '-') + "',103),";
            VSQL = VSQL + "'" + pconcepto_vale + "','" + pbeneficiario + "'," + pmonto_total_caja + "," + pmonto_total_local + "," + pmonto_total_dolares + "," + ptipo_cambio_dolar + ",'" + ppresupuesto + "'," + plinea + ",";
            VSQL = VSQL + "'" + pcentro_costo + "','" + pcuenta_contable + "','" + pnit + "','" + pnro_documento + "','" + ptipo_documento + "'," + pmonto_total_linea + ",'" + pconcepto_linea_vale + "','" + pdetalle + "',";
            VSQL = VSQL + "convert(date,'" + pfecha_vale_linea.ToString().Replace('/', '-') + "',103),'" + ptipo_impuesto + "'," + psubtotal + "," + pimpuestoIVA + "," + pimpuestoConsumo + ",'" + ptipo_afectacion + "','";
            VSQL = VSQL + pactividad_comercial + "','" + pactividadD104 + "');";

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand(VSQL, conn)
            {
                CommandType = CommandType.Text
            })
            {
                conn.Open();
                command.ExecuteNonQuery();
            }
        }

        protected void Upload_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            string text;
            if (e.IsValid)
            {
                Eliminar_Tabla_Temporal();
                text = System.DateTime.Now.ToString().Replace("/", "-").Replace(":", ".") + "_" + e.UploadedFile.FileName;
                e.UploadedFile.SaveAs(this.Server.MapPath("~/SecureFolder/" + text));
                e.CallbackData = text;
                e.CallbackData = this.revisarExcel(this.Server.MapPath("~/SecureFolder/" + text), e.UploadedFile.FileName);
                SQLConta.DataBind();
                GridRenta.DataBind();
            }
        }

        protected void ASPxFormLayout_E3_Click1(object sender, EventArgs e)
        {
            SQLConta.DataBind();
            GridRenta.DataBind();
        }

        protected void Lform_E2_Click(object sender, EventArgs e)
        {
            LayoutItem itemCia = Lform.FindItemOrGroupByName("Cia") as LayoutItem;
            ASPxComboBox CBCia = itemCia.GetNestedControl() as ASPxComboBox;
            if (CBCia.Value != null)
            {
                /*Verificar si el usuario tiene permiso de registro de Vales*/
                string VconnectionString;
                //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
                VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
                SqlConnection dbSQL = new SqlConnection(VconnectionString);
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "PORTAL.dbo.VALIDAR_PERMISO_REG_VALE";
                cmd.Connection = dbSQL;
                cmd.Parameters.AddWithValue("@PCia", CBCia.Value.ToString());
                cmd.Parameters.AddWithValue("@PUsuario", Session["nombreUsuario"].ToString());
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                System.Data.DataTable dt = new System.Data.DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count == 0)
                {
                    //Memo.Text = "El usuario no cuenta con permiso a la empresa " + CBCia.Value.ToString() + " para poder realizar el registro de vales.";
                    //return;
                }

                int resultado = 0;
                int linea = 0;
                bool validacionOK = true;
                /*Se valida que existan los datos en las tablas*/
                for (int i = 0; i < GridRenta.VisibleRowCount; i++)
                {
                    linea = i + 1;
                    string departamento = GridRenta.GetRowValues(i, "DEPARTAMENTO").ToString();
                    resultado = VerificarExistenciaDatos(CBCia.Value.ToString(), "DEPARTAMENTO", departamento);
                    if (resultado == 0)
                    {
                        validacionOK = false;
                        Memo.Text = "La línea " + linea.ToString() + ", posee un departamento que no existe en la compañía seleccionada.";
                        return;
                    }

                    string caja_chica = GridRenta.GetRowValues(i, "CAJA_CHICA").ToString();
                    resultado = VerificarExistenciaDatos(CBCia.Value.ToString(), "CAJA_CHICA", caja_chica);
                    if (resultado == 0)
                    {
                        validacionOK = false;
                        Memo.Text = "La línea " + linea.ToString() + ", posee una caja chica que no existe en la compañía seleccionada.";
                        return;
                    }

                    string concepto_vale = GridRenta.GetRowValues(i, "CONCEPTO_VALE").ToString();
                    resultado = VerificarExistenciaDatos(CBCia.Value.ToString(), "CONCEPTO_VALE", concepto_vale);
                    if (resultado == 0)
                    {
                        validacionOK = false;
                        Memo.Text = "La línea " + linea.ToString() + ", posee un concepto vale que no existe en la compañía seleccionada.";
                        return;
                    }

                    string beneficiario = GridRenta.GetRowValues(i, "BENEFICIARIO").ToString();
                    if (!beneficiario.Equals(""))
                    {
                        resultado = VerificarExistenciaDatos(CBCia.Value.ToString(), "BENEFICIARIO", beneficiario);
                        if (resultado == 0)
                        {
                            validacionOK = false;
                            Memo.Text = "La línea " + linea.ToString() + ", posee un beneficiario que no existe en la compañía seleccionada.";
                            return;
                        }
                    }
                    else
                    {
                        validacionOK = false;
                        Memo.Text = "La línea " + linea.ToString() + ", no posee un beneficiario para asignar a la caja en la compañía seleccionada.";
                        return;
                    }

                    string presupuesto = GridRenta.GetRowValues(i, "PRESUPUESTO").ToString();
                    resultado = VerificarExistenciaDatos(CBCia.Value.ToString(), "PRESUPUESTO", presupuesto);
                    if (resultado == 0)
                    {
                        validacionOK = false;
                        Memo.Text = "La línea " + linea.ToString() + ", posee un presupuesto que no existe en la compañía seleccionada.";
                        return;
                    }

                    string centro_costo = GridRenta.GetRowValues(i, "CENTRO_COSTO").ToString();
                    resultado = VerificarExistenciaDatos(CBCia.Value.ToString(), "CENTRO_COSTO", centro_costo);
                    if (resultado == 0)
                    {
                        validacionOK = false;
                        Memo.Text = "La línea " + linea.ToString() + ", posee un centro de costo que no existe en la compañía seleccionada.";
                        return;
                    }

                    string cuenta_contable = GridRenta.GetRowValues(i, "CUENTA_CONTABLE").ToString();
                    resultado = VerificarExistenciaDatos(CBCia.Value.ToString(), "CUENTA_CONTABLE", cuenta_contable);
                    if (resultado == 0)
                    {
                        validacionOK = false;
                        Memo.Text = "La línea " + linea.ToString() + ", posee una cuenta contable que no existe en la compañía seleccionada.";
                        return;
                    }

                    resultado = VerificarExistenciaCentroCuenta(CBCia.Value.ToString(), cuenta_contable, centro_costo);
                    if (resultado == 0)
                    {
                        validacionOK = false;
                        Memo.Text = "La línea " + linea.ToString() + ", posee una combinación centro de costo-cuenta contable que no existe en la compañía seleccionada.";
                        return;
                    }

                    string nit = GridRenta.GetRowValues(i, "CONTRIBUYENTE").ToString();
                    resultado = VerificarExistenciaDatos(CBCia.Value.ToString(), "NIT", nit);
                    if (resultado == 0)
                    {
                        validacionOK = false;
                        Memo.Text = "La línea " + linea.ToString() + ", posee un Contribuyente que no existe en la compañía seleccionada.";
                        return;
                    }

                    string concepto_linea_vale = GridRenta.GetRowValues(i, "CONCEPTO_LINEA_VALE").ToString();
                    resultado = VerificarExistenciaDatos(CBCia.Value.ToString(), "CONCEPTO_LINEA_VALE", concepto_linea_vale);
                    if (resultado == 0)
                    {
                        validacionOK = false;
                        Memo.Text = "La línea " + linea.ToString() + ", posee un concepto línea vale que no existe en la compañía seleccionada.";
                        return;
                    }

                    string tipo_impuesto = GridRenta.GetRowValues(i, "TIPO_IMPUESTO").ToString();
                    if (!tipo_impuesto.Equals(""))
                    {
                        resultado = VerificarExistenciaDatos(CBCia.Value.ToString(), "TIPO_IMPUESTO", tipo_impuesto);
                        if (resultado == 0)
                        {
                            validacionOK = false;
                            Memo.Text = "La línea " + linea.ToString() + ", posee un tipo de impuesto que no existe en la compañía seleccionada.";
                            return;
                        }
                    }

                    string tipo_afectacion = GridRenta.GetRowValues(i, "TIPO_AFECTACION").ToString();
                    if (!tipo_afectacion.Equals(""))
                    {
                        resultado = VerificarExistenciaDatos(CBCia.Value.ToString(), "TIPO_AFECTACION", tipo_afectacion);
                        if (resultado == 0)
                        {
                            validacionOK = false;
                            Memo.Text = "La línea " + linea.ToString() + ", posee un tipo de afectación que no existe en la compañía seleccionada.";
                            return;
                        }
                    }

                    string actividad_comercial = GridRenta.GetRowValues(i, "ACTIVIDAD_COMERCIAL_LINEA").ToString();
                    if (!actividad_comercial.Equals(""))
                    {
                        resultado = VerificarExistenciaDatos(CBCia.Value.ToString(), "ACTIVIDAD_COMERCIAL_LINEA", actividad_comercial);
                        if (resultado == 0)
                        {
                            validacionOK = false;
                            Memo.Text = "La línea " + linea.ToString() + ", posee una actividad comercial que no existe en la compañía seleccionada.";
                            return;
                        }
                    }

                    string actividad_d104 = GridRenta.GetRowValues(i, "ACTIVIDAD_D104_LINEA").ToString();
                    if (!actividad_d104.Equals(""))
                    {
                        resultado = VerificarExistenciaDatos(CBCia.Value.ToString(), "ACTIVIDAD_D104_LINEA", actividad_d104);
                        if (resultado == 0)
                        {
                            validacionOK = false;
                            Memo.Text = "La línea " + linea.ToString() + ", posee una actividad D104 que no existe en la compañía seleccionada.";
                            return;
                        }
                    }
                }
                if (validacionOK)
                {
                    try
                    {
                        string respuesta = EjecutarCargaCajasChicas(CBCia.Value.ToString());
                        if (respuesta.Equals("OK"))
                        {
                            Eliminar_Tabla_Temporal();
                            SQLConta.DataBind();
                            GridRenta.DataBind();
                            Memo.Text = "Registros Procesados Correctamente.";
                        }
                        else
                        {
                            Memo.Text = "Ocurrió un error en el registro de la cajas chicas.";
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                        Memo.Text = "Ocurrió un error en el registro de la cajas chicas.";
                    }
                }
            }
            else
            {
                Memo.Text = "Tiene que seleccionar la compañía.";
            }
        }

        private string EjecutarCargaCajasChicas(string PCIA)
        {

            string VconnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "Archivo cargado.";

            try
            {
                using (var conn = new SqlConnection(VconnectionString))
                using (var command = new SqlCommand("PORTAL.[dbo].[PORTAL_PROCESAR_VALES_ADJUNTO_2]", conn)
                {
                    CommandType = CommandType.StoredProcedure
                })
                {
                    command.Parameters.AddWithValue("@PCIA", PCIA.ToUpper());
                    command.Parameters.AddWithValue("@PUsuario", Session["nombreUsuario"].ToString().ToUpper());
                    command.Parameters.Add("@PERROR", SqlDbType.Char, 2000);
                    command.Parameters["@PERROR"].Direction = ParameterDirection.Output;
                    conn.Open();
                    command.ExecuteNonQuery();

                    vErr = (string)command.Parameters["@PERROR"].Value;
                    return vErr.Trim().ToString();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return "ERROR";
            }
        }

        protected void ASPxFileManager1_CustomCallback(object sender, CallbackEventArgsBase e)
        {
            SQL_Data_Vale_Doc_Adjuntos.DataBind();
            ASPxFileManager1.DataBind();
        }

        protected void ASPxFileManager1_FileDownloading(object source, FileManagerFileDownloadingEventArgs e)
        {
            e.InputStream.Position = 0;
            Stream csStream = new GZipStream(e.InputStream, CompressionMode.Decompress);
            e.OutputStream = csStream;
        }

        private int VerificarExistenciaDatos(string cia, string tipo, string valor)
        {
            string VconnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            try
            {
                SqlConnection dbSQL = new SqlConnection(VconnectionString);
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "PORTAL.dbo.PORTAL_VALIDAR_PARAM_CAJA_CHICA";
                cmd.Connection = dbSQL;
                cmd.Parameters.AddWithValue("@pesquema", cia);
                cmd.Parameters.AddWithValue("@PTipo", tipo);
                cmd.Parameters.AddWithValue("@PValor", valor);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                System.Data.DataTable dt = new System.Data.DataTable();
                sda.Fill(dt);
                int resultado = Convert.ToInt32(dt.Rows[0].ItemArray[0].ToString());
                return resultado;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return 0;
            }
        }

        private int VerificarExistenciaCentroCuenta(string cia, string cuenta, string centro)
        {
            string VconnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            try
            {
                SqlConnection dbSQL = new SqlConnection(VconnectionString);
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "PORTAL.dbo.PORTAL_VALIDAR_CENTRO_CUENTA";
                cmd.Connection = dbSQL;
                cmd.Parameters.AddWithValue("@pesquema", cia);
                cmd.Parameters.AddWithValue("@pcentro", centro);
                cmd.Parameters.AddWithValue("@pcuenta", cuenta);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                System.Data.DataTable dt = new System.Data.DataTable();
                sda.Fill(dt);
                int resultado = Convert.ToInt32(dt.Rows[0].ItemArray[0].ToString());
                return resultado;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return 0;
            }
        }

        private void Eliminar_Tabla_Temporal()
        {

            string VconnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            string VSQL1;
            VSQL1 = "delete from PORTAL.dbo.CARGADOR_VALES_ADJUNTO WHERE CARGADOR_ID IN (SELECT ID FROM PORTAL.dbo.CARGADOR_VALES WHERE UPPER(USUARIO)='" + Session["nombreUsuario"].ToString().ToUpper() + "') ";
            using (var conn1 = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand(VSQL1, conn1)
            {
                CommandType = CommandType.Text
            })
            {
                conn1.Open();
                command.ExecuteNonQuery();
            }

            String VSQL;
            VSQL = "delete from PORTAL.dbo.CARGADOR_VALES where UPPER(USUARIO)='" + Session["nombreUsuario"].ToString().ToUpper() + "'";
            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand(VSQL, conn)
            {
                CommandType = CommandType.Text
            })
            {
                conn.Open();
                command.ExecuteNonQuery();
            }

            String VSQL2;
            VSQL2 = "delete from PORTAL.dbo.CARGADOR_VALES_MASIVO where UPPER(USUARIO)='" + Session["nombreUsuario"].ToString().ToUpper() + "'";
            using (var conn2 = new SqlConnection(VconnectionString))
            using (var command2 = new SqlCommand(VSQL2, conn2)
            {
                CommandType = CommandType.Text
            })
            {
                conn2.Open();
                command2.ExecuteNonQuery();
            }

            String VSQL3;
            VSQL3 = "DELETE FROM PORTAL.dbo.CARGADOR_VALES_DET WHERE ID_CABECERA IN (SELECT ID FROM PORTAL.dbo.CARGADOR_VALES_CAB WHERE UPPER(USUARIO)='" + Session["nombreUsuario"].ToString().ToUpper() + "' )";
            using (var conn3 = new SqlConnection(VconnectionString))
            using (var command3 = new SqlCommand(VSQL3, conn3)
            {
                CommandType = CommandType.Text
            })
            {
                conn3.Open();
                command3.ExecuteNonQuery();
            }

            String VSQL4;
            VSQL4 = "DELETE FROM PORTAL.dbo.CARGADOR_VALES_CAB WHERE UPPER(USUARIO) ='" + Session["nombreUsuario"].ToString().ToUpper() + "' ";
            using (var conn4 = new SqlConnection(VconnectionString))
            using (var command4 = new SqlCommand(VSQL4, conn4)
            {
                CommandType = CommandType.Text
            })
            {
                conn4.Open();
                command4.ExecuteNonQuery();
            }
        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            Eliminar_Tabla_Temporal();
            SQLConta.DataBind();
            GridRenta.DataBind();
            Memo.Text = "";
        }

        protected void UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            string resultExtension = Path.GetExtension(e.UploadedFile.FileName);
            string resultFileName = e.UploadedFile.FileName;
            string resultFileUrl = UploadDirectory + resultFileName;
            string resultFilePath = MapPath(resultFileUrl);
            byte[] fileBytes = e.UploadedFile.FileBytes;

            fileBytes = Compress(fileBytes);

            CrearImagenBase(Session["CodigoCargadorVale"].ToString(), resultFileName, fileBytes);

            string name = e.UploadedFile.FileName;
            string url = ResolveClientUrl(resultFileUrl);
            long sizeInKilobytes = e.UploadedFile.ContentLength / 1024;
            string sizeText = sizeInKilobytes.ToString() + " KB";
            e.CallbackData = name + "|" + url + "|" + sizeText;
        }

        protected void Popup_WindowCallback(object source, PopupWindowCallbackArgs e)
        {
            CurrentCiactaID = e.Parameter;
            DetailsApply();
        }

        private void DetailsApply()
        {
            if (!String.IsNullOrEmpty(CurrentCiactaID))
            {

                String[] campos = CurrentCiactaID.Split(';');
                Session["CodigoCargadorVale"] = campos[0];
            }
        }

        private void CrearImagenBase(string PCARGADOR_ID, string PNOMBRE, byte[] PIMAGEN)
        {
            string VconnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "ok";
            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.[dbo].[PORTAL_CARGADOR_VALE_ADJUNTOS_CREAR]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@CARGADOR_ID", PCARGADOR_ID);
                command.Parameters.AddWithValue("@PNOMBRE", PNOMBRE);
                command.Parameters.AddWithValue("@PCONTENIDO", PIMAGEN);

                command.Parameters.Add("@PError", SqlDbType.Char, 10);
                command.Parameters["@PError"].Direction = ParameterDirection.Output;

                command.Parameters.Add("@PMerr", SqlDbType.Char, 2000);
                command.Parameters["@PMerr"].Direction = ParameterDirection.Output;
                conn.Open();
                command.ExecuteNonQuery();

                vErr = (string)command.Parameters["@PError"].Value;
                VMerr = (string)command.Parameters["@PMerr"].Value;
            }
        }

        static byte[] Compress(byte[] data)
        {
            using (var compressedStream = new MemoryStream())
            using (var zipStream = new GZipStream(compressedStream, CompressionMode.Compress))
            {
                zipStream.Write(data, 0, data.Length);
                zipStream.Close();
                return compressedStream.ToArray();
            }
        }
    }
}
