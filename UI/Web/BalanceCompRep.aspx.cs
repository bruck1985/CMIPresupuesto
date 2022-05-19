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
using DevExpress.XtraReports.UI;
using DevExpress.XtraReports.Parameters;

namespace UI.Web
{
    public partial class BalanceCompRep : System.Web.UI.Page
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






        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {

            LayoutItem itemFechaInicial = Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem;
            ASPxDateEdit CBFechaInicial = itemFechaInicial.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemFechaFinal = Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem;
            ASPxDateEdit CBFechaFinal = itemFechaFinal.GetNestedControl() as ASPxDateEdit;

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


                XtraReport rpt = new dxKB2796.XtraReport1
                {
                    RequestParameters = false

            };

            rpt.Parameters.GetByName("pcia").Value = Session["bclista_ci_scia"].ToString();
            rpt.Parameters.GetByName("pfecha1").Value = Session["ci_sfec1"].ToString();
            rpt.Parameters.GetByName("pfecha2").Value = Session["ci_sfec2"].ToString();
            rpt.Parameters.GetByName("pcompara").Value = "Y";
            rpt.Parameters.GetByName("pasiento_cierre").Value = "S";
            rpt.Parameters.GetByName("pidioma").Value = "I";
            rpt.Parameters.GetByName("pmoneda").Value = "U";
            rpt.Parameters.GetByName("ptiporeporte").Value = "D";

                //rpt.Parameters("Parameter1").Value = "0001";
                //ASPxWebDocumentViewer1.;
            ASPxWebDocumentViewer1.OpenReport(rpt);

                //SQLConta2.DataBind();




                //PivotCompra.OptionsView.ShowRowGrandTotals;




                //  PivotCompra.DataBind();




                //                Session["ci_stipo"] = CBtiporep.Value != null ? CBtiporep.Value.ToString() : string.Empty;


            }

    }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            //grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });

            DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
        }



        
    }
}
