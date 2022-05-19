using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using DevExpress.Export;

using DevExpress.Utils;
using System.Data;




namespace UI.Web
{
    public partial class PValor_PalancasValorMant : System.Web.UI.Page
    {

        //private string[] values = new string[] { "CodigoPais", "CodigoTecnologia", "CodigoSociedad" };
        
        public DataSet dsConfiguracionCampos = new DataSet();


        private void CargaConfiguracionCampos ()
        {

            try
            {
                DataView view = (DataView)SQLConfiguracionCampos.Select(DataSourceSelectArguments.Empty);
                DataTable table = view.ToTable();
                //DataSet dsConfiguracionCampos = new DataSet();
                dsConfiguracionCampos.Tables.Add(table);
            }

            catch
            {


            }




        }

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
            if (Session["lista_ci_scia1"] == null)
            {
                Session["ci_scia2"] = "%";
                Session["ci_sfec1"] = DateTime.Today.AddMonths(-1).ToString("dd/MM/yyyy");    //DateTime.Now.ToString("dd/MM/yyyy");
                Session["ci_sfec2"] = DateTime.Now.ToString("dd/MM/yyyy");
                SQLCompania.DataBind();

                ((Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Today.AddMonths(-1);
                ((Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Now;

                //(((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxDropDownEdit).FindControl("listBox") as ASPxListBox).SelectAll();   //.Value = " % ";
//                ((Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem).GetNestedControl() as ASPxGridLookup).Value = "";

                Session["lista_ci_scia1"] = "ddd ffffff";

            }

            //if (!IsPostBack)
            //{

            //}

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

            LayoutItem itemFechaFinal = Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem;
            ASPxDateEdit CBFechaFinal = itemFechaFinal.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            ASPxDropDownEdit CBCiaOri = itemCiaOri.GetNestedControl() as ASPxDropDownEdit;



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
   
            }
        
    }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            //grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });

            DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
            //GridPalancas.OptionsView.HideAllTotals();
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            GridPalancas.ExportToXlsx(stream);
            WriteToResponse("Palancas.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
            //GridPalancas.OptionsView.ShowAllTotals();

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

        protected void GridPalancas_Load(object sender, EventArgs e)
        {

            SQLConfiguracionCampos.DataBind();
            //CargaConfiguracionCampos();
            HideReader(GridPalancas);

            //CargaConfiguracionCampos();

            //foreach (DataRow row in dsConfiguracionCampos.Tables[0].Rows)
            //{
            //    string NombreCampo = Convert.ToString(row["NombreCampo"]);
            //    Boolean VisibleLectura = Convert.ToBoolean(row["VisibleLectura"]);
            //    Boolean VisibleEscritura = Convert.ToBoolean(row["VisibleEscritura"]);

            //    string NombreCampoInicial = Convert.ToString(row["NombreCampo"]);
            //    Boolean VisibleLecturaInicial = Convert.ToBoolean(row["VisibleLectura"]);
            //    //Boolean VisibleEscrituraInicial = Convert.ToBoolean(row["VisibleEscritura"]);

            //    if (VisibleLecturaInicial)
            //    {
            //        GridPalancas.DataColumns[NombreCampo].Visible = true;
            //    }
            //    else
            //    {
            //        GridPalancas.DataColumns[NombreCampo].Visible = false;
            //    }
            //}



        }
        protected void GridPalancas_BeforeGetCallbackResult(object sender, EventArgs e)
        {
            HideEditor(sender as ASPxGridView);
        }


        private void HideEditor(ASPxGridView GridPalancas)
        {
            if (GridPalancas.IsEditing && !GridPalancas.IsNewRowEditing)
            {
                //string value = GridPalancas.GetRowValues(GridPalancas.EditingRowVisibleIndex, "CategoryName").ToString();
                //GridPalancas.DataColumns["Description"].EditFormSettings.Visible = values.Contains(value) ? DefaultBoolean.False : DefaultBoolean.True;
                //GridPalancas.DataColumns["CodigoPais"].EditFormSettings.Visible = DefaultBoolean.False;
                //GridPalancas.DataColumns["CodigoTecnologia"].EditFormSettings.Visible = 0;
                //GridPalancas.DataColumns["CodigoTecnologia"].EditFormSettings.Visible = 1;

                //GridPalancas.DataColumns["CodigoSociedad"].EditFormSettings.Visible = DefaultBoolean.False;
                //CargaConfiguracionCampos();

                CargaConfiguracionCampos();

                foreach (DataRow row in dsConfiguracionCampos.Tables[0].Rows)
                {
                    string NombreCampo = Convert.ToString(row["NombreCampo"]);
                    Boolean VisibleLectura = Convert.ToBoolean(row["VisibleLectura"]);
                    Boolean VisibleEscritura = Convert.ToBoolean(row["VisibleEscritura"]);
                    //GridPalancas.DataColumns["CodigoPais"].EditFormSettings.Visible = DefaultBoolean.False;
                    if (VisibleEscritura) {
                        GridPalancas.DataColumns[NombreCampo].EditFormSettings.Visible = DefaultBoolean.True;
                    }
                    else
                    {
                        GridPalancas.DataColumns[NombreCampo].EditFormSettings.Visible = DefaultBoolean.False;
                    }

                    if (VisibleLectura)
                    {
                        GridPalancas.DataColumns[NombreCampo].Visible = true;
                    }
                    else
                    {
                        GridPalancas.DataColumns[NombreCampo].Visible = false;
                    }


                }




            }
        }

        private void HideReader(ASPxGridView GridPalancas)
        {
            CargaConfiguracionCampos();

            foreach (DataRow row in dsConfiguracionCampos.Tables[0].Rows)
            {
                string NombreCampo = Convert.ToString(row["NombreCampo"]);
                Boolean VisibleLectura = Convert.ToBoolean(row["VisibleLectura"]);

                if (VisibleLectura)
                {
                    GridPalancas.DataColumns[NombreCampo].Visible = true;
                }
                else
                {
                    GridPalancas.DataColumns[NombreCampo].Visible = false;
                }


            }

        }


    }
}
