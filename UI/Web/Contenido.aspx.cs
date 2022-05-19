using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.DataAccess.ConnectionParameters;

using System.Xml;

namespace UI.Web
{
    public partial class Contenido : System.Web.UI.Page
    {


        #region "Properties"



        #endregion



        #region "Page Load"

        //private bool HideShowDiv()
        //{
        //    bool Result = false;
        //    try
        //    {
        //        if (Session["HideShow"] != null)
        //        {
        //            if (Session["HideShow"].ToString() != string.Empty)
        //            {
        //                string D = Session["HideShow"].ToString();
        //                if (D == "0")
        //                {
        //                    Result = false;
        //                }
        //                else
        //                {
        //                    Result = true;
        //                }
        //            }
        //        }

        //        return Result;
        //    }
        //    catch (Exception)
        //    {
        //        return Result;
        //    }
        //}

        protected void Page_Load(object sender, EventArgs e)
        {



            if (!this.IsPostBack)
            {
                //((System.Web.UI.HtmlControls.HtmlGenericControl)this.Master.FindControl("FiltradoDiv")).Visible = this.HideShowDiv();


               // this.FiltradoDiv.Visible = this.HideShowDiv();

              //  this.cargarDD_DataSources(Session["Dashboard"].ToString());
            }



            ASPxDashboardViewer1.DashboardId = "Dashboard";
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
            //}

            bool IsNullSessionUsuario = false;
            try
            {
                if (Session["idUsuario"] == null)
                {
                    IsNullSessionUsuario = true;
                }
                else
                {
                    if (string.IsNullOrEmpty(Session["idUsuario"].ToString()))
                    {
                        IsNullSessionUsuario = true;
                    }
                    else
                    {
                        //Esto es para controlar la inactividad de las sessiones, por lo que cada movimiento
                        //entre pagina o cada carga de dashboard refresca las sessiones y el tiempo de inicio
                        //vuelve a ser cero. (Global.asax cierra session en caso de inactividad y al refrescar la
                        // pagina lo devuelve a la pagina de login)
                        Session["idUsuario"] = Session["idUsuario"];
                        Session["idEmpresa"] = Session["idEmpresa"];
                    }

                }


                if (IsNullSessionUsuario)
                {
                    Session["Av"] = "Y";
                    Response.Redirect("../Login.aspx");
                }


            }
            catch (Exception)
            {
                Response.Redirect("../Login.aspx");
                //throw;
            }

        }

        #endregion


        #region "Loading"

        private string[] ObtenerValuesMember(string xml)
        {
            string[] ValuesMember = { "" };
            try
            {
                System.Xml.XmlDocument xml_ = new XmlDocument();
                xml_.LoadXml(xml);
                System.Xml.XmlNodeList Nodes = xml_.GetElementsByTagName("Parameters");

                if (Nodes.Count > 0)
                {
                    for (int i = 0; i < Nodes.Count; i++)
                    {
                        int inTT = 0;
                        foreach (XmlNode Node_ in Nodes.Item(i).ChildNodes)
                        {
                            if (Node_.Name == "Parameter")
                            {
                                if (!Node_.HasChildNodes)
                                {
                                    continue;
                                }

                                foreach (XmlNode Child_Node in Node_.ChildNodes)
                                {
                                    string strValueMemeber = Child_Node.Attributes["ValueMember"].InnerXml;
                                    ValuesMember[inTT] = strValueMemeber;
                                }
                                Array.Resize(ref ValuesMember, ValuesMember.Length + 1);
                                inTT++;
                            }
                        }
                    }
                }

                return ValuesMember;
            }
            catch (Exception)
            {
                //throw;
                return ValuesMember;
            }
        }

        //private void cargarDD_DataSources(string xml)
        //{
        //    try
        //    {
        //        System.Xml.XmlDocument xml_ = new XmlDocument();
        //        xml_.LoadXml(xml);
        //        System.Xml.XmlNodeList Nodes = xml_.GetElementsByTagName("Items");
        //        int CounterItems = 0;

