<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Comprasv2.aspx.cs" Inherits="UI.Web.Comprasv2" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Aprobación Ordenes de Compras"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="900px">
        <Items>
            <dx:LayoutGroup ColCount="8" ColSpan="1" ColumnCount="8" Caption="Defina Parametros" RowSpan="2">
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
    <dx:LayoutItem Caption="Seleccione departamento"  ColSpan="1" Name="centrocosto" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                               <dx:ASPxDropDownEdit ClientInstanceName="checkComboBoxcc" ID="ASPxDropDownEdit2cc" Width="285px" runat="server" AnimationType="None" Theme="SoftOrange">
                                   <DropDownWindowStyle BackColor="#EDEDED" />
                                       <DropDownWindowTemplate>
                                       <dx:ASPxListBox Width="100%" ID="listBoxcc" ClientInstanceName="checkListBoxcc" SelectionMode="CheckColumn" OnCallback="Cmbcentrocosto_Callback"
                                           runat="server" Height="200" EnableSelectAll="true" DataSourceID="SQLDepartamento" TextField="DESC_DEPARTAMENTO" ValueField="DEPARTAMENTO">
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
    <asp:SqlDataSource ID="SQLCompras" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].PORTAL_COMPRASV2b" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="01/01/2020" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="02/03/2020" Name="Pfechafin" SessionField="ci_sfec2" />
            <asp:SessionParameter DefaultValue="A"  Name="Pestado_orden"  SessionField="ci_stipo"/>
            <asp:SessionParameter DefaultValue="CROMSA-TI Tecnologia Informacion;CROMSA-TI1 Tecnologia de Informacion" Name="PDepartamento" SessionField="cov2_departamento" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="System.Data.SqlClient" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM [erpadmin].[PRIVILEGIO_EX] P, erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep
" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLDepartamento" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_DEPARTAMENTO_USUARIO]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="CROMSA XXXXXXX" Name="PCia1" SessionField="CIAS_OC_PRES" Type="String" />
            <asp:SessionParameter DefaultValue="JMZ" Name="PUSUARIO" SessionField="nombreUsuario" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLDepartamento2" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="System.Data.SqlClient" SelectCommand="select CIA+'-'+DEPARTAMENTO DEPARTAMENTO, CIA+'-'+DEPARTAMENTO + ' ' + DESC_DEPARTAMENTO DESC_DEPARTAMENTO
  FROM [PORTAL].[dbo].[Deptm]">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="CROMSA XXXXXXX" Name="PCia1" SessionField="CIAS_OC_PRES" Size="200" Type="String" />
            <asp:SessionParameter DefaultValue="JMZ" Name="PUSUARIO" SessionField="nombreUsuario" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
        <dx:ASPxGridView ID="GridCompras" ClientInstanceName="MasterGrid"  runat="server" AutoGenerateColumns="False" DataSourceID="SQLCompras" KeyFieldName="ORDEN_COMPRAKEY">
                    <ClientSideEvents CustomButtonClick="function(s, e) {  visibleIndex = MasterGrid.GetRowKey(e.visibleIndex);  if (e.buttonID == 'btdet1') {Popup.PerformCallback(visibleIndex); Popup.Show(); }  
          if (e.buttonID == 'btdet2') {Popup2.PerformCallback(visibleIndex); Popup2.Show(); }  }" />
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
           <dx:GridViewCommandColumn ButtonRenderMode="Image" ButtonType="Image" VisibleIndex="0">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btdet1" Text ="Detalle Cia1">
                        <Image IconID="richedit_editrangepermission_svg_16x16">
                        </Image>
                    </dx:GridViewCommandColumnCustomButton>
                </CustomButtons>
            </dx:GridViewCommandColumn>

                <dx:GridViewDataTextColumn FieldName="CIA" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ORDEN_COMPRA" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="USUARIO" VisibleIndex="21" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PROVEEDOR" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NOMBRE" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="BODEGA" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CONDICION_PAGO" VisibleIndex="22" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONEDA" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RESPON_SEGUIMIENTO" VisibleIndex="23" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MODULO_ORIGEN" VisibleIndex="24" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FECHA" VisibleIndex="10">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="FECHA_COTIZACION" VisibleIndex="25" Visible="False">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="FECHA_OFRECIDA" VisibleIndex="26" Visible="False">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="FECHA_EMISION" VisibleIndex="27" Visible="False">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="FECHA_REQ_EMBARQUE" VisibleIndex="28" Visible="False">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="FECHA_REQUERIDA" VisibleIndex="29" Visible="False">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="DIRECCION_EMBARQUE" VisibleIndex="30" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DIRECCION_COBRO" VisibleIndex="31" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TIPO_DESCUENTO" VisibleIndex="32" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PORC_DESCUENTO" VisibleIndex="33" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONTO_DESCUENTO" VisibleIndex="34" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TOTAL_MERCADERIA" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TOTAL_IMPUESTO1" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TOTAL_IMPUESTO2" VisibleIndex="35" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONTO_FLETE" VisibleIndex="36" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONTO_SEGURO" VisibleIndex="37" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONTO_DOCUMENTACIO" VisibleIndex="38" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONTO_ANTICIPO" VisibleIndex="39" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TOTAL_A_COMPRAR" ReadOnly="True" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RUBRO1" VisibleIndex="40" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RUBRO2" VisibleIndex="41" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RUBRO3" VisibleIndex="42" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RUBRO4" VisibleIndex="43" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RUBRO5" VisibleIndex="44" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PRIORIDAD" VisibleIndex="45" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IMPRESA" VisibleIndex="46" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NUM_FORMULARIO" VisibleIndex="47" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="INSTRUCCIONES" VisibleIndex="48" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="COMENTARIO_CXP" VisibleIndex="18">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FECHA_HORA" VisibleIndex="49" Visible="False">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="OBSERVACIONES" VisibleIndex="19">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="REQUIERE_CONFIRMA" VisibleIndex="50" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CONFIRMADA" VisibleIndex="51" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="USUARIO_CONFIRMA" VisibleIndex="52" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FECHA_HORA_CONFIR" VisibleIndex="53" Visible="False">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="USUARIO_CIERRE" VisibleIndex="54" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FECHA_HORA_CIERRE" VisibleIndex="55" Visible="False">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ASIENTO_CIERRE" VisibleIndex="56" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ORDEN_PROGRAMADA" VisibleIndex="57" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RECIBIDO_DE_MAS" VisibleIndex="58" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FECHA_HORA_CANCELA" VisibleIndex="59" Visible="False">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="USUARIO_CANCELA" VisibleIndex="60" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TIPO_PRORRATEO_OC" VisibleIndex="61" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PRESUPUESTO_CR" VisibleIndex="15">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="COD_DIREC_EMB" VisibleIndex="62" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NOTAS_NOAPROBAR" VisibleIndex="20">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="FACTURA" VisibleIndex="63" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FECHA_FACTURA" VisibleIndex="64" Visible="False">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="SUBTIPO" VisibleIndex="65" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FECHA_RIGE" VisibleIndex="66" Visible="False">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="APLICACION" VisibleIndex="67" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONTO_FACTURA" VisibleIndex="68" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DEPARTAMENTO" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FECHA_ULT_NOTIF" VisibleIndex="69" Visible="False">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="BASE_IMPUESTO1" VisibleIndex="70" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="BASE_IMPUESTO2" VisibleIndex="71" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TOT_IMP1_ASUM_DESC" VisibleIndex="72" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TOT_IMP1_ASUM_NODESC" VisibleIndex="73" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TOT_IMP1_RETE_DESC" VisibleIndex="74" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TOT_IMP1_RETE_NODESC" VisibleIndex="75" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FECHA_NO_APRUEBA" VisibleIndex="76" Visible="False">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="USUARIO_NO_APRUEBA" VisibleIndex="77" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="U_OCEAM" VisibleIndex="16">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="U_CARTA_ACEPTACION" VisibleIndex="17">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TOTAL_CAMBIO" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ESTADO" VisibleIndex="78" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ESTADO_DESC" ReadOnly="True" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PAIS_CIA" VisibleIndex="79" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ORDEN_COMPRAKEY" VisibleIndex="80" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PAIS" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <br />
        <br />
        <br />
        <br />
        <dx:ASPxPopupControl ID="Popup" runat="server" AllowDragging="True" ClientInstanceName="Popup" CloseAction="OuterMouseClick" HeaderText="Orden de Compra" Modal="true" OnWindowCallback="Popup_WindowCallback" PopupAction="None" PopupElementID="MasterGrid" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="false">
            <ContentCollection>
                <dx:PopupControlContentControl runat="server">

                    <table style="width: 100%;">
                        <tr>
                            <td><dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" ColCount="4" ColumnCount="4" DataSourceID="SQL_Data_CTA_Detalle1" AlignItemCaptionsInAllGroups="True" RightToLeft="False" EnableTheming="True" Theme="SoftOrange" Width="850px">
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit">
                        </SettingsAdaptivity>
                        <Items>
                            <dx:LayoutGroup Caption="Orden de Compra" ColCount="4" ColSpan="4" ColumnCount="4" ColumnSpan="4" GroupBoxDecoration="HeadingLine" Width="100%">
                                <Items>
                                    <dx:LayoutItem ColSpan="1" FieldName="CIA">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E11" runat="server" Width="170px">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="ORDEN_COMPRA">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E12" runat="server" Width="170px" Font-Bold="True">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="FECHA">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxDateEdit ID="ASPxFormLayout1_E22" runat="server">
                                                </dx:ASPxDateEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutGroup Caption=" " ColCount="3" ColSpan="1" ColumnCount="3" GroupBoxDecoration="HeadingLine" UseDefaultPaddings="True" Width="185px">
                                        <Items>
                                            <dx:LayoutItem Caption="" ColSpan="1" Name="Por Aprobar" Width="16px" HorizontalAlign ="Left">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton ID="ASPxFormLayout1_E2" runat="server" ToolTip="Por Aprobar Orden" AutoPostBack="False" >
                                                            <ClientSideEvents Click="function(s, e) {
	PDialogo.Show();
}" />
                                                            <Image Url="~/Imagenes/BONote_16x16.png">
                                                            </Image>
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem Caption="" ColSpan="1" Name="Aprobar" Width="16px"  HorizontalAlign ="Left">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton ID="ASPxFormLayout1_E4" runat="server" ToolTip="Aprobar Orden" AutoPostBack="False" >
                                                            <ClientSideEvents Click="function(s, e) {
	PDialogo2.Show();
	
}" />
                                                            <Image Url="~/Imagenes/BOUser_16x16.png">
                                                            </Image>
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem Caption="" ColSpan="1" Name="Reversar" Width="16px"  HorizontalAlign ="Left">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton ID="ASPxFormLayout1_E1" runat="server" ToolTip="Reversar Orden de Compra" AutoPostBack="False" >
                                                            <ClientSideEvents Click="function(s, e) {
		PDialogo3.Show();
}" />
                                                            <Image Url="~/Imagenes/Close_16x16.png">
                                                            </Image>
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                        </Items>
                                    </dx:LayoutGroup>
                                    <dx:LayoutItem ColSpan="1" FieldName="PROVEEDOR">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E14" runat="server" Width="170px">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="NOMBRE">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E15" runat="server" Width="170px" Font-Bold="True">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="CONDICION_PAGO">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E17" runat="server" Width="70px">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="MONEDA">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E18" runat="server" Width="100px" Font-Bold="True">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="PAIS">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E19" runat="server" Width="170px">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="RESPON_SEGUIMIENTO">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E20" runat="server" Width="170px">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="FECHA_COTIZACION">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxDateEdit ID="ASPxFormLayout1_E23" runat="server">
                                                </dx:ASPxDateEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="FECHA_OFRECIDA">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxDateEdit ID="ASPxFormLayout1_E24" runat="server">
                                                </dx:ASPxDateEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="FECHA_EMISION">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxDateEdit ID="ASPxFormLayout1_E25" runat="server">
                                                </dx:ASPxDateEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="FECHA_REQ_EMBARQUE">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxDateEdit ID="ASPxFormLayout1_E26" runat="server">
                                                </dx:ASPxDateEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="FECHA_REQUERIDA">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxDateEdit ID="ASPxFormLayout1_E27" runat="server">
                                                </dx:ASPxDateEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="DIRECCION_EMBARQUE">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E28" runat="server" Width="170px">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="DIRECCION_COBRO">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E29" runat="server" Width="170px">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="TOTAL_MERCADERIA">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxSpinEdit ID="ASPxFormLayout1_E33" runat="server" Number="0" DecimalPlaces="2" DisplayFormatString="#,###.00" HorizontalAlign="Right">
                                                </dx:ASPxSpinEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="TOTAL_A_COMPRAR">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxSpinEdit ID="ASPxFormLayout1_E40" runat="server" Number="0" DisplayFormatString="#,###.00" HorizontalAlign="Right">
                                                </dx:ASPxSpinEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="ESTADO">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E47" runat="server" Width="170px">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="2" ColumnSpan="2" FieldName="COMENTARIO_CXP">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E51b" runat="server" Height="16px" Width="350px">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="2" ColumnSpan="2" FieldName="OBSERVACIONES">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E53" runat="server" Height="19px" Width="350px">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="PRESUPUESTO_CR">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E66" runat="server" Width="170px" Font-Bold="True">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="U_OCEAM">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E85" runat="server" Width="170px">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" FieldName="U_CARTA_ACEPTACION">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E86" runat="server" Width="170px">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ColSpan="1" Caption="ESTADO DESC" FieldName="ESTADO_DESC">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="ASPxFormLayout1_E5" runat="server" Width="140px"  Font-Bold="True" ForeColor="Red" Font-Size="12pt" Height="21px">
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                </Items>
                                <SettingsItemCaptions Location="Top" />
                            </dx:LayoutGroup>
                        </Items>
                        <SettingsItemCaptions Location="Left" />
                    </dx:ASPxFormLayout></td>
                            <td>    <dx:ASPxFileManager ID="ASPxFileManager1" runat="server" DataSourceID="SQL_Data_OC_Doc_Adjuntos" Height="380px" Width="200px" OnFileDownloading="ASPxFileManager1_FileDownloading">
        <SettingsDataSource />
        <Settings ThumbnailFolder="~\Thumb\" />
          <SettingsFileList PageSize="100">
          </SettingsFileList>
        <SettingsEditing AllowDownload="True" />
          <SettingsFolders ShowExpandButtons="False" Visible="False" />
          <SettingsToolbar ShowFilterBox="False" ShowPath="False">
          </SettingsToolbar>
        <SettingsUpload Enabled="False">
        </SettingsUpload>
        <SettingsDataSource KeyFieldName="CONSECUTIVO" ParentKeyFieldName="PARENT_ID" NameFieldName="NOMBRE"
            IsFolderFieldName="ISFOLDER" FileBinaryContentFieldName="CONTENIDO"   LastWriteTimeFieldName="FECHA_CREACION"/>
    </dx:ASPxFileManager> </td>
                        </tr>
                    </table>
                  <dx:ASPxLabel ID="Pmensaje" runat="server" Font-Bold="True" Font-Size="12pt" ForeColor="Red">
                </dx:ASPxLabel>

                     
                    
                    
                    
                

                    

    <br />
                    <div>
                        <br />

                     </div>
                    <div>
                        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SQL_Data_OC_Linea" KeyFieldName="ORDEN_COMPRA" Width="1068px">
                            <SettingsPager Mode="ShowAllRecords">
                            </SettingsPager>
                            <Settings VerticalScrollBarMode="Visible" />

