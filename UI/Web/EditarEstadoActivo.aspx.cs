using BusinessLogic.Clases;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utilitarios.Clases;

namespace UI.Web
{
    public partial class EditarEstadoActivo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params["empresa"] != null && Request.Params["activo"] != null && Request.Params["mejora"] != null)
            {
                cargarEmpresas();
                string empresa = "";
                string codActivo = "";
                string mejora = "";
                empresa = Request.Params["empresa"];
                codActivo = Request.Params["activo"];
                mejora = Request.Params["mejora"];
                Session["origen"] = Request.Params["origen"];
                cargarEstadosActivo(empresa);

                ActivoBL objActivo = new ActivoBL();
                Activo oActivo = new Activo();

                oActivo = objActivo.obtenerActivo(empresa, codActivo, mejora);
                cbEmpresas.ValueType = typeof(String);
                cbEmpresas.Value = oActivo.Empresa;
                cbEmpresas.Enabled = false;

                txtCodigoActivo.Text = oActivo.CodActivo;
                txtCodigoActivo.Enabled = false;

                txtNombreActivo.Text = oActivo.NombreActivo;
                txtNombreActivo.Enabled = false;

                txtCodigoActivoMejora.Text = oActivo.CodActivoMejora;
                txtCodigoActivoMejora.Enabled = false;

                txtNombreActivoMejora.Text = oActivo.NombreActivoMejora;
                txtNombreActivoMejora.Enabled = false;

                cbEstadoActual.ValueType = typeof(String);
                cbEstadoActual.Value = oActivo.EstadoActivo;
                cbEstadoActual.Enabled = false;

                txtResponsableActivo.Text = oActivo.NombreResponsable;
                txtResponsableActivo.Enabled = false;

                Session["nombreActivoArea"] = oActivo.NombreActivo;
                Session["nombreEmpresaArea"] = oActivo.NombreEmpresa;
                Session["nombreUbicacionArea"] = oActivo.NombreUbicacion;

                hdArea["hidden_value"] = oActivo.Ubicacion;
                hdResponsable["hidden_value"] = oActivo.Responsable;
            }
        }

        private void cargarEmpresas()
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            String VSQL;
            VSQL = "SELECT CONJUNTO,NOMBRE FROM ERPADMIN.CONJUNTO ORDER BY CONJUNTO";
            SqlConnection conn = new SqlConnection(VconnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = VSQL;
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            cbEmpresas.DataSource = ds;
            cbEmpresas.ValueField = "CONJUNTO";
            cbEmpresas.TextField = "NOMBRE";
            cbEmpresas.DataBind();
        }

        private void cargarEstadosActivo(string empresa)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            String VSQL;
            //VSQL = "SELECT ESTADO_ACTIVO,DESCRIPCION FROM ME." + empresa + ".ESTADO_ACTIVO ORDER BY ESTADO_ACTIVO";
            VSQL = "SELECT ESTADO_ACTIVO,DESCRIPCION FROM PRUEBAS." + empresa + ".ESTADO_ACTIVO ORDER BY ESTADO_ACTIVO";
            SqlConnection conn = new SqlConnection(VconnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = VSQL;
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            cbEstadoActual.DataSource = ds;
            cbEstadoActual.ValueField = "ESTADO_ACTIVO";
            cbEstadoActual.TextField = "DESCRIPCION";
            cbEstadoActual.DataBind();

            cbNuevoEstado.DataSource = ds;
            cbNuevoEstado.ValueField = "ESTADO_ACTIVO";
            cbNuevoEstado.TextField = "DESCRIPCION";
            cbNuevoEstado.DataBind();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            if (Session["origen"].ToString().Equals("Seguimiento"))
            {
                Response.Redirect("SeguimientoAF.aspx");
            }
            else
            {
                Response.Redirect("GestionActivos.aspx");
            }
        }

        protected void Lform_E3_Click(object sender, EventArgs e)
        {
            LayoutItem LiEmpresa = FormLayout.FindItemOrGroupByName("LiEmpresa") as LayoutItem;
            ASPxComboBox cbEmpresa = LiEmpresa.GetNestedControl() as ASPxComboBox;
            string codEmpresa = "";
            if (cbEmpresa != null)
            {
                codEmpresa = cbEmpresa.Value.ToString();
            }

            LayoutItem LiCodigoActivo = FormLayout.FindItemOrGroupByName("LiCodigoActivo") as LayoutItem;
            ASPxTextBox txtCodigoActivo = LiCodigoActivo.GetNestedControl() as ASPxTextBox;
            string codigoActivo = "";
            if (txtCodigoActivo != null)
            {
                codigoActivo = txtCodigoActivo.Value.ToString();
            }

            LayoutItem LiCodigoActivoMejora = FormLayout.FindItemOrGroupByName("LiCodigoActivoMejora") as LayoutItem;
            ASPxTextBox txtCodigoActivoMejora = LiCodigoActivoMejora.GetNestedControl() as ASPxTextBox;
            string codigoActivoMejora = "";
            if (txtCodigoActivoMejora != null)
            {
                codigoActivoMejora = txtCodigoActivoMejora.Value.ToString();
            }

            int resultado = verificarExistenciaCambioEstado(codEmpresa, codigoActivo, codigoActivoMejora);
            if (resultado == 0) //Si el resultado es cero quiere decir que no hay cambio pendiente. y se procede a solicitar el nuevo cambio.
            {
                LayoutItem LiNuevoEstadoActivo = FormLayout.FindItemOrGroupByName("LiNuevoEstadoActivo") as LayoutItem;
                ASPxComboBox txtNuevoEstado = LiNuevoEstadoActivo.GetNestedControl() as ASPxComboBox;
                string nuevoEstado = "";
                if (txtNuevoEstado != null)
                {
                    nuevoEstado = txtNuevoEstado.Value.ToString();
                }

                if (Session["origen"].ToString().Equals("Seguimiento"))
                {
                    ActivoBL oActivo = new ActivoBL();
                    /*Se procede a realizar el cambio en la base de datos de Exactus */
                    actualizarAccionExactus(codEmpresa, codigoActivo, codigoActivoMejora, "EST", "","",nuevoEstado);

                    oActivo.insertarActivoAccion(codEmpresa, hdArea["hidden_value"].ToString(), hdResponsable["hidden_value"].ToString(), "EST", nuevoEstado, codigoActivo, Session["nombreUsuario"].ToString());

                    lblMensaje.Text = "Se realizo el cambio de estado de manera exitosa.";
                    PAdvertencia.ShowOnPageLoad = true;
                    Response.Redirect("SeguimientoAF.aspx");
                }
                else
                {
                    ActivoBL oActivo = new ActivoBL();
                    /*Se procede a realizar el cambio en la base de datos de Exactus */
                    actualizarAccionExactus(codEmpresa, codigoActivo, codigoActivoMejora, "EST", "", "", nuevoEstado);

                    oActivo.insertarActivoAccion(codEmpresa, hdArea["hidden_value"].ToString(), hdResponsable["hidden_value"].ToString(), "EST", nuevoEstado, codigoActivo, Session["nombreUsuario"].ToString());

                    lblMensaje.Text = "Se realizo el cambio de estado de manera exitosa.";
                    PAdvertencia.ShowOnPageLoad = true;
                    /*Conexión a la BD*/
                    /*string VconnectionString;
                    VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
                    SqlConnection dbSQL = new SqlConnection(VconnectionString);

                    try
                    {
                        DataTable dtresponsables = new DataTable();
                        dtresponsables = obtenerResponsableMejora(codEmpresa, codigoActivo, codigoActivoMejora);
                        if (dtresponsables != null)
                        {
                            if (dtresponsables.Rows.Count > 0)
                            {
                                if (dbSQL.State != ConnectionState.Open)
                                    dbSQL.Open();

                                string responsable = dtresponsables.Rows[0].ItemArray[1].ToString();
                                string sentencia = "INSERT INTO PORTAL.dbo.CONF_GESTION_ACTIVO (EMPRESA,CODIGO_ACTIVO,CODIGO_MEJORA,";
                                sentencia = sentencia + "TIPO_ACCION_AF,ESTADO,USUARIO_CREACION,";
                                sentencia = sentencia + "UBICACION,RESPONSABLE,ESTADO_ACTIVO,RESPONSABLE_ORIGINAL,NOMBRE_RESPONSABLE_ORIGINAL) VALUES ('" + codEmpresa + "','" + codigoActivo + "','" + codigoActivoMejora + "',";
                                sentencia = sentencia + "'EST','P','" + Session["nombreUsuario"].ToString() + "',";
                                sentencia = sentencia + "'" + hdArea["hidden_value"].ToString() + "','" + hdResponsable["hidden_value"].ToString() + "','" + nuevoEstado + "','" + hdResponsable["hidden_value"].ToString() + "','" + responsable + "')";

                                SqlCommand ComandoConsulta = new SqlCommand();
                                ComandoConsulta.CommandText = sentencia;
                                ComandoConsulta.Connection = dbSQL;
                                ComandoConsulta.ExecuteNonQuery();

                                enviarCorreoResponsable(codEmpresa, codigoActivo, codigoActivoMejora);
                            }
                            else
                            {
                                PResponsable.ShowOnPageLoad = true;
                                return;
                            }
                        }
                        else
                        {
                            PResponsable.ShowOnPageLoad = true;
                            return;
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.Write(ex.Message);
                    }
                    finally
                    {
                        if (dbSQL.State == ConnectionState.Open)
                            dbSQL.Close();
                    }*/
                    Response.Redirect("GestionActivos.aspx");
                }
            }
            else
            {
                DataTable dt = obtenerDatosExistentesCambioEstado(codEmpresa, codigoActivo, codigoActivoMejora);
                lblMensaje.Text = "Ya existe una solicitud de cambio de Estado pendiente de aprobar o rechazar, la cual fue enviada el dia " + dt.Rows[0].ItemArray[0].ToString() + " al responsable " + dt.Rows[0].ItemArray[1].ToString() ;
                PAdvertencia.ShowOnPageLoad = true;
            }
        }

        private void actualizarAccionExactus(string empresa, string activo, string mejora, string tipo, string ubicacion, string responsable, string estado)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            SqlConnection dbSQL = new SqlConnection(VconnectionString);
            try
            {
                if (dbSQL.State != ConnectionState.Open)
                    dbSQL.Open();

                string sentencia = "";
                if (tipo.Equals("UBI")) //Si es cambio de area o ubicacion
                {
                    //sentencia = "UPDATE ME." + empresa + ".ACTIVO_FIJO SET UBICACION='" + ubicacion + "' WHERE ACTIVO_FIJO='" + activo + "'";
                    sentencia = "UPDATE PRUEBAS." + empresa + ".ACTIVO_FIJO SET UBICACION='" + ubicacion + "' WHERE ACTIVO_FIJO='" + activo + "'";
                }
                else
                {
                    if (tipo.Equals("EST")) //Si es cambio de estado
                    {
                        //sentencia = "UPDATE ME." + empresa + ".ACTIVO_FIJO SET ESTADO_ACTIVO='" + estado + "' WHERE ACTIVO_FIJO='" + activo + "'";
                        sentencia = "UPDATE PRUEBAS." + empresa + ".ACTIVO_FIJO SET ESTADO_ACTIVO='" + estado + "' WHERE ACTIVO_FIJO='" + activo + "'";
                    }
                    else
                    {
                        //if (tipo.Equals("RES"))
                        if (tipo.Equals("RESP") || tipo.Equals("RES"))
                        {
                            //sentencia = "UPDATE ME." + empresa + ".ACTIVO_MEJORA SET RESPONSABLE='" + responsable + "' WHERE ACTIVO_FIJO='" + activo + "' and MEJORA='" + mejora + "'";
                            sentencia = "UPDATE PRUEBAS." + empresa + ".ACTIVO_MEJORA SET RESPONSABLE='" + responsable + "' WHERE ACTIVO_FIJO='" + activo + "' and MEJORA='" + mejora + "'";
                        }
                    }
                }
                SqlCommand ComandoConsulta = new SqlCommand();
                ComandoConsulta.CommandText = sentencia;
                ComandoConsulta.Connection = dbSQL;
                ComandoConsulta.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
            }
            finally
            {
                if (dbSQL.State == ConnectionState.Open)
                    dbSQL.Close();
            }
        }

        private void enviarCorreoResponsable(string empresa, string codActivo, string codActivoMejora)
        {
            DataTable dtresponsables = new DataTable();
            dtresponsables = obtenerResponsableMejora(empresa, codActivo, codActivoMejora);
            if (dtresponsables != null)
            {
                if (dtresponsables.Rows.Count > 0)
                {
                    //string to = "";
                    string urlAprobacion = obtener_parametro("URL_APROBACION_ACTIVO");
                    string urlRechazo = obtener_parametro("URL_RECHAZO_ACTIVO");
                    int idGestionActivo = obtenerIdGestionActivo();
                    urlAprobacion = urlAprobacion + "?id=" + idGestionActivo.ToString();
                    urlRechazo = urlRechazo + "?id=" + idGestionActivo.ToString();
                    string to = dtresponsables.Rows[0].ItemArray[0].ToString();
                    string nombreResponsable = dtresponsables.Rows[0].ItemArray[1].ToString();
                    Session["nombreResponsable"] = nombreResponsable;
                    //string from = "jpalomino@jockey-plaza.com.pe";
                    string from = ConfigurationManager.AppSettings["USUARIO_CORREO"].ToString();
                    string indicador = ConfigurationManager.AppSettings["FLAG_ENVIO"].ToString();
                    if (indicador.Equals("1"))
                    {
                        to = ConfigurationManager.AppSettings["CORREO_DESTINO_DEFAULT"].ToString();
                    }
                    else
                    {
                        to = dtresponsables.Rows[0].ItemArray[0].ToString();
                    }
                    MailMessage message = new MailMessage(from, to);

                    string mailbody = "Estimado " + nombreResponsable + "\n";
                    mailbody = mailbody + "por el presente correo se le comunica que ha sido iniciado un tramite de solicitud de cambio de estado del siguiente activo: \n";
                    mailbody = mailbody + "<table><tr><td><b>Empresa</b></td><td>" + Session["nombreEmpresaArea"].ToString() + "</td></tr> ";
                    mailbody = mailbody + "<tr><td><b>Codigo Activo</b></td><td>" + codActivo + "</td></tr>";
                    mailbody = mailbody + "<tr><td><b>Nombre Activo</b></td><td>" + Session["nombreActivoArea"].ToString() + "</td></tr>";
                    mailbody = mailbody + "<tr><td><b>Responsable de Activo</b></td><td>" + nombreResponsable + "</td></tr>";
                    mailbody = mailbody + "<tr><td><b>Area</b></td><td>" + Session["nombreUbicacionArea"].ToString() + "</td></tr></table> \n";

                    mailbody = mailbody + "Para realizar la aprobación hacer clic en el siguiente link  <a href='" + urlAprobacion + "'>Aprobacion Cambio de Estado</a> , ";
                    mailbody = mailbody + " caso contrario si se desea rechazar el cambio de estado hacer clic en el siguiente link <a href='" + urlRechazo + "'>Rechazo Cambio de Estado</a>";
                    /*mailbody = mailbody + "por el presente correo se le comunica que tiene una solicitud de cambio de estado del activo " + codActivo;
                    mailbody = mailbody + ", para realizar la aprobación hacer clic en el siguiente link  <a href='" + urlAprobacion + "'>Aprobacion Cambio de Estado</a> , ";
                    mailbody = mailbody + " caso contrario si se desea rechazar el cambio de estado hacer clic en el siguiente link <a href='" + urlRechazo + "'>Rechazo Cambio de Estado</a>";*/
                    message.Subject = empresa + " - Activo Fijo - Solicitud Cambio de Estado";
                    message.Body = mailbody;
                    message.BodyEncoding = Encoding.UTF8;
                    message.IsBodyHtml = true;
                    message.CC.Add(ConfigurationManager.AppSettings["CORREO_COPIA_1"].ToString());
                    message.CC.Add(ConfigurationManager.AppSettings["CORREO_COPIA_2"].ToString());
                    string servidorSMTP = ConfigurationManager.AppSettings["SERVIDOR_SMTP"].ToString();
                    string puertoSMTP = ConfigurationManager.AppSettings["PUERTO_SERVIDOR_SMTP"].ToString();
                    SmtpClient client = new SmtpClient(servidorSMTP, Convert.ToInt32(puertoSMTP)); //Gmail smtp    
                    string clave = ConfigurationManager.AppSettings["CLAVE_CORREO"].ToString();
                    System.Net.NetworkCredential basicCredential1 = new
                    System.Net.NetworkCredential(from, clave);
                    client.EnableSsl = false;
                    client.UseDefaultCredentials = false;
                    client.Credentials = basicCredential1;
                    try
                    {
                        client.Send(message);
                    }

                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
            }
        }

        private int obtenerIdGestionActivo()
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            String VSQL;
            VSQL = "SELECT max(id) from  Portal.dbo.CONF_GESTION_ACTIVO";
            SqlConnection conn = new SqlConnection(VconnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = VSQL;
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            return Convert.ToInt32(ds.Tables[0].Rows[0].ItemArray[0].ToString());
        }

        private string obtener_parametro(string nombreParametro)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            String VSQL;
            VSQL = "SELECT VALOR_PARAMETRO FROM PORTAL.dbo.PARAMETRO_ACTIVO_FIJO WHERE NOMBRE_PARAMETRO='" + nombreParametro + "' ";
            SqlConnection conn = new SqlConnection(VconnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = VSQL;
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            return ds.Tables[0].Rows[0].ItemArray[0].ToString();
        }

        private DataTable obtenerResponsableMejora(string empresa, string codActivo, string codActivoMejora)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            String VSQL;
            /*VSQL = "SELECT E.E_MAIL,E.NOMBRE  FROM me." + empresa + ".ACTIVO_MEJORA AM ";
            VSQL = VSQL + " INNER JOIN ME." + empresa + ".RESPONSABLE R ON AM.RESPONSABLE = R.RESPONSABLE ";
            VSQL = VSQL + " INNER JOIN ME." + empresa + ".EMPLEADO E ON E.EMPLEADO = R.EMPLEADO";
            VSQL = VSQL + " WHERE AM.ACTIVO_FIJO='" + codActivo + "' AND AM.MEJORA='" + codActivoMejora + "' ";*/

            VSQL = "SELECT E.E_MAIL,E.NOMBRE  FROM PRUEBAS." + empresa + ".ACTIVO_MEJORA AM ";
            VSQL = VSQL + " INNER JOIN PRUEBAS." + empresa + ".RESPONSABLE R ON AM.RESPONSABLE = R.RESPONSABLE ";
            VSQL = VSQL + " INNER JOIN PRUEBAS." + empresa + ".EMPLEADO E ON E.EMPLEADO = R.EMPLEADO";
            VSQL = VSQL + " WHERE AM.ACTIVO_FIJO='" + codActivo + "' AND AM.MEJORA='" + codActivoMejora + "' ";

            SqlConnection conn = new SqlConnection(VconnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = VSQL;
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            return ds.Tables[0];
        }

        private int verificarExistenciaCambioEstado(string empresa, string codActivo, string codActivoMejora)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            String VSQL;
            VSQL = "SELECT COUNT(*) FROM PORTAL.dbo.CONF_GESTION_ACTIVO WHERE EMPRESA='" + empresa + "' AND CODIGO_ACTIVO='" + codActivo + "' AND ESTADO='P' AND TIPO_ACCION_AF='EST' AND CODIGO_MEJORA='" + codActivoMejora + "'";
            SqlConnection conn = new SqlConnection(VconnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = VSQL;
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            int resultado = Convert.ToInt32(ds.Tables[0].Rows[0].ItemArray[0].ToString());
            return resultado;
        }

        private DataTable obtenerDatosExistentesCambioEstado(string empresa, string codActivo, string codActivoMejora)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            String VSQL;
            VSQL = "SELECT FECHA_CREACION, ISNULL(NOMBRE_RESPONSABLE_ORIGINAL,'') AS RESPONSABLE FROM PORTAL.dbo.CONF_GESTION_ACTIVO WHERE EMPRESA='" + empresa + "' AND CODIGO_ACTIVO='" + codActivo + "' AND ESTADO='P' AND TIPO_ACCION_AF='EST' AND CODIGO_MEJORA='" + codActivoMejora + "'";
            SqlConnection conn = new SqlConnection(VconnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = VSQL;
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            return ds.Tables[0];
        }
    }
}
