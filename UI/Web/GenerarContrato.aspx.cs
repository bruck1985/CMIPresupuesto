using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxSpreadsheet;
using System.Diagnostics;
using System.Drawing;
using DevExpress.Export.Xl;
using System.IO;
using Utilitarios.Clases;
using BusinessLogic.Clases;

namespace UI.Web
{
    public partial class GenerarContrato : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params["id"] != null)
            {
                string valor = "";
                valor = Request.Params["id"];

                ContratoBL objContrato = new ContratoBL();
                Contrato oContrato = new Contrato();
                oContrato = objContrato.obtenerContrato(Convert.ToInt32(valor));
                int fila = -1;
                IXlExporter exporter = XlExport.CreateExporter(XlDocumentFormat.Xlsx);
                FileStream stream = new FileStream("Anexo NIFF 16.xlsx", FileMode.Create);
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
                        cell.Value = oContrato.FechaInicioArrendamiento.Substring(0,10).Replace("-","/");
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
                        cell.Value = DateTime.Parse(oContrato.FechaInicioArrendamiento).AddYears(1).ToShortDateString().Replace("-","/");
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "Fecha Final ";
                        cell.ApplyFormatting(formatoTitulo1);
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = oContrato.FechaVencimientoArrendamiento.Substring(0,10).Replace("-","/");
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
                        cell.Value = "31/12/"+oContrato.FechaInicioArrendamiento.Substring(6,4);
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
                        //cell.Value = tasaImplicita.ToString();
                        cell.Value = oContrato.TasaDescuento.ToString();
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
                        //cell.Value = tasaImplicita.ToString();
                        cell.Value = oContrato.TasaDescuento.ToString();
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
                            cell.Value = item.Saldo.ToString() ;
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
                        if (montoTotalUtilidad>0)
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

                /**********************************************/
                /* Segunda Hoja */
                /**********************************************/
                /*IXlSheet sheet3 = document.CreateSheet();
                sheet3.Name = "Efectos";
                using (IXlColumn column = sheet3.CreateColumn())
                    column.WidthInPixels = 20;

                using (IXlColumn column = sheet3.CreateColumn())
                    column.WidthInPixels = 250;

                using (IXlRow row = sheet3.CreateRow())
                {
                }

                using (IXlRow row = sheet3.CreateRow())
                {
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "Finalmente se deben realizar los registros contables que provienen de todos los cálculos anteriores y que se encuentran debidamente relacionados a las páginas anteriores";
                    }
                }

                using (IXlRow row = sheet3.CreateRow())
                {
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "1.-Se deben regidtrar el activo por derecho de uso y el pasivo financiero en cuyo caso se debe separar la porción de corto y largo plazo";
                    }
                }

                using (IXlRow row = sheet3.CreateRow())
                {
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "2.-Se debe registrar el gasto anual de la depreciación del Activo por derecho de Uso por Arrendamientos";
                    }
                }

                using (IXlRow row = sheet3.CreateRow())
                {
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "3.-Se debe registrar la provisión anual, el correspondiente gasto financiero y la amortización al pasivo financiero correspondientes al periodo 2019";
                    }
                }

                using (IXlRow row = sheet3.CreateRow())
                {
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "4.-Se deben reversar la provisión anual y el costo de desarrollo realmente pagado, con la finalidad de que el gasto quede como financiero de acuerdo a la NIIF 16";
                    }
                }

                using (IXlRow row = sheet3.CreateRow())
                {
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "5.-Se debe registrar un Impuesto sobre la renta diferido de acuerdo al porcentaje de renta (27%) por la diferencia entre el valor del activo y el del pasivo a la fecha de cálculo";
                    }
                }

                using (IXlRow row = sheet3.CreateRow())
                {
                }

                using (IXlRow row = sheet3.CreateRow())
                {
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "Registrar diciembre 2019";
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
                        cell.Value = "Asientos";
                    }
                }

                using (IXlRow row = sheet3.CreateRow())
                {
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "Activos";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = montoTotalValorPresente.ToString();
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "1";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "Activo por Derecho de uso por Arrendamientos";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = montoTotalValorPresente.ToString();
                    }
                }

                using (IXlRow row = sheet3.CreateRow())
                {
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "Pasivos";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = montoTotalValorPresente.ToString();
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
                        cell.Value = "Pasivo Financiero por arrendamiento CP";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "";
                    }
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = montoTotalValorPresente.ToString();
                    }
                }
                */
                /*XlCellFormatting cellFormatting = new XlCellFormatting();
                cellFormatting.Font = new XlFont();
                cellFormatting.Font.Name = "Century Gothic";
                cellFormatting.Font.SchemeStyle = XlFontSchemeStyles.None;

                XlCellFormatting headerRowFormatting = new XlCellFormatting();
                headerRowFormatting.CopyFrom(cellFormatting);
                headerRowFormatting.Font.Bold = true;
                headerRowFormatting.Font.Color = XlColor.FromTheme(XlThemeColor.Light1, 0.0);
                headerRowFormatting.Fill = XlFill.SolidFill(XlColor.FromTheme(XlThemeColor.Accent2, 0.0));

                XlCellFormatting totalRowFormatting = new XlCellFormatting();
                totalRowFormatting.CopyFrom(cellFormatting);
                totalRowFormatting.Font.Bold = true;
                totalRowFormatting.Fill = XlFill.SolidFill(XlColor.FromTheme(XlThemeColor.Accent5, 0.6));

                using (IXlRow row = sheet.CreateRow())
                {
                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "Region";
                        cell.ApplyFormatting(headerRowFormatting);
                    }

                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "Product";
                        cell.ApplyFormatting(headerRowFormatting);
                    }

                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "Sales";
                        cell.ApplyFormatting(headerRowFormatting);
                    }

                }*/

                /*string[] products = new string[] { "Camembert Pierrot", "Gorgonzola Telino", "Mascarpone Fabioli", "Mozzarella di Giovanni" };
                int[] amount = new int[] { 6750, 4500, 3550, 4250, 5500, 6250, 5325, 4235 };

                for (int i = 0; i < 8; i++)
                {
                    using (IXlRow row = sheet.CreateRow())
                    {
                        using (IXlCell cell = row.CreateCell())
                        {
                            cell.Value = (i < 4) ? "East" : "West";
                            cell.ApplyFormatting(cellFormatting);
                        }

                        using (IXlCell cell = row.CreateCell())
                        {
                            cell.Value = products[i % 4];
                            cell.ApplyFormatting(cellFormatting);
                        }

                        using (IXlCell cell = row.CreateCell())
                        {
                            cell.Value = amount[i];
                            cell.ApplyFormatting(cellFormatting);
                        }
                    }
                }

                sheet.AutoFilterRange = sheet.DataRange;
                using (IXlRow row = sheet.CreateRow())
                {
                    using (IXlCell cell = row.CreateCell())
                        cell.ApplyFormatting(totalRowFormatting);

                    using (IXlCell cell = row.CreateCell())
                    {
                        cell.Value = "Total amount";
                        cell.ApplyFormatting(totalRowFormatting);
                        cell.ApplyFormatting(XlCellAlignment.FromHV(XlHorizontalAlignment.Right, XlVerticalAlignment.Bottom));
                    }

                    using (IXlCell cell = row.CreateCell())
                    {
                        // Add values in the cell range С2 through С9 using the SUBTOTAL function. 
                        cell.SetFormula(XlFunc.Subtotal(XlCellRange.FromLTRB(2, 1, 2, 8),XlSummary.Sum, true));
                        cell.ApplyFormatting(totalRowFormatting);
                    }
                }*/


                document.Dispose();
                stream.Dispose();
                Process.Start("Anexo NIFF 16.xlsx");
            }
        }
    }
}