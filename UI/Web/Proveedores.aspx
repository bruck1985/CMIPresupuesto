<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="UI.Web.Proveedores" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Maestro de proveedores"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="809px">
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
                    <dx:LayoutItem Caption="Seleccione estado proveedor" ColSpan="1" Name="CB_Tipo_Reporte">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="tiporep" runat="server" SelectedIndex="1" Theme="SoftOrange" Width="133px" Height="19px">
                                    <Items>
                                        <dx:ListEditItem Text="Todos" Value="%" />
                                        <dx:ListEditItem Text="Activos" Value="S" Selected="True" />
                                        <dx:ListEditItem Text="No Activos" Value="N" />
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
                                <dx:ASPxButton ID="Lform_E2" runat="server" AutoPostBack="False" Height="32px" Width="32px" ToolTip="Lista de Campos">
                                    <ClientSideEvents Click="function(s, e) {
	PivotCompra.ChangeCustomizationFieldsVisibility(); return false; 
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
    <asp:SqlDataSource ID="SQLCompras" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_PROVEEDORES]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="S" Name="PESTADO" SessionField="pv_estado" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxPivotGridExporter ID="ASPxPivExp1" runat="server" ASPxPivotGridID="PivotCompra">
        <OptionsPrint MergeColumnFieldValues="False" MergeRowFieldValues="False" PrintHorzLines="True" PrintVertLines="False" VerticalContentSplitting="Exact">
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
    <dx:ASPxPivotGrid ID="PivotCompra" runat="server" ClientIDMode="AutoID" DataSourceID="SQLCompras" Theme="Office365" ClientInstanceName="PivotCompra">
        <Fields>
            <dx:PivotGridField ID="fieldACEPTADOCELECTRONICO" FieldName="ACEPTA_DOC_ELECTRONICO" Name="fieldACEPTADOCELECTRONICO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldACTIVO" FieldName="ACTIVO" Name="fieldACTIVO" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldALIAS" AreaIndex="0" FieldName="ALIAS" Name="fieldALIAS" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldAUTORETENEDOR" FieldName="AUTORETENEDOR" Name="fieldAUTORETENEDOR" AreaIndex="0" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCARGO" AreaIndex="0" FieldName="CARGO" Name="fieldCARGO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCATEGORIAPROVEED" Area="RowArea" AreaIndex="10" FieldName="CATEGORIA_PROVEED" Name="fieldCATEGORIAPROVEED">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCODIGOIMPUESTO" AreaIndex="0" FieldName="CODIGO_IMPUESTO" Name="fieldCODIGOIMPUESTO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCIA" Area="RowArea" AreaIndex="0" FieldName="CIA" Name="fieldCIA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCONDICIONPAGO" FieldName="CONDICION_PAGO" Name="fieldCONDICIONPAGO" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCONGELADO" FieldName="CONGELADO" Name="fieldCONGELADO" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCONTACTO" FieldName="CONTACTO" Name="fieldCONTACTO" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCONTRIBUYENTE" FieldName="CONTRIBUYENTE" Name="fieldCONTRIBUYENTE" Area="RowArea" AreaIndex="3">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCURP" FieldName="CURP" Name="fieldCURP" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCUENTO" FieldName="DESCUENTO" Name="fieldDESCUENTO" AreaIndex="0" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDETALLEDIRECCION" FieldName="DETALLE_DIRECCION" Name="fieldDETALLEDIRECCION" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDIRECCION" FieldName="DIRECCION" Name="fieldDIRECCION" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDIVISIONGEOGRAFICA1" FieldName="DIVISION_GEOGRAFICA1" Name="fieldDIVISIONGEOGRAFICA1" AreaIndex="0" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDIVISIONGEOGRAFICA2" FieldName="DIVISION_GEOGRAFICA2" Name="fieldDIVISIONGEOGRAFICA2" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDIVISIONGEOGRAFICA3" FieldName="DIVISION_GEOGRAFICA3" Name="fieldDIVISIONGEOGRAFICA3" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDIVISIONGEOGRAFICA4" FieldName="DIVISION_GEOGRAFICA4" Name="fieldDIVISIONGEOGRAFICA4" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldEMAIL" FieldName="E_MAIL" Name="fieldEMAIL" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldEMAILDOCELECTRONICO" FieldName="EMAIL_DOC_ELECTRONICO" Name="fieldEMAILDOCELECTRONICO" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldEMAILDOCELECTRONICOCOPIA" FieldName="EMAIL_DOC_ELECTRONICO_COPIA" Name="fieldEMAILDOCELECTRONICOCOPIA" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFAX" FieldName="FAX" Name="fieldFAX" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFCHHORAULTMOD" FieldName="FCH_HORA_ULT_MOD" Name="fieldFCHHORAULTMOD" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAHORACREACION" FieldName="FECHA_HORA_CREACION" Name="fieldFECHAHORACREACION" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAINGRESO" FieldName="FECHA_INGRESO" Name="fieldFECHAINGRESO" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAULTMOV" FieldName="FECHA_ULT_MOV" Name="fieldFECHAULTMOV" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldGLN" FieldName="GLN" Name="fieldGLN" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldIMPUESTO1INCLUIDO" FieldName="IMPUESTO1_INCLUIDO" Name="fieldIMPUESTO1INCLUIDO" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldINTERNACIONES" FieldName="INTERNACIONES" Name="fieldINTERNACIONES" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldITEMHACIENDACOMPRA" FieldName="ITEM_HACIENDA_COMPRA" Name="fieldITEMHACIENDACOMPRA" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldLOCAL" FieldName="LOCAL" Name="fieldLOCAL" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMODELORETENCION" FieldName="MODELO_RETENCION" Name="fieldMODELORETENCION" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONEDA" FieldName="MONEDA" Name="fieldMONEDA" Area="RowArea" AreaIndex="4">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMULTIMONEDA" FieldName="MULTIMONEDA" Name="fieldMULTIMONEDA" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNOMBRE" Area="RowArea" AreaIndex="2" FieldName="NOMBRE" Name="fieldNOMBRE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldREGIMENTRIB" FieldName="REGIMEN_TRIB" Name="fieldREGIMENTRIB" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO1PROV" FieldName="RUBRO1_PROV" Name="fieldRUBRO1PROV" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO1PROVEEDOR" FieldName="RUBRO1_PROVEEDOR" Name="fieldRUBRO1PROVEEDOR" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO10PROVEEDOR" FieldName="RUBRO10_PROVEEDOR" Name="fieldRUBRO10PROVEEDOR" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO2PROV" FieldName="RUBRO2_PROV" Name="fieldRUBRO2PROV" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO2PROVEEDOR" FieldName="RUBRO2_PROVEEDOR" Name="fieldRUBRO2PROVEEDOR" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO3PROV" FieldName="RUBRO3_PROV" Name="fieldRUBRO3PROV" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO3PROVEEDOR" FieldName="RUBRO3_PROVEEDOR" Name="fieldRUBRO3PROVEEDOR" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO4PROV" FieldName="RUBRO4_PROV" Name="fieldRUBRO4PROV" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
