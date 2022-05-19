using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilitarios.Clases
{
    public class Usuario 
    {
        private string strCodUsuario;
        private string strNombre;
        private string strPassword;
        private List<Empresa> ltsEmpresas;
        private List<OpcionMenu> ltsMenu;

        public Usuario() {
            ltsEmpresas = new List<Empresa>();
            ltsMenu = new List<OpcionMenu>();
        }

        public string codUsuario {
            get { return strCodUsuario;}
            set { strCodUsuario = value; }
        }

        public string nombre {
            get { return strNombre; }
            set { strNombre = value; }
        }

        public string password {
            get { return strPassword; }
            set { strPassword = value; }
        }

        public List<Empresa> ltsEmpresa {
            get { return ltsEmpresas; }
            set { ltsEmpresas = value; }
        }

        public List<OpcionMenu> Menu {
            get { return ltsMenu; }
            set { ltsMenu = value; }
        }

        private string strError;
        public string StrError
        {
            get { return strError; }
            set { strError = value; }
        }
    }
}
