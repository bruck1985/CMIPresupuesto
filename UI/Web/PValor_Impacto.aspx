﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="PValor_Impacto.aspx.cs" Inherits="UI.Web.PValor_Impacto" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Palancas - Impacto"></asp:Label>
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
    <asp:SqlDataSource ID="SQLImpacto" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT 
	CodigoImpacto
	, Impacto
	, RangoMinimo
	, RangoMaximo
	, PesoImpacto
	, Activo
FROM Portal.PValor.Impactos
ORDER BY CodigoImpacto" InsertCommand="INSERT INTO Portal.PValor.Impactos
(
	Impacto
	, Activo
)
VALUES
(
	@Impacto
	, @Activo
)" UpdateCommand="UPDATE Portal.PValor.Impactos
SET 
Impacto=@Impacto
, RangoMinimo=@RangoMinimo
, RangoMaximo=@RangoMaximo
, PesoImpacto=@PesoImpacto
, Activo=@Activo
WHERE CodigoImpacto=@CodigoImpacto">
        <InsertParameters>
            <asp:Parameter Name="Impacto" />
            <asp:Parameter Name="Activo" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Impacto" />
            <asp:Parameter Name="RangoMinimo" />
            <asp:Parameter Name="RangoMaximo" />
            <asp:Parameter Name="PesoImpacto" />
            <asp:Parameter Name="Activo" />
            <asp:Parameter Name="CodigoImpacto" />
        </UpdateParameters>
    </asp:SqlDataSource>

                <dx:ASPxGridViewExporter runat="server" GridViewID="ASPxGridView1" FileName="Impactos" ExportedRowType="All" ID="ASPxGridViewExporter1"></dx:ASPxGridViewExporter>

    <br />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SQLImpacto" KeyFieldName="CodigoImpacto" Theme="SoftOrange" Width="427px">
        <Settings ShowFilterRow="True" />
        <SettingsDataSecurity AllowDelete="False" />
<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Impacto" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RangoMinimo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
                <PropertiesTextEdit DisplayFormatString="#,##.">
                </PropertiesTextEdit>
                <SettingsHeaderFilter>
                    <DateRangePickerSettings DisplayFormatString="#,##.">
                    </DateRangePickerSettings>
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RangoMaximo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
                <PropertiesTextEdit DisplayFormatString="#,##.">
                </PropertiesTextEdit>
                <SettingsHeaderFilter>
                    <DateRangePickerSettings DisplayFormatString="#,##.">
                    </DateRangePickerSettings>
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PesoImpacto" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="#,##.">
                </PropertiesTextEdit>
                <SettingsHeaderFilter>
                    <DateRangePickerSettings DisplayFormatString="#,##.">
                    </DateRangePickerSettings>
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Activo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
            </dx:GridViewDataCheckColumn>
        </Columns>
    </dx:ASPxGridView>
    <br />
        

             </asp:Content>
