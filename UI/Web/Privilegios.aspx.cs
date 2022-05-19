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

namespace UI.Web
{
    public partial class Privilegios : System.Web.UI.Page
    {
        bool bounded;
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

            string columnIndexValue = ColumnIndex.Value, rowIndexValue = RowIndex.Value;
            //if (!string.IsNullOrEmpty(columnIndexValue) && !string.IsNullOrEmpty(rowIndexValue) && ASPxPopupControl1.ShowOnPageLoad)
            //    BindGridView(columnIndexValue, rowIndexValue);
            PivotCompra.ClientSideEvents.CellClick = GetJSCellClickHandler();
       //     ASPxPopupControl1.ClientSideEvents.Closing = GetJSPopupClosingHandler();

            //if (ASPxGridView1.IsCallback && !string.IsNullOrEmpty(columnIndexValue) && !string.IsNullOrEmpty(rowIndexValue))
            //    ASPxGridView1.JSProperties.Add("cpShowDrillDownWindow", false);

            if (Session["lista_ci_scia1"] == null)
            {
                Session["ci_scia2"] = "%";
                Session["CIAS_OC_PRES"] = "XXXX YYYYYYYYY";
//                Session["nombreUsuario"] = "PortalRep";
                
                SQLCompania.DataBind();
                //SqlDataCentroCosto.DataBind();
                


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

            LayoutItem itemUsu = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
            ASPxComboBox CBUsuarios = itemUsu.GetNestedControl() as ASPxComboBox;

            LayoutItem itemMod = Lform.FindItemOrGroupByName("CBModulo") as LayoutItem;
            ASPxComboBox CBModulos = itemMod.GetNestedControl() as ASPxComboBox;



            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            ASPxDropDownEdit CBCiaOri = itemCiaOri.GetNestedControl() as ASPxDropDownEdit;




       //     LayoutItem itemtiporeporte = Lform.FindItemOrGroupByName("tiporeporte") as LayoutItem;
            //ASPxComboBox CBTipoRep = itemtiporeporte.GetNestedControl() as ASPxComboBox;

            //string VtipoRep = CBTipoRep.Value as string;


            //            LayoutItem itemCentroCosto = Lform.FindItemOrGroupByName("centrocosto") as LayoutItem;
            //            ASPxDropDownEdit CBCentroCosto = itemCentroCosto.GetNestedControl() as ASPxDropDownEdit;



            //            LayoutItem itemtiporep = Lform.FindItemOrGroupByName("CB_Tipo_Reporte") as LayoutItem;
            //ASPxComboBox CBtiporep = itemtiporep.GetNestedControl() as ASPxComboBox;



            //ASPxDateEdit CBFechaInicial = GetNestedEditor(Lform, "FechaInicial");
            if (CBUsuarios != null)
            {
                if (CBCiaOri.Value != null)
                {
                    Session["lista_ci_scia1"] = CBCiaOri.Value != null ? CBCiaOri.Value.ToString() : "XXX YYYYYYYY;";
                    Session["CBUsuario_priv"] = CBUsuarios.Value != null ? CBUsuarios.Value.ToString() : "XXX";
                    Session["CBModulo_priv"] = CBModulos.Value != null ? CBModulos.Value.ToString() : "-1"; 
                    //                    Session["lista_ci_centrocosto"] = CBCentroCosto.Value != null ? CBCentroCosto.Value.ToString() : "XXX-yyyy ZZZZZZZZZ;";

                }
                else
                {
                    Session["lista_ci_scia1"] = "XXX XXXXXXXXXX";
                }
                //                SQLConta2.DataBind();

                PivotCompra.OptionsView.HideAllTotals();

     


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
            WriteToResponse("PrivilegiosDocument.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
            PivotCompra.OptionsView.ShowAllTotals();
            PivotCompra.OptionsView.ShowFilterHeaders = true;
            PivotCompra.OptionsView.ShowDataHeaders = true;

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

        protected string GetJSCellClickHandler()
        {
            return string.Format(@"function (s, e) {{
            var columnIndex = document.getElementById('{0}'),
            rowIndex = document.getElementById('{1}');
            columnIndex.value = e.ColumnIndex;
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

        protected void Lform_E4_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