<dx:PivotGridField FieldName="RUBRO4_PROVEEDOR" Name="fieldRUBRO4PROVEEDOR" ID="fieldRUBRO4PROVEEDOR" Visible="False" AreaIndex="0"></dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO5PROV" FieldName="RUBRO5_PROV" Name="fieldRUBRO5PROV" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO5PROVEEDOR" FieldName="RUBRO5_PROVEEDOR" Name="fieldRUBRO5PROVEEDOR" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO6PROVEEDOR" FieldName="RUBRO6_PROVEEDOR" Name="fieldRUBRO6PROVEEDOR" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO7PROVEEDOR" FieldName="RUBRO7_PROVEEDOR" Name="fieldRUBRO7PROVEEDOR" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO8PROVEEDOR" FieldName="RUBRO8_PROVEEDOR" Name="fieldRUBRO8PROVEEDOR" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO9PROVEEDOR" FieldName="RUBRO9_PROVEEDOR" Name="fieldRUBRO9PROVEEDOR" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSALDO" FieldName="SALDO" Name="fieldSALDO" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSALDODOLAR" FieldName="SALDO_DOLAR" Name="fieldSALDODOLAR" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSALDOLOCAL" AreaIndex="0" FieldName="SALDO_LOCAL" Name="fieldSALDOLOCAL" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSALDOTRANS" FieldName="SALDO_TRANS" Name="fieldSALDOTRANS" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSALDOTRANSDOLAR" FieldName="SALDO_TRANS_DOLAR" Name="fieldSALDOTRANSDOLAR" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSALDOTRANSLOCAL" FieldName="SALDO_TRANS_LOCAL" Name="fieldSALDOTRANSLOCAL" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTASAINTERESMORA" FieldName="TASA_INTERES_MORA" Name="fieldTASAINTERESMORA" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTELEFONO1" FieldName="TELEFONO1" Name="fieldTELEFONO1" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTELEFONO2" FieldName="TELEFONO2" Name="fieldTELEFONO2" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPIFICACIONPROVEEDOR" FieldName="TIPIFICACION_PROVEEDOR" Name="fieldTIPIFICACIONPROVEEDOR" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPOCF" FieldName="TIPO_CF" Name="fieldTIPOCF" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPOCONTRIBUYENTE" FieldName="TIPO_CONTRIBUYENTE" Name="fieldTIPOCONTRIBUYENTE" Area="RowArea" AreaIndex="0" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPOIMPUESTO" FieldName="TIPO_IMPUESTO" Name="fieldTIPOIMPUESTO" AreaIndex="8" Area="RowArea">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPOTARIFA" FieldName="TIPO_TARIFA" Name="fieldTIPOTARIFA" AreaIndex="6" Area="RowArea">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUCARTAACEPTACION" FieldName="U_CARTA_ACEPTACION" Name="fieldUCARTAACEPTACION" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUPROVEEDORAE" FieldName="U_PROVEEDOR_AE" Name="fieldUPROVEEDORAE" Area="RowArea" AreaIndex="5">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUBICACION" FieldName="UBICACION" Name="fieldUBICACION" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUBICACIONDOCELECTRONICO" FieldName="UBICACIONDOCELECTRONICO" Name="fieldUBICACIONDOCELECTRONICO" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUSUARIOCREACION" FieldName="USUARIO_CREACION" Name="fieldUSUARIOCREACION" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUSUARIOULTMOD" FieldName="USUARIO_ULT_MOD" Name="fieldUSUARIOULTMOD" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
<dx:PivotGridField FieldName="XSLT_PERSONALIZADO" Name="fieldXSLTPERSONALIZADO" ID="fieldXSLTPERSONALIZADO" Visible="False" AreaIndex="0"></dx:PivotGridField>
            <dx:PivotGridField ID="fieldNOTAS" AreaIndex="0" FieldName="NOTAS" Name="fieldNOTAS" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNUMPROVEEDOR" AreaIndex="0" FieldName="NUMPROVEEDOR" Name="fieldNUMPROVEEDOR" Area="DataArea">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldORDENMINIMA" AreaIndex="0" FieldName="ORDEN_MINIMA" Name="fieldORDENMINIMA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPAIS" FieldName="PAIS" Name="fieldPAIS" Visible="False" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPARTICIPAFLUJOCAJA" AreaIndex="0" FieldName="PARTICIPA_FLUJOCAJA" Name="fieldPARTICIPAFLUJOCAJA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPERMITEDOCGP" AreaIndex="0" FieldName="PERMITE_DOC_GP" Name="fieldPERMITEDOCGP" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPORCTARIFA" AreaIndex="0" FieldName="PORC_TARIFA" Name="fieldPORCTARIFA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPROVEEDOR" AreaIndex="1" FieldName="PROVEEDOR" Name="fieldPROVEEDOR" Area="RowArea">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCTIPOIMPUESTO" Area="RowArea" AreaIndex="9" FieldName="DESC_TIPO_IMPUESTO" Name="fieldDESCTIPOIMPUESTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCTIPOTARIFA" Area="RowArea" AreaIndex="7" FieldName="DESC_TIPO_TARIFA" Name="fieldDESCTIPOTARIFA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCUENTABANCO1" FieldName="CUENTA_BANCO1" Name="fieldCUENTABANCO1" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCUENTABANCO2" FieldName="CUENTA_BANCO2" Name="fieldCUENTABANCO2" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCUENTABANCO3" FieldName="CUENTA_BANCO3" Name="fieldCUENTABANCO3" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCUENTABANCO4" FieldName="CUENTA_BANCO4" Name="fieldCUENTABANCO4" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldU_CATEGORIA_RAMO" FieldName="U_CATEGORIA_RAMO" Name="fieldU_CATEGORIA_RAMO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldU_CATEGORIA_MDA" FieldName="U_CATEGORIA_MDA" Name="fieldU_CATEGORIA_MDA" Visible="False">
            </dx:PivotGridField>
        </Fields>
    </dx:ASPxPivotGrid>


             </asp:Content>
