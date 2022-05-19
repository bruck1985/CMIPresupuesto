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
    public partial class Asocentroscia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                Session["CBCia24"] = "";
                Session["PCuentaini24"] = "";
                Session["PCuentafin24"] = "";
                Session["CBCiades24"] = "";
                Session["PCentrodes24"] = "";

            }
        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {

            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
            ASPxComboBox CBUsuarios = itemCiaOri.GetNestedControl() as ASPxComboBox;

            LayoutItem itemCentroIni = Lform.FindItemOrGroupByName("TXCentroIni") as LayoutItem;
            ASPxTextBox txCentroIni = itemCentroIni.GetNestedControl() as ASPxTextBox;

            LayoutItem itemCentroFin = Lform.FindItemOrGroupByName("TXCentroFin") as LayoutItem;
            ASPxTextBox txCentroFin = itemCentroFin.GetNestedControl() as ASPxTextBox;

            LayoutItem itemCiaDes = Lform.FindItemOrGroupByName("CBCiafin") as LayoutItem;
            ASPxComboBox CBCiaDes = itemCiaDes.GetNestedControl() as ASPxComboBox;



            //ASPxDateEdit CBFechaInicial = GetNestedEditor(Lform, "FechaInicial");
            if (CBUsuarios != null)
            {
                if (CBUsuarios.Value != null)
                {
                    Session["CBCia24"] = CBUsuarios.Value != null ? CBUsuarios.Value.ToString() : "";
                    Session["PCentroini24"] = txCentroIni.Value != null ? txCentroIni.Value.ToString() : "";
                    Session["PCentrofin24"] = txCentroIni.Value != null ? txCentroIni.Value.ToString() : "";

                    Session["CBCiades24"] = CBCiaDes.Value != null ? CBCiaDes.Value.ToString() : "";
                    Session["PCentrodes24"] = txCentroFin.Value != null ? txCentroFin.Value.ToString() : "";

                    DS_CENTRO_COSTO_GRID.DataBind();
                    DS_CENTRO_COSTO_GRID_show.DataBind();
                    GPCentrosCia.DataBind();
                    DS_CENTRO_COSTO_GRID_show.DataBind();


                    //Buscar();
                }
                else
                {
                    Session["CBCia24"] = "X";
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
            string Vmenu;
            LayoutItem itemCBcentro = Lform.FindItemOrGroupByName("CBCentro") as LayoutItem;
            ASPxComboBox CBcentro = itemCBcentro.GetNestedControl() as ASPxComboBox;
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
                ComandoConsulta.CommandText = "select CUENTA_CONTABLE from " + Session["CBCia24"] + ".centro_cuenta WhERE estado = 'A' and CENTRO_COSTO = '" + CBcentro.Value.ToString().ToUpper() + "'";
                ComandoConsulta.Connection = dbSQL;

                GPCentrosCia.Selection.UnselectAll();

                using (SqlDataReader rdr = ComandoConsulta.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        //var myString = rdr.GetString(0); //The 0 stands for "the 0'th column", so the first column of the result.
                                                         // Do somthing with this rows string, for example to put them in to a list
                        Vmenu = rdr.GetString(0); 
                        RowIndice = GPCentrosCia.FindVisibleIndexByKeyValue(Vmenu);
                        GPCentrosCia.Selection.SelectRow(RowIndice);
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
            string Cerr = "0";
            string Merr = "OK";
            int ii = 0;
            string PActivar = "S";

            try
            {
                LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
                ASPxComboBox CBUsuarios = itemCiaOri.GetNestedControl() as ASPxComboBox;

                LayoutItem itemCentroIni = Lform.FindItemOrGroupByName("TXCentroIni") as LayoutItem;
                ASPxTextBox txCentroIni = itemCentroIni.GetNestedControl() as ASPxTextBox;

                LayoutItem itemCentroFin = Lform.FindItemOrGroupByName("TXCentroFin") as LayoutItem;
                ASPxTextBox txCentroFin = itemCentroFin.GetNestedControl() as ASPxTextBox;

                LayoutItem itemCiaDes = Lform.FindItemOrGroupByName("CBCiafin") as LayoutItem;
                ASPxComboBox CBCiaDes = itemCiaDes.GetNestedControl() as ASPxComboBox;



                //ASPxDateEdit CBFechaInicial = GetNestedEditor(Lform, "FechaInicial");
                if (CBUsuarios != null)
                {
                    if (CBUsuarios.Value != null)
                    {
                        Session["CBCia24"] = CBUsuarios.Value != null ? CBUsuarios.Value.ToString() : "";
                        Session["PCentroini24"] = txCentroIni.Value != null ? txCentroIni.Value.ToString() : "";
                        Session["PCentrofin24"] = txCentroIni.Value != null ? txCentroIni.Value.ToString() : "";

                        Session["CBCiades24"] = CBCiaDes.Value != null ? CBCiaDes.Value.ToString() : "";
                        Session["PCentrodes24"] = txCentroFin.Value != null ? txCentroFin.Value.ToString() : "";

                        DS_CENTRO_COSTO_GRID.DataBind();
                        DS_CENTRO_COSTO_GRID_show.DataBind();

                        GPCentrosCia.DataBind();
                        DS_CENTRO_COSTO_GRID_show.DataBind();

                        //Buscar();
                    }
                    else
                    {
                        Session["CBCia24"] = "X";
                    }
                }
                string PERR = "0";
                string PMerr = "ok";
                string PUser;
                PUser = "sa";

                EjecutarCopiaCentroCosto(PUser, Session["CBCia24"].ToString(), Session["PCentroini24"].ToString(), Session["CBCiades24"].ToString(), Session["PCentrodes24"].ToString(), out PERR, out PMerr);

                Pmensaje.Text = PMerr;
                if (PERR.Trim() == "0")
                {
                    DS_CENTRO_COSTO_GRID_show.DataBind();

                }

            }
            catch (Exception ex)
            {
            }
        }

        protected List<object> GetUnselectedFieldValues(ASPxGridView gridInstance, params string[] FieldNames)
        {
            List<object> list = new List<object>();
            for (int i = 0; i < gridInstance.VisibleRowCount; i++)
            {
                if (!gridInstance.Selection.IsRowSelected(i))
                {
                    list.Add(gridInstance.GetRowValues(i, FieldNames));
                }
            }
            return list;
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


        private void EjecutaActualizaAso(string PCia, string PCuenta, string PCentro, string PActivar)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.dbo.[PORTAL_ADD_CENTROS_CUENTAS]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PCIA", PCia);
                command.Parameters.AddWithValue("@PCUENTA_CONTABLE", PCuenta);
                command.Parameters.AddWithValue("@PCENTROS_COSTOS", PCentro);
                command.Parameters.AddWithValue("@PACTIVAR", PActivar);


                conn.Open();
                command.ExecuteNonQuery();
            }


        }

        protected void Popup_WindowCallback(object source, PopupWindowCallbackArgs e)
        {
            //CurrentCiactaID = e.Parameter;
            //DetailsApply();
        }


        protected void Lform_E2_Click(object sender, EventArgs e)
        {
            Guardar();
        }

        protected void Lform_E3_Click(object sender, EventArgs e)
        {
            //Guardar();
        }

        protected void Lform_E2_Callback(object sender, CallbackEventArgsBase e)
        {

            Session["PCia24"] = e.Parameter;
        }

        protected void CBListaAbuelo_Callback(object sender, CallbackEventArgsBase e)
        {

            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
            ASPxComboBox CBUsuarios = itemCiaOri.GetNestedControl() as ASPxComboBox;

            string text = e.Parameter;


            Session["CBCia24"] = CBUsuarios.Value != null ? CBUsuarios.Value.ToString() : "";
            Session["PAdicional241"] = text;


            //Session["PCuentaini24"] = txCuentaIni.Value != null ? txCuentaIni.Value.ToString() : "";
            //Session["PCuentafin24"] = txCuentaFin.Value != null ? txCuentaFin.Value.ToString() : "";

            //CBListaAbuelo.DataBind();
        }

        protected void CBListaPadre_Callback(object sender, CallbackEventArgsBase e)
        {
            string text = e.Parameter;
            string abulocod;

            string pCIA = Session["CBCia24"].ToString();
            string Abuelo = Session["PAdicional241"].ToString();

            //Session["PAbuelo24"] = Abuelo.Substring(0, 3);
            //abulocod = Abuelo.Substring(0, 3);
            Session["PAbuelo24"] = text;
            Session["PAdicional242"] = "";

        }

        private void EjecutarCopiaCentroCosto(string PUSUARIO, string PCIA, string PCENTROINI, string PCIAFin, string PCentroFin, out string PERR, out string PMERR)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            string vErr;
            string VMerr;
            vErr = "0";
            VMerr = "ok";


            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.[dbo].[PORTAL_CENTROSCOSTOS_CB_COPIA_ADD]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PUsuario", PUSUARIO);
                command.Parameters.AddWithValue("@PCia1", PCIA);
                command.Parameters.AddWithValue("@PCentroini", PCENTROINI);
                command.Parameters.AddWithValue("@PCiafin", PCIAFin);
                command.Parameters.AddWithValue("@PCentrofin", PCentroFin);

                command.Parameters.Add("@PErr", SqlDbType.Char, 10);
                command.Parameters["@PErr"].Direction = ParameterDirection.Output;

                command.Parameters.Add("@PMerr", SqlDbType.Char, 2000);
                command.Parameters["@PMerr"].Direction = ParameterDirection.Output;

                conn.Open();
                command.ExecuteNonQuery();


                vErr = (string)command.Parameters["@PErr"].Value;
                VMerr = (string)command.Parameters["@PMerr"].Value;
            }

            PERR = vErr;
            PMERR = VMerr;


        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            int PERR = 0;
            string PMerr = "ok";
            string PUser;
//            string PCC1 = CBListaAbuelo.Text.Substring(0, 3);
//            string PCC2 = CBListaPadre.Text.Substring(0, 3);
//            string PCC3 = tbcentrocostohijo.Text;
            PUser = "sa";

            //EjecutarCrearCentroCosto(PUser, Session["CBCia24"].ToString(), PCC1, tbnombreabuelo.Text, PCC2, tbnombrepadre.Text, PCC3, tbnombrehijo.Text, out PERR, out PMerr);

//            Pmensaje.Text = PMerr;



        }

        protected void ASPxCheckBox1_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void BTAceptar_Click(object sender, EventArgs e)
        {
            Guardar();
        }
    }
}