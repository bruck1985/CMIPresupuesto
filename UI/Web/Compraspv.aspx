<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Compraspv.aspx.cs" Inherits="UI.Web.Compraspv" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Ordenes de Compras"></asp:Label>
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
                    <dx:LayoutItem Caption="Seleccione estado orden" ColSpan="1" Name="CB_Tipo_Reporte">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="tiporep" runat="server" SelectedIndex="0" Theme="SoftOrange" Width="133px" Height="19px">
                                    <Items>
                                        <dx:ListEditItem Text="Todas" Value="%" Selected="True" />
                                        <dx:ListEditItem Text="Planeada" Value="A" />
                                        <dx:ListEditItem Text="Recibida" Value="R" />
                                        <dx:ListEditItem Text="Transito" Value="E" />
                                        <dx:ListEditItem Text="Cerrada" Value="U" />
                                        <dx:ListEditItem Text="Cancelada" Value="O" />
                                        <dx:ListEditItem Text="Por Aprobar" Value="P" />
                                        <dx:ListEditItem Text="Backorder" Value="I" />
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
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_COMPRAS]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="01/01/2020" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="02/03/2020" Name="Pfechafin" SessionField="ci_sfec2" />
            <asp:SessionParameter DefaultValue="A"  Name="Pestado_orden"  SessionField="ci_stipo"/>
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
            <dx:PivotGridField ID="fieldTOTALACOMPRAR" Area="RowArea" AreaIndex="9" FieldName="TOTAL_A_COMPRAR" Name="fieldTOTALACOMPRAR" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldORDENCOMPRA" Area="RowArea" AreaIndex="1" FieldName="ORDEN_COMPRA" Name="fieldORDENCOMPRA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCIA" Area="RowArea" AreaIndex="0" FieldName="CIA" Name="fieldCIA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPROVEEDOR" AreaIndex="0" FieldName="PROVEEDOR" Name="fieldPROVEEDOR">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNOMBRE" Area="RowArea" AreaIndex="3" FieldName="NOMBRE" Name="fieldNOMBRE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHA" Area="RowArea" AreaIndex="4" FieldName="FECHA" Name="fieldFECHA" CellFormat-FormatString="dd/MM/yyyy" CellFormat-FormatType="Custom" ValueFormat-FormatString="dd/MM/yyyy" ValueFormat-FormatType="Custom">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTOTALCAMBIO" Area="DataArea" AreaIndex="0" FieldName="TOTAL_CAMBIO" Name="fieldTOTALCAMBIO" Caption="TOTAL_DOLAR" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldBODEGA" FieldName="BODEGA" Name="fieldBODEGA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldAPLICACION" FieldName="APLICACION" Name="fieldAPLICACION" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldASIENTOCIERRE" FieldName="ASIENTO_CIERRE" Name="fieldASIENTOCIERRE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldBASEIMPUESTO1" FieldName="BASE_IMPUESTO1" Name="fieldBASEIMPUESTO1" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldBASEIMPUESTO2" FieldName="BASE_IMPUESTO2" Name="fieldBASEIMPUESTO2" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCODDIRECEMB" FieldName="COD_DIREC_EMB" Name="fieldCODDIRECEMB" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldOBSERVACIONES1" FieldName="OBSERVACIONES" Name="fieldOBSERVACIONES1" Area="RowArea" AreaIndex="5">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCONDICIONPAGO" FieldName="CONDICION_PAGO" Name="fieldCONDICIONPAGO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCONFIRMADA" FieldName="CONFIRMADA" Name="fieldCONFIRMADA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDEPARTAMENTO" FieldName="DEPARTAMENTO" Name="fieldDEPARTAMENTO" Area="RowArea" AreaIndex="6">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDIRECCIONCOBRO" FieldName="DIRECCION_COBRO" Name="fieldDIRECCIONCOBRO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDIRECCIONEMBARQUE" FieldName="DIRECCION_EMBARQUE" Name="fieldDIRECCIONEMBARQUE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldESTADO" FieldName="ESTADO" Name="fieldESTADO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFACTURA" FieldName="FACTURA" Name="fieldFACTURA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHACOTIZACION" FieldName="FECHA_COTIZACION" Name="fieldFECHACOTIZACION" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAEMISION" FieldName="FECHA_EMISION" Name="fieldFECHAEMISION" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAFACTURA" FieldName="FECHA_FACTURA" Name="fieldFECHAFACTURA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAHORA" FieldName="FECHA_HORA" Name="fieldFECHAHORA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAHORACANCELA" FieldName="FECHA_HORA_CANCELA" Name="fieldFECHAHORACANCELA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAHORACIERRE" FieldName="FECHA_HORA_CIERRE" Name="fieldFECHAHORACIERRE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAHORACONFIR" FieldName="FECHA_HORA_CONFIR" Name="fieldFECHAHORACONFIR" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHANOAPRUEBA" FieldName="FECHA_NO_APRUEBA" Name="fieldFECHANOAPRUEBA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAOFRECIDA" FieldName="FECHA_OFRECIDA" Name="fieldFECHAOFRECIDA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAREQEMBARQUE" FieldName="FECHA_REQ_EMBARQUE" Name="fieldFECHAREQEMBARQUE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHARIGE" FieldName="FECHA_RIGE" Name="fieldFECHARIGE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAULTNOTIF" FieldName="FECHA_ULT_NOTIF" Name="fieldFECHAULTNOTIF" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldIMPRESA" FieldName="IMPRESA" Name="fieldIMPRESA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldINSTRUCCIONES" FieldName="INSTRUCCIONES" Name="fieldINSTRUCCIONES" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMODULOORIGEN" FieldName="MODULO_ORIGEN" Name="fieldMODULOORIGEN" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONEDA" FieldName="MONEDA" Name="fieldMONEDA" Area="RowArea" AreaIndex="8">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONTOANTICIPO" FieldName="MONTO_ANTICIPO" Name="fieldMONTOANTICIPO" Visible="False" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONTODESCUENTO" FieldName="MONTO_DESCUENTO" Name="fieldMONTODESCUENTO" Visible="False"  CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONTODOCUMENTACIO" FieldName="MONTO_DOCUMENTACIO" Name="fieldMONTODOCUMENTACIO" Visible="False" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONTOFACTURA" FieldName="MONTO_FACTURA" Name="fieldMONTOFACTURA" Visible="False" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONTOFLETE" FieldName="MONTO_FLETE" Name="fieldMONTOFLETE" Visible="False" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONTOSEGURO" FieldName="MONTO_SEGURO" Name="fieldMONTOSEGURO" Visible="False" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNOTASNOAPROBAR" FieldName="NOTAS_NOAPROBAR" Name="fieldNOTASNOAPROBAR" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNUMFORMULARIO" FieldName="NUM_FORMULARIO" Name="fieldNUMFORMULARIO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldOBSERVACIONES" FieldName="OBSERVACIONES" Name="fieldOBSERVACIONES" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPAIS" FieldName="PAIS" Name="fieldPAIS" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPRIORIDAD" FieldName="PRIORIDAD" Name="fieldPRIORIDAD" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRECIBIDODEMAS" FieldName="RECIBIDO_DE_MAS" Name="fieldRECIBIDODEMAS" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldREQUIERECONFIRMA" FieldName="REQUIERE_CONFIRMA" Name="fieldREQUIERECONFIRMA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRESPONSEGUIMIENTO" FieldName="RESPON_SEGUIMIENTO" Name="fieldRESPONSEGUIMIENTO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO1" FieldName="RUBRO1" Name="fieldRUBRO1" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO2" FieldName="RUBRO2" Name="fieldRUBRO2" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO3" FieldName="RUBRO3" Name="fieldRUBRO3" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO4" FieldName="RUBRO4" Name="fieldRUBRO4" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPRESUPUESTOCR" Area="RowArea" AreaIndex="7" FieldName="PRESUPUESTO_CR" Name="fieldPRESUPUESTOCR">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO5" FieldName="RUBRO5" Name="fieldRUBRO5" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSUBTIPO" FieldName="SUBTIPO" Name="fieldSUBTIPO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPODESCUENTO" FieldName="TIPO_DESCUENTO" Name="fieldTIPODESCUENTO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPOPRORRATEOOC" FieldName="TIPO_PRORRATEO_OC" Name="fieldTIPOPRORRATEOOC" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTOTIMP1ASUMDESC" FieldName="TOT_IMP1_ASUM_DESC" Name="fieldTOTIMP1ASUMDESC" Visible="False" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTOTIMP1ASUMNODESC" FieldName="TOT_IMP1_ASUM_NODESC" Name="fieldTOTIMP1ASUMNODESC" Visible="False" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTOTIMP1RETEDESC" FieldName="TOT_IMP1_RETE_DESC" Name="fieldTOTIMP1RETEDESC" Visible="False" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTOTIMP1RETENODESC" FieldName="TOT_IMP1_RETE_NODESC" Name="fieldTOTIMP1RETENODESC" Visible="False" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTOTALIMPUESTO1" FieldName="TOTAL_IMPUESTO1" Name="fieldTOTALIMPUESTO1" Visible="False" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTOTALIMPUESTO2" FieldName="TOTAL_IMPUESTO2" Name="fieldTOTALIMPUESTO2" Visible="False" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTOTALMERCADERIA" FieldName="TOTAL_MERCADERIA" Name="fieldTOTALMERCADERIA" Visible="False" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUCARTAACEPTACION" FieldName="U_CARTA_ACEPTACION" Name="fieldUCARTAACEPTACION" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUOCEAM" FieldName="U_OCEAM" Name="fieldUOCEAM" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUSUARIO" FieldName="USUARIO" Name="fieldUSUARIO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUSUARIOCANCELA" FieldName="USUARIO_CANCELA" Name="fieldUSUARIOCANCELA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUSUARIOCIERRE" FieldName="USUARIO_CIERRE" Name="fieldUSUARIOCIERRE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUSUARIOCONFIRMA" FieldName="USUARIO_CONFIRMA" Name="fieldUSUARIOCONFIRMA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUSUARIONOAPRUEBA" FieldName="USUARIO_NO_APRUEBA" Name="fieldUSUARIONOAPRUEBA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldESTADODESC" AreaIndex="2" FieldName="ESTADO_DESC" Name="fieldESTADODESC" Area="RowArea">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCOMENTARIOCXP" AreaIndex="1" FieldName="COMENTARIO_CXP" Name="fieldCOMENTARIOCXP">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPAISCIA" AreaIndex="2" FieldName="PAIS_CIA" Name="fieldPAISCIA">
            </dx:PivotGridField>
        </Fields>
    </dx:ASPxPivotGrid>


             </asp:Content>
