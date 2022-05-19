using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace Utilitarios.Clases
{
    public class Serializador
    {

        private JavaScriptSerializer js;

        public Serializador()
        {
            js = new JavaScriptSerializer();
        }

        #region Serializacion
        /// <summary>
        /// Se encarga de serializar un objeto cualquiera y retorna la serializacion en modo string
        /// </summary>
        /// <param name="pObjeto"></param>
        /// <returns></returns>
        public string serializar(Object pObjeto)
        {
            string serializacion = js.Serialize(pObjeto);
            string encriptado = encriptar(serializacion);
            return encriptado;
        }

        /// <summary>
        /// Se encarga de deserializar y retorna un objeto generico que donde
        /// va ser implementado debe ser casteado.
        /// EJ: 
        /// 1) Object objeto = Serializador.deserializar('stringSerializado');
        /// 2) int  numero = (int) objeto;
        /// </summary>
        /// <param name="pSerializacion"></param>
        /// <returns></returns>
        public Usuario deserializarUsuario(string pSerializacion)
        {

            pSerializacion = desencriptar(pSerializacion);
            Usuario oObjeto = js.Deserialize<Usuario>(pSerializacion);
            return oObjeto;
        }

        /// <summary>
        /// Se encarga de deserializar el parametro ingresado y retornarlo como un string
        /// </summary>
        /// <param name="pSerializacion"></param>
        /// <returns></returns>
        public Pagina deserializacionPagina(string pSerializacion)
        {
            pSerializacion = desencriptar(pSerializacion);
            Pagina oObjeto = js.Deserialize<Pagina>(pSerializacion);
            return oObjeto;
        }

        /// <summary>
        /// Se encarga de deserializar el parametro ingresado y retornarlo como un string
        /// </summary>
        /// <param name="pSerializacion"></param>
        /// <returns></returns>
        public string deserializacionString(string pSerializacion)
        {
            pSerializacion = desencriptar(pSerializacion);
            string oObjeto = js.Deserialize<string>(pSerializacion);
            return oObjeto;
        }
        #endregion

        #region Encriptacion

        /// <summary>
        /// Se encarga de ocultar el verdadero valor del string ingresasdo
        /// </summary>
        /// <param name="pCadenaAencriptar"></param>
        /// <returns></returns>
        private string encriptar(string pCadenaAencriptar)
        {
            string result = string.Empty;
            byte[] encryted = System.Text.Encoding.Unicode.GetBytes(pCadenaAencriptar);
            result = Convert.ToBase64String(encryted);
            return result;
        }

        /// <summary>
        /// Se encarga de eliminar el ocultamiento de datos para que pueda ser visto por el programa
        /// </summary>
        /// <param name="pCadenaAdesencriptar"></param>
        /// <returns></returns>
        private string desencriptar(string pCadenaAdesencriptar)
        {
            string result = string.Empty;
            byte[] decryted = Convert.FromBase64String(pCadenaAdesencriptar);
            //result = System.Text.Encoding.Unicode.GetString(decryted, 0, decryted.ToArray().Length);
            result = System.Text.Encoding.Unicode.GetString(decryted);
            return result;
        }
        #endregion
    }

    public class SerEncrypt
    {
        public SerEncrypt() { }

        public string desencriptarJS(string pCadenaAdesencriptar)
        {
            string result = string.Empty;
            byte[] decryted = Convert.FromBase64String(pCadenaAdesencriptar);
            //result = System.Text.Encoding.Unicode.GetString(decryted, 0, decryted.ToArray().Length);
            result = System.Text.Encoding.Unicode.GetString(decryted);
            return result;
        }

        public string desencriptar_(string pTexto)
        {

            JavaScriptSerializer js = new JavaScriptSerializer();
            pTexto = desencriptarJS(pTexto);
            string o_Objeto = js.Deserialize<String>(pTexto);
            return o_Objeto;
        }
    }

}
