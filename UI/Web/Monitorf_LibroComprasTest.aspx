<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Monitorf_LibroComprasTestTest.aspx.cs" Inherits="UI.Web.Monitorf_LibroComprasTest" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Libro Compras"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="900px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Seleccione compañias" ColSpan="1" Name="CiaOrigen" Width="60px">
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
    </dx:ASPxDropDownEdit>                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Fecha Inicial          " ColSpan="1" Name="FechaInicial" Width="60px">
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
                                <dx:ASPxButton ID="Lform_E2" runat="server" AutoPostBack="False" Height="32px" Width="32px" ToolTip="Lista de Campos" OnClick="Lform_E2_Click">
                                    <ClientSideEvents Click="function(s, e) {
	PivotComprasTransacciones.ChangeCustomizationFieldsVisibility(); return false; 
}" />
                                    <BackgroundImage ImageUrl="~/Imagenes/Lista.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"/>

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
    <asp:SqlDataSource ID="SQLComprasTransacciones" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=pruebas;Persist Security Info=True;User ID=sa
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.MonitorF.SPLibroComprasTransacciones" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="" Name="Pfechafin" SessionField="ci_sfec2" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxPivotGridExporter ID="ASPxPivExp1" runat="server" ASPxPivotGridID="PivotComprasTransacciones">
        <OptionsPrint MergeColumnFieldValues="False" MergeRowFieldValues="False" PrintHorzLines="True" PrintVertLines="False" VerticalContentSplitting="Exact">
        </OptionsPrint>
    </dx:ASPxPivotGridExporter>
    <asp:SqlDataSource ID="SQLComprasServiciosExterior" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=pruebas;Persist Security Info=True;User ID=sa
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.MonitorF.SPLibroComprasServiciosExterior" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="" Name="Pfechafin" SessionField="ci_sfec2" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxPivotGridExporter ID="ASPxPivExp2" runat="server" ASPxPivotGridID="PivoPivotComprasServiciosExteriortVenta">
        <OptionsPrint MergeColumnFieldValues="False" MergeRowFieldValues="False" PrintHorzLines="True" PrintVertLines="False" VerticalContentSplitting="Exact">
        </OptionsPrint>
    </dx:ASPxPivotGridExporter>
    <asp:SqlDataSource ID="SQLComprasTransaccionesExcluidas" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=pruebas;Persist Security Info=True;User ID=sa
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.MonitorF.SPLibroComprasTransaccionesExcluidas" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="" Name="Pfechafin" SessionField="ci_sfec2" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxPivotGridExporter ID="ASPxPivExp3" runat="server" ASPxPivotGridID="PivotComprasTransaccionesExcluidas">
        <OptionsPrint MergeColumnFieldValues="False" MergeRowFieldValues="False" PrintHorzLines="True" PrintVertLines="False" VerticalContentSplitting="Exact">
        </OptionsPrint>
    </dx:ASPxPivotGridExporter>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=pruebas;Persist Security Info=True;User ID=sa
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="Portal.dbo.SPTraeCompanias" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep
" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter DefaultValue="1" Name="PModulo" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <br />
    <br />
    <br />
    <br />
    <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Small" Text="              Embarques - Cuentas por Pagar - Caja Chica - Facturas en Tránsito"></asp:Label>
    <br />



    <dx:ASPxGridView ID="GridCompras" runat="server" 
             AutoGenerateColumns="False" 
                    DataSourceID="SQLComprasTransacciones" 
                    ClientInstanceName="grid" Width="4500px">
                    <ImagesFilterControl>
                       </ImagesFilterControl>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="Cia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Documento" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1" Width="160px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TipoDocumento" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SubTipo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ActividadEconomica" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Origen" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ActividadD104" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FechaEmision" LoadReadOnlyValueFromDataModel="True" VisibleIndex="7">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IdentificacionProveedor" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodigoProveedor" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NombreProveedor" LoadReadOnlyValueFromDataModel="True" VisibleIndex="10">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodigoArticulo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="11">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DescripcionMercancia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="12">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PrecioUnitario" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13">
                            <PropertiesTextEdit DisplayFormatString="#,##.00000">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CantidadComprada" LoadReadOnlyValueFromDataModel="True" VisibleIndex="14">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="UnidadMedida" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MontoSubtotal" LoadReadOnlyValueFromDataModel="True" VisibleIndex="16">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DescuentoAplicado" LoadReadOnlyValueFromDataModel="True" VisibleIndex="17">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ImpuestoConsumo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="18">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IvaFacturado" LoadReadOnlyValueFromDataModel="True" VisibleIndex="19">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Otros" LoadReadOnlyValueFromDataModel="True" VisibleIndex="20">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MontoTotal" LoadReadOnlyValueFromDataModel="True" VisibleIndex="21">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Moneda" LoadReadOnlyValueFromDataModel="True" VisibleIndex="22">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TipoCambio" LoadReadOnlyValueFromDataModel="True" VisibleIndex="23">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DuaImportacion" LoadReadOnlyValueFromDataModel="True" VisibleIndex="24">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FechaDua" LoadReadOnlyValueFromDataModel="True" VisibleIndex="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PartidaArancelaria" LoadReadOnlyValueFromDataModel="True" VisibleIndex="26">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DetallePartidaArancelaria" LoadReadOnlyValueFromDataModel="True" VisibleIndex="27">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Aduana" LoadReadOnlyValueFromDataModel="True" VisibleIndex="28">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NombreAgencia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="29">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="AgenciaAduanalCJ" LoadReadOnlyValueFromDataModel="True" VisibleIndex="30">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="BaseImponible" LoadReadOnlyValueFromDataModel="True" VisibleIndex="31">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IVAPagado" LoadReadOnlyValueFromDataModel="True" VisibleIndex="32">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="OtrosImpuestos" LoadReadOnlyValueFromDataModel="True" VisibleIndex="33">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodIVATarifa" LoadReadOnlyValueFromDataModel="True" VisibleIndex="34">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TipoAfectacion" LoadReadOnlyValueFromDataModel="True" VisibleIndex="35">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PorcentajeIva" LoadReadOnlyValueFromDataModel="True" VisibleIndex="36">
                            <PropertiesTextEdit DisplayFormatString="#,##0.">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PorcentajeAcreditacion" LoadReadOnlyValueFromDataModel="True" VisibleIndex="37">
                            <PropertiesTextEdit DisplayFormatString="#,##0.%">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IvaAcreditable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="38">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IvaGastoAplicable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="39">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Tipo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="40">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="RegistroContable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="41">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="OrdenCompra" LoadReadOnlyValueFromDataModel="True" VisibleIndex="42">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CentroCosto" LoadReadOnlyValueFromDataModel="True" VisibleIndex="43">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CuentaContable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="44">
                        </dx:GridViewDataTextColumn>
                    </Columns>
