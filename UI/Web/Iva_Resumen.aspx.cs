using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI.Web
{
    public partial class Iva_Resumen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LY_IVA.DataBind();
        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {
            SDS_RESUMEN_IVA.DataBind();
            LY_IVA.DataBind();
        }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {

        }

        protected void ASPxButtonCompras2_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Web/Reporte_IVA.aspx");
        }
    }
}