<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="PValor_ConfiguracionCampos.aspx.cs" Inherits="UI.Web.PValor_ConfiguracionCampos" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Palancas - Configuración Campos"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="80px" Theme="SoftOrange" Width="411px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Defina Parametros" RowSpan="2">
                <Items>
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
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLConfiguracionCampos" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT 
	(CodigoMenu + '-' + CAST(CodigoEmpresa AS NVARCHAR) + '-' + NombreCampo) AS CONSECUTIVO
	, CodigoMenu
	, CodigoEmpresa
	, NombreCampo
	, Alias
	, VisibleLectura
	, VisibleEscritura
FROM Portal.dbo.Campos
WHERE VisibleDB=1
AND CodigoMenu='10.1'
AND CodigoEmpresa=1
ORDER BY 
CodigoMenu
, CodigoEmpresa
, NombreCampo" UpdateCommand="UPDATE Portal.dbo.Campos
SET VisibleLectura=@VisibleLectura
	, VisibleEscritura=@VisibleEscritura
WHERE CodigoMenu=@CodigoMenu
	AND CodigoEmpresa=@CodigoEmpresa
	AND NombreCampo=@NombreCampo">
        <UpdateParameters>
            <asp:Parameter Name="VisibleLectura" />
            <asp:Parameter Name="VisibleEscritura" />
            <asp:Parameter Name="CodigoMenu" />
            <asp:Parameter Name="CodigoEmpresa" />
            <asp:Parameter Name="NombreCampo" />
        </UpdateParameters>
    </asp:SqlDataSource>

                <dx:ASPxGridViewExporter runat="server" GridViewID="GridConfiguracionCampos" FileName="ConfiguracionCampos" ExportedRowType="All" ID="ASPxGridViewExporter1"></dx:ASPxGridViewExporter>

    <br />
    <dx:ASPxGridView ID="GridConfiguracionCampos" runat="server" AutoGenerateColumns="False" DataSourceID="SQLConfiguracionCampos" KeyFieldName="CONSECUTIVO" Theme="SoftOrange" Width="600px">
        <SettingsPager PageSize="17">
        </SettingsPager>
        <SettingsEditing Mode="Batch">
        </SettingsEditing>
        <Settings ShowFilterRow="True" />
        <SettingsDataSecurity AllowDelete="False" AllowInsert="False" />
<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="CONSECUTIVO" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" Visible="False" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CodigoMenu" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" Visible="False" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CodigoEmpresa" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" Visible="False" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NombreCampo" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" Visible="False" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Descripción" FieldName="Alias" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4" Width="300px">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="VisibleLectura" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5" Width="100px">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataCheckColumn FieldName="VisibleEscritura" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6" Width="100px">
            </dx:GridViewDataCheckColumn>
        </Columns>
    </dx:ASPxGridView>
    <br />
        

             </asp:Content>
