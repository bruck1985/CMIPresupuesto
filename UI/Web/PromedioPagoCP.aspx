<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="PromedioPagoCP.aspx.cs" Inherits="UI.Web.PromedioPagoCP" %>


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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="Promedio Pago Cuenta por Pagar"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="93px" Theme="SoftOrange" Width="60%">
        <Items>
            <dx:LayoutGroup ColCount="6" ColSpan="1" ColumnCount="6" Caption="Defina Parametros" RowSpan="2">
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
                    <dx:LayoutItem Caption="Tipo documento" ColSpan="1" Name="TipoDocumento" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="TipoDocumento" runat="server" DataSourceID="SQLTipoDocumento" TextField="nombre" Theme="SoftOrange" ValueField="tipo" Width="203px">
                                </dx:ASPxComboBox>
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
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_PROMEDIO_PAGO_CP]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia" SessionField="ci_sciaPP" />
            <asp:SessionParameter DefaultValue="20200201" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="20200330" Name="Pfechafin" SessionField="ci_sfec2" />
            <asp:SessionParameter DefaultValue="%" Name="PTipo" SessionField="ci_tipo" />
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
            <dx:GridViewDataTextColumn FieldName="PROVEEDOR" VisibleIndex="3" ShowInCustomizationForm="True" Caption="Proveedor">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_PROVEEDOR" VisibleIndex="4" ShowInCustomizationForm="True" Caption="Nombre Proveedor">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_DOCUMENTO" VisibleIndex="5" ShowInCustomizationForm="True" Caption="Fecha Documento">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_DOCUMENTO" VisibleIndex="6" ShowInCustomizationForm="True" Caption="Tipo Documento">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NUMERO_DOCUMENTO" VisibleIndex="7" ShowInCustomizationForm="True" Caption="Nro.Documento">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONEDA" VisibleIndex="8" ShowInCustomizationForm="True" Caption="Moneda">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_DOCUMENTO" VisibleIndex="9" ShowInCustomizationForm="True" Caption="Monto Documento">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_VENCE" VisibleIndex="10" ShowInCustomizationForm="True" Caption="Fecha Vence">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_RIGE" VisibleIndex="11" ShowInCustomizationForm="True" Caption="Fecha Rige">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CONDICION_PAGO" VisibleIndex="12" ShowInCustomizationForm="True" Caption="Condicion Pago">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ESTADO_DOCUMENTO" VisibleIndex="13" ShowInCustomizationForm="True" Caption="Estado Documento">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="SALDO" VisibleIndex="14" ShowInCustomizationForm="True" Caption="Saldo">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_DOCUMENTO_DEBITO" VisibleIndex="15" ShowInCustomizationForm="True" Caption="Tipo Documento Debito">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NRO_DOCUMENTO_DEBITO" VisibleIndex="16" ShowInCustomizationForm="True" Caption="Nro.Documento Debito">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_PAGO" VisibleIndex="17" ShowInCustomizationForm="True" Caption="Fecha Pago">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_DEBITO" VisibleIndex="18" ShowInCustomizationForm="True" Caption="Monto Debito">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DIAS_TRANSCURRIDOS" VisibleIndex="19" ShowInCustomizationForm="True" Caption="Dias Transcurridos">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_CREACION" VisibleIndex="20" ShowInCustomizationForm="True" Caption="Usuario Creacion">
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=Me;Persist Security Info=True;User ID=PortalRep
                ;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
                  FROM [ME].[erpadmin].[PRIVILEGIO_EX] P, ME.erpadmin.conjunto C
                  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
                order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLTipoDocumento" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="select '%' tipo , 'Todos' nombre
        union all
        select 'FAC' tipo,'FAC' nombre
        union all
        select 'N/D' tipo , 'N/D' nombre
        union all
        select 'O/C' tipo , 'O/C' nombre
        union all
        select 'N/C' tipo , 'N/C' nombre
        union all
        select 'TEF' tipo , 'TEF' nombre
        union all
        select 'RET' tipo , 'RET' nombre
        union all
        select 'O/D' tipo, 'O/D' nombre"></asp:SqlDataSource>

    <dx:ASPxGridViewExporter ID="grid_data_exp" runat="server" FileName="Cuentas_Pagar_Promedio_Pago" GridViewID="grid_data">
    </dx:ASPxGridViewExporter>
</asp:Content>
