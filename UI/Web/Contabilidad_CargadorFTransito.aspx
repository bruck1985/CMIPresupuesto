<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Contabilidad_CargadorFTransito.aspx.cs" Inherits="UI.Web.Contabilidad_CargadorFTransito" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
<%@ Register Assembly="DevExpress.XtraReports.v18.2.Web.WebForms" Namespace="DevExpress.XtraReports.Web" TagPrefix="dxxr" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function onInit(s, e) {
            //viewer.OpenReport("PivotGrid");
        }
        function onEndCallback(s, e) {
            //viewer.Close();
            //viewer.OpenReport("PivotGrid");
        }

         function OnClick(s, e, catCiaCtaID) {
             Popup.Show();
         }
         var textSeparator = ";";
         function updateText() {
             var selectedItems = checkListBox.GetSelectedItems();
             checkComboBox.SetText(getSelectedItemsText(selectedItems));
         }
         function synchronizeListBoxValues(dropDown, args) {
             checkListBox.UnselectAll();
             var texts = dropDown.GetText().split(textSeparator);
             var values = getValuesByTexts(texts);
             checkListBox.SelectValues(values);
             updateText(); // for remove non-existing texts
         }
         function getSelectedItemsText(items) {
             var texts = [];
             for (var i = 0; i < items.length; i++)
                 texts.push(items[i].text);
             return texts.join(textSeparator);
         }
         function getValuesByTexts(texts) {
             var actualValues = [];
             var item;
             for (var i = 0; i < texts.length; i++) {
                 item = checkListBox.FindItemByText(texts[i]);
                 if (item != null)
                     actualValues.push(item.value);
             }
             return actualValues;
         }
    </script>
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Cargador Facturas en Tránsito"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="956px">
        <Items>
            <dx:LayoutGroup ColCount="10" ColSpan="1" ColumnCount="10" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Seleccione compañias" ColSpan="1" Name="CiaOrigen" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E5" runat="server" DataSourceID="SQLCompania" TextField="nombre" Theme="SoftOrange" ValueField="conjunto" Width="300px">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="FechaInicial          " ColSpan="1" Name="FechaInicial" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="FechaInicial" runat="server"  Theme="SoftOrange" DisplayFormatString="dd/MM/yyyy" Width="90px">
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Fecha Final" ColSpan="1" Name="FechaFinal" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="FechaFinal" runat="server"  Theme="SoftOrange" DisplayFormatString="dd/MM/yyyy" Width="90px">
                                    <DateRangeSettings MaxLength="10" />
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_Click" Theme="SoftOrange" Width="32px" ToolTip="Generar información">
                                    <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E1" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_ClickExc" Theme="SoftOrange" Width="32px" ToolTip="Exportar Excel">
                                    <BackgroundImage ImageUrl="~/Imagenes/Excel.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E2" runat="server" AutoPostBack="False" Height="32px" Width="32px" ToolTip="Lista de Campos" OnClick="Lform_E2_Click" Visible="False">
                                    <ClientSideEvents Click="function(s, e) {
	PivotCompra.ChangeCustomizationFieldsVisibility(); return false; 
}" />
                                    <BackgroundImage ImageUrl="~/Imagenes/SaveAll_32x32.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"/>

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
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM me.[erpadmin].[PRIVILEGIO_EX] P, me.erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep
" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLPaquetes" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="select paquete, paquete + '-' + descripcion descripcion 
from me.decosol.PAQUETE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep
" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
     <br />
    <asp:SqlDataSource ID="SQLFacturasTransito" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="SELECT
	ConsecutivoFacturaTransito
	, CodigoEstadoFacturaTransito
	, FechaCambioEstado
	, Cia 
	, Documento 
	, TipoDocumento
	, NumeroLinea
	, SubTipo 
	, ActividadEconomica 
	, Origen 
	, ActividadD104 
	, FechaEmision 
	, IdentificacionProveedor 
	, CodigoProveedor 
	, NombreProveedor 
	, CodigoArticulo 
	, DescripcionMercancia 
	, PrecioUnitario 
	, CantidadComprada 
	, UnidadMedida 
	, MontoSubtotal 
	, DescuentoAplicado 
	, ImpuestoConsumo 
	, IvaFacturado 
	, Otros 
	, MontoTotal 
	, Moneda 
	, TipoCambio 
	, DuaImportacion 
	, FechaDua 
	, PartidaArancelaria 
	, DetallePartidaArancelaria 
	, Aduana 
	, NombreAgencia 
	, AgenciaAduanalCJ 
	, BaseImponible 
	, IVAPagado 
	, OtrosImpuestos 
	, CodIVATarifa 
	, TipoAfectacion 
	, PorcentajeIva 
	, PorcentajeAcreditacion 
	, IvaAcreditable 
	, IvaGastoAplicable 
	, Tipo 
	, RegistroContable 
	, OrdenCompra 
	, CentroCosto 
	, CuentaContable 
	, Modulo 
	, Usuario  
	, FechaCarga
