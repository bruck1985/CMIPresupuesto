<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="InventarioArticulo.aspx.cs" Inherits="UI.Web.InventarioArticulo" %>


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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="Maestro de Artículos"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="93px" Theme="SoftOrange" Width="60%">
        <Items>
            <dx:LayoutGroup ColCount="5" ColSpan="1" ColumnCount="5" Caption="Defina Parametros" RowSpan="2">
                <Items>
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

                    <dx:LayoutItem Caption="Tipo" ColSpan="1" Name="Tipo" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Tipo" runat="server" DataSourceID="SQLTipo" TextField="nombre" Theme="SoftOrange" ValueField="tipo" Width="203px">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Estado" ColSpan="1" Name="Estado" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Estado" runat="server" DataSourceID="SQLEstado" TextField="nombre" Theme="SoftOrange" ValueField="tipo" Width="203px">
                                </dx:ASPxComboBox>
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
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_INV_ARTICULO]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia" SessionField="ci_sciaIA" />
            <asp:SessionParameter DefaultValue="%" Name="PTipo" SessionField="ci_tipo" />
            <asp:SessionParameter DefaultValue="%" Name="PEstado" SessionField="ci_estado" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxPivotGridExporter ID="ASPxPivExp1" runat="server" ASPxPivotGridID="grid_data">
        <OptionsPrint MergeColumnFieldValues="False" MergeRowFieldValues="False" PrintHorzLines="True" PrintVertLines="False" VerticalContentSplitting="Exact">
        </OptionsPrint>
    </dx:ASPxPivotGridExporter>
    <dx:ASPxPivotGrid ID="grid_data"  ClientInstanceName="MasterGrid" ClientIDMode="AutoID" runat="server"  
        DataSourceID="SQLResultados" Theme="Office365">

        <Fields>
            <dx:PivotGridField FieldName="CIA" Area="RowArea" AreaIndex="1"  Caption="Cia">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="NOMBRE_CIA" Area="RowArea" AreaIndex="2"  Caption="Nombre Cia">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="ARTICULO" Area="RowArea" AreaIndex="3"  Caption="Artículo">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="DESCRIPCION" Area="RowArea" AreaIndex="4"  Caption="Descripción">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="TIPO" Area="RowArea" AreaIndex="5"  Caption="Tipo">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="COSTO_PROM_LOC" AreaIndex="6"  Area="RowArea" Caption="Costo Promedio Local" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="COSTO_PROM_DOL" AreaIndex="7" Area="RowArea" Caption="Costo Promedio Dólar" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="COSTO_STD_LOC" AreaIndex="8" Area="RowArea" Caption="Costo Estándar Local" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="COSTO_STD_DOL" AreaIndex="9" Area="RowArea" Caption="Costo Estándar Dólar" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="COSTO_ULT_LOC" AreaIndex="10" Area="RowArea" Caption="Costo Último Local" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="COSTO_ULT_DOL" AreaIndex="11" Area="RowArea"  Caption="Costo Último Dólar" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="ARTICULO_DEL_PROV" AreaIndex="12" Area="RowArea" Caption="Costo Promedio Local">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="GTIN" AreaIndex="13" Area="RowArea" Caption="GTIN">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="MANUFACTURADOR" AreaIndex="14" Area="RowArea" Caption="Manufacturador">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="COSTO_PROM_COMPARATIVO_LOC" AreaIndex="15" Area="RowArea" Caption="Costo Prom.Comparativo Local" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="COSTO_PROM_COMPARATIVO_DOLAR" AreaIndex="16" Area="RowArea" Caption="Costo Prom.Comparativo Dólar" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="COSTO_PROM_ULTIMO_LOC" AreaIndex="17" Area="RowArea" Caption="Costo Prom.Último Local" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="COSTO_PROM_ULTIMO_DOL" AreaIndex="18" Area="RowArea" Caption="Costo Prom.Último Dólar" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="GENERICO" AreaIndex="19" Area="RowArea" Caption="Genérico">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="FAMILIA" AreaIndex="20" Area="RowArea"  Caption="Familia">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="REQUISIO" AreaIndex="21" Area="RowArea" Caption="Requisio">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="SUBFAMILIA" AreaIndex="22" Area="RowArea"  Caption="SubFamilia">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="TEMP1" AreaIndex="23" Area="RowArea" Caption=".">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="TEMP2" AreaIndex="24" Area="RowArea"  Caption="...">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="ORIGEN" AreaIndex="25" Area="RowArea" Caption="Origen">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="GRUPO_CUENTAS" AreaIndex="26" Area="RowArea" Caption="Grupo de Cunetas">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="UNIDAD_ALMACEN" AreaIndex="27" Area="RowArea" Caption="Unidad Almacén">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="UNIDAD_DETALLE" AreaIndex="28" Area="RowArea" Caption="Unidad Detalle">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="UNIDAD_VENTA" AreaIndex="29" Area="RowArea"  Caption="Unidad Venta">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="COSTO_FISCAL" AreaIndex="30" Area="RowArea" Caption="Costo Fiscal">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="COSTO_COMPARATIVO" AreaIndex="31" Area="RowArea"  Caption="Costo Comparativo">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="ULTIMA_SALIDA" AreaIndex="32"  Area="RowArea" Caption="Última Salida">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="ULTIMO_MOVIMIENTO" AreaIndex="33" Area="RowArea" Caption="Último Movimiento">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="ULTIMO_INGRESO" AreaIndex="34" Area="RowArea" Caption="Último Ingreso">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="ULTIMO_INVENTARIO" AreaIndex="35" Area="RowArea" Caption="Último Inventario">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="IMPUESTO" AreaIndex="36" Area="RowArea" Caption="Impuesto">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="CLASE_ABC" AreaIndex="37" Area="RowArea"  Caption="Clase ABC">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="CONTEO_CICLICO" AreaIndex="38" Area="RowArea" Caption="Conteo Cíclico">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="ACTIVO" AreaIndex="39" Area="RowArea" Caption="Activo">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="LOTES" AreaIndex="40" Area="RowArea" Caption="Lotes">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="PROVEEDOR" AreaIndex="41" Area="RowArea" Caption="Proveedor">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="CUARENTENA" AreaIndex="42" Area="RowArea" Caption="Cuarentena">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="UTILIZADO_MANUFACTURA" AreaIndex="43" Area="RowArea" Caption="Utilizado Manufactura">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="USUARIO_CREACION" AreaIndex="44" Area="RowArea" Caption="Usuario Creación">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="USUARIO_ULT_MODIF" AreaIndex="45" Area="RowArea" Caption="Usuario Modificación">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="PERECEDERO" AreaIndex="46" Area="RowArea" Caption="Perecedero">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="CODIGO_BARRAS_UND_DETALLE" AreaIndex="47" Area="RowArea" Caption="Cód.Barras Detalle">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="TIPO_CODIGO_BARRAS_UND_DETALLE" AreaIndex="48" Area="RowArea" Caption="Tipo Cód.Barras Detalle">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="CODIGO_BARRAS_UND_ALMACEN" AreaIndex="49" Area="RowArea" Caption="Cód.Barras Almacén">
            </dx:PivotGridField>
            <dx:PivotGridField FieldName="TIPO_CODIGO_BARRAS_UND_ALMACEN" AreaIndex="50" Area="RowArea" Caption="Tipo Cód.Barras Almacén">
            </dx:PivotGridField>
        
        </Fields>
    </dx:ASPxPivotGrid>

    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=ME;Persist Security Info=True;User ID=PortalRep
                ;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
                  FROM [ME].[erpadmin].[PRIVILEGIO_EX] P, ME.erpadmin.conjunto C
                  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
                order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLTipo" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="select '%' tipo , 'Todos' nombre
        union all
        select 'T' tipo,'Terminado' nombre
        union all
        select 'V' tipo , 'Servicio' nombre
        union all
        select 'R' tipo, 'Refaccion' nombre
        union all
        select 'U' tipo, 'Suministro' nombre
        union all
        select 'D' tipo, 'Desecho' nombre
        union all
        select 'C' tipo, 'Coproducto' nombre
        union all
        select 'O' tipo, 'Otros' nombre"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLEstado" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="select '%' tipo , 'Todos' nombre
        union all
        select 'S' tipo,'Si' nombre
        union all
        select 'N' tipo , 'No' nombre"></asp:SqlDataSource>

    <dx:ASPxGridViewExporter ID="grid_data_exp" runat="server" FileName="Inventario_Articulo" GridViewID="grid_data">
    </dx:ASPxGridViewExporter>


    
</asp:Content>
