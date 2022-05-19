using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using DevExpress.Export;
using DevExpress.Web.ASPxPivotGrid;
using DevExpress.XtraPivotGrid;

using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.IO;
using System.Data.SqlClient;

namespace UI.Web
{
    public partial class VarTipoCambio : System.Web.UI.Page
    {
        bool bounded;
        private string CurrentCiactaID
        {

            get { return Session["CurrentCiactaID"] == null ? String.Empty : Session["CurrentCiactaID"].ToString(); }
            set { Session["CurrentCiactaID"] = value;
                String[] campos = value.Split(';');
  //              Session["CI_Det_Cia1"] = campos[0];
  //              Session["CI_Det_Cta1"] = campos[1];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            string columnIndexValue = ColumnIndex.Value, rowIndexValue = RowIndex.Value;
            if (!string.IsNullOrEmpty(columnIndexValue) && !string.IsNullOrEmpty(rowIndexValue) && ASPxPopupControl1.ShowOnPageLoad)
                BindGridView(columnIndexValue, rowIndexValue);
            PivotCompra.ClientSideEvents.CellClick = GetJSCellClickHandler();
            ASPxPopupControl1.ClientSideEvents.Closing = GetJSPopupClosingHandler();

            if (ASPxGridView1.IsCallback && !string.IsNullOrEmpty(columnIndexValue) && !string.IsNullOrEmpty(rowIndexValue))
                ASPxGridView1.JSProperties.Add("cpShowDrillDownWindow", false);


            if (ASPxGridView2.IsCallback && !string.IsNullOrEmpty(columnIndexValue) && !string.IsNullOrEmpty(rowIndexValue))
                ASPxGridView2.JSProperties.Add("cpShowDrillDownAsiento", false);

            if (Session["lista_ci_scia1"] == null)
            {
                Session["ci_scia2"] = "%";
                Session["CIAS_OC_PRES"] = "XXXX YYYYYYYYY";
                Session["ci_sfec1"] = DateTime.Today.AddMonths(-1).ToString("dd/MM/yyyy");    //DateTime.Now.ToString("dd/MM/yyyy");
                Session["ci_sfec2"] = DateTime.Now.ToString("dd/MM/yyyy");
                Session["ci_stipo"] = "A";
                Session["nombreUsuario"] = "PortalRep";
                
                SQLCompania.DataBind();
                //SqlDataCentroCosto.DataBind();
                

                ((Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Today.AddMonths(-1);
                ((Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Now;

                //(((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxDropDownEdit).FindControl("listBox") as ASPxListBox).SelectAll();   //.Value = " % ";
//                ((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxGridLookup).Value = "";

//                ((Lform.FindItemOrGroupByName("CB_Tipo_Reporte") as LayoutItem).GetNestedControl() as ASPxComboBox).Value = "A";


                Session["lista_ci_scia1"] = "ddd ffffff";


            }
        }
  //      protected void Cmbcentrocosto_Callback(object source, CallbackEventArgsBase e)
  //      {
      
  //          if (string.IsNullOrEmpty(e.Parameter)) return;
  //            SqlDataCentroCosto.SelectParameters["PCia1"].DefaultValue = e.Parameter.ToString();
  //          Session["CIAS_OC_PRES"] = e.Parameter.ToString();
  //          SqlDataCentroCosto.DataBind();
  //          (((Lform.FindItemOrGroupByName("centrocosto") as LayoutItem).GetNestedControl() as ASPxDropDownEdit).FindControl("listBoxcc") as ASPxListBox).DataBind();

            
  //          //            AccessDataSourceCities.SelectParameters[0].DefaultValue = country;
  ////            CmbCity.DataBind();
  //      }





        protected void BindGridView(string columnIndex, string rowIndex)
        {
            String VCodCentroCosto;
            String VCuentaContable;
            String VCia;
            String VPeriodo;
            String VSQL;
            VSQL = "";
            if (bounded) return;
            bounded = true;
            Int32 VColumIndex;
            Int32 VRowIndex;
            VColumIndex = Int32.Parse(columnIndex);
            VRowIndex = Int32.Parse(rowIndex);
            //List<string> Listado = new List<string>();

            PivotDrillDownDataSource ds = PivotCompra.CreateDrillDownDataSource(Int32.Parse(columnIndex), Int32.Parse(rowIndex));
            PropertyDescriptorCollection props = ((ITypedList)ds).GetItemProperties(null);

            DataTable table = new DataTable("drilldown");
            DataTable tableAsientos = new DataTable("Asientos");

            for (int i = 0; i < props.Count; i++)
            {
                table.Columns.Add(props[i].Name, props[i].PropertyType);
            }
            object[] row = new object[props.Count];
            for (int i = 0; i < ds.RowCount; i++)
            {
                for (int j = 0; j < props.Count; j++)
                {
                    row[j] = ds.GetValue(i, j);
                }
                VCia = row[0].ToString();
                VCodCentroCosto = row[17].ToString();
                VCuentaContable = row[18].ToString();
                VPeriodo = row[1].ToString();
                if (i == 0)
                {
                    VSQL = "Select '" + VCia + "' CIA, M.FECHA, M.ASIENTO, M.CONSECUTIVO, NIT, CENTRO_COSTO, M.CUENTA_CONTABLE, C.DESCRIPCION, M.TIPO_ASIENTO, M.FUENTE, M.REFERENCIA, M.ORIGEN, M.DEBITO_LOCAL, M.CREDITO_LOCAL, M.DEBITO_DOLAR, M.CREDITO_DOLAR, M.CONTABILIDAD, '" + VCia + ";' + M.ASIENTO ASIENTOKEY From me." + VCia + ".mayor M, me." + VCia + ".CUENTA_CONTABLE C Where M.centro_costo = '" + VCodCentroCosto + "' and M.Cuenta_Contable = '" + VCuentaContable + "' AND CONVERT(CHAR(6),M.FECHA, 112) = '" + VPeriodo + "' AND M.CONTABILIDAD IN('A','F') AND M.CUENTA_CONTABLE = C.CUENTA_CONTABLE";
                }
                else
                {
                    VSQL = VSQL + " UNION ALL Select '" + VCia + "' CIA, M.FECHA, M.ASIENTO, M.CONSECUTIVO, NIT, CENTRO_COSTO, M.CUENTA_CONTABLE, C.DESCRIPCION, M.TIPO_ASIENTO, M.FUENTE, M.REFERENCIA, M.ORIGEN, M.DEBITO_LOCAL, M.CREDITO_LOCAL, M.DEBITO_DOLAR, M.CREDITO_DOLAR, M.CONTABILIDAD, '" + VCia + ";' + M.ASIENTO ASIENTOKEY From me." + VCia + ".mayor M, me." + VCia + ".CUENTA_CONTABLE C Where M.centro_costo = '" + VCodCentroCosto + "' and M.Cuenta_Contable = '" + VCuentaContable + "' AND CONVERT(CHAR(6),M.FECHA, 112) = '" + VPeriodo + "' AND M.CONTABILIDAD IN('A','F') AND M.CUENTA_CONTABLE = C.CUENTA_CONTABLE";
                }

                table.Rows.Add(row);
            }
            //  using (StringWriter writer = new StringWriter())
            //  {
            //      table.WriteXml(writer, XmlWriteMode.WriteSchema);
            //Session["drilldown"] = writer.ToString();
            //}


            string TCConnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString; //"Data Source=Source2;Initial Catalog=Core;Persist Security Info=True";
            SqlConnection TCcon = new SqlConnection(TCConnectionString);

            SqlDataAdapter da = new SqlDataAdapter(VSQL, TCcon);
            DataSet dss = new DataSet();
            TCcon.Open();
            da.Fill(dss);
            TCcon.Close();

            //PivotCompra.CreateDrillDownDataSource(Int32.Parse(columnIndex), Int32.Parse(rowIndex), Listado);
            ASPxGridView1.DataSource = dss;
            ASPxGridView1.DataBind();

        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {

            LayoutItem itemFechaInicial = Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem;
            ASPxDateEdit CBFechaInicial = itemFechaInicial.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemFechaFinal = Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem;
            ASPxDateEdit CBFechaFinal = itemFechaFinal.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            ASPxComboBox CBCiaOri = itemCiaOri.GetNestedControl() as ASPxComboBox;

            LayoutItem itemTipoCambio1 = Lform.FindItemOrGroupByName("tipocambio1") as LayoutItem;
            ASPxComboBox CBtipocambio1 = itemTipoCambio1.GetNestedControl() as ASPxComboBox;

            LayoutItem itemTipoCambio2 = Lform.FindItemOrGroupByName("tipocambio2") as LayoutItem;
            ASPxComboBox CBtipocambio2 = itemTipoCambio2.GetNestedControl() as ASPxComboBox;



            //     LayoutItem itemtiporeporte = Lform.FindItemOrGroupByName("tiporeporte") as LayoutItem;
            //ASPxComboBox CBTipoRep = itemtiporeporte.GetNestedControl() as ASPxComboBox;

            //string VtipoRep = CBTipoRep.Value as string;


            //            LayoutItem itemCentroCosto = Lform.FindItemOrGroupByName("centrocosto") as LayoutItem;
            //            ASPxDropDownEdit CBCentroCosto = itemCentroCosto.GetNestedControl() as ASPxDropDownEdit;



            //            LayoutItem itemtiporep = Lform.FindItemOrGroupByName("CB_Tipo_Reporte") as LayoutItem;
            //ASPxComboBox CBtiporep = itemtiporep.GetNestedControl() as ASPxComboBox;



            //ASPxDateEdit CBFechaInicial = GetNestedEditor(Lform, "FechaInicial");
            if (CBFechaInicial != null)
            {
                if (CBCiaOri.Value != null)
                {
                    Session["bclista_ci_scia"] = CBCiaOri.Value != null ? CBCiaOri.Value.ToString() : "XXX YYYYYYYY;";
//                    Session["lista_ci_centrocosto"] = CBCentroCosto.Value != null ? CBCentroCosto.Value.ToString() : "XXX-yyyy ZZZZZZZZZ;";

                }
                else
                {
                    Session["bclista_ci_scia"] = "XXX XXXXXXXXXX";
                }
                Session["ci_sfec1"] = CBFechaInicial.Value != null ? CBFechaInicial.Date.ToString("dd/MM/yyyy") : string.Empty;
                Session["ci_sfec2"] = CBFechaFinal.Value != null ? CBFechaFinal.Date.ToString("dd/MM/yyyy") : string.Empty;

                Session["ptipo_cambio1"] = CBtipocambio1.Value != null ? CBtipocambio1.Value.ToString() : string.Empty;
                Session["ptipo_cambio2"] = CBtipocambio2.Value != null ? CBtipocambio2.Value.ToString() : string.Empty;


                SQLConta2.DataBind();




                //PivotCompra.OptionsView.ShowRowGrandTotals;

     


                    PivotCompra.DataBind();




                //                Session["ci_stipo"] = CBtiporep.Value != null ? CBtiporep.Value.ToString() : string.Empty;


            }
            
    }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            //grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });

            DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
            PivotCompra.OptionsView.HideAllTotals();
            PivotCompra.OptionsView.ShowFilterHeaders = false;
            PivotCompra.OptionsView.ShowDataHeaders = false;
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            ASPxPivExp1.OptionsPrint.MergeColumnFieldValues = false;
            ASPxPivExp1.OptionsPrint.MergeRowFieldValues = false;
            ASPxPivExp1.OptionsPrint.PrintFilterHeaders = DevExpress.Utils.DefaultBoolean.False;
            ASPxPivExp1.OptionsPrint.PrintUnusedFilterFields = false;
                        ASPxPivExp1.ExportToXlsx(stream);
            WriteToResponse("VarTipoCambio.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
            PivotCompra.OptionsView.ShowAllTotals();
            PivotCompra.OptionsView.ShowFilterHeaders = true;
            PivotCompra.OptionsView.ShowDataHeaders = true;

        }

        protected void ExportExcel1_Click(object sender, EventArgs e)
        {

            //ASPxPivotGridExp1.ExportToXlsx("DetalleCtaExp.xlsx");
            // System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //ASPxPivotGridExp1.ExportToXlsx(stream);
            //WriteToResponse("ReporteDetalleCta1.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
            ASPxGridViewDetalle.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
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

        protected string GetJSCellClickHandler()
        {
            return string.Format(@"function (s, e) {{
            var columnIndex = document.getElementById('{0}'),
            rowIndex = document.getElementById('{1}');
            columnIndex.value = e.ColumnIndex
            rowIndex.value = e.RowIndex;
            GridView.PerformCallback('D');
            ShowDrillDown();
        }}", ColumnIndex.ClientID, RowIndex.ClientID);
        }
        protected string GetJSPopupClosingHandler()
        {
            return string.Format(@"function (s, e) {{
            var columnIndex = document.getElementById('{0}'),
            rowIndex = document.getElementById('{1}');
            columnIndex.value = '';
            rowIndex.value = '';
            GridView.SetVisible(false);
        }}", ColumnIndex.ClientID, RowIndex.ClientID);
        }

        protected void SQLCompras_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }


        protected void ASPxGridView1_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            string[] param = e.Parameters.Split('|');
            if (param[0] != "D") return;
            BindGridView(ColumnIndex.Value, RowIndex.Value);
            ASPxGridView1.PageIndex = 0;

            if (e.Parameters == "D")
                ASPxGridView1.JSProperties["cpShowDrillDownWindow"] = true;
        }

        protected void ASPxGridAsiento_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            string[] param = e.Parameters.Split('|');
            if (param[0] != "D") return;
            BindGridView2(ColumnIndex.Value, RowIndex.Value);
            ASPxGridView2.PageIndex = 0;

            if (e.Parameters == "D")
                ASPxGridView2.JSProperties["cpShowDrillDownWindow"] = true;
        }

        protected void BindGridView2(string columnIndex, string rowIndex)
        {

            //  ASPxGridView1.DataSource = dss;
            ASPxGridView2.DataBind();

        }

        protected void DetailsButton_Load(object sender, EventArgs e)
        {
            ASPxHyperLink btn = sender as ASPxHyperLink;
            GridViewDataItemTemplateContainer container = btn.NamingContainer as GridViewDataItemTemplateContainer;
            string cadenaCiaCtaID = DataBinder.Eval(container.DataItem, "CIA").ToString() + ";" + DataBinder.Eval(container.DataItem, "ASIENTO").ToString();
            btn.ClientSideEvents.Click = String.Format("function (s, e) {{ DrillDownAsiento.PerformCallback('{0}'); DrillDownAsiento.Show(); }}", cadenaCiaCtaID);

        }

        protected void hyperLink_Init(object sender, EventArgs e)
        {
            ASPxHyperLink link = (ASPxHyperLink)sender;

            GridViewDataItemTemplateContainer templateContainer = (GridViewDataItemTemplateContainer)link.NamingContainer;

            int rowVisibleIndex = templateContainer.VisibleIndex;

            string PCIA = templateContainer.Grid.GetRowValues(rowVisibleIndex, "CIA").ToString();
            string PASIENTO = templateContainer.Grid.GetRowValues(rowVisibleIndex, "ASIENTO").ToString();
            string cadenaCiaCtaID = PCIA + ";" + PASIENTO;


            //    link.NavigateUrl = "javascript:void(0);";
            //    link.Text = string.Format("More Info: EAN13 - {0}", ean13);
            link.ClientSideEvents.Click = String.Format("function (s, e) {{ DrillDownAsiento.PerformCallback('{0}'); DrillDownAsiento.Show(); }}", cadenaCiaCtaID);
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
                SQLAsiento.SelectParameters["PCia1"].DefaultValue = campos[0];
                SQLAsiento.SelectParameters["PAsiento"].DefaultValue = campos[1];
                //SQL_Data_CTA_Detalle1.SelectParameters["cia1"].DefaultValue = campos[1];
                //SQL_Data_CTA_Detalle1.SelectParameters["cia1"].DefaultValue = campos[1];

                ASPxGridView2.DataBind();
                
            }
        }

        protected void ExportExcel3_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(CurrentCiactaID))
            {

                String[] campos = CurrentCiactaID.Split(';');
                SQLAsiento.SelectParameters["PCia1"].DefaultValue = campos[0];
                SQLAsiento.SelectParameters["PAsiento"].DefaultValue = campos[1];
                //SQL_Data_CTA_Detalle1.SelectParameters["cia1"].DefaultValue = campos[1];
                //SQL_Data_CTA_Detalle1.SelectParameters["cia1"].DefaultValue = campos[1];

                ASPxGridView2.DataBind();

            }
            ASPxGridViewExporter1.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
        }

        protected void Lform_E1_Callback(object sender, CallbackEventArgsBase e)
        {
            string PCia = e.Parameter;
            Session["PCia1"] = PCia != null ? PCia : "XXX";
            SQLTipoCambio1.SelectParameters["PCia1"].DefaultValue = PCia;
            SQLTipoCambio1.DataBind();
            LayoutItem itemTipoCambio1 = Lform.FindItemOrGroupByName("tipocambio1") as LayoutItem;
            ASPxComboBox CBtipocambio1 = itemTipoCambio1.GetNestedControl() as ASPxComboBox;
            CBtipocambio1.DataBind();




        }

        protected void Lform_E4_Callback(object sender, CallbackEventArgsBase e)
        {
            string PCia = e.Parameter;
            Session["PCia1"] = PCia != null ? PCia : "XXX";
            SQLTipoCambio2.SelectParameters["PCia1"].DefaultValue = PCia;
            SQLTipoCambio2.DataBind();
            LayoutItem itemTipoCambio2 = Lform.FindItemOrGroupByName("tipocambio2") as LayoutItem;
            ASPxComboBox CBtipocambio2 = itemTipoCambio2.GetNestedControl() as ASPxComboBox;
            CBtipocambio2.DataBind();

        }
    }
}
