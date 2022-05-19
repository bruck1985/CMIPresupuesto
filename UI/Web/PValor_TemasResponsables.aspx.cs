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

namespace UI.Web
{
    public partial class PValor_TemasResponsables : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                return;

            }
        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {

            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
            ASPxComboBox CBUsuarios = itemCiaOri.GetNestedControl() as ASPxComboBox;



            //ASPxDateEdit CBFechaInicial = GetNestedEditor(Lform, "FechaInicial");
            if (CBUsuarios != null)
            {
                if (CBUsuarios.Value != null)
                {
                    Session["CBUsuario"] = CBUsuarios.Value != null ? CBUsuarios.Value.ToString() : "XXX;";
                    Buscar();
                }
                else
                {
                    Session["CBUsuario"] = "X";
                }
            }

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

        /// <summary>
        /// 
        /// </summary>
        private void Buscar()
        {
            int VArea;
            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
            ASPxComboBox CBUsuarios = itemCiaOri.GetNestedControl() as ASPxComboBox;
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            SqlConnection dbSQL = new SqlConnection(VconnectionString);

            SqlDataReader MIDataReader;
            int Cerr = 0;
            string Merr = "OK";
            int RowIndice;
            try
            {

                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();
                //Oracle.DataAccess.Client.OracleCommand ComandoConsulta = new Oracle.DataAccess.Client.OracleCommand();

                SqlCommand ComandoConsulta = new SqlCommand();
                ComandoConsulta.CommandText = "SELECT AREA FROM [PORTAL].PRESUPUESTO.AREA_USUARIO UM where UM.USUARIO = '" + CBUsuarios.Value.ToString().ToUpper() + "'";
                ComandoConsulta.Connection = dbSQL;

                GAreas.Selection.UnselectAll();

                using (SqlDataReader rdr = ComandoConsulta.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        //var myString = rdr.GetString(0); //The 0 stands for "the 0'th column", so the first column of the result.
                        // Do somthing with this rows string, for example to put them in to a list
                        VArea = rdr.GetInt32(0); 
                        RowIndice = GAreas.FindVisibleIndexByKeyValue(VArea);
                        GAreas.Selection.SelectRow(RowIndice);
                    }
                }


//                MIDataReader = ComandoConsulta.ExecuteReader();
                // aspxboxlist.Text = "0"
                // GFlow.DataBind()
//                GPermisos.Selection.UnselectAll();

                //if (MIDataReader != null)
                //{
                //    while (MIDataReader.Read)
                //    {
                //        Vmenu = MIDataReader.GetValue(0).ToString;
                //        RowIndice = GPermisos.FindVisibleIndexByKeyValue(Vmenu);

                //        GPermisos.Selection.SelectRow(RowIndice);
                //    }
                //    MIDataReader.Close();
                //}
                ComandoConsulta = null/* TODO Change to default(_) if this is not a reference type */;
            }

            // GFlow.Selection.SelectAll()


            catch (Exception ex)
            {
            }
            finally
            {
                if (dbSQL.State == ConnectionState.Open)
                    dbSQL.Close();
            }
        }



        private void Guardar()
        {
            string PUSuario = "";
            int Cerr = 0;
            string Merr = "OK";
            string Vsolo_lectura = "N";
            int ii = 0;

            try
            {
                List<object> plist;
                ArrayList totalVals = new ArrayList();
                // plist = GPermisos.GetSelectedFieldValues(New String() {"ID_MENU"})
                   
                plist = GAreas.GetSelectedFieldValues("AREA");


                //EjecutarSelectVista("Delete COM_USUARIOS_PERMISOS where USUARIO = '" + CBUsuarios.Value.ToString.ToUpper + "'");
                LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
                ASPxComboBox CBUsuarios = itemCiaOri.GetNestedControl() as ASPxComboBox;

                EjecutarborrarMenu(CBUsuarios.Value.ToString().ToUpper());

                foreach (Int32 item in plist)
                    //Vsolo_lectura =  GAreas.GetRowValuesByKeyValue (item, "SOLO_LECTURA");
                    EjecutarInsertaArea(CBUsuarios.Value.ToString().ToUpper(), item);
                    //EjecutarSelectVista("INSERT INTO COM_USUARIOS_PERMISOS (USUARIO, ID_MENU) VALUES ('" + CBUsuarios.Value.ToString.ToUpper + "','" + item + "')");
                    //EjecutarSelectVista("INSERT INTO COM_USUARIOS (USUARIO, NOMBRE, ORACLE) VALUES ('" + CBUsuarios.Value.ToString.ToUpper + "','" + CBUsuarios.Value.ToString.ToUpper + "','S')");

            }
            catch (Exception ex)
            {
            }
        }

        private void EjecutarborrarMenu (string PUSUARIO)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.Presupuesto.PORTAL_PRESUPUESTO_DELETE_PERMISOS", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PUSUARIO", PUSUARIO);
                conn.Open();
                command.ExecuteNonQuery();
            }


        }


        private void EjecutarInsertaArea(string PUSUARIO, int PAREA)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.Presupuesto.PORTAL_PRESUPUESTO_ADD_USU_AREA", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PUSUARIO", PUSUARIO);
                command.Parameters.AddWithValue("@AREA", PAREA);
                
                conn.Open();
                command.ExecuteNonQuery();
            }


        }

        protected void Lform_E2_Click(object sender, EventArgs e)
        {
            Guardar();
        }

        protected void Lform_E3_Click(object sender, EventArgs e)
        {
            Guardar();
        }
    }
}