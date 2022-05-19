using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using DevExpress.Export;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Collections;
using OfficeOpenXml;

namespace UI.Web
{
    public partial class Presupuesto_Usuarios : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private DataTable getDataUsuariosGridview()
        {
            DataTable dt = new DataTable();
            foreach (GridViewColumn column in GUsuarios.VisibleColumns)
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
            for (int i = 0; i < GUsuarios.VisibleRowCount; i++)
            {
                DataRow row = dt.NewRow();
                foreach (GridViewColumn column in GUsuarios.VisibleColumns)
                {
                    var col = column as GridViewDataColumn;
                    if (col != null)
                    {
                        var cellValue = GUsuarios.GetRowValues(i, col.FieldName);
                        row[col.FieldName] = cellValue;
                    }
                    var col2 = column as GridViewCommandColumn;
                    if (GUsuarios.Selection.IsRowSelected(i) && (col2 != null))
                    {
                        row[col2.Name] = "S";
                    }
                }
                dt.Rows.Add(row);
            }

            return dt;
        }

        private void Guardar()
        {

            DataTable dt = new DataTable();

            dt = getDataUsuariosGridview();

            int contador = 0;
            int linea = 0;

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["Check"].ToString() == "S")
                {
                    contador = contador + 1;
                    linea = i;
                }

            }

            if (contador == 1)
            {
                Session["CBUsuario"] = dt.Rows[linea]["USUARIO"].ToString() != null ? dt.Rows[linea]["USUARIO"].ToString() : "XXX;";
            }
            else
            {
                Session["CBUsuario"] = "NO USER";
            }


        }

        private void Carga_Grid()
        {
            gridview.DataSource = DS_Presupuesto_Usuarios;
            gridview.DataBind();
        }


        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {
            Guardar();
            Carga_Grid();
        }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            //grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });

            DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
            //PivotCompra.OptionsView.HideAllTotals();
            //System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //ASPxPivExp1.ExportToXlsx(stream);
            //WriteToResponse("ReporteOrdenCompra.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
            //PivotCompra.OptionsView.ShowAllTotals();

            Response.Clear();
            Response.Charset = "";
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename=Privilegios.xlsx");

            DataTable dt = new DataTable();

            if (gridview.Rows.Count != 0)
            {
                //Forloop for header
                for (int i = 0; i < gridview.HeaderRow.Cells.Count; i++)
                {
                    dt.Columns.Add(gridview.HeaderRow.Cells[i].Text);
                }
                //foreach for datarow
                foreach (GridViewRow row in gridview.Rows)
                {
                    DataRow dr = dt.NewRow();
                    for (int j = 0; j < row.Cells.Count; j++)
                    {
                        dr[gridview.HeaderRow.Cells[j].Text] = Server.HtmlDecode(row.Cells[j].Text);
                        if (Server.HtmlDecode(row.Cells[j].Text) == "")
                        {
                            switch (j)
                            {
                                case 4:
                                    CheckBox cBox = (CheckBox)row.FindControl("PRIV_MODIFICACION");
                                    dr[gridview.HeaderRow.Cells[4].Text] = cBox.Checked ? "S" : "N";
                                    break;
                                case 5:
                                    CheckBox cBox1 = (CheckBox)row.FindControl("PRIV_EJECUCION");
                                    dr[gridview.HeaderRow.Cells[5].Text] = cBox1.Checked ? "S" : "N";
                                    break;
                                case 6:
                                    CheckBox cBox2 = (CheckBox)row.FindControl("PRIV_LECTURA");
                                    dr[gridview.HeaderRow.Cells[6].Text] = cBox2.Checked ? "S" : "N";
                                    break;
                                default:
                                    break;
                            }

                        }
 
                    }
                    dt.Rows.Add(dr);
                }


                //Loop for footer
                if (gridview.FooterRow.Cells.Count != 0)
                {
                    DataRow dr = dt.NewRow();
                    for (int i = 0; i < gridview.FooterRow.Cells.Count; i++)
                    {
                        dr[gridview.HeaderRow.Cells[i].Text] = (gridview.FooterRow.Cells[i].Text == "&nbsp;" ? "" : gridview.FooterRow.Cells[i].Text);
                    }
                    dt.Rows.Add(dr);
                }
                dt.TableName = "tb";
            }

            if (gridview.Rows.Count >= 1)
            {
                using (ExcelPackage pck = new ExcelPackage())
                {
                    ExcelWorksheet wsDt = pck.Workbook.Worksheets.Add("Sheet1");
                    wsDt.Cells["A1"].LoadFromDataTable(dt, true, OfficeOpenXml.Table.TableStyles.Light20);
                    wsDt.Cells[wsDt.Dimension.Address].AutoFitColumns();

                    Response.BinaryWrite(pck.GetAsByteArray());
                }
            }


            Response.Flush();
            Response.End();



        }

        protected void ExportExcel1_Click(object sender, EventArgs e)
        {

            //ASPxPivotGridExp1.ExportToXlsx("DetalleCtaExp.xlsx");
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //ASPxPivotGridExp1.ExportToXlsx(stream);
            //WriteToResponse("ReporteDetalleCta1.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);

        }

        protected void ExportExcel2_Click(object sender, EventArgs e)
        {
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //ASPxPivotGridExp2.ExportToXlsx(stream);
            //WriteToResponse("ReporteDetalleCta1.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);

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




        protected void Lform_E3_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();

            for (int j = 0; j < gridview.Columns.Count; j++)
            {
                dt.Columns.Add(gridview.Columns[j].HeaderText);
            }

            for (int i = 0; i < gridview.Rows.Count; i++)
            {
                DataRow row = dt.NewRow();

                for (int j = 0; j < gridview.Columns.Count; j++)
                {
                    if (gridview.Rows[i].Cells[j].Text != "")
                    {
                        row[gridview.Columns[j].HeaderText] = gridview.Rows[i].Cells[j].Text;
                    }
                    else
                    {
                        CheckBox chk = (gridview.Rows[i].Cells[j].FindControl(gridview.Columns[j].HeaderText) as CheckBox);
                        row[gridview.Columns[j].HeaderText] = chk.Checked ? "S" : "N";
                    }
                }
                dt.Rows.Add(row);
            }


            DataTable dt2 = new DataTable();

            dt2 = getDataUsuariosGridview();

            int contador = 0;
            int linea = 0;

            for (int i = 0; i < dt2.Rows.Count; i++)
            {
                if (dt2.Rows[i]["Check"].ToString() == "S")
                {
                    contador = contador + 1;
                    linea = i;
                }

            }

            if (contador == 1)
            {
                for (int j = 0; j < dt.Rows.Count; j++)
                {
                    try
                    {
                        string VconnectionString;
                        VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;

                        using (var conn = new SqlConnection(VconnectionString))
                        using (var command = new SqlCommand("PORTAL_UPD_PRIVILEGIOS_USUARIOS_PRESUPUESTOS", conn)
                        {
                            CommandType = CommandType.StoredProcedure
                        })
                        {
                            command.Parameters.AddWithValue("@PRESUPUESTO", HttpUtility.HtmlDecode(dt.Rows[j]["PRESUPUESTO"].ToString()));
                            command.Parameters.AddWithValue("@USUARIO", HttpUtility.HtmlDecode(dt2.Rows[linea]["USUARIO"].ToString()));
                            command.Parameters.AddWithValue("@PRIV_LECTURA", dt.Rows[j]["PRIV_LECTURA"].ToString());
                            command.Parameters.AddWithValue("@PRIV_MODIFICACION", dt.Rows[j]["PRIV_MODIFICACION"].ToString());
                            command.Parameters.AddWithValue("@PRIV_EJECUCION", dt.Rows[j]["PRIV_EJECUCION"].ToString());
                            command.Parameters.AddWithValue("@EMPRESA", HttpUtility.HtmlDecode(dt.Rows[j]["EMPRESA"].ToString()));
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

            }
            else
            {
                for (int i = 0; i < dt2.Rows.Count; i++)
                {
                    if (dt2.Rows[i]["Check"].ToString() == "S")
                    {
                        for (int j = 0; j < dt.Rows.Count; j++)
                        {

                                try
                                {
                                    string VconnectionString;
                                    VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;

                                    using (var conn = new SqlConnection(VconnectionString))
                                    using (var command = new SqlCommand("PORTAL_UPD_PRIVILEGIOS_USUARIOS_PRESUPUESTOS", conn)
                                    {
                                        CommandType = CommandType.StoredProcedure
                                    })
                                    {
                                        command.Parameters.AddWithValue("@PRESUPUESTO", HttpUtility.HtmlDecode(dt.Rows[j]["PRESUPUESTO"].ToString()));
                                        command.Parameters.AddWithValue("@USUARIO", HttpUtility.HtmlDecode(dt2.Rows[i]["USUARIO"].ToString()));
                                        command.Parameters.AddWithValue("@PRIV_LECTURA", dt.Rows[j]["PRIV_LECTURA"].ToString());
                                        command.Parameters.AddWithValue("@PRIV_MODIFICACION", dt.Rows[j]["PRIV_MODIFICACION"].ToString());
                                        command.Parameters.AddWithValue("@PRIV_EJECUCION", dt.Rows[j]["PRIV_EJECUCION"].ToString());
                                        command.Parameters.AddWithValue("@EMPRESA", HttpUtility.HtmlDecode(dt.Rows[j]["EMPRESA"].ToString()));
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
                    }

                }

            }


            string script = "alert('Registro Exitoso');";

            ScriptManager.RegisterStartupScript(this, typeof(System.Web.UI.Page), "alerta", script, true);

        }


    }
}