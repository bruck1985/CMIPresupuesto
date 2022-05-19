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
    public partial class CuentasSeccion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

                Session["CBCia24"] = "";
                Session["PCuentaini24"] = "";
                Session["PCuentafin24"] = "";
                    }

        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {


            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            ASPxComboBox CBCiaOri = itemCiaOri.GetNestedControl() as ASPxComboBox;

            LayoutItem itemCuentaIni = Lform.FindItemOrGroupByName("TXCuentaIni") as LayoutItem;
            ASPxTextBox txCuentaIni = itemCuentaIni.GetNestedControl() as ASPxTextBox;

            LayoutItem itemCuentaFin = Lform.FindItemOrGroupByName("TXCuentaFin") as LayoutItem;
            ASPxTextBox txCuentaFin = itemCuentaFin.GetNestedControl() as ASPxTextBox;



            //ASPxDateEdit CBFechaInicial = GetNestedEditor(Lform, "FechaInicial");
            if (CBCiaOri != null)
            {
                if (CBCiaOri.Value != null)
                {
                    Session["CBCia24"] = CBCiaOri.Value != null ? CBCiaOri.Value.ToString() : "";
                    Session["PCuentaini24"] = txCuentaIni.Value != null ? txCuentaIni.Value.ToString() : "";
                    Session["PCuentafin24"] = txCuentaFin.Value != null ? txCuentaFin.Value.ToString() : "";
                    Session["CBCiaSec"] = "CROMSA";


                    DS_Cuentas.DataBind();
                 //   Buscar();
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

           // DevExpress.Export.ExportSettings.DefaultExportType = DevExpress.Export.ExportType.WYSIWYG;
            //PivotCompra.OptionsView.HideAllTotals();
            //System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //ASPxPivExp1.ExportToXlsx(stream);
            //WriteToResponse("ReporteOrdenCompra.xlsx", true, "vnd.openxmlformats-officedocument.spreadsheetml.sheet", stream);
            //PivotCompra.OptionsView.ShowAllTotals();
            Exportador.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
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
            string PUSuario = "";
            int Cerr = 0;
            string Merr = "OK";
            int ii = 0;
            string PActivar = "S";
            string VUdfText = "";
            string VUdfCB = "";

            try
            {


                LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
                ASPxComboBox CBCiaOri = itemCiaOri.GetNestedControl() as ASPxComboBox;


                LayoutItem itemCuentaIni = Lform.FindItemOrGroupByName("TXCuentaIni") as LayoutItem;
                ASPxTextBox txCuentaIni = itemCuentaIni.GetNestedControl() as ASPxTextBox;

                LayoutItem itemCuentaFin = Lform.FindItemOrGroupByName("TXCuentaFin") as LayoutItem;
                ASPxTextBox txCuentaFin = itemCuentaFin.GetNestedControl() as ASPxTextBox;


                //EjecutarSelectVista("Delete COM_USUARIOS_PERMISOS where USUARIO = '" + CBUsuarios.Value.ToString.ToUpper + "'");
                LayoutItem itemUDF = ASPxFormLayoutGuardar.FindItemOrGroupByName("lista_udf") as LayoutItem;
                ASPxComboBox CBUDF = itemUDF.GetNestedControl() as ASPxComboBox;



                LayoutItem itemLYUDF = ASPxFormLayoutGuardar.FindItemOrGroupByName("DataUdf") as LayoutItem;
                //LayoutItemBase layoutGroupUncast = ASPxFormLayoutGuardar.FindItemOrGroupByName("DataUdf");
                

                foreach (var control in itemLYUDF.Controls)
                {
                    if (control.GetType().ToString().ToUpper().Contains("ASPXTEXTBOX"))
                    {
                        ASPxTextBox txtTemp = (ASPxTextBox)control;
                        VUdfText = txtTemp.Value != null ? txtTemp.Value.ToString() : "";
                    }
                    else
                    {
                        if (control.GetType().ToString().ToUpper().Contains("ASPXCOMBOBOX"))
                        {
                            ASPxComboBox CBUdfdetTemp = (ASPxComboBox)control;
                            VUdfCB = CBUdfdetTemp.Value != null ? CBUdfdetTemp.Value.ToString() : "";
                        }
                    }

                }


              //  LayoutItem itemTextUDF = ASPxFormLayoutGuardar.FindItemOrGroupByName("DataUdf") as LayoutItem;
              //  ASPxTextBox TXUdf = itemTextUDF.GetNestedControl() as ASPxTextBox;



              //  LayoutItem itemCBUDF = ASPxFormLayoutGuardar.FindItemOrGroupByName("DataUdf") as LayoutItem;
              //  ASPxComboBox CBUdfdet = itemCBUDF.GetNestedControl() as ASPxComboBox;




                //  EjecutarborrarMenu(CBUsuarios.Value.ToString().ToUpper());

                EjecutaActualizaCta(CBCiaOri.Value.ToString().ToUpper(), txCuentaIni.Value.ToString(), txCuentaFin.Value.ToString().ToUpper(), CBUDF.Text.ToString(), VUdfText, VUdfCB);
                DS_Cuentas.DataBind();
                GPermisos.DataBind();
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




        private void EjecutaActualizaCta(string PCia, string txCuentaIni, string txCuentaFin, string CBUDF, string TXUdf, string CBUdfdet)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.[dbo].[PORTAL_CUENTACONTABLE_UDF_UPD]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PCIA", PCia);
                command.Parameters.AddWithValue("@PCUENTAINI", txCuentaIni);
                command.Parameters.AddWithValue("@PCUENTAFIN", txCuentaFin);
                command.Parameters.AddWithValue("@PUDFSEL", CBUDF);
                command.Parameters.AddWithValue("@TXUDF", TXUdf);
                command.Parameters.AddWithValue("@CBUDFDET", CBUdfdet);
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





        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
          /*  string PERR = "0";
            string PMerr = "ok";
            string PUser;
            string PCC1 = CBListaAbuelo.Text.Substring(0, 3);
            string PCC2 = CBListaPadre.Text.Substring(0, 3);
            string PCC3 = tbcentrocostohijo.Text;
            PUser = "sa";

            EjecutarCrearCentroCosto(PUser, Session["CBCia24"].ToString(), PCC1, tbnombreabuelo.Text, PCC2, tbnombrepadre.Text, PCC3, tbnombrehijo.Text, out PERR, out PMerr, CHAsocentroCuentas.Value.ToString());

            Pmensaje.Text = PMerr;
            if (PERR.Trim() == "0")
            {
                CBListaAbuelo.Text = null;
                tbnombreabuelo.Text = null;
                CBListaPadre.Text = null;
                tbnombrepadre.Text = null;
                tbcentrocostohijo.Text = null;
                tbnombrehijo.Text = null;

            }

    */

        }

        protected void ASPxCheckBox1_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void Lform_E2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void BTAceptar_Click(object sender, EventArgs e)
        {
            Guardar();
        }

        protected void GPermisos_CellEditorInitialize(object sender, ASPxGridViewEditorEventArgs e)
        {
       //     if (e.Column.FieldName == "CUENTA_CONTABLE")
       //     {
       //         var editor = e.Editor as ASPxComboBox;
       //         editor.ClientInstanceName = "CuentaEditor";
       //         editor.ClientSideEvents.EndCallback = "CuentaCombo_EndCallback";
       //     }

        }

        protected void Lform_E8_Callback(object sender, CallbackEventArgsBase e)
        {

            Session["UDF_SELECCIONADO"] = e.Parameter;
                DS_LISTA_UDF_DET.DataBind();
            Lform_E8.DataBind();
        }

    
    }
}