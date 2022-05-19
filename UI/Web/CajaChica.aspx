<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="CajaChica.aspx.cs" Inherits="UI.Web.CajaChica" %>
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
    </script>
    <input runat="server" id="ColumnIndex" type="hidden" enableviewstate="true" />
    <input runat="server" id="RowIndex" type="hidden" enableviewstate="true" />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Vales Caja Chica"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="920px" style="margin-top: 0px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Seleccione compañia" ColSpan="1" Name="CiaOrigen" Width="60px">
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
    <asp:SqlDataSource ID="SQLCaja_Chica" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$;connect timeout=0;" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_CAJA_CHICA]" SelectCommandType="StoredProcedure" OnSelecting="SQLCompras_Selecting">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="TC XXXXXX" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="01/10/2021" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="30/10/2021" Name="Pfechafin" SessionField="ci_sfec2" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxPivotGridExporter ID="ASPxPivExp1" runat="server" ASPxPivotGridID="PivotCompra">
        <OptionsPrint MergeColumnFieldValues="False" MergeRowFieldValues="False" PrintHorzLines="True" PrintVertLines="False" VerticalContentSplitting="Exact" PrintFilterHeaders="False">
        </OptionsPrint>
    </dx:ASPxPivotGridExporter>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM [ME].[erpadmin].[PRIVILEGIO_EX] P, me.erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep
" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataCentroCosto" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_CENTROSCOSTOS]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="CROMSA XXXXXXXXZXX" Name="PCia1" SessionField="CIAS_OC_PRES" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <dx:ASPxPivotGrid ID="PivotCompra" runat="server" ClientIDMode="AutoID" DataSourceID="SQLCaja_Chica" Theme="Office365" ClientInstanceName="PivotCompra">
        <Fields>
            <dx:PivotGridField ID="fieldCIA" Area="RowArea" AreaIndex="0" FieldName="CIA" Name="fieldCIA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCAJACHICA" Area="RowArea" AreaIndex="1" FieldName="CAJA_CHICA" Name="fieldCAJACHICA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldVALE" Area="RowArea" AreaIndex="3" FieldName="VALE" Name="fieldVALE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCCONCEPTOVALE" AreaIndex="5" FieldName="DESC_CONCEPTO_VALE" Name="fieldDESCCONCEPTOVALE" Area="RowArea" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAEMISION" Area="RowArea" AreaIndex="4" FieldName="FECHA_EMISION" Name="fieldFECHAEMISION">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONTODOLAR" AreaIndex="0" FieldName="MONTO_DOLAR" Name="fieldMONTODOLAR"  CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONTOLOCAL" AreaIndex="1" FieldName="MONTO_LOCAL" Name="fieldMONTOLOCAL"  CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldBENEFICIARIO" FieldName="BENEFICIARIO" Name="fieldBENEFICIARIO" AreaIndex="2">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCONCEPTOVALE" FieldName="CONCEPTO_VALE" Name="fieldCONCEPTOVALE" AreaIndex="5" Area="RowArea">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCONSECUTIVO" FieldName="CONSECUTIVO" Name="fieldCONSECUTIVO" AreaIndex="3">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCONSECUTIVODOC" AreaIndex="4" FieldName="CONSECUTIVO_DOC" Name="fieldCONSECUTIVODOC">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDEPARTAMENTO" AreaIndex="5" FieldName="DEPARTAMENTO" Name="fieldDEPARTAMENTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCCAJACHICA" FieldName="DESC_CAJA_CHICA" Name="fieldDESCCAJACHICA" AreaIndex="2" Area="RowArea">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCCONCEPTOVALE1" FieldName="DESC_CONCEPTO_VALE" Name="fieldDESCCONCEPTOVALE1" AreaIndex="18">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCDEPARTAMENTO" FieldName="DESC_DEPARTAMENTO" Name="fieldDESCDEPARTAMENTO" AreaIndex="6">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldESTADO" FieldName="ESTADO" Name="fieldESTADO" AreaIndex="7" Area="RowArea">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFACTURAELECTRONICA" AreaIndex="7" FieldName="FACTURA_ELECTRONICA" Name="fieldFACTURAELECTRONICA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAANULACION" AreaIndex="8" FieldName="FECHA_ANULACION" Name="fieldFECHAANULACION">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHALIQUIDACION" AreaIndex="9" FieldName="FECHA_LIQUIDACION" Name="fieldFECHALIQUIDACION">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAMODIFIC" AreaIndex="10" FieldName="FECHA_MODIFIC" Name="fieldFECHAMODIFIC">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAMODIFIC1" AreaIndex="11" FieldName="FECHA_MODIFIC" Name="fieldFECHAMODIFIC1">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONEDACAJA" AreaIndex="12" FieldName="MONEDA_CAJA" Name="fieldMONEDACAJA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNOMBENEFICIARIO" AreaIndex="13" FieldName="NOM_BENEFICIARIO" Name="fieldNOMBENEFICIARIO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNOTAS" AreaIndex="14" FieldName="NOTAS" Name="fieldNOTAS">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPRESUPUESTOCR" AreaIndex="16" FieldName="PRESUPUESTO_CR" Name="fieldPRESUPUESTOCR">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldREINTEGRO" AreaIndex="17" FieldName="REINTEGRO" Name="fieldREINTEGRO">
            </dx:PivotGridField>

            <dx:PivotGridField ID="fieldMONTOVALEDOL" Area="DataArea" AreaIndex="0" FieldName="MONTO_VALE_DOL" Name="fieldMONTOVALEDOL"   CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONTOVALELOC" Area="DataArea" AreaIndex="1" FieldName="MONTO_VALE_LOC" Name="fieldMONTOVALELOC"   CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00" >
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldLINEA" AreaIndex="15" FieldName="LINEA" Name="fieldLINEA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCENTROCOSTO" AreaIndex="14" FieldName="CENTRO_COSTO" Name="fieldCENTROCOSTO" Area="RowArea">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCUENTACONTABLE" AreaIndex="15" FieldName="CUENTA_CONTABLE" Name="fieldCUENTACONTABLE" Area="RowArea">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNIT" AreaIndex="18" FieldName="NIT" Name="fieldNIT" Area="RowArea" Caption="CONTRIBUYENTE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPO" AreaIndex="11" FieldName="TIPO" Name="fieldTIPO" Area="RowArea">
            </dx:PivotGridField>

            <dx:PivotGridField ID="fieldASIENTO" Area="RowArea" AreaIndex="8" FieldName="ASIENTO" Name="fieldASIENTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONTOLIQUIDADO" Area="RowArea" AreaIndex="6" FieldName="MONTO_LIQUIDADO" Name="fieldMONTOLIQUIDADO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDOCUMENTOFISCAL" Area="RowArea" AreaIndex="12" FieldName="DOCUMENTO_FISCAL" Name="fieldDOCUMENTOFISCAL">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldASIENTOREINTEGRO" Area="RowArea" AreaIndex="9" FieldName="ASIENTO_REINTEGRO" Name="fieldASIENTOREINTEGRO">
            </dx:PivotGridField>
             <dx:PivotGridField ID="fieldDOCSOPORTE" Area="RowArea" AreaIndex="10" FieldName="DOC_SOPORTE" Name="fieldDOCSOPORTE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONTOCAJACHICA" Area="RowArea" AreaIndex="13" FieldName="MONTO_CAJA_CHICA" Name="fieldMONTOCAJACHICA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDETALLE" Area="RowArea" AreaIndex="16" FieldName="DETALLE" Name="fieldDETALLE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldIMPUESTO1" Area="RowArea" AreaIndex="28" FieldName="IMPUESTO1" Name="fieldIMPUESTO1" Caption="VENTAS(MONEDA CAJA)">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldIMP1AFECTACOSTO" Area="RowArea" AreaIndex="19" FieldName="IMP1_AFECTA_COSTO" Name="fieldIMP1AFECTACOSTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHARIGE" Area="RowArea" AreaIndex="17" FieldName="FECHA_RIGE" Name="fieldFECHARIGE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCODIGOIMPUESTO" Area="RowArea" AreaIndex="20" FieldName="CODIGO_IMPUESTO" Name="fieldCODIGOIMPUESTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldITEMHACIENDA" Area="RowArea" AreaIndex="39" FieldName="ITEM_HACIENDA" Name="fieldITEMHACIENDA" Caption="Actividad D-104">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCUBICGEOGRAFICA" Area="RowArea" AreaIndex="32" FieldName="DESC_UBIC_GEOGRAFICA" Name="fieldDESCUBICGEOGRAFICA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPOIMPUESTO1" Area="RowArea" AreaIndex="21" FieldName="TIPO_IMPUESTO1" Name="fieldTIPOIMPUESTO1">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPOIMPUESTO2" Area="RowArea" AreaIndex="24" FieldName="TIPO_IMPUESTO2" Name="fieldTIPOIMPUESTO2">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPOTARIFA1" Area="RowArea" AreaIndex="22" FieldName="TIPO_TARIFA1" Name="fieldTIPOTARIFA1">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPOTARIFA2" Area="RowArea" AreaIndex="25" FieldName="TIPO_TARIFA2" Name="fieldTIPOTARIFA2">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldIMPUESTO2" Area="RowArea" AreaIndex="35" FieldName="IMPUESTO2" Name="fieldIMPUESTO2" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPORCENTAJE2" Area="RowArea" AreaIndex="26" FieldName="PORCENTAJE2" Name="fieldPORCENTAJE2">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSUBTOTAL" Area="RowArea" AreaIndex="27" FieldName="SUBTOTAL" Name="fieldSUBTOTAL">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldACTIVIDADCOMERCIAL" Area="RowArea" AreaIndex="38" FieldName="ACTIVIDAD_COMERCIAL" Name="fieldACTIVIDADCOMERCIAL">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSUBTOTALBIENES" Area="RowArea" AreaIndex="29" FieldName="SUBTOTAL_BIENES" Name="fieldSUBTOTALBIENES">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSUBTOTALSERVICIOS" Area="RowArea" AreaIndex="40" FieldName="SUBTOTAL_SERVICIOS" Name="fieldSUBTOTALSERVICIOS" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldIMP1ASUMIDODESC" Area="RowArea" AreaIndex="38" FieldName="IMP1_ASUMIDO_DESC" Name="fieldIMP1ASUMIDODESC" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldIMP1ASUMIDONODESC" Area="RowArea" AreaIndex="38" FieldName="IMP1_ASUMIDO_NODESC" Name="fieldIMP1ASUMIDONODESC" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldIMP1RETENIDODESC" Area="RowArea" AreaIndex="38" FieldName="IMP1_RETENIDO_DESC" Name="fieldIMP1RETENIDODESC" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldIMP1RETENIDONODESC" Area="RowArea" AreaIndex="38" FieldName="IMP1_RETENIDO_NODESC" Name="fieldIMP1RETENIDONODESC" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPOIMPUESTO" Area="RowArea" AreaIndex="38" FieldName="TIPO_IMPUESTO" Name="fieldTIPOIMPUESTO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPOTARIFA" Area="RowArea" AreaIndex="38" FieldName="TIPO_TARIFA" Name="fieldTIPOTARIFA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPORCAFECTACIONIVA" Area="RowArea" AreaIndex="38" FieldName="PORC_AFECTACION_IVA" Name="fieldPORCAFECTACIONIVA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMontoTotalDeGastoAplicable" Area="RowArea" AreaIndex="36" FieldName="MontoTotalDeGastoAplicable" Name="fieldMontoTotalDeGastoAplicable">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMontoTotalImpuestoAcreditar" Area="RowArea" AreaIndex="35" FieldName="MontoTotalImpuestoAcreditar" Name="fieldMontoTotalImpuestoAcreditar">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMontoProporcionalidad" Area="RowArea" AreaIndex="37" FieldName="MontoProporcionalidad" Name="fieldMontoProporcionalidad">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPODOCREFERENCIA" Area="RowArea" AreaIndex="38" FieldName="TIPO_DOC_REFERENCIA" Name="fieldTIPODOCREFERENCIA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDIVISIONGEOGRAFICA1" Area="RowArea" AreaIndex="38" FieldName="DIVISION_GEOGRAFICA1" Name="fieldDIVISIONGEOGRAFICA1" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDIVISIONGEOGRAFICA2" Area="RowArea" AreaIndex="38" FieldName="DIVISION_GEOGRAFICA2" Name="fieldDIVISIONGEOGRAFICA2" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCAI" Area="RowArea" AreaIndex="38" FieldName="CAI" Name="fieldCAI" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRAZONREFERENCIA" Area="RowArea" AreaIndex="38" FieldName="RAZON_REFERENCIA" Name="fieldRAZONREFERENCIA" Visible="False">
            </dx:PivotGridField>

            <dx:PivotGridField ID="fieldPORCENTAJE1" Area="RowArea" AreaIndex="23" FieldName="PORCENTAJE1" Name="fieldPORCENTAJE1">
            </dx:PivotGridField>

            <dx:PivotGridField ID="fieldCONCEPTOSOP" Area="RowArea" AreaIndex="13" FieldName="CONCEPTO_SOP" Name="fieldCONCEPTOSOP">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSUBTIPO" Area="RowArea" AreaIndex="30" FieldName="SUBTIPO" Name="fieldSUBTIPO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCCONTRIBUYENTE" Area="RowArea" AreaIndex="31" FieldName="DESC_CONTRIBUYENTE" Name="fieldDESCCONTRIBUYENTE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCIMPUESTO" Area="RowArea" AreaIndex="33" FieldName="DESC_IMPUESTO" Name="fieldDESCIMPUESTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCTIPOAFECTACION" Area="RowArea" AreaIndex="34" FieldName="DESC_TIPO_AFECTACION" Name="fieldDESCTIPOAFECTACION">
            </dx:PivotGridField>

        </Fields>
    </dx:ASPxPivotGrid>

      
             </asp:Content>
