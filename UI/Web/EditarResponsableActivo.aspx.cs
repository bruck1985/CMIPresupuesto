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
    public partial class EditarResponsableActivo : System.Web.UI.Page
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
                cargarResponsables(empresa);

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

                cbResponsableActual.ValueType = typeof(String);
                cbResponsableActual.Value = oActivo.Responsable;
                cbResponsableActual.Enabled = false;

                Session["nombreActivoArea"] = oActivo.NombreActivo;
                Session["nombreEmpresaArea"] = oActivo.NombreEmpresa;
                Session["nombreUbicacionArea"] = oActivo.NombreUbicacion;

                hdArea["hidden_value"] = oActivo.Ubicacion;
                hdEstado["hidden_value"] = oActivo.EstadoActivo;

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

        private void cargarResponsables(string empresa)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            String VSQL;
            //VSQL = "SELECT RESPONSABLE,NOMBRE FROM ME." + empresa + ".RESPONSABLE ORDER BY NOMBRE";
            VSQL = "SELECT RESPONSABLE,NOMBRE FROM PRUEBAS." + empresa + ".RESPONSABLE ORDER BY NOMBRE";
            SqlConnection conn = new SqlConnection(VconnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = VSQL;
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            cbResponsableActual.DataSource = ds;
            cbResponsableActual.ValueField = "RESPONSABLE";
            cbResponsableActual.TextField = "NOMBRE";
            cbResponsableActual.DataBind();

            cbNuevoResponsable.DataSource = ds;
            cbNuevoResponsable.ValueField = "RESPONSABLE";
            cbNuevoResponsable.TextField = "NOMBRE";
            cbNuevoResponsable.DataBind();
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

            int resultado = verificarExistenciaCambioResponsable(codEmpresa, codigoActivo, codigoActivoMejora);
            if (resultado == 0) //Si el resultado es cero quiere decir que no hay cambio pendiente. y se procede a solicitar el nuevo cambio.
            {
                LayoutItem LiNuevoResponsable = FormLayout.FindItemOrGroupByName("LiNuevoResponsable") as LayoutItem;
                ASPxComboBox txtNuevoResponsable = LiNuevoResponsable.GetNestedControl() as ASPxComboBox;
                string nuevoResponsable = "";
                if (txtNuevoResponsable != null)
                {
                    nuevoResponsable = txtNuevoResponsable.Value.ToString();
                }

                LayoutItem LiResponsable = FormLayout.FindItemOrGroupByName("LiResponsable") as LayoutItem;
                ASPxComboBox txtResponsableActual = LiResponsable.GetNestedControl() as ASPxComboBox;
                string responsableActual = "";
                if (txtResponsableActual != null)
                {
                    if (txtResponsableActual.Value==null)
                    {
                        lblValidacion.Text = "No se puede realizar el cambio de responsable actual, ya que actualmente no existe.";
                        PValidacion.ShowOnPageLoad = true;
                    }
                    else
                    {
                        responsableActual = txtResponsableActual.Value.ToString();
                    }
                    
                }

                if (Session["origen"].ToString().Equals("Seguimiento"))
                {
                    ActivoBL oActivo = new ActivoBL();
                    /*Se procede a realizar el cambio en la base de datos de Exactus */
                    if (codEmpresa.ToUpper().Equals("DVA") || codEmpresa.ToUpper().Equals("EOLO") || codEmpresa.ToUpper().Equals("PESRL") )
                    {
                        actualizarAccionExactus(codEmpresa, codigoActivo, codigoActivoMejora, "RES", "", nuevoResponsable, "");
                    }
                    else
                    {
                        actualizarAccionExactus(codEmpresa, codigoActivo, codigoActivoMejora, "RESP", "", nuevoResponsable, "");
                    }

                    if (codEmpresa.ToUpper().Equals("DVA") || codEmpresa.ToUpper().Equals("EOLO") || codEmpresa.ToUpper().Equals("PESRL"))
                    {
                        oActivo.insertarActivoAccion(codEmpresa, hdArea["hidden_value"].ToString(), nuevoResponsable, "RES", hdEstado["hidden_value"].ToString(), codigoActivo, Session["nombreUsuario"].ToString());
                    }
                    else
                    {
                        oActivo.insertarActivoAccion(codEmpresa, hdArea["hidden_value"].ToString(), nuevoResponsable, "RESP", hdEstado["hidden_value"].ToString(), codigoActivo, Session["nombreUsuario"].ToString());
                    }
                        
                    lblMensaje.Text = "Se realizo el cambio de responsable de manera exitosa.";
                    PAdvertencia.ShowOnPageLoad = true;
                    Response.Redirect("SeguimientoAF.aspx");
                }
                else
                {
                    ActivoBL oActivo = new ActivoBL();
                    /*Se procede a realizar el cambio en la base de datos de Exactus */
                    if (codEmpresa.ToUpper().Equals("DVA") || codEmpresa.ToUpper().Equals("EOLO") || codEmpresa.ToUpper().Equals("PESRL"))
                    {
                        actualizarAccionExactus(codEmpresa, codigoActivo, codigoActivoMejora, "RES", "", nuevoResponsable, "");
                    }
                    else
                    {
                        actualizarAccionExactus(codEmpresa, codigoActivo, codigoActivoMejora, "RESP", "", nuevoResponsable, "");
                    }

                    if (codEmpresa.ToUpper().Equals("DVA") || codEmpresa.ToUpper().Equals("EOLO") || codEmpresa.ToUpper().Equals("PESRL"))
                    {
                        oActivo.insertarActivoAccion(codEmpresa, hdArea["hidden_value"].ToString(), nuevoResponsable, "RES", hdEstado["hidden_value"].ToString(), codigoActivo, Session["nombreUsuario"].ToString());
                    }
                    else
                    {
                        oActivo.insertarActivoAccion(codEmpresa, hdArea["hidden_value"].ToString(), nuevoResponsable, "RESP", hdEstado["hidden_value"].ToString(), codigoActivo, Session["nombreUsuario"].ToString());
                    }
                        
                    lblMensaje.Text = "Se realizo el cambio de responsable de manera exitosa.";
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
                                sentencia = sentencia + "'RESP','P','" + Session["nombreUsuario"].ToString() + "',";
                                sentencia = sentencia + "'" + hdArea["hidden_value"].ToString() + "','" + nuevoResponsable + "','" + hdEstado["hidden_value"].ToString() + "','" + responsableActual + "','" + responsable + "')";

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
                DataTable dt= obtenerDatosExistentesCambioResponsable(codEmpresa, codigoActivo, codigoActivoMejora);
                lblMensaje.Text = "Ya existe una solicitud de cambio de Responsable pendiente de aprobar o rechazar, la cual fue enviada el dia " + dt.Rows[0].ItemArray[0].ToString() + " al responsable " + dt.Rows[0].ItemArray[1].ToString();
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
                    DataTable dtNuevoResponsable = obtenerNuevoResponsableCambio(empresa, idGestionActivo.ToString());

                    string to = dtresponsables.Rows[0].ItemArray[0].ToString();
                    string nombreResponsable = dtresponsables.Rows[0].ItemArray[1].ToString();
                    Session["nombreResponsable"] = nombreResponsable;
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
                    mailbody = mailbody + "por el presente correo se le comunica que ha sido iniciado un tramite de solicitud de cambio de responsable del siguiente activo: \n";
                    mailbody = mailbody + "<table><tr><td><b>Empresa</b></td><td>" + Session["nombreEmpresaArea"].ToString() + "</td></tr> ";
                    mailbody = mailbody + "<tr><td><b>Codigo Activo</b></td><td>" + codActivo + "</td></tr>";
                    mailbody = mailbody + "<tr><td><b>Nombre Activo</b></td><td>" + Session["nombreActivoArea"].ToString() + "</td></tr>";
                    mailbody = mailbody + "<tr><td><b>Responsable de Activo</b></td><td>" + nombreResponsable + "</td></tr>";
                    mailbody = mailbody + "<tr><td><b>Nuevo Responsable de Activo</b></td><td>" + dtNuevoResponsable.Rows[0].ItemArray[1].ToString() + "</td></tr>";
                    mailbody = mailbody + "<tr><td><b>Area</b></td><td>" + Session["nombreUbicacionArea"].ToString() + "</td></tr></table> \n";

                    /*mailbody = mailbody + "por el presente correo se le comunica que tiene una solicitud de cambio de responsable del activo " + codActivo;
                    mailbody = mailbody + ", para realizar la aprobación hacer clic en el siguiente link  <a href='" + urlAprobacion + "'>Aprobacion Cambio de Responsable</a> , ";
                    mailbody = mailbody + " caso contrario si se desea rechazar el cambio de responsable hacer clic en el siguiente link <a href='" + urlRechazo + "'>Rechazo Cambio de Responsable</a>";*/

                    message.Subject = empresa + " - Activo Fijo - Solicitud Cambio de Responsable";
                    message.Body = mailbody;
                    message.BodyEncoding = Encoding.UTF8;
                    message.IsBodyHtml = true;
                    message.CC.Add(ConfigurationManager.AppSettings["CORREO_COPIA_1"].ToString());
                    message.CC.Add(ConfigurationManager.AppSettings["CORREO_COPIA_2"].ToString());
                    if (!dtNuevoResponsable.Rows[0].ItemArray[0].ToString().Equals(""))
                    {
                        message.CC.Add(dtNuevoResponsable.Rows[0].ItemArray[0].ToString());
                    }
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
            /*VSQL = "SELECT E.E_MAIL,E.NOMBRE  FROM ME." + empresa + ".ACTIVO_MEJORA AM ";
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

        private DataTable obtenerNuevoResponsableCambio(string empresa, string IdCambio)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            String VSQL;
            /*VSQL = "SELECT isnull(E.E_MAIL,''),isnull(E.MOMBRE,'') FROM ME." + empresa + ".RESPONSABLE R ";
            VSQL = VSQL + " INNER JOIN ME." + empresa + ".EMPLEADO E ON E.EMPLEADO=R.EMPLEADO ";
            VSQL = VSQL + " INNER JOIN PORTAL.dbo.CONF_GESTION_ACTIVO C ON C.RESPONSABLE=R.RESPONSABLE ";
            VSQL = VSQL + " WHERE C.ID=" + IdCambio;*/

            VSQL = "SELECT isnull(E.E_MAIL,''),isnull(E.MOMBRE,'') FROM PRUEBAS." + empresa + ".RESPONSABLE R ";
            VSQL = VSQL + " INNER JOIN PRUEBAS." + empresa + ".EMPLEADO E ON E.EMPLEADO=R.EMPLEADO ";
            VSQL = VSQL + " INNER JOIN PORTAL.dbo.CONF_GESTION_ACTIVO C ON C.RESPONSABLE=R.RESPONSABLE ";
            VSQL = VSQL + " WHERE C.ID=" + IdCambio;

            SqlConnection conn = new SqlConnection(VconnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = VSQL;
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            return ds.Tables[0];
        }

        private int verificarExistenciaCambioResponsable(string empresa, string codActivo, string codActivoMejora)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            String VSQL;
            VSQL = "SELECT COUNT(*) FROM PORTAL.dbo.CONF_GESTION_ACTIVO WHERE EMPRESA='" + empresa + "' AND CODIGO_ACTIVO='" + codActivo + "' AND ESTADO='P' AND TIPO_ACCION_AF='RES' AND CODIGO_MEJORA='" + codActivoMejora + "'";
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

        private DataTable obtenerDatosExistentesCambioResponsable(string empresa, string codActivo, string codActivoMejora)
        {
            string VconnectionString;
            VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexionPruebas"].ConnectionString;
            //VconnectionString = ConfigurationManager.ConnectionStrings["SQLConexion"].ConnectionString;
            String VSQL;
            VSQL = "SELECT FECHA_CREACION, ISNULL(NOMBRE_RESPONSABLE_ORIGINAL,'') AS RESPONSABLE FROM PORTAL.dbo.CONF_GESTION_ACTIVO WHERE EMPRESA='" + empresa + "' AND CODIGO_ACTIVO='" + codActivo + "' AND ESTADO='P' AND TIPO_ACCION_AF='RES' AND CODIGO_MEJORA='" + codActivoMejora + "'";
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
