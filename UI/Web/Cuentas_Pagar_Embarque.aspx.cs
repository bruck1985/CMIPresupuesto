using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using DevExpress.Export;

namespace UI.Web
{
    public partial class Cuentas_Pagar_Embarque : System.Web.UI.Page
    {
        private string CurrentCiactaID
        {

            get { return Session["CurrentCiactaID"] == null ? String.Empty : Session["CurrentCiactaID"].ToString(); }
            set { Session["CurrentCiactaID"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ci_sciaCPE"] == null)
            {
                Session["ci_sciaCPE"] = "ddd ffffff";
                Session["ci_sfec1"] = DateTime.Today.AddMonths(-1).ToString("dd/MM/yyyy");    //DateTime.Now.ToString("dd/MM/yyyy");
                Session["ci_sfec2"] = DateTime.Now.ToString("dd/MM/yyyy");

                ((Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Today.AddMonths(-1);
                ((Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Now;
                //((Lform.FindItemOrGroupByName("Cia") as LayoutItem).GetNestedControl() as ASPxComboBox).Value = "%";
                (Lform.FindItemOrGroupByName("Cia") as LayoutItem).Caption = HttpUtility.HtmlDecode("Compañía");
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



        protected void DetailGrid_Init(object sender, EventArgs e)
        {
            DetailsApply();
        }

        protected void DetailGrid_Init2(object sender, EventArgs e)
        {
            DetailsApply2();
        }

        protected void Popup_WindowCallback(object source, PopupWindowCallbackArgs e)
        {
            CurrentCiactaID = e.Parameter;
            DetailsApply();
        }

        protected void Popup_WindowCallback2(object source, PopupWindowCallbackArgs e)
        {
            CurrentCiactaID = e.Parameter;
            DetailsApply2();
        }

        private void DetailsApply2()
        {
            if (!String.IsNullOrEmpty(CurrentCiactaID))
            {

                String[] campos = CurrentCiactaID.Split(';');
                //SQL_Data_CTA_Detalle2.SelectParameters["PCia1"].DefaultValue = campos[2];
                //SQL_Data_CTA_Detalle2.SelectParameters["PCta"].DefaultValue = campos[3];

                //PivotDetalleCta1.DataBind();
            }
        }

        private void DetailsApply()
        {
            if (!String.IsNullOrEmpty(CurrentCiactaID))
            {
                
                String[] campos = CurrentCiactaID.Split(';');
                //SQL_Data_CTA_Detalle1.SelectParameters["PCia1"].DefaultValue = campos[0];
                //SQL_Data_CTA_Detalle1.SelectParameters["PCta"].DefaultValue = campos[1];
                
                //SQL_Data_CTA_Detalle1.SelectParameters["cia1"].DefaultValue = campos[1];
                //SQL_Data_CTA_Detalle1.SelectParameters["cia1"].DefaultValue = campos[1];

                //PivotDetalleCta1.DataBind();
            }
        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {

            LayoutItem itemFechaInicial = Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem;
            ASPxDateEdit CBFechaInicial = itemFechaInicial.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemFechaFinal = Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem;
            ASPxDateEdit CBFechaFinal = itemFechaFinal.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemCia = Lform.FindItemOrGroupByName("Cia") as LayoutItem;
            ASPxDropDownEdit CBCia = itemCia.GetNestedControl() as ASPxDropDownEdit;

            if (CBFechaInicial != null)
            {
                if (CBCia.Value != null)
                {
                    Session["ci_sciaCPE"] = CBCia.Value != null ? CBCia.Value.ToString() : "XXX;";
                }
                else
                {
                    Session["ci_sciaCPE"] = "XXX XXXXXXXXXX";
                }
                
                Session["ci_sfec1"] = CBFechaInicial.Value != null ? CBFechaInicial.Date.ToString("dd/MM/yyyy") : string.Empty;
                Session["ci_sfec2"] = CBFechaFinal.Value != null ? CBFechaFinal.Date.ToString("dd/MM/yyyy") : string.Empty;
            }
        }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
        }

        protected void ExportExcel1_Click(object sender, EventArgs e)
        {
            DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
            //PivotDetalleCta1.OptionsView.HideAllTotals();
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //ASPxPivotGridExp1.ExportToXlsx(stream);
            WriteToResponse("CuentaPagarEmbarque.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
            //PivotDetalleCta1.OptionsView.ShowAllTotals();
        }

        protected void ExportExcel2_Click(object sender, EventArgs e)
        {
            DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
            //PivotDetalleCta2.OptionsView.HideAllTotals();

            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //ASPxPivotGridExp2.ExportToXlsx(stream);
            WriteToResponse("CuentaPagarEmbarque.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
            //PivotDetalleCta2.OptionsView.ShowAllTotals();
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

    }
}
