using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilitarios.Clases
{
    public class ConfiguracionContable
    {
        private string empresa;
        private string tipo;
        private string centroCosto;
        private string cuentaContable;
        private int conceptoId;

        public string Empresa { get => empresa; set => empresa = value; }
        public string Tipo { get => tipo; set => tipo = value; }
        public string CentroCosto { get => centroCosto; set => centroCosto = value; }
        public string CuentaContable { get => cuentaContable; set => cuentaContable = value; }
        public int ConceptoId { get => conceptoId; set => conceptoId = value; }
    }
}
