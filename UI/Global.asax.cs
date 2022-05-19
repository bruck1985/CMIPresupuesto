using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using BusinessLogic.Clases;
using System.Security.Principal;
using System.Configuration;
using System.Globalization;
using System.Threading;
using UI.Web;

namespace UI
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

            DevExpress.XtraReports.Web.ASPxWebDocumentViewer.StaticInitialize();
            DevExpress.XtraReports.Web.Extensions.ReportStorageWebExtension.RegisterExtensionGlobal(new ReportStorageWebExtension1());
            DevExpress.XtraReports.Web.ASPxReportDesigner.StaticInitialize();
            DevExpress.XtraReports.Web.Extensions.ReportStorageWebExtension.RegisterExtensionGlobal(new ReportStorageWebExtension1());
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            CultureInfo newCulture = (CultureInfo)System.Threading.Thread.CurrentThread.CurrentCulture.Clone();
            newCulture.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            newCulture.DateTimeFormat.DateSeparator = "-";
            Thread.CurrentThread.CurrentCulture = newCulture;
        }

        void Application_AuthenticateRequest(Object sender, EventArgs e)
        {
            if (ConfigurationManager.AppSettings.Get("DOMINIO").ToString() != "")
            {
                String cookieName = FormsAuthentication.FormsCookieName;
            HttpCookie authCookie = Context.Request.Cookies[cookieName];

            if (null == authCookie)
            {//There is no authentication cookie.
                return;
            }

            FormsAuthenticationTicket authTicket = null;

            try
            {
                authTicket = FormsAuthentication.Decrypt(authCookie.Value);
            }
            catch (Exception ex)
            {
                //Write the exception to the Event Log.
                return;
            }

            if (null == authTicket)
            {//Cookie failed to decrypt.
                return;
            }

            //When the ticket was created, the UserData property was assigned a
            //pipe-delimited string of group names.
            String[] groups = authTicket.UserData.Split(new char[] { '|' });

            //Create an Identity.
            GenericIdentity id = new GenericIdentity(authTicket.Name, "LdapAuthentication");

            //This principal flows throughout the request.
            GenericPrincipal principal = new GenericPrincipal(id, groups);

            Context.User = principal;
            }
        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            int intUsuario = 0;
            try {
                intUsuario = (int)Session["idUsuario"];
                UsuarioBL oUsuario = new UsuarioBL();
                oUsuario.cerrarSesion(intUsuario);
                Response.Redirect("Login.aspx");
            }
            catch (Exception) {
                UsuarioBL oUsuario = new UsuarioBL();
                oUsuario.cerrarSesion(intUsuario);
                Response.Redirect("Login.aspx");
            }            
        }

        protected void Application_End(object sender, EventArgs e)
        {
            int intUsuario = 0;
            try
            {
                intUsuario = (int)Session["idUsuario"];
                UsuarioBL oUsuario = new UsuarioBL();
                oUsuario.cerrarSesion(intUsuario);
            }
            catch (Exception)
            {
                UsuarioBL oUsuario = new UsuarioBL();
                oUsuario.cerrarSesion(intUsuario);
            } 
        }
    }
}