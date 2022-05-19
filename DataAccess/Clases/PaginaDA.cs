using System;
using System.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilitarios.Clases;

using System.Web;

namespace DataAccess.Clases
{
    public class PaginaDA
    {
        private SqlConnection oConexion;
        private SqlCommand oComando;
        private string strConexion;

        public PaginaDA(){

            /// El string de conexion esta en el web.config de MenuDashboard, porque el configurarionManager toma
            /// el .config de donde esta siendo llamando, no de donde esta localizado
            /// Referencia : https://social.msdn.microsoft.com/Forums/lync/en-US/5fcfb8b6-4c6d-4b0d-8bcb-8c18e76f42d3/referencia-a-objeto-no-establecida-como-instancia-de-un-objeto?forum=vcses
           
           // strConexion = ConfigurationManager.AppSettings.Get("ConexionSQL").ToString();
            //Data Source=10.90.124.16\sql2008;Initial Catalog=Dashboard;User Id=test;Password=test;

            ClsTraductor clsT = new ClsTraductor();
            strConexion = clsT.TradPass(ConfigurationManager.AppSettings.Get("ConexionSQL").ToString());

        }

        /// <summary>
        /// Toma el contenido de la base de datos perteneciente al menu o submenu seleccionado
        /// </summary>
        /// <author>Stiven Sánchez Rodríguez</author>
        /// <param name="pPermiso"></param>
        /// <returns></returns>
        public Pagina obtenerContenido(string pPermiso) {
            Pagina oInformacion = new Pagina();
            try {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("ObtenerContenidoMenu", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@Permiso", pPermiso);

                
                
                //(int)Session["idEmpresa"]
                //if ( System.Web.htt Session["idEmpresa"] != null)
                //{
                    
                //}

                //oComando.Parameters.Add("@IdEmpresa", pPermiso);


                SqlDataReader dtrResultado = oComando.ExecuteReader();
                DataTable dtResultado = new DataTable();

                dtResultado.Load(dtrResultado);

                if (dtResultado.Rows.Count == 0) {
                    return null;
                }

                DataRow dtrFila = dtResultado.Rows[0];
                oInformacion.ContenidoPag = dtrFila["Contenido"].ToString();
                oInformacion.UserDB = dtrFila["UserDatabase"].ToString();
                oInformacion.PassDB = dtrFila["PassDatabase"].ToString();

                return oInformacion;
            }
            catch (Exception) { return null; }
            finally { oConexion.Close(); }
        }


        //--------------------------------------------------------------

        public Pagina obtenerInformacionMenuContenido(string pPermiso, int IntIdEmpresa, string ModoVisual)
        {
            Pagina oInformacion = new Pagina();
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("obtenerInformacionMenuContenido", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@Permiso", pPermiso);
                oComando.Parameters.AddWithValue("@IdEmpresa", IntIdEmpresa);
                oComando.Parameters.AddWithValue("@ModiVisual", ModoVisual);

                SqlDataReader dtrResultado = oComando.ExecuteReader();
                DataTable dtResultado = new DataTable();

                dtResultado.Load(dtrResultado);

                if (dtResultado.Rows.Count == 0)
                {
                    return null;
                }

                DataRow dtrFila = dtResultado.Rows[0];
                oInformacion.ContenidoPag = dtrFila["Contenido"].ToString();
                oInformacion.UserDB = dtrFila["UserDatabase"].ToString();
                oInformacion.PassDB = dtrFila["PassDatabase"].ToString();

                return oInformacion;
            }
            catch (Exception) { return null; }
            finally { oConexion.Close(); }
        }
        
        
        
        //-

         public Pagina obtenerContenidoPorIdEmpY_IdPerm(string pPermiso, int IntIdEmp) {
            Pagina oInformacion = new Pagina();
            try {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("obtenerContenidoMenuPorIdEmpY_IdPerm", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@Permiso", pPermiso);
                oComando.Parameters.AddWithValue("@IdEmpresa", IntIdEmp);


                SqlDataReader dtrResultado = oComando.ExecuteReader();
                DataTable dtResultado = new DataTable();

                dtResultado.Load(dtrResultado);

                if (dtResultado.Rows.Count == 0) {
                    return null;
                }

                DataRow dtrFila = dtResultado.Rows[0];
                oInformacion.ContenidoPag = dtrFila["Contenido"].ToString();
                oInformacion.UserDB = dtrFila["UserDatabase"].ToString();
                oInformacion.PassDB = dtrFila["PassDatabase"].ToString();

                return oInformacion;
            }
            catch (Exception) { return null; }
            finally { oConexion.Close(); }
        }


        //------------------------------------------------------------


        /// <summary>
        /// Obtiene el código del permiso para el dashboard por defecto
        /// </summary>
        public string obtenerPermisoDefecto(int pIdEmpresa, int pIdUsuario) {
            string oPermiso = "";
            string query = string.Format("SELECT dashboardDefecto FROM Usuario_Empresa WHERE codigoUsuario = {0} AND codigoEmpresa = {1}",pIdUsuario,pIdEmpresa);
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand(query, oConexion);
                oComando.CommandType = CommandType.Text;                

                SqlDataReader dtrResultado = oComando.ExecuteReader();
                DataTable dtResultado = new DataTable();

                dtResultado.Load(dtrResultado);

                if (dtResultado.Rows.Count == 0)
                {
                    return null;
                }

                DataRow dtrFila = dtResultado.Rows[0];
                oPermiso = dtrFila["dashboardDefecto"].ToString();

                return oPermiso;
            }
            catch (Exception) { return null; }
            finally { oConexion.Close(); }
        }

    }
}
