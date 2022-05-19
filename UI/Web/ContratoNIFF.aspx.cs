using BusinessLogic.Clases;
using DevExpress.Export.Xl;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utilitarios.Clases;

namespace UI.Web
{
    public partial class ContratoNIFF : System.Web.UI.Page
    {
        private string CurrentCiactaID
        {

            get { return Session["CurrentCiactaID"] == null ? String.Empty : Session["CurrentCiactaID"].ToString(); }
            set
            {
                Session["CurrentCiactaID"] = value;
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
                Session["ci_stipo"] = "A";
                SQLCompania.DataBind();

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

        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {
            LayoutItem itemFechaInicial = Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem;
            ASPxDateEdit CBFechaInicial = itemFechaInicial.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemFechaFinal = Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem;
            ASPxDateEdit CBFechaFinal = itemFechaFinal.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            ASPxDropDownEdit CBCiaOri = itemCiaOri.GetNestedControl() as ASPxDropDownEdit;

            LayoutItem itemtiporep = Lform.FindItemOrGroupByName("CB_Tipo_Reporte") as LayoutItem;
            ASPxComboBox CBtiporep = itemtiporep.GetNestedControl() as ASPxComboBox;

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
                Session["ci_stipo"] = CBtiporep.Value != null ? CBtiporep.Value.ToString() : string.Empty;
            }
        }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
            //PivotContratoNIIF.OptionsView.HideAllTotals();
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            ASPxPivExp1.ExportToXlsx(stream);
            WriteToResponse("ReporteOrdenCompra.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
            //PivotContratoNIIF.OptionsView.ShowAllTotals();
        }

        protected void ExportExcel1_Click(object sender, EventArgs e)
        {
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
        }

        protected void ExportExcel2_Click(object sender, EventArgs e)
        {
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
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

        protected void grid_data_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            string keyValue = grid.GetRowValues(e.VisibleIndex, "CONTRATO_ID").ToString();
            if (e.ButtonID.Equals("btnDescargar"))
            {
                ASPxGridView.RedirectOnCallback(string.Format("Descarga.aspx?id={0}", keyValue));
            }
            else
            {
                if (e.ButtonID.Equals("btnDetalle"))
                {
                    ASPxGridView.RedirectOnCallback(string.Format("VerContratoNIFF.aspx?id={0}", keyValue));
                }
                else
                {
                    if (e.ButtonID.Equals("btnAmortizacion"))
                    {
                        ASPxGridView.RedirectOnCallback(string.Format("VerAmortizacion.aspx?id={0}", keyValue));
                    }
                    else
                    {
                        if (e.ButtonID.Equals("btnDepreciacion"))
                        {
                            ASPxGridView.RedirectOnCallback(string.Format("VerDepreciacion.aspx?id={0}", keyValue));
                        }
                        else
                        {
                            if (e.ButtonID.Equals("btnIntereses"))
                            {
                                ASPxGridView.RedirectOnCallback(string.Format("VerIntereses.aspx?id={0}", keyValue));
                            }
                        }
                    }
                }
            }
        }

        private void descargarExcel(string valor)
        {
            ContratoBL objContrato = new ContratoBL();
            Contrato oContrato = new Contrato();
            oContrato = objContrato.obtenerContrato(Convert.ToInt32(valor));
            int fila = -1;
            IXlExporter exporter = XlExport.CreateExporter(XlDocumentFormat.Xlsx);
            FileStream stream = new FileStream(this.Server.MapPath("~/SecureFolder/" + "Anexo NIFF 16.xlsx"), FileMode.Create);
            IXlDocument document = exporter.CreateDocument(stream);
            IXlSheet sheet = document.CreateSheet();
            sheet.Name = "Cálculos Arrendamiento";

            /*Configuramos las columnas de la primera hoja*/
            using (IXlColumn column = sheet.CreateColumn())
                column.WidthInPixels = 20;

            using (IXlColumn column = sheet.CreateColumn())
                column.WidthInPixels = 200;

            using (IXlColumn column = sheet.CreateColumn())
                column.WidthInPixels = 180;

            using (IXlColumn column = sheet.CreateColumn())
                column.WidthInPixels = 200;

            using (IXlColumn column = sheet.CreateColumn())
                column.WidthInPixels = 90;
            using (IXlColumn column = sheet.CreateColumn())
                column.WidthInPixels = 90;
            using (IXlColumn column = sheet.CreateColumn())
                column.WidthInPixels = 90;
            using (IXlColumn column = sheet.CreateColumn())
                column.WidthInPixels = 160;
            using (IXlColumn column = sheet.CreateColumn())
                column.WidthInPixels = 130;
            using (IXlColumn column = sheet.CreateColumn())
                column.WidthInPixels = 130;
            using (IXlColumn column = sheet.CreateColumn())
                column.WidthInPixels = 140;

            /*Formato Negrita*/
            XlCellFormatting formatoNegrita = new XlCellFormatting();
            formatoNegrita.Font = new XlFont();
            formatoNegrita.Font.Bold = true;
            /***********************************************/
            /*Formato Negrita Subrayado - Simple*/
            XlCellFormatting formatoNegritaSubrayado = new XlCellFormatting();
            formatoNegritaSubrayado.Font = new XlFont();
            formatoNegritaSubrayado.Font.Bold = true;
            formatoNegritaSubrayado.Font.Underline = XlUnderlineType.Single;
            /*Formato Negrita Subrayado - Doble*/
            XlCellFormatting formatoNegritaSubrayadoDoble = new XlCellFormatting();
            formatoNegritaSubrayadoDoble.Font = new XlFont();
            formatoNegritaSubrayadoDoble.Font.Bold = true;
            formatoNegritaSubrayadoDoble.Font.Underline = XlUnderlineType.Double;
            /*****************************************************/
            /*Negrita - Fondo Gris*/
            XlCellFormatting formatoTitulo1 = new XlCellFormatting();
            formatoTitulo1.Font = new XlFont();
            formatoTitulo1.Font.Bold = true;
            formatoTitulo1.Fill = XlFill.SolidFill(XlColor.FromTheme(XlThemeColor.Accent3, 0.0));
            /*********************************************/
            /*Negrita Blanco - Fondo Azul*/
            XlCellFormatting formatoTitulo2 = new XlCellFormatting();
            formatoTitulo2.Font = new XlFont();
            formatoTitulo2.Font.Bold = true;
            formatoTitulo2.Font.Color = XlColor.FromTheme(XlThemeColor.Light1, 0.0);
            formatoTitulo2.Fill = XlFill.SolidFill(XlColor.FromTheme(XlThemeColor.Accent5, 0.0));
            /*********************************************/

            using (IXlRow row = sheet.CreateRow())
            {
                //Creamos una fila en blanco
                fila = fila + 1;
            }

            /*Segunda Fila*/
            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "1";
                }

                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Para realizar el cálculo del activo por derecho de uso y su correspondiente pasivo financiero se deben considerar todos los pagos fijos que se tendrán que desembolsar a lo largo del tiempo que se espera mantener el contrato";
                }
                fila = fila + 1;
            }
            /*Tercera Fila*/
            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }

                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "incluido el tiempo que se espera extender si fuese factible, así como también los aumentos a las cuotas que esten definidas por contrato, de tratarse de variables que se definiran en el tiempo tal como la inflación se deberá incluir";
                }
                fila = fila + 1;
            }
            /*Cuarta Fila*/
            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }

                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "en el cálculo en el momento en que se definan, los datos anteriormente detallados ya se encuentran incluidas en el tab denominado Análisis y debidamente referenciados a esta hoja. Adicionalmente se deben completar en el cuadro";
                }
                fila = fila + 1;
            }

            /*Quinta Fila*/
            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }

                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "siguiente los espacios marcados en celeste son derivados de la información anterior. Por otra parte se deben completar los datos de la tasa de descuento que se encuentran marcados en color verde.";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                //Creamos una fila en blanco
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Cálculo de los arrendamientos";
                    cell.ApplyFormatting(formatoNegritaSubrayado);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }

                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "CUADRO DE INCLUSIÓN DE DATOS";
                    cell.ApplyFormatting(formatoNegrita);
                }
                fila = fila + 1;
            }
            sheet.MergedCells.Add(XlCellRange.FromLTRB(3, fila, 11, fila));

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Fecha Inicial de Contrato";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = oContrato.FechaInicioArrendamiento.Substring(0, 10).Replace("-", "/");
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Plazo";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    int anio1 = Convert.ToInt32(oContrato.FechaInicioArrendamiento.Substring(7, 4).ToString());
                    int anio2 = Convert.ToInt32(oContrato.FechaVencimientoArrendamiento.Substring(7, 4).ToString());
                    int resultado = anio2 - anio1;
                    cell.Value = resultado.ToString();
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Años";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }

                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                    //cell.Value = "Aumento Anual";
                    //cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Fecha Final Primer Periodo";
                    cell.ApplyFormatting(formatoTitulo1);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = DateTime.Parse(oContrato.FechaInicioArrendamiento).AddYears(1).ToShortDateString().Replace("-", "/");
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Fecha Final ";
                    cell.ApplyFormatting(formatoTitulo1);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = oContrato.FechaVencimientoArrendamiento.Substring(0, 10).Replace("-", "/");
                }
                fila = fila + 1;
            }
            sheet.MergedCells.Add(XlCellRange.FromLTRB(4, fila, 5, fila));

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Pago";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = oContrato.CuotaArrendamiento.ToString();
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Fecha Final Primer Año";
                    cell.ApplyFormatting(formatoTitulo1);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "31/12/" + oContrato.FechaInicioArrendamiento.Substring(6, 4);
                }
                fila = fila + 1;
            }
            using (IXlRow row = sheet.CreateRow())
            {
                //Creamos una fila en blanco
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Tasa Anual";
                    cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Formatting = XlNumberFormat.Percentage;
                    cell.Value = (XlVariantValue)oContrato.TasaAnual;
                    //"0.0%"
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Perioricidad Cuota";
                    cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = oContrato.PerioricidadCuota.ToString();
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Tasa Mensual Implicita";
                    cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    decimal tasaImplicita = oContrato.TasaAnual / oContrato.PerioricidadCuota;
                    cell.Value = tasaImplicita.ToString();
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                //Creamos una fila en blanco
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "2";
                }

                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Con la inclusión de los datos en el cuadro respectivo, automáticamente se realiza el cálculo anual de las cuotas y respectivo aumento";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                //Creamos una fila en blanco
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Número de Cuotas";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Cuota Anual";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "De noviembre a diciembre";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "De enero a octubre";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Cuota Anual Final";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                fila = fila + 1;
            }
            sheet.MergedCells.Add(XlCellRange.FromLTRB(5, fila, 6, fila));

            List<CuotaAnual> lstCuotas = objContrato.obtenerCuotasAnualesContrato(Convert.ToInt32(valor));
            decimal montoTotal = 0;
            foreach (CuotaAnual item in lstCuotas)
            {
                using (IXlRow row = sheet.CreateRow())
                {
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.Anio;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.NroCuota;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.MontoCuotaAnual.ToString();
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.PrimerTramo.ToString();
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.SegundoTramo.ToString();
                    }

                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.CuotaAnualFinal.ToString();
                        montoTotal = montoTotal + item.CuotaAnualFinal;
                    }
                    fila = fila + 1;
                }
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoTotal.ToString();
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                //Creamos una fila en blanco
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "3";
                }

                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Posteriormente en función del cálculo anterior, automaticamente se realiza el descuento del valor del activo por derecho de uso y su correspondiente pasivo financiero";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                //Creamos una fila en blanco
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Tasa Incremental";
                    cell.ApplyFormatting(formatoTitulo1);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Tasa Anual";
                    cell.ApplyFormatting(formatoTitulo1);
                }
                fila = fila + 1;
            }
            sheet.MergedCells.Add(XlCellRange.FromLTRB(5, fila, 8, fila));

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Año";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Mes";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Número de cuotas";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Cuota Anual";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Valor Presente";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                fila = fila + 1;
            }

            List<Valor_Activo> lstActivo = new List<Valor_Activo>();
            decimal montoTotalValorPresente = 0;
            decimal montoTotalCuotaAnual = 0;
            lstActivo = objContrato.obtenerDescuentoValorActivo(Convert.ToInt32(valor));
            foreach (Valor_Activo item in lstActivo)
            {
                using (IXlRow row = sheet.CreateRow())
                {
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.Anio;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.Mes;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.NroCuota;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.CuotaAnual.ToString();
                        montoTotalCuotaAnual = montoTotalCuotaAnual + item.CuotaAnual;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.ValorPresente.ToString();
                        montoTotalValorPresente = montoTotalValorPresente + item.ValorPresente;
                    }
                    fila = fila + 1;
                }

            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Total Monto Descontado";
                    cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoTotalCuotaAnual.ToString();
                    cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoTotalValorPresente.ToString();
                    cell.ApplyFormatting(formatoNegrita);
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                //Creamos una fila en blanco
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Estado de situación financiera";
                    cell.ApplyFormatting(formatoNegritaSubrayado);
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                //Creamos una fila en blanco
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "1)";
                    cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Monto del pasivo financiero";
                    cell.ApplyFormatting(formatoNegrita);
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Párrafo 27";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "En la fecha de comienzo, los paos por arrendamiento incluidos en la medición del pasivo por arrendamiento comprenden los pagos siguientes por el derecho a usar el activo subyacente durante el plazo del arrendamiento que no se paguen en la fecha de comienzo:";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                fila = fila + 1;
            }
            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "(a) pagos fijos (incluyendo los pagos en esencia fijos como se describe en el párrafo B42), menos cualquier incentivo de arrendamiento por cobrar;";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "(b) pagos por arrendamiento variables, que dependen de un índice o una tasa, inicialmente medidos usando el índice o tasa en la fecha de comienzo (como se describe en el párrafo 28);";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "(c) importes que espera pagar el arrendatario como garantías de valor residual;";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "(d) el precio de ejercicio de una opción de compra si el arrendatario está razonablemente seguro de ejercer esa opción (evaliada considerando los factores descritos en los párrafos B37 a B40); y";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "(e) pagos por penalizaciones derivadas de la terminación del arrendamiento, si el plazo del arrendamiento refleja que el arrendatario ejercerá una opción para terminar el arrendamiento.";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "a) y b)";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoTotalValorPresente.ToString();
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "c)";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "-";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "d)";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "-";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "e)";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "-";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Total";
                    cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoTotalValorPresente.ToString();
                    cell.ApplyFormatting(formatoNegritaSubrayadoDoble);
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "2)";
                    cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Monto del Activo (Derecho de uso)";
                    cell.ApplyFormatting(formatoNegrita);
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "El costo del activo por derecho de uso comprenderá:";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "(a) el importe de la medición inicial del pasivo por arrendamiento.";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "(b) los pagos por arrendamiento realizados antes o a partir de la fecha de comienzo, menos los incentivos de arrendamiento recibidos;";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "(c) los costos directos iniciales incurridos por el arrendatario; y";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "(d) una estimación de los costos a incurrir por el arrendatario al desmantelar y eliminar el activo subyacente, restaurando el lugar en el que est´ubicado o restaurar el activo subyacente a la condición requerida por los términos y condiciones del arrendamiento, a menos que se incurra en esos costos para producir inventarios. El arrendatario incurre en obligaciones a consecuencia de esos costos ya sea en la fecha de comienzo o como una consecuencia de haber usado el activo subyacente durante un periodo concreto.";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "a)";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoTotalValorPresente.ToString();
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "b)";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "-";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "c)";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "-";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "d)";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "-";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Total";
                    cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoTotalValorPresente.ToString();
                    cell.ApplyFormatting(formatoNegritaSubrayadoDoble);
                }
                fila = fila + 1;
            }

            sheet.Dispose();
            /**********************************************/
            /* Segunda Hoja */
            /**********************************************/
            IXlSheet sheet2 = document.CreateSheet();
            sheet2.Name = "Cálculos";
            fila = -1;
            /*Configuramos las columnas de la primera hoja*/
            using (IXlColumn column = sheet2.CreateColumn())
                column.WidthInPixels = 30;

            using (IXlColumn column = sheet2.CreateColumn())
                column.WidthInPixels = 150;

            using (IXlColumn column = sheet2.CreateColumn())
                column.WidthInPixels = 100;

            using (IXlColumn column = sheet2.CreateColumn())
                column.WidthInPixels = 100;

            using (IXlColumn column = sheet2.CreateColumn())
                column.WidthInPixels = 100;

            using (IXlColumn column = sheet2.CreateColumn())
                column.WidthInPixels = 160;

            using (IXlRow row = sheet2.CreateRow())
            {
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "1";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Con la finalidad de ir amortizando el pasivo financiero se realiza la correspondiente tabla de amortización del contrato";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "de arrendamiento y que cuenta con la información debidamente relacionada al cuadro de datos de la hoja anterior";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Unicamente se deben incluir la fecha inicial y final del descuento que esta relacionada con la información que brinda el contrato.";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Tabla de amortización del contrato de arrendamiento";
                    cell.ApplyFormatting(formatoNegritaSubrayado);
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Valor Razonable";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoTotalValorPresente.ToString();
                    cell.ApplyFormatting(formatoNegrita);
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Tasa Anual";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = oContrato.TasaAnual.ToString();
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Perioricidad Cuota";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = oContrato.PerioricidadCuota.ToString();
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Tasa Mensual Implicita";
                    cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    decimal tasaImplicita = oContrato.TasaAnual / oContrato.PerioricidadCuota;
                    cell.Value = tasaImplicita.ToString();
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                fila = fila + 1;
            }
            using (IXlRow row = sheet2.CreateRow())
            {
                fila = fila + 1;
            }
            using (IXlRow row = sheet2.CreateRow())
            {
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Número de Cuotas";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Fecha de Pago";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Cuota";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Interés";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Amortización Principal";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Saldo";
                    cell.ApplyFormatting(formatoTitulo2);
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoTotalValorPresente.ToString();
                }
                fila = fila + 1;
            }

            List<Amortizacion> lstAmortizacion = new List<Amortizacion>();
            lstAmortizacion = objContrato.obtenerAmortizacionContrato(Convert.ToInt32(valor));
            decimal montoTotalCuota = 0;
            decimal montoTotalIntereses = 0;
            decimal montoTotalAmortizacion = 0;
            foreach (Amortizacion item in lstAmortizacion)
            {
                using (IXlRow row = sheet2.CreateRow())
                {
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.NroCuota;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.Anio;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.ValorCuota.ToString();
                        montoTotalCuota = montoTotalCuota + item.ValorCuota;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.Interes.ToString();
                        montoTotalIntereses = montoTotalIntereses + item.Interes;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.MontoAmortizacion.ToString();
                        montoTotalAmortizacion = montoTotalAmortizacion + item.MontoAmortizacion;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.Saldo.ToString();
                    }
                    fila = fila + 1;
                }
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Totales";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoTotalCuota.ToString();
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoTotalIntereses.ToString();
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoTotalAmortizacion.ToString();
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "2";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Posteriormente con la información calculada en el cuadro anterior, automáticamente se realiza una comparación entre el escenario";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Financiero y el escenario Operativo";
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Escenario Financiero";
                    cell.ApplyFormatting(formatoNegrita);
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Contabilización Arrendamiento Financiero";
                    cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Contabilización Arrendamiento Operativo";
                    cell.ApplyFormatting(formatoNegrita);
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Gasto de Intereses";
                    cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Gasto de Depreciación";
                    cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Total Gasto";
                    cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Gasto de Alquiler";
                    cell.ApplyFormatting(formatoNegrita);
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "Mejor Utilidad";
                    cell.ApplyFormatting(formatoNegrita);
                }
                fila = fila + 1;
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                fila = fila + 1;
            }
            List<Arrendamiento> lstArrendamiento = new List<Arrendamiento>();
            lstArrendamiento = objContrato.obtenerArrendamiento(Convert.ToInt32(valor));
            decimal montoGastoInteres = 0;
            decimal montoGastoDepreciacion = 0;
            decimal montoTotalGasto = 0;
            decimal montoGastoAlquiler = 0;
            decimal montoTotalUtilidad = 0;
            foreach (Arrendamiento item in lstArrendamiento)
            {
                using (IXlRow row = sheet2.CreateRow())
                {
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.Correlativo;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.Anio;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.GastoInteres.ToString();
                        montoGastoInteres = montoGastoInteres + item.GastoInteres;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.GastoDepreciacion.ToString();
                        montoGastoDepreciacion = montoGastoDepreciacion + item.GastoDepreciacion;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.TotalGasto.ToString();
                        montoTotalGasto = montoTotalGasto + item.TotalGasto;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.Correlativo;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.GastoAlquiler.ToString();
                        montoGastoAlquiler = montoGastoAlquiler + item.GastoAlquiler;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.MejorUtilidad.ToString();
                        montoTotalUtilidad = montoTotalUtilidad + item.MejorUtilidad;
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = item.Tipo;
                        cell.ApplyFormatting(formatoNegrita);
                    }
                    fila = fila + 1;
                }
            }

            using (IXlRow row = sheet2.CreateRow())
            {
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoGastoInteres.ToString();
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoGastoDepreciacion.ToString();
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoTotalGasto.ToString();
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = "";
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoGastoAlquiler.ToString();
                }
                using (IXlCell cell = row.CreateCell())
                {
                    cell.Value = montoTotalUtilidad.ToString();
                }
                using (IXlCell cell = row.CreateCell())
                {
                    if (montoTotalUtilidad > 0)
                    {
                        cell.Value = "Financiero";
                    }
                    else
                    {
                        cell.Value = "Operativo";
                    }
                    cell.ApplyFormatting(formatoNegrita);
                }
                fila = fila + 1;
            }
            sheet2.Dispose();

            document.Dispose();
            stream.Dispose();
            string ruta = this.Server.MapPath("~/SecureFolder/" + "Anexo NIFF 16.xlsx");
            //Process.Start("Anexo NIFF 16.xlsx");
            Process.Start(ruta);
        }

        protected void Lform_E2_Click(object sender, EventArgs e)
        {

        }
    }
}