FROM PORTAL.MonitorF.FacturasTransito
WHERE convert(date, FechaEmision, 120) &gt;= convert(date, @Pfechaini, 103) 
and convert(date, FechaEmision, 120) &lt;= convert(date, @Pfechafin, 103) 
AND Cia = @PCia1" DeleteCommand="DELETE FROM PORTAL.MonitorF.FacturasTransito
WHERE ConsecutivoFacturaTransito=@ConsecutivoFacturaTransito" UpdateCommand="UPDATE PORTAL.MonitorF.FacturasTransito
SET CodigoEstadoFacturaTransito=@CodigoEstadoFacturaTransito
	, FechaCambioEstado = @FechaCambioEstado
	, Cia = @Cia
	, Documento  = @Documento
	, TipoDocumento = @TipoDocumento
	, NumeroLinea = @NumeroLinea
	, SubTipo  = @SubTipo
	, ActividadEconomica  = @ActividadEconomica
	, Origen  = @Origen
	, ActividadD104  = @ActividadD104
	, FechaEmision  = @FechaEmision
	, IdentificacionProveedor  = @IdentificacionProveedor
	, CodigoProveedor  = @CodigoProveedor
	, NombreProveedor  = @NombreProveedor
	, CodigoArticulo  = @CodigoArticulo
	, DescripcionMercancia  = @DescripcionMercancia
	, PrecioUnitario  = @PrecioUnitario
	, CantidadComprada  = @CantidadComprada
	, UnidadMedida  = @UnidadMedida
	, MontoSubtotal  = @MontoSubtotal
	, DescuentoAplicado  = @DescuentoAplicado
	, ImpuestoConsumo  = @ImpuestoConsumo
	, IvaFacturado  = @IvaFacturado
	, Otros  = @Otros
	, MontoTotal  = @MontoTotal
	, Moneda  = @Moneda
	, TipoCambio  = @TipoCambio
	, DuaImportacion  = @DuaImportacion
	, FechaDua  = @FechaDua
	, PartidaArancelaria  = @PartidaArancelaria
	, DetallePartidaArancelaria  = @DetallePartidaArancelaria
	, Aduana  = @Aduana
	, NombreAgencia  = @NombreAgencia
	, AgenciaAduanalCJ  = @AgenciaAduanalCJ
	, BaseImponible  = @BaseImponible
	, IVAPagado  = @IVAPagado
	, OtrosImpuestos  = @OtrosImpuestos
	, CodIVATarifa  = @CodIVATarifa
	, TipoAfectacion  = @TipoAfectacion
	, PorcentajeIva  = @PorcentajeIva
	, PorcentajeAcreditacion  = @PorcentajeAcreditacion
	, IvaAcreditable  = @IvaAcreditable
	, IvaGastoAplicable  = @IvaGastoAplicable
	, Tipo  = @Tipo
	, RegistroContable  = @RegistroContable
	, OrdenCompra  = @OrdenCompra
	, CentroCosto  = @CentroCosto
	, CuentaContable  = @CuentaContable
	, Modulo  = @Modulo
	, Usuario   = @Usuario
	, FechaCarga = @FechaCarga
	, FechaUltimoCambio = GETDATE()
