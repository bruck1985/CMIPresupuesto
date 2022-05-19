using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

using DataAccess.Clases;
using Utilitarios.Clases;


namespace BusinessLogic.Clases
{
    public class UsuarioBL
    {
        private UsuarioDA oUsuarioDA;

        public UsuarioBL() {
            oUsuarioDA = new UsuarioDA();
        }

        /// <summary>
        /// Retorna un string de un usuario serializado con el id de Logueo
        /// </summary>
        /// <author>Stiven Sánchez Rodríguez</author>
        /// <param name="pUsuario"></param>
        /// <param name="pPassword"></param>
        /// <returns></returns>
        public string Logueo(string pUsuario, string pPassword)
        {
            Usuario oUsuario = oUsuarioDA.Logueo(pUsuario, pPassword);
            #region serializacion
                string objetoSerializado = new Serializador().serializar(oUsuario);
            #endregion
                return objetoSerializado;
        }

        /// <summary>
        /// Retorna un Usuario con todas la empresas correspondientes cargadas
        /// </summary>
        /// <author>Stiven Sánchez Rodríguez</author>
        /// <param name="pIdUsuario"></param>
        /// <returns></returns>
        public string ObtenerEmpresas(int pIdUsuario) {

            Usuario oUsuario = oUsuarioDA.obtenerEmpresas(pIdUsuario);
            if (oUsuario != null)
            {
                #region serializacion
                string objetoSerializado = new Serializador().serializar(oUsuario);
                #endregion
                return objetoSerializado;
            }
            else {
                return null; 
            }
        }

        /// <summary>
        /// Retorna un usuario con un menu cargado
        /// </summary>
        /// <author>Stiven Sánchez Rodríguez</author>
        /// <param name="pIdUsuario"></param>
        /// <param name="pIdEmpresa"></param>
        /// <returns></returns>
        public string obtenerMenu(int pIdUsuario, int pIdEmpresa) {
            Usuario oUsuario = oUsuarioDA.obtenerMenu(pIdUsuario, pIdEmpresa);
            if (oUsuario != null)
            {
                #region serializacion
                string objetoSerializado = new Serializador().serializar(oUsuario);
                #endregion

                return objetoSerializado;
            }
            else {
                return null;
            }
        }

        /// <summary>
        /// Cierra Sesion
        /// </summary>
        /// <param name="pIdUsuario"></param>
        public void cerrarSesion(int pIdUsuario) {
            oUsuarioDA.cerrarSesion(pIdUsuario);
        }

        /// <summary>
        /// Verifica que el usuario siga logueado
        /// </summary>
        /// <param name="pIdUsuario"></param>
        /// <returns></returns>
        public Boolean estaLogueado(int pIdUsuario) {
            return oUsuarioDA.estaLogueado(pIdUsuario);
        }

        /// <summary>
        /// Retorna true si la licencia esta vigente o no necesita 
        /// validacion de licencia temporal
        /// </summary>
        /// <returns></returns>
        public Boolean verificarLicenciaTemporal() {
            int pDiasCreacion = oUsuarioDA.diasCreacionBase();
            Serializador oSerializador = new Serializador();
            string pDiasLicencias = ConfigurationManager.AppSettings.Get("RegistrosGraficos").ToString();
            int pLimite = Int32.Parse(oSerializador.deserializacionString(pDiasLicencias));
            if (pDiasCreacion <= pLimite || pLimite == 0)
            {
                return true;
            }
            else {
                return false;
            }
        }

    }
}
