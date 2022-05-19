<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="PValor_Responsables.aspx.cs" Inherits="UI.Web.PValor_Responsables" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Palancas - Responsables"></asp:Label>
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
    <asp:SqlDataSource ID="SQLResponsables" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT 
	Resp.CodigoResponsable
	, Usu.Nombre AS Responsable
	, Resp.Usuario
	, Resp.CodigoRolUsuario
	, Resp.Activo
FROM Portal.PValor.Responsables AS Resp
INNER JOIN ME.erpadmin.USUARIO AS Usu
ON Resp.Usuario=Usu.Usuario
ORDER BY CodigoResponsable" InsertCommand="INSERT INTO Portal.PValor.Responsables
(
	Usuario
	, CodigoRolUsuario
	, Activo
)
VALUES
(
	@Usuario
	, @CodigoRolUsuario
	, @Activo
)" UpdateCommand="UPDATE Portal.PValor.Responsables
SET 
	Usuario=@Usuario
	, CodigoRolUsuario=@CodigoRolUsuario
	, Activo=@Activo
WHERE CodigoResponsable=@CodigoResponsable">
        <InsertParameters>
            <asp:Parameter Name="Usuario" />
            <asp:Parameter Name="CodigoRolUsuario" />
            <asp:Parameter Name="Activo" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Usuario" />
            <asp:Parameter Name="CodigoRolUsuario" />
            <asp:Parameter Name="Activo" />
            <asp:Parameter Name="CodigoResponsable" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLUsuarios" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT 
	Usuario
	, (Usuario + ' ' + Nombre) AS Nombre
FROM ME.erpadmin.USUARIO
WHERE ACTIVO='S'
ORDER BY Nombre">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLRoles" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT 
	Rol.CodigoRolUsuario
	, Rol.RolUsuario
FROM Portal.PValor.RolUsuarios AS Rol
WHERE Rol.Estado='A'">
    </asp:SqlDataSource>

                <dx:ASPxGridViewExporter runat="server" GridViewID="ASPxGridView1" FileName="Responsables" ExportedRowType="All" ID="ASPxGridViewExporter1"></dx:ASPxGridViewExporter>

    <br />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SQLResponsables" KeyFieldName="CodigoResponsable" Theme="SoftOrange" Width="427px">
        <Settings ShowFilterRow="True" />
        <SettingsDataSecurity AllowDelete="False" />
<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="CodigoResponsable" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="Usuario" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
                <PropertiesComboBox DataSourceID="SQLUsuarios" TextField="Nombre" ValueField="Usuario">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoRolUsuario" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
                <PropertiesComboBox DataSourceID="SQLRoles" TextField="RolUsuario" ValueField="CodigoRolUsuario">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataCheckColumn FieldName="Activo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
            </dx:GridViewDataCheckColumn>

        </Columns>
    </dx:ASPxGridView>
    <br />
        

             </asp:Content>
