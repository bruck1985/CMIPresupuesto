using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilitarios.Clases
{
    public class Depreciacion
    {
        private int id;
        private int idContrato;
        private int anio;
        private int mes;
        private int orden;
        private int nroCuota;
        private decimal cuotaAnual;
        private decimal valorPresente;
        private int estado;
        private string empresa;
        
        public int Id { get => id; set => id = value; }
        public int IdContrato { get => idContrato; set => idContrato = value; }
        public int Anio { get => anio; set => anio = value; }
        public int NroCuota { get => nroCuota; set => nroCuota = value; }
        public int Mes { get => mes; set => mes = value; }
        public int Orden { get => orden; set => orden = value; }
        public decimal CuotaAnual { get => cuotaAnual; set => cuotaAnual = value; }
        public decimal ValorPresente { get => valorPresente; set => valorPresente = value; }
        public int Estado { get => estado; set => estado = value; }
        public string Empresa { get => empresa; set => empresa = value; }
        
    }
}
