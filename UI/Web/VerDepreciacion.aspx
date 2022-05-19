<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="VerDepreciacion.aspx.cs" Inherits="UI.Web.VerDepreciacion" %>

<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
  
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
  
  
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="Detalle Depreciación - Contrato NIFF"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="1124px" style="margin-top: 0px">
        <Items>
            <dx:LayoutGroup ColCount="10" ColSpan="1" ColumnCount="10" Caption="Detalle Contrato" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Nombre contrato" ColSpan="1" Name="LiNombreContrato" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="txtNombreContrato" runat="server" NullText="Nombre Contrato" Width="250px" CssClass="maxWidth" MaxLength="250">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="País" ColSpan="1" Name="LiPais" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="txtPais" runat="server" NullText="País" Width="250px" CssClass="maxWidth" MaxLength="100">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Entidad" ColSpan="1" Name="LiEntidad" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="txtEntidad" runat="server" NullText="Entidad" Width="250px" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Cuota Arrendamiento" ColSpan="1"  Name="LiCuotaArrendamiento" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxSpinEdit ID="txtCuotaMensual" runat="server" Number="00.00" DecimalPlaces="2" DisplayFormatString="{0:C}" Width="100%" CssClass="maxWidth" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E3" runat="server" Height="32px" Width="32px" AutoPostBack="False">
                                    <ClientSideEvents Click="function(s, e) {
	                                        PDialogo.Show();
                                        }" />
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/SaveAll_32x32.png" Repeat="NoRepeat" VerticalPosition="center" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/SaveAll_32x32.png">
                        </TabImage>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E1" runat="server" Height="32px" Native="True" Theme="SoftOrange" Width="32px" ToolTip="Exportar Excel" OnClick="Lform_E1_Click">
                                   <BackgroundImage ImageUrl="~/Imagenes/Excel.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="" ColSpan="1" Name="Salir">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnCancelar" runat="server" Height="32px" Width="32px" AutoPostBack="False"  EnableClientSideAPI="True">
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/Menu/Cerrar_Sesion_Hover.png" Repeat="NoRepeat" VerticalPosition="center" />
                                    <ClientSideEvents Click="function(s,e){ document.location.href='ContratoNIFF.aspx'; }" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:EmptyLayoutItem ColSpan="1">
                    </dx:EmptyLayoutItem>
                    <dx:EmptyLayoutItem ColSpan="1">
                    </dx:EmptyLayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

    <br />

    <asp:SqlDataSource ID="DS_Depreciacion_Contrato" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=PORTAL;Persist Security Info=True;User ID=sa
