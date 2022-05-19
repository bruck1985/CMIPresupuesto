<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="OrdenCompraLinea.aspx.cs" Inherits="UI.Web.OrdenCompraLinea" %>



<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script type="text/javascript">
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="Orden Compra Línea"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="93px" Theme="SoftOrange" Width="60%">
        <Items>
            <dx:LayoutGroup ColCount="5" ColSpan="1" ColumnCount="5" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Fecha Inicial " ColSpan="1" Name="FechaInicial" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="FechaInicial" runat="server" Date="2020-03-17" Theme="SoftOrange" Width="90px" DisplayFormatString="dd/MM/yyyy">
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Fecha Final" ColSpan="1" Name="FechaFinal" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="FechaFinal" runat="server" Date="2020-03-17" Theme="SoftOrange" DisplayFormatString="dd/MM/yyyy" Width="90px">
                                    <DateRangeSettings MaxLength="10" />
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Compañía" ColSpan="1" Name="Cia" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDropDownEdit ClientInstanceName="checkComboBox" ID="ASPxDropDownEdit1" Width="285px" runat="server" AnimationType="None" Theme="SoftOrange">
                                   <DropDownWindowStyle BackColor="#EDEDED" />
                                       <DropDownWindowTemplate>
                                            <dx:ASPxListBox Width="100%" ID="listBox" ClientInstanceName="checkListBox" SelectionMode="CheckColumn"
                                                    runat="server" Height="200" EnableSelectAll="true" DataSourceID="SQLCompania" TextField="nombre" ValueField="conjunto">
                                                <FilteringSettings ShowSearchUI="true"/>
                                                <Border BorderStyle="None" />
                                                <BorderBottom BorderStyle="Solid" BorderWidth="1px" BorderColor="#DCDCDC" />
                                                <ClientSideEvents SelectedIndexChanged="updateText" Init="updateText" />
                                            </dx:ASPxListBox>
                                            <table style="width: 100%">
                                                <tr>
                                                    <td style="padding: 4px">
                                                        <dx:ASPxButton ID="ASPxButton1" AutoPostBack="False" runat="server" Text="Close" style="float: right">
                                                            <ClientSideEvents Click="function(s, e){ checkComboBox.HideDropDown(); }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </DropDownWindowTemplate>
                                        <ClientSideEvents TextChanged="synchronizeListBoxValues" DropDown="synchronizeListBoxValues" />
                                </dx:ASPxDropDownEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Width="32px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server" Height="32px" Native="True"  Theme="SoftOrange" Width="32px" OnClick="ASPxFormLayout1_E3_Click">
                                 <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />                               

                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="32px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E1" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_ClickExc" Theme="SoftOrange" Width="32px">
                                      <BackgroundImage ImageUrl="~/Imagenes/Excel.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>
                    
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

    <asp:SqlDataSource ID="SQLResultados" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=ME;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_LISTA_OC_LINEA]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia" SessionField="ci_sciaOCL" />
            <asp:SessionParameter DefaultValue="20200201" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="20200330" Name="Pfechafin" SessionField="ci_sfec2" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridView ID="grid_data"  ClientInstanceName="MasterGrid" runat="server" Width="1324px" AutoGenerateColumns="False" 
        DataSourceID="SQLResultados" Theme="SoftOrange" EnableRowsCache="False">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="CIA" VisibleIndex="1" ShowInCustomizationForm="True" Caption="Cia">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_CIA" VisibleIndex="2" ShowInCustomizationForm="True" Caption="Nombre Cia">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_ORDEN" VisibleIndex="3" ShowInCustomizationForm="True" Caption="Fecha Orden">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ORDEN_COMPRA" VisibleIndex="4" ShowInCustomizationForm="True" Caption="Orden Compra">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ORDEN_COMPRA_LINEA" VisibleIndex="5" ShowInCustomizationForm="True" Caption="Línea OC">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ESTADO" VisibleIndex="6" ShowInCustomizationForm="True" Caption="Estado">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ARTICULO" VisibleIndex="7" ShowInCustomizationForm="True" Caption="Cód.Articulo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_ARTICULO" VisibleIndex="8" ShowInCustomizationForm="True" Caption="Nombre Artículo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PROVEEDOR" VisibleIndex="9" ShowInCustomizationForm="True" Caption="Cód.Proveedor">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_PROVEEDOR" VisibleIndex="10" ShowInCustomizationForm="True" Caption="Proveedor">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_REQUERIDA" VisibleIndex="11" ShowInCustomizationForm="True" Caption="Fecha Requerida">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="BODEGA" VisibleIndex="12" ShowInCustomizationForm="True" Caption="Cód.Bodega">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_BODEGA" VisibleIndex="13" ShowInCustomizationForm="True" Caption="Nombre Bodega">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="UNIDAD_MEDIDA_COMP" VisibleIndex="14" ShowInCustomizationForm="True" Caption="Unidad Medida">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CANTIDAD_ORDENADA" VisibleIndex="15" ShowInCustomizationForm="True" Caption="Cantidad Ordenada">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CANTIDAD_EMBARCADA" VisibleIndex="16" ShowInCustomizationForm="True" Caption="Cantidad Embarcada">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CANTIDAD_RECIBIDA" VisibleIndex="17" ShowInCustomizationForm="True" Caption="Cantidad Recibida">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CANTIDAD_RECHAZADA" VisibleIndex="18" ShowInCustomizationForm="True" Caption="Cantidad Rechazada">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CANTIDAD_BACKORDER" VisibleIndex="19" ShowInCustomizationForm="True" Caption="Cantidad BackOrder">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PRECIO_UNITARIO" VisibleIndex="20" ShowInCustomizationForm="True" Caption="Precio Unitario">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PRECIO_UNITARIO_LOCAL" VisibleIndex="21" ShowInCustomizationForm="True" Caption="Precio Unitario Local">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="IMPUESTO1" VisibleIndex="22" ShowInCustomizationForm="True" Caption="Impuesto Venta">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="IMPUESTO2" VisibleIndex="23" ShowInCustomizationForm="True" Caption="Impuesto Consumo">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PORCENTAJE_DESCUENTO" VisibleIndex="24" ShowInCustomizationForm="True" Caption="Porcentaje Descuento">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_DESCUENTO" VisibleIndex="25" ShowInCustomizationForm="True" Caption="Monto Descuento">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_DESCUENTO_LOCAL" VisibleIndex="26" ShowInCustomizationForm="True" Caption="Monto Descuento Local">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOTAL_LINEA_OC" VisibleIndex="27" ShowInCustomizationForm="True" Caption="Importe Total">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="IMPORTE_TOTAL_LOCAL" VisibleIndex="28" ShowInCustomizationForm="True" Caption="Importe Total Local">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONEDA" VisibleIndex="29" ShowInCustomizationForm="True" Caption="Moneda">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FACTURA" VisibleIndex="30" ShowInCustomizationForm="True" Caption="Factura">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FACTOR_CONVERSION" VisibleIndex="31" ShowInCustomizationForm="True" Caption="Factor Conversión">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_EMBARQUE_PROV" VisibleIndex="32" ShowInCustomizationForm="True" Caption="Fecha Embarque Prov.">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DIAS_PARA_ENTREGA" VisibleIndex="33" ShowInCustomizationForm="True" Caption="Días Entrega">
            </dx:GridViewDataTextColumn>
            
            <dx:GridViewDataTextColumn FieldName="USUARIO_CIERRE" VisibleIndex="34" ShowInCustomizationForm="True" Caption="Usuario Cierre">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_CIERRE" VisibleIndex="35" ShowInCustomizationForm="True" Caption="Fecha Cierre">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_CANCELA" VisibleIndex="36" ShowInCustomizationForm="True" Caption="Usuario Cancelación">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_CANCELA" VisibleIndex="37" ShowInCustomizationForm="True" Caption="Fecha Cancelación">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COMENTARIO" VisibleIndex="38" ShowInCustomizationForm="True" Caption="Comentario">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CENTRO_COSTO" VisibleIndex="39" ShowInCustomizationForm="True" Caption="Centro Costo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CUENTA_CONTABLE" VisibleIndex="40" ShowInCustomizationForm="True" Caption="Cuenta Contable">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="SOLICITUDES" VisibleIndex="41" ShowInCustomizationForm="True" Caption="Solicitudes">
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=ME;Persist Security Info=True;User ID=PortalRep
                ;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
                  FROM [ME].[erpadmin].[PRIVILEGIO_EX] P, ME.erpadmin.conjunto C
                  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
                order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>


    <dx:ASPxGridViewExporter ID="grid_data_exp" runat="server" FileName="Ordenes_Compra_Linea" GridViewID="grid_data">
    </dx:ASPxGridViewExporter>

</asp:Content>
