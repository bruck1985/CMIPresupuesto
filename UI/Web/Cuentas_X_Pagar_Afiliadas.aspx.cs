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
    public partial class Cuentas_X_Pagar_Afiliadas : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                Session["ci_scia1"] = null;
                Session["ci_scia12"] = null;
            }
        }



        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {
            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            ASPxComboBox CBCiaOri = itemCiaOri.GetNestedControl() as ASPxComboBox;

            LayoutItem itemCiaDest = Lform.FindItemOrGroupByName("CiaDestino") as LayoutItem;
            ASPxComboBox CBCiaDest = itemCiaDest.GetNestedControl() as ASPxComboBox;

            if (CBCiaOri.Value != null)
            {
                Session["ci_scia1"] = CBCiaOri.Value != null ? CBCiaOri.Value.ToString() : "XXX YYYYYYYY;";
                Session["ci_scia12"] = CBCiaDest.Value != null ? CBCiaDest.Value.ToString() : CBCiaOri.Value != null ? CBCiaOri.Value.ToString() : "XXX YYYYYYYY;";
                SQLGetMapeos.DataBind();
                SQLGetCtasBancos.DataBind();
                SQLGetCtasCC.DataBind();
                GPermisos.DataBind();
                GPermisos1.DataBind();

            }
            else
            {
                Session["ci_scia1"] = "XXX XXXXXXXXXX";
            }

            UpdateTotalCP.Update();
        }



        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            ASPxGridViewExporter1.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
        }

        protected void SQLCompras_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        private void Ejecutar(string cia, string proveedor, string tipo_documento, string documento, string cuenta_cheque, string monto_a_pagar, string tipo_cambio)
        {
            try
            {
                string VconnectionString;
                VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebasPortal"].ConnectionString;

                using (var conn = new SqlConnection(VconnectionString))
                using (var command = new SqlCommand("PORTAL_CXP_SET_PAGO_AFILIADAS", conn)
                {
                    CommandType = CommandType.StoredProcedure
                })
                {
                    command.Parameters.AddWithValue("@CIA", cia);
                    command.Parameters.AddWithValue("@PROVEEDOR", proveedor);
                    command.Parameters.AddWithValue("@TIPO_DOCUMENTO", tipo_documento);
                    command.Parameters.AddWithValue("@DOCUMENTO", documento);
                    command.Parameters.AddWithValue("@CUENTA_CHEQUE", cuenta_cheque);
                    command.Parameters.AddWithValue("@MONTO_PAGO", monto_a_pagar);
                    command.Parameters.AddWithValue("@TIPO_CAMBIO", tipo_cambio);
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


        private void EjecutarDestino(string cia, string cliente, string tipo_documento, string documento, string cuenta_cheque, string monto_a_pagar, string tipo_cambio)
        {
            try
            {
                string VconnectionString;
                VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebasPortal"].ConnectionString;

                using (var conn = new SqlConnection(VconnectionString))
                using (var command = new SqlCommand("PORTAL_CXC_SET_PAGO_AFILIADAS", conn)
                {
                    CommandType = CommandType.StoredProcedure
                })
                {
                    command.Parameters.AddWithValue("@CIA", cia);
                    command.Parameters.AddWithValue("@CLIENTE", cliente);
                    command.Parameters.AddWithValue("@TIPO_DOCUMENTO", tipo_documento);
                    command.Parameters.AddWithValue("@DOCUMENTO", documento);
                    command.Parameters.AddWithValue("@CUENTA_CHEQUE", cuenta_cheque);
                    command.Parameters.AddWithValue("@MONTO_PAGO", monto_a_pagar);
                    command.Parameters.AddWithValue("@TIPO_CAMBIO", tipo_cambio);
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

            LayoutItem itemCiaDes = Lform.FindItemOrGroupByName("CiaDestino") as LayoutItem;
            ASPxComboBox CBCiaDes = itemCiaDes.GetNestedControl() as ASPxComboBox;

            LayoutItem itemCtaCiaOri = Lform.FindItemOrGroupByName("CtaBanco") as LayoutItem;
            ASPxComboBox CBCtaCiaOri = itemCtaCiaOri.GetNestedControl() as ASPxComboBox;

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
                        Ejecutar(CBCiaOri.Value.ToString(), dt.Rows[i]["PROVEEDOR"].ToString(), dt.Rows[i]["TIPO"].ToString(), dt.Rows[i]["DOCUMENTO"].ToString(), CBCtaCiaOri.Value.ToString(), txt_Monto_Pagar.Text, Tipo_Cambio_CL.Value.ToString()) ;
                        //EjecutarDestino(CBCtaCiaOri.Value.ToString(), dt.Rows[i]["PROVEEDOR"].ToString(), dt.Rows[i]["TIPO"].ToString(), dt.Rows[i]["DOCUMENTO"].ToString(), CBCtaCiaOri.Value.ToString(), tb_Monto_a_pagar.Value.ToString());
                    }

                }


            }
            catch (Exception ex)
            {
            }
        }

        private void Guardar2()
        {

            LayoutItem itemCiaDes = Lform.FindItemOrGroupByName("CiaDestino") as LayoutItem;
            ASPxComboBox CBCiaDes = itemCiaDes.GetNestedControl() as ASPxComboBox;

            LayoutItem itemCtaCiaDes = Lform.FindItemOrGroupByName("CtaBancoDestino") as LayoutItem;
            ASPxComboBox CBCtaCiaDes = itemCtaCiaDes.GetNestedControl() as ASPxComboBox;

            DataTable dt = new DataTable();
            foreach (GridViewColumn column in GPermisos1.VisibleColumns)
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
            for (int i = 0; i < GPermisos1.VisibleRowCount; i++)
            {
                DataRow row = dt.NewRow();
                foreach (GridViewColumn column in GPermisos1.VisibleColumns)
                {
                    var col = column as GridViewDataColumn;
                    if (col != null)
                    {
                        var cellValue = GPermisos1.GetRowValues(i, col.FieldName);
                        row[col.FieldName] = cellValue;
                    }
                    var col2 = column as GridViewCommandColumn;
                    if (GPermisos1.Selection.IsRowSelected(i) && (col2 != null))
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
                        //Ejecutar(CBCiaOri.Value.ToString(), dt.Rows[i]["PROVEEDOR"].ToString(), dt.Rows[i]["TIPO"].ToString(), dt.Rows[i]["DOCUMENTO"].ToString(), CBCtaCiaOri.Value.ToString(), tb_Monto_a_pagar.Value.ToString(), Tipo_Cambio_CL.Value.ToString());
                        EjecutarDestino(CBCiaDes.Value.ToString(), dt.Rows[i]["CLIENTE"].ToString(), dt.Rows[i]["TIPO"].ToString(), dt.Rows[i]["DOCUMENTO"].ToString(), CBCtaCiaDes.Value.ToString(), txt_Monto_Pagar.Text, Tipo_Cambio_CL.Value.ToString());
                    }

                }


                SQLGetMapeos.DataBind();
                GPermisos.DataBind();

                SQLGetCtasCC.DataBind();

                GPermisos1.DataBind();
            }
            catch (Exception ex)
            {
            }
        }

        protected void Lform_E3_Click(object sender, EventArgs e)

        {
            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CiaOrigen") as LayoutItem;
            ASPxComboBox CBCiaOri = itemCiaOri.GetNestedControl() as ASPxComboBox;

            LayoutItem itemCiaDes = Lform.FindItemOrGroupByName("CiaDestino") as LayoutItem;
            ASPxComboBox CBCiaDes = itemCiaDes.GetNestedControl() as ASPxComboBox;

            LayoutItem itemCtaCiaDes = Lform.FindItemOrGroupByName("CtaBancoDestino") as LayoutItem;
            ASPxComboBox CBCtaCiaDes = itemCtaCiaDes.GetNestedControl() as ASPxComboBox;

            LayoutItem itemCtaCiaOri = Lform.FindItemOrGroupByName("CtaBanco") as LayoutItem;
            ASPxComboBox CBCtaCiaOri = itemCtaCiaOri.GetNestedControl() as ASPxComboBox;

            if ((txt_Monto_Pagar.Text != "")  && (txt_Monto_Pagar.Text != "") && (CBCiaDes.SelectedIndex != -1) && (CBCtaCiaDes.SelectedIndex != -1) && (CBCiaOri.SelectedIndex != -1) && (CBCtaCiaOri.SelectedIndex != -1))
            {
                if (Convert.ToDecimal(GPermisos.GetTotalSummaryValue(GPermisos.TotalSummary["SALDO"])) > 0 && Convert.ToDecimal(GPermisos1.GetTotalSummaryValue(GPermisos1.TotalSummary["SALDO"]))  > 0)
                {
                    Guardar();
                    Guardar2();
                    string script = "alert('Registro Exitoso');";

                    ScriptManager.RegisterStartupScript(this, typeof(System.Web.UI.Page), "alerta", script, true);
                }
                else
                {
                    string script = "alert('Revisar datos');";

                    ScriptManager.RegisterStartupScript(this, typeof(System.Web.UI.Page), "alerta", script, true);
                }

            }

        }

        protected void Lform_E2_Click(object sender, EventArgs e)
        {

        }

        protected void GPermisos_SelectionChanged(object sender, EventArgs e)
        {
            GPermisos.DataBind();
            UpdateTotalCP.Update();
            //txt_Monto_Pagar.Value = GPermisos.GetTotalSummaryValue(GPermisos.TotalSummary["SALDO"]).ToString();
            //txt_Monto_Pagar.Text = GPermisos.GetTotalSummaryValue(GPermisos.TotalSummary["SALDO"]).ToString();
            txt_Monto_Pagar1.Value = (Convert.ToDecimal(txt_Monto_Pagar.Value) * Convert.ToDecimal(Tipo_Cambio_CL.Text)).ToString("N2");
            txt_Monto_Pagar1.Text = (Convert.ToDecimal(txt_Monto_Pagar.Value) * Convert.ToDecimal(Tipo_Cambio_CL.Text)).ToString("N2");
        }

        protected void GPermisos_CustomSummaryCalculate(object sender, DevExpress.Data.CustomSummaryEventArgs e)
        {
            ASPxSummaryItem summary = e.Item as ASPxSummaryItem;
            if (summary.FieldName != "SALDO")
                return;
            decimal totalValue = 0;
            if (e.IsTotalSummary)
            {
                foreach (object value in GPermisos.GetSelectedFieldValues("SALDO"))
                {
                    totalValue += Convert.ToDecimal(value);
                }
                e.TotalValue = totalValue;
                e.TotalValueReady = true;
            }
            UpdateTotalCP.Update();
            //txt_Monto_Pagar.Value = totalValue.ToString("N2");
            //txt_Monto_Pagar.Text = totalValue.ToString("N2");
            txt_Monto_Pagar1.Value = (Convert.ToDecimal(txt_Monto_Pagar.Value) * Convert.ToDecimal(Tipo_Cambio_CL.Text)).ToString("N2");
            txt_Monto_Pagar1.Text = (Convert.ToDecimal(txt_Monto_Pagar.Value) * Convert.ToDecimal(Tipo_Cambio_CL.Text)).ToString("N2");
        }

        protected void GPermisos1_CustomSummaryCalculate(object sender, DevExpress.Data.CustomSummaryEventArgs e)
        {
            ASPxSummaryItem summary = e.Item as ASPxSummaryItem;
            if (summary.FieldName != "SALDO")
                return;
            decimal totalValue = 0;
            if (e.IsTotalSummary)
            {
                foreach (object value in GPermisos1.GetSelectedFieldValues("SALDO"))
                {
                    totalValue += Convert.ToDecimal(value);
                }
                e.TotalValue = totalValue;
                e.TotalValueReady = true;
            }
        }

        protected void GPermisos1_SelectionChanged(object sender, EventArgs e)
        {
            GPermisos1.DataBind();

        }

        protected void GPermisos_DataBound(object sender, EventArgs e)
        {
            UpdateTotalCP.Update();
            //txt_Monto_Pagar.Value = GPermisos.GetTotalSummaryValue(GPermisos.TotalSummary["SALDO"]).ToString();
            //txt_Monto_Pagar.Text = GPermisos.GetTotalSummaryValue(GPermisos.TotalSummary["SALDO"]).ToString();
            txt_Monto_Pagar1.Value = (Convert.ToDecimal(txt_Monto_Pagar.Value) * Convert.ToDecimal(Tipo_Cambio_CL.Text)).ToString("N2");
            txt_Monto_Pagar1.Text = (Convert.ToDecimal(txt_Monto_Pagar.Value) * Convert.ToDecimal(Tipo_Cambio_CL.Text)).ToString("N2");

        }

        protected void txt_Monto_Pagar_ValueChanged(object sender, EventArgs e)
        {
            txt_Monto_Pagar1.Value = (Convert.ToDecimal(txt_Monto_Pagar.Value) * Convert.ToDecimal(Tipo_Cambio_CL.Text)).ToString("N2");
            txt_Monto_Pagar1.Text = (Convert.ToDecimal(txt_Monto_Pagar.Value) * Convert.ToDecimal(Tipo_Cambio_CL.Text)).ToString("N2");
        }
    }
}
