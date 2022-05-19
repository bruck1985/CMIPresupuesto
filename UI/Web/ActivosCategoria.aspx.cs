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
    public partial class ActivosCategoria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["ci_sciaG"] == null)
                {
                    Session["ci_sciaG"] = "ddd ffffff";
                    (Lform.FindItemOrGroupByName("Cia") as LayoutItem).Caption = HttpUtility.HtmlDecode("Compañía");
                }
            }
        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {
            BuscarCategorias();
        }

        private void BuscarCategorias()
        {
            LayoutItem itemCia = Lform.FindItemOrGroupByName("Cia") as LayoutItem;
            ASPxDropDownEdit CBCia = itemCia.GetNestedControl() as ASPxDropDownEdit;
            Session["ci_sciaG"] = CBCia.Value != null ? CBCia.Value.ToString() : "XXX;";
        }
    }
}