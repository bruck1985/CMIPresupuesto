using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilitarios.Clases
{
    public class Empresa
    {
        private int intCodEmpresa;
        private string strNombre;

        public Empresa() { 
        }

        public Empresa(int pCodEmpresas, string pNombre) {
            intCodEmpresa = pCodEmpresas;
            strNombre = pNombre;
        }

        public int CodEmpresa
        {
            get { return intCodEmpresa; }
            set { intCodEmpresa = value; }
        }

        public string Nombre {
            get { return strNombre; }
            set { strNombre = value; }
        }
    }
}
