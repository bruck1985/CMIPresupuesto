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
using Microsoft.Office.Interop.Excel;
using Excel = Microsoft.Office.Interop.Excel;
using static DevExpress.CodeParser.CodeStyle.Formatting.Rules.Spacing;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace UI.Web
{
    public partial class Contabilidad_CargadorFTransito : System.Web.UI.Page
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
        //siok
//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (Session["lista_ci_scia1"] == null)
//            {
//                Session["ci_scia2"] = "%";
//                Session["ci_sfec1"] = DateTime.Today.AddMonths(-1).ToString("dd/MM/yyyy");    //DateTime.Now.ToString("dd/MM/yyyy");
//                Session["ci_sfec2"] = DateTime.Now.ToString("dd/MM/yyyy");
//                SQLCompania.DataBind();

//                ((Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Today.AddMonths(-1);
//                ((Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Now;

//                //(((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxDropDownEdit).FindControl("listBox") as ASPxListBox).SelectAll();   //.Value = " % ";
////                ((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxGridLookup).Value = "";



//                Session["lista_ci_scia1"] = "ddd ffffff";


//            }
//        }

    
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

            //LayoutItem itemPaquete = Lform.FindItemOrGroupByName("Paquete") as LayoutItem;
            //ASPxComboBox CTPaquete = itemPaquete.GetNestedControl() as ASPxComboBox;

            //LayoutItem itemReferencia = Lform.FindItemOrGroupByName("Referencia") as LayoutItem;
            //ASPxTextEdit CTReferencia = itemReferencia.GetNestedControl() as ASPxTextEdit;


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

                //Session["ci_paquete"] = CTPaquete.Value != null ? CTPaquete.Value.ToString() : string.Empty;
                //Session["ci_referencia"] = CTReferencia.Value != null ? CTReferencia.Text : string.Empty;


            }

        }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            //grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });

            DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
            //PivotCompra.OptionsView.HideAllTotals();
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            GridFacturasTransito.ExportToXlsx(stream);
            //Exportador.WriteXlsToResponse(stream);
            WriteToResponse("CargadorFacturasTransito.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
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

        //siok
        private void Upload_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            string text;
            if (e.IsValid)
            {
                text = System.DateTime.Now.ToString().Replace("/", "-").Replace(":", ".") + "_" + e.UploadedFile.FileName;
                e.UploadedFile.SaveAs(this.Server.MapPath("~/SecureFolder/" + text));
                e.CallbackData = text;
                //siok
                e.CallbackData = this.revisarExcel(this.Server.MapPath("~/SecureFolder/" + text), e.UploadedFile.FileName);
                SQLFacturasTransito.DataBind();
                GridFacturasTransito.DataBind();
            }

        }

        ////siok
        public string revisarExcel(string path, string filename)
        {
            int num = 0;
            string str = "OK";
            //String PTipoAsiento = "CG";

            int vErr;
            string VMerr;
            vErr = 0;
            VMerr = "ok";

			int ContadorvErr;

			string VMerrGeneral;


			ContadorvErr = 0;

			//VMerrGeneral = "Se detallan los primeros 5 Errores detectados en el archivo: \n";
			VMerrGeneral = "Carga no realizada con errores encontrados, se muestran los primeros registros: " + "\r\n";


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

            string pcodigotipoproceso = "1";
            string text = "Errores encontrados: " + "\r\n";
            //int num2 = 0;
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
                    //string pfecha = (xlWorkSheet.Cells[AA, 1].value) != null ? (xlWorkSheet.Cells[AA, 1].value).ToString() : string.Empty;
                    //string pperiodo = (xlWorkSheet.Cells[AA, 2]).value != null ? (xlWorkSheet.Cells[AA, 2]).value.ToString() : string.Empty;
                    //string ptipo = (xlWorkSheet.Cells[AA, 3]).value != null ? (xlWorkSheet.Cells[AA, 3].value).ToString() : string.Empty;
                    //string pcuenta_conso = (xlWorkSheet.Cells[AA, 4]).value != null ? (xlWorkSheet.Cells[AA, 4].value).ToString() : string.Empty;
                    //string ppais = (xlWorkSheet.Cells[AA, 5]).value != null ? (xlWorkSheet.Cells[AA, 5].value).ToString() : string.Empty;
                    //string psociedad = (xlWorkSheet.Cells[AA, 6]).value != null ? (xlWorkSheet.Cells[AA, 6].value).ToString() : string.Empty;
                    //string psociedad_aso = (xlWorkSheet.Cells[AA, 7]).value != null ? (xlWorkSheet.Cells[AA, 7].value).ToString() : string.Empty;
                    //string pindicador = (xlWorkSheet.Cells[AA, 13]).value != null ? (xlWorkSheet.Cells[AA, 13].value).ToString() : string.Empty;
                    //string pimporte_local = (xlWorkSheet.Cells[AA, 14]).value != null ? (xlWorkSheet.Cells[AA, 14].value).ToString() : string.Empty;
                    //string pmoneda_local = (xlWorkSheet.Cells[AA, 15]).value != null ? (xlWorkSheet.Cells[AA, 15].value).ToString() : string.Empty;
                    //string pimporte_trans = (xlWorkSheet.Cells[AA, 16]).value != null ? (xlWorkSheet.Cells[AA, 16].value).ToString() : string.Empty;
                    //string pmoneda_trans = (xlWorkSheet.Cells[AA, 17]).value != null ? (xlWorkSheet.Cells[AA, 17].value).ToString() : string.Empty;
                    //string pcentro = (xlWorkSheet.Cells[AA, 20]).value != null ? (xlWorkSheet.Cells[AA, 20].value).ToString() : string.Empty;
                    //string pcuenta = (xlWorkSheet.Cells[AA, 4]).value != null ? (xlWorkSheet.Cells[AA, 4].value).ToString() : string.Empty;



                    //string pfecha = (xlWorkSheet.Cells[AA, 1].value) != null ? (xlWorkSheet.Cells[AA, 1].value).ToString() : string.Empty;





                    string pcia = (xlWorkSheet.Cells[AA, 1].value) != null ? (xlWorkSheet.Cells[AA, 1].value).ToString() : string.Empty;
                    string pdocumento = (xlWorkSheet.Cells[AA, 2].value) != null ? (xlWorkSheet.Cells[AA, 2].value).ToString() : string.Empty;
                    string ptipodocumento = (xlWorkSheet.Cells[AA, 3].value) != null ? (xlWorkSheet.Cells[AA, 3].value).ToString() : string.Empty;
                    string pnumerolinea = (xlWorkSheet.Cells[AA, 4].value) != null ? (xlWorkSheet.Cells[AA, 4].value).ToString() : string.Empty;
                    string psubtipo = (xlWorkSheet.Cells[AA, 5].value) != null ? (xlWorkSheet.Cells[AA, 5].value).ToString() : string.Empty;
                    string pactividadeconomica = (xlWorkSheet.Cells[AA, 6].value) != null ? (xlWorkSheet.Cells[AA, 6].value).ToString() : string.Empty;
                    string porigen = (xlWorkSheet.Cells[AA, 7].value) != null ? (xlWorkSheet.Cells[AA, 7].value).ToString() : string.Empty;
                    string pactividadd104 = (xlWorkSheet.Cells[AA, 8].value) != null ? (xlWorkSheet.Cells[AA, 8].value).ToString() : string.Empty;
                    string pfechaemision = (xlWorkSheet.Cells[AA, 9].value) != null ? (xlWorkSheet.Cells[AA, 9].value).ToString() : string.Empty;
                    string pidentificacionproveedor = (xlWorkSheet.Cells[AA, 10].value) != null ? (xlWorkSheet.Cells[AA, 10].value).ToString() : string.Empty;
                    //string pcodigoproveedor = (xlWorkSheet.Cells[AA, 11].value) != null ? (xlWorkSheet.Cells[AA, 11].value).ToString() : string.Empty;
                    string pnombreproveedor = (xlWorkSheet.Cells[AA, 11].value) != null ? (xlWorkSheet.Cells[AA, 11].value).ToString() : string.Empty;
                    //string pcodigoarticulo = (xlWorkSheet.Cells[AA, 13].value) != null ? (xlWorkSheet.Cells[AA, 13].value).ToString() : string.Empty;
                    string pdescripcionmercancia = (xlWorkSheet.Cells[AA, 12].value) != null ? (xlWorkSheet.Cells[AA, 12].value).ToString() : string.Empty;
                    string ppreciounitario = (xlWorkSheet.Cells[AA, 13].value) != null ? (xlWorkSheet.Cells[AA, 13].value).ToString() : string.Empty;
                    string pcantidadcomprada = (xlWorkSheet.Cells[AA, 14].value) != null ? (xlWorkSheet.Cells[AA, 14].value).ToString() : string.Empty;
                    string punidadmedida = (xlWorkSheet.Cells[AA, 15].value) != null ? (xlWorkSheet.Cells[AA, 15].value).ToString() : string.Empty;
                    string pmontosubtotal = (xlWorkSheet.Cells[AA, 16].value) != null ? (xlWorkSheet.Cells[AA, 16].value).ToString() : string.Empty;
                    string pdescuentoaplicado = (xlWorkSheet.Cells[AA, 17].value) != null ? (xlWorkSheet.Cells[AA, 17].value).ToString() : string.Empty;
                    string pimpuestoconsumo = (xlWorkSheet.Cells[AA, 18].value) != null ? (xlWorkSheet.Cells[AA, 18].value).ToString() : string.Empty;
                    string pivafacturado = (xlWorkSheet.Cells[AA, 19].value) != null ? (xlWorkSheet.Cells[AA, 19].value).ToString() : string.Empty;
                    string potros = (xlWorkSheet.Cells[AA, 20].value) != null ? (xlWorkSheet.Cells[AA, 20].value).ToString() : string.Empty;
                    //string pmontototal = (xlWorkSheet.Cells[AA, 23].value) != null ? (xlWorkSheet.Cells[AA, 23].value).ToString() : string.Empty;
                    string pmoneda = (xlWorkSheet.Cells[AA, 21].value) != null ? (xlWorkSheet.Cells[AA, 21].value).ToString() : string.Empty;
                    string ptipocambio = (xlWorkSheet.Cells[AA, 22].value) != null ? (xlWorkSheet.Cells[AA, 22].value).ToString() : string.Empty;
                    string pduaimportacion = (xlWorkSheet.Cells[AA, 23].value) != null ? (xlWorkSheet.Cells[AA, 23].value).ToString() : string.Empty;
                    string pfechadua = (xlWorkSheet.Cells[AA, 24].value) != null ? (xlWorkSheet.Cells[AA, 24].value).ToString() : string.Empty;
                    string ppartidaarancelaria = (xlWorkSheet.Cells[AA, 25].value) != null ? (xlWorkSheet.Cells[AA, 25].value).ToString() : string.Empty;
                    string pdetallepartidaarancelaria = (xlWorkSheet.Cells[AA, 26].value) != null ? (xlWorkSheet.Cells[AA, 26].value).ToString() : string.Empty;
                    string paduana = (xlWorkSheet.Cells[AA, 27].value) != null ? (xlWorkSheet.Cells[AA, 27].value).ToString() : string.Empty;
                    string pnombreagencia = (xlWorkSheet.Cells[AA, 28].value) != null ? (xlWorkSheet.Cells[AA, 28].value).ToString() : string.Empty;
                    string pagenciaaduanalcj = (xlWorkSheet.Cells[AA, 29].value) != null ? (xlWorkSheet.Cells[AA, 29].value).ToString() : string.Empty;
                    string pbaseimponible = (xlWorkSheet.Cells[AA, 30].value) != null ? (xlWorkSheet.Cells[AA, 30].value).ToString() : string.Empty;
                    string pivapagado = (xlWorkSheet.Cells[AA, 31].value) != null ? (xlWorkSheet.Cells[AA, 31].value).ToString() : string.Empty;
                    string potrosimpuestos = (xlWorkSheet.Cells[AA, 32].value) != null ? (xlWorkSheet.Cells[AA, 32].value).ToString() : string.Empty;
                    string pcodivatarifa = (xlWorkSheet.Cells[AA, 33].value) != null ? (xlWorkSheet.Cells[AA, 33].value).ToString() : string.Empty;
                    string ptipoafectacion = (xlWorkSheet.Cells[AA, 34].value) != null ? (xlWorkSheet.Cells[AA, 34].value).ToString() : string.Empty;
                    //string pporcentajeiva = (xlWorkSheet.Cells[AA, 38].value) != null ? (xlWorkSheet.Cells[AA, 38].value).ToString() : string.Empty;
                    //string pporcentajeacreditacion = (xlWorkSheet.Cells[AA, 39].value) != null ? (xlWorkSheet.Cells[AA, 39].value).ToString() : string.Empty;
                    //string pivaacreditable = (xlWorkSheet.Cells[AA, 40].value) != null ? (xlWorkSheet.Cells[AA, 40].value).ToString() : string.Empty;
                    //string pivagastoaplicable = (xlWorkSheet.Cells[AA, 41].value) != null ? (xlWorkSheet.Cells[AA, 41].value).ToString() : string.Empty;
                    //string ptipo = (xlWorkSheet.Cells[AA, 42].value) != null ? (xlWorkSheet.Cells[AA, 42].value).ToString() : string.Empty;
                    string pregistrocontable = (xlWorkSheet.Cells[AA, 35].value) != null ? (xlWorkSheet.Cells[AA, 35].value).ToString() : string.Empty;
                    //string pordencompra = (xlWorkSheet.Cells[AA, 44].value) != null ? (xlWorkSheet.Cells[AA, 44].value).ToString() : string.Empty;
                    //string pcentrocosto = (xlWorkSheet.Cells[AA, 45].value) != null ? (xlWorkSheet.Cells[AA, 45].value).ToString() : string.Empty;
                    //string pcuentacontable = (xlWorkSheet.Cells[AA, 46].value) != null ? (xlWorkSheet.Cells[AA, 46].value).ToString() : string.Empty;
                    //string pmodulo = (xlWorkSheet.Cells[AA, 47].value) != null ? (xlWorkSheet.Cells[AA, 47].value).ToString() : string.Empty;
                    //string pusuario = (xlWorkSheet.Cells[AA, 48].value) != null ? (xlWorkSheet.Cells[AA, 48].value).ToString() : string.Empty;
                    //string pfechacarga = (xlWorkSheet.Cells[AA, 49].value) != null ? (xlWorkSheet.Cells[AA, 49].value).ToString() : string.Empty;





                    ////siok
                    //Inserta_Asientos(pfecha, pperiodo, ptipo, pcuenta_conso, ppais, psociedad, psociedad_aso, pindicador, pimporte_local, pmoneda_local, pimporte_trans, pmoneda_trans, pcentro, pcuenta, Session["lista_ci_scia1"].ToString());

                    if (AA > 2)
                    {
                        pcodigotipoproceso = "2";
                    }

                    if (pcia == string.Empty)
                    {
                        break;
                    }

                    else
                    {
                        Inserta_FacturasTransitoTemp(
                                                    Session["nombreUsuario"].ToString()
                                                    , pcia
                                                    , pdocumento
                                                    , ptipodocumento
                                                    , pnumerolinea
                                                    , psubtipo
                                                    , pactividadeconomica
                                                    , porigen
                                                    , pactividadd104
                                                    , pfechaemision
                                                    , pidentificacionproveedor
                                                    //, pcodigoproveedor
                                                    , pnombreproveedor
                                                    //, pcodigoarticulo
                                                    , pdescripcionmercancia
                                                    , ppreciounitario
                                                    , pcantidadcomprada
                                                    , punidadmedida
                                                    , pmontosubtotal
                                                    , pdescuentoaplicado
                                                    , pimpuestoconsumo
                                                    , pivafacturado
                                                    , potros
                                                    //, pmontototal
                                                    , pmoneda
                                                    , ptipocambio
                                                    , pduaimportacion
                                                    , pfechadua
                                                    , ppartidaarancelaria
                                                    , pdetallepartidaarancelaria
                                                    , paduana
                                                    , pnombreagencia
                                                    , pagenciaaduanalcj
                                                    , pbaseimponible
                                                    , pivapagado
                                                    , potrosimpuestos
                                                    , pcodivatarifa
                                                    , ptipoafectacion
                                                    //, pporcentajeiva
                                                    //, pporcentajeacreditacion
                                                    //, pivaacreditable
                                                    //, pivagastoaplicable
                                                    //, ptipo
                                                    , pregistrocontable
                                                    //, pordencompra
                                                    //, pcentrocosto
                                                    //, pcuentacontable
                                                    //, pmodulo
                                                    //, Session["nombreUsuario"].ToString()
                                                    //, pfechacarga
                                                    , pcodigotipoproceso
                                                    , out vErr, out VMerr
                                                    );

                        //, Session["lista_ci_scia1"].ToString()
                        //EjecutarCargaAsientos(Session["lista_ci_scia1"].ToString(), Session["ci_paquete"].ToString(), PTipoAsiento, Session["ci_referencia"].ToString(), out vErr, out VMerr);

                    }




                    if (vErr != 0)
                    {
						ContadorvErr = ContadorvErr + 1;
						text = "Revise fila" + AA + ", " + VMerr;
                        //text= "Errores encontrados: " + "\r\n";

						if (ContadorvErr <= 30)

						{
							//VMerrGeneral = VMerrGeneral + "Fila " + AA + ", " + VMerr + "Environment.NewLine";
							VMerrGeneral = VMerrGeneral + "Fila " + (AA-0).ToString() + " Documento:" + pdocumento + " "+ VMerr + Environment.NewLine; //+"\r\n";

						}

						//else if(ContadorvErr == 2)

						//{


						//}
						//else if (ContadorvErr == 3)

						//{


						//}
						//else if (ContadorvErr == 4)

						//{


						//}
						//else if (ContadorvErr == 5)

						//{


						//}


					}

                    else
                    {
                        //text = "Revise test fila" + AA + ", " + VMerr;
                        text = VMerr;
                    }

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
						if (ContadorvErr==0)

							{
								text = "Archivo " + filename + " Cargado Exitosamente.";
							}
						else
							{
								text = VMerrGeneral;
							}

                }
            }

            xlWorkBook.Close();
            xlApp.Quit();
            System.Threading.Thread.CurrentThread.CurrentCulture = currentCulture;
            releaseObject(xlApp);
            releaseObject(xlWorkBook);
            releaseObject(xlWorkSheet);





			//    String Cadena = CBCia.Value.ToString();
			////siok
			//EjecutarCargaAsientos(Session["lista_ci_scia1"].ToString(), Session["ci_paquete"].ToString(), PTipoAsiento, Session["ci_referencia"].ToString(), out vErr, out VMerr);

			if (ContadorvErr == 0)

			{
				Inserta_FacturasTransito(
														Session["nombreUsuario"].ToString()
														, out vErr, out VMerr
														);

				text = VMerr;
				//text = "Test end" + AA + ", " + VMerr;

				return text;
			}
			else
			{
				text = VMerrGeneral;
				return text;
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
               // ProjectData.SetProjectError(expr_11);
                obj = null;
               // ProjectData.ClearProjectError();
            }
            finally
            {
                System.GC.Collect();
            }
        }

        private void GridFacturasTransito_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            this.SQLFacturasTransito.DataBind();
            this.GridFacturasTransito.DataBind();
        }


        //siok
        //private void Inserta_FacturasTransitoTemp(
        //                                             string pcia
        //                                            , string pdocumento
        //                                            , string ptipodocumento
        //                                            , string pnumerolinea
        //                                            , string psubtipo
        //                                            , string pactividadeconomica
        //                                            , string porigen
        //                                            , string pactividadd104
        //                                            , string pfechaemision
        //                                            , string pidentificacionproveedor
        //                                            , string pcodigoproveedor
        //                                            , string pnombreproveedor
        //                                            , string pcodigoarticulo
        //                                            , string pdescripcionmercancia
        //                                            , string ppreciounitario
        //                                            , string pcantidadcomprada
        //                                            , string punidadmedida
        //                                            , string pmontosubtotal
        //                                            , string pdescuentoaplicado
        //                                            , string pimpuestoconsumo
        //                                            , string pivafacturado
        //                                            , string potros
        //                                            , string pmontototal
        //                                            , string pmoneda
        //                                            , string ptipocambio
        //                                            , string pduaimportacion
        //                                            , string pfechadua
        //                                            , string ppartidaarancelaria
        //                                            , string pdetallepartidaarancelaria
        //                                            , string paduana
        //                                            , string pnombreagencia
        //                                            , string pagenciaaduanalcj
        //                                            , string pbaseimponible
        //                                            , string pivapagado
        //                                            , string potrosimpuestos
        //                                            , string pcodivatarifa
        //                                            , string ptipoafectacion
        //                                            , string pporcentajeiva
        //                                            , string pporcentajeacreditacion
        //                                            , string pivaacreditable
        //                                            , string pivagastoaplicable
        //                                            , string ptipo
        //                                            , string pregistrocontable
        //                                            , string pordencompra
        //                                            , string pcentrocosto
        //                                            , string pcuentacontable
        //                                            , string pmodulo
        //                                            , string pusuario
        //                                            , string pfechacarga
        //                                            , string pcodigotipoproceso
        //                                            )
        //{

        //    string VconnectionString;
        //    VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

        //    String VSQL;

        //    VSQL = "EXEC PORTAL.MonitorF.spRegistraFacturasTransitoTemp " +
        //                "'" + pcia + "'"
        //                + ",'" + pdocumento + "'"
        //                + "','" + ptipodocumento
        //                + "','" + pnumerolinea
        //                + "','" + psubtipo
        //                + "','" + pactividadeconomica
        //                + "','" + porigen
        //                + "','" + pactividadd104
        //                + "','" + pfechaemision
        //                + "','" + pidentificacionproveedor
        //                + "','" + pcodigoproveedor
        //                + "','" + pnombreproveedor
        //                + "','" + pcodigoarticulo
        //                + "','" + pdescripcionmercancia
        //                + "','" + ppreciounitario
        //                + "','" + pcantidadcomprada
        //                + "','" + punidadmedida
        //                + "','" + pmontosubtotal
        //                + "','" + pdescuentoaplicado
        //                + "','" + pimpuestoconsumo
        //                + "','" + pivafacturado
        //                + "','" + potros
        //                + "','" + pmontototal
        //                + "','" + pmoneda
        //                + "','" + ptipocambio
        //                + "','" + pduaimportacion
        //                + "','" + pfechadua
        //                + "','" + ppartidaarancelaria
        //                + "','" + pdetallepartidaarancelaria
        //                + "','" + paduana
        //                + "','" + pnombreagencia
        //                + "','" + pagenciaaduanalcj
        //                + "','" + pbaseimponible
        //                + "','" + pivapagado
        //                + "','" + potrosimpuestos
        //                + "','" + pcodivatarifa
        //                + "','" + ptipoafectacion
        //                + "','" + pporcentajeiva
        //                + "','" + pporcentajeacreditacion
        //                + "','" + pivaacreditable
        //                + "','" + pivagastoaplicable
        //                + "','" + ptipo
        //                + "','" + pregistrocontable
        //                + "','" + pordencompra
        //                + "','" + pcentrocosto
        //                + "','" + pcuentacontable
        //                + "','" + pmodulo
        //                + "','" + pusuario
        //                + "','" + pfechacarga
        //                + "','" + pcodigotipoproceso
        //                ;





        //        //+ "','" + pperiodo 
        //        //+ "','" + ptipo 
        //        //+ "','" + pcuenta_conso + "','" + ppais + "','" + psociedad + "','" + psociedad_aso + "','" + pindicador + "'," + pimporte_local + ",'" + pmoneda_local + "'," + pimporte_trans + ",'" + pmoneda_trans + "','" + pcentro + "','" + pcuenta 
        //        //+ "', 'P','" 
        //        //+ pcia 
        //        //+ "')";

        //    using (var conn = new SqlConnection(VconnectionString))
        //    using (var command = new SqlCommand(VSQL, conn)
        //    {
        //        CommandType = CommandType.Text
        //    })
        //    {
        //        conn.Open();
        //        command.ExecuteNonQuery();
        //    }


            //}
            //siok
            protected void Upload_FileUploadComplete1(object sender, FileUploadCompleteEventArgs e)
        {
            string text;
            if (e.IsValid)
            {
                text = System.DateTime.Now.ToString().Replace("/", "").Replace(":", "") + "_" + e.UploadedFile.FileName;
                e.UploadedFile.SaveAs(this.Server.MapPath("~/SecureFolder/" + text));
                e.CallbackData = text;
                //siok
                e.CallbackData = this.revisarExcel(this.Server.MapPath("~/SecureFolder/" + text), e.UploadedFile.FileName);
            }
        }

        protected void Lform_E2_Click(object sender, EventArgs e)
        {
            //grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });

            DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
            //GridFacturasTransito.OptionsView.HideAllTotals();
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            GridFacturasTransito.ExportToXlsx(stream);
            WriteToResponse("FacturaTransitos.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
            //GridFacturasTransito.OptionsView.ShowAllTotals();
        }

            private void Inserta_FacturasTransitoTemp(
                                                    string pusuariocia
                                                    , string pcia
                                                    , string pdocumento
                                                    , string ptipodocumento
                                                    , string pnumerolinea
                                                    , string psubtipo
                                                    , string pactividadeconomica
                                                    , string porigen
                                                    , string pactividadd104
                                                    , string pfechaemision
                                                    , string pidentificacionproveedor
                                                    //, string pcodigoproveedor
                                                    , string pnombreproveedor
                                                    //, string pcodigoarticulo
                                                    , string pdescripcionmercancia
                                                    , string ppreciounitario
                                                    , string pcantidadcomprada
                                                    , string punidadmedida
                                                    , string pmontosubtotal
                                                    , string pdescuentoaplicado
                                                    , string pimpuestoconsumo
                                                    , string pivafacturado
                                                    , string potros
                                                    //, string pmontototal
                                                    , string pmoneda
                                                    , string ptipocambio
                                                    , string pduaimportacion
                                                    , string pfechadua
                                                    , string ppartidaarancelaria
                                                    , string pdetallepartidaarancelaria
                                                    , string paduana
                                                    , string pnombreagencia
                                                    , string pagenciaaduanalcj
                                                    , string pbaseimponible
                                                    , string pivapagado
                                                    , string potrosimpuestos
                                                    , string pcodivatarifa
                                                    , string ptipoafectacion
                                                    //, string pporcentajeiva
                                                    //, string pporcentajeacreditacion
                                                    //, string pivaacreditable
                                                    //, string pivagastoaplicable
                                                    //, string ptipo
                                                    , string pregistrocontable
                                                    //, string pordencompra
                                                    //, string pcentrocosto
                                                    //, string pcuentacontable
                                                    //, string pmodulo
                                                    //, string pusuario
                                                    //, string pfechacarga
                                                    , string pcodigotipoproceso
                                                    , out int CodigoError, out string MensajeError
                                                    )
            {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
                int vErr;
                string VMerr;
                vErr = 0;
                VMerr = "Archivo cargado.";


                using (var conn = new SqlConnection(VconnectionString))
                using (var command = new SqlCommand("PORTAL.MonitorF.spRegistraFacturasTransitoTemp", conn)
                {
                    CommandType = CommandType.StoredProcedure
                })
                {
                    command.Parameters.AddWithValue("@PUsuarioCia", pusuariocia);
                    command.Parameters.AddWithValue("@Cia", pcia);
                    command.Parameters.AddWithValue("@Documento", pdocumento);
                    command.Parameters.AddWithValue("@TipoDocumento", ptipodocumento);
                    command.Parameters.AddWithValue("@NumeroLinea", pnumerolinea);
                    command.Parameters.AddWithValue("@SubTipo", psubtipo);
                    command.Parameters.AddWithValue("@ActividadEconomica", pactividadeconomica);
                    command.Parameters.AddWithValue("@Origen", porigen);
                    command.Parameters.AddWithValue("@ActividadD104", pactividadd104);
                    command.Parameters.AddWithValue("@FechaEmision", pfechaemision);
                    command.Parameters.AddWithValue("@identificacionProveedor", pidentificacionproveedor);
                    //command.Parameters.AddWithValue("@CodigoProveedor", pcodigoproveedor);
                    command.Parameters.AddWithValue("@NombreProveedor", pnombreproveedor);
                    //command.Parameters.AddWithValue("@CodigoArticulo", pcodigoarticulo);
                    command.Parameters.AddWithValue("@DescripcionMercancia", pdescripcionmercancia);
                    command.Parameters.AddWithValue("@PrecioUnitario", ppreciounitario);
                    command.Parameters.AddWithValue("@CantidadComprada", pcantidadcomprada);
                    command.Parameters.AddWithValue("@UnidadMedida", punidadmedida);
                    command.Parameters.AddWithValue("@MontoSubtotal", pmontosubtotal);
                    command.Parameters.AddWithValue("@DescuentoAplicado", pdescuentoaplicado);
                    command.Parameters.AddWithValue("@impuestoConsumo", pimpuestoconsumo);
                    command.Parameters.AddWithValue("@ivaFacturado", pivafacturado);
                    command.Parameters.AddWithValue("@Otros", potros);
                    //command.Parameters.AddWithValue("@MontoTotal", pmontototal);
                    command.Parameters.AddWithValue("@Moneda", pmoneda);
                    command.Parameters.AddWithValue("@TipoCambio", ptipocambio);
                    command.Parameters.AddWithValue("@DuaImportacion", pduaimportacion);
                    command.Parameters.AddWithValue("@FechaDua", pfechadua);
                    command.Parameters.AddWithValue("@PartidaArancelaria", ppartidaarancelaria);
                    command.Parameters.AddWithValue("@DetallePartidaArancelaria", pdetallepartidaarancelaria);
                    command.Parameters.AddWithValue("@Aduana", paduana);
                    command.Parameters.AddWithValue("@NombreAgencia", pnombreagencia);
                    command.Parameters.AddWithValue("@AgenciaAduanalCJ", pagenciaaduanalcj);
                    command.Parameters.AddWithValue("@BaseImponible", pbaseimponible);
                    command.Parameters.AddWithValue("@IVAPagado", pivapagado);
                    command.Parameters.AddWithValue("@OtrosImpuestos", potrosimpuestos);
                    command.Parameters.AddWithValue("@CodIVATarifa", pcodivatarifa);
                    command.Parameters.AddWithValue("@TipoAfectacion", ptipoafectacion);
                    //command.Parameters.AddWithValue("@PorcentajeIva", pporcentajeiva);
                    //command.Parameters.AddWithValue("@PorcentajeAcreditacion", pporcentajeacreditacion);
                    //command.Parameters.AddWithValue("@IvaAcreditable", pivaacreditable);
                    //command.Parameters.AddWithValue("@IvaGastoAplicable", pivagastoaplicable);
                    //command.Parameters.AddWithValue("@Tipo", ptipo);
                    command.Parameters.AddWithValue("@RegistroContable", pregistrocontable);
                //command.Parameters.AddWithValue("@OrdenCompra", pordencompra);
                //command.Parameters.AddWithValue("@CentroCosto", pcentrocosto);
                //command.Parameters.AddWithValue("@CuentaContable", pcuentacontable);
                //command.Parameters.AddWithValue("@Modulo", pmodulo);
                //command.Parameters.AddWithValue("@Usuario", pusuario);
                //command.Parameters.AddWithValue("@FechaCarga", pfechacarga);
                command.Parameters.AddWithValue("@CodigoTipoProceso", pcodigotipoproceso);



                command.Parameters.Add("@CodigoError", SqlDbType.Int, 20);
                    command.Parameters["@CodigoError"].Direction = ParameterDirection.Output;

                    command.Parameters.Add("@MensajeError", SqlDbType.Char, 32000);
                    command.Parameters["@MensajeError"].Direction = ParameterDirection.Output;


                    conn.Open();
                    command.ExecuteNonQuery();

                    vErr = (int)command.Parameters["@CodigoError"].Value;
                    VMerr = (string)command.Parameters["@MensajeError"].Value;

                }

            //CodigoError = Int32.Parse(vErr);
            CodigoError = vErr;
            MensajeError = VMerr;


            }



        private void Inserta_FacturasTransito(string pusuariocia
                                            , out int CodigoError, out string MensajeError
                                                )
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            int vErr;
            string VMerr;
            vErr = 0;
            VMerr = "Archivo cargado.";


            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.MonitorF.spRegistraFacturasTransito", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PUsuarioCia", pusuariocia);
                //command.Parameters.AddWithValue("@Cia", pcia);
                //command.Parameters.AddWithValue("@CodigoTipoProceso", pcodigotipoproceso);



                command.Parameters.Add("@CodigoError", SqlDbType.Int, 20);
                command.Parameters["@CodigoError"].Direction = ParameterDirection.Output;

                command.Parameters.Add("@MensajeError", SqlDbType.Char, 32000);
                command.Parameters["@MensajeError"].Direction = ParameterDirection.Output;


                conn.Open();
                command.ExecuteNonQuery();

                vErr = (int)command.Parameters["@CodigoError"].Value;
                VMerr = (string)command.Parameters["@MensajeError"].Value;

            }

            //CodigoError = Int32.Parse(vErr);
            CodigoError = vErr;
            MensajeError = VMerr;


        }


        //siok
        //private void EjecutarCargaAsientos(string PCIA, string PPAQUETE, string Ptipo_asiento, string PREFERENCIA, out int PERR, out string PMERR)
        //{

        //    //string VconnectionString;
        //    VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
        //    string vErr;
        //    string VMerr;
        //    vErr = "0";
        //    VMerr = "Archivo cargado.";


        //    using (var conn = new SqlConnection(VconnectionString))
        //    using (var command = new SqlCommand("PORTAL.[dbo].[PORTAL_xxCARGA_ASIENTOS2xxxxx]", conn)
        //    {
        //        CommandType = CommandType.StoredProcedure
        //    })
        //    {
        //        command.Parameters.AddWithValue("@PCIA", PCIA);
        //        command.Parameters.AddWithValue("@PPAQUETE", PPAQUETE);
        //        command.Parameters.AddWithValue("@Ptipo_asiento", Ptipo_asiento);
        //        command.Parameters.AddWithValue("@PREFERENCIA", PREFERENCIA);

        //        command.Parameters.Add("@PERROR", SqlDbType.Char, 20);
        //        command.Parameters["@PERROR"].Direction = ParameterDirection.Output;

        //        command.Parameters.Add("@PMERR", SqlDbType.Char, 32000);
        //        command.Parameters["@PMERR"].Direction = ParameterDirection.Output;


        //        conn.Open();
        //        command.ExecuteNonQuery();

        //        vErr = (string)command.Parameters["@PERROR"].Value;
        //        VMerr = (string)command.Parameters["@PMERR"].Value;

        //    }

        //    PERR = Int32.Parse(vErr);
        //    PMERR = VMerr;


        //}



    }
}
