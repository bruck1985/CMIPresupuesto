using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data.SqlClient;
using System.Configuration;

namespace Utilitarios.Clases
{
    public class ClsTraductor
    {
        public ClsTraductor() { }

        public string TradPass(string Con)
        {
            string Result = string.Empty;
            try
            {
                SqlConnectionStringBuilder SqlSB = new SqlConnectionStringBuilder(Con);
                string Pass = SqlSB.Password;
                string DataSource = SqlSB.DataSource;
                string InitCatal = SqlSB.InitialCatalog;
                string user = SqlSB.UserID;
                SerEncrypt Srl = new SerEncrypt();
                string RealPass = Srl.desencriptar_(Pass);
                Result = string.Format("Data Source= {0};Initial Catalog={1};User={2}; Password={3}", DataSource, InitCatal, user, RealPass);

                return Result;

            }
            catch (Exception)
            {
                return Result;
                //throw;
            }
        }


    }
}