<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="ORDEN_COMPRA" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0" Visible="False" Caption="Orden">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ORDEN_COMPRA_LINEA" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="1" Caption="Linea">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ARTICULO" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Articulo">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="BODEGA" ShowInCustomizationForm="True" VisibleIndex="2" Caption="Bod">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="LINEA_USUARIO" ShowInCustomizationForm="True" VisibleIndex="3" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="DESCRIPCION" ShowInCustomizationForm="True" VisibleIndex="5" Caption="Descripción" Width="140px">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CANTIDAD_ORDENADA" ShowInCustomizationForm="True" VisibleIndex="6" Caption="Cant">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CANTIDAD_EMBARCADA" ShowInCustomizationForm="True" VisibleIndex="12" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CANTIDAD_RECIBIDA" ShowInCustomizationForm="True" VisibleIndex="13" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CANTIDAD_RECHAZADA" ShowInCustomizationForm="True" VisibleIndex="14" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PRECIO_UNITARIO" ShowInCustomizationForm="True" VisibleIndex="15" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="IMPUESTO1" ShowInCustomizationForm="True" VisibleIndex="16" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="IMPUESTO2" ShowInCustomizationForm="True" VisibleIndex="17" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TIPO_DESCUENTO" ShowInCustomizationForm="True" VisibleIndex="18" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PORC_DESCUENTO" ShowInCustomizationForm="True" VisibleIndex="19" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="MONTO_DESCUENTO" ShowInCustomizationForm="True" VisibleIndex="20" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="FECHA" ShowInCustomizationForm="True" VisibleIndex="21" Visible="False">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="ESTADO" ShowInCustomizationForm="True" VisibleIndex="22" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="COMENTARIO" ShowInCustomizationForm="True" VisibleIndex="23" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="FACTOR_CONVERSION" ShowInCustomizationForm="True" VisibleIndex="24" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="FECHA_REQUERIDA" ShowInCustomizationForm="True" VisibleIndex="25" Visible="False">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataDateColumn FieldName="FEC_EMBARQUE_PROV" ShowInCustomizationForm="True" VisibleIndex="26" Visible="False">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="DIAS_PARA_ENTREGA" ShowInCustomizationForm="True" VisibleIndex="27" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="FACTURA" ShowInCustomizationForm="True" VisibleIndex="28" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="UNIDAD_DISTRIBUCIO" ShowInCustomizationForm="True" VisibleIndex="29" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="USUARIO_CANCELA" ShowInCustomizationForm="True" VisibleIndex="30" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="FECHA_HORA_CANCELA" ShowInCustomizationForm="True" VisibleIndex="31" Visible="False">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataDateColumn FieldName="FECHA_HORA_CIERRE" ShowInCustomizationForm="True" VisibleIndex="32" Visible="False">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="USUARIO_CIERRE" ShowInCustomizationForm="True" VisibleIndex="33" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CENTRO_COSTO" ShowInCustomizationForm="True" VisibleIndex="8" Caption="Centro Costo">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CUENTA_CONTABLE" ShowInCustomizationForm="True" VisibleIndex="10" Caption="Cuenta Contable d">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="E_MAIL" ShowInCustomizationForm="True" VisibleIndex="34" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CANTIDAD_ACEPTADA" ShowInCustomizationForm="True" VisibleIndex="35" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="LOCALIZACION" ShowInCustomizationForm="True" VisibleIndex="36" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="LOTE" ShowInCustomizationForm="True" VisibleIndex="37" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="IMP2_POR_CANTIDAD" ShowInCustomizationForm="True" VisibleIndex="38" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="FASE" ShowInCustomizationForm="True" VisibleIndex="39" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PROYECTO" ShowInCustomizationForm="True" VisibleIndex="40" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SERIE_CADENA" ShowInCustomizationForm="True" VisibleIndex="41" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="IMP1_AFECTA_COSTO" ShowInCustomizationForm="True" VisibleIndex="42" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="IMP1_ASUMIDO_DESC" ShowInCustomizationForm="True" VisibleIndex="43" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="IMP1_ASUMIDO_NODESC" ShowInCustomizationForm="True" VisibleIndex="44" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="IMP1_RETENIDO_DESC" ShowInCustomizationForm="True" VisibleIndex="45" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="IMP1_RETENIDO_NODESC" ShowInCustomizationForm="True" VisibleIndex="46" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ORDEN_CAMBIO" ShowInCustomizationForm="True" VisibleIndex="47" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CONCEPTO_ME" ShowInCustomizationForm="True" VisibleIndex="48" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="RowPointer" ShowInCustomizationForm="True" VisibleIndex="49" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="NoteExistsFlag" ShowInCustomizationForm="True" VisibleIndex="50" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="RecordDate" ShowInCustomizationForm="True" VisibleIndex="51" Visible="False">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="CreatedBy" ShowInCustomizationForm="True" VisibleIndex="52" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="UpdatedBy" ShowInCustomizationForm="True" VisibleIndex="53" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="CreateDate" ShowInCustomizationForm="True" VisibleIndex="54" Visible="False">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="PRECIO_ART_PROV" ShowInCustomizationForm="True" VisibleIndex="55" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="MONTO_APLICADO" ShowInCustomizationForm="True" VisibleIndex="56" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TIPO_IMPUESTO1" ShowInCustomizationForm="True" VisibleIndex="57" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TIPO_TARIFA1" ShowInCustomizationForm="True" VisibleIndex="58" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TIPO_IMPUESTO2" ShowInCustomizationForm="True" VisibleIndex="59" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TIPO_TARIFA2" ShowInCustomizationForm="True" VisibleIndex="60" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PORC_EXONERACION" ShowInCustomizationForm="True" VisibleIndex="61" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="MONTO_EXONERACION" ShowInCustomizationForm="True" VisibleIndex="62" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ES_CANASTA_BASICA" ShowInCustomizationForm="True" VisibleIndex="63" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="MontoTotalImpuestoAcreditar" ShowInCustomizationForm="True" VisibleIndex="64" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="MontoTotalDeGastoAplicable" ShowInCustomizationForm="True" VisibleIndex="65" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="MontoProporcionalidad" ShowInCustomizationForm="True" VisibleIndex="66" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SUBTOTAL_BIENES" ShowInCustomizationForm="True" VisibleIndex="67" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SUBTOTAL_SERVICIOS" ShowInCustomizationForm="True" VisibleIndex="68" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Desc Centro Costo" FieldName="DESC_CENTRO_COSTO" ShowInCustomizationForm="True" VisibleIndex="9">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Desc Cuenta Contable" FieldName="DESC_CUENTA_CONTABLE" ShowInCustomizationForm="True" VisibleIndex="11">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Total" FieldName="IMPORTE_TOTAL" ShowInCustomizationForm="True" VisibleIndex="7" PropertiesTextEdit-DisplayFormatString ="#,###.00">
<PropertiesTextEdit DisplayFormatString="#,###.00"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                            </Columns>
                        </dx:ASPxGridView>
                    </div>
                    <div>
                        <asp:SqlDataSource ID="SQL_Data_CTA_Detalle1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_COMPRASV2_Detalle]" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="cov2_cia" Type="String" />
                                <asp:SessionParameter DefaultValue="OC009176" Name="POrden_Compra" SessionField="cov2_orden_compra" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <dx:ASPxPivotGridExporter ID="ASPxPivotGridExp1" runat="server" ASPxPivotGridID="PivotDetalleCta1">
                        </dx:ASPxPivotGridExporter>
                        <asp:SqlDataSource ID="SQL_Data_OC_Linea" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_COMPRASV2_Detalle_linea]" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="cov2_cia" Type="String" />
                                <asp:Parameter DefaultValue="OC009242" Name="POrden_Compra" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SQL_Data_OC_Doc_Adjuntos" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_DOCUMENTOS_ADJUNTOS_OC]" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="cov2_cia" Type="String" />
                                <asp:SessionParameter DefaultValue="OC009279" Name="PORDEN_COMPRA" SessionField="cov2_orden_compra" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        <br />
                        <br />
                        <br />
                    </div>
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="PDialogo" runat="server" Height="130px" Width="363px" HeaderText="Confirmación"  ClientInstanceName="PDialogo" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
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
                <dx:ASPxLabel ID="LabelMensaje" runat="server" Font-Bold="True" Text="Esta seguro que desea pasar a por aprobar la Orden de compra?" style="margin-left: 7px" Width="300px">
                    <DisabledStyle Font-Bold="True">
                    </DisabledStyle>
                </dx:ASPxLabel>
            </td>
            <td class="auto-style3">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8">&nbsp;</td>
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
                <dx:ASPxButton ID="BTAceptar" runat="server" OnClick="BTAceptar_Click" Text="Aceptar" Width="80px">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo.Hide();
}" />
                    <Image IconID="businessobjects_bo_validation_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="BTCancelar" runat="server" Text="Cancelar">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo.Hide();
}" />
                    <Image Width="80px" IconID="iconbuilder_actions_delete_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
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


    <dx:ASPxPopupControl ID="PDialogo2" runat="server" Height="130px" Width="363px" HeaderText="Confirmación"  ClientInstanceName="PDialogo2" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
                    <SettingsAdaptivity VerticalAlign="WindowCenter" />
                    <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <table style="width:100%;">
        <tr>
            <td class="auto-style10">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10"></td>
            <td class="auto-style3" colspan="3">
                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Font-Bold="True" Text="Esta seguro que desea aprobar la orden de compra?" style="margin-left: 7px" Width="300px">
                    <DisabledStyle Font-Bold="True">
                    </DisabledStyle>
                </dx:ASPxLabel>
            </td>
            <td class="auto-style3">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10"></td>
            <td class="auto-style3">&nbsp;
                <br />
                &nbsp;</td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
        </tr>
        <tr>
            <td class="auto-style11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Aceptar" Width="80px" OnClick="ASPxButton2_Click1">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo2.Hide();
}" />
                    <Image IconID="businessobjects_bo_validation_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Cancelar">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo2.Hide();
}" />
                    <Image Width="80px" IconID="iconbuilder_actions_delete_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
        </tr>
        <tr>
            <td class="auto-style10">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
                        </dx:PopupControlContentControl>
