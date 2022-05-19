using DataAccess.Clases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilitarios.Clases;

namespace BusinessLogic.Clases
{
    public class PaginaBL
    {
        private PaginaDA oPaginaDA;

        public PaginaBL() {
            oPaginaDA = new PaginaDA();
        }
        
        /// <summary>
        /// Se encarga de retornar el contenido de la pagina que fue seleccionada en la pagina
        /// </summary>
        /// <author>Stiven Sánchez Rodríguez</author>
        /// <param name="pIdEmpresa"></param>
        /// <param name="pSeleccion"></param>
        /// <returns></returns>
        public string obtenerInformacion(string pPermiso) {
            Pagina oPagina = oPaginaDA.obtenerContenido(pPermiso);

            if (oPagina != null)
            {
                #region serializacion
                string objetoSerializado = new Serializador().serializar(oPagina);
                #endregion

                return objetoSerializado;
            }
            else {
                return null;
            }
        }

        //------------------------
        public string obtenerInformacionMenuContenido(string pPermiso, int IntIdEmpresa, string ModoVisual)
        {

            try
            {
                Pagina oPagina = oPaginaDA.obtenerInformacionMenuContenido(pPermiso, IntIdEmpresa, ModoVisual);
                if (oPagina != null)
                {
                    #region serializacion
                    string objetoSerializado = new Serializador().serializar(oPagina);
                    #endregion

                    return objetoSerializado;
                }
                else
                {
                    return null;
                }


            }
            catch (Exception)
            {

                throw;
            }

        }

        //-------------------------


        public string obtenerInformacionPorIdEmpY_IdPerm(string pPermiso, int IntIdEmpresa)
        {

            try
            {
                 Pagina oPagina = oPaginaDA.obtenerContenidoPorIdEmpY_IdPerm(pPermiso,  IntIdEmpresa);
                 if (oPagina != null)
                 {
                     #region serializacion
                     string objetoSerializado = new Serializador().serializar(oPagina);
                     #endregion

                     return objetoSerializado;
                 }
                 else
                 {
                     return null;
                 }


            }
            catch (Exception)
            {
                
                throw;
            }
        
        }


        /// <summary>
        /// Encarga de obtener el permiso de pro defecto del usuario
        /// </summary>
        /// <param name="pIdEmpresa"></param>
        /// <param name="pIdUsuario"></param>
        /// <returns></returns>
        public string obtenerPermisoDefecto(int pIdEmpresa, int pIdUsuario)
        {
            string permiso = oPaginaDA.obtenerPermisoDefecto(pIdEmpresa, pIdUsuario);
            return permiso;
        }
    }
}
