using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic.Clases;

namespace UI.Web
{
    public partial class ActionDB : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(EnableSession = true)]
        public static string CloseSession(string pIdUser)
        {
            int intUsuario = 0;
            try
            {                
                intUsuario = pIdUser != null ? Convert.ToInt32(pIdUser) : 0;
                UsuarioBL oUsuario = new UsuarioBL();
                string numero1 = HttpContext.Current.Session["idEmpresa"].ToString();
                //int numero = (int)Session["idEmpresa"];
                //oUsuario.cerrarSesion(intUsuario);
                return "Done";
            }
            catch (Exception)
            {
                return "";
            }  
        }
    }
}