        //        if (Nodes.Count > 0)
        //        {
        //            string[] Values = this.ObtenerValuesMember(xml);
        //            for (int i = 0; i < Nodes.Count; i++)
        //            {
        //                foreach (XmlNode item in Nodes.Item(i).ChildNodes)
        //                {
        //                    foreach (XmlNode NodeCh in item.ChildNodes)
        //                    {
        //                        if (NodeCh.Name == "DataItems")
        //                        {
        //                            foreach (XmlNode ChildNode in NodeCh.ChildNodes)
        //                            {
        //                                if (ChildNode.Name != "Dimension")
        //                                {
        //                                    continue;
        //                                }
        //                                string strDataMemeber = ChildNode.Attributes["DataMember"].InnerXml;
        //                                string strUniqueName = ChildNode.Attributes["UniqueName"].InnerXml;
        //                                for (int j = 0; j < Values.Length - 1; j++)
        //                                {
        //                                    if (Values[j].ToString() == strDataMemeber)
        //                                    {
        //                                        this.DD_DataSources.Items.Add(new ListItem(item.Attributes["Name"].InnerXml, item.Attributes["DataSource"].InnerXml + ";" + item.Attributes["ComponentName"].InnerXml + ";" + strDataMemeber + ";" + strUniqueName));
        //                                        // ((DropDownList)this.Master.FindControl("DD_DataSources")).Items.Add(new ListItem(item.Attributes["Name"].InnerXml, item.Attributes["DataSource"].InnerXml + ";" + item.Attributes["ComponentName"].InnerXml + ";" + strDataMemeber + ";" + strUniqueName));
        //                                        CounterItems++;
        //                                    }
        //                                }
        //                            }
        //                        }
        //                    }
        //                }
        //            }

        //            if (CounterItems > 1)
        //            {
        //                //((DropDownList)this.Master.FindControl("DD_DataSources")).Visible = true;
        //                this.DD_DataSources.Visible = true;
        //            }
        //            else
        //            {
        //                //((DropDownList)this.Master.FindControl("DD_DataSources")).Visible = false;
        //                //((DropDownList)this.Master.FindControl("DD_DataSources")).SelectedIndex = 0;

        //                this.DD_DataSources.Visible = false;
        //                this.DD_DataSources.SelectedIndex = 0;
        //            }
        //        }
        //    }
        //    catch (Exception)
        //    {
        //        //throw;
        //    }
        //}

        protected void ASPxDashboardViewer1_DashboardLoading(object sender, DevExpress.DashboardWeb.DashboardLoadingEventArgs e)
        {
            try
            {
                if (e.DashboardId == "Dashboard")
                {
                    string dashboardDefinition = Session["Dashboard"].ToString();
                    if (Session["DashboardLayout"] != null)
                    {
                        if (!string.IsNullOrEmpty(Session["DashboardLayout"].ToString()))
                        {
                            dashboardDefinition = Session["DashboardLayout"].ToString();
                            Session["DashboardLayout"] = null;
                        }
                    }

                    e.DashboardXml = dashboardDefinition;
                }
            }
            catch (Exception error)
            {
                //throw;
            }
        }

        #endregion

        #region "Loaded"

        protected void ASPxDashboardViewer1_DashboardLoaded(object sender, DevExpress.DashboardWeb.DashboardLoadedWebEventArgs e)
        {
            try
            {
                //string Dashboardlayout = string.Empty;

                //using (System.IO.MemoryStream memoria = new System.IO.MemoryStream())
                //{
                //    e.Dashboard.SaveToXml(memoria);
                //    memoria.Seek(0, System.IO.SeekOrigin.Begin);
                //    using (System.IO.StreamReader lector = new System.IO.StreamReader(memoria))
                //    {
                //        Dashboardlayout = lector.ReadToEnd();
                //        Session["Dashboard"] = Dashboardlayout;
                //    }
                //}
            }
            catch (Exception)
            {
                throw;
            }
        }

        #endregion

        #region "botones"

