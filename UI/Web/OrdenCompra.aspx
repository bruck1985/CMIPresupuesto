<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="OrdenCompra.aspx.cs" Inherits="UI.Web.OrdenCompra" %>

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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="Orden Compra"></asp:Label>
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
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_LISTA_OC]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia" SessionField="ci_sciaOC" />
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
            <dx:GridViewDataTextColumn FieldName="PROVEEDOR" VisibleIndex="5" ShowInCustomizationForm="True" Caption="Cód.Proveedor">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_PROVEEDOR" VisibleIndex="6" ShowInCustomizationForm="True" Caption="Proveeodr">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DEPARTAMENTO" VisibleIndex="7" ShowInCustomizationForm="True" Caption="Departamento">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PAIS" VisibleIndex="8" ShowInCustomizationForm="True" Caption="País">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONEDA" VisibleIndex="9" ShowInCustomizationForm="True" Caption="Moneda">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CONDICION_PAGO" VisibleIndex="10" ShowInCustomizationForm="True" Caption="Condición Pago">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="BODEGA" VisibleIndex="11" ShowInCustomizationForm="True" Caption="Bodega">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MODULO_ORIGEN" VisibleIndex="12" ShowInCustomizationForm="True" Caption="Módulo Origen">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COMPRADOR" VisibleIndex="13" ShowInCustomizationForm="True" Caption="Comprador">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_COTIZACION" VisibleIndex="14" ShowInCustomizationForm="True" Caption="Fecha Cotización">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_OFRECIDA" VisibleIndex="15" ShowInCustomizationForm="True" Caption="Fecha Ofrecida">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_EMISION" VisibleIndex="16" ShowInCustomizationForm="True" Caption="Fecha Emisión">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_REQ_EMBARQUE" VisibleIndex="17" ShowInCustomizationForm="True" Caption="Fecha Req.Embarque">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_REQUERIDA" VisibleIndex="18" ShowInCustomizationForm="True" Caption="Fecha Requerida">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DIRECCION_EMBARQUE" VisibleIndex="19" ShowInCustomizationForm="True" Caption="Dirección Embarque">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DIRECCION_COBRO" VisibleIndex="20" ShowInCustomizationForm="True" Caption="Dirección Cobro">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_DESCUENTO" VisibleIndex="21" ShowInCustomizationForm="True" Caption="Tipo Descuento">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PORCENTAJE_DESCUENTO" VisibleIndex="22" ShowInCustomizationForm="True" Caption="Porcentaje Descuento">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_DESCUENTO" VisibleIndex="23" ShowInCustomizationForm="True" Caption="Monto Descuento">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOTAL_MERCADERIA" VisibleIndex="24" ShowInCustomizationForm="True" Caption="Total Mercadería">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOTAL_IMPUESTO1" VisibleIndex="25" ShowInCustomizationForm="True" Caption="Total Impuesto 1">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOTAL_IMPUESTO2" VisibleIndex="26" ShowInCustomizationForm="True" Caption="Total Impuesto 2">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_FLETE" VisibleIndex="27" ShowInCustomizationForm="True" Caption="Monto Flete">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_SEGURO" VisibleIndex="28" ShowInCustomizationForm="True" Caption="Monto Seguro">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_DOCUMENTACIO" VisibleIndex="29" ShowInCustomizationForm="True" Caption="Monto Documentacio">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_ANTICIPO" VisibleIndex="30" ShowInCustomizationForm="True" Caption="Monto Anticipo">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOTAL" VisibleIndex="31" ShowInCustomizationForm="True" Caption="Total">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RUBRO1" VisibleIndex="32" ShowInCustomizationForm="True" Caption="Rubro 1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RUBRO2" VisibleIndex="33" ShowInCustomizationForm="True" Caption="Rubro 2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RUBRO3" VisibleIndex="34" ShowInCustomizationForm="True" Caption="Rubro3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RUBRO4" VisibleIndex="35" ShowInCustomizationForm="True" Caption="Rubro 4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RUBRO5" VisibleIndex="36" ShowInCustomizationForm="True" Caption="Rubro 5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PRIORIDAD" VisibleIndex="37" ShowInCustomizationForm="True" Caption="Prioridad">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ESTADO" VisibleIndex="38" ShowInCustomizationForm="True" Caption="Estado">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="IMPRESA" VisibleIndex="39" ShowInCustomizationForm="True" Caption="Impresa">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NUM_FORMULARIO" VisibleIndex="40" ShowInCustomizationForm="True" Caption="Num.Formulario">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="INSTRUCCION" VisibleIndex="41" ShowInCustomizationForm="True" Caption="Instrucción">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COMENTARIO_CXP" VisibleIndex="42" ShowInCustomizationForm="True" Caption="Comentario CxP">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="OBSERVACIONES" VisibleIndex="43" ShowInCustomizationForm="True" Caption="Observaciones">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_CREACION" VisibleIndex="44" ShowInCustomizationForm="True" Caption="Usuario Creación">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_HORA" VisibleIndex="45" ShowInCustomizationForm="True" Caption="Fecha Creación">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="REQUIERE_CONFIRMA" VisibleIndex="46" ShowInCustomizationForm="True" Caption="Requiere Confirmación">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CONFIRMADA" VisibleIndex="47" ShowInCustomizationForm="True" Caption="Confirmada">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_CONFIRMA" VisibleIndex="48" ShowInCustomizationForm="True" Caption="Usuario Confirmación">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_CONFIRMA" VisibleIndex="49" ShowInCustomizationForm="True" Caption="Fecha Confirmación">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_CIERRE" VisibleIndex="50" ShowInCustomizationForm="True" Caption="Usuario Cierre">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_CIERRE" VisibleIndex="51" ShowInCustomizationForm="True" Caption="Fecha Cierre">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ASIENTO_CIERRE" VisibleIndex="52" ShowInCustomizationForm="True" Caption="Asiento Cierre">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_CANCELA" VisibleIndex="53" ShowInCustomizationForm="True" Caption="Usuario Cancelación">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_CANCELA" VisibleIndex="54" ShowInCustomizationForm="True" Caption="Fecha Cancelación">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COMENTARIO_NO_APROB" VisibleIndex="55" ShowInCustomizationForm="True" Caption="Comentario No Aprobación">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DOCUMENTO" VisibleIndex="56" ShowInCustomizationForm="True" Caption="Documento">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="U_OCEAM" VisibleIndex="57" ShowInCustomizationForm="True" Caption="OCEAM">
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


    <dx:ASPxGridViewExporter ID="grid_data_exp" runat="server" FileName="Ordenes_Compra" GridViewID="grid_data">
    </dx:ASPxGridViewExporter>


    
</asp:Content>
