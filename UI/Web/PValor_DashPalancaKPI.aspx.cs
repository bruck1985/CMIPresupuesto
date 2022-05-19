using DevExpress.DashboardCommon;
using DevExpress.DashboardWeb;
using DevExpress.DataAccess.Web;
using DevExpress.XtraEditors; //Added by RH
using DevExpress.LookAndFeel; //Added by RH
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;



namespace UI.Web
{
    public partial class PValor_DashPalancaKPI : System.Web.UI.Page
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

            //ASPxDashboard1.ColorScheme = ColorSchemeDarkViolet();

            // Enabled by RH
            //ASPxDashboard1.DashboardXmlPath = Server.MapPath("App_Data/Dashboards/DashPalancaGeneral.xml");
            //ASPxDashboard1.DashboardXmlPath = "~/App_Data/Dashboards/DashPalancaGeneral.xml";

            //            string definitionPath = Server.MapPath("App_Data/Dashboards/DashPalancaGeneral.xml");
            //            string dashboardDefinition = File.ReadAllText(definitionPath);
            //            ASPxDashboard1.OpenDashboard(dashboardDefinition);

            /*#region #DataSourceStorage
            DashboardSqlDataSource sqlDataSource = new DashboardSqlDataSource("SQL Data Source", "SQLConexionPortal");
            DataSourceInMemoryStorage dataSourceStorage = new DataSourceInMemoryStorage();
            dataSourceStorage.RegisterDataSource("sqlDataSource1", sqlDataSource.SaveToXml());
            ASPxDashboard1.SetDataSourceStorage(dataSourceStorage);
            #endregion #DataSourceStorage*/



        }

        protected void ASPxDashboard1_DashboardSaving(object sender, DashboardSavingWebEventArgs e)
        {


            //e.DashboardXml.Save(ASPxDashboard1.DashboardXmlPath);
            //e.DashboardXml.Save("~/App_Data/Dashboards/DashPalancaGeneral.xml");
            //e.DashboardXml.Save(ASPxDashboard1.DashboardXmlPath);
            e.DashboardXml.Save("D:/OLD/Downloads/Portal CMI-20211021T194116Z-001/Portal CMI/CMI Data Analisis/UI/App_Data/Dashboards/DashPalancaKPI.xml");
            //SaveDashboard()
            //e.Handled = true;
            //string titleText = e.Dashboard.Title.Text;
            //string titleText = e
            //SaveFileDialog sfd = new SaveFileDialog();
            //sfd.Filter = "Dashboard files (*.xml)|*.xml";
            //sfd.DefaultExt = "xml";
            //sfd.FileName = titleText;
            //if (sfd.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            //{
            //    e.Dashboard.SaveToXml(sfd.FileName);
            //    e.Saved = false;
            //}
            //else
            //    e.Saved = false;
            e.Handled = true;
        }

        protected void ASPxDashboard1_CustomPalette(object sender, CustomPaletteWebEventArgs e)
        {
            List<Color> customColors = new List<Color>();
            customColors.Add(Color.LightBlue);
            customColors.Add(Color.Aquamarine);
            customColors.Add(Color.SkyBlue);
            customColors.Add(Color.LightCoral);
            customColors.Add(Color.Tomato);
            customColors.Add(Color.IndianRed);
            customColors.Add(Color.Violet);
            customColors.Add(Color.Plum);
            customColors.Add(Color.MediumOrchid);

            e.Palette = new DashboardPalette(customColors);
        }

        protected void ASPxDashboard1_SetInitialDashboardState(object sender, SetInitialDashboardStateEventArgs e)
        {
            DashboardState dashboardState = new DashboardState();

            DashboardItemState gridFilterState = new DashboardItemState("comboBoxDashboardItem1");
            gridFilterState.MasterFilterValues.AddRange(new List<object[]>() {
                new string[1] { "Abierto" }
            });
            dashboardState.Items.Add(gridFilterState);

            e.InitialState = dashboardState;
        }




        //private void dashboardDesigner1_DashboardSaving(object sender, DevExpress.DashboardWin.DashboardSavingEventArgs e)
        //{
        //    string titleText = e.Dashboard.Title.Text;
        //    SaveFileDialog sfd = new SaveFileDialog();
        //    sfd.Filter = "Dashboard files (*.xml)|*.xml";
        //    sfd.DefaultExt = "xml";
        //    sfd.FileName = titleText;
        //    if (sfd.ShowDialog() == System.Windows.Forms.DialogResult.OK)
        //    {
        //        e.Dashboard.SaveToXml(sfd.FileName);
        //        e.Saved = false;
        //    }
        //    else
        //        e.Saved = false;
        //    e.Handled = true;
        //}

        //private void dashboardDesigner1_DashboardSaving(object sender,
        //    DevExpress.DashboardWin.DashboardSavingEventArgs e)
        //{
        //    if (e.Command == DevExpress.DashboardWin.DashboardSaveCommand.Save)
        //    {
        //        dashboardDesigner1.Dashboard.SaveToXml(filePath);
        //        e.Handled = true;
        //    }
        //    if (e.Command == DevExpress.DashboardWin.DashboardSaveCommand.SaveAs)
        //    {
        //        DialogResult result = InvokeMessageBox();
        //        if (result == DialogResult.OK)
        //        {
        //            dashboardDesigner1.Dashboard.SaveToXml(filePath);
        //            e.Handled = true;
        //            e.Saved = true;
        //        }
        //        if (result == DialogResult.Cancel)
        //        {
        //            e.Handled = true;
        //            e.Saved = false;
        //        }
        //    }
        //}


    }
}