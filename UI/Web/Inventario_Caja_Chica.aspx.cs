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
    public partial class Inventario_Caja_Chica : System.Web.UI.Page
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
        {
            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            ASPxComboBox CBCiaOri = itemCiaOri.GetNestedControl() as ASPxComboBox;


            if (CBCiaOri.Value != null)
            {
                Session["ci_scia1"] = CBCiaOri.Value != null ? CBCiaOri.Value.ToString() : "XXX YYYYYYYY;";
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

        private void EjecutarInserta(string cuenta_contable, string partida, string centro_costo, string cia)
        {
            try
            {
                string VconnectionString;
                VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebasPortal"].ConnectionString;

                using (var conn = new SqlConnection(VconnectionString))
                using (var command = new SqlCommand("PORTAL_SET_CUENTAS_COSTOS_NO_MAPEADAS", conn)
                {
                    CommandType = CommandType.StoredProcedure
                })
                {
                    command.Parameters.AddWithValue("@CUENTA_CONTABLE", cuenta_contable);
                    command.Parameters.AddWithValue("@PARTIDA", partida);
                    command.Parameters.AddWithValue("@CENTRO_COSTO", centro_costo);
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
            ASPxComboBox CBUsuarios = itemCiaOri.GetNestedControl() as ASPxComboBox;

            DataTable dt = new DataTable();
            foreach (GridViewColumn column in GPermisos.VisibleColumns)
            {
                var col = column as GridViewDataColumn;
                if (col != null)
                    dt.Columns.Add(col.FieldName);
                var col2 = column as GridViewCommandColumn;
                if (col2 != null)
                {
                    dt.Columns.Add(col2.Name);
                }
            }
            for (int i = 0; i < GPermisos.VisibleRowCount; i++)
            {
                DataRow row = dt.NewRow();
                foreach (GridViewColumn column in GPermisos.VisibleColumns)
                {
                    var col = column as GridViewDataColumn;
                    if (col != null)
                    {
                        var cellValue = GPermisos.GetRowValues(i, col.FieldName);
                        row[col.FieldName] = cellValue;
                    }
                    var col2 = column as GridViewCommandColumn;
                    if (GPermisos.Selection.IsRowSelected(i) && (col2 != null))
                    {
                        row[col2.Name] = "S";
                    }
                }
                dt.Rows.Add(row);
            }



            try
            {

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["Check"].ToString() == "S")
                    {
                        EjecutarInserta(dt.Rows[i]["CUENTA_CONTABLE"].ToString(), dt.Rows[i]["PARTIDA"].ToString(), dt.Rows[i]["CENTRO_COSTO"].ToString(), CBUsuarios.Value.ToString());
                    }

                }

                SQLGetMapeos.DataBind();
                GPermisos.DataBind();
            }
            catch (Exception ex)
            {
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
