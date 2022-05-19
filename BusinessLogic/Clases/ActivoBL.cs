using DataAccess.Clases;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilitarios.Clases;

namespace BusinessLogic.Clases
{
    public class ActivoBL
    {
        private ActivoDA oActivoDA;

        public ActivoBL()
        {
            oActivoDA = new ActivoDA();
        }

        public Activo obtenerActivo(string pEmpresa, string codActivo, string codMejora)
        {

            Activo oActivo = oActivoDA.obtenerActivo(pEmpresa, codActivo, codMejora);
            if (oActivo != null)
            {
                return oActivo;
            }
            else
            {
                return null;
            }
        }

        public DataTable obtenerActivoMejora(string pEmpresa, string codActivo, string codMejora)
        {
            DataTable oActivo = oActivoDA.obtenerActivoMejora(pEmpresa, codActivo, codMejora);
            if (oActivo != null)
            {
                return oActivo;
            }
            else
            {
                return null;
            }
        }

        public void insertarActivoAccion(string empresa, string ubicacion, string responsable, string tipoAccion, string estadoActivo, string activoFijo, string usuarioCreacion)
        {
            oActivoDA.insertarActivoAccion(empresa,ubicacion,responsable,tipoAccion,estadoActivo,activoFijo, usuarioCreacion);
        }
    }
}
