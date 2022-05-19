<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="SolicitudesEAM.aspx.cs" Inherits="UI.Web.SolicitudesEAM" %>
  
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
             //checkListBoxcc.PerformCallback(getSelectedItemsText(selectedItems));
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
         //function synchronizeListBoxValuescc(dropDown, args) {
             //checkListBoxcc.UnselectAll();
         //    var texts = dropDown.GetText().split(textSeparator);
         //    var values = getValuesByTextscc(texts);
             //checkListBoxcc.SelectValues(values);
             //updateTextcc(); // for remove non-existing texts
         //}
         /*function getValuesByTextscc(texts) {
             var actualValues = [];
             var item;
             for (var i = 0; i < texts.length; i++) {
                 item = checkListBoxcc.FindItemByText(texts[i]);
                 if (item != null)
                     actualValues.push(item.value);
             }
             return actualValues;
         } */

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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Solicitudes EAM - SOFTLAND"></asp:Label>
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
                               </dx:ASPxDropDownEdit>    
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
                                <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_Click"  Theme="SoftOrange" Width="32px" ToolTip="Generar información">
                                  <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E1" runat="server" Height="32px" Native="True"  OnClick="ASPxFormLayout1_E3_ClickExc" Theme="SoftOrange" Width="32px" ToolTip="Exportar Excel">
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
    <asp:SqlDataSource ID="SQLCompras" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="[PORTAL].[dbo].[PORTAL_SOLIC_EAM_SOFT]" SelectCommandType="StoredProcedure" OnSelecting="SQLCompras_Selecting">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="01/01/2020" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="02/03/2020" Name="Pfechafin" SessionField="ci_sfec2" />
        </SelectParameters>
    </asp:SqlDataSource>

    <dx:ASPxPivotGridExporter ID="ASPxPivExp1" runat="server" ASPxPivotGridID="PivotCompra">
        <OptionsPrint MergeColumnFieldValues="False" MergeRowFieldValues="False" PrintHorzLines="True" PrintVertLines="False" VerticalContentSplitting="Exact" PrintFilterHeaders="False">
        </OptionsPrint>
    </dx:ASPxPivotGridExporter>

    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM [ME].[erpadmin].[PRIVILEGIO_EX] P, me.erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <dx:ASPxPivotGrid ID="PivotCompra" runat="server" ClientIDMode="AutoID" DataSourceID="SQLCompras" Theme="Office365" ClientInstanceName="PivotCompra">
        <Fields>
            <dx:PivotGridField ID="fieldORGANIZACION" Area="RowArea" AreaIndex="0" FieldName="ORGANIZACION" Name="fieldORGANIZACION">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPAIS_OC" Area="RowArea" AreaIndex="1" FieldName="PAIS_OC" Name="fieldPAIS_OC">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNO_REQUISICION" Area="RowArea" AreaIndex="2" FieldName="NO_REQUISICION" Name="fieldNO_REQUISICION">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHA_REQ" Area="RowArea" AreaIndex="3" FieldName="FECHA_REQ" Name="fieldFECHA_REQ">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHA_APROB_BOD" Area="RowArea" AreaIndex="4" FieldName="FECHA_APROB_BOD" Name="fieldFECHA_APROB_BOD">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESC_ESTADO_REQ" Area="RowArea" AreaIndex="5" FieldName="DESC_ESTADO_REQ" Name="fieldDESC_ESTADO_REQ">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSOLICITANTE" Area="RowArea" AreaIndex="6" FieldName="SOLICITANTE" Name="fieldSOLICITANTE">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNOMBRE_SOLICIT" Area="RowArea" AreaIndex="7" FieldName="NOMBRE_SOLICIT" Name="fieldNOMBRE_SOLICT">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldALMACEN" Area="RowArea" AreaIndex="8" FieldName="ALMACEN" Name="fieldALMACEN">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldLINEA_REQ" Area="RowArea" AreaIndex="9" FieldName="LINEA_REQ" Name="fieldLINEA_REQ">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPIEZA_REQUISICION" Area="RowArea" AreaIndex="10" FieldName="PIEZA_REQUISICION" Name="fieldPIEZA_REQUISICION">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNOMBRE_PIEZA" Area="RowArea" AreaIndex="11" FieldName="NOMBRE_PIEZA" Name="fieldNOMBRE_PIEZA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCANTIDAD" Area="DataArea" AreaIndex="0" FieldName="CANTIDAD" Name="fieldCANTIDAD">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPRECIO_REQ" Area="RowArea" AreaIndex="12" FieldName="PRECIO_REQ" Name="fieldPRECIO_REQ">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUOM_REQ" Area="RowArea" AreaIndex="13" FieldName="UOM_REQ" Name="fieldUOM_REQ">
            </dx:PivotGridField>

            <dx:PivotGridField ID="fieldPRECIOUNITARIO" Area="FilterArea" AreaIndex="0" FieldName="PRECIO_UNITARIO" Name="fieldPRECIOUNITARIO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPRECIOUNITARIOLOCAL" Area="FilterArea" AreaIndex="1" FieldName="PRECIO_UNITARIO_LOCAL" Name="fieldPRECIOUNITARIOLOCAL">
            </dx:PivotGridField>

        </Fields>
    </dx:ASPxPivotGrid>

      <dx:ASPxPopupControl ID="ASPxPopupControl1" Modal="true" runat="server" Height="1px"
        AllowDragging="True" ClientInstanceName="DrillDownWindow" Left="200" Top="200"
        CloseAction="CloseButton" Width="153px" HeaderText="Drill Down Window">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridView" OnCustomCallback="ASPxGridView1_CustomCallback">
                    <ClientSideEvents EndCallback="onGridEndCallback" />
                    <Columns>
                        <dx:GridViewDataTextColumn Caption="ORGANIZACION" FieldName="ORGANIZACION" VisibleIndex="0" />
                        <dx:GridViewDataTextColumn Caption="PAIS_OC" FieldName="PAIS_OC" VisibleIndex="1" />
                        <dx:GridViewDataTextColumn Caption="NO_REQUISICION" FieldName="NO_REQUISICION" VisibleIndex="2" />
                        <dx:GridViewDataTextColumn Caption="FECHA_REQ" FieldName="FECHA_REQ" VisibleIndex="3" />
                        <dx:GridViewDataTextColumn Caption="FECHA_APROB_BOD" FieldName="FECHA_APROB_BOD" VisibleIndex="4" />
                        <dx:GridViewDataTextColumn Caption="DESC_ESTADO_REQ" FieldName="DESC_ESTADO_REQ" VisibleIndex="5" />
                        <dx:GridViewDataTextColumn Caption="SOLICITANTE" FieldName="SOLICITANTE" VisibleIndex="6" />
                        <dx:GridViewDataDateColumn Caption="NOMBRE_SOLICIT" FieldName="NOMBRE_SOLICIT" VisibleIndex="7" />
                        <dx:GridViewDataDateColumn Caption="ALMACEN" FieldName="ALMACEN" VisibleIndex="8" />
                        <dx:GridViewDataDateColumn Caption="LINEA_REQ" FieldName="LINEA_REQ" VisibleIndex="9" />
                        <dx:GridViewDataDateColumn Caption="PIEZA_REQUISICION" FieldName="PIEZA_REQUISICION" VisibleIndex="10" />
                        <dx:GridViewDataDateColumn Caption="NOMBRE_PIEZA" FieldName="NOMBRE_PIEZA" VisibleIndex="11" />
                        <dx:GridViewDataDateColumn Caption="CANTIDAD" FieldName="CANTIDAD" VisibleIndex="12" />
                        <dx:GridViewDataTextColumn Caption="PRECIO_REQ" FieldName="PRECIO_REQ" VisibleIndex="13">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn Caption="UOM_REQ" FieldName="UOM_REQ" VisibleIndex="14" />
                        <dx:GridViewDataDateColumn Caption="ORL_ORDER" FieldName="UOM_REQ" VisibleIndex="15" />
                        <dx:GridViewDataDateColumn Caption="CUENTA_CONTABLE" FieldName="CUENTA_CONTABLE" VisibleIndex="16" />
                        <dx:GridViewDataDateColumn Caption="DESCRIPCION_CTA_CONTABLE" FieldName="DESCRIPCION_CTA_CONTABLE" VisibleIndex="17" />
                        <dx:GridViewDataDateColumn Caption="CENTRO_COSTO" FieldName="CENTRO_COSTO" VisibleIndex="18" />
                        <dx:GridViewDataDateColumn Caption="DESCRIPCION_CENTRO_COSTO" FieldName="DESCRIPCION_CENTRO_COSTO" VisibleIndex="19" />
                        <dx:GridViewDataDateColumn Caption="ORDEN_COMPRA" FieldName="ORDEN_COMPRA" VisibleIndex="20" />
                        <dx:GridViewDataDateColumn Caption="PAIS_OC_EXAC" FieldName="PAIS_OC_EXAC" VisibleIndex="21" />
                        <dx:GridViewDataDateColumn Caption="ORDEN_COMPRA_EAM" FieldName="ORDEN_COMPRA_EAM" VisibleIndex="22" />
                        <dx:GridViewDataDateColumn Caption="ESTADO_OC_EXACTUS" FieldName="ESTADO_OC_EXACTUS" VisibleIndex="23" />
                        <dx:GridViewDataDateColumn Caption="PROVEEDOR" FieldName="PROVEEDOR" VisibleIndex="24" />
                        <dx:GridViewDataDateColumn Caption="NOMBRE_PROVEEDOR" FieldName="NOMBRE_PROVEEDOR" VisibleIndex="25" />
                        <dx:GridViewDataDateColumn Caption="DEPARTAMENTO" FieldName="DEPARTAMENTO" VisibleIndex="26" />
                        <dx:GridViewDataDateColumn Caption="CONDICION_PAGO" FieldName="CONDICION_PAGO" VisibleIndex="27" />
                        <dx:GridViewDataDateColumn Caption="FECHA_ORDEN" FieldName="FECHA_ORDEN" VisibleIndex="28" />
                        <dx:GridViewDataDateColumn Caption="FECHA_REQUERIDA" FieldName="FECHA_REQUERIDA" VisibleIndex="29" />
                        <dx:GridViewDataDateColumn Caption="FECHA_INGRESO" FieldName="FECHA_INGRESO" VisibleIndex="30" />
                        <dx:GridViewDataDateColumn Caption="LINEA_OC" FieldName="LINEA_OC" VisibleIndex="31" />
                        <dx:GridViewDataDateColumn Caption="CANTIDAD_ORDENADA" FieldName="CANTIDAD_ORDENADA" VisibleIndex="32" />
                        <dx:GridViewDataDateColumn Caption="UNIDAD_MEDIDA" FieldName="UNIDAD_MEDIDA" VisibleIndex="33" />
                        <dx:GridViewDataTextColumn Caption="PRECIO_UNIT_INICIAL" FieldName="PRECIO_UNIT_INICIAL" VisibleIndex="34">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="PRECIO_UNIT_DSCTO" FieldName="PRECIO_UNIT_DSCTO" VisibleIndex="35">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn Caption="CANTIDAD_RECIBIDA" FieldName="CANTIDAD_RECIBIDA" VisibleIndex="36" />
                        <dx:GridViewDataDateColumn Caption="MONEDA" FieldName="MONEDA" VisibleIndex="37" />
                        <dx:GridViewDataDateColumn Caption="OBSERVACIONES" FieldName="OBSERVACIONES" VisibleIndex="38" />
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
