using BusinessLogic.Clases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utilitarios.Clases;
using System.DirectoryServices;
using FormsAuth;
using System.Web.Security;
using System.Configuration;
using System.Security.Principal;

namespace MenuDashboard.Web
{
    public partial class Login : System.Web.UI.Page
    {

        private UsuarioBL oUsuarioBL;
        private List<int> lstCodEmpresas;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["Av"] != null)
            {
                ClientScript.RegisterStartupScript(GetType(), "SesionExpirada", "javascript:SesionExpirada();", true);
                Session["Av"] = null;
            }

            #region Evitar lectura del Cache del Navegador
            HttpContext.Current.Response.Cache.SetExpires(DateTime.UtcNow.AddDays(-1));
            HttpContext.Current.Response.Cache.SetValidUntilExpires(false);
            HttpContext.Current.Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);
            HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            HttpContext.Current.Response.Cache.SetNoStore();
            #endregion

            lstCodEmpresas = new List<int>();
            oUsuarioBL = new UsuarioBL();

            this.Sesion_Device();

            if (Session["Mensaje"] != null && Session["Mensaje"] != "")
            {
                string mensaje = (string)Session["Mensaje"];
                cambiarEstadoLogin();
                LBL_Mensaje.Text = mensaje;
                LBL_Mensaje.Visible = true;
            }

            //TB_Usuario.Text = "Administrador"; ///WindowsIdentity.GetCurrent().ToString().Replace(ConfigurationManager.AppSettings.Get("DOMINIO").ToString(),"");
            //TB_Usuario.Text = WindowsIdentity.GetCurrent().ToString().Replace(ConfigurationManager.AppSettings.Get("DOMINIO").ToString(), "");

            if (ConfigurationManager.AppSettings.Get("DOMINIO").ToString() != "") 
              { 
                 TB_Usuario.Text = WindowsIdentity.GetCurrent().Name.ToString().Replace(ConfigurationManager.AppSettings.Get("DOMINIO").ToString(), "").Replace("\\","");
                 BTN_Ejecutar_Click(sender, e);
              }
        }

        /// <summary>
        /// Modo Cargar: Carga las empresas pertenecientes al usuario ingresado
        /// Modo Ingresar: Compara el usuario y la contraseña en la base de datos
        /// </summary>
        /// <author>Stiven Sánchez Rodríguez</author>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void BTN_Ejecutar_Click(object sender, EventArgs e)
        {
            String Variable= "0";
            String adPath;
            String dominio;
            LdapAuthentication adAuth;

            //  if (((DateTime.Now.Date).Year * 100 + (DateTime.Now.Date).Month) >= 201804)
            //  {
            //      LBL_Mensaje.Text = "Licencia Expirada.";
            //      Response.Close();
            //      Response.End();
            //  }



            if (BTN_Ejecutar.Text == "Cargar")
            {
                try
                {
                    if (ConfigurationManager.AppSettings.Get("DOMINIO").ToString() != "")
                    {
                        Variable = "1";
                        adPath = ConfigurationManager.AppSettings.Get("LDAP").ToString();
                        dominio = ConfigurationManager.AppSettings.Get("DOMINIO").ToString();
                        Variable = "2";
                        // String adPath = "LDAP://SERVERFULLTECH.FULLTECHNOLOGY.com/DC=FULLTECHNOLOGY, DC=com"; //Fully-qualified Domain Name
                        adAuth = new LdapAuthentication(adPath);
                        Variable = "3";

                        Variable = "4";

                        if (true == adAuth.IsAuthenticated(dominio, TB_Usuario.Text, TB_Password.Text))
                        {
                            Variable = "5";

                            //String groups = adAuth.GetGroups();

                            //Create the ticket, and add the groups.
                            bool isCookiePersistent = false; //chkPersist.Checked;
                                                             //FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(1, TB_Usuario.Text,
                                                             //DateTime.Now, DateTime.Now.AddMinutes(60), isCookiePersistent, groups);

                            //Encrypt the ticket.
                            //String encryptedTicket = FormsAuthentication.Encrypt(authTicket);

                            //Create a cookie, and then add the encrypted ticket to the cookie as data.
                            //HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);

                            //if (true == isCookiePersistent)
                            //  authCookie.Expires = authTicket.Expiration;

                            //Add the cookie to the outgoing cookies collection.
                            //Response.Cookies.Add(authCookie);

                            //You can redirect now.
                            //Response.Redirect(FormsAuthentication.GetRedirectUrl(TB_Usuario.Text, false));
                        }
                        else
                        {
                            LBL_Mensaje.Text = "Authentication did not succeed. Check user name and password.";
                        }
                    }

                    //              }
                    //              catch (Exception ex)
                    //              {
                    //                  LBL_Mensaje.Text = "Error authenticating. " + ex.Message;
                    //              }
                    #region ENCRIPTAR & DESENCRIPTAR (LOGUIN)
                    Variable = "6";
                    string strSerializacion = oUsuarioBL.Logueo(TB_Usuario.Text, new Serializador().serializar(TB_Password.Text)); //Toma el string de serializacion devuelto desde la capa de negocios
                    Variable = "7";

                    Usuario oUsuario = new Usuario();
                    Variable = "8";

                    oUsuario = (strSerializacion != null) ? (new Serializador().deserializarUsuario(strSerializacion)) : null; //Deserializa el objeto
                    #endregion
                    Variable = "9";

                    //              try {

                    if (!string.IsNullOrEmpty(oUsuario.StrError.ToString()))
                    {
                        LBL_Mensaje.Text = "Error: " + oUsuario.StrError.ToString();
                        return;
                    }

                    Variable = "10";

                    Session["idUsuario"] = Int32.Parse(oUsuario.codUsuario);

                    Variable = "11";

                    cambiarEstadoEmpresa();
                    Variable = "12";

                    #region ENCRIPTAR & DESENCRIPTAR (LISTA EMPRESAS)
                    strSerializacion = oUsuarioBL.ObtenerEmpresas(Int32.Parse(oUsuario.codUsuario)); //obtiene la lista de empresas del usuario de forma serializada;
                    Variable = "13";

                    if (strSerializacion != null)
                    {
                        Variable = "14";

                        oUsuario = new Serializador().deserializarUsuario(strSerializacion);   //convierte la serializacion e un objeto usuario;

                        Variable = "15";

                        cargarEmpresas(oUsuario);
                        Session["lstEmpresas"] = lstCodEmpresas;

                        Variable = "16";

                        if (lstCodEmpresas.Count == 1)
                        {
                            List<int> idsEmpresas = (List<int>)Session["lstEmpresas"];
                            Session["idEmpresa"] = idsEmpresas[0];
                            Session["nombreEmpresa"] = DDL_Empresas.Text;
                            Session["nombreUsuario"] = TB_Usuario.Text;
                            Session["idUsuario"] = Session["idUsuario"];
                            Session["lstEmpresas"] = null;

                            Response.Redirect("Web/Splash.aspx");
                        }

                    }
                    else
                    {
                        cambiarEstadoLogin();
                        LBL_Mensaje.Text = "Usuario no tiene Empresa Asignada";
                    }
                    #endregion



                }
                catch (Exception error)
                {
                    vaciarCampos();
                    LBL_Mensaje.Text = "E" + Variable + ":" + error.Message.ToString(); //codUsuario puede contener un texti que indica la razon por la cual no se logueo
                }
            }
            else //Redireccionamiento a la pagina Siguiente
            {
                List<int> idsEmpresas = (List<int>)Session["lstEmpresas"];
                Session["idEmpresa"] = idsEmpresas[DDL_Empresas.SelectedIndex];
                Session["nombreEmpresa"] = DDL_Empresas.Text;
                Session["nombreUsuario"] = TB_Usuario.Text;
                Session["idUsuario"] = Session["idUsuario"];
                Session["lstEmpresas"] = null;

                Response.Redirect("Web/Splash.aspx");
                //Response.Redirect("Web/Contenido.aspx");
            }
        }

        /// <summary>
        /// Se encarga de volver al form inicial
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void BTN_Atras_Click(object sender, EventArgs e)
        {
            cambiarEstadoLogin();
        }

        #region Metodos Internos

        /// <summary>
        /// Se encarga de cargar el DropdownList con las empresas
        /// </summary>
        /// <param name="pUsuario"></param>
        private void cargarEmpresas(Usuario pUsuario)
        {
            DDL_Empresas.Items.Clear();
            lstCodEmpresas.Clear();
            LBL_Mensaje.Text = "";
            List<Empresa> listaEmpresas = pUsuario.ltsEmpresa;
            int numeroEmpresas = listaEmpresas.Count;
            if (numeroEmpresas != 0)
            {
                DDL_Empresas.Visible = true;
                //LBL_Empresas.Visible = true;
                for (int indice = 0; indice < numeroEmpresas; indice++)
                {
                    DDL_Empresas.Items.Add(listaEmpresas[indice].Nombre);
                    lstCodEmpresas.Add(listaEmpresas[indice].CodEmpresa);
                }
            }
            else
            {
                DDL_Empresas.Visible = false;
                //LBL_Empresas.Visible = false;
            }
        }

        /// <summary>
        /// Vacia los campos de la interfaz
        /// </summary>
        private void vaciarCampos()
        {
            TB_Usuario.Text = "";
            TB_Password.Text = "";
        }

        private void cambiarEstadoLogin() {
            int idUsuario = Int32.Parse(Session["idUsuario"].ToString());
            oUsuarioBL.cerrarSesion(idUsuario);
            TB_Password.Visible = true;
            TB_Usuario.Enabled = true;
            BTN_CerrarSesion.Visible = false;
            DDL_Empresas.Visible = false;
            Session.Clear();
            Session.RemoveAll();
            Session.Abandon();
            TB_Usuario.Text = "";
            TB_Password.Text = "";
            DDL_Empresas.Items.Clear();
            BTN_Ejecutar.Text = "Cargar";

        }


        private void cambiarEstadoEmpresa() {
            TB_Password.Visible = false;
            TB_Usuario.Enabled = false;
            BTN_CerrarSesion.Visible = true;
            BTN_Ejecutar.Text = "Ingresar";
            BTN_Ejecutar.Focus();
        }


        private void Sesion_Device() {

            try
            {
                string Device = Request.UserAgent.ToString();
                HttpContext context = HttpContext.Current;

                context.Session["Device"] = "pc";

                //if (Device.Contains("iphone") || Device.Contains("android") || Device.Contains("ppc") || Device.Contains("windows ce") || Device.Contains("blackberry") || Device.Contains("opera mini") || Device.Contains("mobile") || Device.Contains("palm") || Device.Contains("portable"))
                //{
                //    context.Session["Device"] = "mobile";
                //}
                //else
                //{
                //    context.Session["Device"] = "pc";
                //}   
             

                if (context.Request.Browser.IsMobileDevice )
                {
                    context.Session["Device"] = "mobile";
                    return;
                }

                if (context.Request.ServerVariables["HTTP_X_WAP_PROFILE"] != null)
                {
                    context.Session["Device"] = "mobile";
                    return;
                }

                if (context.Request.ServerVariables["HTTP_ACCEPT"] != null && context.Request.ServerVariables["HTTP_ACCEPT"].ToLower().Contains("wap"))
                {
                    context.Session["Device"] = "mobile";
                    return;
                }

                if (context.Request.ServerVariables["HTTP_USER_AGENT"] != null)
                {
                    //Create a list of all mobile types
                    string[] mobiles =
                        new[]
                {
                    "midp", "j2me", "avant", "docomo", 
                    "novarra", "palmos", "palmsource", 
                    "240x320", "opwv", "chtml",
                    "pda", "windows ce", "mmp/", 
                    "blackberry", "mib/", "symbian", 
                    "wireless", "nokia", "hand", "mobi",
                    "phone", "cdm", "up.b", "audio", 
                    "SIE-", "SEC-", "samsung", "HTC", 
                    "mot-", "mitsu", "sagem", "sony"
                    , "alcatel", "lg", "eric", "vx", 
                    "NEC", "philips", "mmm", "xx", 
                    "panasonic", "sharp", "wap", "sch",
                    "rover", "pocket", "benq", "java", 
                    "pt", "pg", "vox", "amoi", 
                    "bird", "compal", "kg", "voda",
                    "sany", "kdd", "dbt", "sendo", 
                    "sgh", "gradi", "jb", "dddi", 
                    "moto", "iphone", "android","tablet"
                };
                   
                    foreach (string s in mobiles)
                    {
                        if (context.Request.ServerVariables["HTTP_USER_AGENT"].
                                                            ToLower().Contains(s.ToLower()))
                        {
                            context.Session["Device"] = "mobile";
                            return;
                        }
                    }
                }
                
            }
            catch (Exception)
            {
                
                throw;
            }

           

        }


        #endregion

    }
}