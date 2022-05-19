<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Presupuesto_Pase_Softland.aspx.cs" Inherits="UI.Web.Presupuesto_Pase_Softland" %>
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
         function synchronizeListBoxValuescc(dropDown, args) {
             checkListBoxcc.UnselectAll();
             var texts = dropDown.GetText().split(textSeparator);
             var values = getValuesByTextscc(texts);
             checkListBoxcc.SelectValues(values);
             updateTextcc(); // for remove non-existing texts
         }
         function getValuesByTextscc(texts) {
             var actualValues = [];
             var item;
             for (var i = 0; i < texts.length; i++) {
                 item = checkListBoxcc.FindItemByText(texts[i]);
                 if (item != null)
                     actualValues.push(item.value);
             }
             return actualValues;
         }
         function updateTextcc() {
             var selectedItems = checkListBoxcc.GetSelectedItems();
             checkComboBoxcc.SetText(getSelectedItemsText(selectedItems));
         } 

         function ShowDrillDown() {
             var mainElement = PivotCompra.GetMainElement();
             DrillDownWindow.ShowAtPos(ASPxClientUtils.GetAbsoluteX(mainElement), ASPxClientUtils.GetAbsoluteY(mainElement));
         }
         function onGridEndCallback(s, e) {
             if (s.cpShowDrillDownWindow)
                 GridView.SetVisible(true);
         }
    </script>
    <input runat="server" id="ColumnIndex" type="hidden" enableviewstate="true" />
    <input runat="server" id="RowIndex" type="hidden" enableviewstate="true" />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Presupuesto a Softland"></asp:Label>
    <br />
    <br />

    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="1050px" style="margin-top: 0px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Seleccione compañia" ColSpan="1" Name="CiaOrigen" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E4" runat="server" DataSourceID="SQLCompania" EnableTheming="True" TextField="nombre" Theme="SoftOrange" ValueField="conjunto" Width="250px">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
          </LayoutItemNestedControlCollection>
                <CaptionSettings Location="Top" />
         </dx:LayoutItem>
                    <dx:LayoutItem Caption="Seleccione el año" ColSpan="1" Name="AnnoOrigen" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="ASPxComboBox2" runat="server" DataSourceID="SQLPeriodos" TextField="ano" Theme="SoftOrange" ValueField="ano">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                         <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_Click" Theme="SoftOrange" Width="32px" ToolTip="Generar información">
                                  <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E1EXCEL" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_ClickExc" Theme="SoftOrange" Width="32px" ToolTip="Exportar Excel">
                                   <BackgroundImage ImageUrl="~/Imagenes/Excel.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E2" runat="server" AutoPostBack="False" Height="32px" Width="32px" ToolTip="Lista de Campos" OnClick="Lform_E2_Click">
                                    <ClientSideEvents Click="function(s, e) {
	PivotCompra.ChangeCustomizationFieldsVisibility(); return false; 
}" />
                                   <BackgroundImage ImageUrl="~/Imagenes/Lista.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Lista.png">
                        </TabImage>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E3" runat="server" Height="32px" OnClick="Lform_E3_Click" Width="32px">
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/SaveAll_32x32.png" Repeat="NoRepeat" VerticalPosition="center" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLGetMapeos" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPortal %>" SelectCommand="PORTAL_GET_PRESUPUESTO" SelectCommandType="StoredProcedure" OnSelecting="SQLCompras_Selecting" ProviderName="<%$ ConnectionStrings:SQLConexionPortal.ProviderName %>">
        <SelectParameters>
            <asp:SessionParameter Name="CIA" SessionField="ci_scia1" />
            <asp:SessionParameter Name="ANNO" SessionField="Anno" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM [erpadmin].[PRIVILEGIO_EX] P, erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

                <dx:ASPxGridViewExporter runat="server" GridViewID="GPermisos" FileName="Presupuesto_Pase_Softland" ExportedRowType="All" ID="ASPxGridViewExporter1"></dx:ASPxGridViewExporter>

    <asp:SqlDataSource ID="SQLPeriodos" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPortal %>" ProviderName="<%$ ConnectionStrings:SQLConexionPortal.ProviderName %>" SelectCommand="select ano from portal.[Presupuesto].[PERIODOS] order by 1">
    </asp:SqlDataSource>

        
    <br />
                <dx:ASPxGridView ID="GPermisos" runat="server" AutoGenerateColumns="False" CssFilePath="~/App_Themes/RedWine/{0}/styles.css"
                    CssPostfix="RedWine" 
                    Width="376px" ClientInstanceName="grid" EnableRowsCache="False" Theme="SoftOrange" DataSourceID="SQLGetMapeos">
                    <ImagesFilterControl>
                        <LoadingPanel Url="~/App_Themes/RedWine/Editors/Loading.gif">
                        </LoadingPanel>
                    </ImagesFilterControl>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="ID" LoadReadOnlyValueFromDataModel="True" VisibleIndex="0">
                            <BatchEditModifiedCellStyle HorizontalAlign="Right">
                            </BatchEditModifiedCellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CIA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CENTRO_COSTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PARTIDA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3" Caption="PARTIDA_PRESUPUESTAL">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DESCRIPCION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4" Caption="DESCRIPCION">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ENERO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
                            <PropertiesTextEdit DisplayFormatString="N2">
                                <Style HorizontalAlign="Right">
                                </Style>
                            </PropertiesTextEdit>
                            <EditCellStyle HorizontalAlign="Right">
                            </EditCellStyle>
                            <FilterCellStyle HorizontalAlign="Right">
                            </FilterCellStyle>
                            <EditFormCaptionStyle HorizontalAlign="Right">
                            </EditFormCaptionStyle>
                            <HeaderStyle HorizontalAlign="Right" />
                            <CellStyle HorizontalAlign="Right">
                            </CellStyle>
                            <FooterCellStyle HorizontalAlign="Right">
                            </FooterCellStyle>
                            <GroupFooterCellStyle HorizontalAlign="Right">
                            </GroupFooterCellStyle>
                            <ExportCellStyle HorizontalAlign="Right">
                            </ExportCellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FEBRERO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6">
                            <PropertiesTextEdit DisplayFormatString="N2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MARZO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="7">
                            <PropertiesTextEdit DisplayFormatString="N2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ABRIL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8">
                            <PropertiesTextEdit DisplayFormatString="N2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MAYO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9">
                            <PropertiesTextEdit DisplayFormatString="N2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="JUNIO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="10">
                            <PropertiesTextEdit DisplayFormatString="N2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="JULIO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="11">
                            <PropertiesTextEdit DisplayFormatString="N2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="AGOSTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="12">
                            <PropertiesTextEdit DisplayFormatString="N2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SEPTIEMBRE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13">
                            <PropertiesTextEdit DisplayFormatString="N2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="OCTUBRE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="14">
                            <PropertiesTextEdit DisplayFormatString="N2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NOVIEMBRE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15">
                            <PropertiesTextEdit DisplayFormatString="N2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DICIEMBRE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="16">
                            <PropertiesTextEdit DisplayFormatString="N2">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TOTAL_LINEA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="17">
                            <PropertiesTextEdit DisplayFormatString="N2">
                                <Style HorizontalAlign="Right">
                                </Style>
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="N2" FieldName="ENERO" ShowInColumn="ENERO" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="N2" FieldName="FEBRERO" ShowInColumn="FEBRERO" SummaryType="Sum" ValueDisplayFormat="N2" />
                        <dx:ASPxSummaryItem DisplayFormat="N2" FieldName="MARZO" ShowInColumn="MARZO" SummaryType="Sum" ValueDisplayFormat="N2" />
                        <dx:ASPxSummaryItem DisplayFormat="N2" FieldName="ABRIL" ShowInColumn="ABRIL" SummaryType="Sum" ValueDisplayFormat="N2" />
                        <dx:ASPxSummaryItem DisplayFormat="N2" FieldName="MAYO" ShowInColumn="MAYO" SummaryType="Sum" ValueDisplayFormat="N2" />
                        <dx:ASPxSummaryItem DisplayFormat="N2" FieldName="JUNIO" ShowInColumn="JUNIO" SummaryType="Sum" ValueDisplayFormat="N2" />
                        <dx:ASPxSummaryItem DisplayFormat="N2" FieldName="JULIO" ShowInColumn="JULIO" SummaryType="Sum" ValueDisplayFormat="N2" />
                        <dx:ASPxSummaryItem DisplayFormat="N2" FieldName="AGOSTO" ShowInColumn="AGOSTO" SummaryType="Sum" ValueDisplayFormat="N2" />
                        <dx:ASPxSummaryItem DisplayFormat="N2" FieldName="SEPTIEMBRE" ShowInColumn="SEPTIEMBRE" SummaryType="Sum" ValueDisplayFormat="N2" />
                        <dx:ASPxSummaryItem DisplayFormat="N2" FieldName="OCTUBRE" ShowInColumn="OCTUBRE" SummaryType="Sum" ValueDisplayFormat="N2" />
                        <dx:ASPxSummaryItem DisplayFormat="N2" FieldName="NOVIEMBRE" ShowInColumn="NOVIEMBRE" SummaryType="Sum" ValueDisplayFormat="N2" />
                        <dx:ASPxSummaryItem DisplayFormat="N2" FieldName="DICIEMBRE" ShowInColumn="DICIEMBRE" SummaryType="Sum" ValueDisplayFormat="N2" />
                        <dx:ASPxSummaryItem DisplayFormat="N2" FieldName="TOTAL_LINEA" ShowInColumn="TOTAL_LINEA" SummaryType="Sum" ValueDisplayFormat="N2" />
                    </TotalSummary>
                    <Styles CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine">
                        <DetailCell HorizontalAlign="Right">
                        </DetailCell>
                        <Footer HorizontalAlign="Right">
                        </Footer>
                        <LoadingPanel ImageSpacing="8px">
                        </LoadingPanel>
                    </Styles>
                    <Settings ShowFooter="True" />
                    <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>

                    <SettingsLoadingPanel ImagePosition="Top" />
                    <Images SpriteCssFilePath="~/App_Themes/RedWine/{0}/sprite.css">
                        <LoadingPanelOnStatusBar Url="~/App_Themes/RedWine/GridView/gvLoadingOnStatusBar.gif">
                        </LoadingPanelOnStatusBar>
                        <LoadingPanel Url="~/App_Themes/RedWine/GridView/Loading.gif">
                        </LoadingPanel>
                    </Images>
                    <StylesEditors>
                        <CalendarHeader Spacing="1px">
                        </CalendarHeader>
                        <ProgressBar Height="25px">
                        </ProgressBar>
                    </StylesEditors>
                    <ImagesEditors>
                        <DropDownEditDropDown >
                            <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_RedWine" />
                        </DropDownEditDropDown>
                    </ImagesEditors>
                </dx:ASPxGridView>
                
      
             </asp:Content>
