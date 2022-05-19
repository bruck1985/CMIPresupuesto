using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BusinessLogic.Clases;
using Utilitarios.Clases;

using System.Configuration;

using System.Xml;

namespace UI.Web.assets
{
    public partial  class Menu : System.Web.UI.MasterPage
    {


        #region "Properties"
              

        //public DropDownList DDL_DataSources
        //{
        //    get { return this.DD_DataSources; }
        //    set { this.DD_DataSources = value; }
        //}



        #endregion

    

        UsuarioBL oUsuarioBL = new UsuarioBL();

        protected void Page_Load(object sender, EventArgs e)
        {
            #region Evitar lectura del Cache del Navegador
            HttpContext.Current.Response.Cache.SetExpires(DateTime.UtcNow.AddDays(-1));
            HttpContext.Current.Response.Cache.SetValidUntilExpires(false);
            HttpContext.Current.Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);
            HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            HttpContext.Current.Response.Cache.SetNoStore();
            #endregion

            try
            {
                //if (Session["idUsuario"] == null || Session["idUsuario"] == "" || oUsuarioBL.estaLogueado((int)Session["idUsuario"]) == false || oUsuarioBL.verificarLicenciaTemporal() == false)
                              
                
                if (Session["idUsuario"] == null || Session["idUsuario"] == "" || oUsuarioBL.verificarLicenciaTemporal() == false)
                {
                    if (oUsuarioBL.verificarLicenciaTemporal() == false)
                    {
                        Session["Mensaje"] = "Licencia Temporal Expirada";
                    }
                    else
                    {

                        if (Session["idUsuario"] != null && Session["idUsuario"] != "")
                        {
                            Session["Mensaje"] = "Maximo Licencias Alcanzadas";
                        }
                    }

                    // Response.Redirect("../Login.aspx");
                    Response.Redirect("../Web/Conciliacion_Intercompany.aspx");
                }
                else
                {
                    
                    Session["Activa"] = Session["Activa"] == null ? 1 : Session["Activa"];
                    string strSerializacion = oUsuarioBL.obtenerMenu((int)Session["idUsuario"], (int)Session["idEmpresa"]);

                    Usuario oUsuario = (strSerializacion != null) ? new Serializador().deserializarUsuario(strSerializacion) : null;
                    LBL_Empresa.Text = Session["nombreEmpresa"].ToString();
                    LBL_Usuario.Text = (string)Session["nombreUsuario"];

                    //LBL_Empresa.Text += " " + (string)Session["Device"];

                    if (oUsuario != null)
                    {
                        llenarMenu(oUsuario);
                        if (Session["LI_Menu_ID"] != null)
                        {
                            HtmlGenericControl menu = menuPrincipal;
                            HtmlGenericControl li = (HtmlGenericControl)menu.FindControl(Session["LI_Menu_ID"].ToString());
                            HtmlGenericControl ul = ((HtmlGenericControl)li.FindControl(Session["UL_SubMenu_ID"].ToString()));
                            ul.Attributes["style"] = "display: block";

                            HtmlGenericControl b = (HtmlGenericControl)li.FindControl("A_" + li.ID.ToString()).FindControl("B_A_" + li.ID.ToString());
                            b.Attributes["class"] = "arrow fa fa-angle-down";   
                         
                            //------------------------------------------------
                            //string SCR = ConfigurationManager.AppSettings["Img_MenuPrin"].ToString();

                            //this.imgMenu.InnerHtml = "<img src='" + SCR + "' />";

                            //----------------------------------------------

                        }
                    }

                    string SCR = ConfigurationManager.AppSettings["Img_MenuPrin"].ToString();
                    this.imgMenu.InnerHtml = string.Empty;
                    this.imgMenu.InnerHtml = "<img src='" + SCR + "' style='width:150px;height:100px' />";

                    LBL_Usuario.Text = (string)Session["nombreUsuario"];
                }
            }
            catch (Exception)
            {
                Response.Redirect("../Web/Conciliacion_Intercompany.aspx");
                Session.Clear();
            }
        }

        #region MetodosInternos

        /// <summary>
        /// Se encarga de cerrar las sesiones
        /// </summary>
        private void cerrarSesiones()
        {
            Session.Clear();
            Session.RemoveAll();
            Session.Abandon();
        }

        private bool tieneHijos(List<OpcionMenu> pOptionMenu,int pIndice, int pCantidad)
        {
            if (pCantidad == pIndice + 1)
            {
                return false;
            }
            else {
                if (pOptionMenu[pIndice + 1].Tipo == 0)
                {
                    return true;
                }
                else {
                    return false;
                }
            }
        }

