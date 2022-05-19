using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilitarios.Clases
{
    public class Arrendamiento
    {
        private int id;
        private int idContrato;
        private int anio;
        private decimal gastoInteres;
        private decimal gastoDepreciacion;
        private decimal totalGasto;
        private int correlativo;
        private decimal gastoAlquiler;
        private decimal mejorUtilidad;
        private string tipo;

        public int Id { get => id; set => id = value; }
        public int IdContrato { get => idContrato; set => idContrato = value; }
        public int Anio { get => anio; set => anio = value; }
        public decimal GastoInteres { get => gastoInteres; set => gastoInteres = value; }
        public decimal GastoDepreciacion { get => gastoDepreciacion; set => gastoDepreciacion = value; }
        public decimal TotalGasto { get => totalGasto; set => totalGasto = value; }
        public int Correlativo { get => correlativo; set => correlativo = value; }
        public decimal GastoAlquiler { get => gastoAlquiler; set => gastoAlquiler = value; }
        public decimal MejorUtilidad { get => mejorUtilidad; set => mejorUtilidad = value; }
        public string Tipo { get => tipo; set => tipo = value; }
    }
}
