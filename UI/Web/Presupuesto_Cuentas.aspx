<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Presupuesto_Cuentas.aspx.cs" Inherits="UI.Web.Presupuesto_Cuentas" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Presupuesto Cuentas Contables"></asp:Label>
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
    <asp:SqlDataSource ID="SQLRubros" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT RUBRO_CONTABLE, DESCRIPCION
  FROM [PORTAL].[Presupuesto].[RUBRO_CONTABLE]
  order by 1">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLTipoGasto" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT TIPO_GASTO, DESCRIPCION, ESTADO
  FROM [PORTAL].[Presupuesto].[TIPO_GASTO]
  order by 1">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLERP" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [ERP]
      ,[DESCRIPCION]
  FROM [PORTAL].[Presupuesto].[ERP]
  order by 1">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLCMI_Mapping" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CMI_MAPPING,[CMI_MAPPING] DESCRIPCION
  FROM [PORTAL].[Presupuesto].[CMI_MAPPING]
  order by 1">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLCuentaContable" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CUENTA_CONTABLE, DESCRIPCION, ERP, U_CMI_MAPPING, RUBRO_CONTABLE, TIPO_GASTO, ESTADO
  FROM [PORTAL].[Presupuesto].[CUENTA_CONTABLE]
  order by CUENTA_CONTABLE" InsertCommand="INSERT INTO [PORTAL].[Presupuesto].[CUENTA_CONTABLE]
           (CUENTA_CONTABLE, DESCRIPCION, ERP, U_CMI_MAPPING, RUBRO_CONTABLE, TIPO_GASTO, ESTADO)
     VALUES (@CUENTA_CONTABLE, @DESCRIPCION, @ERP, @U_CMI_MAPPING, @RUBRO_CONTABLE, @TIPO_GASTO, @ESTADO)" UpdateCommand="Update [PORTAL].[Presupuesto].[CUENTA_CONTABLE]
set DESCRIPCION = @DESCRIPCION, ERP= @ERP, U_CMI_MAPPING = @U_CMI_MAPPING, RUBRO_CONTABLE = @RUBRO_CONTABLE, TIPO_GASTO = @TIPO_GASTO, ESTADO = @ESTADO
WHERE CUENTA_CONTABLE = @CUENTA_CONTABLE">
        <InsertParameters>
            <asp:Parameter Name="CUENTA_CONTABLE" />
            <asp:Parameter Name="DESCRIPCION" />
            <asp:Parameter Name="ERP" />
            <asp:Parameter Name="U_CMI_MAPPING" />
            <asp:Parameter Name="RUBRO_CONTABLE" />
            <asp:Parameter Name="TIPO_GASTO" />
            <asp:Parameter Name="ESTADO" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="DESCRIPCION" />
            <asp:Parameter Name="ERP" />
            <asp:Parameter Name="U_CMI_MAPPING" />
            <asp:Parameter Name="RUBRO_CONTABLE" />
            <asp:Parameter Name="TIPO_GASTO" />
            <asp:Parameter Name="ESTADO" />
            <asp:Parameter Name="CUENTA_CONTABLE" />
        </UpdateParameters>
    </asp:SqlDataSource>

                <dx:ASPxGridViewExporter runat="server" GridViewID="ASPxGridView1" FileName="Cuenta Contable" ExportedRowType="All" ID="ASPxGridViewExporter1"></dx:ASPxGridViewExporter>

    <br />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SQLCuentaContable" KeyFieldName="CUENTA_CONTABLE" Theme="SoftOrange" Width="427px">
        <Settings ShowFilterRow="True" />
<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="CUENTA_CONTABLE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DESCRIPCION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="RUBRO_CONTABLE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
                <PropertiesComboBox DataSourceID="SQLRubros" TextField="DESCRIPCION" ValueField="RUBRO_CONTABLE">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="TIPO_GASTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6">
                <PropertiesComboBox DataSourceID="SQLTipoGasto" TextField="DESCRIPCION" ValueField="TIPO_GASTO">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataCheckColumn FieldName="ESTADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="7">
                <PropertiesCheckEdit ValueChecked="A" ValueType="System.String" ValueUnchecked="X">
                </PropertiesCheckEdit>
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataComboBoxColumn FieldName="ERP" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
                <PropertiesComboBox DataSourceID="SQLERP" TextField="DESCRIPCION" ValueField="ERP">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="U_CMI_MAPPING" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
                <PropertiesComboBox DataSourceID="SQLCMI_Mapping" TextField="DESCRIPCION" ValueField="CMI_MAPPING">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
        </Columns>
    </dx:ASPxGridView>
    <br />
        

             </asp:Content>
