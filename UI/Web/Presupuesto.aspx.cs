using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DevExpress.Web.Bootstrap;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using DevExpress.Export;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using DevExpress.XtraPrintingLinks;
using System.IO;
using DevExpress.XtraSpreadsheet;
using DevExpress.Spreadsheet;
//using Microsoft.Office.Interop.Excel;

namespace UI.Web
{
    public partial class Presupuesto : System.Web.UI.Page
    {
        bool bounded;
       
        protected void Page_Load(object sender, EventArgs e)
        {
           


            LayoutItem itemArea = Lform.FindItemOrGroupByName("cbarea") as LayoutItem;
            ASPxComboBox CBArea = itemArea.GetNestedControl() as ASPxComboBox;

            LayoutItem itemAno = Lform.FindItemOrGroupByName("cbano") as LayoutItem;
            ASPxComboBox CBAno = itemAno.GetNestedControl() as ASPxComboBox;

            Session["PAREA"] = CBArea.Value != null ? CBArea.Value.ToString() : "1";
            Session["PANO"] = CBAno.Value != null ? CBAno.Value.ToString() : "1900";

        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {
            string PERIODO = "";
            string ESTADO_PRESUPUESTO = "";
            string ESTADO_FORECAST = "";

            LayoutItem itemArea = Lform.FindItemOrGroupByName("cbarea") as LayoutItem;
            ASPxComboBox CBArea = itemArea.GetNestedControl() as ASPxComboBox;

            LayoutItem itemAno = Lform.FindItemOrGroupByName("cbano") as LayoutItem;
            ASPxComboBox CBAno = itemAno.GetNestedControl() as ASPxComboBox;

            Session["PAREA"] = CBArea.Value != null ? CBArea.Value.ToString() : "1";
            Session["PANO"] = CBAno.Value != null ? CBAno.Value.ToString() : "1900";

            string PERR = "0";
            string PMerr = "ok";
            string PUser;
            PUser = Session["nombreUsuario"].ToString();

            EjecutarDuplicarAno(Session["PAREA"].ToString(), Session["PANO"].ToString(), out PERIODO, out ESTADO_PRESUPUESTO, out ESTADO_FORECAST);

            ASPxGridView1.DataColumns["ENERO"].ReadOnly = false;
            ASPxGridView1.DataColumns["FEBRERO"].ReadOnly = false;
            ASPxGridView1.DataColumns["MARZO"].ReadOnly = false;
            ASPxGridView1.DataColumns["ABRIL"].ReadOnly = false;
            ASPxGridView1.DataColumns["MAYO"].ReadOnly = false;
            ASPxGridView1.DataColumns["JUNIO"].ReadOnly = false;
            ASPxGridView1.DataColumns["JULIO"].ReadOnly = false;
            ASPxGridView1.DataColumns["AGOSTO"].ReadOnly = false;
            ASPxGridView1.DataColumns["SEPTIEMBRE"].ReadOnly = false;
            ASPxGridView1.DataColumns["OCTUBRE"].ReadOnly = false;
            ASPxGridView1.DataColumns["NOVIEMBRE"].ReadOnly = false;
            ASPxGridView1.DataColumns["DICIEMBRE"].ReadOnly = false;


            ASPxGridView1.DataColumns["FENERO"].ReadOnly = false;
            ASPxGridView1.DataColumns["FFEBRERO"].ReadOnly = false;
            ASPxGridView1.DataColumns["FMARZO"].ReadOnly = false;
            ASPxGridView1.DataColumns["FABRIL"].ReadOnly = false;
            ASPxGridView1.DataColumns["FMAYO"].ReadOnly = false;
            ASPxGridView1.DataColumns["FJUNIO"].ReadOnly = false;
            ASPxGridView1.DataColumns["FJULIO"].ReadOnly = false;
            ASPxGridView1.DataColumns["FAGOSTO"].ReadOnly = false;
            ASPxGridView1.DataColumns["FSEPTIEMBRE"].ReadOnly = false;
            ASPxGridView1.DataColumns["FOCTUBRE"].ReadOnly = false;
            ASPxGridView1.DataColumns["FNOVIEMBRE"].ReadOnly = false;
            ASPxGridView1.DataColumns["FDICIEMBRE"].ReadOnly = false;


            if (ESTADO_PRESUPUESTO=="C")
            {
                ASPxGridView1.DataColumns["ENERO"].ReadOnly = true;
                ASPxGridView1.DataColumns["FEBRERO"].ReadOnly = true;
                ASPxGridView1.DataColumns["MARZO"].ReadOnly = true;
                ASPxGridView1.DataColumns["ABRIL"].ReadOnly = true;
                ASPxGridView1.DataColumns["MAYO"].ReadOnly = true;
                ASPxGridView1.DataColumns["JUNIO"].ReadOnly = true;
                ASPxGridView1.DataColumns["JULIO"].ReadOnly = true;
                ASPxGridView1.DataColumns["AGOSTO"].ReadOnly = true;
                ASPxGridView1.DataColumns["SEPTIEMBRE"].ReadOnly = true;
                ASPxGridView1.DataColumns["OCTUBRE"].ReadOnly = true;
                ASPxGridView1.DataColumns["NOVIEMBRE"].ReadOnly = true;
                ASPxGridView1.DataColumns["DICIEMBRE"].ReadOnly = true;
            }
            else
            {
                if (PERIODO.Substring(4,2) =="02")
                    {
                    ASPxGridView1.DataColumns["ENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FENERO"].ReadOnly = true;
                }
                if (PERIODO.Substring(4, 2) == "03")
                    {
                    ASPxGridView1.DataColumns["ENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FFEBRERO"].ReadOnly = true;
                }
                if (PERIODO.Substring(4, 2) == "04")
                {
                    ASPxGridView1.DataColumns["ENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FFEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMARZO"].ReadOnly = true;
                }
                if (PERIODO.Substring(4, 2) == "05")
                {
                    ASPxGridView1.DataColumns["ENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FFEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["ABRIL"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FABRIL"].ReadOnly = true;

                }
                if (PERIODO.Substring(4, 2) == "06")
                {
                    ASPxGridView1.DataColumns["ENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FFEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["ABRIL"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FABRIL"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MAYO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMAYO"].ReadOnly = true;
                }


                if (PERIODO.Substring(4, 2) == "07")
                {
                    ASPxGridView1.DataColumns["ENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FFEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["ABRIL"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FABRIL"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MAYO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMAYO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["JUNIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FJUNIO"].ReadOnly = true;
                }
                if (PERIODO.Substring(4, 2) == "08")
                {
                    ASPxGridView1.DataColumns["ENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FFEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["ABRIL"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FABRIL"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MAYO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMAYO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["JUNIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FJUNIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["JULIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FJULIO"].ReadOnly = true;
                }
                if (PERIODO.Substring(4, 2) == "09")
                {
                    ASPxGridView1.DataColumns["ENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FFEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["ABRIL"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FABRIL"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MAYO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMAYO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["JUNIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FJUNIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["JULIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FJULIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["AGOSTO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FAGOSTO"].ReadOnly = true;

                }
                if (PERIODO.Substring(4, 2) == "10")
                {
                    ASPxGridView1.DataColumns["ENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FFEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["ABRIL"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FABRIL"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MAYO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMAYO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["JUNIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FJUNIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["JULIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FJULIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["AGOSTO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FAGOSTO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["SEPTIEMBRE"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FSEPTIEMBRE"].ReadOnly = true;
                }
                if (PERIODO.Substring(4, 2) == "11")
                {
                    ASPxGridView1.DataColumns["ENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FFEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["ABRIL"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FABRIL"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MAYO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMAYO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["JUNIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FJUNIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["JULIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FJULIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["AGOSTO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FAGOSTO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["SEPTIEMBRE"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FSEPTIEMBRE"].ReadOnly = true;
                    ASPxGridView1.DataColumns["OCTUBRE"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FOCTUBRE"].ReadOnly = true;
                }
                if (PERIODO.Substring(4, 2) == "12")
                {
                    ASPxGridView1.DataColumns["ENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FENERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FFEBRERO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMARZO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["ABRIL"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FABRIL"].ReadOnly = true;
                    ASPxGridView1.DataColumns["MAYO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FMAYO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["JUNIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FJUNIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["JULIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FJULIO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["AGOSTO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FAGOSTO"].ReadOnly = true;
                    ASPxGridView1.DataColumns["SEPTIEMBRE"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FSEPTIEMBRE"].ReadOnly = true;
                    ASPxGridView1.DataColumns["OCTUBRE"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FOCTUBRE"].ReadOnly = true;
                    ASPxGridView1.DataColumns["NOVIEMBRE"].ReadOnly = true;
                    ASPxGridView1.DataColumns["FNOVIEMBRE"].ReadOnly = true;
                }


            }
            if (ESTADO_FORECAST == "C")
            {
                ASPxGridView1.DataColumns["FENERO"].ReadOnly = true;
                ASPxGridView1.DataColumns["FFEBRERO"].ReadOnly = true;
                ASPxGridView1.DataColumns["FMARZO"].ReadOnly = true;
                ASPxGridView1.DataColumns["FABRIL"].ReadOnly = true;
                ASPxGridView1.DataColumns["FMAYO"].ReadOnly = true;
                ASPxGridView1.DataColumns["FJUNIO"].ReadOnly = true;
                ASPxGridView1.DataColumns["FJULIO"].ReadOnly = true;
                ASPxGridView1.DataColumns["FAGOSTO"].ReadOnly = true;
                ASPxGridView1.DataColumns["FSEPTIEMBRE"].ReadOnly = true;
                ASPxGridView1.DataColumns["FOCTUBRE"].ReadOnly = true;
                ASPxGridView1.DataColumns["FNOVIEMBRE"].ReadOnly = true;
                ASPxGridView1.DataColumns["FDICIEMBRE"].ReadOnly = true;
            }



        }


        private void EjecutarDuplicarAno(string PAREA, string PANO, out string PERIODO, out string ESTADO_PRESUPUESTO, out string ESTADO_FORECAST)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "ok";


            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.[Presupuesto].[PORTAL_PRESUPUESTO_COPY]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@AREA", PAREA);
                command.Parameters.AddWithValue("@ANO", PANO);
                command.Parameters.Add("@PERIODO", SqlDbType.Char, 6);
                command.Parameters["@PERIODO"].Direction = ParameterDirection.Output;
                command.Parameters.Add("@ESTADO_PRESUPUESTO", SqlDbType.Char, 1);
                command.Parameters["@ESTADO_PRESUPUESTO"].Direction = ParameterDirection.Output;
                command.Parameters.Add("@ESTADO_FORECAST", SqlDbType.Char, 1);
                command.Parameters["@ESTADO_FORECAST"].Direction = ParameterDirection.Output;

                conn.Open();
                command.ExecuteNonQuery();

                PERIODO = (string)command.Parameters["@PERIODO"].Value;
                ESTADO_PRESUPUESTO = (string)command.Parameters["@ESTADO_PRESUPUESTO"].Value;
                ESTADO_FORECAST = (string)command.Parameters["@ESTADO_FORECAST"].Value;

            }



        }



        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {

            var stream1 = new MemoryStream();
            var stream2 = new MemoryStream();

            grid_data_exp.WriteXlsx(stream1, new XlsxExportOptionsEx() { SheetName = "Presupuesto" });
            grid_data_expDetaII.WriteXlsx(stream2);

            stream1.Seek(0, SeekOrigin.Begin);
            stream2.Seek(0, SeekOrigin.Begin);

            Workbook workbook1 = new Workbook();
            Workbook workbook2 = new Workbook();

            workbook1.LoadDocument(stream1, DocumentFormat.Xlsx);
            workbook2.LoadDocument(stream2, DocumentFormat.Xlsx);

            //workbook1.Worksheets.Add(ASPxGridView1.ID);
            workbook1.Worksheets.Add("Restringido");
            workbook1.Worksheets["Restringido"].CopyFrom(workbook2.Worksheets[0]);

            var sourceMs = new MemoryStream();
            workbook1.SaveDocument(sourceMs, DocumentFormat.Xlsx);
            sourceMs.Seek(0, SeekOrigin.Begin);
            var report = sourceMs.ToArray();

            Response.Clear();
            Response.ContentType = "application/xlsx";
            Response.OutputStream.Write(report, 0, report.Length);
            Response.AddHeader("Content-Disposition", "attachment;filename=Presupuesto.xlsx");
            Response.End();



            ////grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });

            //// grid_data_expDetaII.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
            ////DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
            //PrintingSystemBase ps = new PrintingSystemBase();

            ////          ASPxGridView1.OptionsPrint.MergeRowFieldValues = false;

            //ASPxGridView1.SettingsBehavior.AllowCellMerge = false;
            ////ASPxGridView1.SettingsExport.
            //ASPxGridView2.SettingsBehavior.AllowCellMerge = false;


            ////XlsxExportOptions exportOptions = new XlsxExportOptions();
            

            //PrintableComponentLinkBase link1 = new PrintableComponentLinkBase(ps);
            //link1.Component = grid_data_exp;
  

            //PrintableComponentLinkBase link2 = new PrintableComponentLinkBase(ps);
            //link2.Component = grid_data_expDetaII;

            //CompositeLinkBase compositeLink = new CompositeLinkBase(ps);
            //compositeLink.Links.AddRange(new object[] { link1, link2 });
            
            //compositeLink.CreateDocument();
            //using (MemoryStream stream = new MemoryStream())
            //{
            //    compositeLink.ExportToXls(stream);
            //    WriteToResponse("Presupuesto", true, "xls", stream);
            //}
            //ps.Dispose();
        }
        void WriteToResponse(string fileName, bool saveAsFile, string fileFormat, MemoryStream stream)
        {
            if (Page == null || Page.Response == null)
                return;
            string disposition = saveAsFile ? "attachment" : "inline";
            Page.Response.Clear();
            Page.Response.Buffer = false;
            Page.Response.AppendHeader("Content-Type", string.Format("application/{0}", fileFormat));
            Page.Response.AppendHeader("Content-Transfer-Encoding", "binary");
            Page.Response.AppendHeader("Content-Disposition",
                string.Format("{0}; filename={1}.{2}", disposition, fileName, fileFormat));
            Page.Response.BinaryWrite(stream.GetBuffer());
            Page.Response.End();
        }




        protected void ASPxGridView1_CellEditorInitialize(object sender, ASPxGridViewEditorEventArgs e)
        {
            if (e.Column.FieldName == "CIA")
                e.Editor.ClientInstanceName = "CIAEditor";
            if (e.Column.FieldName == "CUENTA_CONTABLE")
            {
                var editor = e.Editor as ASPxComboBox;
                editor.ClientInstanceName = "CuentaEditor";
                editor.ClientSideEvents.EndCallback = "CuentaCombo_EndCallback";
            }
            if (e.Column.FieldName == "CENTRO_COSTO")
            {
                var editor = e.Editor as ASPxComboBox;
                editor.ClientInstanceName = "CentroEditor";
                editor.ClientSideEvents.EndCallback = "CentroCombo_EndCallback";
                //editor.AllowNull=true;
            }
        }

        protected void OnItemRequestedByValue(object source, ListEditItemRequestedByValueEventArgs e)
        {
            if (e.Value == null) return;
            ASPxComboBox comboBox = source as ASPxComboBox;
            SQLCuentaContable.SelectParameters.Clear();
            SQLCuentaContable.SelectParameters.Add("CUENTA_CONTABLE", TypeCode.String, e.Value.ToString());
            SQLCuentaContable.SelectCommand = @"SELECT [CUENTA_CONTABLE], [CUENTA_CONTABLE] + ' ' + [DESCRIPCION] DESCRIPCION
  FROM [PORTAL].[Presupuesto].[CUENTA_CONTABLE] WHERE (CUENTA_CONTABLE = @CUENTA_CONTABLE) ORDER BY 1";

            comboBox.DataSource = SQLCuentaContable;
            comboBox.DataBind();
        }

        protected void Centro_ItemRequestedByValue(object source, ListEditItemRequestedByValueEventArgs e)
        {
            if (e.Value == null) return;
            ASPxComboBox comboBox = source as ASPxComboBox;
            SQLCentroCosto.SelectParameters.Clear();
            SQLCentroCosto.SelectParameters.Add("CENTRO_COSTO", TypeCode.String, e.Value.ToString());
            SQLCentroCosto.SelectCommand = @"SELECT  CENTRO_COSTO, CENTRO_COSTO + ' ' + DESCRIPCION DESCRIPCION
  FROM [PORTAL].[Presupuesto].[CENTRO_COSTO] WHERE (CENTRO_COSTO = @CENTRO_COSTO) ORDER BY 1";

            comboBox.DataSource = SQLCentroCosto;
            comboBox.DataBind();
        }

        private string GetCurrentCIA()
        {
            object id = null;
            if (hf.TryGet("CurrentCIA", out id))
                return Convert.ToString(id);
            return "-1";
        }
        protected void OnItemsRequestedByFilterCondition(object source, ListEditItemsRequestedByFilterConditionEventArgs e)
        {
            ASPxComboBox comboBox = source as ASPxComboBox;
            string Vsql;
            string CIA = this.GetCurrentCIA();
            SQLCuentaContable.SelectParameters.Clear();
            SQLCuentaContable.SelectParameters.Add("filter", TypeCode.String, string.Format("%{0}%", e.Filter));
            SQLCuentaContable.SelectParameters.Add("startIndex", TypeCode.Int32, (e.BeginIndex + 1).ToString());
            SQLCuentaContable.SelectParameters.Add("endIndex", TypeCode.Int32, (e.EndIndex + 1).ToString());
            if (CIA != "-1")
            {
                Vsql = @"SELECT CUENTA_CONTABLE, CUENTA_CONTABLE + ' ' + DESCRIPCION DESCRIPCION FROM  (select CUENTA_CONTABLE, DESCRIPCION, row_number() over (order by CUENTA_CONTABLE) as [rn] from [PORTAL].[Presupuesto].[CUENTA_CONTABLE] as C 
           WHERE C.ERP IN (SELECT CC.ERP FROM PORTAL.[Presupuesto].[CIA] CC WHERE CC.ERP = C.ERP AND CC.CONJUNTO = @CIA and (CC.ERP <> 'SOF' OR CC.CONJUNTO IN (SELECT CCC.CIA FROM PORTAL.PRESUPUESTO.CIA_CUENTA CCC WHERE CCC.CUENTA = C.CUENTA_CONTABLE AND CCC.CIA = CC.CONJUNTO)) AND
            C.CUENTA_CONTABLE IN (SELECT A.CUENTA FROM PORTAL.[Presupuesto].[AREA_CUENTA] A WHERE A.CUENTA = C.CUENTA_CONTABLE AND A.AREA = " + Session["PAREA"].ToString() + ") "
            + "AND (c.DESCRIPCION LIKE @filter) )) as st where st.[rn] between @startIndex and @endIndex";

                SQLCuentaContable.SelectParameters.Add("CIA", TypeCode.String, CIA.ToString());
                SQLCuentaContable.SelectCommand =
        @"SELECT CUENTA_CONTABLE, CUENTA_CONTABLE + ' ' + DESCRIPCION DESCRIPCION FROM  (select CUENTA_CONTABLE, DESCRIPCION, row_number() over (order by CUENTA_CONTABLE) as [rn] from [PORTAL].[Presupuesto].[CUENTA_CONTABLE] as C 
           WHERE C.ERP IN (SELECT CC.ERP FROM PORTAL.[Presupuesto].[CIA] CC WHERE CC.ERP = C.ERP AND CC.CONJUNTO = @CIA and (CC.ERP <> 'SOF' OR CC.CONJUNTO IN (SELECT CCC.CIA FROM PORTAL.PRESUPUESTO.CIA_CUENTA CCC WHERE CCC.CUENTA = C.CUENTA_CONTABLE AND CCC.CIA = CC.CONJUNTO)) AND
            C.CUENTA_CONTABLE IN (SELECT A.CUENTA FROM PORTAL.[Presupuesto].[AREA_CUENTA] A WHERE A.CUENTA = C.CUENTA_CONTABLE AND A.AREA = " + Session["PAREA"].ToString() + ") " 
            + "AND (c.DESCRIPCION LIKE @filter) )) as st where st.[rn] between @startIndex and @endIndex";
            }
            else
            {
                Vsql = @"SELECT CUENTA_CONTABLE, CUENTA_CONTABLE +' ' + DESCRIPCION DESCRIPCION FROM (select CUENTA_CONTABLE, DESCRIPCION, row_number() over (order by CUENTA_CONTABLE) as [rn] from[PORTAL].[Presupuesto].[CUENTA_CONTABLE] as C
           WHERE C.ERP IN (SELECT CC.ERP FROM PORTAL.[Presupuesto].[CIA] CC WHERE CC.ERP = C.ERP  and (CC.ERP <> 'SOF' OR CC.CONJUNTO IN (SELECT CCC.CIA FROM PORTAL.PRESUPUESTO.CIA_CUENTA CCC WHERE CCC.CUENTA = C.CUENTA_CONTABLE AND CCC.CIA = CC.CONJUNTO))) AND
            C.CUENTA_CONTABLE IN (SELECT A.CUENTA FROM PORTAL.[Presupuesto].[AREA_CUENTA] A WHERE A.CUENTA = C.CUENTA_CONTABLE AND A.AREA = " + Session["PAREA"].ToString() + ") "
          + " AND(c.DESCRIPCION LIKE @filter) ) as st where st.[rn] between @startIndex and @endIndex";

                SQLCuentaContable.SelectCommand =
               @"SELECT CUENTA_CONTABLE, CUENTA_CONTABLE +' ' + DESCRIPCION DESCRIPCION FROM (select CUENTA_CONTABLE, DESCRIPCION, row_number() over (order by CUENTA_CONTABLE) as [rn] from[PORTAL].[Presupuesto].[CUENTA_CONTABLE] as C
           WHERE C.ERP IN (SELECT CC.ERP FROM PORTAL.[Presupuesto].[CIA] CC WHERE CC.ERP = C.ERP  and (CC.ERP <> 'SOF' OR CC.CONJUNTO IN (SELECT CCC.CIA FROM PORTAL.PRESUPUESTO.CIA_CUENTA CCC WHERE CCC.CUENTA = C.CUENTA_CONTABLE AND CCC.CIA = CC.CONJUNTO))) AND
            C.CUENTA_CONTABLE IN (SELECT A.CUENTA FROM PORTAL.[Presupuesto].[AREA_CUENTA] A WHERE A.CUENTA = C.CUENTA_CONTABLE AND A.AREA = " + Session["PAREA"].ToString() + ") "
          + " AND(c.DESCRIPCION LIKE @filter) ) as st where st.[rn] between @startIndex and @endIndex";

            }
            comboBox.DataSource = SQLCuentaContable;
            //SQLCuentaContable.DataBind();
            comboBox.DataBind();
        }
        protected void Centro_OnItemsRequestedByFilterCondition(object source, ListEditItemsRequestedByFilterConditionEventArgs e)
        {
            ASPxComboBox comboBox = source as ASPxComboBox;
            String CIA = this.GetCurrentCIA();
            SQLCentroCosto.SelectParameters.Clear();
            SQLCentroCosto.SelectParameters.Add("filter", TypeCode.String, string.Format("%{0}%", e.Filter));
            SQLCentroCosto.SelectParameters.Add("startIndex", TypeCode.Int32, (e.BeginIndex + 1).ToString());
            SQLCentroCosto.SelectParameters.Add("endIndex", TypeCode.Int32, (e.EndIndex + 1).ToString());
            if (CIA != "-1")
            {
                SQLCentroCosto.SelectParameters.Add("CIA", TypeCode.String, CIA.ToString());
                SQLCentroCosto.SelectCommand =
        @"SELECT CENTRO_COSTO, CENTRO_COSTO + ' ' + DESCRIPCION DESCRIPCION FROM (select CENTRO_COSTO, DESCRIPCION, row_number() over (order by CENTRO_COSTO) as [rn] from [PORTAL].[Presupuesto].[CENTRO_COSTO] as t where (T.DESCRIPCION LIKE @filter And [CIA] = @CIA) AND 
t.CENTRO_COSTO IN (SELECT A.CENTRO_COSTO FROM PORTAL.[Presupuesto].[AREA_CENTRO] A WHERE A.CENTRO_COSTO = t.CENTRO_COSTO AND A.AREA = " + Session["PAREA"].ToString() + ")) as st where st.[rn] between @startIndex and @endIndex";
            }
            else
            {
                SQLCentroCosto.SelectCommand =
               @"SELECT CENTRO_COSTO, CENTRO_COSTO + ' ' + DESCRIPCION DESCRIPCION FROM (select CENTRO_COSTO, DESCRIPCION, row_number() over (order by CENTRO_COSTO) as [rn] from [PORTAL].[Presupuesto].[CENTRO_COSTO] as t where (T.DESCRIPCION LIKE @filter ) AND 
t.CENTRO_COSTO IN (SELECT A.CENTRO_COSTO FROM PORTAL.[Presupuesto].[AREA_CENTRO] A WHERE A.CENTRO_COSTO = t.CENTRO_COSTO AND A.AREA = " + Session["PAREA"].ToString() + ")) as st where st.[rn] between @startIndex and @endIndex";
            }
            comboBox.DataSource = SQLCentroCosto;
            comboBox.DataBind();
        }

        protected void ASPxGridView1_CustomUnboundColumnData(object sender, ASPxGridViewColumnDataEventArgs e)
        {
            if (e.Column.FieldName == "Sum")
            {
                decimal VEnero = e.GetListSourceFieldValue("ENERO") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("ENERO")) : 0;
                decimal VFebrero = e.GetListSourceFieldValue("FEBRERO") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("FEBRERO")) : 0;
                decimal VMarzo = e.GetListSourceFieldValue("MARZO") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("MARZO")) : 0;
                decimal VAbril = e.GetListSourceFieldValue("ABRIL") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("ABRIL")) : 0 ;
                decimal VMayo = e.GetListSourceFieldValue("MAYO") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("MAYO")) : 0;
                decimal VJunio = e.GetListSourceFieldValue("JUNIO") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("JUNIO")) : 0;
                decimal VJulio = e.GetListSourceFieldValue("JULIO") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("JULIO")) : 0;
                decimal VAgosto = e.GetListSourceFieldValue("AGOSTO") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("AGOSTO")) : 0;
                decimal VSeptiembre = e.GetListSourceFieldValue("SEPTIEMBRE") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("SEPTIEMBRE")) : 0;
                decimal VOctubre = e.GetListSourceFieldValue("OCTUBRE") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("OCTUBRE")) : 0;
                decimal VNoviembre = e.GetListSourceFieldValue("NOVIEMBRE") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("NOVIEMBRE")) : 0;
                decimal VDiciembre = e.GetListSourceFieldValue("DICIEMBRE") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("DICIEMBRE")) : 0;


                e.Value = VEnero + VFebrero + VMarzo + VAbril + VMayo + VJunio + VJulio + VAgosto + VSeptiembre + VOctubre + VNoviembre + VDiciembre;
            }

            if (e.Column.FieldName == "SumAnt")
            {
                decimal VYAGEnero = e.GetListSourceFieldValue("YAGENERO") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("YAGENERO")) : 0;
                decimal VYAGFebrero = e.GetListSourceFieldValue("YAGFEBRERO") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("YAGFEBRERO")) : 0;
                decimal VYAGMarzo = e.GetListSourceFieldValue("YAGMARZO") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("YAGMARZO")) : 0;
                decimal VYAGAbril = e.GetListSourceFieldValue("YAGABRIL") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("YAGABRIL")) : 0;
                decimal VYAGMayo = e.GetListSourceFieldValue("YAGMAYO") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("YAGMAYO")) : 0;
                decimal VYAGJunio = e.GetListSourceFieldValue("YAGJUNIO") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("YAGJUNIO")) : 0;
                decimal VYAGJulio = e.GetListSourceFieldValue("YAGJULIO") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("YAGJULIO")) : 0;
                decimal VYAGAgosto = e.GetListSourceFieldValue("YAGAGOSTO") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("YAGAGOSTO")) : 0;
                decimal VYAGSeptiembre = e.GetListSourceFieldValue("YAGSEPTIEMBRE") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("YAGSEPTIEMBRE")) : 0;
                decimal VYAGOctubre = e.GetListSourceFieldValue("YAGOCTUBRE") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("YAGOCTUBRE")) : 0;
                decimal VYAGNoviembre = e.GetListSourceFieldValue("YAGNOVIEMBRE") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("YAGNOVIEMBRE")) : 0;
                decimal VYAGDiciembre = e.GetListSourceFieldValue("YAGDICIEMBRE") != System.DBNull.Value ? Convert.ToDecimal(e.GetListSourceFieldValue("YAGDICIEMBRE")) : 0;


                e.Value = VYAGEnero + VYAGFebrero + VYAGMarzo + VYAGAbril + VYAGMayo + VYAGJunio + VYAGJulio + VYAGAgosto + VYAGSeptiembre + VYAGOctubre + VYAGNoviembre + VYAGDiciembre;
            }


        }


    }
}
