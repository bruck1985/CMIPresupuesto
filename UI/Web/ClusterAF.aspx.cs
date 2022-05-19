using BusinessLogic.Clases;
using DevExpress.Export.Xl;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utilitarios.Clases;

namespace UI.Web
{
    public partial class ClusterAF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void grid_data_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            string keyValue = grid.GetRowValues(e.VisibleIndex, "CLUSTER_ID").ToString();
            if (e.ButtonID.Equals("btnEditar"))
            {
                ASPxGridView.RedirectOnCallback(string.Format("EditarCluster.aspx?id={0}", keyValue));
            }
        }
    }
}