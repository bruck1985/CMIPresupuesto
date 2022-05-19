using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilitarios.Clases
{
    public class Contrato
    {
        private int idContrato;
        private string nombreContrato;
        private string pais;
        private string entidad;
        private int monedaLocal;
        private string descripcionActivo;
        private string arrendador;
        private string arrendadorAfiliado;
        private int subarriendo;
        private decimal cuotaArrendamiento;
        private int cantidadArrendamiento;
        private int monedaArrendamiento;
        private string fechaInicioArrendamiento;
        private string fechaVencimientoArrendamiento;
        private int mesesTranscurridos;
        private int mesesPendientes;
        private string plazoContrato;
        private int mesesEfectivos;
        private string frecuenciaPagos;
        private int garantiaPagada;
        private decimal montoGarantiaPagada;
        private int costosIniciales;
        private string descripcionCostos;
        private int opcionCompra;
        private decimal montoOpcionCompra;
        private int costoDesmantelamiento;
        private decimal montoCostoDesmantelamiento;
        private int clausulaExtension;
        private string plazoClausula;
        private int probabilidadExtension;
        private int clausulaTerminacion;
        private int probabilidadTerminacion;
        private int aumentoPagoMinimo;
        private decimal porcentajeAumento;
        private string perioricidadAumento;
        private int costosIndirectos;
        private decimal montoCostoIndirecto;
        private int valorResidual;
        private decimal montoValorResidual;
        private int cortoPlazo;
        private int bajoValor;
        private decimal tasaAnual;
        private int perioricidadCuota;
        private decimal tasaDescuento;
        private string empresa;

        public int IdContrato { get => idContrato; set => idContrato = value; }
        public string NombreContrato { get => nombreContrato; set => nombreContrato = value; }
        public string Pais { get => pais; set => pais = value; }
        public string Entidad { get => entidad; set => entidad = value; }
        public int MonedaLocal { get => monedaLocal; set => monedaLocal = value; }
        public string DescripcionActivo { get => descripcionActivo; set => descripcionActivo = value; }
        public string Arrendador { get => arrendador; set => arrendador = value; }
        public string ArrendadorAfiliado { get => arrendadorAfiliado; set => arrendadorAfiliado = value; }
        public int Subarriendo { get => subarriendo; set => subarriendo = value; }
        public decimal CuotaArrendamiento { get => cuotaArrendamiento; set => cuotaArrendamiento = value; }
        public int CantidadArrendamiento { get => cantidadArrendamiento; set => cantidadArrendamiento = value; }
        public int MonedaArrendamiento { get => monedaArrendamiento; set => monedaArrendamiento = value; }
        public string FechaInicioArrendamiento { get => fechaInicioArrendamiento; set => fechaInicioArrendamiento = value; }
        public string FechaVencimientoArrendamiento { get => fechaVencimientoArrendamiento; set => fechaVencimientoArrendamiento = value; }
        public int MesesTranscurridos { get => mesesTranscurridos; set => mesesTranscurridos = value; }
        public int MesesPendientes { get => mesesPendientes; set => mesesPendientes = value; }
        public string PlazoContrato { get => plazoContrato; set => plazoContrato = value; }
        public int MesesEfectivos { get => mesesEfectivos; set => mesesEfectivos = value; }
        public string FrecuenciaPagos { get => frecuenciaPagos; set => frecuenciaPagos = value; }
        public int GarantiaPagada { get => garantiaPagada; set => garantiaPagada = value; }
        public decimal MontoGarantiaPagada { get => montoGarantiaPagada; set => montoGarantiaPagada = value; }
        public int CostosIniciales { get => costosIniciales; set => costosIniciales = value; }
        public string DescripcionCostos { get => descripcionCostos; set => descripcionCostos = value; }
        public int OpcionCompra { get => opcionCompra; set => opcionCompra = value; }
        public decimal MontoOpcionCompra { get => montoOpcionCompra; set => montoOpcionCompra = value; }
        public int CostoDesmantelamiento { get => costoDesmantelamiento; set => costoDesmantelamiento = value; }
        public decimal MontoCostoDesmantelamiento { get => montoCostoDesmantelamiento; set => montoCostoDesmantelamiento = value; }
        public int ClausulaExtension { get => clausulaExtension; set => clausulaExtension = value; }
        public string PlazoClausula { get => plazoClausula; set => plazoClausula = value; }
        public int ProbabilidadExtension { get => probabilidadExtension; set => probabilidadExtension = value; }
        public int ClausulaTerminacion { get => clausulaTerminacion; set => clausulaTerminacion = value; }
        public int ProbabilidadTerminacion { get => probabilidadTerminacion; set => probabilidadTerminacion = value; }
        public int AumentoPagoMinimo { get => aumentoPagoMinimo; set => aumentoPagoMinimo = value; }
        public decimal PorcentajeAumento { get => porcentajeAumento; set => porcentajeAumento = value; }
        public string PerioricidadAumento { get => perioricidadAumento; set => perioricidadAumento = value; }
        public int CostosIndirectos { get => costosIndirectos; set => costosIndirectos = value; }
        public decimal MontoCostoIndirecto { get => montoCostoIndirecto; set => montoCostoIndirecto = value; }
        public int ValorResidual { get => valorResidual; set => valorResidual = value; }
        public decimal MontoValorResidual { get => montoValorResidual; set => montoValorResidual = value; }
        public int CortoPlazo { get => cortoPlazo; set => cortoPlazo = value; }
        public int BajoValor { get => bajoValor; set => bajoValor = value; }
        public decimal TasaAnual { get => tasaAnual; set => tasaAnual = value; }
        public int PerioricidadCuota { get => perioricidadCuota; set => perioricidadCuota = value; }
        public decimal TasaDescuento { get => tasaDescuento; set => tasaDescuento = value; }
        public string Empresa { get => empresa; set => empresa = value; }
    }
}
