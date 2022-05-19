using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilitarios.Clases;

namespace DataAccess.Clases
{
    public class ActivoDA
    {
        private SqlConnection oConexion;
        private SqlCommand oComando;
        private string strConexion;

        public ActivoDA()
        {
            ClsTraductor clsT = new ClsTraductor();
            //strConexion = clsT.TradPass(ConfigurationManager.AppSettings.Get("ConexionSQL").ToString());
            strConexion = clsT.TradPass(ConfigurationManager.AppSettings.Get("ConexionSQLPortal").ToString());
        }

        public Activo obtenerActivo(string pEmpresa, string codActivo, string codMejora)
        {
            Activo oActivo = new Activo();
            string strQuery = string.Empty;
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_OBTENER_ACTIVO", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@PCia", pEmpresa);
                oComando.Parameters.AddWithValue("@PActivo", codActivo);
                oComando.Parameters.AddWithValue("@PMejora", codMejora);
                dtrResult = oComando.ExecuteReader();
                dtResult.Load(dtrResult);
                if (dtResult.Rows.Count == 0)
                {
                    return null;
                }

                foreach (DataRow dtrFila in dtResult.Rows)
                {
                    oActivo = new Activo();
                    oActivo.CodActivo = dtrFila["ACTIVO"].ToString();
                    oActivo.NombreActivo = dtrFila["DESCRIPCION_ACTIVO"].ToString();
                    oActivo.Ubicacion = dtrFila["UBICACION"].ToString();
                    oActivo.EstadoActivo = dtrFila["ESTADO_ACTIVO"].ToString();
                    oActivo.Empresa = dtrFila["CIA"].ToString();
                    oActivo.CodActivoMejora = dtrFila["ACTIVO_MEJORA"].ToString();
                    oActivo.NombreActivoMejora = dtrFila["DESCRIPCION_MEJORA"].ToString();
                    oActivo.Responsable = dtrFila["RESPONSABLE"].ToString();
                    oActivo.NombreResponsable = dtrFila["NOMBRE_RESPONSABLE"].ToString();
                    oActivo.FechaInventario = dtrFila["FECHA_INVENTARIO"].ToString();
                    oActivo.NombreEmpresa = dtrFila["NOMBRE_CIA"].ToString();
                    oActivo.NombreUbicacion = dtrFila["NOMBRE_AREA"].ToString();
                }
                return oActivo;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                oConexion.Close();
            }
        }

        public DataTable obtenerActivoMejora(string pEmpresa, string codActivo, string codMejora)
        {
            Activo oActivo = new Activo();
            string strQuery = string.Empty;
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_GET_ACTIVO", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@pesquema", pEmpresa);
                oComando.Parameters.AddWithValue("@PActivo", codActivo);
                oComando.Parameters.AddWithValue("@PMejora", codMejora);
                dtrResult = oComando.ExecuteReader();
                dtResult.Load(dtrResult);
                if (dtResult.Rows.Count == 0)
                {
                    return null;
                }
                else
                {
                    return dtResult;
                }
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                oConexion.Close();
            }
        }

        public void insertarActivoAccion(string empresa,string ubicacion,string responsable, string tipoAccion,string estadoActivo,string activoFijo, string usuarioCreacion)
        {
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("PORTAL_INS_ACTIVO_ACCION", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@PCia", empresa);
                oComando.Parameters.AddWithValue("@PUbicacion", ubicacion);
                oComando.Parameters.AddWithValue("@PResponsable", responsable);
                oComando.Parameters.AddWithValue("@PTipoAccionAF", tipoAccion);
                oComando.Parameters.AddWithValue("@PEstadoActivo", estadoActivo);
                oComando.Parameters.AddWithValue("@ActivoFijo", activoFijo);
                oComando.Parameters.AddWithValue("@PUsuarioCreacion", usuarioCreacion);
                oComando.ExecuteReader();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                oConexion.Close();
            }
        }
    }
}