        /// <summary>
        /// Se encarga de rellenar el menu de la interfaz con los menus
        /// pertenecientes al usuario ingresado
        /// </summary>
        /// <author>Stiven Sánchez Rodríguez</author>
        /// <param name="pUsuario"></param>
        private void llenarMenu(Usuario pUsuario)
        {
            List<OpcionMenu> optionMenu = pUsuario.Menu;
            int numeroElementos = optionMenu.Count;
            for (int indice = 0; indice < numeroElementos; indice++)
            {

                if (optionMenu[indice].Tipo == 1) //Etiqueta padre;
                {
                    HtmlGenericControl li = new HtmlGenericControl("li");

                    LinkButton aw = new LinkButton();
                    aw.Attributes["href"] = "#";
                    aw.Attributes["class"] = "dropdown-toggle";
                    aw.ID = "A_LI_" + indice;
                    HtmlGenericControl i = new HtmlGenericControl("i");
                    i.Attributes["class"] = "fa fa-bar-chart-o";
                    HtmlGenericControl span = new HtmlGenericControl("span");
                    Label lbltext = new Label();
                    lbltext.Text = optionMenu[indice].Nombre;
                    HtmlGenericControl b = new HtmlGenericControl("b");
                    b.Attributes["class"] = "arrow fa fa-angle-right";
                    b.ID = "B_A_LI_" + indice;
                    aw.Controls.Add(i);
                    aw.Controls.Add(span);
                    span.Controls.Add(lbltext);
                    aw.Controls.Add(b);
                    li.Controls.Add(aw);
                    li.ID = "LI_" + indice;
                    if (tieneHijos(optionMenu, indice, numeroElementos))
                    {
                    //Inicio Cambios
                    llenarSubMenu(li, optionMenu, indice+1);
                    //Fin Cambios
                    }
                    //else
                    //{
                    //    LinkButton aw = new LinkButton();
                    //    aw.Text = optionMenu[indice].Nombre;
                    //    aw.ID = optionMenu[indice].Id;                                  // NUEVO
                    //    aw.Attributes["runnat"] = "server";
                    //    aw.Click += new EventHandler(seleccionMenu);
                    //    HtmlGenericControl i = new HtmlGenericControl("i");
                    //    i.Attributes["class"] = "fa fa-bar-chart-o";
                    //    HtmlGenericControl span = new HtmlGenericControl("span");
                    //    Label lbltext = new Label();
                    //    lbltext.Text = optionMenu[indice].Nombre;
                    //    aw.Controls.Add(i);
                    //    aw.Controls.Add(s pñ`'+´çpan);
                    //    span.Controls.Add(lbltext);
                    //    li.Controls.Add(aw);
                    //}
                    menuPrincipal.Controls.Add(li);
                }                    
            }
        }

        /// <summary>
        /// Se encarga de rellenar el menu de la interfaz con el submenu correspondiente
        /// </summary>
        /// <author>Stiven Sánchez Rodríguez</author>
        /// <param name="pControl"></param>
        private int llenarSubMenu(HtmlGenericControl pControl, List<OpcionMenu> pLista, int pIndice)
        {
            HtmlGenericControl ul = new HtmlGenericControl("ul");
            ul.ID = "M&" + pIndice ;
            ul.Attributes["class"] = "submenu";
            int numeroElementos = pLista.Count;
            int result = 0;

            try
            {            

                for (int indice = pIndice; indice < numeroElementos; indice++)
                {

                    if (pLista[indice].Tipo == 0 || result == 0)
                    {
                        HtmlGenericControl li = new HtmlGenericControl("li");

                        LinkButton aw = new LinkButton();
                        aw.Text = pLista[indice].Nombre;

                        aw.ID = pLista[indice].Id;                                  // NUEVO

                        aw.Attributes["runnat"] = "server";
                        aw.Click += new EventHandler(seleccionMenu);

                        li.Controls.Add(aw);
                        ul.Controls.Add(li);
                        result += 1;
                    }
                    else
                    {
                        break;
                    }
                }

                pControl.Controls.Add(ul);
                return result;


            }
            catch (Exception)
            {
                return result;
                //throw;
            }

        }

        #endregion

        /// <summary>
        /// Se encarga de cerrar las sesiones 
        /// </summary>
        /// <author>Stiven Sánchez Rodríguez</author>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void LN_CerrarSesion_Click(object sender, EventArgs e)
        {
            int idUsuario = Int32.Parse(Session["idUsuario"].ToString());
            oUsuarioBL.cerrarSesion(idUsuario);
            cerrarSesiones();
            Response.Redirect("../Login.aspx");
        }

        /// <summary>
        /// Se encargar de obtener la informacion solicitada para refrescar el contenido principal
        /// </summary>
        /// <author>Stiven Sánchez Rodríguez</author>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void seleccionMenu(object sender, EventArgs e)
        {
            string pPermiso = ((LinkButton)sender).ID;
            string ModoVisual = "pc";
            Session["LI_Menu_ID"] = ((LinkButton)sender).Parent.Parent.Parent.ID;
            Session["UL_SubMenu_ID"] = ((LinkButton)sender).Parent.Parent.ID;

            #region Encriptar && Desencriptar

            int IntIdEmpresa = 1;

            try
            {
                if (Session["idEmpresa"] != null)
                {
                    IntIdEmpresa = (int)Session["idEmpresa"];
                }

                if (Session["Device"] != null)
                {
                    if (!string.IsNullOrEmpty(Session["Device"].ToString()))
                    {
                        ModoVisual = Session["Device"].ToString();
                    }                
                }

               
                //string strSerializacion = new PaginaBL().obtenerInformacion(pPermiso);

                //string strSerializacion = new PaginaBL().obtenerInformacionPorIdEmpY_IdPerm(pPermiso, IntIdEmpresa);
                string strSerializacion = new PaginaBL().obtenerInformacionMenuContenido(pPermiso, IntIdEmpresa, ModoVisual);

                Pagina oPagina = (strSerializacion != null) ? new Serializador().deserializacionPagina(strSerializacion) : null;
                

                if (oPagina != null)
                {
                    string xmlContenido = oPagina.ContenidoPag;
                    Session["Dashboard"] = xmlContenido;

                    if (xmlContenido.IndexOf("<Parameters>") <= -1)
                    {                         
                        Session["HideShow"] = 0;
                    }
                    else
                    {
                        Session["HideShow"] = 1;
                    }

                    //  Response.Redirect("Contenidosc.aspx", false);
                    Response.Redirect(xmlContenido, false);
                    //Response.Redirect("Conciliacion_Intercompany.aspx", false);
                }
            }
            catch (Exception error)
            {
                //throw;
                Console.WriteLine("An error occurred: '{0}'", error);

            }

            #endregion

        }
    }
}