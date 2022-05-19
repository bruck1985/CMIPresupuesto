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
    public partial class EditarCluster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.Params["id"] != null)
                {
                    string VconnectionString;
                    string codigo = Request.Params["id"].ToString();
                    VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
                    //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
                    SqlConnection dbSQL = new SqlConnection(VconnectionString);
                    DataTable dt = new DataTable();
                    try
                    {
                        if (dbSQL.State != ConnectionState.Open)
                            dbSQL.Open();

                        String VSQL;
                        VSQL = "SELECT CLUSTER_ID, NOMBRE_CLUSTER, ESTADO FROM PORTAL.dbo.CLUSTER_AF WHERE CLUSTER_ID=" + codigo;
                        SqlConnection conn = new SqlConnection(VconnectionString);
                        SqlDataAdapter da = new SqlDataAdapter();
                        SqlCommand cmd = conn.CreateCommand();
                        cmd.CommandText = VSQL;
                        da.SelectCommand = cmd;
                        DataSet ds = new DataSet();
                        da.Fill(ds);
                        dt = ds.Tables[0];

                        hdCluster["hidden_value"] = dt.Rows[0].ItemArray[0].ToString();
                        txtNombreCluster.Text = dt.Rows[0].ItemArray[1].ToString();
                        rbtEstado.Value = dt.Rows[0].ItemArray[2].ToString();

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

                    Session["ci_cluster"] = dt.Rows[0].ItemArray[0].ToString();
                    SQLCompania.DataBind();

                    /*Se asigna las compañias que estan asociadas al cluster*/
                    if (dbSQL.State != ConnectionState.Open)
                        dbSQL.Open();
                    SqlCommand ComandoConsulta = new SqlCommand();
                    ComandoConsulta.CommandText = "SELECT [CIA] FROM [PORTAL].[dbo].[DETALLE_CLUSTER_AF]  where CLUSTER_ID = " + codigo;
                    ComandoConsulta.Connection = dbSQL;

                    GPermisos.Selection.UnselectAll();
                    string vcia;
                    int RowIndice;
                    using (SqlDataReader rdr = ComandoConsulta.ExecuteReader())
                    {
                        while (rdr.Read())
                        {
                            vcia = rdr.GetString(0);
                            RowIndice = GPermisos.FindVisibleIndexByKeyValue(vcia);
                            GPermisos.Selection.SelectRow(RowIndice);
                        }
                    }

                }
            }
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
            ASPxRadioButtonList rbtnEstado = LiEstado.GetNestedControl() as ASPxRadioButtonList;
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

            string idCluster = hdCluster.Get("hidden_value").ToString();
            
            try
            {
                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();

                string sentencia = "UPDATE Portal.dbo.CLUSTER_AF SET NOMBRE_CLUSTER='" + cluster.ToUpper() + "', ESTADO= " + estado.ToString() + " ";
                sentencia = sentencia + " WHERE CLUSTER_ID=" + idCluster;
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

                /*Se inserta las compañias asociadas al Cluster Registrado*/
                List<object> plist;
                ArrayList totalVals = new ArrayList();
                plist = GPermisos.GetSelectedFieldValues("CONJUNTO");

                EjecutarborrarCompaniasCluster(idCluster.ToString());

                foreach (string item in plist)
                    EjecutarInsertaDetalleCluster(idCluster.ToString(), item);

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
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ClusterAF.aspx");
        }
    }
}