</ContentCollection>
                </dx:ASPxPopupControl>


        <dx:ASPxPopupControl ID="ASPxPopupControl3" runat="server" Height="130px" Width="363px" HeaderText="Confirmación"  ClientInstanceName="PDialogo3" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
                    <SettingsAdaptivity VerticalAlign="WindowCenter" />
                    <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <table style="width:100%;">
        <tr>
            <td class="auto-style10">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10"></td>
            <td class="auto-style3" colspan="3">
                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Font-Bold="True" Text="Esta seguro de reversar la orden de compra?" style="margin-left: 7px" Width="300px">
                    <DisabledStyle Font-Bold="True">
                    </DisabledStyle>
                </dx:ASPxLabel>
            </td>
            <td class="auto-style3">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10"></td>
            <td class="auto-style3">&nbsp;
                <br />
                &nbsp;</td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
        </tr>
        <tr>
            <td class="auto-style11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="ASPxButton4" runat="server" Text="Aceptar" Width="80px" OnClick="ASPxButton4_Click">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo3.Hide();
}" />
                    <Image IconID="businessobjects_bo_validation_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="ASPxButton5" runat="server" Text="Cancelar">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo3.Hide();
}" />
                    <Image Width="80px" IconID="iconbuilder_actions_delete_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
        </tr>
        <tr>
            <td class="auto-style10">&nbsp;</td>
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
