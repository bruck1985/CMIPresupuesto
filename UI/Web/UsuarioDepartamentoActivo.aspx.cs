using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.Export;
using DevExpress.XtraPrinting;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Collections;

namespace UI.Web
{
    public partial class UsuarioDepartamentoActivo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Session["usuarioConsulta"] = "0";
            }
        }

        protected void ASPxFormLayout1_E3_Click(object sender, EventArgs e)
        {

            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
            ASPxComboBox CBUsuarios = itemCiaOri.GetNestedControl() as ASPxComboBox;
            if (CBUsuarios != null)
            {
                if (CBUsuarios.Value != null)
                {
                    Session["CBUsuario"] = CBUsuarios.Value != null ? CBUsuarios.Value.ToString() : "XXX;";
                    Session["usuarioConsulta"] = Session["CBUsuario"];
                    Buscar();
                }
                else
                {
                    Session["CBUsuario"] = "X";
                    Session["usuarioConsulta"] = "0";
                }
            }
        }

        protected void ASPxFormLayout1_E3_ClickExc(object sender, EventArgs e)
        {
            grid_data_exp_excel.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
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

        private void Buscar()
        {
            string Vmenu;
            LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
            ASPxComboBox CBUsuarios = itemCiaOri.GetNestedControl() as ASPxComboBox;
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            SqlConnection dbSQL = new SqlConnection(VconnectionString);

            SqlDataReader MIDataReader;
            int Cerr = 0;
            string Merr = "OK";
            int RowIndice;
            try
            {

                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();
                
                SqlCommand ComandoConsulta = new SqlCommand();
                ComandoConsulta.CommandText = "SELECT [CodigoDepartamentoCia] FROM [PORTAL].[dbo].[Departamento_Usuario_AF]  where NombreUsuario = '" + CBUsuarios.Value.ToString().ToUpper() + "'";
                ComandoConsulta.Connection = dbSQL;

                GPermisos.Selection.UnselectAll();

                using (SqlDataReader rdr = ComandoConsulta.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        Vmenu = rdr.GetString(0);
                        RowIndice = GPermisos.FindVisibleIndexByKeyValue(Vmenu);
                        GPermisos.Selection.SelectRow(RowIndice);
                    }
                }
                ComandoConsulta = null/* TODO Change to default(_) if this is not a reference type */;
            }
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

            try
            {
                List<object> plist;
                ArrayList totalVals = new ArrayList();
                plist = GPermisos.GetSelectedFieldValues("CODIGO");
                LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
                ASPxComboBox CBUsuarios = itemCiaOri.GetNestedControl() as ASPxComboBox;

                EjecutarborrarDepartamentoUsuarios(CBUsuarios.Value.ToString().ToUpper());

                foreach (string item in plist)
                    EjecutarInsertaDepartamento(CBUsuarios.Value.ToString().ToUpper(), item);

            }
            catch (Exception ex)
            {
            }
        }

        private void EjecutarborrarDepartamentoUsuarios(string PUSUARIO)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.dbo.PORTAL_DELETE_USU_DEPAT_AF", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PUsuario", PUSUARIO);
                conn.Open();
                command.ExecuteNonQuery();
            }


        }


        private void EjecutarInsertaDepartamento(string PUsuario, string PCodigo)
        {
            string[] valores = PCodigo.Split('-');
            string compania = valores[0].ToString();
            string departamento = "";
            int tamanio = valores.Length;
            if (tamanio==2)
            {
                departamento = valores[1].ToString();
            }
            else
            {
                for (int i = 1; i < tamanio; i++)
                {
                    if (i==1)
                    {
                        departamento = valores[i].ToString();
                    }
                    else
                    {
                        departamento = departamento + "-" + valores[i].ToString();
                    }
                }
            }

            string nombreDepartamento = ObtenerNombreDepartamento(compania, departamento);
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.dbo.[PORTAL_ADD_DEPARTAMENTO_AF]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PUsuario", PUsuario);
                command.Parameters.AddWithValue("@PCodigo", PCodigo);
                command.Parameters.AddWithValue("@PEmpresa", compania);
                command.Parameters.AddWithValue("@PDepartamento", departamento);
                command.Parameters.AddWithValue("@PNombreDepartamento", nombreDepartamento.ToUpper());
                conn.Open();
                command.ExecuteNonQuery();
            }
        }

        private string ObtenerNombreDepartamento(string empresa, string codigoDepartamento)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            SqlConnection dbSQL = new SqlConnection(VconnectionString);
            string nombreDepartamento="";
            try
            {

                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();

                SqlCommand ComandoConsulta = new SqlCommand();
                ComandoConsulta.CommandText = "SELECT DESCRIPCION FROM PRUEBAS." + empresa + ".UBICACION WHERE UBICACION='" + codigoDepartamento + "'";
                ComandoConsulta.Connection = dbSQL;

                using (SqlDataReader rdr = ComandoConsulta.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        nombreDepartamento = rdr.GetString(0);
                    }
                }
                ComandoConsulta = null;
                return nombreDepartamento;
            }
            catch (Exception ex)
            {
            }
            finally
            {
                if (dbSQL.State == ConnectionState.Open)
                    dbSQL.Close();
            }
            return nombreDepartamento;
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
