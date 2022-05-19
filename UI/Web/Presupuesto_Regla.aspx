<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Presupuesto_Regla.aspx.cs" Inherits="UI.Web.Presupuesto_Regla" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Presupuesto Reglas"></asp:Label>
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

    <asp:SqlDataSource ID="SQLCIA" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CONJUNTO, CONJUNTO + ' ' + NOMBRE NOMBRE
  FROM [PORTAL].[Presupuesto].[CIA]
  ORDER BY 1
">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLReglas" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" SelectCommand="SELECT REGLA, [DESCRIPCION],[INSTANCIA],[TIPO],[FORMULA_MES1],[FORMULA_MES2],[FORMULA_MES3]
      ,[FORMULA_MES4],[FORMULA_MES5],[FORMULA_MES6],[FORMULA_MES7],[FORMULA_MES8],[FORMULA_MES9],[FORMULA_MES10]
      ,[FORMULA_MES11],[FORMULA_MES12],[CIA],[AREA], ESTADO
  FROM [PORTAL].[Presupuesto].[REGLA]
  order by DESCRIPCION" InsertCommand="INSERT INTO [PORTAL].[Presupuesto].[CENTRO_COSTO]
           (CENTRO_COSTO, DESCRIPCION,CIA,CAPITAL, ESTADO)
     VALUES (@CENTRO_COSTO, @DESCRIPCION, @CIA, @CAPITAL, @ESTADO)" UpdateCommand="Update [PORTAL].[Presupuesto].[REGLA] 
set DESCRIPCION = @DESCRIPCION, CIA= @CIA, 
[INSTANCIA]= @INSTANCIA, [TIPO] = @TIPO,[FORMULA_MES1]=@FORMULA_MES1,[FORMULA_MES2]=FORMULA_MES2,[FORMULA_MES3]= @FORMULA_MES3
      ,[FORMULA_MES4]=@FORMULA_MES4,[FORMULA_MES5] =@FORMULA_MES5,[FORMULA_MES6]=@FORMULA_MES6,[FORMULA_MES7]=@FORMULA_MES7,[FORMULA_MES8]=@FORMULA_MES8,[FORMULA_MES9]=@FORMULA_MES9,[FORMULA_MES10]=@FORMULA_MES10
      ,[FORMULA_MES11] =@FORMULA_MES11,[FORMULA_MES12] = @FORMULA_MES12,[AREA]=@AREA, ESTADO=@ESTADO
where REGLA = @REGLA">
        <InsertParameters>
            <asp:Parameter Name="CENTRO_COSTO" />
            <asp:Parameter Name="DESCRIPCION" />
            <asp:Parameter Name="CIA" />
            <asp:Parameter Name="CAPITAL" />
            <asp:Parameter Name="ESTADO" />
        </InsertParameters>
    </asp:SqlDataSource>

                <dx:ASPxGridViewExporter runat="server" GridViewID="ASPxGridView1" FileName="Centros de Costos" ExportedRowType="All" ID="ASPxGridViewExporter1"></dx:ASPxGridViewExporter>

    <br />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SQLReglas" Theme="SoftOrange" Width="427px" KeyFieldName="REGLA">
        <Settings ShowFilterRow="True" />
<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="REGLA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4" ReadOnly="True">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DESCRIPCION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="INSTANCIA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FORMULA_MES1" LoadReadOnlyValueFromDataModel="True" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FORMULA_MES2" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FORMULA_MES3" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FORMULA_MES4" LoadReadOnlyValueFromDataModel="True" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FORMULA_MES5" LoadReadOnlyValueFromDataModel="True" VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FORMULA_MES6" LoadReadOnlyValueFromDataModel="True" VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FORMULA_MES7" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FORMULA_MES8" LoadReadOnlyValueFromDataModel="True" VisibleIndex="14">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FORMULA_MES9" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FORMULA_MES10" LoadReadOnlyValueFromDataModel="True" VisibleIndex="16">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FORMULA_MES11" LoadReadOnlyValueFromDataModel="True" VisibleIndex="17">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FORMULA_MES12" LoadReadOnlyValueFromDataModel="True" VisibleIndex="18">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="AREA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ESTADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="19">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="CIA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
                <PropertiesComboBox DataSourceID="SQLCIA" TextField="NOMBRE" ValueField="CONJUNTO">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
        </Columns>
    </dx:ASPxGridView>
    <br />
        

             </asp:Content>
