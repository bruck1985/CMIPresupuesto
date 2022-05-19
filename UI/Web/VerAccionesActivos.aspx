<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="VerAccionesActivos.aspx.cs" Inherits="UI.Web.VerAccionesActivos" %>

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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="Acciones del Activo"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="93px" Theme="SoftOrange" Width="60%">
        <Items>
            <dx:LayoutGroup ColCount="5" ColSpan="1" ColumnCount="6" Caption="Acciones Activo"  RowSpan="2">
                <Items>

                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="32px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E1" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_ClickExc" Theme="SoftOrange" Width="32px">
                                      <BackgroundImage ImageUrl="~/Imagenes/Excel.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>
                    
                    <dx:LayoutItem Caption="" ColSpan="1" Name="PDF" Width="32px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnExportarPdf" runat="server" Height="32px" Native="True" OnClick="btnExportarPdf_E3_ClickExc" Theme="SoftOrange" Width="32px">
                                      <BackgroundImage ImageUrl="~/Imagenes/export_pdf.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnCancelar" runat="server" Height="32px" Width="32px" AutoPostBack="False"  EnableClientSideAPI="True">
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/Menu/Cerrar_Sesion_Hover.png" Repeat="NoRepeat" VerticalPosition="center" />
                                    <ClientSideEvents Click="function(s,e){ document.location.href='GestionActivos.aspx'; }" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/SaveAll_32x32.png">
                        </TabImage>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>



    <asp:SqlDataSource ID="SQLResultados" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=PRUEBAS;Persist Security Info=True;User ID=sa
;Password=SAsoftladbqa$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_ACCIONES_ACTIVO]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="pesquema" SessionField="dCia" />
            <asp:SessionParameter DefaultValue="%" Name="PActivo" SessionField="dActivo" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridView ID="grid_data"  ClientInstanceName="MasterGrid" runat="server" Width="1324px" AutoGenerateColumns="False" 
        DataSourceID="SQLResultados" Theme="SoftOrange" EnableRowsCache="False" >
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="CIA" VisibleIndex="7" ShowInCustomizationForm="True" Caption="Cia">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_CIA" VisibleIndex="8" ShowInCustomizationForm="True" Caption="Nombre Cia">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA" VisibleIndex="9" ShowInCustomizationForm="True" Caption="Fecha">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ACTIVO_FIJO" VisibleIndex="10" ShowInCustomizationForm="True" Caption="Activo Fijo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_ACTIVO" VisibleIndex="11" ShowInCustomizationForm="True" Caption="Nombre Activo Fijo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="UBICACION" VisibleIndex="11" ShowInCustomizationForm="True" Caption="Ubicacion">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_UBICACION" VisibleIndex="11" ShowInCustomizationForm="True" Caption="Nombre Ubicacion">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RESPONSABLE" VisibleIndex="12" ShowInCustomizationForm="True" Caption="Responsable">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_RESPONSABLE" VisibleIndex="13" ShowInCustomizationForm="True" Caption="Nombre Responsable">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ESTADO_ACTIVO" VisibleIndex="14" ShowInCustomizationForm="True" Caption="Estado Activo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DESCRIPCION_ESTADO" VisibleIndex="15" ShowInCustomizationForm="True" Caption="Descripcion Estado Activo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_ACCION_AF" VisibleIndex="16" ShowInCustomizationForm="True" Caption="Tipo Accion AF">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DESCRIPCION_TIPO_ACCION" VisibleIndex="17" ShowInCustomizationForm="True" Caption="Descripcion Tipo Accion AF">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOTAS" VisibleIndex="18" ShowInCustomizationForm="True" Caption="Notas">
            </dx:GridViewDataTextColumn>
            
        </Columns>
    </dx:ASPxGridView>

    <dx:ASPxGridViewExporter ID="grid_data_exp" runat="server" Landscape="true" FileName="Acciones_Activo" GridViewID="grid_data">
    </dx:ASPxGridViewExporter>

</asp:Content>