        //protected void btnFiltro_Click(object sender, EventArgs e)
        //{
        //    string xmlResult = string.Empty;
        //    try
        //    {
        //        string xmlDash = Session["Dashboard"].ToString();
        //        string ParametroFiltroFecha = this.DD_Filt.SelectedValue.ToString();
        //        string ValoresComboSources = this.DD_DataSources.SelectedValue.ToString();
        //        string NameItem = this.DD_DataSources.SelectedItem.Text;

        //        if (this.DD_Filt.SelectedValue == "-1")
        //        {
        //            xmlResult = Session["Dashboard"].ToString();
        //            return;
        //        }

        //        xmlResult = this.ArmarXML(xmlDash, ParametroFiltroFecha, ValoresComboSources, NameItem);

        //        Session["DashboardLayout"] = xmlResult;

        //    }
        //    catch (Exception ex)
        //    {
        //        //throw;
        //    }
        //}


        //private string ParametrosPorDevolver(int ParametroFiltroFecha, bool VarPeriodo)
        //{
        //    string ResulParam = string.Empty;
        //    try
        //    {
        //        int Fecha = ParametroFiltroFecha;

        //        DateTime DT = DateTime.Now;

        //        DateTime DTMes = DT;

        //        if (Fecha > 0)
        //        {
        //            DTMes = DT.AddMonths(Fecha * -1);
        //        }
        //        else
        //        {
        //            DTMes = DT.AddMonths(0);
        //        }


        //        //DateTime DTMes = DT.AddMonths(Fecha * -1);

        //        if (VarPeriodo)
        //        {
        //            string Month = DTMes.Month.ToString();

        //            if (Month.Length == 1)
        //            {
        //                Month = "0" + Month;
        //            }

        //            ResulParam = DTMes.Year.ToString() + "-" + Month;
        //        }
        //        else
        //        {
        //            ResulParam = DTMes.Month.ToString();
        //        }

        //        //ResulParam = DTMes.Month.ToString();
        //        return ResulParam;
        //    }
        //    catch (Exception)
        //    {
        //        return ResulParam;
        //        //throw;
        //    }

        //}

        //private string ArmarXML(string xml, string ParametroFiltroFecha, string ValoresComboSources, string NameItem)
        //{
        //    string Result = string.Empty;
        //    try
        //    {

        //        System.Xml.XmlDocument xml_ = new XmlDocument();
        //        xml_.LoadXml(xml);
        //        System.Xml.XmlNodeList Nodes = xml_.GetElementsByTagName("Items");

        //        if (Nodes.Count > 0)
        //        {
        //            for (int i = 0; i < Nodes.Count; i++)
        //            {
        //                foreach (XmlNode item in Nodes.Item(i).ChildNodes)
        //                {
        //                    //if (item.Name == NameItem)
        //                    if (item.Attributes["Name"].InnerXml == NameItem)
        //                    {
        //                        if (item.Attributes["FilterString"] != null)
        //                        {
        //                            XmlAttribute FilterString_ = item.Attributes["FilterString"];
        //                            item.ParentNode.Attributes.Remove(FilterString_);
        //                        }

        //                        //dashboardOlapDataSource1;chartDashboardItem1;[Fechas].[Periodo].[Periodo];DataItem3
        //                        //Not [DataItem1] In ('[Date].[Month of Year].&amp;[1]', '[Date].[Month of Year].&amp;[2]', '[Date].[Month of Year].&amp;[3]')
        //                        //dashboardOlapDataSource3;chartDashboardItem2;[Date].[Month of Year].[Month of Year];DataItem1">Gráfico 2

        //                        string[] Valores = ValoresComboSources.Split(';');

        //                        string DataIt = Valores[3].ToString();
        //                        string ValueIt = string.Empty;

        //                        int Param = Convert.ToInt16(ParametroFiltroFecha.ToString());

        //                        if (Param == 0)
        //                        {
        //                            string[] Val_ = Valores[2].ToString().Split('.');
        //                            ValueIt += "'" + Val_[0].ToString() + "." + Val_[1].ToString() + ".&[";

