using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilitarios.Clases
{
    public class Amortizacion
    {
        private int id;
        private int idContrato;
        private int anio;
        private int nroCuota;
        private decimal valorCuota;
        private decimal interes;
        private decimal montoAmortizacion;
        private decimal saldo;
        private int estado;
        private string empresa;
        private int mes;

        public int Id { get => id; set => id = value; }
        public int IdContrato { get => idContrato; set => idContrato = value; }
        public int Anio { get => anio; set => anio = value; }
        public int NroCuota { get => nroCuota; set => nroCuota = value; }
        public decimal ValorCuota { get => valorCuota; set => valorCuota = value; }
        public decimal Interes { get => interes; set => interes = value; }
        public decimal MontoAmortizacion { get => montoAmortizacion; set => montoAmortizacion = value; }
        public decimal Saldo { get => saldo; set => saldo = value; }
        public int Estado { get => estado; set => estado = value; }
        public string Empresa { get => empresa; set => empresa = value; }
        public int Mes { get => mes; set => mes = value; }
    }
}
