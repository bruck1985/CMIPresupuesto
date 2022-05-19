using BusinessLogic.Clases;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class AprobacionCambio : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params["id"] != null)
            {
                DataTable dt = new DataTable();
                string id = Request.Params["id"].ToString();
                dt = obtenerActivoCambio(id);
                if (dt!=null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        string estado = dt.Rows[0].ItemArray[4].ToString();
                        if (estado.Equals("P")) //Si el registro se encuentra en estado Registrado
                        {

                            string VconnectionString;
                            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
                            SqlConnection dbSQL = new SqlConnection(VconnectionString);

                            try
                            {
                                if (dbSQL.State != ConnectionState.Open)
                                    dbSQL.Open();

                                string sentencia = "UPDATE PORTAL.dbo.CONF_GESTION_ACTIVO SET ESTADO='A', USUARIO_APROBACION=RESPONSABLE_ORIGINAL, ";
                                sentencia = sentencia + " FECHA_APROBACION=GETDATE() WHERE ID=" + id;
                                SqlCommand ComandoConsulta = new SqlCommand();
                                ComandoConsulta.CommandText = sentencia;
                                ComandoConsulta.Connection = dbSQL;
                                ComandoConsulta.ExecuteNonQuery();
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

                            ActivoBL oActivo = new ActivoBL();
                            string empresa = dt.Rows[0].ItemArray[0].ToString();
                            string ubicacion = dt.Rows[0].ItemArray[9].ToString();
                            string responsable = dt.Rows[0].ItemArray[10].ToString();
                            string tipoAccion = dt.Rows[0].ItemArray[3].ToString();
                            string estadoActivo = dt.Rows[0].ItemArray[11].ToString();
                            string activoFijo = dt.Rows[0].ItemArray[1].ToString();
                            string usuario_creacion = dt.Rows[0].ItemArray[12].ToString();
                            string mejora = dt.Rows[0].ItemArray[2].ToString();

                            /*Se procede a realizar el cambio en la base de datos de Exactus */
                            actualizarAccionExactus(empresa, activoFijo, mejora, tipoAccion, ubicacion, responsable, estadoActivo);

                            oActivo.insertarActivoAccion(empresa, ubicacion, responsable, tipoAccion, estadoActivo, activoFijo, usuario_creacion);

                            LBL_Mensaje.Text = "La solicitud de cambio de Area ha sido aprobada con exito.";
                        }
                        else
                        {
                            if (estado.Equals("R")) //El registro se encuentra rechazado
                            {
                                string usuario_rechazo = dt.Rows[0].ItemArray[7].ToString();
                                string fecha_rechazo = dt.Rows[0].ItemArray[8].ToString();
                                LBL_Mensaje.Text = "La solicitud de cambio de Area ya se encuentra Rechazada por el usuario " + usuario_rechazo + " el dia " + fecha_rechazo ;
                            }
                            else
                            {
                                if (estado.Equals("A")) //El registro se encuentra aprobado
                                {
                                    string usuario_aprobacion = dt.Rows[0].ItemArray[5].ToString();
                                    string fecha_aprobacion = dt.Rows[0].ItemArray[6].ToString();
                                    LBL_Mensaje.Text = "La solicitud de cambio de Area ya se encuentra Aceptada por el usuario " + usuario_aprobacion + " el dia " + fecha_aprobacion;
                                }
                            }
                        }
                    }
                }
            }
        }

        private void actualizarAccionExactus(string empresa, string activo, string mejora, string tipo,string ubicacion,string responsable, string estado)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            SqlConnection dbSQL = new SqlConnection(VconnectionString);
            try
            {
                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();

                string sentencia = "";
                if (tipo.Equals("UBI")) //Si es cambio de area o ubicacion
                {
                    sentencia = "UPDATE Pruebas." + empresa + ".ACTIVO_FIJO SET UBICACION='" + ubicacion + "' WHERE ACTIVO_FIJO='" + activo + "'";
                }
                else
                {
                    if (tipo.Equals("EST")) //Si es cambio de estado
                    {
                        sentencia = "UPDATE Pruebas." + empresa + ".ACTIVO_FIJO SET ESTADO_ACTIVO='" + estado + "' WHERE ACTIVO_FIJO='" + activo + "'";
                    }
                    else
                    {
                        if (tipo.Equals("RESP") || tipo.Equals("RES"))
                        {
                            sentencia = "UPDATE Pruebas." + empresa + ".ACTIVO_MEJORA SET RESPONSABLE='" + responsable + "' WHERE ACTIVO_FIJO='" + activo + "' and MEJORA='" + mejora + "'";
                        }
                    }
                }
                SqlCommand ComandoConsulta = new SqlCommand();
                ComandoConsulta.CommandText = sentencia;
                ComandoConsulta.Connection = dbSQL;
                ComandoConsulta.ExecuteNonQuery();
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
        }

        private DataTable obtenerActivoCambio(string id)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            String VSQL;
            VSQL = "SELECT EMPRESA,CODIGO_ACTIVO,CODIGO_MEJORA, TIPO_ACCION_AF,ESTADO,USUARIO_APROBACION,FECHA_APROBACION,USUARIO_RECHAZO, FECHA_RECHAZO,UBICACION,RESPONSABLE,ESTADO_ACTIVO,RESPONSABLE_ORIGINAL  ";
            VSQL = VSQL + " FROM PORTAL.dbo.CONF_GESTION_ACTIVO WHERE ID= " + id;
            SqlConnection conn = new SqlConnection(VconnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = VSQL;
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            return ds.Tables[0];
        }
    }
}
