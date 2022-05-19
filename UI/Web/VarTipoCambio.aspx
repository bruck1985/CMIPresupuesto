<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="VarTipoCambio.aspx.cs" Inherits="UI.Web.VarTipoCambio" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
  
<%@ Register assembly="DevExpress.XtraReports.v18.2.Web.WebForms, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraReports.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.XtraReports.v18.2.Web.WebForms, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraReports.Web.ClientControls" tagprefix="cc1" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
         function OnClick(s, e, catCiaCtaID) {
             Popup.Show();
        }
         var textSeparator = ";";
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
         function synchronizeListBoxValuescc(dropDown, args) {
             checkListBoxcc.UnselectAll();
             var texts = dropDown.GetText().split(textSeparator);
             var values = getValuesByTextscc(texts);
             checkListBoxcc.SelectValues(values);
             updateTextcc(); // for remove non-existing texts
         }
         function getValuesByTextscc(texts) {
             var actualValues = [];
             var item;
             for (var i = 0; i < texts.length; i++) {
                 item = checkListBoxcc.FindItemByText(texts[i]);
                 if (item != null)
                     actualValues.push(item.value);
             }
             return actualValues;
         }
         function updateTextcc() {
             var selectedItems = checkListBoxcc.GetSelectedItems();
             checkComboBoxcc.SetText(getSelectedItemsText(selectedItems));
         } 

         function ShowDrillDown() {
             var mainElement = PivotCompra.GetMainElement();
             DrillDownWindow.ShowAtPos(ASPxClientUtils.GetAbsoluteX(mainElement), ASPxClientUtils.GetAbsoluteY(mainElement));
         }
         function onGridEndCallback(s, e) {
             if (s.cpShowDrillDownWindow)
                 GridView.SetVisible(true);
        }
        function OnHyperLinkClick(s, e) {
            DrillDownAsiento.ShowAtPos(GridViewAsiento.GetMainElement());
            GridViewAsiento.Perf
        }

    </script>
    <input runat="server" id="ColumnIndex" type="hidden" enableviewstate="true" />
    <input runat="server" id="RowIndex" type="hidden" enableviewstate="true" />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Posición Monetaria"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="1050px" style="margin-top: 0px">
        <Items>
            <dx:LayoutGroup ColCount="9" ColSpan="1" ColumnCount="9" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Seleccione compañia" ColSpan="1" Name="CiaOrigen" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="ASPxComboBox1" runat="server" DataSourceID="SQLCompania" TextField="nombre" ValueField="conjunto">
                                    <ClientSideEvents SelectedIndexChanged="function(s, e) {
	      tipocambio1.PerformCallback(s.GetSelectedItem().value);
             tipocambio2.PerformCallback(s.GetSelectedItem().value);
}" />
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
          </LayoutItemNestedControlCollection>
                <CaptionSettings Location="Top" />
         </dx:LayoutItem>



                    <dx:LayoutItem Caption="Tipo Cambio 1" ColSpan="1" Width="60px" Name="tipocambio1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E1" runat="server" Theme="SoftOrange" Width="90px" SelectedIndex="0" DataSourceID="SQLTipoCambio1" TextField="DESCRIPCION" ValueField="MONTO" OnCallback="Lform_E1_Callback" ClientInstanceName="tipocambio1">
                                    <Items>
                                        <dx:ListEditItem Selected="True" Text="Año Anterior" Value="y" />
                                        <dx:ListEditItem Text="Mes Anterior" Value="m" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                         <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Tipo Cambio 2" ColSpan="1" Width="60px" Name="tipocambio2">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E4" runat="server" Theme="SoftOrange" Width="90px" SelectedIndex="0" DataSourceID="SQLTipoCambio2" TextField="DESCRIPCION" ValueField="MONTO" OnCallback="Lform_E4_Callback"  ClientInstanceName="tipocambio2">
                                    <Items>
                                        <dx:ListEditItem Selected="True" Text="Si" Value="s" />
                                        <dx:ListEditItem Text="No" Value="n" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
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
                                  <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E1EXCEL" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_ClickExc" Theme="SoftOrange" Width="32px" ToolTip="Exportar Excel">
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
                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E3" runat="server" Height="28px" Text="Generar Reporte" Visible="False">
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLConta2" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_VAR_TIPO_CAMBIO]" OnSelecting="SQLCompras_Selecting" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="XXXX XXXX" Name="PCia1" SessionField="bclista_ci_scia" Type="String" />
            <asp:SessionParameter DefaultValue="01/01/2021" Name="Pfechaini" SessionField="ci_sfec1" Type="String" />
            <asp:SessionParameter DefaultValue="31/01/2020" Name="Pfechafin" SessionField="ci_sfec2" Type="String" />
            <asp:SessionParameter DefaultValue="500" Name="ptipo_cambio1" SessionField="ptipo_cambio1" Type="String" />
            <asp:SessionParameter DefaultValue="600" Name="ptipo_cambio2" SessionField="ptipo_cambio2" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxPivotGridExporter ID="ASPxPivExp1" runat="server" ASPxPivotGridID="PivotCompra">
        <OptionsPrint MergeColumnFieldValues="False" MergeRowFieldValues="False" PrintHorzLines="True" PrintVertLines="False" VerticalContentSplitting="Exact" PrintFilterHeaders="False">
        </OptionsPrint>
    </dx:ASPxPivotGridExporter>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM [erpadmin].[PRIVILEGIO_EX] P, erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLTipoCambio1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_TIPO_CAMBIO]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="IEO2" Name="PCia1" SessionField="PCia1" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLTipoCambio2" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_TIPO_CAMBIO]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="IEO2" Name="PCia1" SessionField="PCia1" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLConta3" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$;connect timeout=0;" ProviderName="System.Data.SqlClient" SelectCommand="Select 'CROMSA' CIA, M.FECHA, M.ASIENTO, M.CONSECUTIVO, NIT, CENTRO_COSTO, M.CUENTA_CONTABLE, C.DESCRIPCION, M.TIPO_ASIENTO, M.FUENTE, M.REFERENCIA, M.ORIGEN, M.DEBITO_LOCAL, M.CREDITO_LOCAL, M.DEBITO_DOLAR, M.CREDITO_DOLAR, M.CONTABILIDAD From me.CROMSA.mayor M, me.CROMSA.CUENTA_CONTABLE C Where M.centro_costo = '000-000-000' and M.Cuenta_Contable = '101-02-02-01-00' AND CONVERT(CHAR(6),M.FECHA, 112) = '202103' AND M.CONTABILIDAD IN('A','F') AND M.CUENTA_CONTABLE = C.CUENTA_CONTABLE" OnSelecting="SQLCompras_Selecting">
    </asp:SqlDataSource>

    <dx:ASPxPivotGrid ID="PivotCompra" runat="server" ClientIDMode="AutoID" DataSourceID="SQLConta2" Theme="Office365" ClientInstanceName="PivotCompra">
        <Fields>
            <dx:PivotGridField ID="fieldCIA" Area="RowArea" AreaIndex="0" FieldName="CIA" Name="fieldCIA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCODCUENTACONTABLE" Area="RowArea" AreaIndex="1" FieldName="COD_CUENTA_CONTABLE" Name="fieldCODCUENTACONTABLE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCRIPCION_CUENTA" Area="RowArea" AreaIndex="2" FieldName="DESCRIPCION_CUENTA" Name="fieldDESCRIPCION_CUENTA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCUENTADES1" Area="RowArea" AreaIndex="3" FieldName="CUENTADES1" Name="fieldCUENTADES1" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCUENTADES2" Area="RowArea" AreaIndex="3" FieldName="CUENTADES2" Name="fieldCUENTADES2" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCUENTADES3" Area="RowArea" AreaIndex="3" FieldName="CUENTADES3" Name="fieldCUENTADES3" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCUENTADES4" Area="RowArea" AreaIndex="3" FieldName="CUENTADES4" Name="fieldCUENTADES4" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCUENTADES5" Area="RowArea" AreaIndex="3" FieldName="CUENTADES5" Name="fieldCUENTADES5" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCENTROCOSTO" AreaIndex="0" FieldName="CENTRO_COSTO" Name="fieldCENTROCOSTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPERIODO1" Area="ColumnArea" AreaIndex="0" FieldName="PERIODO" Name="fieldPERIODO1">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFIN" Area="DataArea" AreaIndex="0" FieldName="FIN" Name="fieldFIN" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00" Caption="SALDO DOL">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONTOTIPOCAMBIO1" Area="DataArea" AreaIndex="1" FieldName="MONTO_TIPO_CAMBIO1" Name="fieldMONTOTIPOCAMBIO1" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00" Caption="SALDO LOC 1">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONTOTIPOCAMBIO2" Area="DataArea" AreaIndex="2" FieldName="MONTO_TIPO_CAMBIO2" Name="fieldMONTOTIPOCAMBIO2" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00" Caption="SALDO LOC 2">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldVARTIPOCAMBIO" Area="DataArea" AreaIndex="3" FieldName="VAR_TIPO_CAMBIO" Name="fieldVARTIPOCAMBIO" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00" Caption="VAR CAMBIO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCODCENTROCOSTO" AreaIndex="1" Name="fieldCODCENTROCOSTO" FieldName="COD_CENTRO_COSTO">
            </dx:PivotGridField>

        </Fields>
        <OptionsPager ColumnsPerPage="20" NumericButtonCount="20" RowsPerPage="20">
        </OptionsPager>
    </dx:ASPxPivotGrid>

      
             <br />
    <br />
    <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" AllowDragging="True" ClientInstanceName="DrillDownWindow" CloseAction="CloseButton" HeaderText="Drill Down Window" Height="1px" Left="200" Modal="true" Top="200" Width="153px">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxButton ID="ExportExcel1" runat="server" OnClick="ExportExcel1_Click" Text="Export Excel">
           <Image Url="~/Imagenes/Excel.jpg">
           </Image>
       </dx:ASPxButton>
                <dx:ASPxGridViewExporter ID="ASPxGridViewDetalle" runat="server" ExportedRowType="All" GridViewID="ASPxGridView1" FileName="DetalleCTPE">
                </dx:ASPxGridViewExporter>
    <br />
    <div> 
                <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridView" OnCustomCallback="ASPxGridView1_CustomCallback" KeyFieldName="ASIENTOKEY">
                    <ClientSideEvents EndCallback="onGridEndCallback" />
                    <Settings ShowFooter="True" ShowFilterRow="True" />

