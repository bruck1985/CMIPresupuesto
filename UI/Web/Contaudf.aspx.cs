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
    public partial class Contaudf : System.Web.UI.Page
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
            ASPxDropDownEdit CBCiaOri = itemCiaOri.GetNestedControl() as ASPxDropDownEdit;

            LayoutItem itemtiporeporte = Lform.FindItemOrGroupByName("tiporeporte") as LayoutItem;
            ASPxComboBox CBTipoRep = itemtiporeporte.GetNestedControl() as ASPxComboBox;

            string VtipoRep = CBTipoRep.Value as string;


            //            LayoutItem itemCentroCosto = Lform.FindItemOrGroupByName("centrocosto") as LayoutItem;
            //            ASPxDropDownEdit CBCentroCosto = itemCentroCosto.GetNestedControl() as ASPxDropDownEdit;



            //            LayoutItem itemtiporep = Lform.FindItemOrGroupByName("CB_Tipo_Reporte") as LayoutItem;
            //ASPxComboBox CBtiporep = itemtiporep.GetNestedControl() as ASPxComboBox;



            //ASPxDateEdit CBFechaInicial = GetNestedEditor(Lform, "FechaInicial");
            if (CBFechaInicial != null)
            {
                if (CBCiaOri.Value != null)
                {
                    Session["lista_ci_scia1"] = CBCiaOri.Value != null ? CBCiaOri.Value.ToString() : "XXX YYYYYYYY;";
//                    Session["lista_ci_centrocosto"] = CBCentroCosto.Value != null ? CBCentroCosto.Value.ToString() : "XXX-yyyy ZZZZZZZZZ;";

                }
                else
                {
                    Session["lista_ci_scia1"] = "XXX XXXXXXXXXX";
                }
                Session["ci_sfec1"] = CBFechaInicial.Value != null ? CBFechaInicial.Date.ToString("dd/MM/yyyy") : string.Empty;
                Session["ci_sfec2"] = CBFechaFinal.Value != null ? CBFechaFinal.Date.ToString("dd/MM/yyyy") : string.Empty;
                SQLConta2.DataBind();

                PivotCompra.OptionsView.HideAllTotals();

                if (VtipoRep == "0")
                {

                    /*var defaultIndexes = PivotCompra.Fields.Cast<PivotGridField>().Where(f => f.Area == DevExpress.XtraPivotGrid.PivotArea.RowArea).OrderBy(f => f.AreaIndex).Select(f => f.ID).ToArray();

/*                    PivotCompra.Fields.Remove(fieldMTDQtyPrev);
                    PivotCompra.Fields.Remove(fieldMTDQtyCur);
                    PivotCompra.Fields.Remove(fieldMTDAmtPrev);
                    PivotCompra.Fields.Remove(fieldMTDAmtCur);*/
                    /*  foreach (var field in PivotCompra.Fields.Cast<PivotGridField>().Where(f => f.Area == DevExpress.XtraPivotGrid.PivotArea.RowArea && !f.Visible))
                      {
                          field.Visible = true;
                      }
                      for (int i = 0; i < defaultIndexes.Length; i++)
                      {
                          var field = PivotCompra.Fields[defaultIndexes[i]];
                          if (field != null)
                              field.AreaIndex = i;
                      }*/

                    PivotCompra.BeginUpdate();

                    PivotCompra.Fields["fieldDescripcion"].Visible = false;

                    PivotCompra.Fields["fieldUENTITY"].Visible = false;

                    PivotCompra.Fields["fieldULEDGER"].Visible = false;

                    PivotCompra.Fields["fieldUEXPENSESTYPE"].Visible = false;

                    PivotCompra.Fields["fieldUGROUPOVERHEAD"].Visible = false;

                    PivotCompra.Fields["fieldUORDENEEFF"].Visible = false;

                    PivotCompra.Fields["fieldGRUPOORDENER"].Visible = false;

                    PivotCompra.Fields["fieldUINTERCONONINTECO"].Visible = false;

                    PivotCompra.Fields["fieldUCIAINTERCOM"].Visible = false;

                    PivotCompra.Fields["fieldUAGRUPEEFF"].Visible = false;

                    PivotCompra.Fields["fieldUAGRUPTIPO"].Visible = false;

                    PivotCompra.Fields["fieldUAGRUPNOMCTA"].Visible = false;

                    PivotCompra.Fields["fieldUCODCASHFLOW"].Visible = false;

                    PivotCompra.Fields["fieldCLASECUENTA"].Visible = false;

                    PivotCompra.Fields["fieldORDENER"].Visible = false;

                    PivotCompra.Fields["fieldUCTAINTERCOM"].Visible = false;

                    PivotCompra.Fields["fieldUMONEDATRANSACCION"].Visible = false;
                    

                    PivotCompra.Fields["fieldMAYORIZADO"].Area = DevExpress.XtraPivotGrid.PivotArea.FilterArea;
                    PivotCompra.Fields["fieldMAYORIZADO"].AreaIndex = 0;



                    PivotCompra.Fields["fieldCIA"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldCIA"].AreaIndex = 0;


                    PivotCompra.Fields["fieldFECHACONTABILIZACION"].Visible = true;
                    PivotCompra.Fields["fieldFECHACONTABILIZACION"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldFECHACONTABILIZACION"].AreaIndex = 1;


                    PivotCompra.Fields["fieldPERIODOCONTABLE"].Visible = true;
                    PivotCompra.Fields["fieldPERIODOCONTABLE"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldPERIODOCONTABLE"].AreaIndex = 2;


                    PivotCompra.Fields["fieldUTIPOVALOR"].Visible = true;
                    PivotCompra.Fields["fieldUTIPOVALOR"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUTIPOVALOR"].AreaIndex = 3;



                    PivotCompra.Fields["fieldUCMIMAPPING"].Visible = true;
                    PivotCompra.Fields["fieldUCMIMAPPING"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUCMIMAPPING"].AreaIndex = 4;


                    PivotCompra.Fields["fieldUPAIS"].Visible = true;
                    PivotCompra.Fields["fieldUPAIS"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUPAIS"].AreaIndex = 5;

                    PivotCompra.Fields["fieldUSOCIEDADGL"].Visible = true;
                    PivotCompra.Fields["fieldUSOCIEDADGL"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUSOCIEDADGL"].AreaIndex = 6;

                    PivotCompra.Fields["fieldUSOCASO"].Visible = true;
                    PivotCompra.Fields["fieldUSOCASO"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUSOCASO"].AreaIndex = 7;

                    PivotCompra.Fields["fieldUNDivision"].Visible = true;
                    PivotCompra.Fields["fieldUNDivision"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUNDivision"].AreaIndex = 8;

                    PivotCompra.Fields["fieldCANAL"].Visible = true;
                    PivotCompra.Fields["fieldCANAL"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldCANAL"].AreaIndex = 9;

                    PivotCompra.Fields["fieldSECTOR"].Visible = true;
                    PivotCompra.Fields["fieldSECTOR"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldSECTOR"].AreaIndex = 10;

                    PivotCompra.Fields["fieldPROVEEDOR"].Visible = true;
                    PivotCompra.Fields["fieldPROVEEDOR"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldPROVEEDOR"].AreaIndex = 11;

                    PivotCompra.Fields["fieldCLIENTE"].Visible = true;
                    PivotCompra.Fields["fieldCLIENTE"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldCLIENTE"].AreaIndex = 12;

                    PivotCompra.Fields["fieldINDICADOR"].Visible = true;
                    PivotCompra.Fields["fieldINDICADOR"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldINDICADOR"].AreaIndex = 13;


                    PivotCompra.Fields["fieldIMPORTE"].Visible = true;
                    PivotCompra.Fields["fieldIMPORTE"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldIMPORTE"].AreaIndex = 14;


                    PivotCompra.Fields["fieldUMONEDALOCAL"].Visible = true;
                    PivotCompra.Fields["fieldUMONEDALOCAL"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUMONEDALOCAL"].AreaIndex = 15;



                    PivotCompra.Fields["fieldUMONEDAGRUPO"].Visible = true;
                    PivotCompra.Fields["fieldUMONEDAGRUPO"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUMONEDAGRUPO"].AreaIndex = 16;

                    PivotCompra.Fields["fieldIMPORTETRANSACCION"].Visible = true;
                    PivotCompra.Fields["fieldIMPORTETRANSACCION"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldIMPORTETRANSACCION"].AreaIndex = 17;


                    PivotCompra.Fields["fieldCEBE"].Visible = true;
                    PivotCompra.Fields["fieldCEBE"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldCEBE"].AreaIndex = 18;

                    PivotCompra.Fields["fieldCECOSAP"].Visible = true;
                    PivotCompra.Fields["fieldCECOSAP"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldCECOSAP"].AreaIndex = 19;

                    PivotCompra.Fields["fieldCECOORIGEN"].Visible = true;
                    PivotCompra.Fields["fieldCECOORIGEN"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldCECOORIGEN"].AreaIndex = 20;


                    PivotCompra.Fields["fieldCUENTACONTABLE"].Visible = true;
                    PivotCompra.Fields["fieldCUENTACONTABLE"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldCUENTACONTABLE"].AreaIndex = 21;

                    PivotCompra.Fields["fieldTIPODOCUMENTO"].Visible = true;
                    PivotCompra.Fields["fieldTIPODOCUMENTO"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldTIPODOCUMENTO"].AreaIndex = 22;

                    PivotCompra.Fields["fieldAREAFUNCIONAL"].Visible = true;
                    PivotCompra.Fields["fieldAREAFUNCIONAL"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldAREAFUNCIONAL"].AreaIndex = 23;


                    PivotCompra.Fields["fieldUCARESEP"].Visible = false;






                    PivotCompra.EndUpdate();

                    PivotCompra.DataBind();
                    

                }

                if (VtipoRep == "1")
                {

                    /*var defaultIndexes = PivotCompra.Fields.Cast<PivotGridField>().Where(f => f.Area == DevExpress.XtraPivotGrid.PivotArea.RowArea).OrderBy(f => f.AreaIndex).Select(f => f.ID).ToArray();

/*                    PivotCompra.Fields.Remove(fieldMTDQtyPrev);
                    PivotCompra.Fields.Remove(fieldMTDQtyCur);
                    PivotCompra.Fields.Remove(fieldMTDAmtPrev);
                    PivotCompra.Fields.Remove(fieldMTDAmtCur);*/
                    /*  foreach (var field in PivotCompra.Fields.Cast<PivotGridField>().Where(f => f.Area == DevExpress.XtraPivotGrid.PivotArea.RowArea && !f.Visible))
                      {
                          field.Visible = true;
                      }
                      for (int i = 0; i < defaultIndexes.Length; i++)
                      {
                          var field = PivotCompra.Fields[defaultIndexes[i]];
                          if (field != null)
                              field.AreaIndex = i;
                      }*/

                    PivotCompra.BeginUpdate();



                    PivotCompra.Fields["fieldIMPORTE"].Area = DevExpress.XtraPivotGrid.PivotArea.DataArea;
                    PivotCompra.Fields["fieldIMPORTE"].AreaIndex = 0;


                    PivotCompra.Fields["fieldCIA"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldCIA"].AreaIndex = 0;


                    PivotCompra.Fields["fieldCLASECUENTA"].Visible = true;
                    PivotCompra.Fields["fieldCLASECUENTA"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldCLASECUENTA"].AreaIndex = 1;


                    PivotCompra.Fields["fieldORDENER"].Visible = true;
                    PivotCompra.Fields["fieldORDENER"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldORDENER"].AreaIndex = 2;


                    PivotCompra.Fields["fieldCUENTACONTABLE"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldCUENTACONTABLE"].AreaIndex = 3;


                    PivotCompra.Fields["fieldDescripcion"].Visible = true;
                    PivotCompra.Fields["fieldDescripcion"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldDescripcion"].AreaIndex = 4;


                    PivotCompra.Fields["fieldUCMIMAPPING"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUCMIMAPPING"].AreaIndex = 5;


                    PivotCompra.Fields["fieldUENTITY"].Visible = true;
                    PivotCompra.Fields["fieldUENTITY"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUENTITY"].AreaIndex = 6;


                    PivotCompra.Fields["fieldUSOCIEDADGL"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUSOCIEDADGL"].AreaIndex = 7;


                    PivotCompra.Fields["fieldULEDGER"].Visible = true;
                    PivotCompra.Fields["fieldULEDGER"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldULEDGER"].AreaIndex = 8;

                    PivotCompra.Fields["fieldUTIPOVALOR"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUTIPOVALOR"].AreaIndex = 9;

                    PivotCompra.Fields["fieldUPAIS"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUPAIS"].AreaIndex = 10;

                    PivotCompra.Fields["fieldUMONEDALOCAL"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUMONEDALOCAL"].AreaIndex = 11;

                    PivotCompra.Fields["fieldUMONEDAGRUPO"].Visible = true;
                    PivotCompra.Fields["fieldUMONEDAGRUPO"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUMONEDAGRUPO"].AreaIndex = 12;


                    PivotCompra.Fields["fieldUEXPENSESTYPE"].Visible = true;
                    PivotCompra.Fields["fieldUEXPENSESTYPE"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUEXPENSESTYPE"].AreaIndex = 13;

                    PivotCompra.Fields["fieldUGROUPOVERHEAD"].Visible = true;
                    PivotCompra.Fields["fieldUGROUPOVERHEAD"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUGROUPOVERHEAD"].AreaIndex = 14;


                    PivotCompra.Fields["fieldUORDENEEFF"].Visible = true;
                    PivotCompra.Fields["fieldUORDENEEFF"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUORDENEEFF"].AreaIndex = 15;


                    PivotCompra.Fields["fieldGRUPOORDENER"].Visible = true;
                    PivotCompra.Fields["fieldGRUPOORDENER"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldGRUPOORDENER"].AreaIndex = 16;

                    PivotCompra.Fields["fieldUINTERCONONINTECO"].Visible = true;
                    PivotCompra.Fields["fieldUINTERCONONINTECO"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUINTERCONONINTECO"].AreaIndex = 17;


                    PivotCompra.Fields["fieldUSOCASO"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUSOCASO"].AreaIndex = 18;


                    PivotCompra.Fields["fieldUCIAINTERCOM"].Visible = true;
                    PivotCompra.Fields["fieldUCIAINTERCOM"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUCIAINTERCOM"].AreaIndex = 19;

                    PivotCompra.Fields["fieldUCTAINTERCOM"].Visible = true;
                    PivotCompra.Fields["fieldUCTAINTERCOM"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUCTAINTERCOM"].AreaIndex = 20;


                    PivotCompra.Fields["fieldUAGRUPEEFF"].Visible = true;
                    PivotCompra.Fields["fieldUAGRUPEEFF"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUAGRUPEEFF"].AreaIndex = 21;

                    PivotCompra.Fields["fieldUAGRUPTIPO"].Visible = true;
                    PivotCompra.Fields["fieldUAGRUPTIPO"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUAGRUPTIPO"].AreaIndex = 22;

                    PivotCompra.Fields["fieldUAGRUPNOMCTA"].Visible = true;
                    PivotCompra.Fields["fieldUAGRUPNOMCTA"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUAGRUPNOMCTA"].AreaIndex = 23;

                    PivotCompra.Fields["fieldUCODCASHFLOW"].Visible = true;
                    PivotCompra.Fields["fieldUCODCASHFLOW"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUCODCASHFLOW"].AreaIndex = 24;

                    PivotCompra.Fields["fieldIMPORTETRANSACCION"].Area = DevExpress.XtraPivotGrid.PivotArea.DataArea;
                    PivotCompra.Fields["fieldIMPORTETRANSACCION"].AreaIndex = 1;



                    PivotCompra.Fields["fieldFECHACONTABILIZACION"].Visible = false;

                    PivotCompra.Fields["fieldPERIODOCONTABLE"].Visible = false;

                    

                    PivotCompra.Fields["fieldUNDivision"].Visible = false;

                    PivotCompra.Fields["fieldCANAL"].Visible = false;

                    PivotCompra.Fields["fieldSECTOR"].Visible = false;

                    PivotCompra.Fields["fieldPROVEEDOR"].Visible = false;

                    PivotCompra.Fields["fieldCLIENTE"].Visible = false;

                    PivotCompra.Fields["fieldINDICADOR"].Visible = false;


                    PivotCompra.Fields["fieldUMONEDATRANSACCION"].Visible = false;

                    PivotCompra.Fields["fieldCEBE"].Visible = false;

                    PivotCompra.Fields["fieldCECOSAP"].Visible = false;

                    PivotCompra.Fields["fieldCECOORIGEN"].Visible = false;



                    PivotCompra.Fields["fieldTIPODOCUMENTO"].Visible = false;

                    PivotCompra.Fields["fieldAREAFUNCIONAL"].Visible = false;

                    
                    PivotCompra.Fields["fieldUMONEDAGRUPO"].Visible = false;



                    PivotCompra.Fields["fieldUCARESEP"].Visible = true;
                    PivotCompra.Fields["fieldUCARESEP"].Area = DevExpress.XtraPivotGrid.PivotArea.RowArea;
                    PivotCompra.Fields["fieldUCARESEP"].AreaIndex = 25;






                    PivotCompra.Fields["fieldMAYORIZADO"].Area = DevExpress.XtraPivotGrid.PivotArea.FilterArea;
                    PivotCompra.Fields["fieldMAYORIZADO"].AreaIndex = 0;


                    PivotCompra.EndUpdate();


                    PivotCompra.DataBind();


                }


                //                Session["ci_stipo"] = CBtiporep.Value != null ? CBtiporep.Value.ToString() : string.Empty;


            }
            
    }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            //grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
            LayoutItem itemtiporeporte = Lform.FindItemOrGroupByName("tiporeporte") as LayoutItem;
            ASPxComboBox CBTipoRep = itemtiporeporte.GetNestedControl() as ASPxComboBox;

            string VtipoRep = CBTipoRep.Value as string;

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

            if (VtipoRep == "0")
            {
                WriteToResponse("CSVDocument.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
            }
            else
            { WriteToResponse("UDFDocument.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream); }
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
    }
}
