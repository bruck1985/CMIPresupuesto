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
    public partial class InventarioArticulo : System.Web.UI.Page
    {
        private string CurrentCiactaID
        {
            get { return Session["CurrentCiactaID"] == null ? String.Empty : Session["CurrentCiactaID"].ToString(); }
            set
            {
                Session["CurrentCiactaID"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ci_sciaIA"] == null)
            {
                Session["ci_sciaIA"] = "ddd ffffff";
                Session["ci_tipo"] = "%";
                Session["ci_estado"] = "%";

                ((Lform.FindItemOrGroupByName("Tipo") as LayoutItem).GetNestedControl() as ASPxComboBox).Value = "%";
                ((Lform.FindItemOrGroupByName("Estado") as LayoutItem).GetNestedControl() as ASPxComboBox).Value = "%";
                (Lform.FindItemOrGroupByName("Cia") as LayoutItem).Caption = HttpUtility.HtmlDecode("Compañía");
            }
        }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {
            BuscarInventarioArticulo();
        }

        private void BuscarInventarioArticulo()
        {
            LayoutItem itemCia = Lform.FindItemOrGroupByName("Cia") as LayoutItem;
            ASPxDropDownEdit CBCia = itemCia.GetNestedControl() as ASPxDropDownEdit;

            LayoutItem itemTipo = Lform.FindItemOrGroupByName("Tipo") as LayoutItem;
            ASPxComboBox CBTipo = itemTipo.GetNestedControl() as ASPxComboBox;

            LayoutItem itemEstado = Lform.FindItemOrGroupByName("Estado") as LayoutItem;
            ASPxComboBox CBEstado = itemEstado.GetNestedControl() as ASPxComboBox;

            if (CBCia != null)
            {
                //Session["ci_scia"] = CBCia.Value != null ? CBCia.Value.ToString() : string.Empty;
                if (CBCia.Value != null)
                {
                    Session["ci_sciaIA"] = CBCia.Value != null ? CBCia.Value.ToString() : "XXX;";
                }
                else
                {
                    Session["ci_sciaIA"] = "XXX XXXXXXXXXX";
                }
                Session["ci_tipo"] = CBTipo.Value != null ? CBTipo.Value.ToString() : string.Empty;
                Session["ci_estado"] = CBEstado.Value != null ? CBEstado.Value.ToString() : string.Empty;
            }
        }
    }
}
