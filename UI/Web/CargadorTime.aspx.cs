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
using DevExpress.Utils.Serializing;
//using Microsoft.Office.Interop.Excel;
//using Excel = Microsoft.Office.Interop.Excel;
using static DevExpress.CodeParser.CodeStyle.Formatting.Rules.Spacing;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using DevExpress.Spreadsheet;
using DevExpress.Spreadsheet.Export;

//using DevExpress.Spreadsheet;

namespace UI.Web
{
    public partial class CargadorTime : System.Web.UI.Page
    {
        string FilePath
        {
            get { return Session["FilePath"] == null ? String.Empty : Session["FilePath"].ToString(); }
            set { Session["FilePath"] = value; }
        }

        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (!IsPostBack)
                FilePath = String.Empty;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                Session["ct_sfec1"] = DateTime.Today.AddMonths(-1).ToString("dd/MM/yyyy");    //DateTime.Now.ToString("dd/MM/yyyy");



                ((Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Today.AddMonths(-1);

                //(((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxDropDownEdit).FindControl("listBox") as ASPxListBox).SelectAll();   //.Value = " % ";
                //                ((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxGridLookup).Value = "";


                Session["ct_pano"] = DateTime.Today.AddMonths(-1).ToString("yyyy");
                Session["ct_pmes"] = DateTime.Today.AddMonths(-1).ToString("MM");

                SQLBux.DataBind();
                GridRenta.DataBind();


            }
        }

    

        



        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {

            LayoutItem itemFechaInicial = Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem;
            ASPxDateEdit CBFechaInicial = itemFechaInicial.GetNestedControl() as ASPxDateEdit;


            //ASPxDateEdit CBFechaInicial = GetNestedEditor(Lform, "FechaInicial");
            if (CBFechaInicial != null)
            {
                Session["ci_sfec1"] = CBFechaInicial.Value != null ? CBFechaInicial.Date.ToString("dd/MM/yyyy") : string.Empty;

                Session["ct_pano"] = CBFechaInicial.Date.ToString("yyyy");
                Session["ct_pmes"] = CBFechaInicial.Date.ToString("MM");

                SQLBux.DataBind();
                GridRenta.DataBind();
            }

        }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            //grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });

            DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
            //PivotCompra.OptionsView.HideAllTotals();
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //Exportador.WriteXlsToResponse(stream);
            WriteToResponse("CargadorAsiento.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
            //PivotCompra.OptionsView.ShowAllTotals();

        }

        protected void ExportExcel1_Click(object sender, EventArgs e)
        {

            //ASPxPivotGridExp1.ExportToXlsx("DetalleCtaExp.xlsx");
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //ASPxPivotGridExp1.ExportToXlsx(stream);
            //WriteToResponse("ReporteDetalleCta1.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);

    }

        protected void ExportExcel2_Click(object sender, EventArgs e)
        {
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //ASPxPivotGridExp2.ExportToXlsx(stream);
            //WriteToResponse("ReporteDetalleCta1.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);

        }

        protected void WriteToResponse(string fileName, bool saveAsFile, string fileFormat, System.IO.MemoryStream stream)
        {
            if (Page == null || Page.Response == null) return;
            string disposition = saveAsFile ? "attachment" : "inline";
            Response.Clear();
            Response.Buffer = false;
            Response.AppendHeader("Content-Type", string.Format("application/{0}", fileFormat));
            Response.AppendHeader("Content-Transfer-Encoding", "binary");
            Response.AppendHeader("Content-Disposition", string.Format("{0}; filename={1}", disposition, fileName));
            Response.BinaryWrite(stream.ToArray());
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.SuppressContent = true;
            HttpContext.Current.ApplicationInstance.CompleteRequest();

        }


       private void Upload_FileUploadComplete(object sender, FileUploadCompleteEventArgs e) 
        {
            string text;

            if (e.IsValid)
            {
                text = System.DateTime.Now.ToString().Replace("/", "-").Replace(":", ".") + "_" + e.UploadedFile.FileName;
                e.UploadedFile.SaveAs(this.Server.MapPath("~/SecureFolder/" + text));
                e.CallbackData = text;
                e.CallbackData = this.revisarExcel(this.Server.MapPath("~/SecureFolder/" + text), e.UploadedFile.FileName);
                SQLBux.DataBind();
                GridRenta.DataBind();
            }
          
        }

