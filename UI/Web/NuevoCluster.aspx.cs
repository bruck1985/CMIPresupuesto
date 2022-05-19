using DevExpress.Web;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI.Web
{
    public partial class NuevoCluster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ClusterAF.aspx");
        }

        protected void Lform_E3_Click(object sender, EventArgs e)
        {
            LayoutItem LiCluster = FormLayout.FindItemOrGroupByName("LiCluster") as LayoutItem;
            ASPxTextBox txtNombreCluster = LiCluster.GetNestedControl() as ASPxTextBox;

            string cluster = "";
            if (txtNombreCluster != null)
            {
                cluster = txtNombreCluster.Value.ToString();
            }

            LayoutItem LiEstado = FormLayout.FindItemOrGroupByName("LiEstado") as LayoutItem;
            ASPxRadioButtonList rbtnEstado= LiEstado.GetNestedControl() as ASPxRadioButtonList;
            string estado = "";
            if (rbtnEstado != null)
            {
                estado = rbtnEstado.Value.ToString();
            }

            /*Conexión a la BD*/
            string VconnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            SqlConnection dbSQL = new SqlConnection(VconnectionString);
            SqlDataReader MIDataReader;

            try
            {
                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();

                string sentencia = "INSERT INTO Portal.dbo.CLUSTER_AF(NOMBRE_CLUSTER,ESTADO) ";
                sentencia = sentencia + " VALUES('" + cluster.ToUpper() + "'," + estado + ");";
                SqlCommand ComandoConsulta = new SqlCommand();
                ComandoConsulta.CommandText = sentencia;
                ComandoConsulta.Connection = dbSQL;
                ComandoConsulta.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
                //throw;
            }
            finally
            {
                if (dbSQL.State == ConnectionState.Open)
                    dbSQL.Close();
            }

            /*Se obtiene el ultimo id de cluster insertado*/
            try
            {
                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();

                String VSQL;
                VSQL = "SELECT MAX(CLUSTER_ID) FROM PORTAL.dbo.CLUSTER_AF";
                SqlConnection conn = new SqlConnection(VconnectionString);
                SqlDataAdapter da = new SqlDataAdapter();
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = VSQL;
                da.SelectCommand = cmd;
                DataSet ds = new DataSet();
                da.Fill(ds);
                DataTable dt = new DataTable();
                dt = ds.Tables[0];

                int codigoCluster = Convert.ToInt32(dt.Rows[0].ItemArray[0].ToString());

                /*Se inserta las compañias asociadas al Cluster Registrado*/

                List<object> plist;
                ArrayList totalVals = new ArrayList();
                plist = GPermisos.GetSelectedFieldValues("CONJUNTO");

                EjecutarborrarCompaniasCluster(codigoCluster.ToString());

                foreach (string item in plist)
                    EjecutarInsertaDetalleCluster(codigoCluster.ToString(), item);

            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
            }
            finally
            {
                if (dbSQL.State == ConnectionState.Open)
                    dbSQL.Close();
            }
            Response.Redirect("ClusterAF.aspx");
        }

        private void EjecutarborrarCompaniasCluster(string pCluster)
        {

            string VconnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.dbo.PORTAL_DELETE_DETALLE_CLUSTER", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PCluster", pCluster);
                conn.Open();
                command.ExecuteNonQuery();
            }
        }

        private void EjecutarInsertaDetalleCluster(string PCluster, string PCodigo)
        {
            string VconnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;

            using (var conn = new SqlConnection(VconnectionString))
            using (var command = new SqlCommand("PORTAL.dbo.[PORTAL_ADD_DETALLE_CLUSTER]", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.AddWithValue("@PCluster", PCluster);
                command.Parameters.AddWithValue("@PCodigo", PCodigo);
                conn.Open();
                command.ExecuteNonQuery();
            }
        }
    }
}
