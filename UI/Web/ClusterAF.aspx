<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="ClusterAF.aspx.cs" Inherits="UI.Web.ClusterAF" %>

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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="Cluster"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="900px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Cluster" RowSpan="2">
                <Items>

                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E2" runat="server" Height="32px" Width="32px" ToolTip="Nuevo Cluster" PostBackUrl="~/Web/NuevoCluster.aspx">
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
    <asp:SqlDataSource ID="SQLCluster" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=PORTAL;Persist Security Info=True;User ID=sa
;Password=SAsoftladbqa$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_CLUSTER_AF]" SelectCommandType="StoredProcedure">

    </asp:SqlDataSource>

    <dx:ASPxGridView ID="grid_data"  ClientInstanceName="MasterGrid" runat="server" Width="1324px" AutoGenerateColumns="False" DataSourceID="SQLCluster" Theme="SoftOrange" KeyFieldName="CLUSTER_ID" OnCustomButtonCallback="grid_data_CustomButtonCallback" >
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_CLUSTER" VisibleIndex="1" ShowInCustomizationForm="True" Caption="Nombre Cluster">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ESTADO" VisibleIndex="2" ShowInCustomizationForm="True" Caption="Estado">
            </dx:GridViewDataTextColumn>
            
            <dx:GridViewCommandColumn VisibleIndex="11">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnEditar" Text="Editar" />
                </CustomButtons>
            </dx:GridViewCommandColumn>

        </Columns>
    </dx:ASPxGridView>


</asp:Content>
