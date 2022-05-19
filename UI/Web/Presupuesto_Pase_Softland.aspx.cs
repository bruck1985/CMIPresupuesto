using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using DevExpress.Export;
using DevExpress.Web.ASPxPivotGrid;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Collections;

namespace UI.Web
{
    public partial class Presupuesto_Pase_Softland : System.Web.UI.Page
    {
        bool bounded;
        private string CurrentCiactaID
        {

            get { return Session["CurrentCiactaID"] == null ? String.Empty : Session["CurrentCiactaID"].ToString(); }
            set
            {
                Session["CurrentCiactaID"] = value;
                String[] campos = value.Split(';');
                Session["CI_Det_Cia1"] = campos[0];
                Session["CI_Det_Cta1"] = campos[1];
                Session["CI_Det_Cia2"] = campos[2];
                Session["CI_Det_Cta2"] = campos[3];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }



        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        { //ASPxComboBox2
            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            ASPxComboBox CBCiaOri = itemCiaOri.GetNestedControl() as ASPxComboBox;

            LayoutItem itemAnno = Lform.FindItemOrGroupByName("AnnoOrigen") as LayoutItem;
            ASPxComboBox CBAnnoOri = itemAnno.GetNestedControl() as ASPxComboBox;

            if (CBCiaOri.Value != null)
            {
                Session["ci_scia1"] = CBCiaOri.Value != null ? CBCiaOri.Value.ToString() : "SERSA";
                Session["anno"] = CBAnnoOri.Value != null ? CBAnnoOri.Value.ToString() : "1979";
                SQLGetMapeos.DataBind();
                GPermisos.DataBind();
            }
            else
            {
                Session["ci_scia1"] = "XXX XXXXXXXXXX";
            }
        }



        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            ASPxGridViewExporter1.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
        }

        protected void SQLCompras_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        private void EjecutarInserta(string ano, string cia)
        {
            try
            {
                string VconnectionString;
                VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;

                using (var conn = new SqlConnection(VconnectionString))
                using (var command = new SqlCommand("PORTAL_SET_PRESUPUESTO_SOFTLAND", conn)
                {
                    CommandType = CommandType.StoredProcedure
                })
                {
                    command.Parameters.AddWithValue("@ANO", ano);
                    command.Parameters.AddWithValue("@CIA", cia);

                    conn.Open();
                    command.ExecuteNonQuery();
                }


            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                throw;
            }



        }

        private void Guardar()
        {
            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            ASPxComboBox CBCiaOri = itemCiaOri.GetNestedControl() as ASPxComboBox;

            LayoutItem itemAnno = Lform.FindItemOrGroupByName("AnnoOrigen") as LayoutItem;
            ASPxComboBox CBAnnoOri = itemAnno.GetNestedControl() as ASPxComboBox;

            if (CBCiaOri.Value != null)
            {
                Session["ci_scia1"] = CBCiaOri.Value != null ? CBCiaOri.Value.ToString() : "XXX YYYYYYYY;";
                Session["anno"] = CBAnnoOri.Value != null ? CBAnnoOri.Value.ToString() : "XXX YYYYYYYY;";
                EjecutarInserta(Session["anno"].ToString(),Session["ci_scia1"].ToString());
                SQLGetMapeos.DataBind();
                GPermisos.DataBind();
                string script = "alert('Registro Exitoso');";

                ScriptManager.RegisterStartupScript(this, typeof(System.Web.UI.Page), "alerta", script, true);
            }
            else
            {
                Session["ci_scia1"] = "XXX XXXXXXXXXX";
            }

        }

        protected void Lform_E3_Click(object sender, EventArgs e)
        {
            Guardar();
        }

        protected void Lform_E2_Click(object sender, EventArgs e)
        {

        }
    }
}
