<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="ContratoNIFF.aspx.cs" Inherits="UI.Web.ContratoNIFF" %>

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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Contratos NIFF"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="900px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Contratos" RowSpan="2">
                <Items>

                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E2" runat="server" Height="32px" Width="32px" ToolTip="Nuevo Contrato" PostBackUrl="~/Web/NuevoContratoNIFF.aspx">
                                    <BackgroundImage ImageUrl="~/Imagenes/AddFile_32x32.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"/>
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/AddFile_32x32.png">
                        </TabImage>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLContratos" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=PORTAL;Persist Security Info=True;User ID=sa
;Password=SAsoftladbqa$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_CONTRATO_NIIF]" SelectCommandType="StoredProcedure">

    </asp:SqlDataSource>
    <dx:ASPxPivotGridExporter ID="ASPxPivExp1" runat="server" ASPxPivotGridID="PivotContratoNIIF">
        <OptionsPrint MergeColumnFieldValues="False" MergeRowFieldValues="False" PrintHorzLines="True" PrintVertLines="False" VerticalContentSplitting="Exact">
        </OptionsPrint>
    </dx:ASPxPivotGridExporter>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM [ME].[erpadmin].[PRIVILEGIO_EX] P, me.erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>


    <dx:ASPxGridView ID="grid_data"  ClientInstanceName="MasterGrid" runat="server" Width="1324px" AutoGenerateColumns="False" DataSourceID="SQLContratos" Theme="SoftOrange" KeyFieldName="CONTRATO_ID" OnCustomButtonCallback="grid_data_CustomButtonCallback" >
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="EMPRESA" VisibleIndex="1" ShowInCustomizationForm="True" Caption="Empresa">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_CONTRATO" VisibleIndex="1" ShowInCustomizationForm="True" Caption="Nombre Contrato">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PAIS" VisibleIndex="2" ShowInCustomizationForm="True" Caption="País">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ENTIDAD" VisibleIndex="3" ShowInCustomizationForm="True" Caption="Entidad">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DESCRIPCION_ACTIVO" VisibleIndex="4" ShowInCustomizationForm="True" Caption="Descripción Activo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ARRENDADOR" VisibleIndex="5" ShowInCustomizationForm="True" Caption="Arrendador">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ARRENDADOR_AFILIADO" VisibleIndex="6" ShowInCustomizationForm="True" Caption="¿Arrendador es Afiliado?">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CONTRATO_SUBARRIENDO" VisibleIndex="7" ShowInCustomizationForm="True" Caption="¿Contrato Incluye Subarriendo?">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CUOTA_ARRENDAMIENTO" VisibleIndex="8" ShowInCustomizationForm="True" Caption="Cuota Arrendamiento">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_INICIO_ARREN" VisibleIndex="9" ShowInCustomizationForm="True" Caption="Fecha Inicio Arrendamiento">
                <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_VENCI_ARREN" VisibleIndex="10" ShowInCustomizationForm="True" Caption="Fecha Vencimiento Arrendamiento">
                <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CONTRATO_ID" ShowInCustomizationForm="False" Visible="False" VisibleIndex="0">
            </dx:GridViewDataTextColumn>

            <dx:GridViewCommandColumn VisibleIndex="11">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnDetalle" Text="Detalle" />
                </CustomButtons>
            </dx:GridViewCommandColumn>

            <dx:GridViewCommandColumn VisibleIndex="12">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnDescargar" Text="Descargar" />
                </CustomButtons>
            </dx:GridViewCommandColumn>

            <dx:GridViewCommandColumn VisibleIndex="13">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnAmortizacion" Text="Amortización" />
                </CustomButtons>
            </dx:GridViewCommandColumn>

            <dx:GridViewCommandColumn VisibleIndex="14">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnDepreciacion" Text="Depreciación" />
                </CustomButtons>
            </dx:GridViewCommandColumn>

            <dx:GridViewCommandColumn VisibleIndex="15">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnIntereses" Text="Interéses" />
                </CustomButtons>
            </dx:GridViewCommandColumn>
            
        </Columns>
    </dx:ASPxGridView>


</asp:Content>