using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DevExpress.Web.Bootstrap;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using DevExpress.Export;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace UI.Web
{
    public partial class Time_ValidaHoras : System.Web.UI.Page
    {
        bool bounded;
       
        protected void Page_Load(object sender, EventArgs e)
        {
           



            LayoutItem itemAno = Lform.FindItemOrGroupByName("cbano") as LayoutItem;
            ASPxComboBox CBAno = itemAno.GetNestedControl() as ASPxComboBox;

            Session["PANO"] = CBAno.Value != null ? CBAno.Value.ToString() : "2021";

        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {


            LayoutItem itemAno = Lform.FindItemOrGroupByName("cbano") as LayoutItem;
            ASPxComboBox CBAno = itemAno.GetNestedControl() as ASPxComboBox;

            Session["PANO"] = CBAno.Value != null ? CBAno.Value.ToString() : "1900";

            string PERR = "0";
            string PMerr = "ok";
            string PUser;
            PUser = Session["nombreUsuario"].ToString();

            SQLTimeSheet.DataBind();
            Grid.DataBind();

        }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
            Grid.OptionsView.HideAllTotals();
            Grid.OptionsView.ShowFilterHeaders = false;
            Grid.OptionsView.ShowDataHeaders = false;
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            ASPxPivExp1.OptionsPrint.MergeColumnFieldValues = false;
            ASPxPivExp1.OptionsPrint.MergeRowFieldValues = false;
            ASPxPivExp1.OptionsPrint.PrintFilterHeaders = DevExpress.Utils.DefaultBoolean.False;
            ASPxPivExp1.OptionsPrint.PrintUnusedFilterFields = false;
            ASPxPivExp1.ExportToXlsx(stream);
            WriteToResponse("ResumenPresupuesto.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
            Grid.OptionsView.ShowAllTotals();
            Grid.OptionsView.ShowFilterHeaders = true;
            Grid.OptionsView.ShowDataHeaders = true;
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
    }
}
