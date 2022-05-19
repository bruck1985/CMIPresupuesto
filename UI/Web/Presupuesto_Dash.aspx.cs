using DevExpress.DashboardCommon;
using DevExpress.DashboardWeb;
using DevExpress.DataAccess.Web;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI.Web
{
    public partial class Presupuesto_Dash : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region #DashboardStorage
            //DashboardFileStorage dashboardFileStorage = new DashboardFileStorage("~/App_Data/Dashboards");
            //ASPxDashboard1.SetDashboardStorage(dashboardFileStorage);
            #endregion #DashboardStorage

            string VconnectionString = string.Empty;
            VconnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ToString();

            ASPxDashboard1.SetConnectionStringsProvider(new ConfigFileConnectionStringsProvider());
            DashboardConfigurator.Default.SetConnectionStringsProvider(new ConfigFileConnectionStringsProvider());
 //           ASPxDashboard1.DashboardXmlPath = Server.MapPath("App_Data/Dashboards/dashboard1.xml");

//            string definitionPath = Server.MapPath("App_Data/Dashboards/dashboard1.xml");
//            string dashboardDefinition = File.ReadAllText(definitionPath);
//            ASPxDashboard1.OpenDashboard(dashboardDefinition);

            /*#region #DataSourceStorage
            DashboardSqlDataSource sqlDataSource = new DashboardSqlDataSource("SQL Data Source", "SQLConexionPortal");
            DataSourceInMemoryStorage dataSourceStorage = new DataSourceInMemoryStorage();
            dataSourceStorage.RegisterDataSource("sqlDataSource1", sqlDataSource.SaveToXml());
            ASPxDashboard1.SetDataSourceStorage(dataSourceStorage);
            #endregion #DataSourceStorage*/

        }
    }
}