FROM PORTAL.MonitorF.FacturasTransito
WHERE ConsecutivoFacturaTransito=@ConsecutivoFacturaTransito" InsertCommand="INSERT INTO PORTAL.MonitorF.FacturasTransito
(
	CodigoEstadoFacturaTransito
    , FechaCambioEstado
	, Cia 
	, Documento 
	, TipoDocumento
	, NumeroLinea
	, SubTipo 
	, ActividadEconomica 
	, Origen 
	, ActividadD104 
	, FechaEmision 
	, IdentificacionProveedor 
	, CodigoProveedor 
	, NombreProveedor 
	, CodigoArticulo 
	, DescripcionMercancia 
	, PrecioUnitario 
	, CantidadComprada 
	, UnidadMedida 
	, MontoSubtotal 
	, DescuentoAplicado 
	, ImpuestoConsumo 
	, IvaFacturado 
	, Otros 
	, MontoTotal 
	, Moneda 
	, TipoCambio 
	, DuaImportacion 
	, FechaDua 
	, PartidaArancelaria 
	, DetallePartidaArancelaria 
	, Aduana 
	, NombreAgencia 
	, AgenciaAduanalCJ 
	, BaseImponible 
	, IVAPagado 
	, OtrosImpuestos 
	, CodIVATarifa 
	, TipoAfectacion 
	, PorcentajeIva 
	, PorcentajeAcreditacion 
	, IvaAcreditable 
	, IvaGastoAplicable 
	, Tipo 
	, RegistroContable 
	, OrdenCompra 
	, CentroCosto 
	, CuentaContable 
	, Modulo 
	, Usuario  
	, FechaCarga
)
VALUES
(
	@CodigoEstadoFacturaTransito
    , @FechaCambioEstado
	, @Cia 
	, @Documento 
	, @TipoDocumento
	, @NumeroLinea
	, @SubTipo 
	, @ActividadEconomica 
	, @Origen 
	, @ActividadD104 
	, @FechaEmision 
	, @IdentificacionProveedor 
	, @CodigoProveedor 
	, @NombreProveedor 
	, @CodigoArticulo 
	, @DescripcionMercancia 
	, @PrecioUnitario 
	, @CantidadComprada 
	, @UnidadMedida 
	, @MontoSubtotal 
	, @DescuentoAplicado 
	, @ImpuestoConsumo 
	, @IvaFacturado 
	, @Otros 
	, @MontoTotal 
	, @Moneda 
	, @TipoCambio 
	, @DuaImportacion 
	, @FechaDua 
	, @PartidaArancelaria 
	, @DetallePartidaArancelaria 
	, @Aduana 
	, @NombreAgencia 
	, @AgenciaAduanalCJ 
	, @BaseImponible 
	, @IVAPagado 
	, @OtrosImpuestos 
	, @CodIVATarifa 
	, @TipoAfectacion 
	, @PorcentajeIva 
	, @PorcentajeAcreditacion 
	, @IvaAcreditable 
	, @IvaGastoAplicable 
	, @Tipo 
	, @RegistroContable 
	, @OrdenCompra 
	, @CentroCosto 
	, @CuentaContable 
	, @Modulo 
	, @Usuario  
	, @FechaCarga
)" >
        <InsertParameters>
            <asp:Parameter Name="CodigoEstadoFacturaTransito" />
            <asp:Parameter Name="FechaCambioEstado" />
            <asp:Parameter Name="Cia" />
            <asp:Parameter Name="Documento" />
            <asp:Parameter Name="TipoDocumento" />
            <asp:Parameter Name="NumeroLinea" />
            <asp:Parameter Name="SubTipo" />
            <asp:Parameter Name="ActividadEconomica" />
            <asp:Parameter Name="Origen" />
            <asp:Parameter Name="ActividadD104" />
            <asp:Parameter Name="FechaEmision" />
            <asp:Parameter Name="IdentificacionProveedor" />
            <asp:Parameter Name="CodigoProveedor" />
            <asp:Parameter Name="NombreProveedor" />
            <asp:Parameter Name="CodigoArticulo" />
            <asp:Parameter Name="DescripcionMercancia" />
            <asp:Parameter Name="PrecioUnitario" />
            <asp:Parameter Name="CantidadComprada" />
            <asp:Parameter Name="UnidadMedida" />
            <asp:Parameter Name="MontoSubtotal" />
            <asp:Parameter Name="DescuentoAplicado" />
            <asp:Parameter Name="ImpuestoConsumo" />
            <asp:Parameter Name="IvaFacturado" />
            <asp:Parameter Name="Otros" />
            <asp:Parameter Name="MontoTotal" />
            <asp:Parameter Name="Moneda" />
            <asp:Parameter Name="TipoCambio" />
            <asp:Parameter Name="DuaImportacion" />
            <asp:Parameter Name="FechaDua" />
            <asp:Parameter Name="PartidaArancelaria" />
            <asp:Parameter Name="DetallePartidaArancelaria" />
            <asp:Parameter Name="Aduana" />
            <asp:Parameter Name="NombreAgencia" />
            <asp:Parameter Name="AgenciaAduanalCJ" />
            <asp:Parameter Name="BaseImponible" />
            <asp:Parameter Name="IVAPagado" />
            <asp:Parameter Name="OtrosImpuestos" />
            <asp:Parameter Name="CodIVATarifa" />
            <asp:Parameter Name="TipoAfectacion" />
            <asp:Parameter Name="PorcentajeIva" />
            <asp:Parameter Name="PorcentajeAcreditacion" />
            <asp:Parameter Name="IvaAcreditable" />
            <asp:Parameter Name="IvaGastoAplicable" />
            <asp:Parameter Name="Tipo" />
            <asp:Parameter Name="RegistroContable" />
            <asp:Parameter Name="OrdenCompra" />
            <asp:Parameter Name="CentroCosto" />
            <asp:Parameter Name="CuentaContable" />
            <asp:Parameter Name="Modulo" />
            <asp:Parameter Name="Usuario" />
            <asp:Parameter Name="FechaCarga" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="01/09/2021" Name="Pfechaini" SessionField="ci_sfec1" Type="String" />
            <asp:SessionParameter DefaultValue="01/12/2021" Name="Pfechafin" SessionField="ci_sfec2" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CodigoEstadoFacturaTransito" />
            <asp:Parameter Name="FechaCambioEstado" />
            <asp:Parameter Name="Cia" />
            <asp:Parameter Name="Documento" />
            <asp:Parameter Name="TipoDocumento" />
            <asp:Parameter Name="NumeroLinea" />
            <asp:Parameter Name="SubTipo" />
            <asp:Parameter Name="ActividadEconomica" />
            <asp:Parameter Name="Origen" />
            <asp:Parameter Name="ActividadD104" />
            <asp:Parameter Name="FechaEmision" />
            <asp:Parameter Name="IdentificacionProveedor" />
            <asp:Parameter Name="CodigoProveedor" />
            <asp:Parameter Name="NombreProveedor" />
            <asp:Parameter Name="CodigoArticulo" />
            <asp:Parameter Name="DescripcionMercancia" />
            <asp:Parameter Name="PrecioUnitario" />
            <asp:Parameter Name="CantidadComprada" />
            <asp:Parameter Name="UnidadMedida" />
            <asp:Parameter Name="MontoSubtotal" />
            <asp:Parameter Name="DescuentoAplicado" />
            <asp:Parameter Name="ImpuestoConsumo" />
            <asp:Parameter Name="IvaFacturado" />
            <asp:Parameter Name="Otros" />
            <asp:Parameter Name="MontoTotal" />
            <asp:Parameter Name="Moneda" />
            <asp:Parameter Name="TipoCambio" />
            <asp:Parameter Name="DuaImportacion" />
            <asp:Parameter Name="FechaDua" />
            <asp:Parameter Name="PartidaArancelaria" />
            <asp:Parameter Name="DetallePartidaArancelaria" />
            <asp:Parameter Name="Aduana" />
            <asp:Parameter Name="NombreAgencia" />
            <asp:Parameter Name="AgenciaAduanalCJ" />
            <asp:Parameter Name="BaseImponible" />
            <asp:Parameter Name="IVAPagado" />
            <asp:Parameter Name="OtrosImpuestos" />
            <asp:Parameter Name="CodIVATarifa" />
            <asp:Parameter Name="TipoAfectacion" />
            <asp:Parameter Name="PorcentajeIva" />
            <asp:Parameter Name="PorcentajeAcreditacion" />
            <asp:Parameter Name="IvaAcreditable" />
            <asp:Parameter Name="IvaGastoAplicable" />
            <asp:Parameter Name="Tipo" />
            <asp:Parameter Name="RegistroContable" />
            <asp:Parameter Name="OrdenCompra" />
            <asp:Parameter Name="CentroCosto" />
            <asp:Parameter Name="CuentaContable" />
            <asp:Parameter Name="Modulo" />
            <asp:Parameter Name="Usuario" />
            <asp:Parameter Name="FechaCarga" />
            <asp:Parameter Name="ConsecutivoFacturaTransito" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLEstadosFacturaTransito" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CodigoEstadoFacturaTransito
	, EstadoFacturaTransito
