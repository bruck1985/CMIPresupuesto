<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="EstadoActivoGrafico.aspx.cs" Inherits="UI.Web.EstadoActivoGrafico" %>


<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

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

        function updateText2() {
            var selectedItems = checkListBox2.GetSelectedItems();
            checkComboBox2.SetText(getSelectedItemsText2(selectedItems));
        }

        function synchronizeListBoxValues(dropDown, args) {
            checkListBox.UnselectAll();
            var texts = dropDown.GetText().split(textSeparator);
            var values = getValuesByTexts(texts);
            checkListBox.SelectValues(values);
            updateText(); // for remove non-existing texts
        }

        function synchronizeListBoxValues2(dropDown2, args) {
            checkListBox2.UnselectAll();
            var texts = dropDown2.GetText().split(textSeparator);
            var values = getValuesByTexts2(texts);
            checkListBox2.SelectValues(values);
            updateText2(); // for remove non-existing texts
        }

        function getSelectedItemsText(items) {
            var texts = [];
            for (var i = 0; i < items.length; i++)
                texts.push(items[i].text);
            return texts.join(textSeparator);
        }

        function getSelectedItemsText2(items) {
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

        function getValuesByTexts2(texts) {
            var actualValues = [];
            var item;
            for (var i = 0; i < texts.length; i++) {
                item = checkListBox2.FindItemByText(texts[i]);
                if (item != null)
                    actualValues.push(item.value);
            }
            return actualValues;
        }

    </script>
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="Activos por Estado - Pruebas"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="93px" Theme="SoftOrange" Width="60%">
        <Items>
            <dx:LayoutGroup ColCount="5" ColSpan="1" ColumnCount="6" Caption="Datos Activo" RowSpan="2">
                <Items>

                    <dx:LayoutItem Caption="Compañía"  ColSpan="1" Name="Cia" Width="60px">
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


                    <dx:LayoutItem Caption="Categorías"  ColSpan="1" Name="Categoria" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                
                                <dx:ASPxDropDownEdit ClientInstanceName="checkComboBox2" ID="ASPxDropDownEdit2" Width="285px" runat="server" AnimationType="None" Theme="SoftOrange">
                                   <DropDownWindowStyle BackColor="#EDEDED" />
                                       <DropDownWindowTemplate>
                                            <dx:ASPxListBox Width="100%" ID="listBox2" ClientInstanceName="checkListBox2" SelectionMode="CheckColumn"
                                                    runat="server" Height="200" EnableSelectAll="true" DataSourceID="SQLCategoria" TextField="NOMBRE_ACTIVO" ValueField="TIPO_ACTIVO">
                                                <FilteringSettings ShowSearchUI="true"/>
                                                <Border BorderStyle="None" />
                                                <BorderBottom BorderStyle="Solid" BorderWidth="1px" BorderColor="#DCDCDC" />
                                                <ClientSideEvents SelectedIndexChanged="updateText2" Init="updateText2" />
                                            </dx:ASPxListBox>
                                            <table style="width: 100%">
                                                <tr>
                                                    <td style="padding: 4px">
                                                        <dx:ASPxButton ID="ASPxButton2" AutoPostBack="False" runat="server" Text="Close" style="float: right">
                                                            <ClientSideEvents Click="function(s, e){ checkComboBox2.HideDropDown(); }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </DropDownWindowTemplate>
                                        <ClientSideEvents TextChanged="synchronizeListBoxValues2" DropDown="synchronizeListBoxValues2" />
                                </dx:ASPxDropDownEdit>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>


                    <dx:LayoutItem Caption="" ColSpan="1" Width="32px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server" Height="32px" ToolTip="Búsqueda" Native="True" OnClick="ASPxFormLayout1_E3_Click"  Theme="SoftOrange" Width="32px">
                                 <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />                               

                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

    <asp:SqlDataSource ID="SQLResultados" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=Pruebas;Persist Security Info=True;User ID=sa
;Password=SAsoftladbqa$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_AF_ESTADO_GRAFICO]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="PCia" SessionField="ci_sciaG" />
            <asp:SessionParameter DefaultValue="" Name="PCategoria" SessionField="ci_scategoriaG" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <dx:BootstrapPieChart ID="graficoEstados" runat="server" DataSourceID="SQLResultados" >
        <SeriesCollection>
            <dx:BootstrapPieChartSeries ArgumentField="NOMBRE_ESTADO_ACTIVO" ValueField="CANTIDAD">
                <Label Visible="true" />
            </dx:BootstrapPieChartSeries>
        </SeriesCollection>
    </dx:BootstrapPieChart>

    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=Pruebas;Persist Security Info=True;User ID=sa
                ;Password=SAsoftladbqa$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
                  FROM [Pruebas].[erpadmin].[PRIVILEGIO_EX] P, ME.erpadmin.conjunto C
                  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
                order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLCategoria" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=Pruebas;Persist Security Info=True;User ID=sa
;Password=SAsoftladbqa$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_CATEGORIAS_AF]" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>

</asp:Content>
