using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilitarios.Clases
{
    public class Activo
    {
        private string empresa;
        private string codActivo;
        private string nombreActivo;
        private string ubicacion;
        private string estadoActivo;
        private string codActivoMejora;
        private string nombreActivoMejora;
        private string responsable;
        private string nombreResponsable;
        private string fechaInventario;
        private string nombreEmpresa;
        private string nombreUbicacion;

        public string Empresa { get => empresa; set => empresa = value; }
        public string CodActivo { get => codActivo; set => codActivo = value; }
        public string NombreActivo { get => nombreActivo; set => nombreActivo = value; }
        public string Ubicacion { get => ubicacion; set => ubicacion = value; }
        public string EstadoActivo { get => estadoActivo; set => estadoActivo = value; }
        public string CodActivoMejora{ get => codActivoMejora; set => codActivoMejora = value; }
        public string NombreActivoMejora { get => nombreActivoMejora; set => nombreActivoMejora = value; }
        public string Responsable { get => responsable; set => responsable = value; }
        public string NombreResponsable { get => nombreResponsable; set => nombreResponsable = value; }
        public string FechaInventario { get => fechaInventario; set => fechaInventario = value; }
        public string NombreEmpresa { get => nombreEmpresa; set => nombreEmpresa = value; }
        public string NombreUbicacion { get => nombreUbicacion; set => nombreUbicacion = value; }
    }
}
