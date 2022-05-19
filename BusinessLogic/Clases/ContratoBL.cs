using DataAccess.Clases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilitarios.Clases;

namespace BusinessLogic.Clases
{
    public class ContratoBL
    {
        private ContratoDA oContratoDA;

        public ContratoBL()
        {
            oContratoDA = new ContratoDA();
        }

        public Contrato obtenerContrato(int pIdContrato)
        {

            Contrato oContrato = oContratoDA.obtenerContrato(pIdContrato);
            if (oContrato != null)
            {
                return oContrato;
            }
            else
            {
                return null;
            }
        }

        public List<CuotaAnual> obtenerCuotasAnualesContrato(int pIdContrato)
        {
            List<CuotaAnual> lstCuotas = oContratoDA.obtenerCuotasAnualesContrato(pIdContrato);
            return lstCuotas;
        }
        public List<Valor_Activo> obtenerDescuentoValorActivo(int pIdContrato)
        {
            List<Valor_Activo> lstValor = oContratoDA.obtenerDescuentoValorActivo(pIdContrato);
            return lstValor;
        }

        public List<Amortizacion> obtenerAmortizacionContrato(int pIdContrato)
        {
            List<Amortizacion> lstValor = oContratoDA.obtenerAmortizacionContrato(pIdContrato);
            return lstValor;
        }

        public List<Arrendamiento> obtenerArrendamiento(int pIdContrato)
        {
            List<Arrendamiento> lstValor = oContratoDA.obtenerArrendamiento(pIdContrato);
            return lstValor;
        }

        public Interes obtenerInteres(int pId)
        {
            Interes lstValor = oContratoDA.obtenerInteres(pId);
            return lstValor;
        }

        public Amortizacion obtenerAmortizacion(int pId)
        {
            Amortizacion lstValor = oContratoDA.obtenerAmortizacion(pId);
            return lstValor;
        }

        public void actualizarEstadoAmortizacion(int pId)
        {
            oContratoDA.actualizarEstadoAmortizacion(pId);
        }

        public void actualizarEstadoDepreciacion(int pId)
        {
            oContratoDA.actualizarEstadoDepreciacion(pId);
        }

        public void procesarCargadorAsiento(string strCia, string strPaquete, string strTipoAsiento, string strPreferencia)
        {
            oContratoDA.procesarCargadorAsiento(strCia,strPaquete,strTipoAsiento,strPreferencia);
        }

        public ConfiguracionContable obtenerConfiguracion(string empresa, string tipo, string concepto)
        {
            return oContratoDA.obtenerConfiguracion(empresa, tipo,concepto);
        }

        public Depreciacion obtenerDepreciacion(int pId)
        {
            Depreciacion lstValor = oContratoDA.obtenerDepreciacion(pId);
            return lstValor;
        }

        public int verificarExistenciaConfiguracion(string empresa, string tipo, int concepto)
        {
            return oContratoDA.verificarExistenciaConfiguracion(empresa, tipo, concepto);
        }

        public ConfiguracionContable obtenerConfiguracion(int id)
        {
            return oContratoDA.obtenerConfiguracion(id);
        }

        public void actualizarEstadoInteres(int pId)
        {
            oContratoDA.actualizarEstadoInteres(pId);
        }
    }
}
