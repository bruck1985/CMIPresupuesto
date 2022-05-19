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
using Microsoft.Office.Interop.Excel;
using Excel = Microsoft.Office.Interop.Excel;
using static DevExpress.CodeParser.CodeStyle.Formatting.Rules.Spacing;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace UI.Web
{
    public partial class CargadorAsientos : System.Web.UI.Page
    {
        private string CurrentCiactaID
        {

            get { return Session["CurrentCiactaID"] == null ? String.Empty : Session["CurrentCiactaID"].ToString(); }
            set { Session["CurrentCiactaID"] = value;
                String[] campos = value.Split(';');
                Session["CI_Det_Cia1"] = campos[0];
                Session["CI_Det_Cta1"] = campos[1];
                Session["CI_Det_Cia2"] = campos[2];
                Session["CI_Det_Cta2"] = campos[3];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["lista_ci_scia1"] == null)
            {
                Session["ci_scia2"] = "%";
                Session["ci_sfec1"] = DateTime.Today.AddMonths(-1).ToString("dd/MM/yyyy");    //DateTime.Now.ToString("dd/MM/yyyy");
                Session["ci_sfec2"] = DateTime.Now.ToString("dd/MM/yyyy");
                SQLCompania.DataBind();

                ((Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Today.AddMonths(-1);
                ((Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Now;

                //(((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxDropDownEdit).FindControl("listBox") as ASPxListBox).SelectAll();   //.Value = " % ";
//                ((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxGridLookup).Value = "";



                Session["lista_ci_scia1"] = "ddd ffffff";


            }
        }

    
        protected void DetailsButton_Load(object sender, EventArgs e)
        {
            ASPxButton btn = sender as ASPxButton;
            GridViewDataItemTemplateContainer container = btn.NamingContainer as GridViewDataItemTemplateContainer;
            string cadenaCiaCtaID = DataBinder.Eval(container.DataItem, "CIA").ToString() + ";" + DataBinder.Eval(container.DataItem, "Cuenta_Contable").ToString() + ";" + DataBinder.Eval(container.DataItem, "CIA2").ToString() + ";" + DataBinder.Eval(container.DataItem, "Cuenta_Contable2").ToString();
            btn.ClientSideEvents.Click = String.Format("function (s, e) {{ Popup.PerformCallback('{0}'); Popup.Show(); }}", cadenaCiaCtaID);
            
        }

        protected void DetailsButton_Load2(object sender, EventArgs e)
        {
        //    ASPxButton btn = sender as ASPxButton;
        //    GridViewDataItemTemplateContainer container = btn.NamingContainer as GridViewDataItemTemplateContainer;
        //    string cadenaCiaCtaID = DataBinder.Eval(container.DataItem, "CIA").ToString() + ";" + DataBinder.Eval(container.DataItem, "Cuenta_Contable").ToString() + ";" + DataBinder.Eval(container.DataItem, "CIA2").ToString() + ";" + DataBinder.Eval(container.DataItem, "Cuenta_Contable2").ToString();
        //    btn.ClientSideEvents.Click = String.Format("function (s, e) {{ Popup.PerformCallback('{0}'); Popup.Show(); }}", cadenaCiaCtaID);

        }





        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {

            LayoutItem itemFechaInicial = Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem;
            ASPxDateEdit CBFechaInicial = itemFechaInicial.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemFechaFinal = Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem;
            ASPxDateEdit CBFechaFinal = itemFechaFinal.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            ASPxComboBox CBCiaOri = itemCiaOri.GetNestedControl() as ASPxComboBox;

            LayoutItem itemPaquete = Lform.FindItemOrGroupByName("Paquete") as LayoutItem;
            ASPxComboBox CTPaquete = itemPaquete.GetNestedControl() as ASPxComboBox;

            LayoutItem itemReferencia = Lform.FindItemOrGroupByName("Referencia") as LayoutItem;
            ASPxTextEdit CTReferencia = itemReferencia.GetNestedControl() as ASPxTextEdit;


            //ASPxDateEdit CBFechaInicial = GetNestedEditor(Lform, "FechaInicial");
            if (CBFechaInicial != null)
            {
                if (CBCiaOri.Value != null)
                {
                    Session["lista_ci_scia1"] = CBCiaOri.Value != null ? CBCiaOri.Value.ToString() : "XXX;";
                }
                else
                {
                    Session["lista_ci_scia1"] = "XXX XXXXXXXXXX";
                }
                Session["ci_sfec1"] = CBFechaInicial.Value != null ? CBFechaInicial.Date.ToString("dd/MM/yyyy") : string.Empty;
                Session["ci_sfec2"] = CBFechaFinal.Value != null ? CBFechaFinal.Date.ToString("dd/MM/yyyy") : string.Empty;

                Session["ci_paquete"] = CTPaquete.Value != null ? CTPaquete.Value.ToString() : string.Empty;
                Session["ci_referencia"] = CTReferencia.Value != null ? CTReferencia.Text : string.Empty;


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
                SQLConta.DataBind();
                GridRenta.DataBind();
            }
          
        }


        public string revisarExcel(string path, string filename)
        {
            int num = 0;
            string str = "OK";
            String PTipoAsiento = "CG";

            int vErr;
            string VMerr;
            vErr = 0;
            VMerr = "ok";

            LayoutItem itemCia = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            ASPxComboBox CBCia = itemCia.GetNestedControl() as ASPxComboBox;

            Excel.Application xlApp;
            Excel.Workbook xlWorkBook;
            //Excel.Worksheet xlWorkSheet;

            System.Globalization.CultureInfo currentCulture = System.Threading.Thread.CurrentThread.CurrentCulture;
            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US");

            xlApp = new Excel.Application();
            xlApp.Application.ScreenUpdating = false;
            xlApp.DisplayAlerts = false;
            xlWorkBook = xlApp.Workbooks.Open(path);
            Excel.Worksheet xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets[1];

            //General.Vusuario = this.Request.Cookies.Get("USUARIO").Value.ToString();
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
            int num5 = 0;
            if (num3 == 0)
            {
                AA = 2;
                do
                {
                    string pfecha = (xlWorkSheet.Cells[AA, 1].value) != null ? (xlWorkSheet.Cells[AA, 1].value).ToString() : string.Empty;
                    string pperiodo = (xlWorkSheet.Cells[AA, 2]).value != null ? (xlWorkSheet.Cells[AA, 2]).value.ToString() : string.Empty;
                    string ptipo = (xlWorkSheet.Cells[AA, 3]).value != null ? (xlWorkSheet.Cells[AA, 3].value).ToString() : string.Empty;
                    string pcuenta_conso = (xlWorkSheet.Cells[AA, 4]).value != null ? (xlWorkSheet.Cells[AA, 4].value).ToString() : string.Empty;
                    string ppais = (xlWorkSheet.Cells[AA, 5]).value != null ? (xlWorkSheet.Cells[AA, 5].value).ToString() : string.Empty;
                    string psociedad = (xlWorkSheet.Cells[AA, 6]).value != null ? (xlWorkSheet.Cells[AA, 6].value).ToString() : string.Empty;
                    string psociedad_aso = (xlWorkSheet.Cells[AA, 7]).value != null ? (xlWorkSheet.Cells[AA, 7].value).ToString() : string.Empty;
                    string pindicador = (xlWorkSheet.Cells[AA, 13]).value != null ? (xlWorkSheet.Cells[AA, 13].value).ToString() : string.Empty;
                    string pimporte_local = (xlWorkSheet.Cells[AA, 14]).value != null ? (xlWorkSheet.Cells[AA, 14].value).ToString() : string.Empty;
                    string pmoneda_local = (xlWorkSheet.Cells[AA, 15]).value != null ? (xlWorkSheet.Cells[AA, 15].value).ToString() : string.Empty;
                    string pimporte_trans = (xlWorkSheet.Cells[AA, 16]).value != null ? (xlWorkSheet.Cells[AA, 16].value).ToString() : string.Empty;
                    string pmoneda_trans = (xlWorkSheet.Cells[AA, 17]).value != null ? (xlWorkSheet.Cells[AA, 17].value).ToString() : string.Empty;
                    string pcentro = (xlWorkSheet.Cells[AA, 20]).value != null ? (xlWorkSheet.Cells[AA, 20].value).ToString() : string.Empty;
                    string pcuenta = (xlWorkSheet.Cells[AA, 4]).value != null ? (xlWorkSheet.Cells[AA, 4].value).ToString() : string.Empty;

                    if (pfecha == string.Empty)
                    {
                        break;
                    }

                    Inserta_Asientos(pfecha, pperiodo, ptipo, pcuenta_conso, ppais, psociedad, psociedad_aso, pindicador, pimporte_local, pmoneda_local, pimporte_trans, pmoneda_trans, pcentro, pcuenta, Session["lista_ci_scia1"].ToString());
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

            xlWorkBook.Close();
            xlApp.Quit();
            System.Threading.Thread.CurrentThread.CurrentCulture = currentCulture;
            releaseObject(xlApp);
            releaseObject(xlWorkBook);
            releaseObject(xlWorkSheet);



           

        //    String Cadena = CBCia.Value.ToString();

            EjecutarCargaAsientos(Session["lista_ci_scia1"].ToString(), Session["ci_paquete"].ToString(), PTipoAsiento, Session["ci_referencia"].ToString(), out vErr, out VMerr);
             
             text = VMerr; 

            return text;
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
            this.SQLConta.DataBind();
            this.GridRenta.DataBind();
        }



        private void Inserta_Asientos(string pfecha, string pperiodo, string ptipo, string pcuenta_conso, string ppais, string psociedad, string psociedad_aso, string pindicador, string pimporte_local, string pmoneda_local, string pimporte_trans, string pmoneda_trans, string pcentro, string pcuenta, string pcia)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            String VSQL;

            VSQL = "insert into PORTAL.dbo.CARGADOR_ASIENTOS ([FECHA_CONTABILIZACION],[PERIODO],[TIPO],[CUENTA_CONSO],[PAIS],[SOCIEDAD],[SOCIEDAD_GL],[INDICADOR],[IMPORTE_LOCAL],[MONEDA_LOCAL],[IMPORTE_TRANSACCION],[MONEDA_TRANSACCION],[CENTRO_COSTO],[CUENTA],[ESTADO], CIA) " + 
                    " VALUES ('" + pfecha + "','" + pperiodo + "','" + ptipo + "','" + pcuenta_conso + "','" + ppais + "','" + psociedad + "','" + psociedad_aso + "','" + pindicador + "'," + pimporte_local + ",'" + pmoneda_local + "'," + pimporte_trans + ",'" + pmoneda_trans + "','" + pcentro + "','" + pcuenta + "', 'P','" + pcia + "')";

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
    }
}
