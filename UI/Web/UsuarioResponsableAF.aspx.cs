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
    public partial class UsuarioResponsableAF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
            grid_data_exp.WriteXlsxToResponse(new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
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
                ComandoConsulta.CommandText = "SELECT [CodigoResponsableCia] FROM [PORTAL].[dbo].[RESPONSABLE_USUARIO_AF]  where NombreUsuario = '" + CBUsuarios.Value.ToString().ToUpper() + "'";
                ComandoConsulta.Connection = dbSQL;

                GResponsables.Selection.UnselectAll();

                using (SqlDataReader rdr = ComandoConsulta.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        Vmenu = rdr.GetString(0);
                        RowIndice = GResponsables.FindVisibleIndexByKeyValue(Vmenu);
                        GResponsables.Selection.SelectRow(RowIndice);
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
                plist = GResponsables.GetSelectedFieldValues("CODIGO");
                LayoutItem itemCiaOri = Lform.FindItemOrGroupByName("CBUsuario") as LayoutItem;
                ASPxComboBox CBUsuarios = itemCiaOri.GetNestedControl() as ASPxComboBox;

                EjecutarborrarResponsableUsuarios(CBUsuarios.Value.ToString().ToUpper());

                foreach (string item in plist)
                    EjecutarInsertaResponsable(CBUsuarios.Value.ToString().ToUpper(), item);

            }
            catch (Exception ex)
            {
            }
        }

        private void EjecutarborrarResponsableUsuarios(string PUSUARIO)
        {

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.dbo.PORTAL_DELETE_USU_RESP_AF", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PUsuario", PUSUARIO);
                conn.Open();
                command.ExecuteNonQuery();
            }
        }


        private void EjecutarInsertaResponsable(string PUsuario, string PCodigo)
        {
            string[] valores = PCodigo.Split('-');
            string compania = valores[0].ToString();
            string responsable = valores[1].ToString();

            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.dbo.[PORTAL_ADD_RESPONSABLE_AF]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PUsuario", PUsuario);
                command.Parameters.AddWithValue("@PCodigo", PCodigo);
                command.Parameters.AddWithValue("@PEmpresa", compania);
                command.Parameters.AddWithValue("@PResponsable", responsable);
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
