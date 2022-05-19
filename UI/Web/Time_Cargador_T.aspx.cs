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
    public partial class Time_Cargador_T : System.Web.UI.Page
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
            if (Session["ct_sfec1"] == null)
            {
                Session["ct_sfec1"] = DateTime.Today.AddMonths(-1).ToString("dd/MM/yyyy");    //DateTime.Now.ToString("dd/MM/yyyy");

                ((Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Today.AddMonths(-1);

                //(((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxDropDownEdit).FindControl("listBox") as ASPxListBox).SelectAll();   //.Value = " % ";
//                ((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxGridLookup).Value = "";





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


        public string revisarExcel(string path, string filename)
        {
            int num = 0;
            string str = "OK";
            String PTipoAsiento = "CG";

            int vErr;
            string VMerr;
            string pano;
            string pmes;
            vErr = 0;
            VMerr = "ok";

            LayoutItem itemFechaInicial = Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem;
            ASPxDateEdit CBFechaInicial = itemFechaInicial.GetNestedControl() as ASPxDateEdit;



            //LayoutItem itemCia = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            //ASPxComboBox CBCia = itemCia.GetNestedControl() as ASPxComboBox;

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



            //ASPxDateEdit CBFechaInicial = GetNestedEditor(Lform, "FechaInicial");

             

            string text = "Errores encontrados: " + "\r\n";
            int num2 = 0;
            int num3 = 0;
            int AA = 2;

            pano = Session["ct_pano"].ToString(); // CBFechaInicial.Date.ToString("yyyy"); //"2021"; // Session["ct_pano"].ToString();

            EliminarAno(pano);
            int num5 = 0;
            if (num3 == 0)
            {
                AA = 2;
                do
                {
                    string pproyecto = (xlWorkSheet.Cells[AA, 1].value) != null ? (xlWorkSheet.Cells[AA, 1].value).ToString() : string.Empty;
                    string tarea = (xlWorkSheet.Cells[AA, 2]).value != null ? (xlWorkSheet.Cells[AA, 2]).value.ToString() : string.Empty;
                    string pempleado = (xlWorkSheet.Cells[AA, 8]).value != null ? (xlWorkSheet.Cells[AA, 8].value).ToString() : string.Empty;
                    string pcantidad_horas = (xlWorkSheet.Cells[AA, 7]).value != null ? (xlWorkSheet.Cells[AA, 7].value).ToString() : string.Empty;
                    string pfecha = (xlWorkSheet.Cells[AA, 4]).value != null ? (xlWorkSheet.Cells[AA, 4].text).ToString() : string.Empty;
                  //  string pporc_cargas = (xlWorkSheet.Cells[AA, 6]).value != null ? (xlWorkSheet.Cells[AA, 6].value).ToString() : string.Empty;

                    if (pproyecto == string.Empty)
                    {
                        break;
                    }


                 
                    Inserta_replicon(pproyecto, tarea, pempleado, pcantidad_horas, pfecha, pano);
                    num5 += 1;
                    AA += 1;
                }
                while (AA <= 400000);
                if (num3 == 0)
                {
                    // General.Actualizar_Exactus(num, str)
                    if (num != 0)
                        text += str;
                    else if (num != 0)
                        text += str;
                    else
                        text = "Archivo " + filename + " Cargado Exitosamente.";
                    ActualizaEmpleados(pano);
                }
            }

            xlWorkBook.Close();
            xlApp.Quit();
            System.Threading.Thread.CurrentThread.CurrentCulture = currentCulture;
            releaseObject(xlApp);
            releaseObject(xlWorkBook);
            releaseObject(xlWorkSheet);



           

        //    String Cadena = CBCia.Value.ToString();

         //   EjecutarCargaAsientos(Session["lista_ci_scia1"].ToString(), Session["ci_paquete"].ToString(), PTipoAsiento, Session["ci_referencia"].ToString(), out vErr, out VMerr);
             
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
            this.SQLBux.DataBind();
            this.GridRenta.DataBind();
        }



        private void Inserta_replicon(string pproyecto, string tarea, string pempleado, string pcantidad_horas, string pfecha, string pano)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            String VSQL;

            VSQL = "insert into PORTAL.[Time].[REPLICON] ([ANO],[MES],[PROYECTO],[FECHA],[HORAS],[FECHA_REGISTRO],[NOMBRE_EMPLEADO], ACTIVIDAD) " +
                    " VALUES ('" + pano + "',cast(DATEPART(m,convert(datetime,'" + pfecha + "',120)) as varchar(2)),'" + pproyecto + "', convert(datetime,'" + pfecha + "',120)," + pcantidad_horas + ",getdate(),'" + pempleado + "','" + tarea + "')";

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

        private void EliminarAno(string PANO)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "Archivo cargado.";


            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("DELETE PORTAL.[Time].[REPLICON] WHERE ANO = '" + PANO + "'", conn)
            {
                CommandType = CommandType.Text
            })
            {

                conn.Open();
                command.ExecuteNonQuery();
                
            }

        }

        private void ActualizaEmpleados(string PANO)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "Archivo cargado.";


            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("update time.replicon set CODIGO_EMPLEADO = (SELECT TOP(1) E.CODIGO_EMPLEADO FROM Time.EMPLEADO E WHERE E.NOMBRE_REPLICON = time.replicon.NOMBRE_EMPLEADO) WHERE ANO = '" + PANO + "'", conn)
            {
                CommandType = CommandType.Text
            })
            {

                conn.Open();
                command.ExecuteNonQuery();

            }

        }




        protected void DS_Usuarios_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}