;Password=SAsoftladbqa$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_DEPRECIACION_CONTRATO]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="0" Name="CONTRATO_ID" SessionField="ContratoDepreciacion" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" GridViewID="grid_data">
    </dx:ASPxGridViewExporter>

    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM [ME].[erpadmin].[PRIVILEGIO_EX] P, me.erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>


    <dx:ASPxGridView ID="grid_data"  ClientInstanceName="grid" runat="server" Width="1324px" AutoGenerateColumns="False" DataSourceID="DS_Depreciacion_Contrato" Theme="SoftOrange" KeyFieldName="ID" EnableRowsCache="False" >
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="ANIO" VisibleIndex="1" ShowInCustomizationForm="True" Caption="Año">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MES" VisibleIndex="2" ShowInCustomizationForm="True" Caption="Mes">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NRO_CUOTA" VisibleIndex="3" ShowInCustomizationForm="True" Caption="Número Cuota">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CUOTA_ANUAL" VisibleIndex="4" ShowInCustomizationForm="True" Caption="Cuota Anual">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VALOR_PRESENTE" VisibleIndex="5" ShowInCustomizationForm="True" Caption="Valor Presente">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ESTADO_DESCRIPCION" VisibleIndex="6" ShowInCustomizationForm="True" Caption="Estado">
            </dx:GridViewDataTextColumn>
            <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="7" ShowClearFilterButton="True">
                <HeaderStyle HorizontalAlign="Center">
                    <Paddings PaddingBottom="1px" PaddingTop="1px" />
                </HeaderStyle>
                <HeaderTemplate>
                 	<input type="checkbox" onclick="grid.SelectAllRowsOnPage(this.checked);" style="vertical-align:middle;" title="Seleccione/Deseleccione todas las filas de la pagina"></input>
                </HeaderTemplate>
            </dx:GridViewCommandColumn>

            <dx:GridViewDataTextColumn FieldName="ID" ShowInCustomizationForm="False" Visible="False" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ESTADO" ShowInCustomizationForm="False" Visible="False" VisibleIndex="0">
            </dx:GridViewDataTextColumn>

        </Columns>
    </dx:ASPxGridView>


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
                        <dx:ASPxLabel ID="LabelMensaje" runat="server" Font-Bold="True" Text="¿Está seguro que desea generar los asientos para los registros seleccionados?" style="margin-left: 7px" Width="300px">
                            <DisabledStyle Font-Bold="True">
                            </DisabledStyle>
                        </dx:ASPxLabel>
                    </td>
                    <td class="auto-style3">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                </tr>
                <tr>
                    <td class="auto-style9"></td>
                    <td class="progress-xxlarge">
                        <dx:ASPxButton ID="BTAceptar" runat="server" OnClick="BTAceptar_Click" Text="Aceptar" Width="80px">
                            <ClientSideEvents Click="function(s, e) { PDialogo.Hide(); }" />
                            <Image IconID="businessobjects_bo_validation_svg_16x16">
                            </Image>
                        </dx:ASPxButton>
                    </td>
                    <td class="progress-xxlarge"></td>
                    <td class="progress-xxlarge">
                        <dx:ASPxButton ID="BTCancelar" runat="server" Text="Cancelar">
                            <ClientSideEvents Click="function(s, e) { PDialogo.Hide(); }" />
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

    <dx:ASPxPopupControl ID="PMensaje" runat="server" Height="130px" Width="363px" HeaderText="Advertencia"  ClientInstanceName="PMensaje" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
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
                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Font-Bold="True" Text="Ha seleccionado registros que ya han sido procesados, por favor revisar." style="margin-left: 7px" Width="300px">
                            <DisabledStyle Font-Bold="True">
                            </DisabledStyle>
                        </dx:ASPxLabel>
                    </td>
                    <td class="auto-style3">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                </tr>
                <tr>
                    <td class="auto-style9"></td>
                    <td class="progress-xxlarge">

                    </td>
                    <td class="progress-xxlarge"></td>
                    <td class="progress-xxlarge">
                        <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Aceptar">
                            <ClientSideEvents Click="function(s, e) { PMensaje.Hide(); }" />
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

    <dx:ASPxPopupControl ID="PConfiguracion" runat="server" Height="130px" Width="363px" HeaderText="Advertencia"  ClientInstanceName="PConfiguracion" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
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
                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Font-Bold="True" Text="La cuenta contable y/o centro de costo de la empresa no se encuentra configurada correctamente, no se puede continuar con el proceso." style="margin-left: 7px" Width="300px">
                            <DisabledStyle Font-Bold="True">
                            </DisabledStyle>
                        </dx:ASPxLabel>
                    </td>
                    <td class="auto-style3">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                </tr>
                <tr>
                    <td class="auto-style9"></td>
                    <td class="progress-xxlarge">

                    </td>
                    <td class="progress-xxlarge"></td>
                    <td class="progress-xxlarge">
                        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Aceptar">
                            <ClientSideEvents Click="function(s, e) { PConfiguracion.Hide(); }" />
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

    <dx:ASPxPopupControl ID="PError" runat="server" Height="130px" Width="363px" HeaderText="Error"  ClientInstanceName="PError" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
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
                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Font-Bold="True" Text="Ocurrió un error en el proceso, por favor volver a intentar." style="margin-left: 7px" Width="300px">
                            <DisabledStyle Font-Bold="True">
                            </DisabledStyle>
                        </dx:ASPxLabel>
                    </td>
                    <td class="auto-style3">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                </tr>
                <tr>
                    <td class="auto-style9"></td>
                    <td class="progress-xxlarge">

                    </td>
                    <td class="progress-xxlarge"></td>
                    <td class="progress-xxlarge">
                        <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Aceptar">
                            <ClientSideEvents Click="function(s, e) { PError.Hide(); }" />
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

    <dx:ASPxPopupControl ID="PExito" runat="server" Height="130px" Width="363px" HeaderText="Error"  ClientInstanceName="PExito" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
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
                        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Font-Bold="True" Text="Se termino de ejecutar el proceso con éxito." style="margin-left: 7px" Width="300px">
                            <DisabledStyle Font-Bold="True">
                            </DisabledStyle>
                        </dx:ASPxLabel>
                    </td>
                    <td class="auto-style3">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                </tr>
                <tr>
                    <td class="auto-style9"></td>
                    <td class="progress-xxlarge">

                    </td>
                    <td class="progress-xxlarge"></td>
                    <td class="progress-xxlarge">
                        <dx:ASPxButton ID="ASPxButton4" runat="server" Text="Aceptar">
                            <ClientSideEvents Click="function(s, e) { PExito.Hide(); }" />
                            <Image IconID="businessobjects_bo_validation_svg_16x16">
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

</asp:Content>