<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Contaudf.aspx.cs" Inherits="UI.Web.Contaudf" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Asientos x UDF"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="1050px" style="margin-top: 0px">
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

 


          <dx:LayoutItem Caption="Tipo de Reporte"  ColSpan="1" Name="tiporeporte"  Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E3" runat="server"  Theme="SoftOrange" SelectedIndex="0" >
                                    <Items>
                                        <dx:ListEditItem Selected="True" Text="CSV" Value="0" />
                                        <dx:ListEditItem Text="UDFs para revisión" Value="1" />
                                    </Items>
                                </dx:ASPxComboBox>
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
    <asp:SqlDataSource ID="SQLConta" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$;connect timeout=0;" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_CONTA_UDF]" SelectCommandType="StoredProcedure" OnSelecting="SQLCompras_Selecting">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="01/01/2020" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="02/03/2020" Name="Pfechafin" SessionField="ci_sfec2" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLConta2" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$;connect timeout=0;" ProviderName="System.Data.SqlClient" SelectCommand="SELECT TOP (1000) CIA, FECHA_CONTABILIZACION, PERIODO_CONTABLE, U_TIPOVALOR, U_CMI_MAPPING, U_PAIS, U_SOCIEDAD_GL, U_SOCASO, UN_Division, CANAL, SECTOR, PROVEEDOR, CLIENTE, INDICADOR, IMPORTE, U_MONEDA_LOCAL, IMPORTE_TRANSACCION, U_MONEDA_TRANSACCION, CEBE, CE_CO_SAP, CECO_ORIGEN, TIPO_DOCUMENTO, AREA_FUNCIONAL, Descripcion, U_ENTITY, U_LEDGER, U_MONEDA_GRUPO, U_EXPENSES_TYPE, U_GROUP_OVERHEAD, U_ORDEN_EEFF, GRUPO_ORDEN_ER, U_INTERCO_NON_INTECO, U_CIA_INTERCOM, U_AGRUP_EEFF, U_AGRUP_TIPO, U_AGRUP_NOM_CTA, U_CODCASHFLOW FROM PORTAL.dbo.CONTA_UDF" OnSelecting="SQLCompras_Selecting">
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

    <dx:ASPxPivotGrid ID="PivotCompra" runat="server" ClientIDMode="AutoID" DataSourceID="SQLConta" Theme="Office365" ClientInstanceName="PivotCompra">
        <Fields>
            <dx:PivotGridField ID="fieldCIA" Area="RowArea" AreaIndex="0" FieldName="CIA" Name="fieldCIA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHACONTABILIZACION" Area="RowArea" AreaIndex="1" FieldName="FECHA_CONTABILIZACION" Name="fieldFECHACONTABILIZACION">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPERIODOCONTABLE" Area="RowArea" AreaIndex="2" FieldName="PERIODO_CONTABLE" Name="fieldPERIODOCONTABLE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUTIPOVALOR" Area="RowArea" AreaIndex="3" FieldName="U_TIPOVALOR" Name="fieldUTIPOVALOR">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUCMIMAPPING" Area="RowArea" AreaIndex="4" FieldName="U_CMI_MAPPING" Name="fieldUCMIMAPPING">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUPAIS" Area="RowArea" AreaIndex="5" FieldName="U_PAIS" Name="fieldUPAIS">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUSOCIEDADGL" Area="RowArea" AreaIndex="6" FieldName="U_SOCIEDAD_GL" Name="fieldUSOCIEDADGL">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUSOCASO" Area="RowArea" AreaIndex="7" FieldName="U_SOCASO" Name="fieldUSOCASO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUNDivision" Area="RowArea" AreaIndex="8" FieldName="UN_Division" Name="fieldUNDivision">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCANAL" Area="RowArea" AreaIndex="9" FieldName="CANAL" Name="fieldCANAL">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSECTOR" Area="RowArea" AreaIndex="10" FieldName="SECTOR" Name="fieldSECTOR">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPROVEEDOR" Area="RowArea" AreaIndex="11" FieldName="PROVEEDOR" Name="fieldPROVEEDOR">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCLIENTE" Area="RowArea" AreaIndex="12" FieldName="CLIENTE" Name="fieldCLIENTE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldINDICADOR" Area="RowArea" AreaIndex="13" FieldName="INDICADOR" Name="fieldINDICADOR">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUMONEDALOCAL" Area="RowArea" AreaIndex="14" FieldName="U_MONEDA_LOCAL" Name="fieldUMONEDALOCAL">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldIMPORTE" Area="RowArea" AreaIndex="15" FieldName="IMPORTE" Name="fieldIMPORTE" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUMONEDATRANSACCION" AreaIndex="0" FieldName="U_MONEDA_TRANSACCION" Name="fieldUMONEDATRANSACCION" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldIMPORTETRANSACCION" Area="RowArea" AreaIndex="17" FieldName="IMPORTE_TRANSACCION" Name="fieldIMPORTETRANSACCION" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCEBE" Area="RowArea" AreaIndex="18" FieldName="CEBE" Name="fieldCEBE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCECOSAP" Area="RowArea" AreaIndex="19" FieldName="CE_CO_SAP" Name="fieldCECOSAP">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCECOORIGEN" Area="RowArea" AreaIndex="20" FieldName="CECO_ORIGEN" Name="fieldCECOORIGEN">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCUENTACONTABLE" Area="RowArea" AreaIndex="21" FieldName="CUENTA_CONTABLE" Name="fieldCUENTACONTABLE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPODOCUMENTO" Area="RowArea" AreaIndex="22" FieldName="TIPO_DOCUMENTO" Name="fieldTIPODOCUMENTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldAREAFUNCIONAL" Area="RowArea" AreaIndex="23" FieldName="AREA_FUNCIONAL" Name="fieldAREAFUNCIONAL">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDescripcion" FieldName="Descripcion" Name="fieldDescripcion" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUENTITY" FieldName="U_ENTITY" Name="fieldUENTITY" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldULEDGER" FieldName="U_LEDGER" Name="fieldULEDGER" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUMONEDAGRUPO" FieldName="U_MONEDA_GRUPO" Name="fieldUMONEDAGRUPO" Area="RowArea" AreaIndex="16">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUEXPENSESTYPE" FieldName="U_EXPENSES_TYPE" Name="fieldUEXPENSESTYPE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUGROUPOVERHEAD" FieldName="U_GROUP_OVERHEAD" Name="fieldUGROUPOVERHEAD" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUORDENEEFF" FieldName="U_ORDEN_EEFF" Name="fieldUORDENEEFF" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldGRUPOORDENER" FieldName="GRUPO_ORDEN_ER" Name="fieldGRUPOORDENER" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUINTERCONONINTECO" FieldName="U_INTERCO_NON_INTECO" Name="fieldUINTERCONONINTECO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUCIAINTERCOM" FieldName="U_CIA_INTERCOM" Name="fieldUCIAINTERCOM" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUAGRUPEEFF" FieldName="U_AGRUP_EEFF" Name="fieldUAGRUPEEFF" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUAGRUPTIPO" FieldName="U_AGRUP_TIPO" Name="fieldUAGRUPTIPO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUAGRUPNOMCTA" FieldName="U_AGRUP_NOM_CTA" Name="fieldUAGRUPNOMCTA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUCODCASHFLOW" FieldName="U_CODCASHFLOW" Name="fieldUCODCASHFLOW" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMAYORIZADO" FieldName="MAYORIZADO" Name="fieldMAYORIZADO" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCLASECUENTA" AreaIndex="0" FieldName="CLASE_CUENTA" Name="fieldCLASECUENTA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldORDENER" AreaIndex="0" FieldName="ORDENER" Name="fieldORDENER" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUCTAINTERCOM" AreaIndex="0" FieldName="U_CTA_INTERCOM" Name="fieldUCTAINTERCOM" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUCARESEP" Area="RowArea" AreaIndex="24" FieldName="U_C_ARESEP" Name="fieldUCARESEP">
            </dx:PivotGridField>
        </Fields>
    </dx:ASPxPivotGrid>

      
             </asp:Content>
