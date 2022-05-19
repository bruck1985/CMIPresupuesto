<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Presupuesto_Area.aspx.cs" Inherits="UI.Web.Presupuesto_Area" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Presupuesto Area"></asp:Label>
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
    <asp:SqlDataSource ID="SQLArea" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT AREA,DESCRIPCION, ESTADO
  FROM [PORTAL].[Presupuesto].[AREA]
  order by 1" DeleteCommand="DELETE [PORTAL].[Presupuesto].[AREA]
WHERE AREA = @AREA" InsertCommand="INSERT INTO PORTAL.[Presupuesto].[AREA]
           (DESCRIPCION, ESTADO)
     VALUES (@DESCRIPCION, @ESTADO)" UpdateCommand="Update [PORTAL].[Presupuesto].[AREA]
Set DESCRIPCION = @DESCRIPCION,
ESTADO = @ESTADO
WHERE AREA = @AREA">
        <DeleteParameters>
            <asp:Parameter Name="AREA" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="DESCRIPCION" />
            <asp:Parameter Name="ESTADO" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="DESCRIPCION" />
            <asp:Parameter Name="AREA" />
            <asp:Parameter Name="ESTADO" />
        </UpdateParameters>
    </asp:SqlDataSource>

                <dx:ASPxGridViewExporter runat="server" GridViewID="ASPxGridView1" FileName="Rubros_Contables" ExportedRowType="All" ID="ASPxGridViewExporter1"></dx:ASPxGridViewExporter>

    <asp:SqlDataSource ID="SQLCuentaContable" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CUENTA_CONTABLE, CUENTA_CONTABLE + ' ' +DESCRIPCION DESCRIPCION
  FROM [PORTAL].[Presupuesto].[CUENTA_CONTABLE]
  order by CUENTA_CONTABLE">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLArea_Cuenta" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CUENTA, AREA
  FROM portal.[Presupuesto].[AREA_CUENTA]
WHERE AREA = @AREA
  order by 1" DeleteCommand="DELETE  portal.[Presupuesto].[AREA_CUENTA]
WHERE AREA = @AREA AND CUENTA = @CUENTA" InsertCommand="INSERT INTO  portal.[Presupuesto].[AREA_CUENTA]
           (AREA, CUENTA)
     VALUES (@AREA, @CUENTA)" UpdateCommand="Update  portal.[Presupuesto].[AREA_CUENTA]
Set CUENTA= @CUENTA
WHERE AREA = @AREA">
        <DeleteParameters>
            <asp:SessionParameter Name="AREA" SessionField="PAREA" />
            <asp:Parameter Name="CUENTA" />
        </DeleteParameters>
        <InsertParameters>
            <asp:SessionParameter Name="AREA" SessionField="PAREA" />
            <asp:Parameter Name="CUENTA" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="1" Name="AREA" SessionField="PAREA" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CUENTA" />
            <asp:Parameter Name="AREA" />
        </UpdateParameters>
    </asp:SqlDataSource>

                <br />

    <br />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SQLArea" Theme="SoftOrange" Width="427px" KeyFieldName="AREA">
        <Settings ShowFilterRow="True" />
<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="AREA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DESCRIPCION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="ESTADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
                <PropertiesCheckEdit ValueChecked="A" ValueType="System.String" ValueUnchecked="X">
                </PropertiesCheckEdit>
            </dx:GridViewDataCheckColumn>

        </Columns>
              <Templates>
					<DetailRow>
						<dx:ASPxGridView ID="detailGrid" runat="server" AutoGenerateColumns="False" DataSourceID="SQLArea_Cuenta"
							KeyFieldName="CUENTA" OnBeforePerformDataSelect="detailGrid_BeforePerformDataSelect" OnRowDeleting="Grid_RowDeleting" OnRowInserting="Grid_RowInserting" OnRowUpdating="Grid_RowUpdating"
							 Theme="SoftOrange" Width="420px" >
							<Columns>
								<dx:GridViewCommandColumn ShowNewButton="true" ShowEditButton="false" ShowDeleteButton="true" VisibleIndex="0">
								</dx:GridViewCommandColumn>
                                <dx:GridViewDataComboBoxColumn FieldName="CUENTA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1">
                                  <PropertiesComboBox DataSourceID="SQLCuentaContable" TextField="DESCRIPCION" ValueField="CUENTA_CONTABLE" Width ="400px">
                                  </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
								<dx:GridViewDataTextColumn FieldName="AREA" VisibleIndex="2" Visible="false">
								</dx:GridViewDataTextColumn>
							</Columns>
						</dx:ASPxGridView>
					</DetailRow>
				</Templates>
				<SettingsDetail ShowDetailRow="True" />
    </dx:ASPxGridView>
    <br />
        

             </asp:Content>
