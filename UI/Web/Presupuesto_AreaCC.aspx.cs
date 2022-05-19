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
    public partial class Presupuesto_AreaCC : System.Web.UI.Page
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
        }




        protected void detailGrid_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["PAREA"] = (sender as ASPxGridView).GetMasterRowKeyValue().ToString();
        }

        protected void Grid_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            // Database editing is not allowed in online examples
            Session["PAREA"] = (sender as ASPxGridView).GetMasterRowKeyValue().ToString();
            string vparea;
            vparea = (sender as ASPxGridView).GetMasterRowKeyValue().ToString();
            SQLArea_Cuenta.DeleteCommand = "DELETE portal.[Presupuesto].[AREA_CUENTA] WHERE AREA = " + vparea + " AND CUENTA = @CUENTA";
            SQLArea_Centro.DeleteParameters.Clear();
            SQLArea_Centro.DeleteParameters.Add("AREA", TypeCode.Int32, vparea);
            SQLArea_Centro.DeleteParameters.Add("CUENTA", TypeCode.String, string.Format("%{0}%", e.Keys));


        }

        protected void Grid_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            // Database editing is not allowed in online examples
            Session["PAREA"] = (sender as ASPxGridView).GetMasterRowKeyValue().ToString();
        }

        protected void Grid_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            // Database editing is not allowed in online examples
            e.Cancel = true;
        }


        protected void SdetailGrid_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["PAREA"] = (sender as ASPxGridView).GetMasterRowKeyValue().ToString();
        }

        protected void SGrid_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            // Database editing is not allowed in online examples
            string vparea;
            vparea = (sender as ASPxGridView).GetMasterRowKeyValue().ToString();


            SQLArea_Centro.DeleteCommand = "DELETE  portal.[Presupuesto].[AREA_CENTRO] WHERE AREA = " + vparea + " AND CENTRO_COSTO = @CENTRO_COSTO";
            SQLArea_Centro.DeleteParameters.Clear();
            SQLArea_Centro.DeleteParameters.Add("AREA", TypeCode.Int32, vparea);
            SQLArea_Centro.DeleteParameters.Add("CENTRO_COSTO", TypeCode.String, string.Format("%{0}%", e.Keys));

            Session["PAREA"] = (sender as ASPxGridView).GetMasterRowKeyValue().ToString();
        }

        protected void SGrid_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            // Database editing is not allowed in online examples
            Session["PAREA"] = (sender as ASPxGridView).GetMasterRowKeyValue().ToString();
        }

        protected void SGrid_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            // Database editing is not allowed in online examples
            e.Cancel = true;
        }



        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {

//            LayoutItem itemFechaInicial = Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem;
//            ASPxDateEdit CBFechaInicial = itemFechaInicial.GetNestedControl() as ASPxDateEdit;

//            LayoutItem itemFechaFinal = Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem;
//            ASPxDateEdit CBFechaFinal = itemFechaFinal.GetNestedControl() as ASPxDateEdit;

         
    
        
    }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            ASPxGridViewExporter1.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
            

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

        protected void Lform_E2_Click(object sender, EventArgs e)
        {

        }
    }
}
