<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Time_Parametros_Mes.aspx.cs" Inherits="UI.Web.Time_Parametros_Mes" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Time Parámetros Mes (Tipo de cambio y Porcentaje carga social)"></asp:Label>
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
    <asp:SqlDataSource ID="SQLParametrosMes" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [ID]
      ,[ANO]
      ,[MES]
      ,[TIPO_CAMBIO]
      ,[PORC_CARGA_SOCIAL],
CANTIDAD_HORAS_MES
  FROM [PORTAL].[Time].[TIPO_CAMBIO]" UpdateCommand="Update [PORTAL].[Time].[TIPO_CAMBIO]
   SET TIPO_CAMBIO = @TIPO_CAMBIO,
      PORC_CARGA_SOCIAL = @PORC_CARGA_SOCIAL,
      CANTIDAD_HORAS_MES = @CANTIDAD_HORAS_MES
 WHERE ANO = @ANO and MES = @MES" DeleteCommand="Delete [PORTAL].[Presupuesto].[CIA]
WHERE CONJUNTO = @CONJUNTO" InsertCommand="INSERT INTO portal.[Time].[TIPO_CAMBIO]
           ([ANO]
           ,[MES]
           ,[TIPO_CAMBIO]
           ,[PORC_CARGA_SOCIAL]
           ,[CANTIDAD_HORAS_MES])
     VALUES (@ANO
           ,@MES
           ,@TIPO_CAMBIO
           ,@PORC_CARGA_SOCIAL
           ,@CANTIDAD_HORAS_MES)">
        <DeleteParameters>
            <asp:Parameter Name="CONJUNTO" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ANO" />
            <asp:Parameter Name="MES" />
            <asp:Parameter Name="TIPO_CAMBIO" />
            <asp:Parameter Name="PORC_CARGA_SOCIAL" />
            <asp:Parameter Name="CANTIDAD_HORAS_MES" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="TIPO_CAMBIO" />
            <asp:Parameter Name="PORC_CARGA_SOCIAL" />
            <asp:Parameter Name="CANTIDAD_HORAS_MES" />
            <asp:Parameter Name="ANO" />
            <asp:Parameter Name="MES" />
        </UpdateParameters>
    </asp:SqlDataSource>

                <dx:ASPxGridViewExporter runat="server" GridViewID="ASPxGridView1" FileName="Time Parametros Mes" ExportedRowType="All" ID="ASPxGridViewExporter1"></dx:ASPxGridViewExporter>

    <br />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SQLParametrosMes" KeyFieldName="ID" Theme="SoftOrange" Width="427px">
        <SettingsEditing Mode="Batch">
        </SettingsEditing>
        <Settings ShowFilterRow="True" ShowFilterBar="Visible" ShowFilterRowMenuLikeItem="True" />
<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="ID" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="0">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ANO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MES" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_CAMBIO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PORC_CARGA_SOCIAL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CANTIDAD_HORAS_MES" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>
    <br />
        

             </asp:Content>