FROM Portal.MonitorF.EstadosFacturaTransito
WHERE Activo=1">
    </asp:SqlDataSource>
    <br />
         
                   &nbsp;<dx:ASPxGridView ID="GridFacturasTransito" runat="server" 
             AutoGenerateColumns="False" 
                    DataSourceID="SQLFacturasTransito" 
                    ClientInstanceName="grid" KeyFieldName="ConsecutivoFacturaTransito">
                    <ImagesFilterControl>
                       </ImagesFilterControl>
                    <Columns>
<%--                        <dx:GridViewCommandColumn VisibleIndex="0" ShowSelectCheckbox="True" ShowEditButton="True" ShowNewButton="True" ShowUpdateButton="True">
                            <FooterTemplate>
                                <dx:ASPxButton ID="buttonDel" AutoPostBack="false" runat="server" Text="Delete All">
                                    <ClientSideEvents Click="OnClickButtonDel"/>
                                </dx:ASPxButton>
                            </FooterTemplate>
                        </dx:GridViewCommandColumn>--%>


                        <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>

                        <dx:GridViewDataComboBoxColumn FieldName="CodigoEstadoFacturaTransito" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2" Caption="EstadoFacturaTransito" Width="160px">
                            <PropertiesComboBox DataSourceID="SQLEstadosFacturaTransito" TextField="EstadoFacturaTransito" ValueField="CodigoEstadoFacturaTransito">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>

