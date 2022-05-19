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
    public partial class Presupuesto_Actualiza_Estado : System.Web.UI.Page
    {
        bool bounded;
        private string CurrentCiactaID
        {

            get { return Session["CurrentCiactaID"] == null ? String.Empty : Session["CurrentCiactaID"].ToString(); }
            set
            {
                Session["CurrentCiactaID"] = value;
                String[] campos = value.Split(';');
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }



        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        { //ASPxComboBox2
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

        private void Ejecutar(string ano, string cia)
        {
            try
            {
                string VconnectionString;
                VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;

                using (var conn = new SqlConnection(VconnectionString))
                using (var command = new SqlCommand("PORTAL_SET_PRESUPUESTO_LIBERADO", conn)
                {
                    CommandType = CommandType.StoredProcedure
                })
                {
                    command.Parameters.AddWithValue("@PRESUPUESTO", ano);
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

        private void Ejecutar2(string ano, string cia)
        {
            try
            {
                string VconnectionString;
                VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;

                using (var conn = new SqlConnection(VconnectionString))
                using (var command = new SqlCommand("PORTAL_SET_PRESUPUESTO_CERRADO", conn)
                {
                    CommandType = CommandType.StoredProcedure
                })
                {
                    command.Parameters.AddWithValue("@PRESUPUESTO", ano);
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
                        Ejecutar(dt.Rows[i]["PRESUPUESTO"].ToString(), CBUsuarios.Value.ToString());
                    }

                }

                SQLGetMapeos.DataBind();
                GPermisos.DataBind();
            }
            catch (Exception ex)
            {
            }

        }


        private void Guardar2()
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
                        Ejecutar2(dt.Rows[i]["PRESUPUESTO"].ToString(), CBUsuarios.Value.ToString());
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

        protected void Lform_E5_Click(object sender, EventArgs e)
        {
            Guardar2();
        }
    }
}