        private DataTable GetTableFromExcel()
        {
            Workbook book = new Workbook();
            book.InvalidFormatException += book_InvalidFormatException;
            book.LoadDocument(FilePath);
            DevExpress.Spreadsheet.Worksheet sheet = book.Worksheets.ActiveWorksheet;
            DevExpress.Spreadsheet.Range range = sheet.GetUsedRange();
            DataTable table = sheet.CreateDataTable(range, false);
            DataTableExporter exporter = sheet.CreateDataTableExporter(range, table, false);
            exporter.CellValueConversionError += exporter_CellValueConversionError;
            exporter.Export();
            return table;
        }

        public string revisarExcel(string path, string filename)
        {
            string VMError;
            VMError = "0";
            Workbook xlWorkBook = new Workbook();
            try
            {
                int num = 0;
            string str = "Archivo cargado satisfactoriamente.";
            String PTipoAsiento = "CG";

            int vErr;
            string VMerr;
            string pano;
            string pmes;
            vErr = 0;
            VMerr = "Archivo cargado satisfactoriamente.";
            VMError = "1";



                //LayoutItem itemCia = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
                //ASPxComboBox CBCia = itemCia.GetNestedControl() as ASPxComboBox;

                VMError = "2";
             //   Excel.Application xlApp;
            //Excel.Workbook xlWorkBook;

                xlWorkBook.InvalidFormatException += book_InvalidFormatException;
                xlWorkBook.LoadDocument(path);

                //Excel.Worksheet xlWorkSheet;
                VMError = "3";
                System.Globalization.CultureInfo currentCulture = System.Threading.Thread.CurrentThread.CurrentCulture;
            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US");
                VMError = "4";
               // xlApp = new Excel.Application();
                //xlApp.Visible = true;
                VMError = "4.1";
                //xlApp.Application.ScreenUpdating = false;
                VMError = "4.2";

                //xlApp.DisplayAlerts = false;
                VMError = "4.3" + path.ToString();
                //xlWorkBook = xlApp.Workbooks.Open(path); //, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Microsoft.Office.Interop.Excel.XlCorruptLoad.xlExtractData);
                //                xlWorkBook = xlApp.Workbooks.Open(path);
                //xlWorkBook = xlApp.Workbooks.Open(path, false, true); //  [ReadOnly]= True, UpdateLinks:= False)
                VMError = "4.4";

                //Excel.Worksheet xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets[1];

                DevExpress.Spreadsheet.Worksheet xlWorkSheet = xlWorkBook.Worksheets.ActiveWorksheet;

                VMError = "5";
                //General.Vusuario = this.Request.Cookies.Get("USUARIO").Value.ToString();



                //ASPxDateEdit CBFechaInicial = GetNestedEditor(Lform, "FechaInicial");



                string text = "Errores encontrados: " + "\r\n";
            int num2 = 0;
            int num3 = 0;
            int AA = 2;
                // The following expression was wrapped in a checked-statement
                //do
                //{
                //    string pfecha = (xlWorkSheet.Cells[AA, 1].value) != null ? (xlWorkSheet.Cells[AA, 1].value).ToString() : string.Empty;
                //    string pperiodo = (xlWorkSheet.Cells[AA, 2]).value != null ? (xlWorkSheet.Cells[AA, 2]).value.ToString() : string.Empty;
                //    string ptipo = (xlWorkSheet.Cells[AA, 3]).value != null ? (xlWorkSheet.Cells[AA, 3].value).ToString() : string.Empty;
                //    string pcuenta_conso = (xlWorkSheet.Cells[AA, 4]).value != null ? (xlWorkSheet.Cells[AA, 4].value).ToString() : string.Empty;
                //    string ppais = (xlWorkSheet.Cells[AA, 5]).value != null ? (xlWorkSheet.Cells[AA, 5].value).ToString() : string.Empty;
                //    string psociedad = (xlWorkSheet.Cells[AA, 6]).value != null ? (xlWorkSheet.Cells[AA, 6].value).ToString() : string.Empty;
                //    string psociedad_aso = (xlWorkSheet.Cells[AA, 7]).value != null ? (xlWorkSheet.Cells[AA, 7].value).ToString() : string.Empty;
                //    string pindicador = (xlWorkSheet.Cells[AA, 13]).value != null ? (xlWorkSheet.Cells[AA, 13].value).ToString() : string.Empty;
                //    string pimporte_local = (xlWorkSheet.Cells[AA, 14]).value != null ? (xlWorkSheet.Cells[AA, 14].value).ToString() : string.Empty;
                //    string pmoneda_local = (xlWorkSheet.Cells[AA, 15]).value != null ? (xlWorkSheet.Cells[AA, 15].value).ToString() : string.Empty;
                //    string pimporte_trans = (xlWorkSheet.Cells[AA, 16]).value != null ? (xlWorkSheet.Cells[AA, 16].value).ToString() : string.Empty;
                //    string pmoneda_trans = (xlWorkSheet.Cells[AA, 17]).value != null ? (xlWorkSheet.Cells[AA, 17].value).ToString() : string.Empty;
                //    string pcentro    = (xlWorkSheet.Cells[AA, 20]).value != null ? (xlWorkSheet.Cells[AA, 20].value).ToString() : string.Empty;
                //    string pcuenta = (xlWorkSheet.Cells[AA, 21]).value != null ? (xlWorkSheet.Cells[AA, 21].value).ToString() : string.Empty;


                //    if (pcuenta != "")
                //    {                    // If Not text8.Contains("-") Then
                //        // If Not General.Verificar_Existe_articulo(text8, Session("PCOMPANIA")) Then
                //        // num3 += 1
                //        // text = text + "- Artículo " + text8 + " no fue encontrado como artículo" & vbCr
                //        // End If
                //        // End If


                //        num2 = 0;
                //    }
                //    else
                //    {
                //        num2 += 1;
                //        if (num2 > 5)
                //            break;
                //    }

                //    AA += 1;
                //}
                //while (AA <= 3);
                VMError = "6";
                int num5 = 0;
            if (num3 == 0)
            {
                AA = 4;
                do
                {
                        //Cells[position].Value
                    string pcodigo_empleado = (xlWorkSheet.Cells["A" + AA.ToString()].Value) != null ? (xlWorkSheet.Cells["A" + AA.ToString()].Value).ToString() : string.Empty;
                    string pcentro_costo = (xlWorkSheet.Cells["B" + AA.ToString()].Value) != null ? (xlWorkSheet.Cells["B" + AA.ToString()].Value).ToString() : string.Empty;
                    string psalario = (xlWorkSheet.Cells["C" + AA.ToString()].Value) != null ? (xlWorkSheet.Cells["C" + AA.ToString()].Value).ToString() : string.Empty;
                    string pcarga_social = (xlWorkSheet.Cells["E" + AA.ToString()].Value) != null ? (xlWorkSheet.Cells["E" + AA.ToString()].Value).ToString() : string.Empty;
                    string pbono = (xlWorkSheet.Cells["D" + AA.ToString()].Value) != null ? (xlWorkSheet.Cells["D" + AA.ToString()].Value).ToString() : string.Empty;
                    string pporc_cargas = "1";  //(xlWorkSheet.Cells[AA, 6]).value != null ? (xlWorkSheet.Cells[AA, 6].value).ToString() : string.Empty;

                    if (pcodigo_empleado == string.Empty)
                    {
                        break;
                    }


                    pano = Session["ct_pano"].ToString();
                    pmes = Session["ct_pmes"].ToString();

                    if (AA==4)
                    {
                        Borrar_Data(pano, pmes);
                    }

                    Inserta_Salarios(pcodigo_empleado, pano, pmes, pcentro_costo, psalario, pcarga_social, pbono, pporc_cargas);
                    num5 += 1;
                    AA += 1;
                }
                while (AA <= 2000);
                if (num3 == 0)
                {
                    // General.Actualizar_Exactus(num, str)
                    if (num != 0)
                        text += str;
                    else if (num != 0)
                        text += str;
                    else
                        text = "Archivo " + filename + " Cargado Exitosamente.";
                }
            }
                VMError = "7";
//                xlWorkBook.clo
//            xlApp.Quit();
            System.Threading.Thread.CurrentThread.CurrentCulture = currentCulture;
//            releaseObject(xlApp);
            releaseObject(xlWorkBook);
            releaseObject(xlWorkSheet);

                VMError = "8";



                //    String Cadena = CBCia.Value.ToString();

                //   EjecutarCargaAsientos(Session["lista_ci_scia1"].ToString(), Session["ci_paquete"].ToString(), PTipoAsiento, Session["ci_referencia"].ToString(), out vErr, out VMerr);

                text = VMerr; 

            return text;
            }
            catch (Exception e)
            {
                return "Error:" + VMError + " " + e.Message.ToString();
            }
        }


