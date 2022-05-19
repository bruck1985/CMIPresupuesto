using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using DevExpress.Export;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace UI.Web
{
    public partial class VerAccionesActivos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params["empresa"] != null && Request.Params["activo"] != null )
            {


                Session["dCia"] = Request.Params["empresa"].ToString();
                Session["dActivo"] = Request.Params["activo"].ToString();
                Session["origen"] = Request.Params["origen"];
                SQLResultados.DataBind();

                //grid_data.DataBind();
            }
        }
        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
        }

        protected void btnExportarPdf_E3_ClickExc(object sender, EventArgs e)
        {
            grid_data_exp.WritePdfToResponse(new PdfExportOptions() { });
        }
    }
}