        //                            //if ((Val_[0].IndexOf("Periodo") > -1) || (Val_[1].IndexOf("Periodo") > -1))
        //                            //{
        //                            //    ValueIt += this.ParametrosPorDevolver(Param, true) + "]'";
        //                            //}
        //                            //else
        //                            //{
        //                            //    ValueIt += this.ParametrosPorDevolver(Param, false) + "]'";
        //                            //}
        //                        }
        //                        else
        //                        {
        //                            for (int j = 1; j <= Param; j++)
        //                            {
        //                                if (j > 1)
        //                                {
        //                                    ValueIt += ",";
        //                                }
        //                                string[] Val_ = Valores[2].ToString().Split('.');
        //                                ValueIt += "'" + Val_[0].ToString() + "." + Val_[1].ToString() + ".&[";

        //                                //if ((Val_[0].IndexOf("Periodo") > -1) || (Val_[1].IndexOf("Periodo") > -1))
        //                                //{
        //                                //    ValueIt += this.ParametrosPorDevolver(j, true) + "]'";

        //                                //}
        //                                //else
        //                                //{
        //                                //    ValueIt += this.ParametrosPorDevolver(j, false) + "]'";
        //                                //}

        //                                //ValueIt += this.ParametrosPorDevolver_Mes(j) + "]'"; 
        //                            }

        //                        }

        //                        XmlAttribute Filter_String_;
        //                        Filter_String_ = xml_.CreateAttribute("FilterString");

        //                        Filter_String_.InnerText = DataIt + " In (" + ValueIt + ")";
        //                        item.Attributes.Append(Filter_String_);

        //                    }
        //                }
        //            }
        //        }

        //        Result = xml_.OuterXml;

        //        return Result;

        //    }
        //    catch (Exception)
        //    {
        //        return Result;
        //        //throw;
        //    }


        //}

        #endregion


        #region "Testing"


        protected void ASPxDashboardViewer1_SingleFilterDefaultValue(object sender, DevExpress.DashboardCommon.SingleFilterDefaultValueEventArgs e)
        {

            //if (e.DashboardItemName == "chartDashboardItem2")
            //{
            //    //e.SetFilterValue("01");

            //    // e.FilterValue.Aggregate( = "01";
            //    string n = string.Empty;// e.SetFilterValue("05");

            //}

        }

        protected void ASPxDashboardViewer1_CustomParameters(object sender, DevExpress.DashboardWeb.CustomParametersWebEventArgs e)
        {
            //var custIDParameter = e.Parameters.FirstOrDefault(p => p.Name == "P_Meses");
            //if (custIDParameter != null)
            //{
            //    custIDParameter.Value = "07";
            //}
            // Response.Redirect("Contenido.aspx");

        }

        protected void ASPxDashboardViewer1_ConfigureDataConnection(object sender, DevExpress.DashboardWeb.ConfigureDataConnectionWebEventArgs e)
        {
            string VconnectionString = string.Empty;
            //DevExpress.DataAccess.ConnectionParameters.OlapConnectionParameters parameters_ = (OlapConnectionParameters)e.ConnectionParameters;
            //if (parameters_ != null)
            //{
            //    VconnectionString = parameters_.ConnectionString; // = "provider=msolap;data source=10.90.124.16\sql2008;initial catalog=&quot;Adventure Works DW 2008R2&quot;;timeout=1200;Cube Name=Adventure Works;";


            //}

            //SqlServerConnectionParametersBase parameters = (SqlServerConnectionParametersBase)e.ConnectionParameters;
            //if (parameters != null)
            //{
            //    VconnectionString = System.Configuration.ConfigurationManager.AppSettings["ConexionSQL"].ToString();//.ConnectionString;//
            //    System.Data.SqlClient.SqlConnectionStringBuilder decoder = new System.Data.SqlClient.SqlConnectionStringBuilder(VconnectionString.Replace("Provider=SQLOLEDB.1;", ""));
            //    parameters.ServerName = decoder.DataSource;
            //    parameters.UserName = decoder.UserID;
            //    parameters.DatabaseName = decoder.InitialCatalog;
            //    parameters.Password = decoder.Password;
            //}
        }

        #endregion



    }
}