<Styles GroupButtonWidth="28">
    <Header ImageSpacing="5px" SortingImageSpacing="5px">
    </Header>
    <LoadingPanel ImageSpacing="8px">
    </LoadingPanel>
                    </Styles>

                    <Settings VerticalScrollableHeight="400" VerticalScrollBarMode="Auto" />

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

                    <SettingsPager PageSize="400">
                    </SettingsPager>

                    <SettingsEditing EditFormColumnCount="1" Mode="Inline">
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

    <br />
    <br />
    <br />
    <br />

    <br />
    <br />
    <br />
    <br />
    <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="Small" Text="              Servicios Exterior"></asp:Label>
    <br />

    <dx:ASPxGridView ID="GridExterior" runat="server" 
             AutoGenerateColumns="False" 
                    DataSourceID="SQLComprasServiciosExterior" 
                    ClientInstanceName="grid" Width="4500px">
                    <ImagesFilterControl>
                       </ImagesFilterControl>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="Cia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Documento" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1" Width="160px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TipoDocumento" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SubTipo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ActividadEconomica" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Origen" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ActividadD104" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FechaEmision" LoadReadOnlyValueFromDataModel="True" VisibleIndex="7">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IdentificacionProveedor" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodigoProveedor" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NombreProveedor" LoadReadOnlyValueFromDataModel="True" VisibleIndex="10">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodigoArticulo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="11">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DescripcionMercancia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="12">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PrecioUnitario" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13">
                            <PropertiesTextEdit DisplayFormatString="#,##.00000">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CantidadComprada" LoadReadOnlyValueFromDataModel="True" VisibleIndex="14">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="UnidadMedida" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MontoSubtotal" LoadReadOnlyValueFromDataModel="True" VisibleIndex="16">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DescuentoAplicado" LoadReadOnlyValueFromDataModel="True" VisibleIndex="17">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ImpuestoConsumo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="18">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IvaFacturado" LoadReadOnlyValueFromDataModel="True" VisibleIndex="19">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Otros" LoadReadOnlyValueFromDataModel="True" VisibleIndex="20">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MontoTotal" LoadReadOnlyValueFromDataModel="True" VisibleIndex="21">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Moneda" LoadReadOnlyValueFromDataModel="True" VisibleIndex="22">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TipoCambio" LoadReadOnlyValueFromDataModel="True" VisibleIndex="23">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DuaImportacion" LoadReadOnlyValueFromDataModel="True" VisibleIndex="24">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FechaDua" LoadReadOnlyValueFromDataModel="True" VisibleIndex="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PartidaArancelaria" LoadReadOnlyValueFromDataModel="True" VisibleIndex="26">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DetallePartidaArancelaria" LoadReadOnlyValueFromDataModel="True" VisibleIndex="27">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Aduana" LoadReadOnlyValueFromDataModel="True" VisibleIndex="28">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NombreAgencia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="29">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="AgenciaAduanalCJ" LoadReadOnlyValueFromDataModel="True" VisibleIndex="30">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="BaseImponible" LoadReadOnlyValueFromDataModel="True" VisibleIndex="31">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IVAPagado" LoadReadOnlyValueFromDataModel="True" VisibleIndex="32">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="OtrosImpuestos" LoadReadOnlyValueFromDataModel="True" VisibleIndex="33">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodIVATarifa" LoadReadOnlyValueFromDataModel="True" VisibleIndex="34">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TipoAfectacion" LoadReadOnlyValueFromDataModel="True" VisibleIndex="35">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PorcentajeIva" LoadReadOnlyValueFromDataModel="True" VisibleIndex="36">
                            <PropertiesTextEdit DisplayFormatString="#,##.">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PorcentajeAcreditacion" LoadReadOnlyValueFromDataModel="True" VisibleIndex="37">
                            <PropertiesTextEdit DisplayFormatString="#,##.%">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IvaAcreditable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="38">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IvaGastoAplicable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="39">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Tipo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="40">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="RegistroContable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="41">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="OrdenCompra" LoadReadOnlyValueFromDataModel="True" VisibleIndex="42">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CentroCosto" LoadReadOnlyValueFromDataModel="True" VisibleIndex="43">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CuentaContable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="44">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Modulo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="45">
                        </dx:GridViewDataTextColumn>
                    </Columns>