        void exporter_CellValueConversionError(object sender, CellValueConversionErrorEventArgs e)
        {
            e.Action = DataTableExporterAction.Continue;
            e.DataTableValue = null;
        }
        void book_InvalidFormatException(object sender, SpreadsheetInvalidFormatExceptionEventArgs e)
        {

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
               // ProjectData.SetProjectError(expr_11);
                obj = null;
               // ProjectData.ClearProjectError();
            }
            finally
            {
                System.GC.Collect();
            }
        }

        private void GridRenta_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            this.SQLBux.DataBind();
            this.GridRenta.DataBind();
        }



        private void Inserta_Salarios(string pcodigo_empleado, string pano, string pmes, string pcentro_costo, string psalario, string pcarga_social, string pbono, string pporc_cargas)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            String VSQL;

            VSQL = "insert into PORTAL.Time.BUX ([CODIGO_EMPLEADO], [ANO], [MES], [CENTRO_COSTO], [SALARIO], [CARGA_SOCIAL], [BONO], PORC_CARGAS) " + 
                    " VALUES ('" + pcodigo_empleado + "','" + pano + "','" + pmes + "','" + pcentro_costo + "'," + psalario + "," + pcarga_social + "," + pbono + "," + pporc_cargas + ")";

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

        private void Borrar_Data(string pano, string pmes)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            String VSQL;

            VSQL = "delete PORTAL.Time.BUX where ano= '" + pano + "' and mes = '" + pmes + "'";

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



        protected void Upload_FileUploadComplete1(object sender, FileUploadCompleteEventArgs e)
        {
            string text;
            if (e.IsValid)
            {
                text = System.DateTime.Now.ToString().Replace("/", "").Replace(":", "") + "_" + e.UploadedFile.FileName;
                e.UploadedFile.SaveAs(this.Server.MapPath("~/SecureFolder/" + text));
                e.CallbackData = text;
                e.CallbackData = this.revisarExcel(this.Server.MapPath("~/SecureFolder/" + text), e.UploadedFile.FileName);
            }
        }

        private void EjecutarCargaAsientos(string PCIA, string PPAQUETE, string Ptipo_asiento, string PREFERENCIA, out int PERR, out string PMERR)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "Archivo cargado.";


            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.[dbo].[PORTAL_CARGA_ASIENTOS2]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PCIA", PCIA);
                command.Parameters.AddWithValue("@PPAQUETE", PPAQUETE);
                command.Parameters.AddWithValue("@Ptipo_asiento", Ptipo_asiento);
                command.Parameters.AddWithValue("@PREFERENCIA", PREFERENCIA);

                command.Parameters.Add("@PERROR", SqlDbType.Char, 20);
                command.Parameters["@PERROR"].Direction = ParameterDirection.Output;

                command.Parameters.Add("@PMERR", SqlDbType.Char, 32000);
                command.Parameters["@PMERR"].Direction = ParameterDirection.Output;


                conn.Open();
                command.ExecuteNonQuery();
                
                vErr = (string)command.Parameters["@PERROR"].Value;
                VMerr = (string)command.Parameters["@PMERR"].Value;

            }

            PERR = Int32.Parse(vErr);
            PMERR = VMerr;


        }

        protected void GridRenta_CustomCallback1(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            this.SQLBux.DataBind();
            this.GridRenta.DataBind();
        }
    }
}
