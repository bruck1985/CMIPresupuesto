using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;



namespace UI.Web
{
    public partial class XtraReportBorradorHaciendav2Test : DevExpress.XtraReports.UI.XtraReport
    {
        //public string CiaIDXtraReport;

        public XtraReportBorradorHaciendav2Test()
        {
            InitializeComponent();
        }

        private void XtraReportBorradorHaciendav2Test_DesignerLoaded(object sender, DevExpress.XtraReports.UserDesigner.DesignerLoadedEventArgs e)
        {
            //var report = new UI.Web.XtraReportBorradorHaciendav2Test(); // XtraReport1();
            //documentViewer1.DocumentSource = report;
            //XtraReportBorradorHaciendav2Test.
           
        }

        private void XtraReportBorradorHaciendav2Test_DataSourceDemanded(object sender, EventArgs e)

        {

            //if (this.pcia.Value.ToString() == "")
            //{
            //    this.pcia.Value = "CROMSA";
            //}
            //else
            
            //if(this.pcia.Value != null)
            //{
            //    this.pcia.Value = this.pcia.Value;
            //}
            //else
            //{
            //    this.pcia.Value = "IECA";
            //}

        }

        private void DetailReport1_AfterPrint(object sender, EventArgs e)
        {
            //if (xrLabelActividad_290003.Value != null)
            //{
            //    DetailReport1.Visible = true;
            //}
            //else
            //{
            //    DetailReport1.Visible = false;
            //}
        }

        private void DetailReport2_AfterPrint(object sender, EventArgs e)
        {
            //if (xrLabelActividad_401002.Value != null)
            //{
            //    DetailReport2.Visible = true;
            //}
            //else
            //{
            //    DetailReport2.Visible = false;
            //}
        }

        private void Detail2_AfterPrint(object sender, EventArgs e)
        {
            //if (xrLabelActividad_290003.Value != null)
            //{
            //    DetailReport1.Visible = true;
            //}
            //else
            //{
            //    DetailReport1.Visible = false;
            //}
        }

        private void Detail3_AfterPrint(object sender, EventArgs e)
        {
            //if (xrLabelActividad_401002.Value != null)
            //{
            //    DetailReport2.Visible = true;
            //}
            //else
            //{
            //    DetailReport2.Visible = false;
            //}
        }
    }
}