<Styles GroupButtonWidth="28">
    <Header ImageSpacing="5px" SortingImageSpacing="5px">
    </Header>
    <LoadingPanel ImageSpacing="8px">
    </LoadingPanel>
                    </Styles>

                    <Settings VerticalScrollableHeight="400" VerticalScrollBarMode="Auto" />

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

                    <SettingsPager PageSize="400">
                    </SettingsPager>

                    <SettingsEditing EditFormColumnCount="1" Mode="Inline">
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
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="Small" Text="              Transacciones excluidas de embarque, cxp, caja chica" Visible="False"></asp:Label>
    <br />

    <dx:ASPxGridView ID="GridTransito" runat="server" 
             AutoGenerateColumns="False" 
                    DataSourceID="SQLComprasTransaccionesExcluidas" 
                    ClientInstanceName="grid" Width="4500px" Visible="False">
                    <ImagesFilterControl>
                       </ImagesFilterControl>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="Cia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Documento" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1" Width="160px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TipoDocumento" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SubTipo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ActividadEconomica" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Origen" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ActividadD104" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FechaEmision" LoadReadOnlyValueFromDataModel="True" VisibleIndex="7">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IdentificacionProveedor" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodigoProveedor" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NombreProveedor" LoadReadOnlyValueFromDataModel="True" VisibleIndex="10">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodigoArticulo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="11">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DescripcionMercancia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="12">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PrecioUnitario" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13">
                            <PropertiesTextEdit DisplayFormatString="#,##.00000">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CantidadComprada" LoadReadOnlyValueFromDataModel="True" VisibleIndex="14">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="UnidadMedida" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MontoSubtotal" LoadReadOnlyValueFromDataModel="True" VisibleIndex="16">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DescuentoAplicado" LoadReadOnlyValueFromDataModel="True" VisibleIndex="17">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ImpuestoConsumo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="18">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IvaFacturado" LoadReadOnlyValueFromDataModel="True" VisibleIndex="19">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Otros" LoadReadOnlyValueFromDataModel="True" VisibleIndex="20">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MontoTotal" LoadReadOnlyValueFromDataModel="True" VisibleIndex="21">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Moneda" LoadReadOnlyValueFromDataModel="True" VisibleIndex="22">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TipoCambio" LoadReadOnlyValueFromDataModel="True" VisibleIndex="23">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DuaImportacion" LoadReadOnlyValueFromDataModel="True" VisibleIndex="24">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FechaDua" LoadReadOnlyValueFromDataModel="True" VisibleIndex="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PartidaArancelaria" LoadReadOnlyValueFromDataModel="True" VisibleIndex="26">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DetallePartidaArancelaria" LoadReadOnlyValueFromDataModel="True" VisibleIndex="27">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Aduana" LoadReadOnlyValueFromDataModel="True" VisibleIndex="28">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NombreAgencia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="29">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="AgenciaAduanalCJ" LoadReadOnlyValueFromDataModel="True" VisibleIndex="30">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="BaseImponible" LoadReadOnlyValueFromDataModel="True" VisibleIndex="31">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IVAPagado" LoadReadOnlyValueFromDataModel="True" VisibleIndex="32">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="OtrosImpuestos" LoadReadOnlyValueFromDataModel="True" VisibleIndex="33">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodIVATarifa" LoadReadOnlyValueFromDataModel="True" VisibleIndex="34">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TipoAfectacion" LoadReadOnlyValueFromDataModel="True" VisibleIndex="35">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PorcentajeIva" LoadReadOnlyValueFromDataModel="True" VisibleIndex="36">
                            <PropertiesTextEdit DisplayFormatString="#,##.">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PorcentajeAcreditacion" LoadReadOnlyValueFromDataModel="True" VisibleIndex="37">
                            <PropertiesTextEdit DisplayFormatString="#,##.">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IvaAcreditable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="38">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IvaGastoAplicable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="39">
                            <PropertiesTextEdit DisplayFormatString="#,##.00">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Tipo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="40">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="RegistroContable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="41">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="OrdenCompra" LoadReadOnlyValueFromDataModel="True" VisibleIndex="42">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CentroCosto" LoadReadOnlyValueFromDataModel="True" VisibleIndex="43">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CuentaContable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="44">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Modulo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="45">
                        </dx:GridViewDataTextColumn>
                    </Columns>
<Styles GroupButtonWidth="28">
    <Header ImageSpacing="5px" SortingImageSpacing="5px">
    </Header>
    <LoadingPanel ImageSpacing="8px">
    </LoadingPanel>
                    </Styles>

                    <Settings VerticalScrollableHeight="400" VerticalScrollBarMode="Auto" />

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

                    <SettingsPager PageSize="400">
                    </SettingsPager>

                    <SettingsEditing EditFormColumnCount="1" Mode="Inline">
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

             <br />
    <br />
    <br />
    <br />



             </asp:Content>