<%--                        <dx:GridViewDataDateColumn FieldName="FechaCambioEstado" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
                        </dx:GridViewDataDateColumn>--%>
                        <dx:GridViewDataDateColumn FieldName="FechaCambioEstado" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3" Width="160px">
                            <PropertiesDateEdit DisplayFormatString="dd-MM-yyyy" EditFormatString="dd-MM-yyyy"></PropertiesDateEdit>  
                        </dx:GridViewDataDateColumn> 


                        <dx:GridViewDataTextColumn FieldName="Cia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Documento" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TipoDocumento" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NumeroLinea" LoadReadOnlyValueFromDataModel="True" VisibleIndex="7">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SubTipo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ActividadEconomica" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Origen" LoadReadOnlyValueFromDataModel="True" VisibleIndex="10">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ActividadD104" LoadReadOnlyValueFromDataModel="True" VisibleIndex="11">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FechaEmision" LoadReadOnlyValueFromDataModel="True" VisibleIndex="12">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IdentificacionProveedor" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodigoProveedor" LoadReadOnlyValueFromDataModel="True" VisibleIndex="14" Visible="False">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NombreProveedor" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodigoArticulo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="16" Visible="False">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DescripcionMercancia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="17">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PrecioUnitario" LoadReadOnlyValueFromDataModel="True" VisibleIndex="18">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CantidadComprada" LoadReadOnlyValueFromDataModel="True" VisibleIndex="19">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="UnidadMedida" LoadReadOnlyValueFromDataModel="True" VisibleIndex="20">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MontoSubtotal" LoadReadOnlyValueFromDataModel="True" VisibleIndex="21">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DescuentoAplicado" LoadReadOnlyValueFromDataModel="True" VisibleIndex="22">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ImpuestoConsumo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="23">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IvaFacturado" LoadReadOnlyValueFromDataModel="True" VisibleIndex="24">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Otros" LoadReadOnlyValueFromDataModel="True" VisibleIndex="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MontoTotal" LoadReadOnlyValueFromDataModel="True" VisibleIndex="26">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Moneda" LoadReadOnlyValueFromDataModel="True" VisibleIndex="27">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TipoCambio" LoadReadOnlyValueFromDataModel="True" VisibleIndex="28">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DuaImportacion" LoadReadOnlyValueFromDataModel="True" VisibleIndex="29">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FechaDua" LoadReadOnlyValueFromDataModel="True" VisibleIndex="30">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PartidaArancelaria" LoadReadOnlyValueFromDataModel="True" VisibleIndex="31">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DetallePartidaArancelaria" LoadReadOnlyValueFromDataModel="True" VisibleIndex="32">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Aduana" LoadReadOnlyValueFromDataModel="True" VisibleIndex="33">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NombreAgencia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="34">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="AgenciaAduanalCJ" LoadReadOnlyValueFromDataModel="True" VisibleIndex="35">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="BaseImponible" LoadReadOnlyValueFromDataModel="True" VisibleIndex="36">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IVAPagado" LoadReadOnlyValueFromDataModel="True" VisibleIndex="37">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="OtrosImpuestos" LoadReadOnlyValueFromDataModel="True" VisibleIndex="38">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodIVATarifa" LoadReadOnlyValueFromDataModel="True" VisibleIndex="39">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TipoAfectacion" LoadReadOnlyValueFromDataModel="True" VisibleIndex="40">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PorcentajeIva" LoadReadOnlyValueFromDataModel="True" VisibleIndex="41">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PorcentajeAcreditacion" LoadReadOnlyValueFromDataModel="True" VisibleIndex="42">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IvaAcreditable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="43">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IvaGastoAplicable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="44">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Tipo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="45" Visible="False">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="RegistroContable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="46">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="OrdenCompra" LoadReadOnlyValueFromDataModel="True" VisibleIndex="47" Visible="False">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CentroCosto" LoadReadOnlyValueFromDataModel="True" VisibleIndex="48" Visible="False">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CuentaContable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="49" Visible="False">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Modulo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="50" Visible="False">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Usuario" LoadReadOnlyValueFromDataModel="True" VisibleIndex="51">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FechaCarga" LoadReadOnlyValueFromDataModel="True" VisibleIndex="52">
                        </dx:GridViewDataDateColumn>
                    </Columns>