<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>

                    <SettingsSearchPanel Visible="True" />

                    <SettingsLoadingPanel Mode="ShowOnStatusBar" />
                    <Columns>
                        <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowInCustomizationForm="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="CIA" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FECHA" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="2">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="ASIENTO" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="3">
                           <EditFormSettings Visible="False" />
                              <DataItemTemplate>
                               <dx:ASPxHyperLink ID="hyperLink" runat="server" Text='<%# Bind("ASIENTO") %>' NavigateUrl="javaScript:return false;" OnInit="hyperLink_Init">
                               </dx:ASPxHyperLink>
                           </DataItemTemplate>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CONSECUTIVO" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NIT" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CENTRO_COSTO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="6">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CUENTA_CONTABLE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="7">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DESCRIPCION" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="8">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TIPO_ASIENTO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="9">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FUENTE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="10">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="REFERENCIA" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="11">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ORIGEN" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="12">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DEBITO_DOLAR" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="13">
                            <PropertiesTextEdit DisplayFormatString="#,###.00">
                </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CREDITO_DOLAR" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="14">
                            <PropertiesTextEdit DisplayFormatString="#,###.00">
                </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
              <dx:GridViewDataTextColumn FieldName="DEBITO_LOCAL" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="15">
                            <PropertiesTextEdit DisplayFormatString="#,###.00">
                </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CREDITO_LOCAL" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="16">
                            <PropertiesTextEdit DisplayFormatString="#,###.00">
                </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn FieldName="CONTABILIDAD" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="17">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ASIENTOKEY" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="18">
                        </dx:GridViewDataTextColumn>

                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="#,###.00" FieldName="DEBITO_DOLAR" ShowInColumn="DEBITO_DOLAR" ShowInGroupFooterColumn="DEBITO_DOLAR" SummaryType="Sum" ValueDisplayFormat="#0,000.00" />
                        <dx:ASPxSummaryItem DisplayFormat="#,###.00" FieldName="DEBITO_LOCAL" ShowInColumn="DEBITO_LOCAL" ShowInGroupFooterColumn="DEBITO_LOCAL" SummaryType="Sum" ValueDisplayFormat="#0,000.00" />
                        <dx:ASPxSummaryItem DisplayFormat="#,###.00" FieldName="CREDITO_DOLAR" ShowInColumn="CREDITO_DOLAR" ShowInGroupFooterColumn="CREDITO_DOLAR" SummaryType="Sum" ValueDisplayFormat="#0,000.00" />
                        <dx:ASPxSummaryItem DisplayFormat="#,###.00" FieldName="CREDITO_LOCAL" ShowInColumn="CREDITO_LOCAL" ShowInGroupFooterColumn="CREDITO_LOCAL" SummaryType="Sum" ValueDisplayFormat="#0,000.00" />
                    </TotalSummary>
                    <Styles>
                        <Header ImageSpacing="5px" SortingImageSpacing="5px" />
                    </Styles>
                </dx:ASPxGridView>
             </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

      

    <dx:ASPxPopupControl ID="ASPxPopupControl2" runat="server" AllowDragging="True" ClientInstanceName="DrillDownAsiento" CloseAction="CloseButton" HeaderText="Asiento" Height="1px" Left="200" Modal="true" Top="200" Width="153px"  OnWindowCallback="Popup_WindowCallback">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
                <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ExportExcel3_Click" Text="Export Excel">
           <Image Url="~/Imagenes/Excel.jpg">
           </Image>
       </dx:ASPxButton>
                <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" ExportedRowType="All" GridViewID="ASPxGridView2" FileName="DetalleAsiento">
                </dx:ASPxGridViewExporter>
                <asp:SqlDataSource ID="SQLAsiento" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$;connect timeout=0;" OnSelecting="SQLCompras_Selecting" ProviderName="System.Data.SqlClient" SelectCommand="portal.[dbo].[PORTAL_BALANCE_ASIENTO]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="PCia1" Type="String" />
                        <asp:Parameter Name="PAsiento" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
    <br />
    <div> 
                <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewAsiento" OnCustomCallback="ASPxGridAsiento_CustomCallback" DataSourceID="SQLAsiento">
                    <ClientSideEvents EndCallback="onGridEndCallback" />
                    <Settings ShowFooter="True" ShowFilterRow="True" />

