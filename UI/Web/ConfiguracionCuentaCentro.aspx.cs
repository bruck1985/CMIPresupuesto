using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI.Web
{
    public partial class ConfiguracionCuentaCentro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void grid_data_CustomButtonCallback(object sender, DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            string keyValue = grid.GetRowValues(e.VisibleIndex, "ID").ToString();
            if (e.ButtonID.Equals("btnEditar"))
            {
                ASPxGridView.RedirectOnCallback(string.Format("EditarConfiguracion.aspx?id={0}", keyValue));
            }
        }
    }
}