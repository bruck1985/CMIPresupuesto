using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilitarios.Clases
{
    public class Pagina
    {

        private string Contenido;
        private string User;
        private string Pass;

        public Pagina() { 
        }

        public string ContenidoPag
        {
            get{return Contenido;}
            set { Contenido = value; }
        }

        public string UserDB {
            get { return User; }
            set { User = value; }
        }

        public string PassDB {
            get { return Pass; }
            set { Pass = value; }
        }

    }
}
