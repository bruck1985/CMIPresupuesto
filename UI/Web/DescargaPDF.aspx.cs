using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Mime;
using System.Runtime.Serialization.Formatters.Binary;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI.Web
{
    public partial class DescargaPDF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*Response.ContentType = "Application/pdf";
            Response.BinaryWrite(ObjectToByteArray(Session["binaryData"]));
            Response.End();*/
            Response.ClearContent();
            Response.Buffer = true;
            Response.Cache.SetCacheability(HttpCacheability.Private);
            Response.ContentType = "application/pdf";

            ContentDisposition contentDisposition = new ContentDisposition();
            contentDisposition.FileName = Session["nombreDescarga"].ToString();
            
            contentDisposition.DispositionType = System.Net.Mime.DispositionTypeNames.Inline.ToString();
            Response.AddHeader("Content-Disposition", contentDisposition.ToString());
            Response.BinaryWrite(ObjectToByteArray(Session["binaryData"]));
            HttpContext.Current.ApplicationInstance.CompleteRequest();
            try
            {
                Response.End();
                Response.Flush();
            }
            catch (System.Threading.ThreadAbortException)
            {
            }
        }

        byte[] ObjectToByteArray(object obj)
        {
            if (obj == null)
                return null;
            BinaryFormatter bf = new BinaryFormatter();
            using (MemoryStream ms = new MemoryStream())
            {
                bf.Serialize(ms, obj);
                return ms.ToArray();
            }
        }
    }
}