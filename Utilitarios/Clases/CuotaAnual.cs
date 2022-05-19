using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilitarios.Clases
{
    public class CuotaAnual
    {
        private int id;
        private int contratoId;
        private int anio;
        private int nroCuota;
        private decimal montocuotaAnual;
        private decimal primerTramo;
        private decimal segundoTramo;
        private decimal cuotaAnualFinal;

        public int Id { get => id; set => id = value; }
        public int ContratoId { get => contratoId; set => contratoId = value; }
        public int Anio { get => anio; set => anio = value; }
        public int NroCuota { get => nroCuota; set => nroCuota = value; }
        public decimal MontoCuotaAnual { get => montocuotaAnual; set => montocuotaAnual = value; }
        public decimal PrimerTramo { get => primerTramo; set => primerTramo = value; }
        public decimal SegundoTramo { get => segundoTramo; set => segundoTramo = value; }
        public decimal CuotaAnualFinal { get => cuotaAnualFinal; set => cuotaAnualFinal = value; }
    }
}
