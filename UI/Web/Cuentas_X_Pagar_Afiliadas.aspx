<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Cuentas_X_Pagar_Afiliadas.aspx.cs" Inherits="UI.Web.Cuentas_X_Pagar_Afiliadas" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
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
        <asp:ScriptManager ID="MyScripts" runat="server" EnablePageMethods="true" EnablePartialRendering="true" LoadScriptsBeforeUI="true" ScriptMode="Auto"> 
       
    </asp:ScriptManager>
    <input runat="server" id="ColumnIndex" type="hidden" enableviewstate="true" />
    <input runat="server" id="RowIndex" type="hidden" enableviewstate="true" />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Aplica CXP Interco"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="145px" Theme="SoftOrange" Width="903px" style="margin-top: 0px">
        <Items>
            <dx:LayoutGroup ColCount="5" ColSpan="1" ColumnCount="5" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Seleccione compañia origen" ColSpan="1" Name="CiaOrigen" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E4" runat="server" DataSourceID="SQLCompania" EnableTheming="True" TextField="nombre" Theme="SoftOrange" ValueField="conjunto" Width="188px">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
          </LayoutItemNestedControlCollection>
                <CaptionSettings Location="Top" />
         </dx:LayoutItem>
                    <dx:LayoutItem Caption="Seleccione compañía destino" ColSpan="1" Name="CiaDestino" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E5" runat="server" DataSourceID="SQLCompania" EnableTheming="True" Height="22px" TextField="nombre" Theme="SoftOrange" ValueField="conjunto" Width="187px">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Monto Sel CXP" ColSpan="1" Width="20px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <asp:UpdatePanel ID="UpdateTotalCP" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                    <ContentTemplate>
                                        <label ID="TotalCP" Font-Bold="True" Font-Size="Medium" ><%= Convert.ToDecimal( GPermisos.GetTotalSummaryValue(GPermisos.TotalSummary["SALDO"])).ToString("N2") %></label>                            
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Width="20px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_Click" Theme="SoftOrange" ToolTip="Generar información" Width="32px">
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/BotonActualizar.png" Repeat="NoRepeat" VerticalPosition="center" />
                                </dx:ASPxButton>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="20px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E3" runat="server" Height="32px" OnClick="Lform_E3_Click" Width="32px">
                                    <ClientSideEvents Click="function(s, e) {
	e.processOnServer = confirm('¿Desea continuar?'); 
}" />
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/SaveAll_32x32.png" Repeat="NoRepeat" VerticalPosition="center" />
                                </dx:ASPxButton>
                                <asp:Button ID="btn_guardar_hide" ClientIDMode="Static" style="display:none" runat="server" Visible="true" onclick="Lform_E3_Click"/>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Sel. Cta Banco Origen:" ColSpan="1" Name="CtaBanco" VerticalAlign="Middle" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E6" runat="server" DataSourceID="SQLGetCtasBancos" EnableTheming="True" Height="21px" TextField="NOMBRE" Theme="SoftOrange" ValueField="CUENTA_BANCO" Width="189px">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Sel. Cta Banco Destino:" ColSpan="1" Name="CtaBancoDestino">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E7" runat="server" DataSourceID="SQLGetCtasBancosDest" EnableTheming="True" Height="21px" TextField="NOMBRE" Theme="SoftOrange" ValueField="CUENTA_BANCO" Width="189px">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Monto a pagar:" ColSpan="1" Width="20px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="txt_Monto_Pagar" runat="server" Height="21px" Width="100px" Theme="SoftOrange" Number="0.00" DecimalPlaces="2" DisplayFormatString="{0:N}" OnValueChanged="txt_Monto_Pagar_ValueChanged"/>
                             </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="TC:" ColSpan="1" Width="20px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="Tipo_Cambio_CL" runat="server" Height="21px" Width="100px" Theme="SoftOrange" Number="0.00" DecimalPlaces="2" DisplayFormatString="{0:N}"/>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Monto Pagar Moneda Cta Banco:" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxSpinEdit ID="txt_Monto_Pagar1" runat="server" DecimalPlaces="2" DisplayFormatString="{0:N}" Height="16px" Number="0.00" ReadOnly="True" Theme="SoftOrange" Width="177px">
                                </dx:ASPxSpinEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLGetMapeos" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=PORTAL;Persist Security Info=True;User ID=sa; Password=SAsoftladbqa$" SelectCommand="PORTAL_CXP_GET_PENDIENTES_AFILIADAS" SelectCommandType="StoredProcedure" OnSelecting="SQLCompras_Selecting" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>">
        <SelectParameters>
            <asp:SessionParameter Name="CIA" SessionField="ci_scia1" />
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

    <asp:SqlDataSource ID="SQLGetCtasBancos" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=PORTAL;Persist Security Info=True;User ID=sa; Password=SAsoftladbqa$" SelectCommand="PORTAL_GET_CUENTAS_BANCARIAS" SelectCommandType="StoredProcedure" OnSelecting="SQLCompras_Selecting" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>">
        <SelectParameters>
            <asp:SessionParameter Name="CIA" SessionField="ci_scia1" />
        </SelectParameters>
    </asp:SqlDataSource>

                <dx:ASPxGridViewExporter runat="server" GridViewID="GPermisos" FileName="Mapeo_Contable" ExportedRowType="All" ID="ASPxGridViewExporter1"></dx:ASPxGridViewExporter>

    <asp:SqlDataSource ID="SQLGetCtasCC" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebasPortal %>" SelectCommand="PORTAL_CXC_GET_PENDIENTES_AFILIADAS" SelectCommandType="StoredProcedure" OnSelecting="SQLCompras_Selecting" ProviderName="<%$ ConnectionStrings:SQLConexionPruebasPortal.ProviderName %>">
        <SelectParameters>
            <asp:SessionParameter Name="CIA" SessionField="ci_scia12" />
            <asp:SessionParameter Name="CIA_PAGAR" SessionField="ci_scia1" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLGetCtasBancosDest" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=PORTAL;Persist Security Info=True;User ID=sa; Password=SAsoftladbqa$" SelectCommand="PORTAL_GET_CUENTAS_BANCARIAS" SelectCommandType="StoredProcedure" OnSelecting="SQLCompras_Selecting" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>">
        <SelectParameters>
            <asp:SessionParameter Name="CIA" SessionField="ci_scia12" />
        </SelectParameters>
    </asp:SqlDataSource>

                <br />
    <br />

    <br />
    <%--                <div class ="row">
                    <div class="col-sm-3">
                       <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Medium" Text="Cuentas x Pagar"></asp:Label>
                    </div>
                                        <div class="col-sm-3">
                        <asp:UpdatePanel ID="UpdateTotalCP" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                            <ContentTemplate>
                                <label ID="TotalCP" Font-Bold="True" Font-Size="Medium" ><%= Convert.ToDecimal( GPermisos.GetTotalSummaryValue(GPermisos.TotalSummary["SALDO"])).ToString("N2") %></label>                            
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="col-sm-6">
                        <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="Medium" Text="Cuentas x Cobrar"></asp:Label>
                    </div>

                </div>--%>
                <div class ="row">
                    <div class="col-sm-6">
                                        <dx:ASPxGridView ID="GPermisos" runat="server" AutoGenerateColumns="False" CssFilePath="~/App_Themes/RedWine/{0}/styles.css"
                    CssPostfix="RedWine" OnDataBound="GPermisos_DataBound"  OnCustomSummaryCalculate="GPermisos_CustomSummaryCalculate" OnSelectionChanged="GPermisos_SelectionChanged"
                    Width="354px" ClientInstanceName="grid" EnableRowsCache="False" Theme="SoftOrange" DataSourceID="SQLGetMapeos" KeyFieldName="NUM" Caption="Cuentas x Pagar">
                    <ImagesFilterControl>
                        <LoadingPanel Url="~/App_Themes/RedWine/Editors/Loading.gif">
                        </LoadingPanel>
                    </ImagesFilterControl>
                    <TotalSummary>
                        <dx:ASPxSummaryItem FieldName="SALDO" ShowInColumn="SALDO" SummaryType="Custom" />
                    </TotalSummary>
                    <Columns>
                        <dx:GridViewCommandColumn Name="Check" SelectAllCheckboxMode="Page" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                            <CellStyle CssClass="N2">
                            </CellStyle>
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="PROVEEDOR" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2" ReadOnly="True" ShowInCustomizationForm="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DOCUMENTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4" ReadOnly="True" ShowInCustomizationForm="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TIPO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6" ReadOnly="True" ShowInCustomizationForm="True" Caption="TIP">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FECHA_DOCUMENTO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="7" Caption="D FECHA" Width="80px">
                            <PropertiesDateEdit DisplayFormatString="dd/MM/yy">
                            </PropertiesDateEdit>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="MONTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8" ShowInCustomizationForm="True" Visible="False">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SALDO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9" ShowInCustomizationForm="True">
                            <PropertiesTextEdit DisplayFormatString="###,###.00" >  
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NOMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="3" Width="210px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MONEDA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5" Caption="MON">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NUM" LoadReadOnlyValueFromDataModel="True" Visible="False" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <SettingsBehavior ProcessSelectionChangedOnServer="True" />
                    <Styles CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine">
                        <LoadingPanel ImageSpacing="8px">
                        </LoadingPanel>
                        <FilterCell Wrap="False">
                        </FilterCell>
                    </Styles>
                                            <Settings ShowFooter="True" />
                                            <SettingsBehavior AllowSelectSingleRowOnly="True" />
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
                    </div>
                    <div class="col-sm-6">
                                        <dx:ASPxGridView ID="GPermisos1" runat="server" AutoGenerateColumns="False" CssFilePath="~/App_Themes/RedWine/{0}/styles.css"
                    CssPostfix="RedWine" OnCustomSummaryCalculate="GPermisos1_CustomSummaryCalculate" OnSelectionChanged="GPermisos1_SelectionChanged"
                    Width="354px" ClientInstanceName="grid" EnableRowsCache="False" Theme="SoftOrange" DataSourceID="SQLGetCtasCC" KeyFieldName="NUM" Caption="Cuentas X Cobrar">
                    <ImagesFilterControl>
                        <LoadingPanel Url="~/App_Themes/RedWine/Editors/Loading.gif">
                        </LoadingPanel>
                    </ImagesFilterControl>
                    <TotalSummary>
                        <dx:ASPxSummaryItem FieldName="SALDO" ShowInColumn="SALDO" SummaryType="Custom" />
                    </TotalSummary>
                    <Columns>
                        <dx:GridViewCommandColumn Name="Check" SelectAllCheckboxMode="Page" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                            <CellStyle CssClass="N2">
                            </CellStyle>
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="CLIENTE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2" ReadOnly="True" ShowInCustomizationForm="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DOCUMENTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4" ReadOnly="True" ShowInCustomizationForm="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TIPO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6" ReadOnly="True" ShowInCustomizationForm="True" Caption="TIP">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FECHA_DOCUMENTO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="7" Caption="D FECHA" Width="80px">
                            <PropertiesDateEdit DisplayFormatString="dd/MM/yy">
                            </PropertiesDateEdit>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="MONTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8" ShowInCustomizationForm="True" Visible="False">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SALDO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9" ShowInCustomizationForm="True">
                            <PropertiesTextEdit DisplayFormatString="###,###.00" >  
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NOMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="3" Width="210px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MONEDA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5" Caption="MON">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NUM" LoadReadOnlyValueFromDataModel="True" Visible="False" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <SettingsBehavior ProcessSelectionChangedOnServer="True" />
                    <Styles CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine">
                        <LoadingPanel ImageSpacing="8px">
                        </LoadingPanel>
                        <FilterCell Wrap="False">
                        </FilterCell>
                    </Styles>
                                            <Settings ShowFooter="True" />
                                            <SettingsBehavior AllowSelectSingleRowOnly="True" />
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
                    </div>
                </div>
      

                 <br />
                
                
      
    
                 <br />
    <br />
    <br />
    <br />
                
                
      
                 </asp:Content>
