<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Time_Fact.aspx.cs" Inherits="UI.Web.Time_Indirectos" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Time Facturas"></asp:Label>
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
    <asp:SqlDataSource ID="SQLFacturas" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [ID]
      ,[PROYECTO_COD]
      ,[FACTURA]
      ,[DESCRIPCION]
      ,[ESTADO]
      ,[ANO], MONTO, FECHA
  FROM [PORTAL].[Time].[FACTURAS]" DeleteCommand="DELETE PORTAL.[Time].[INDIRECTOS]
 WHERE ID = @ID" InsertCommand="INSERT INTO PORTAL.[Time].[FACTURAS]
           ([PROYECTO_COD], [FACTURA], [DESCRIPCION], [ESTADO], [ANO], [MONTO], [FECHA])
 
 VALUES
  (@PROYECTO_COD, @FACTURA, @DESCRIPCION, @ESTADO, @ANO, @MONTO, @FECHA)" UpdateCommand="UPDATE PORTAL.[Time].[FACTURAS]
  
SET [PROYECTO_COD] = @PROYECTO_COD,
      ,[FACTURA] = @FACTURA,
      ,[DESCRIPCION] = @DESCRIPCION,
      ,[ESTADO] = @ESTADO,
      ,[MONTO] = @MONTO,

      ,[ANO] = @ANO
, FECHA= @FECHA WHERE ID = @ID">
        <DeleteParameters>
            <asp:Parameter Name="ID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="PROYECTO_COD" />
            <asp:Parameter Name="FACTURA" />
            <asp:Parameter Name="DESCRIPCION" />
            <asp:Parameter Name="ESTADO" />
            <asp:Parameter Name="ANO" />
            <asp:Parameter Name="MONTO" />
            <asp:Parameter Name="FECHA" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="PROYECTO_COD" />
            <asp:Parameter Name="FACTURA" />
            <asp:Parameter Name="DESCRIPCION" />
            <asp:Parameter Name="ESTADO" />
            <asp:Parameter Name="MONTO" />
            <asp:Parameter Name="ANO" />
            <asp:Parameter Name="FECHA" />
            <asp:Parameter Name="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLProyectos" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="select [PROYECTO_COD], [PROYECTO], [ESTADO], [DISTRIBUIR]
  from portal.[Time].[PROYECTO]
  order by 2" UpdateCommand="Update portal.[Time].[PROYECTO]
set PROYECTO= @PROYECTO,
ESTADO =@ESTADO, DISTRIBUIR = @DISTRIBUIR
WHERE PROYECTO_COD = @PROYECTO_COD" DeleteCommand="Delete [PORTAL].[Presupuesto].[CIA]
WHERE CONJUNTO = @CONJUNTO">
        <DeleteParameters>
            <asp:Parameter Name="CONJUNTO" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="PROYECTO" />
            <asp:Parameter Name="ESTADO" />
            <asp:Parameter Name="DISTRIBUIR" />
            <asp:Parameter Name="PROYECTO_COD" />
        </UpdateParameters>
    </asp:SqlDataSource>

                <dx:ASPxGridViewExporter runat="server" GridViewID="ASPxGridView1" FileName="Time_Facturas" ExportedRowType="All" ID="ASPxGridViewExporter1"></dx:ASPxGridViewExporter>

    <br />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SQLFacturas" KeyFieldName="ID" Theme="SoftOrange" Width="427px">
        <Settings ShowFilterRow="True" />
<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FACTURA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DESCRIPCION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ANO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataCheckColumn FieldName="ESTADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="7">
                <PropertiesCheckEdit DisplayTextGrayed="Checked" DisplayTextUndefined="Checked" ValueChecked="S" ValueGrayed="S" ValueType="System.String" ValueUnchecked="N">
                </PropertiesCheckEdit>
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataComboBoxColumn FieldName="PROYECTO_COD" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
                <PropertiesComboBox DataSourceID="SQLProyectos" TextField="PROYECTO" ValueField="PROYECTO_COD">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
        </Columns>
    </dx:ASPxGridView>
    <br />
        

             </asp:Content>
