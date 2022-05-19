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
    public partial class cambioperiodos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {

            //LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
            //ASPxComboBox CBUsuarios = itemCiaOri.GetNestedControl() as ASPxComboBox;



            //ASPxDateEdit CBFechaInicial = GetNestedEditor(Lform, "FechaInicial");

            DS_Periodos.DataBind();

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
            string Vmenu;
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
                ComandoConsulta.CommandText = "SELECT [permiso] FROM [PORTAL].[dbo].[Usuario_Menu] UM, portal.dbo.Usuario U  where UM.Codigousuario = U.Codigousuario and nombre = '" + CBUsuarios.Value.ToString().ToUpper() + "'";
                ComandoConsulta.Connection = dbSQL;

                GPermisos.Selection.UnselectAll();

                using (SqlDataReader rdr = ComandoConsulta.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        //var myString = rdr.GetString(0); //The 0 stands for "the 0'th column", so the first column of the result.
                                                         // Do somthing with this rows string, for example to put them in to a list
                        Vmenu = rdr.GetString(0); 
                        RowIndice = GPermisos.FindVisibleIndexByKeyValue(Vmenu);
                        GPermisos.Selection.SelectRow(RowIndice);
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

            LayoutItem itemFechaadvIni = Lform.FindItemOrGroupByName("FechaadvIni") as LayoutItem;
            ASPxDateEdit CBFechaadvIni = itemFechaadvIni.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemFechaadvFin = Lform.FindItemOrGroupByName("FechaadvFin") as LayoutItem;
            ASPxDateEdit CBFechaadvFin = itemFechaadvFin.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemFechatraIni = Lform.FindItemOrGroupByName("FechatraIni") as LayoutItem;
            ASPxDateEdit CBFechatraIni = itemFechatraIni.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemFechatraFin = Lform.FindItemOrGroupByName("FechatraFin") as LayoutItem;
            ASPxDateEdit CBFechatraFin = itemFechatraFin.GetNestedControl() as ASPxDateEdit;

       if ((CBFechaadvIni != null) && (CBFechaadvFin != null) && (CBFechatraIni != null) && (CBFechatraFin != null))
        {



            string pfechaadvini = CBFechaadvIni.Date.ToString("dd/MM/yyyy");
            string pfechaadvfin = CBFechaadvFin.Date.ToString("dd/MM/yyyy");
            string pfechaperini = CBFechatraIni.Date.ToString("dd/MM/yyyy");
            string pfechaperfin = CBFechatraFin.Date.ToString("dd/MM/yyyy");

                string PERR = "0";
            string PMerr = "ok";

            int Cerr = 0;
            string Merr = "OK";
            int ii = 0;

            try
            {
                List<object> plist;
                ArrayList totalVals = new ArrayList();
                // plist = GPermisos.GetSelectedFieldValues(New String() {"ID_MENU"})
                plist = GPermisos.GetSelectedFieldValues("CIA");


                //EjecutarSelectVista("Delete COM_USUARIOS_PERMISOS where USUARIO = '" + CBUsuarios.Value.ToString.ToUpper + "'");
                //LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
                //ASPxComboBox CBUsuarios = itemCiaOri.GetNestedControl() as ASPxComboBox;

                //EjecutarborrarMenu(CBUsuarios.Value.ToString().ToUpper());

                foreach (string item in plist)
                { 
                    EjecutarCambiaperiodos(pfechaadvini, pfechaadvfin, pfechaperini, pfechaperfin, item, out PERR, out PMerr);
                    //EjecutarSelectVista("INSERT INTO COM_USUARIOS_PERMISOS (USUARIO, ID_MENU) VALUES ('" + CBUsuarios.Value.ToString.ToUpper + "','" + item + "')");
                    //EjecutarSelectVista("INSERT INTO COM_USUARIOS (USUARIO, NOMBRE, ORACLE) VALUES ('" + CBUsuarios.Value.ToString.ToUpper + "','" + CBUsuarios.Value.ToString.ToUpper + "','S')");
                    
                    if (PERR.Trim() != "0")
                    {
                        Pmensaje.Text = PMerr;
                        break;
                    }


                }
                    DS_Periodos.DataBind();
                }
            catch (Exception ex)
            {
            }
        }
        }

        private void EjecutarborrarMenu (string PUSUARIO)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.dbo.PORTAL_DELETE_PERMISOS", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PUSUARIO", PUSUARIO);
                conn.Open();
                command.ExecuteNonQuery();
            }


        }


        private void EjecutarCambiaperiodos(string pfechaadvini, string pfechaadvfin, string pfechaperini, string pfechaperfin, string PMENU, out string PERR, out string PMERR)
        {


            string PUser;
            PUser = Session["nombreUsuario"].ToString();

            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "ok";


            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.dbo.[PORTAL_MOD_PERIODOS]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PCIA", PMENU);
                command.Parameters.AddWithValue("@PFECHAADVINI", pfechaadvini);
                command.Parameters.AddWithValue("@PFECHAADVFIN", pfechaadvfin);
                command.Parameters.AddWithValue("@PFECHATRABINI", pfechaperini);
                command.Parameters.AddWithValue("@PFECHATRABFIN", pfechaperfin);

                command.Parameters.Add("@PError", SqlDbType.Char, 10);
                command.Parameters["@PError"].Direction = ParameterDirection.Output;

                command.Parameters.Add("@PMerr", SqlDbType.Char, 2000);
                command.Parameters["@PMerr"].Direction = ParameterDirection.Output;


                //                command.Parameters.AddWithValue("@PMerr", VMerr);

                conn.Open();
                command.ExecuteNonQuery();
                vErr = (string)command.Parameters["@PError"].Value;
                VMerr = (string)command.Parameters["@PMerr"].Value;
            }

            PERR = vErr;
            PMERR = VMerr;

        }

        protected void Lform_E2_Click(object sender, EventArgs e)
        {
            //Guardar();
        }

        

        protected void BTAceptar_Click(object sender, EventArgs e)
        {
            Guardar();
        }

        protected void Lform_E3_Click(object sender, EventArgs e)
        {

        }
    }
}