<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>

                    <SettingsSearchPanel Visible="True" />

                    <SettingsLoadingPanel Mode="ShowOnStatusBar" />
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="CIA" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FECHA" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="1">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="ASIENTO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CONSECUTIVO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NIT" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CENTRO_COSTO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CUENTA_CONTABLE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="6">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DESCRIPCION" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="7">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TIPO_ASIENTO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="8">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FUENTE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="9">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="REFERENCIA" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="10">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ORIGEN" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="11">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DEBITO_DOLAR" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="12">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CREDITO_DOLAR" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="13">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DEBITO_LOCAL" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="14">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CREDITO_LOCAL" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="15">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CONTABILIDAD" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="16">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="HECHO_POR" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="17">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FECHA_CREA" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="18">
                        </dx:GridViewDataDateColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="#,###.00" FieldName="DEBITO_DOLAR" ShowInColumn="DEBITO_DOLAR" ShowInGroupFooterColumn="DEBITO_DOLAR" SummaryType="Sum" ValueDisplayFormat="#0,000.00" />
                        <dx:ASPxSummaryItem DisplayFormat="#,###.00" FieldName="DEBITO_LOCAL" ShowInColumn="DEBITO_LOCAL" ShowInGroupFooterColumn="DEBITO_LOCAL" SummaryType="Sum" ValueDisplayFormat="#0,000.00" />
                        <dx:ASPxSummaryItem DisplayFormat="#,###.00" FieldName="CREDITO_DOLAR" ShowInColumn="CREDITO_DOLAR" ShowInGroupFooterColumn="CREDITO_DOLAR" SummaryType="Sum" ValueDisplayFormat="#0,000.00" />
                        <dx:ASPxSummaryItem DisplayFormat="#,###.00" FieldName="CREDITO_LOCAL" ShowInColumn="CREDITO_LOCAL" ShowInGroupFooterColumn="CREDITO_LOCAL" SummaryType="Sum" ValueDisplayFormat="#0,000.00" />
                    </TotalSummary>
                    <Styles>
                        <Header ImageSpacing="5px" SortingImageSpacing="5px" />
                    </Styles>
                </dx:ASPxGridView>
             </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>





    <dx:ASPxPopupControl ID="PDialogo" runat="server" Height="130px" Width="1445px" HeaderText="Reporte de Balance"  ClientInstanceName="PDialogo" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
                    <SettingsAdaptivity VerticalAlign="WindowCenter" />
                    <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <table style="width:100%;">
        <tr>
            <td class="auto-style8">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8"></td>
            <td class="auto-style3" colspan="3">
                &nbsp;</td>
            <td class="auto-style3">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8">
                <dx:ASPxReportDesigner ID="RepBalanceComp" runat="server" DisableHttpHandlerValidation="False">
                    <MenuItems>
                        <cc1:ClientControlsMenuItem>
                        </cc1:ClientControlsMenuItem>
                    </MenuItems>
                </dx:ASPxReportDesigner>
            </td>
            <td class="auto-style3">&nbsp;
                <br />
                &nbsp;</td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
        </tr>
        <tr>
            <td class="auto-style9">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
            <td class="progress-xxlarge">
                &nbsp;</td>
            <td class="progress-xxlarge"></td>
            <td class="progress-xxlarge">
                &nbsp;</td>
            <td class="progress-xxlarge"></td>
        </tr>
        <tr>
            <td class="auto-style8">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
                        </dx:PopupControlContentControl>
</ContentCollection>
                </dx:ASPxPopupControl>


    


             </asp:Content>
