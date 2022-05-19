using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilitarios.Clases
{
    public class OpcionMenu
    {
        private string strNombre;
        private string strId;
        private int intTipo;

        public OpcionMenu() {
        }

        public string Nombre {
            get { return strNombre; }
            set { strNombre = value; }
        }

        public string Id
        {
            get { return strId; }
            set { strId = value; }
        }

        public int Tipo {
            get { return intTipo; }
            set { intTipo = value; }
        }


    }
}
