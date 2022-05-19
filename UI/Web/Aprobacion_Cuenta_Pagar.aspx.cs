using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using DevExpress.Export;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace UI.Web
{
    public partial class Aprobacion_Cuenta_Pagar : System.Web.UI.Page
    {
        private string CurrentCiactaID
        {
            get { return Session["CurrentCiactaID"] == null ? String.Empty : Session["CurrentCiactaID"].ToString(); }
            set
            {
                Session["CurrentCiactaID"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ci_sciaACP"] == null)
            {
                Session["ci_sciaACP"] = "ddd ffffff";
                Session["ci_sfec1"] = DateTime.Today.AddMonths(-1).ToString("dd/MM/yyyy");    
                Session["ci_sfec2"] = DateTime.Now.ToString("dd/MM/yyyy");

                ((Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Today.AddMonths(-1);
                ((Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem).GetNestedControl() as ASPxDateEdit).Value = DateTime.Now;
                //((Lform.FindItemOrGroupByName("Cia") as LayoutItem).GetNestedControl() as ASPxComboBox).Value = "%";
                (Lform.FindItemOrGroupByName("Cia") as LayoutItem).Caption = HttpUtility.HtmlDecode("Compañía");
            }
            
        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {
            BuscarDocumentos();
        }

        private void BuscarDocumentos()
        {
            LayoutItem itemFechaInicial = Lform.FindItemOrGroupByName("FechaInicial") as LayoutItem;
            ASPxDateEdit CBFechaInicial = itemFechaInicial.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemFechaFinal = Lform.FindItemOrGroupByName("FechaFinal") as LayoutItem;
            ASPxDateEdit CBFechaFinal = itemFechaFinal.GetNestedControl() as ASPxDateEdit;

            LayoutItem itemCia = Lform.FindItemOrGroupByName("Cia") as LayoutItem;
            ASPxDropDownEdit CBCia = itemCia.GetNestedControl() as ASPxDropDownEdit;

            if (CBFechaInicial != null)
            {
                //Session["ci_scia"] = CBCia.Value != null ? CBCia.Value.ToString() : string.Empty;
                if (CBCia.Value != null)
                {
                    Session["ci_sciaACP"] = CBCia.Value != null ? CBCia.Value.ToString() : "XXX;";
                }
                else
                {
                    Session["ci_sciaACP"] = "XXX XXXXXXXXXX";
                }
                Session["ci_sfec1"] = CBFechaInicial.Value != null ? CBFechaInicial.Date.ToString("dd/MM/yyyy") : string.Empty;
                Session["ci_sfec2"] = CBFechaFinal.Value != null ? CBFechaFinal.Date.ToString("dd/MM/yyyy") : string.Empty;
            }
        }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
        }

        protected void Lform_E3_Click(object sender, EventArgs e)
        {
            AprobarCuentasPorPagar();
        }

        private void AprobarCuentasPorPagar()
        {
            string listaEmpresas;
            listaEmpresas = "";
            string PUSuario = "";
            int Cerr = 0;
            string Merr = "OK";
            int ii = 0;

            try
            {
                List<object> plist;
                plist = grid_data.GetSelectedFieldValues("ID_CUENTA_PAGAR");
                /*Se obtiene todas las empresas distintas que han sido seleccionadas*/
                int contador = 0;
                foreach (string item in plist)
                {
                    string[] valores = item.Split(';');
                    bool existe = false;
                    existe = listaEmpresas.Contains(valores[0]);
                    if (!existe)
                    {
                        if (contador == 0)
                        {
                            listaEmpresas = valores[0];
                            contador = 1;
                        }
                        else
                        {
                            listaEmpresas = listaEmpresas + ";" + valores[0];
                        }
                    }
                }

                string[] empresas = listaEmpresas.Split(';');
                foreach (string empresa in empresas)
                {
                    string VconnectionString;
                    VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;
                    //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
                    SqlConnection dbSQL = new SqlConnection(VconnectionString);
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "PORTAL.dbo.VALIDAR_PERMISO_APROBAR_CP";
                    cmd.Connection = dbSQL;
                    cmd.Parameters.AddWithValue("@PCia", empresa);
                    cmd.Parameters.AddWithValue("@PUsuario", Session["nombreUsuario"].ToString());
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    if (dt.Rows.Count == 0)
                    {
                        ASPxLabel3.Text = "El usuario no cuenta con permiso a la empresa " + empresa + " para poder realizar la aprobación de la cuenta por pagar.";
                        PError.ShowOnPageLoad = true;
                        return;
                    }
                }

                /*Se realiza la aprobación de todos los documentos por Pagar*/
                foreach (string item2 in plist)
                {
                    string[] valores = item2.Split(';');
                    string compania = valores[0].ToString();
                    string proveedor = valores[1].ToString();
                    string documento = valores[2].ToString();
                    string tipo = valores[3].ToString();

                    string VconnectionString;
                    VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPortal"].ConnectionString;
                    //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
                    SqlConnection dbSQL = new SqlConnection(VconnectionString);
                    dbSQL.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "PORTAL.dbo.PORTAL_APROBAR_CP";
                    cmd.Connection = dbSQL;
                    cmd.Parameters.AddWithValue("@PCia", compania);
                    cmd.Parameters.AddWithValue("@PProveedor", proveedor);
                    cmd.Parameters.AddWithValue("@PDocumento", documento);
                    cmd.Parameters.AddWithValue("@PTipo", tipo);
                    cmd.Parameters.AddWithValue("@PUsuario", Session["nombreUsuario"].ToString());
                    cmd.ExecuteNonQuery();
                    dbSQL.Close();
                }

                PAdvertencia.ShowOnPageLoad = true;
                BuscarDocumentos();
            }
            catch (Exception ex)
            {
            }
        }
    }
}
