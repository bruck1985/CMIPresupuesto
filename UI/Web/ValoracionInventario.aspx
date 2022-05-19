<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="ValoracionInventario.aspx.cs" Inherits="UI.Web.ValoracionInventario" %>


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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="Valoración de Inventario"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="93px" Theme="SoftOrange" Width="60%">
        <Items>
            <dx:LayoutGroup ColCount="4" ColSpan="1" ColumnCount="4" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Fecha Inicial " ColSpan="1" Name="FechaInicial" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="FechaInicial" runat="server" Date="2020-03-17" Theme="SoftOrange" Width="90px" DisplayFormatString="dd/MM/yyyy">
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
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_VALORACION_INVENTARIO]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia" SessionField="ci_sciaVI" />
            <asp:SessionParameter DefaultValue="20200201" Name="Pfechaini" SessionField="ci_sfec1" />
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
            <dx:GridViewDataTextColumn FieldName="BODEGA" VisibleIndex="3" ShowInCustomizationForm="True" Caption="Bodega">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_BODEGA" VisibleIndex="4" ShowInCustomizationForm="True" Caption="Nombre Bodega">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ARTICULO" VisibleIndex="5" ShowInCustomizationForm="True" Caption="Articulo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_ARTICULO" VisibleIndex="6" ShowInCustomizationForm="True" Caption="Nombre Articulo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="GRUPO" VisibleIndex="7" ShowInCustomizationForm="True" Caption="Grupo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="SUBGRUPO" VisibleIndex="8" ShowInCustomizationForm="True" Caption="Subgrupo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LOCALIZACION" VisibleIndex="9" ShowInCustomizationForm="True" Caption="Localización">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COSTO_PROMEDIO_LOCAL" VisibleIndex="10" ShowInCustomizationForm="True" Caption="Costo Promedio Local">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COSTO_PROMEDIO_DOLAR" VisibleIndex="11" ShowInCustomizationForm="True" Caption="Costo Promedio Dólar">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CANTIDAD_BODEGA" VisibleIndex="12" ShowInCustomizationForm="True" Caption="Cantidad Bodega">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COSTO_BODEGA_LOCAL" VisibleIndex="13" ShowInCustomizationForm="True" Caption="Costo Bodega Local">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COSTO_BODEGA_DOLAR" VisibleIndex="14" ShowInCustomizationForm="True" Caption="Costo Bodega Dólar">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
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

    <dx:ASPxGridViewExporter ID="grid_data_exp" runat="server" FileName="Valoracion_Inventarios" GridViewID="grid_data">
    </dx:ASPxGridViewExporter>


    
</asp:Content>
