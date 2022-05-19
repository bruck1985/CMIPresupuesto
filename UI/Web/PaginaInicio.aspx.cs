using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic.Clases;
using DevExpress.DataAccess.ConnectionParameters;
using Utilitarios.Clases;

using System.Xml;

namespace UI.Web
{
    public partial class PaginaInicio : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["idUsuario"] == null || Session["idUsuario"] == "")
            //{


            //    Response.Redirect("../Login.aspx");
            //}
            //else
            //{
            //    //Esto es para controlar la inactividad de las sessiones, por lo que cada movimiento
            //    //entre pagina o cada carga de dashboard refresca las sessiones y el tiempo de inicio
            //    //vuelve a ser cero. (Global.asax cierra session en caso de inactividad y al refrescar la
            //    // pagina lo devuelve a la pagina de login)
            //    Session["idUsuario"] = Session["idUsuario"];
            //    Session["idEmpresa"] = Session["idEmpresa"];

            //    if (!IsPostBack) {
            //        cargarDashboardDefecto();
            //    }

                
            //}

            bool IsNullSessionUsuario = false;

            try
            {
                if (Session["idUsuario"] != null)
                {
                    if (!string.IsNullOrEmpty(Session["idUsuario"].ToString()))
                    {
                        Session["idUsuario"] = Session["idUsuario"];
                        Session["idEmpresa"] = Session["idEmpresa"];

                        if (!IsPostBack)
                        {
                            cargarDashboardDefecto();
                        }
                    }
                    else
                    {
                        IsNullSessionUsuario = true;
                    }               
                }
                else
                {
                    IsNullSessionUsuario = true;
                }

                if (IsNullSessionUsuario)
                {
                    Response.Redirect("../Login.aspx");
                }

            }
            catch (Exception)
            {

                throw;
            }


        }

        protected void ASPxDashboardViewer1_ConfigureDataConnection(object sender, DevExpress.DashboardWeb.ConfigureDataConnectionWebEventArgs e)
        {

        }

        protected void ASPxDashboardViewer1_CustomParameters(object sender, DevExpress.DashboardWeb.CustomParametersWebEventArgs e)
        {


        }

        protected void ASPxDashboardViewer1_ConfigureDataConnection1(object sender, DevExpress.DashboardWeb.ConfigureDataConnectionWebEventArgs e)
        {
            MsSqlConnectionParameters parametros = e.ConnectionParameters as MsSqlConnectionParameters;
            if (parametros != null)
            {
                parametros.UserName = "test";
                parametros.Password = "test";

            }
        }



        private void cargarDashboardDefecto()
        {

            string ModoVisual = "pc";
            string pPermiso = string.Empty;

            try
            {
            

               #region Encriptar && Desencriptar

                pPermiso = new PaginaBL().obtenerPermisoDefecto((int)Session["idEmpresa"], (int)Session["idUsuario"]);
                //string strSerializacion = new PaginaBL().obtenerInformacion(pPermiso);

                if (Session["Device"] != null)
                {
                    if (!string.IsNullOrEmpty(Session["Device"].ToString()))
                    {
                      ModoVisual = Session["Device"].ToString();
                    }
                }

                //string strSerializacion = new PaginaBL().obtenerInformacionPorIdEmpY_IdPerm(pPermiso, (int)Session["idEmpresa"]);
                string strSerializacion = new PaginaBL().obtenerInformacionMenuContenido(pPermiso, (int)Session["idEmpresa"],ModoVisual);

                Pagina oPagina = (strSerializacion != null) ? new Serializador().deserializacionPagina(strSerializacion) : null;

               #endregion

                if (oPagina != null)
                {
                    string xmlContenido = oPagina.ContenidoPag;
                    Session["Dashboard"] = xmlContenido;

                    Session["UsuarioDB"] = oPagina.UserDB;
                    Session["PassDB"] = oPagina.PassDB;


                    if (xmlContenido.IndexOf("<Parameters>") <= -1)
                    {                      
                        Session["HideShow"] = 0;
                    }
                    else
                    {
                        Session["HideShow"] = 1;
                    }


                  
                    Response.Redirect("Contenidosc.aspx");
                }

            }
            catch (Exception ex)
            {

                throw;
            }

        }

        private void cargarDD_DataSources(string xml)
        {
            DropDownList DD = new DropDownList();
            try
            {               
                System.Xml.XmlDocument xml_ = new XmlDocument();
                xml_.LoadXml(xml);
                System.Xml.XmlNodeList Nodes = xml_.GetElementsByTagName("Items");
                ((DropDownList)this.Master.FindControl("DD_DataSources")).Visible = false;
                if (Nodes.Count > 0)
                {
                    for (int i = 0; i < Nodes.Count; i++)
                    {                       
                        foreach (XmlNode item in Nodes.Item(i).ChildNodes)
                        {                           
                            ((DropDownList)this.Master.FindControl("DD_DataSources")).Items.Add(new ListItem(item.Attributes["DataSource"].InnerXml + "-" + item.Attributes["ComponentName"].InnerXml, item.Attributes["DataSource"].InnerXml + "-" + item.Attributes["ComponentName"].InnerXml));
                        }
                    }
                }
            }
            catch (Exception)
            {                
                throw;
            }        
        }

    }
}