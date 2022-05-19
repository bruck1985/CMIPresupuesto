using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;
using System.IO;

using System.Configuration;

using Utilitarios.Clases;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Data.Common;
using System.Data;
using System.Security;
using System.Net;

namespace DataAccess.Clases
{
    public class UsuarioDA
    {

        private SqlConnection oConexion;
        private SqlConnection oConexion2;

        private SqlCommand    oComando;
        private string        strConexion;

        public UsuarioDA() {

            /// El string de conexion esta en el web.config de MenuDashboard, porque el configurarionManager toma
            /// el .config de donde esta siendo llamando, no de donde esta localizado
            /// Referencia : https://social.msdn.microsoft.com/Forums/lync/en-US/5fcfb8b6-4c6d-4b0d-8bcb-8c18e76f42d3/referencia-a-objeto-no-establecida-como-instancia-de-un-objeto?forum=vcses
          
            //strConexion = ConfigurationManager.AppSettings.Get("ConexionSQL").ToString();
            ClsTraductor clsT = new ClsTraductor();
            strConexion = clsT.TradPass(ConfigurationManager.AppSettings.Get("ConexionSQL").ToString());

           // strConexion = ConfigurationManager.AppSettings.Get("ConexionSQL").ToString();
        }

        /// <summary>
        /// Toma de la base el usuario cuyos parametros sean iguales a los 
        /// ingresados
        /// </summary>
        /// <author>Stiven Sánchez Rodríguez</author>
        /// <param name="pUsuario"></param>
        /// <param name="pPassword"></param>
        /// <returns></returns>
        public Usuario Logueo(string pUsuario, string pPassword)
        {
            Usuario oUsuario = new Usuario();
            string strNumeroLicencias = ConfigurationManager.AppSettings.Get("CoordinacionMenu").ToString();
            Serializador oSerializador = new Serializador();
            int intNumeroLicencias = Int32.Parse(oSerializador.deserializacionString(strNumeroLicencias));

            //SecureString theSecureString = new NetworkCredential("", pPassword).SecurePassword;

            //SqlCredential VCredenciales = new SqlCredential(pUsuario, theSecureString);


            SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(strConexion);
            builder.Password = (new Serializador().deserializacionString(pPassword));
            builder.UserID = pUsuario;
            builder.InitialCatalog = "PORTAL";

            try
            {

                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("Login", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;
                oComando.Parameters.AddWithValue("@Nombre", pUsuario);
                oComando.Parameters.AddWithValue("@Pass", pPassword);
                oComando.Parameters.AddWithValue("@Licencias", intNumeroLicencias);
                oComando.Parameters.Add("@Mensaje", SqlDbType.VarChar, 256);
                oComando.Parameters["@Mensaje"].Direction = ParameterDirection.Output;

                oComando.ExecuteNonQuery();
                
                oUsuario.codUsuario = oComando.Parameters["@Mensaje"].Value.ToString();
                oUsuario.StrError = string.Empty;
                try
                {
                    oConexion2 = new SqlConnection(builder.ConnectionString);
                    oConexion2.Open();
                }
                catch (Exception ex2)
                {
                    oUsuario.StrError = "Usuario o Clave invalida"; //ex2.Message.ToString();
                    return oUsuario;
                }
                finally
                {
                    oConexion2.Close();
                }

                return oUsuario;
            }
            catch (Exception ex)
            {
                oUsuario.StrError = "Usuario o Clave invalida";    //ex.Message.ToString();
                return oUsuario;
            }
            finally
            {
                oConexion.Close();
            }
        }

        /// <summary>
        /// Toma el nombre de las empresas pertenecientes al usuario ingresado como parametro
        /// </summary>
        /// <author>Stiven Sánchez Rodríguez</author>
        /// <param name="pIdUsuario"></param>
        /// <returns></returns>
        public Usuario obtenerEmpresas(int pIdUsuario)
        {

            Usuario oUsuario = new Usuario();
            string strQuery = string.Empty;
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();

            try {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand("mostrarEmpresas", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;

                oComando.Parameters.AddWithValue("@idUsuario", pIdUsuario);

                dtrResult = oComando.ExecuteReader();

                dtResult.Load(dtrResult);

                if (dtResult.Rows.Count == 0) {
                    return null;
                }

                foreach (DataRow dtrFila in dtResult.Rows) {
                    Empresa oEmpresa= new Empresa();
                    oEmpresa.Nombre = dtrFila["nombre"].ToString();
                    oEmpresa.CodEmpresa = Convert.ToInt32(dtrFila["codigoEmpresa"].ToString());

                    oUsuario.ltsEmpresa.Add(oEmpresa);
                }
                return oUsuario;
            }
            catch (Exception)
            {
                return null;
            }
            finally {
                oConexion.Close();
            }
        }

        /// <summary>
        /// Toma los menu y submenu a los cuales puede tener acceso el usuario ingresado
        /// pertenecientes a la empresa solicitada
        /// </summary>
        /// <author>Stiven Sánchez Rodríguez</author>
        /// <param name="pUsuario"></param>
        /// <param name="pEmpresa"></param>
        /// <returns></returns>
        public Usuario obtenerMenu(int pUsuario, int pEmpresa) {
            Usuario oUsuario = new Usuario();
            string strQuery = string.Empty;
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();

            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();

                oComando = new SqlCommand("mostrarOpcionesMenu", oConexion);
                oComando.CommandType = CommandType.StoredProcedure;

                oComando.Parameters.AddWithValue("@idUsuario", pUsuario);//id del Usuario
                oComando.Parameters.AddWithValue("@idEmpresa", pEmpresa);//id de la Empresa

                dtrResult = oComando.ExecuteReader();

                dtResult.Load(dtrResult);


                if (dtResult.Rows.Count == 0)
                {
                    return null;
                }

                foreach (DataRow dtrFila in dtResult.Rows)
                {
                    OpcionMenu oOpcionMenu = new OpcionMenu();
                    oOpcionMenu.Nombre = dtrFila["nombre"].ToString();
                    oOpcionMenu.Tipo = Convert.ToInt32(dtrFila["clase"].ToString());
                    oOpcionMenu.Id = dtrFila["permiso"].ToString();
                    oUsuario.Menu.Add(oOpcionMenu);
                }

                return oUsuario;
            }
            catch (Exception)
            {
                return null;
            }
            finally {
                oConexion.Close();
            }
        }

        /// <summary>
        /// Se encarga de eliminar la sesion abierta en la base de datos
        /// </summary>
        /// <param name="pUsuario"></param>
        public void cerrarSesion(int pUsuario) {
            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                string querry = string.Format("DELETE FROM Conectados WHERE codigoUsuario = {0}", pUsuario);
                oComando = new SqlCommand(querry, oConexion);
                oComando.CommandType = CommandType.Text;
                oComando.ExecuteNonQuery();
            }
            catch (Exception)
            {

            }
            finally
            {
                oConexion.Close();
            }
        }