<Styles GroupButtonWidth="28">
    <Header ImageSpacing="5px" SortingImageSpacing="5px">
    </Header>
    <LoadingPanel ImageSpacing="8px">
    </LoadingPanel>
                    </Styles>

<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>

                    <SettingsSearchPanel Visible="True" />

<SettingsLoadingPanel ImagePosition="Top"></SettingsLoadingPanel>

                    <Paddings Padding="1px" />

<Images SpriteCssFilePath="~/App_Themes/SoftOrange/{0}/sprite.css">
    <LoadingPanelOnStatusBar Url="~/App_Themes/SoftOrange/GridView/gvLoadingOnStatusBar.gif">
    </LoadingPanelOnStatusBar>
    <LoadingPanel Url="~/App_Themes/SoftOrange/GridView/Loading.gif">
    </LoadingPanel>
</Images>

                    <SettingsEditing EditFormColumnCount="1" Mode="Batch">
                    </SettingsEditing>

<StylesEditors>
    <CalendarHeader Spacing="1px">
    </CalendarHeader>
<ProgressBar Height="29px"></ProgressBar>
</StylesEditors>

<%--        <Templates>
            <EditForm>
                <div style="padding: 4px 3px 4px">
                    <dx:ASPxPageControl runat="server" ID="pageControl" Width="100%">
                        <TabPages>
                            <dx:TabPage Text="Datos" Visible="true">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:ASPxGridViewTemplateReplacement ID="Editors" ReplacementType="EditFormEditors"
                                            runat="server">
                                        </dx:ASPxGridViewTemplateReplacement>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                        </TabPages>
                    </dx:ASPxPageControl>
                </div>
                <div style="text-align: left; padding: 2px">
                    <dx:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton"
                        runat="server">
                    </dx:ASPxGridViewTemplateReplacement>
                    <dx:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton"
                        runat="server">
                    </dx:ASPxGridViewTemplateReplacement>
                </div>
            </EditForm>
        </Templates>--%>

</dx:ASPxGridView>
                <dx:ASPxGridViewExporter ID="Exportador" runat="server" FileName="CargarFacturaTransito"
                    GridViewID="GFile">
                </dx:ASPxGridViewExporter>
                </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                Seleccione el archivo excel a cargar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" 
                    CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine" 
                    NavigateUrl="~/Plantillas/MachoteCargadorFacturasTransito.xls" 
                    Text="Formato de ejemplo para cargar" />
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxUploadControl ID="Upload" runat="server" Height="120px" ShowProgressPanel="True"
                    ShowUploadButton="True" Width="578px" OnFileUploadComplete="Upload_FileUploadComplete1">
                    <ClientSideEvents FileUploadComplete="function(s, e) {
	 if( e.isValid)
        { memo.SetText(e.callbackData);
          grid.PerformCallback();
        }

}" />
                </dx:ASPxUploadControl>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxMemo ID="Memo" runat="server" CssFilePath="~/App_Themes/Red Wine/{0}/styles.css"
                    CssPostfix="RedWine" Height="168px" ReadOnly="True" Width="480px" ClientInstanceName="memo">
                    <ValidationSettings>
                        <ErrorImage Url="~/App_Themes/Red Wine/Editors/edtError.png" />
                        <ErrorFrameStyle ImageSpacing="4px">
                            <ErrorTextPaddings PaddingLeft="4px" />
                        </ErrorFrameStyle>
                    </ValidationSettings>
                </dx:ASPxMemo>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
    </table>



             </asp:Content>
