<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Compraspres.aspx.cs" Inherits="UI.Web.Compraspres" %>
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
             checkListBoxcc.PerformCallback(getSelectedItemsText(selectedItems));
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Ordenes de Compras X Centro de Costo"></asp:Label>
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
          <dx:LayoutItem Caption="Seleccione centro costo"  ColSpan="1" Name="centrocosto" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                               <dx:ASPxDropDownEdit ClientInstanceName="checkComboBoxcc" ID="ASPxDropDownEdit2cc" Width="285px" runat="server" AnimationType="None" Theme="SoftOrange" OnTextChanged="ASPxDropDownEdit2cc_TextChanged">
                                   <DropDownWindowStyle BackColor="#EDEDED" />
                                       <DropDownWindowTemplate>
                                       <dx:ASPxListBox Width="100%" ID="listBoxcc" ClientInstanceName="checkListBoxcc" SelectionMode="CheckColumn" OnCallback="Cmbcentrocosto_Callback"
                                           runat="server" Height="200" EnableSelectAll="true" DataSourceID="SqlDataCentroCosto" TextField="DESC_CENTRO_COSTO" ValueField="CENTRO_COSTO">
                                          <FilteringSettings ShowSearchUI="true"/>
                                          <Border BorderStyle="None" />
                                          <BorderBottom BorderStyle="Solid" BorderWidth="1px" BorderColor="#DCDCDC" />
                <ClientSideEvents SelectedIndexChanged="updateTextcc" Init="updateTextcc"/>
            </dx:ASPxListBox>
            <table style="width: 100%">
                <tr>
                    <td style="padding: 4px">
                        <dx:ASPxButton ID="ASPxButton1cc" AutoPostBack="False" runat="server" Text="Close" style="float: right">
                            <ClientSideEvents Click="function(s, e){ checkComboBoxcc.HideDropDown(); }" />
                        </dx:ASPxButton>
                    </td>
                </tr>
            </table>
        </DropDownWindowTemplate>
        <ClientSideEvents TextChanged="synchronizeListBoxValuescc" DropDown="synchronizeListBoxValuescc" />
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
    <asp:SqlDataSource ID="SQLCompras" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$;connect timeout=0;" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_COMPRAS_PRES]" SelectCommandType="StoredProcedure" OnSelecting="SQLCompras_Selecting">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="01/01/2020" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="02/03/2020" Name="Pfechafin" SessionField="ci_sfec2" />
            <asp:SessionParameter DefaultValue="CROMSA-034-204-108 Carlos Alberto Ulloa Salazar"  Name="PCentro_Costo"  SessionField="lista_ci_centrocosto" Type="String"/>
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

    <dx:ASPxPivotGrid ID="PivotCompra" runat="server" ClientIDMode="AutoID" DataSourceID="SQLCompras" Theme="Office365" ClientInstanceName="PivotCompra">
        <Fields>
            <dx:PivotGridField ID="fieldMONTOLOCAL" Area="RowArea" AreaIndex="14" FieldName="MONTO_LOCAL" Name="fieldMONTOLOCAL" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldORDENCOMPRA" Area="RowArea" AreaIndex="1" FieldName="ORDEN_COMPRA" Name="fieldORDENCOMPRA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCIA" Area="RowArea" AreaIndex="0" FieldName="CIA" Name="fieldCIA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPROVEEDOR" AreaIndex="2" FieldName="PROVEEDOR" Name="fieldPROVEEDOR">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNOMBRE" Area="RowArea" AreaIndex="3" FieldName="NOMBRE" Name="fieldNOMBRE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHA" Area="RowArea" AreaIndex="4" FieldName="FECHA" Name="fieldFECHA" CellFormat-FormatString="dd/MM/yyyy" CellFormat-FormatType="Custom" ValueFormat-FormatString="dd/MM/yyyy" ValueFormat-FormatType="Custom">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONTODOLAR" Area="DataArea" AreaIndex="0" FieldName="MONTO_DOLAR" Name="fieldMONTODOLAR" Caption="TOTAL_DOLAR" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCENTROCOSTO" FieldName="CENTRO_COSTO" Name="fieldCENTROCOSTO" Area="RowArea" AreaIndex="5">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCCENTROCOSTO" FieldName="DESC_CENTRO_COSTO" Name="fieldDESCCENTROCOSTO" Area="RowArea" AreaIndex="6">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONEDA" FieldName="MONEDA" Name="fieldMONEDA" Area="RowArea" AreaIndex="13">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPRESUPUESTOCR" Area="RowArea" AreaIndex="7" FieldName="PRESUPUESTO_CR" Name="fieldPRESUPUESTOCR" Caption="PRESUPUESTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldESTADODESC" AreaIndex="2" FieldName="ESTADO_DESC" Name="fieldESTADODESC" Area="RowArea" Caption="ESTADO DESC">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCOMENTARIOCXP" FieldName="COMENTARIO_CXP" Name="fieldCOMENTARIOCXP" AreaIndex="3">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPRESUPUESTOCR1" FieldName="PRESUPUESTO_CR" Name="fieldPRESUPUESTOCR1" Area="RowArea" AreaIndex="1" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCUENTACONTABLE" FieldName="CUENTA_CONTABLE" Name="fieldCUENTACONTABLE" Area="RowArea" AreaIndex="8">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCCUENTACONTABLE" FieldName="DESC_CUENTA_CONTABLE" Name="fieldDESCCUENTACONTABLE" Area="RowArea" AreaIndex="9">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDEPARTAMENTO" Area="RowArea" AreaIndex="11" FieldName="DEPARTAMENTO" Name="fieldDEPARTAMENTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldOBSERVACIONES" Area="RowArea" AreaIndex="10" FieldName="OBSERVACIONES" Name="fieldOBSERVACIONES">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUSUARIOCONFIRMA" AreaIndex="1" FieldName="USUARIO_CONFIRMA" Name="fieldUSUARIOCONFIRMA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNOMBREUSUARIOCONFIRMA" Area="RowArea" AreaIndex="12" FieldName="NOMBRE_USUARIO_CONFIRMA" Name="fieldNOMBREUSUARIOCONFIRMA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldAPLICACION" AreaIndex="0" FieldName="APLICACION" Name="fieldAPLICACION" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldASIENTOCIERRE" AreaIndex="0" FieldName="ASIENTO_CIERRE" Name="fieldASIENTOCIERRE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldBODEGA" AreaIndex="0" FieldName="BODEGA" Name="fieldBODEGA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCODDIRECEMB" AreaIndex="0" FieldName="COD_DIREC_EMB" Name="fieldCODDIRECEMB" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCONDICIONPAGO" AreaIndex="0" FieldName="CONDICION_PAGO" Name="fieldCONDICIONPAGO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCONFIRMADA" AreaIndex="0" FieldName="CONFIRMADA" Name="fieldCONFIRMADA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDEPARTAMENTO1" AreaIndex="0" FieldName="DEPARTAMENTO" Name="fieldDEPARTAMENTO1">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDIRECCIONCOBRO" AreaIndex="0" FieldName="DIRECCION_COBRO" Name="fieldDIRECCIONCOBRO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDIRECCIONEMBARQUE" AreaIndex="0" FieldName="DIRECCION_EMBARQUE" Name="fieldDIRECCIONEMBARQUE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFACTURA" AreaIndex="4" FieldName="FACTURA" Name="fieldFACTURA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHACOTIZACION" AreaIndex="0" FieldName="FECHA_COTIZACION" Name="fieldFECHACOTIZACION" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAEMISION" AreaIndex="0" FieldName="FECHA_EMISION" Name="fieldFECHAEMISION" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAFACTURA" AreaIndex="5" FieldName="FECHA_FACTURA" Name="fieldFECHAFACTURA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAHORA" AreaIndex="0" FieldName="FECHA_HORA" Name="fieldFECHAHORA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAHORACANCELA" AreaIndex="0" FieldName="FECHA_HORA_CANCELA" Name="fieldFECHAHORACANCELA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAHORACIERRE" AreaIndex="0" FieldName="FECHA_HORA_CIERRE" Name="fieldFECHAHORACIERRE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAHORACONFIR" AreaIndex="0" FieldName="FECHA_HORA_CONFIR" Name="fieldFECHAHORACONFIR" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHANOAPRUEBA" AreaIndex="0" FieldName="FECHA_NO_APRUEBA" Name="fieldFECHANOAPRUEBA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAOFRECIDA" AreaIndex="0" FieldName="FECHA_OFRECIDA" Name="fieldFECHAOFRECIDA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAREQEMBARQUE" AreaIndex="0" FieldName="FECHA_REQ_EMBARQUE" Name="fieldFECHAREQEMBARQUE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAREQUERIDA" AreaIndex="0" FieldName="FECHA_REQUERIDA" Name="fieldFECHAREQUERIDA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHARIGE" AreaIndex="0" FieldName="FECHA_RIGE" Name="fieldFECHARIGE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAULTNOTIF" AreaIndex="0" FieldName="FECHA_ULT_NOTIF" Name="fieldFECHAULTNOTIF" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldIMPRESA" AreaIndex="0" FieldName="IMPRESA" Name="fieldIMPRESA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldINSTRUCCIONES" AreaIndex="0" FieldName="INSTRUCCIONES" Name="fieldINSTRUCCIONES" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMODULOORIGEN" AreaIndex="0" FieldName="MODULO_ORIGEN" Name="fieldMODULOORIGEN" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNOTASNOAPROBAR" AreaIndex="0" FieldName="NOTAS_NOAPROBAR" Name="fieldNOTASNOAPROBAR" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNUMFORMULARIO" AreaIndex="0" FieldName="NUM_FORMULARIO" Name="fieldNUMFORMULARIO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldORDENPROGRAMADA" AreaIndex="0" FieldName="ORDEN_PROGRAMADA" Name="fieldORDENPROGRAMADA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPAIS" AreaIndex="6" FieldName="PAIS" Name="fieldPAIS">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPRIORIDAD" AreaIndex="0" FieldName="PRIORIDAD" Name="fieldPRIORIDAD" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRECIBIDODEMAS" AreaIndex="0" FieldName="RECIBIDO_DE_MAS" Name="fieldRECIBIDODEMAS" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldREQUIERECONFIRMA" AreaIndex="0" FieldName="REQUIERE_CONFIRMA" Name="fieldREQUIERECONFIRMA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRESPONSEGUIMIENTO" AreaIndex="0" FieldName="RESPON_SEGUIMIENTO" Name="fieldRESPONSEGUIMIENTO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO1" AreaIndex="0" FieldName="RUBRO1" Name="fieldRUBRO1" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO2" AreaIndex="0" FieldName="RUBRO2" Name="fieldRUBRO2" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO3" AreaIndex="0" FieldName="RUBRO3" Name="fieldRUBRO3" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO4" AreaIndex="0" FieldName="RUBRO4" Name="fieldRUBRO4" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldRUBRO5" AreaIndex="0" FieldName="RUBRO5" Name="fieldRUBRO5" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSUBTIPO" AreaIndex="0" FieldName="SUBTIPO" Name="fieldSUBTIPO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPODESCUENTO" AreaIndex="0" FieldName="TIPO_DESCUENTO" Name="fieldTIPODESCUENTO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUCARTAACEPTACION" AreaIndex="0" FieldName="U_CARTA_ACEPTACION" Name="fieldUCARTAACEPTACION" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUOCEAM" AreaIndex="0" FieldName="U_OCEAM" Name="fieldUOCEAM" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUSUARIO" AreaIndex="7" FieldName="USUARIO" Name="fieldUSUARIO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUSUARIOCANCELA" AreaIndex="0" FieldName="USUARIO_CANCELA" Name="fieldUSUARIOCANCELA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUSUARIOCIERRE" AreaIndex="0" FieldName="USUARIO_CIERRE" Name="fieldUSUARIOCIERRE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUSUARIONOAPRUEBA" AreaIndex="0" FieldName="USUARIO_NO_APRUEBA" Name="fieldUSUARIONOAPRUEBA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPAISCIA" AreaIndex="8" FieldName="PAIS_CIA" Name="fieldPAISCIA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCOMPRADOR" AreaIndex="10" FieldName="COMPRADOR" Name="fieldCOMPRADOR">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldU_CUENTACAPITAL" AreaIndex="8" FieldName="U_CUENTACAPITAL" Name="fieldU_CUENTACAPITAL"> </dx:PivotGridField>
            <dx:PivotGridField ID="fieldU_SUBCUENTACAPITAL1" AreaIndex="8" FieldName="U_SUBCUENTACAPITAL1" Name="fieldU_SUBCUENTACAPITAL1"> </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMONTO_DOLARSIMP" Area="DataArea" AreaIndex="0" FieldName="MONTO_DOLARSIMP" Name="fieldMONTO_DOLARSIMP" Caption="TOTAL DOLAR SIMP" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>

        </Fields>
    </dx:ASPxPivotGrid>

      <dx:ASPxPopupControl ID="ASPxPopupControl1" Modal="true" runat="server" Height="1px"
        AllowDragging="True" ClientInstanceName="DrillDownWindow" Left="200" Top="200"
        CloseAction="CloseButton" Width="153px" HeaderText="Drill Down Window">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridView"
                    OnCustomCallback="ASPxGridView1_CustomCallback">
                    <ClientSideEvents EndCallback="onGridEndCallback" />
                    <Columns>
                        <dx:GridViewDataTextColumn Caption="CIA" FieldName="CIA" VisibleIndex="0" />
                        <dx:GridViewDataTextColumn Caption="ORDEN_COMPRA" FieldName="ORDEN_COMPRA" VisibleIndex="1" />
                        <dx:GridViewDataTextColumn Caption="PROVEEDOR" FieldName="PROVEEDOR" VisibleIndex="2" />
                        <dx:GridViewDataTextColumn Caption="NOMBRE" FieldName="NOMBRE" VisibleIndex="3" />
                        <dx:GridViewDataTextColumn Caption="FECHA" FieldName="FECHA" VisibleIndex="4" />
                        <dx:GridViewDataTextColumn Caption="CENTRO_COSTO" FieldName="CENTRO_COSTO" VisibleIndex="5" />
                        <dx:GridViewDataTextColumn Caption="MONEDA" FieldName="MONEDA" VisibleIndex="6" />
                        <dx:GridViewDataDateColumn Caption="OBSERVACIONES" FieldName="OBSERVACIONES" VisibleIndex="7" />
                        <dx:GridViewDataTextColumn Caption="MONTO_LOCAL" FieldName="MONTO_LOCAL" VisibleIndex="8">
                            <PropertiesTextEdit DisplayFormatString="#,###.00" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="MONTO_DOLAR" FieldName="MONTO_DOLAR" VisibleIndex="9">
                            <PropertiesTextEdit DisplayFormatString="#,###.00" />
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <SettingsLoadingPanel Mode="ShowOnStatusBar" />
                    <Styles>
                        <Header ImageSpacing="5px" SortingImageSpacing="5px" />
                    </Styles>
                </dx:ASPxGridView>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>


             </asp:Content>
