<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Presupuesto_Resumen.aspx.cs" Inherits="UI.Web.Presupuesto_Resumen" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">


.dxpcLite .dxpc-header,
.dxdpLite .dxpc-header 
{
	color: #404040;
	background-color: #DCDCDC;
	border-bottom: 1px solid #C9C9C9;
	padding: 2px 2px 2px 12px;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">

        var FocusedCellColumnIndex = 0;
        var FocusedCellRowIndex = 0;
        var lastRecordIndex;
        var colCount;
        var firstRecordIndex;

        var lastRecordIndexC;
        var colCountC;
        var firstRecordIndexC;

        var bots;
        var bote;


        var curentEditingIndex;
        var lastCia = null;
        var isCustomCascadingCallback = { "CuentaCombo": false, "CentroCombo": false };

        function CIACombo_SelectedIndexChanged(s, e) {
            lastCia = s.GetValue();
            isCustomCascadingCallback.CuentaCombo = true;
            isCustomCascadingCallback.CentroCombo = true;
            RefreshData(lastCia);
        }

           function OnBatchEditStartEditing(s, e) {
            curentEditingIndex = e.visibleIndex;
            var currentCIA = grid.batchEditApi.GetCellValue(curentEditingIndex, "CIA");
            if (currentCIA != lastCia && e.focusedColumn.fieldName == "CUENTA_CONTABLE" && currentCIA != null) {
                lastCia = currentCIA;
                RefreshData(currentCIA);
               }
            

           if (currentCIA != lastCia && e.focusedColumn.fieldName == "CENTRO_COSTO" && currentCIA != null) {
                lastCia = currentCIA;
                RefreshData(currentCIA);
               }
            }


             function copydata(s, e) {
            curentEditingIndex = e.visibleIndex;
                var PENERO =   s.batchEditApi.GetCellValue(e.visibleIndex, "ENERO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "ENERO") : 0;  
                var PFEBRERO = s.batchEditApi.GetCellValue(e.visibleIndex, "FEBRERO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FEBRERO") : 0;  
                var PMARZO = s.batchEditApi.GetCellValue(e.visibleIndex, "MARZO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "MARZO") : 0;  
                var PABRIL = s.batchEditApi.GetCellValue(e.visibleIndex, "ABRIL") ? s.batchEditApi.GetCellValue(e.visibleIndex, "ABRIL") : 0;  
                var PMAYO = s.batchEditApi.GetCellValue(e.visibleIndex, "MAYO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "MAYO") : 0;  
                var PJUNIO = s.batchEditApi.GetCellValue(e.visibleIndex, "JUNIO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "JUNIO") : 0;  
                var PJULIO = s.batchEditApi.GetCellValue(e.visibleIndex, "JULIO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "JULIO") : 0;  
                var PAGOSTO = s.batchEditApi.GetCellValue(e.visibleIndex, "AGOSTO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "AGOSTO") : 0;  
                var PSEPTIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "SEPTIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "SEPTIEMBRE") : 0;  
                var POCTUBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "OCTUBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "OCTUBRE") : 0;  
                var PNOVIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "NOVIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "NOVIEMBRE") : 0;  
                var PDICIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "DICIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "DICIEMBRE") : 0;   

               s.batchEditApi.SetCellValue(e.visibleIndex, "FEBRERO", (parseFloat(PENERO) ), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "MARZO", (parseFloat(PENERO) ), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "ABRIL", (parseFloat(PENERO) ), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "MAYO", (parseFloat(PENERO) ), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "JUNIO", (parseFloat(PENERO) ), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "JULIO", (parseFloat(PENERO) ), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "AGOSTO", (parseFloat(PENERO) ), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "SEPTIEMBRE", (parseFloat(PENERO)), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "OCTUBRE", (parseFloat(PENERO)), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "NOVIEMBRE", (parseFloat(PENERO)), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "DICIEMBRE", (parseFloat(PENERO)), null, true);  

        }


        function CuentaCombo_EndCallback(s, e) {
            if (isCustomCascadingCallback.CuentaCombo) {
                if (s.GetItemCount() > 0)
                    grid.batchEditApi.SetCellValue(curentEditingIndex, "CUENTA_CONTABLE", s.GetItem(0).value);
                isCustomCascadingCallback.CuentaCombo = false;
            }
        }
        function CentroCombo_EndCallback(s, e) {
            if (isCustomCascadingCallback.CentroCombo) {
                if (s.GetItemCount() > 0)
                    grid.batchEditApi.SetCellValue(curentEditingIndex, "CENTRO_COSTO", s.GetItem(0).value);
                isCustomCascadingCallback.CentroCombo = false;
            }
        }

        function RefreshData(CIAValue) {
            hf.Set("CurrentCIA", CIAValue);
            CuentaEditor.PerformCallback();
            CentroEditor.PerformCallback();
        }

        function OnBatchEditEndEditing(s, e) {  
            window.setTimeout(function () {  
                var PENERO =   s.batchEditApi.GetCellValue(e.visibleIndex, "ENERO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "ENERO") : 0;  
                var PFEBRERO = s.batchEditApi.GetCellValue(e.visibleIndex, "FEBRERO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FEBRERO") : 0;  
                var PMARZO = s.batchEditApi.GetCellValue(e.visibleIndex, "MARZO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "MARZO") : 0;  
                var PABRIL = s.batchEditApi.GetCellValue(e.visibleIndex, "ABRIL") ? s.batchEditApi.GetCellValue(e.visibleIndex, "ABRIL") : 0;  
                var PMAYO = s.batchEditApi.GetCellValue(e.visibleIndex, "MAYO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "MAYO") : 0;  
                var PJUNIO = s.batchEditApi.GetCellValue(e.visibleIndex, "JUNIO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "JUNIO") : 0;  
                var PJULIO = s.batchEditApi.GetCellValue(e.visibleIndex, "JULIO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "JULIO") : 0;  
                var PAGOSTO = s.batchEditApi.GetCellValue(e.visibleIndex, "AGOSTO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "AGOSTO") : 0;  
                var PSEPTIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "SEPTIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "SEPTIEMBRE") : 0;  
                var POCTUBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "OCTUBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "OCTUBRE") : 0;  
                var PNOVIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "NOVIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "NOVIEMBRE") : 0;  
                var PDICIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "DICIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "DICIEMBRE") : 0;  

                s.batchEditApi.SetCellValue(e.visibleIndex, "Sum", (parseFloat(PENERO) + parseFloat(PFEBRERO) + parseFloat(PMARZO) + parseFloat(PABRIL) + parseFloat(PMAYO) + parseFloat(PJUNIO) + parseFloat(PJULIO) + parseFloat(PAGOSTO) + parseFloat(PSEPTIEMBRE) + parseFloat(POCTUBRE) + parseFloat(PNOVIEMBRE) + parseFloat(PDICIEMBRE)), null, true);  

                var FENERO =   s.batchEditApi.GetCellValue(e.visibleIndex, "FENERO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FENERO") : 0;  
                var FFEBRERO = s.batchEditApi.GetCellValue(e.visibleIndex, "FFEBRERO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FFEBRERO") : 0;  
                var FMARZO = s.batchEditApi.GetCellValue(e.visibleIndex, "FMARZO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FMARZO") : 0;  
                var FABRIL = s.batchEditApi.GetCellValue(e.visibleIndex, "FABRIL") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FABRIL") : 0;  
                var FMAYO = s.batchEditApi.GetCellValue(e.visibleIndex, "FMAYO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FMAYO") : 0;  
                var FJUNIO = s.batchEditApi.GetCellValue(e.visibleIndex, "FJUNIO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FJUNIO") : 0;  
                var FJULIO = s.batchEditApi.GetCellValue(e.visibleIndex, "FJULIO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FJULIO") : 0;  
                var FAGOSTO = s.batchEditApi.GetCellValue(e.visibleIndex, "FAGOSTO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FAGOSTO") : 0;  
                var FSEPTIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "FSEPTIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FSEPTIEMBRE") : 0;  
                var FOCTUBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "FOCTUBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FOCTUBRE") : 0;  
                var FNOVIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "FNOVIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FNOVIEMBRE") : 0;  
                var FDICIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "FDICIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FDICIEMBRE") : 0;  

                s.batchEditApi.SetCellValue(e.visibleIndex, "SumForecast", (parseFloat(FENERO) + parseFloat(FFEBRERO) + parseFloat(FMARZO) + parseFloat(FABRIL) + parseFloat(FMAYO) + parseFloat(FJUNIO) + parseFloat(FJULIO) + parseFloat(FAGOSTO) + parseFloat(FSEPTIEMBRE) + parseFloat(FOCTUBRE) + parseFloat(FNOVIEMBRE) + parseFloat(FDICIEMBRE)), null, true);  


                
            }, 0);  
          }


    </script>
    <input runat="server" id="ColumnIndex" type="hidden" enableviewstate="true" />
    <input runat="server" id="RowIndex" type="hidden" enableviewstate="true" />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Reporte Resumen Presupuesto"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="1050px" style="margin-top: 0px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Defina Parametros" RowSpan="2">
                <Items>
          <dx:LayoutItem Caption="Seleccione Area"  ColSpan="1" Name="cbarea" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E3" runat="server" Theme="SoftOrange" Width="299px" DataSourceID="SQLArea" TextField="DESCRIPCION" ValueField="AREA">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                <CaptionSettings Location="Top" />
                    </dx:LayoutItem>



                    <dx:LayoutItem Caption="Seleccione Año" ColSpan="1" Name="cbano">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                  <dx:ASPxComboBox ID="ASPxComboBox2" runat="server" Theme="SoftOrange" DataSourceID="SQLPeriodos" TextField="ano" ValueField="ano">
                                </dx:ASPxComboBox>                  
                            </dx:LayoutItemNestedControlContainer>
          </LayoutItemNestedControlCollection>
                <CaptionSettings Location="Top" />
         </dx:LayoutItem>

 


                    <dx:LayoutItem Caption="" ColSpan="1" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_Click" Theme="SoftOrange" Width="32px" ToolTip="Generar información">
                                  <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E1" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_ClickExc" Theme="SoftOrange" Width="32px" ToolTip="Exportar Excel">
                                   <BackgroundImage ImageUrl="~/Imagenes/Excel.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E2" runat="server" AutoPostBack="False" Height="32px" Width="32px" ToolTip="Lista de Campos">
                                    <ClientSideEvents Click="function(s, e) {
	PivotCompra.ChangeCustomizationFieldsVisibility(); return false; 
}" />
                                   <BackgroundImage ImageUrl="~/Imagenes/Lista.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Lista.png">
                        </TabImage>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <dx:ASPxHiddenField runat="server" ID="hf" ClientInstanceName="hf"></dx:ASPxHiddenField>
    <asp:SqlDataSource ID="SQLArea" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT -1 [AREA]
      ,' Todas' [DESCRIPCION]
  UNION ALL
SELECT [AREA]
      ,[DESCRIPCION]
  FROM [PORTAL].[Presupuesto].[AREA] A
  where A.AREA IN (SELECT U.AREA FROM  [PORTAL].[Presupuesto].AREA_USUARIO U WHERE A.AREA = U.AREA and U.USUARIO = @PNOMUSUARIO)
  order by 2">
        <SelectParameters>
            <asp:SessionParameter Name="PNOMUSUARIO" SessionField="nombreUsuario" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLPeriodos" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="select ano from portal.[Presupuesto].[PERIODOS] order by 1">
    </asp:SqlDataSource>

        
    <asp:SqlDataSource ID="SQLPresupuesto" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$;connect timeout=0;" ProviderName="System.Data.SqlClient" SelectCommand="select D.ANO, D.ANO *100 + 1 PERIODO, D.CIA, C.PAIS,  D.AREA, CO.CENTRO_COSTO, CO.DESCRIPCION DESC_CENTRO, CC.CUENTA_CONTABLE, CC.DESCRIPCION DESC_CUENTA, t.[TIPO_GASTO], T.DESCRIPCION DESC_TIPO_GASTO, [ANO], D.[DESCRIPCION],
R.RUBRO_CONTABLE, R.DESCRIPCION DESC_RUBRO,
[ENERO] VALOR_ACTUAL, [FENERO] FORECAST, [YAGENERO] YAG, (select AA.DESCRIPCION FROM PORTAL.[Presupuesto].[AREA] AA WHERE AA.AREA = D.AREA) DESC_AREA, cc.U_CMI_MAPPING
from PORTAL.presupuesto.DATA D, PORTAL.presupuesto.[CIA] C, PORTAL.presupuesto.[CUENTA_CONTABLE]  CC, PORTAL.presupuesto.[CENTRO_COSTO] CO, PORTAL.presupuesto.[RUBRO_CONTABLE] R, PORTAL.presupuesto.[TIPO_GASTO] T 
WHERE D.CIA = C.CONJUNTO AND D.CUENTA_CONTABLE = CC.CUENTA_CONTABLE AND D.CENTRO_COSTO = CO.CENTRO_COSTO AND D.CIA = CO.CIA AND CC.RUBRO_CONTABLE = R.RUBRO_CONTABLE AND CC.TIPO_GASTO = T.TIPO_GASTO  AND (D.AREA = @AREA or 
D.AREA in (select U.AREA from [PORTAL].[Presupuesto].AREA_USUARIO U where U.USUARIO = @PUSUARIO AND D.AREA = U.AREA AND @AREA = -1)) AND D.ANO=@ANO and
(D.CENTRO_COSTO  in (select C.centro_costo from [PORTAL].[Presupuesto].[AREA_CENTRO] C, [PORTAL].[Presupuesto].CENTRO_COSTO CC Where D.area = C.area and D.centro_costo = C.centro_costo 
and c.CENTRO_COSTO = cc.CENTRO_COSTO and cc.CIA= d.CIA and cc.ESTADO = 'A') and d.cuenta_contable  in (select C.Cuenta from [PORTAL].[Presupuesto].[AREA_CUENTA] C, [PORTAL].[Presupuesto].CUENTA_CONTABLE CC, [PORTAL].[Presupuesto].CIA CIA Where D.area = C.area and D.cuenta_contable = C.CUENTA AND 
c.CUENTA = cc.CUENTA_CONTABLE AND CC.ERP = CIA.ERP AND D.CIA = CIA.CONJUNTO))
UNION ALL
select D.ANO, D.ANO *100 + 2 PERIODO, D.CIA, C.PAIS,  D.AREA, CO.CENTRO_COSTO, CO.DESCRIPCION DESC_CENTRO, CC.CUENTA_CONTABLE, CC.DESCRIPCION DESC_CUENTA, t.[TIPO_GASTO], T.DESCRIPCION DESC_TIPO_GASTO, [ANO], D.[DESCRIPCION],
R.RUBRO_CONTABLE, R.DESCRIPCION DESC_RUBRO,
[FEBRERO] VALOR_ACTUAL, [FFEBRERO] FORECAST, [YAGFEBRERO] YAG, (select AA.DESCRIPCION FROM PORTAL.[Presupuesto].[AREA] AA WHERE AA.AREA = D.AREA) DESC_AREA, cc.U_CMI_MAPPING
from PORTAL.presupuesto.DATA D, PORTAL.presupuesto.[CIA] C, PORTAL.presupuesto.[CUENTA_CONTABLE]  CC, PORTAL.presupuesto.[CENTRO_COSTO] CO, PORTAL.presupuesto.[RUBRO_CONTABLE] R, PORTAL.presupuesto.[TIPO_GASTO] T 
WHERE D.CIA = C.CONJUNTO AND D.CUENTA_CONTABLE = CC.CUENTA_CONTABLE AND D.CENTRO_COSTO = CO.CENTRO_COSTO AND D.CIA = CO.CIA AND CC.RUBRO_CONTABLE = R.RUBRO_CONTABLE AND CC.TIPO_GASTO = T.TIPO_GASTO  AND (D.AREA = @AREA or 
D.AREA in (select U.AREA from [PORTAL].[Presupuesto].AREA_USUARIO U where U.USUARIO = @PUSUARIO AND D.AREA = U.AREA AND @AREA = -1)) AND D.ANO=@ANO and
(D.CENTRO_COSTO  in (select C.centro_costo from [PORTAL].[Presupuesto].[AREA_CENTRO] C, [PORTAL].[Presupuesto].CENTRO_COSTO CC Where D.area = C.area and D.centro_costo = C.centro_costo 
and c.CENTRO_COSTO = cc.CENTRO_COSTO and cc.CIA= d.CIA and cc.ESTADO = 'A') and d.cuenta_contable  in (select C.Cuenta from [PORTAL].[Presupuesto].[AREA_CUENTA] C, [PORTAL].[Presupuesto].CUENTA_CONTABLE CC, [PORTAL].[Presupuesto].CIA CIA Where D.area = C.area and D.cuenta_contable = C.CUENTA AND 
c.CUENTA = cc.CUENTA_CONTABLE AND CC.ERP = CIA.ERP AND D.CIA = CIA.CONJUNTO))
UNION ALL
select D.ANO, D.ANO *100 + 3 PERIODO, D.CIA, C.PAIS,  D.AREA, CO.CENTRO_COSTO, CO.DESCRIPCION DESC_CENTRO, CC.CUENTA_CONTABLE, CC.DESCRIPCION DESC_CUENTA, t.[TIPO_GASTO], T.DESCRIPCION DESC_TIPO_GASTO, [ANO], D.[DESCRIPCION],
R.RUBRO_CONTABLE, R.DESCRIPCION DESC_RUBRO,
MARZO VALOR_ACTUAL, [FMARZO] FORECAST, [YAGMARZO] YAG, (select AA.DESCRIPCION FROM PORTAL.[Presupuesto].[AREA] AA WHERE AA.AREA = D.AREA) DESC_AREA, cc.U_CMI_MAPPING
from PORTAL.presupuesto.DATA D, PORTAL.presupuesto.[CIA] C, PORTAL.presupuesto.[CUENTA_CONTABLE]  CC, PORTAL.presupuesto.[CENTRO_COSTO] CO, PORTAL.presupuesto.[RUBRO_CONTABLE] R, PORTAL.presupuesto.[TIPO_GASTO] T 
WHERE D.CIA = C.CONJUNTO AND D.CUENTA_CONTABLE = CC.CUENTA_CONTABLE AND D.CENTRO_COSTO = CO.CENTRO_COSTO AND D.CIA = CO.CIA AND CC.RUBRO_CONTABLE = R.RUBRO_CONTABLE AND CC.TIPO_GASTO = T.TIPO_GASTO  AND (D.AREA = @AREA or  
D.AREA in (select U.AREA from [PORTAL].[Presupuesto].AREA_USUARIO U where U.USUARIO = @PUSUARIO AND D.AREA = U.AREA AND @AREA = -1)) AND D.ANO=@ANO and
(D.CENTRO_COSTO  in (select C.centro_costo from [PORTAL].[Presupuesto].[AREA_CENTRO] C, [PORTAL].[Presupuesto].CENTRO_COSTO CC Where D.area = C.area and D.centro_costo = C.centro_costo 
and c.CENTRO_COSTO = cc.CENTRO_COSTO and cc.CIA= d.CIA and cc.ESTADO = 'A') and d.cuenta_contable  in (select C.Cuenta from [PORTAL].[Presupuesto].[AREA_CUENTA] C, [PORTAL].[Presupuesto].CUENTA_CONTABLE CC, [PORTAL].[Presupuesto].CIA CIA Where D.area = C.area and D.cuenta_contable = C.CUENTA AND 
c.CUENTA = cc.CUENTA_CONTABLE AND CC.ERP = CIA.ERP AND D.CIA = CIA.CONJUNTO))
UNION ALL
select D.ANO, D.ANO *100 + 4 PERIODO, D.CIA, C.PAIS,  D.AREA, CO.CENTRO_COSTO, CO.DESCRIPCION DESC_CENTRO, CC.CUENTA_CONTABLE, CC.DESCRIPCION DESC_CUENTA, t.[TIPO_GASTO], T.DESCRIPCION DESC_TIPO_GASTO, [ANO], D.[DESCRIPCION],
R.RUBRO_CONTABLE, R.DESCRIPCION DESC_RUBRO,
ABRIL VALOR_ACTUAL, [FABRIL] FORECAST, [YAGABRIL] YAG, (select AA.DESCRIPCION FROM PORTAL.[Presupuesto].[AREA] AA WHERE AA.AREA = D.AREA) DESC_AREA, cc.U_CMI_MAPPING
from PORTAL.presupuesto.DATA D, PORTAL.presupuesto.[CIA] C, PORTAL.presupuesto.[CUENTA_CONTABLE]  CC, PORTAL.presupuesto.[CENTRO_COSTO] CO, PORTAL.presupuesto.[RUBRO_CONTABLE] R, PORTAL.presupuesto.[TIPO_GASTO] T 
WHERE D.CIA = C.CONJUNTO AND D.CUENTA_CONTABLE = CC.CUENTA_CONTABLE AND D.CENTRO_COSTO = CO.CENTRO_COSTO AND D.CIA = CO.CIA AND CC.RUBRO_CONTABLE = R.RUBRO_CONTABLE AND CC.TIPO_GASTO = T.TIPO_GASTO  AND (D.AREA = @AREA or 
D.AREA in (select U.AREA from [PORTAL].[Presupuesto].AREA_USUARIO U where U.USUARIO = @PUSUARIO AND D.AREA = U.AREA AND @AREA = -1)) AND D.ANO=@ANO and
(D.CENTRO_COSTO  in (select C.centro_costo from [PORTAL].[Presupuesto].[AREA_CENTRO] C, [PORTAL].[Presupuesto].CENTRO_COSTO CC Where D.area = C.area and D.centro_costo = C.centro_costo 
and c.CENTRO_COSTO = cc.CENTRO_COSTO and cc.CIA= d.CIA and cc.ESTADO = 'A') and d.cuenta_contable  in (select C.Cuenta from [PORTAL].[Presupuesto].[AREA_CUENTA] C, [PORTAL].[Presupuesto].CUENTA_CONTABLE CC, [PORTAL].[Presupuesto].CIA CIA Where D.area = C.area and D.cuenta_contable = C.CUENTA AND 
c.CUENTA = cc.CUENTA_CONTABLE AND CC.ERP = CIA.ERP AND D.CIA = CIA.CONJUNTO))
UNION ALL
select D.ANO, D.ANO *100 + 5 PERIODO, D.CIA, C.PAIS,  D.AREA, CO.CENTRO_COSTO, CO.DESCRIPCION DESC_CENTRO, CC.CUENTA_CONTABLE, CC.DESCRIPCION DESC_CUENTA, t.[TIPO_GASTO], T.DESCRIPCION DESC_TIPO_GASTO, [ANO], D.[DESCRIPCION],
R.RUBRO_CONTABLE, R.DESCRIPCION DESC_RUBRO,
MAYO VALOR_ACTUAL, [FMAYO] FORECAST, [YAGMAYO] YAG, (select AA.DESCRIPCION FROM PORTAL.[Presupuesto].[AREA] AA WHERE AA.AREA = D.AREA) DESC_AREA, cc.U_CMI_MAPPING
from PORTAL.presupuesto.DATA D, PORTAL.presupuesto.[CIA] C, PORTAL.presupuesto.[CUENTA_CONTABLE]  CC, PORTAL.presupuesto.[CENTRO_COSTO] CO, PORTAL.presupuesto.[RUBRO_CONTABLE] R, PORTAL.presupuesto.[TIPO_GASTO] T 
WHERE D.CIA = C.CONJUNTO AND D.CUENTA_CONTABLE = CC.CUENTA_CONTABLE AND D.CENTRO_COSTO = CO.CENTRO_COSTO AND D.CIA = CO.CIA AND CC.RUBRO_CONTABLE = R.RUBRO_CONTABLE AND CC.TIPO_GASTO = T.TIPO_GASTO  AND (D.AREA = @AREA or 
D.AREA in (select U.AREA from [PORTAL].[Presupuesto].AREA_USUARIO U where U.USUARIO = @PUSUARIO AND D.AREA = U.AREA AND @AREA = -1)) AND D.ANO=@ANO and
(D.CENTRO_COSTO  in (select C.centro_costo from [PORTAL].[Presupuesto].[AREA_CENTRO] C, [PORTAL].[Presupuesto].CENTRO_COSTO CC Where D.area = C.area and D.centro_costo = C.centro_costo 
and c.CENTRO_COSTO = cc.CENTRO_COSTO and cc.CIA= d.CIA and cc.ESTADO = 'A') and d.cuenta_contable  in (select C.Cuenta from [PORTAL].[Presupuesto].[AREA_CUENTA] C, [PORTAL].[Presupuesto].CUENTA_CONTABLE CC, [PORTAL].[Presupuesto].CIA CIA Where D.area = C.area and D.cuenta_contable = C.CUENTA AND 
c.CUENTA = cc.CUENTA_CONTABLE AND CC.ERP = CIA.ERP AND D.CIA = CIA.CONJUNTO))
UNION ALL
select D.ANO, D.ANO *100 + 6 PERIODO, D.CIA, C.PAIS,  D.AREA, CO.CENTRO_COSTO, CO.DESCRIPCION DESC_CENTRO, CC.CUENTA_CONTABLE, CC.DESCRIPCION DESC_CUENTA, t.[TIPO_GASTO], T.DESCRIPCION DESC_TIPO_GASTO, [ANO], D.[DESCRIPCION],
R.RUBRO_CONTABLE, R.DESCRIPCION DESC_RUBRO,
JUNIO VALOR_ACTUAL, [FJUNIO] FORECAST, [YAGJUNIO] YAG, (select AA.DESCRIPCION FROM PORTAL.[Presupuesto].[AREA] AA WHERE AA.AREA = D.AREA) DESC_AREA, cc.U_CMI_MAPPING
from PORTAL.presupuesto.DATA D, PORTAL.presupuesto.[CIA] C, PORTAL.presupuesto.[CUENTA_CONTABLE]  CC, PORTAL.presupuesto.[CENTRO_COSTO] CO, PORTAL.presupuesto.[RUBRO_CONTABLE] R, PORTAL.presupuesto.[TIPO_GASTO] T 
WHERE D.CIA = C.CONJUNTO AND D.CUENTA_CONTABLE = CC.CUENTA_CONTABLE AND D.CENTRO_COSTO = CO.CENTRO_COSTO AND D.CIA = CO.CIA AND CC.RUBRO_CONTABLE = R.RUBRO_CONTABLE AND CC.TIPO_GASTO = T.TIPO_GASTO  AND (D.AREA = @AREA or 
D.AREA in (select U.AREA from [PORTAL].[Presupuesto].AREA_USUARIO U where U.USUARIO = @PUSUARIO AND D.AREA = U.AREA AND @AREA = -1)) AND D.ANO=@ANO and
(D.CENTRO_COSTO  in (select C.centro_costo from [PORTAL].[Presupuesto].[AREA_CENTRO] C, [PORTAL].[Presupuesto].CENTRO_COSTO CC Where D.area = C.area and D.centro_costo = C.centro_costo 
and c.CENTRO_COSTO = cc.CENTRO_COSTO and cc.CIA= d.CIA and cc.ESTADO = 'A') and d.cuenta_contable  in (select C.Cuenta from [PORTAL].[Presupuesto].[AREA_CUENTA] C, [PORTAL].[Presupuesto].CUENTA_CONTABLE CC, [PORTAL].[Presupuesto].CIA CIA Where D.area = C.area and D.cuenta_contable = C.CUENTA AND 
c.CUENTA = cc.CUENTA_CONTABLE AND CC.ERP = CIA.ERP AND D.CIA = CIA.CONJUNTO))
UNION ALL
select D.ANO, D.ANO *100 + 7 PERIODO, D.CIA, C.PAIS,  D.AREA, CO.CENTRO_COSTO, CO.DESCRIPCION DESC_CENTRO, CC.CUENTA_CONTABLE, CC.DESCRIPCION DESC_CUENTA, t.[TIPO_GASTO], T.DESCRIPCION DESC_TIPO_GASTO, [ANO], D.[DESCRIPCION],
R.RUBRO_CONTABLE, R.DESCRIPCION DESC_RUBRO,
[JULIO] VALOR_ACTUAL, [FJULIO] FORECAST, [YAGJULIO] YAG, (select AA.DESCRIPCION FROM PORTAL.[Presupuesto].[AREA] AA WHERE AA.AREA = D.AREA) DESC_AREA, cc.U_CMI_MAPPING
from PORTAL.presupuesto.DATA D, PORTAL.presupuesto.[CIA] C, PORTAL.presupuesto.[CUENTA_CONTABLE]  CC, PORTAL.presupuesto.[CENTRO_COSTO] CO, PORTAL.presupuesto.[RUBRO_CONTABLE] R, PORTAL.presupuesto.[TIPO_GASTO] T 
WHERE D.CIA = C.CONJUNTO AND D.CUENTA_CONTABLE = CC.CUENTA_CONTABLE AND D.CENTRO_COSTO = CO.CENTRO_COSTO AND D.CIA = CO.CIA AND CC.RUBRO_CONTABLE = R.RUBRO_CONTABLE AND CC.TIPO_GASTO = T.TIPO_GASTO  AND (D.AREA = @AREA or 
D.AREA in (select U.AREA from [PORTAL].[Presupuesto].AREA_USUARIO U where U.USUARIO = @PUSUARIO AND D.AREA = U.AREA AND @AREA = -1)) AND D.ANO=@ANO and
(D.CENTRO_COSTO  in (select C.centro_costo from [PORTAL].[Presupuesto].[AREA_CENTRO] C, [PORTAL].[Presupuesto].CENTRO_COSTO CC Where D.area = C.area and D.centro_costo = C.centro_costo 
and c.CENTRO_COSTO = cc.CENTRO_COSTO and cc.CIA= d.CIA and cc.ESTADO = 'A') and d.cuenta_contable  in (select C.Cuenta from [PORTAL].[Presupuesto].[AREA_CUENTA] C, [PORTAL].[Presupuesto].CUENTA_CONTABLE CC, [PORTAL].[Presupuesto].CIA CIA Where D.area = C.area and D.cuenta_contable = C.CUENTA AND 
c.CUENTA = cc.CUENTA_CONTABLE AND CC.ERP = CIA.ERP AND D.CIA = CIA.CONJUNTO))
UNION ALL
select D.ANO, D.ANO *100 + 8 PERIODO, D.CIA, C.PAIS,  D.AREA, CO.CENTRO_COSTO, CO.DESCRIPCION DESC_CENTRO, CC.CUENTA_CONTABLE, CC.DESCRIPCION DESC_CUENTA, t.[TIPO_GASTO], T.DESCRIPCION DESC_TIPO_GASTO, [ANO], D.[DESCRIPCION],
R.RUBRO_CONTABLE, R.DESCRIPCION DESC_RUBRO,
[AGOSTO] VALOR_ACTUAL, [FAGOSTO] FORECAST, [YAGAGOSTO] YAG, (select AA.DESCRIPCION FROM PORTAL.[Presupuesto].[AREA] AA WHERE AA.AREA = D.AREA) DESC_AREA, cc.U_CMI_MAPPING
from PORTAL.presupuesto.DATA D, PORTAL.presupuesto.[CIA] C, PORTAL.presupuesto.[CUENTA_CONTABLE]  CC, PORTAL.presupuesto.[CENTRO_COSTO] CO, PORTAL.presupuesto.[RUBRO_CONTABLE] R, PORTAL.presupuesto.[TIPO_GASTO] T 
WHERE D.CIA = C.CONJUNTO AND D.CUENTA_CONTABLE = CC.CUENTA_CONTABLE AND D.CENTRO_COSTO = CO.CENTRO_COSTO AND D.CIA = CO.CIA AND CC.RUBRO_CONTABLE = R.RUBRO_CONTABLE AND CC.TIPO_GASTO = T.TIPO_GASTO  AND (D.AREA = @AREA or 
D.AREA in (select U.AREA from [PORTAL].[Presupuesto].AREA_USUARIO U where U.USUARIO = @PUSUARIO AND D.AREA = U.AREA AND @AREA = -1)) AND D.ANO=@ANO and
(D.CENTRO_COSTO  in (select C.centro_costo from [PORTAL].[Presupuesto].[AREA_CENTRO] C, [PORTAL].[Presupuesto].CENTRO_COSTO CC Where D.area = C.area and D.centro_costo = C.centro_costo 
and c.CENTRO_COSTO = cc.CENTRO_COSTO and cc.CIA= d.CIA and cc.ESTADO = 'A') and d.cuenta_contable  in (select C.Cuenta from [PORTAL].[Presupuesto].[AREA_CUENTA] C, [PORTAL].[Presupuesto].CUENTA_CONTABLE CC, [PORTAL].[Presupuesto].CIA CIA Where D.area = C.area and D.cuenta_contable = C.CUENTA AND 
c.CUENTA = cc.CUENTA_CONTABLE AND CC.ERP = CIA.ERP AND D.CIA = CIA.CONJUNTO))
UNION ALL
select D.ANO, D.ANO *100 + 9 PERIODO, D.CIA, C.PAIS,  D.AREA, CO.CENTRO_COSTO, CO.DESCRIPCION DESC_CENTRO, CC.CUENTA_CONTABLE, CC.DESCRIPCION DESC_CUENTA, t.[TIPO_GASTO], T.DESCRIPCION DESC_TIPO_GASTO, [ANO], D.[DESCRIPCION],
R.RUBRO_CONTABLE, R.DESCRIPCION DESC_RUBRO,
SEPTIEMBRE VALOR_ACTUAL, [FSEPTIEMBRE] FORECAST, [YAGSEPTIEMBRE] YAG, (select AA.DESCRIPCION FROM PORTAL.[Presupuesto].[AREA] AA WHERE AA.AREA = D.AREA) DESC_AREA, cc.U_CMI_MAPPING
from PORTAL.presupuesto.DATA D, PORTAL.presupuesto.[CIA] C, PORTAL.presupuesto.[CUENTA_CONTABLE]  CC, PORTAL.presupuesto.[CENTRO_COSTO] CO, PORTAL.presupuesto.[RUBRO_CONTABLE] R, PORTAL.presupuesto.[TIPO_GASTO] T 
WHERE D.CIA = C.CONJUNTO AND D.CUENTA_CONTABLE = CC.CUENTA_CONTABLE AND D.CENTRO_COSTO = CO.CENTRO_COSTO AND D.CIA = CO.CIA AND CC.RUBRO_CONTABLE = R.RUBRO_CONTABLE AND CC.TIPO_GASTO = T.TIPO_GASTO  AND (D.AREA = @AREA or 
D.AREA in (select U.AREA from [PORTAL].[Presupuesto].AREA_USUARIO U where U.USUARIO = @PUSUARIO AND D.AREA = U.AREA AND @AREA = -1)) AND D.ANO=@ANO and
(D.CENTRO_COSTO  in (select C.centro_costo from [PORTAL].[Presupuesto].[AREA_CENTRO] C, [PORTAL].[Presupuesto].CENTRO_COSTO CC Where D.area = C.area and D.centro_costo = C.centro_costo 
and c.CENTRO_COSTO = cc.CENTRO_COSTO and cc.CIA= d.CIA and cc.ESTADO = 'A') and d.cuenta_contable  in (select C.Cuenta from [PORTAL].[Presupuesto].[AREA_CUENTA] C, [PORTAL].[Presupuesto].CUENTA_CONTABLE CC, [PORTAL].[Presupuesto].CIA CIA Where D.area = C.area and D.cuenta_contable = C.CUENTA AND 
c.CUENTA = cc.CUENTA_CONTABLE AND CC.ERP = CIA.ERP AND D.CIA = CIA.CONJUNTO))
UNION ALL
select D.ANO, D.ANO *100 + 10 PERIODO, D.CIA, C.PAIS,  D.AREA, CO.CENTRO_COSTO, CO.DESCRIPCION DESC_CENTRO, CC.CUENTA_CONTABLE, CC.DESCRIPCION DESC_CUENTA, t.[TIPO_GASTO], T.DESCRIPCION DESC_TIPO_GASTO, [ANO], D.[DESCRIPCION],
R.RUBRO_CONTABLE, R.DESCRIPCION DESC_RUBRO,
[OCTUBRE] VALOR_ACTUAL, [FOCTUBRE] FORECAST, [YAGOCTUBRE] YAG, (select AA.DESCRIPCION FROM PORTAL.[Presupuesto].[AREA] AA WHERE AA.AREA = D.AREA) DESC_AREA, cc.U_CMI_MAPPING
from PORTAL.presupuesto.DATA D, PORTAL.presupuesto.[CIA] C, PORTAL.presupuesto.[CUENTA_CONTABLE]  CC, PORTAL.presupuesto.[CENTRO_COSTO] CO, PORTAL.presupuesto.[RUBRO_CONTABLE] R, PORTAL.presupuesto.[TIPO_GASTO] T 
WHERE D.CIA = C.CONJUNTO AND D.CUENTA_CONTABLE = CC.CUENTA_CONTABLE AND D.CENTRO_COSTO = CO.CENTRO_COSTO AND D.CIA = CO.CIA AND CC.RUBRO_CONTABLE = R.RUBRO_CONTABLE AND CC.TIPO_GASTO = T.TIPO_GASTO  AND (D.AREA = @AREA or 
D.AREA in (select U.AREA from [PORTAL].[Presupuesto].AREA_USUARIO U where U.USUARIO = @PUSUARIO AND D.AREA = U.AREA AND @AREA = -1)) AND D.ANO=@ANO and
(D.CENTRO_COSTO  in (select C.centro_costo from [PORTAL].[Presupuesto].[AREA_CENTRO] C, [PORTAL].[Presupuesto].CENTRO_COSTO CC Where D.area = C.area and D.centro_costo = C.centro_costo 
and c.CENTRO_COSTO = cc.CENTRO_COSTO and cc.CIA= d.CIA and cc.ESTADO = 'A') and d.cuenta_contable  in (select C.Cuenta from [PORTAL].[Presupuesto].[AREA_CUENTA] C, [PORTAL].[Presupuesto].CUENTA_CONTABLE CC, [PORTAL].[Presupuesto].CIA CIA Where D.area = C.area and D.cuenta_contable = C.CUENTA AND 
c.CUENTA = cc.CUENTA_CONTABLE AND CC.ERP = CIA.ERP AND D.CIA = CIA.CONJUNTO))
UNION ALL
select D.ANO, D.ANO *100 + 11 PERIODO, D.CIA, C.PAIS,  D.AREA, CO.CENTRO_COSTO, CO.DESCRIPCION DESC_CENTRO, CC.CUENTA_CONTABLE, CC.DESCRIPCION DESC_CUENTA, t.[TIPO_GASTO], T.DESCRIPCION DESC_TIPO_GASTO, [ANO], D.[DESCRIPCION],
R.RUBRO_CONTABLE, R.DESCRIPCION DESC_RUBRO,
[NOVIEMBRE] VALOR_ACTUAL, [FNOVIEMBRE] FORECAST, [YAGNOVIEMBRE] YAG, (select AA.DESCRIPCION FROM PORTAL.[Presupuesto].[AREA] AA WHERE AA.AREA = D.AREA) DESC_AREA, cc.U_CMI_MAPPING
from PORTAL.presupuesto.DATA D, PORTAL.presupuesto.[CIA] C, PORTAL.presupuesto.[CUENTA_CONTABLE]  CC, PORTAL.presupuesto.[CENTRO_COSTO] CO, PORTAL.presupuesto.[RUBRO_CONTABLE] R, PORTAL.presupuesto.[TIPO_GASTO] T 
WHERE D.CIA = C.CONJUNTO AND D.CUENTA_CONTABLE = CC.CUENTA_CONTABLE AND D.CENTRO_COSTO = CO.CENTRO_COSTO AND D.CIA = CO.CIA AND CC.RUBRO_CONTABLE = R.RUBRO_CONTABLE AND CC.TIPO_GASTO = T.TIPO_GASTO  AND (D.AREA = @AREA or 
D.AREA in (select U.AREA from [PORTAL].[Presupuesto].AREA_USUARIO U where U.USUARIO = @PUSUARIO AND D.AREA = U.AREA AND @AREA = -1)) AND D.ANO=@ANO and
(D.CENTRO_COSTO  in (select C.centro_costo from [PORTAL].[Presupuesto].[AREA_CENTRO] C, [PORTAL].[Presupuesto].CENTRO_COSTO CC Where D.area = C.area and D.centro_costo = C.centro_costo 
and c.CENTRO_COSTO = cc.CENTRO_COSTO and cc.CIA= d.CIA and cc.ESTADO = 'A') and d.cuenta_contable  in (select C.Cuenta from [PORTAL].[Presupuesto].[AREA_CUENTA] C, [PORTAL].[Presupuesto].CUENTA_CONTABLE CC, [PORTAL].[Presupuesto].CIA CIA Where D.area = C.area and D.cuenta_contable = C.CUENTA AND 
c.CUENTA = cc.CUENTA_CONTABLE AND CC.ERP = CIA.ERP AND D.CIA = CIA.CONJUNTO))
UNION ALL
select D.ANO, D.ANO *100 + 12 PERIODO, D.CIA, C.PAIS,  D.AREA, CO.CENTRO_COSTO, CO.DESCRIPCION DESC_CENTRO, CC.CUENTA_CONTABLE, CC.DESCRIPCION DESC_CUENTA, t.[TIPO_GASTO], T.DESCRIPCION DESC_TIPO_GASTO, [ANO], D.[DESCRIPCION],
R.RUBRO_CONTABLE, R.DESCRIPCION DESC_RUBRO,
[DICIEMBRE] VALOR_ACTUAL, [FDICIEMBRE] FORECAST, [YAGDICIEMBRE] YAG, (select AA.DESCRIPCION FROM PORTAL.[Presupuesto].[AREA] AA WHERE AA.AREA = D.AREA) DESC_AREA, cc.U_CMI_MAPPING
from PORTAL.presupuesto.DATA D, PORTAL.presupuesto.[CIA] C, PORTAL.presupuesto.[CUENTA_CONTABLE]  CC, PORTAL.presupuesto.[CENTRO_COSTO] CO, PORTAL.presupuesto.[RUBRO_CONTABLE] R, PORTAL.presupuesto.[TIPO_GASTO] T 
WHERE D.CIA = C.CONJUNTO AND D.CUENTA_CONTABLE = CC.CUENTA_CONTABLE AND D.CENTRO_COSTO = CO.CENTRO_COSTO AND D.CIA = CO.CIA AND CC.RUBRO_CONTABLE = R.RUBRO_CONTABLE AND CC.TIPO_GASTO = T.TIPO_GASTO 
 AND (D.AREA = @AREA or D.AREA in (select U.AREA from [PORTAL].[Presupuesto].AREA_USUARIO U where U.USUARIO = @PUSUARIO AND D.AREA = U.AREA AND @AREA = -1)) AND D.ANO=@ANO and
(D.CENTRO_COSTO  in (select C.centro_costo from [PORTAL].[Presupuesto].[AREA_CENTRO] C, [PORTAL].[Presupuesto].CENTRO_COSTO CC Where D.area = C.area and D.centro_costo = C.centro_costo 
and c.CENTRO_COSTO = cc.CENTRO_COSTO and cc.CIA= d.CIA and cc.ESTADO = 'A') and d.cuenta_contable  in (select C.Cuenta from [PORTAL].[Presupuesto].[AREA_CUENTA] C, [PORTAL].[Presupuesto].CUENTA_CONTABLE CC, [PORTAL].[Presupuesto].CIA CIA Where D.area = C.area and D.cuenta_contable = C.CUENTA AND 
c.CUENTA = cc.CUENTA_CONTABLE AND CC.ERP = CIA.ERP AND D.CIA = CIA.CONJUNTO))" InsertCommand="INSERT INTO PORTAL.[Presupuesto].[DATA] (AREA,COD_PAIS, CIA,  CENTRO_COSTO, DESCRIPCION, CATEGORIA, CUENTA_CONTABLE, 
ANO, ENERO, FEBRERO, MARZO, ABRIL, MAYO, JUNIO, JULIO, AGOSTO, SEPTIEMBRE, OCTUBRE, NOVIEMBRE, DICIEMBRE, FENERO, FFEBRERO, FMARZO, FABRIL, FMAYO, FJUNIO, FJULIO, FAGOSTO, FSEPTIEMBRE, FOCTUBRE, FNOVIEMBRE, FDICIEMBRE, YAGENERO, YAGFEBRERO, YAGMARZO, YAGABRIL, YAGMAYO, YAGJUNIO, YAGJULIO, YAGAGOSTO, YAGSEPTIEMBRE, YAGOCTUBRE, YAGNOVIEMBRE, YAGDICIEMBRE)
VALUES (@AREA, @COD_PAIS, @CIA,  @CENTRO_COSTO, @DESCRIPCION, @CATEGORIA, @CUENTA_CONTABLE, 
@ANO, @ENERO, @FEBRERO, @MARZO, @ABRIL, @MAYO, @JUNIO, @JULIO, @AGOSTO, @SEPTIEMBRE, @OCTUBRE, @NOVIEMBRE, @DICIEMBRE, @FENERO, @FFEBRERO, @FMARZO, @FABRIL, @FMAYO, @FJUNIO, @FJULIO, @FAGOSTO, @FSEPTIEMBRE, @FOCTUBRE, @FNOVIEMBRE, @FDICIEMBRE, @YAGENERO, @YAGFEBRERO, @YAGMARZO, @YAGABRIL, @YAGMAYO, @YAGJUNIO, @YAGJULIO, @YAGAGOSTO, @YAGSEPTIEMBRE, @YAGOCTUBRE, @YAGNOVIEMBRE, @YAGDICIEMBRE)" UpdateCommand="UPDATE PORTAL.[Presupuesto].[DATA] 
SET AREA = @AREA, 
COD_PAIS = @COD_PAIS, 
CIA= @CIA,  CENTRO_COSTO = @CENTRO_COSTO, DESCRIPCION = @DESCRIPCION, 
CATEGORIA = @CATEGORIA, CUENTA_CONTABLE = @CUENTA_CONTABLE, 
ANO = @ANO, ENERO = @ENERO, FEBRERO = @FEBRERO, MARZO= @MARZO, ABRIL = @ABRIL, MAYO = @MAYO, 
JUNIO = @JUNIO, JULIO = @JULIO, AGOSTO = @AGOSTO, SEPTIEMBRE = @SEPTIEMBRE, OCTUBRE = @OCTUBRE, NOVIEMBRE = @NOVIEMBRE, DICIEMBRE = @DICIEMBRE, 
FENERO = @FENERO, FFEBRERO = @FFEBRERO, FMARZO = @FMARZO, FABRIL = @FABRIL, FMAYO=@FMAYO, 
FJUNIO=@FJUNIO, FJULIO=@FJULIO, FAGOSTO=@FAGOSTO, FSEPTIEMBRE=@FSEPTIEMBRE, FOCTUBRE=@FOCTUBRE, 
FNOVIEMBRE=@FNOVIEMBRE, FDICIEMBRE=@FDICIEMBRE, 
YAGENERO=@YAGENERO, YAGFEBRERO=@YAGFEBRERO, YAGMARZO=@YAGMARZO, YAGABRIL=@YAGABRIL, YAGMAYO=@YAGMAYO, 
YAGJUNIO=@YAGJUNIO, YAGJULIO=@YAGJULIO, YAGAGOSTO=@YAGAGOSTO, YAGSEPTIEMBRE=@YAGSEPTIEMBRE, YAGOCTUBRE=@YAGOCTUBRE, 
YAGNOVIEMBRE=@YAGNOVIEMBRE, YAGDICIEMBRE=@YAGDICIEMBRE
where ID = @ID" >
        <InsertParameters>
            <asp:SessionParameter DefaultValue="1" Name="AREA" SessionField="PAREA" />
            <asp:Parameter Name="COD_PAIS" />
            <asp:Parameter Name="CIA" />
            <asp:Parameter Name="CENTRO_COSTO" />
            <asp:Parameter Name="DESCRIPCION" />
            <asp:Parameter Name="CATEGORIA" />
            <asp:Parameter Name="CUENTA_CONTABLE" />
            <asp:SessionParameter DefaultValue="2021" Name="ANO" SessionField="PANO" />
            <asp:Parameter Name="ENERO" />
            <asp:Parameter Name="FEBRERO" />
            <asp:Parameter Name="MARZO" />
            <asp:Parameter Name="ABRIL" />
            <asp:Parameter Name="MAYO" />
            <asp:Parameter Name="JUNIO" />
            <asp:Parameter Name="JULIO" />
            <asp:Parameter Name="AGOSTO" />
            <asp:Parameter Name="SEPTIEMBRE" />
            <asp:Parameter Name="OCTUBRE" />
            <asp:Parameter Name="NOVIEMBRE" />
            <asp:Parameter Name="DICIEMBRE" />
            <asp:Parameter Name="FENERO" />
            <asp:Parameter Name="FFEBRERO" />
            <asp:Parameter Name="FMARZO" />
            <asp:Parameter Name="FABRIL" />
            <asp:Parameter Name="FMAYO" />
            <asp:Parameter Name="FJUNIO" />
            <asp:Parameter Name="FJULIO" />
            <asp:Parameter Name="FAGOSTO" />
            <asp:Parameter Name="FSEPTIEMBRE" />
            <asp:Parameter Name="FOCTUBRE" />
            <asp:Parameter Name="FNOVIEMBRE" />
            <asp:Parameter Name="FDICIEMBRE" />
            <asp:Parameter Name="YAGENERO" />
            <asp:Parameter Name="YAGFEBRERO" />
            <asp:Parameter Name="YAGMARZO" />
            <asp:Parameter Name="YAGABRIL" />
            <asp:Parameter Name="YAGMAYO" />
            <asp:Parameter Name="YAGJUNIO" />
            <asp:Parameter Name="YAGJULIO" />
            <asp:Parameter Name="YAGAGOSTO" />
            <asp:Parameter Name="YAGSEPTIEMBRE" />
            <asp:Parameter Name="YAGOCTUBRE" />
            <asp:Parameter Name="YAGNOVIEMBRE" />
            <asp:Parameter Name="YAGDICIEMBRE" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="AREA" SessionField="PAREA" DefaultValue="-1" />
            <asp:SessionParameter Name="ANO" SessionField="PANO" DefaultValue="2021" />
            <asp:SessionParameter DefaultValue="" Name="PUSUARIO" SessionField="nombreUsuario" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter DefaultValue="1" Name="AREA" SessionField="PAREA" />
            <asp:Parameter Name="COD_PAIS" />
            <asp:Parameter Name="CIA" />
            <asp:Parameter Name="CENTRO_COSTO" />
            <asp:Parameter Name="DESCRIPCION" />
            <asp:Parameter Name="CATEGORIA" />
            <asp:Parameter Name="CUENTA_CONTABLE" />
            <asp:SessionParameter DefaultValue="2021" Name="ANO" SessionField="PANO" />
            <asp:Parameter Name="ENERO" />
            <asp:Parameter Name="FEBRERO" />
            <asp:Parameter Name="MARZO" />
            <asp:Parameter Name="ABRIL" />
            <asp:Parameter Name="MAYO" />
            <asp:Parameter Name="JUNIO" />
            <asp:Parameter Name="JULIO" />
            <asp:Parameter Name="AGOSTO" />
            <asp:Parameter Name="SEPTIEMBRE" />
            <asp:Parameter Name="OCTUBRE" />
            <asp:Parameter Name="NOVIEMBRE" />
            <asp:Parameter Name="DICIEMBRE" />
            <asp:Parameter Name="FENERO" />
            <asp:Parameter Name="FFEBRERO" />
            <asp:Parameter Name="FMARZO" />
            <asp:Parameter Name="FABRIL" />
            <asp:Parameter Name="FMAYO" />
            <asp:Parameter Name="FJUNIO" />
            <asp:Parameter Name="FJULIO" />
            <asp:Parameter Name="FAGOSTO" />
            <asp:Parameter Name="FSEPTIEMBRE" />
            <asp:Parameter Name="FOCTUBRE" />
            <asp:Parameter Name="FNOVIEMBRE" />
            <asp:Parameter Name="FDICIEMBRE" />
            <asp:Parameter Name="YAGENERO" />
            <asp:Parameter Name="YAGFEBRERO" />
            <asp:Parameter Name="YAGMARZO" />
            <asp:Parameter Name="YAGABRIL" />
            <asp:Parameter Name="YAGMAYO" />
            <asp:Parameter Name="YAGJUNIO" />
            <asp:Parameter Name="YAGJULIO" />
            <asp:Parameter Name="YAGAGOSTO" />
            <asp:Parameter Name="YAGSEPTIEMBRE" />
            <asp:Parameter Name="YAGOCTUBRE" />
            <asp:Parameter Name="YAGNOVIEMBRE" />
            <asp:Parameter Name="YAGDICIEMBRE" />
            <asp:Parameter Name="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <dx:ASPxPivotGridExporter ID="ASPxPivExp1" runat="server" ASPxPivotGridID="Grid">
        <OptionsPrint MergeColumnFieldValues="False" MergeRowFieldValues="False" PrintHorzLines="True" PrintVertLines="False" VerticalContentSplitting="Exact" PrintFilterHeaders="False">
        </OptionsPrint>
    </dx:ASPxPivotGridExporter>
    <br />
    <dx:ASPxPivotGrid ID="Grid" runat="server" ClientIDMode="AutoID" DataSourceID="SQLPresupuesto" Theme="Office365" ClientInstanceName="PivotCompra">
        <Fields>
            <dx:PivotGridField ID="fieldVALORACTUAL" Area="DataArea" AreaIndex="0" FieldName="VALOR_ACTUAL" Name="fieldVALORACTUAL" Caption="ACT" CellFormat-FormatString="#,###" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###" ValueFormat-FormatString="#,###">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldYAG" Area="DataArea" AreaIndex="1" FieldName="YAG" Name="fieldYAG" CellFormat-FormatString="#,###" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###" ValueFormat-FormatString="#,###">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFORECAST" Area="DataArea" AreaIndex="2" FieldName="FORECAST" Name="fieldFORECAST" CellFormat-FormatString="#,###" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###" ValueFormat-FormatString="#,###">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPERIODO" Area="ColumnArea" AreaIndex="0" FieldName="PERIODO" Name="fieldPERIODO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPAIS" Area="RowArea" AreaIndex="0" FieldName="PAIS" Name="fieldPAIS">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldAREA" AreaIndex="0" FieldName="AREA" Name="fieldAREA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCENTROCOSTO" AreaIndex="0" FieldName="CENTRO_COSTO" Name="fieldCENTROCOSTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCCENTRO" AreaIndex="1" FieldName="DESC_CENTRO" Name="fieldDESCCENTRO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCUENTACONTABLE" AreaIndex="5" FieldName="CUENTA_CONTABLE" Name="fieldCUENTACONTABLE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCCUENTA" AreaIndex="2" FieldName="DESC_CUENTA" Name="fieldDESCCUENTA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBROCONTABLE" AreaIndex="3" FieldName="RUBRO_CONTABLE" Name="fieldRUBROCONTABLE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCRUBRO" AreaIndex="3" FieldName="DESC_RUBRO" Name="fieldDESCRUBRO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPOGASTO" AreaIndex="5" FieldName="TIPO_GASTO" Name="fieldTIPOGASTO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCTIPOGASTO" AreaIndex="4" FieldName="DESC_TIPO_GASTO" Name="fieldDESCTIPOGASTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCIA" Area="RowArea" AreaIndex="1" FieldName="CIA" Name="fieldCIA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="field4" Area="DataArea" AreaIndex="3" Caption="VARYAG" Name="field4" UnboundExpression="Iif([VALOR_ACTUAL] = 0, 0, ([VALOR_ACTUAL] - [YAG]) / [VALOR_ACTUAL])" UnboundFieldName="field" UnboundType="Decimal" CellFormat-FormatString="#,###.00%" GrandTotalCellFormat-FormatString="#,###.00%" TotalCellFormat-FormatString="#,###.00%" TotalValueFormat-FormatString="#,###.00%" ValueFormat-FormatString="#,###.00%">
            </dx:PivotGridField>
            <dx:PivotGridField ID="field" Area="DataArea" AreaIndex="4" Caption=" " Name="field" UnboundExpression="Iif([VALOR_ACTUAL] = 0, 0, ([VALOR_ACTUAL] - [YAG]) / [VALOR_ACTUAL])" UnboundFieldName="field" UnboundType="Decimal" CellFormat-FormatString="#,###.00%" GrandTotalCellFormat-FormatString="#,###.00%" TotalCellFormat-FormatString="#,###.00%" TotalValueFormat-FormatString="#,###.00%" ValueFormat-FormatString="#,###.00%" KPIGraphic="VarianceArrow">
            </dx:PivotGridField>
            <dx:PivotGridField ID="field5" Area="DataArea" AreaIndex="5" Caption="VARFOR" Name="field5" UnboundExpression="Iif([VALOR_ACTUAL] = 0, 0, ([VALOR_ACTUAL] - [FORECAST]) / [VALOR_ACTUAL])" UnboundFieldName="field1" UnboundType="Decimal" CellFormat-FormatString="#,###.00%" GrandTotalCellFormat-FormatString="#,###.00%" TotalCellFormat-FormatString="#,###.00%" TotalValueFormat-FormatString="#,###.00%" ValueFormat-FormatString="#,###.00%">
            </dx:PivotGridField>
            <dx:PivotGridField ID="field1" Area="DataArea" AreaIndex="6" Caption=" " Name="field1" UnboundExpression="Iif([VALOR_ACTUAL] = 0, 0, ([VALOR_ACTUAL] - [FORECAST]) / [VALOR_ACTUAL])" UnboundFieldName="field1" UnboundType="Decimal" CellFormat-FormatString="#,###.00%" GrandTotalCellFormat-FormatString="#,###.00%" TotalCellFormat-FormatString="#,###.00%" TotalValueFormat-FormatString="#,###.00%" ValueFormat-FormatString="#,###.00%" KPIGraphic="VarianceArrow">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCAREA" AreaIndex="6" FieldName="DESC_AREA" Name="fieldDESCAREA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUCMIMAPPING" AreaIndex="7" FieldName="U_CMI_MAPPING" Name="fieldUCMIMAPPING">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCRIPCION" AreaIndex="7" FieldName="DESCRIPCION" Name="fieldDESCRIPCION" Visible="False">
            </dx:PivotGridField>
        </Fields>
    </dx:ASPxPivotGrid>
    <br />
    <br />
    &nbsp;&nbsp;&nbsp;&nbsp;<br />
    <br />
    <br />

        
             <br />

    
             </asp:Content>
