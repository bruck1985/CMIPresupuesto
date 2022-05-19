<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="PValor_TemasPorResponsable.aspx.cs" Inherits="UI.Web.PValor_TemasPorResponsable" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Palancas - Temas por Responsable"></asp:Label>
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
    <asp:SqlDataSource ID="SQLTemasResponsables" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT 
	TemResp.CodigoTemaResponsable
	, TemResp.CodigoTema
	, TemResp.CodigoResponsable
FROM Portal.[PValor].[TemasResponsables] AS TemResp
ORDER BY 2" InsertCommand="INSERT INTO Portal.PValor.TemasResponsables
(
	CodigoTema
	, CodigoResponsable
)
VALUES
(
	@CodigoTema
	, @CodigoResponsable
)" UpdateCommand="UPDATE Portal.PValor.TemasResponsables
SET 
CodigoTema=@CodigoTema
, CodigoResponsable=@CodigoResponsable
WHERE CodigoTemaResponsable=@CodigoTemaResponsable" DeleteCommand="DELETE Portal.PValor.TemasResponsables
WHERE CodigoTemaResponsable=@CodigoTemaResponsable">
        <InsertParameters>
            <asp:Parameter Name="CodigoTema" />
            <asp:Parameter Name="CodigoResponsable" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="CodigoTema" />
            <asp:Parameter Name="CodigoResponsable" />
            <asp:Parameter Name="CodigoTemaResponsable" />
        </UpdateParameters>
    </asp:SqlDataSource>
                <asp:SqlDataSource ID="SQLTemas" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep; Password=P0rta1R3p.2766$"
                    ProviderName="System.Data.SqlClient" SelectCommand='SELECT
	CodigoTema
	, Tema
FROM PORTAL.[PValor].[Temas] AS Tem'>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SQLResponsables" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep; Password=P0rta1R3p.2766$"
                    ProviderName="System.Data.SqlClient" SelectCommand='SELECT 
	Resp.CodigoResponsable
	, (Usu.Usuario + &#039; &#039; + Usu.Nombre) AS Responsable
FROM Portal.PValor.Responsables AS Resp
INNER JOIN ME.erpadmin.USUARIO AS Usu
ON Resp.Usuario=Usu.Usuario
'>
                </asp:SqlDataSource>
                <dx:ASPxGridViewExporter runat="server" GridViewID="ASPxGridView1" FileName="TemasResponsables" ExportedRowType="All" ID="ASPxGridViewExporter1"></dx:ASPxGridViewExporter>

    <br />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SQLTemasResponsables" KeyFieldName="CodigoTemaResponsable" Theme="SoftOrange" Width="427px">
        <Settings ShowFilterRow="True" />
        <SettingsBehavior ConfirmDelete="True" />
<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0" ShowDeleteButton="True">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoTema" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1">
                <PropertiesComboBox DataSourceID="SQLTemas" TextField="Tema" ValueField="CodigoTema">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoResponsable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
                <PropertiesComboBox DataSourceID="SQLResponsables" TextField="Responsable" ValueField="CodigoResponsable">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
        </Columns>
    </dx:ASPxGridView>
    <br />
        

             </asp:Content>
