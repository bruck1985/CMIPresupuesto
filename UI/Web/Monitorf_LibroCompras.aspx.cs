using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using DevExpress.Export;
using System.IO;
using System.IO.Compression;



namespace UI.Web
{
    public partial class Monitorf_LibroCompras : System.Web.UI.Page
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
			//         //grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });

			//         DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
			//         //PivotComprasTransacciones.OptionsView.HideAllTotals();
			//         System.IO.MemoryStream stream = new System.IO.MemoryStream();
			//         GridCompras.ExportToXlsx(stream);

			//GridExterior.ExportToXlsx(stream);
			//WriteToResponse("LibroCompras.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
			////System.IO.MemoryStream stream2 = new System.IO.MemoryStream();
			////GridExterior.ExportToXlsx(stream);
			////WriteToResponse2("LibroComprasExterior.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
			////System.IO.MemoryStream stream3 = new System.IO.MemoryStream();
			////GridTransito.ExportToXlsx(stream);
			////WriteToResponse3("LibroComprasTransito.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
			//////PivotComprasTransacciones.OptionsView.ShowAllTotals();
			///

			//grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });


			DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
			//PivotComprasTransacciones.OptionsView.HideAllTotals();
			System.IO.MemoryStream stream = new System.IO.MemoryStream();

			using (var memoryStream = new MemoryStream())
			{

				using (var archive = new ZipArchive(memoryStream, ZipArchiveMode.Create, true))
				{

					GridCompras.DataBind();

					

					var zipFile = archive.CreateEntry("LibroCompras" + ".xlsx");

					using (var entryStream = zipFile.Open())
					{
						GridExporterCompras.WriteXlsx(entryStream);
					}

					zipFile = archive.CreateEntry("LibroExterior" + ".xlsx");
					using (var entryStream = zipFile.Open())
					{
						GridExporterExterior.WriteXlsx(entryStream);
					}
				}
				memoryStream.Seek(0, SeekOrigin.Begin);
				Response.ContentType = "application/zip";
				Response.AddHeader("content-disposition", "attachment; filename=LibroCompras_Exterior.zip");
				Response.BufferOutput = true;
				Response.OutputStream.Write(memoryStream.ToArray(), 0, memoryStream.ToArray().Length);
				Response.End();


			}


			//GridCompras.ExportToXlsx(stream);

			//GridExterior.ExportToXlsx(stream);
			//WriteToResponse("LibroCompras.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
			//System.IO.MemoryStream stream2 = new System.IO.MemoryStream();
			//GridExterior.ExportToXlsx(stream);
			//WriteToResponse2("LibroComprasExterior.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
			//System.IO.MemoryStream stream3 = new System.IO.MemoryStream();
			//GridTransito.ExportToXlsx(stream);
			//WriteToResponse3("LibroComprasTransito.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
			////PivotComprasTransacciones.OptionsView.ShowAllTotals();
			///

		}

		//protected void ExportExcel1_Click(object sender, EventArgs e)
		//      {

		//          //ASPxPivotGridExp1.ExportToXlsx("DetalleCtaExp.xlsx");
		//          System.IO.MemoryStream stream = new System.IO.MemoryStream();
		//          //ASPxPivotGridExp1.ExportToXlsx(stream);
		//          //WriteToResponse("ReporteDetalleCta1.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);

		//  }

		//protected void ExportExcel2_Click(object sender, EventArgs e)
		//{
		//    System.IO.MemoryStream stream = new System.IO.MemoryStream();
		//    //ASPxPivotGridExp2.ExportToXlsx(stream);
		//    //WriteToResponse("ReporteDetalleCta1.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);

		//}

		//     protected void WriteToResponse(string fileName, bool saveAsFile, string fileFormat, System.IO.MemoryStream stream)
		//     {
		//         if (Page == null || Page.Response == null) return;
		//         string disposition = saveAsFile ? "attachment" : "inline";
		//Response.ClearHeaders();
		//Response.Clear();
		//Response.ClearContent();
		//Response.Buffer = false;
		//         Response.AppendHeader("Content-Type", string.Format("application/{0}", fileFormat));
		//         Response.AppendHeader("Content-Transfer-Encoding", "binary");
		//         Response.AppendHeader("Content-Disposition", string.Format("{0}; filename={1}", disposition, fileName));
		//         Response.BinaryWrite(stream.ToArray());
		//         HttpContext.Current.Response.Flush();
		//         HttpContext.Current.Response.SuppressContent = true;
		//         HttpContext.Current.ApplicationInstance.CompleteRequest();

		//     }



		protected void Lform_E2_Click(object sender, EventArgs e)
		{

		}
	}
}