        /// <summary>
        /// Verifica si usuario se encuentra en la lista de logueados
        /// </summary>
        /// <param name="pUsuario"></param>
        /// <returns></returns>
        public Boolean estaLogueado(int pUsuario) {
            Usuario oUsuario = new Usuario();
            string strQuery = string.Format("SELECT codigoUsuario FROM Conectados WHERE codigoUsuario = {0}",pUsuario);
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();

            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand(strQuery, oConexion);
                oComando.CommandType = CommandType.Text;

                dtrResult = oComando.ExecuteReader();

                dtResult.Load(dtrResult);

                if (dtResult.Rows.Count == 0)
                {
                    return false;
                }
                else {
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
            finally
            {
                oConexion.Close();
            }
        }

        /// <summary>
        /// Verifica si usuario se encuentra en la lista de logueados
        /// </summary>
        /// <param name="pUsuario"></param>
        /// <returns></returns>
        public int diasCreacionBase()
        {
            Usuario oUsuario = new Usuario();

            StringBuilder strQuery = new StringBuilder();

            strQuery.Append(" DECLARE @startdate DATETIME, @enddate DATETIME ");
            strQuery.Append(" SET @enddate = GETDATE() ");
            strQuery.Append(" SET @startdate= (SELECT create_date FROM sys.databases WHERE name='Dashboard') ");
            strQuery.Append(" SELECT DATEDIFF(DAY, @startdate, @enddate) AS 'Resultado' ");

            
            SqlDataReader dtrResult = null;
            DataTable dtResult = new DataTable();

            try
            {
                oConexion = new SqlConnection(strConexion);
                oConexion.Open();
                oComando = new SqlCommand(strQuery.ToString(), oConexion);
                oComando.CommandType = CommandType.Text;

                dtrResult = oComando.ExecuteReader();

                dtResult.Load(dtrResult);

                if (dtResult.Rows.Count == 0)
                {
                    return 0;
                }
                else
                {
                    DataRow fila;
                    fila = dtResult.Rows[0];
                    int Resultado = Convert.ToInt32(fila["Resultado"].ToString());
                    return Resultado;
                }
            }
            catch (Exception)
            {
                return 0;
            }
            finally
            {
                oConexion.Close();
            }
        }

    }
}
