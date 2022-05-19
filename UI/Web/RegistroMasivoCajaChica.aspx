<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="RegistroMasivoCajaChica.aspx.cs" Inherits="UI.Web.RegistroMasivoCajaChica" %>


<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
<%@ Register Assembly="DevExpress.XtraReports.v18.2.Web.WebForms" Namespace="DevExpress.XtraReports.Web" TagPrefix="dxxr" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function onInit(s, e) {
            //viewer.OpenReport("PivotGrid");
        }
        function onEndCallback(s, e) {
            //viewer.Close();
            //viewer.OpenReport("PivotGrid");
        }

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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="Cargador Masivo Caja Chicas"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="956px">
        <Items>
            <dx:LayoutGroup ColCount="4" ColSpan="1" ColumnCount="4" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Seleccione compañias" ColSpan="1" Name="Cia" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Cia" runat="server" DataSourceID="SQLCompania" TextField="nombre" Theme="SoftOrange" ValueField="conjunto" Width="300px">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    
                    <dx:LayoutItem Caption="Actualizar" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server" Height="32px" Native="True"  Theme="SoftOrange" Width="32px" OnClick="ASPxFormLayout_E3_Click1">
                                 <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar2.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />                               
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Limpiar Grilla" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxButton1" runat="server" Height="32px" Native="True"  Theme="SoftOrange" Width="32px" OnClick="ASPxButton1_Click" >
                                 <BackgroundImage ImageUrl="~/Imagenes/trash.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />                               
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Procesar Cajas Chica" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E2" runat="server" AutoPostBack="False" Height="32px" Width="32px" ToolTip="Procesar Cajas Chicas" OnClick="Lform_E2_Click">
                                    <BackgroundImage ImageUrl="~/Imagenes/SaveAll_32x32.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"/>
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
            FROM Pruebas.[erpadmin].[PRIVILEGIO_EX] P, Pruebas.erpadmin.conjunto C
            where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
            order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

     <br />
    <asp:SqlDataSource ID="SQLConta" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" 
        SelectCommand="SELECT C.ID,C.DEPARTAMENTO,C.CAJA_CHICA,C.CONSECUTIVO_VALE,C.FECHA_EMISION,
	                    C.FECHA_LIQUIDACION,C.CONCEPTO_VALE,C.BENEFICIARIO,C.MONTO_TOTAL_CAJA,
	                    C.MONTO_TOTAL_LOCAL,C.MONTO_TOTAL_DOLAR,C.TIPO_CAMBIO_DOLAR,C.PRESUPUESTO,
	                    D.LINEA,D.CENTRO_COSTO,D.CUENTA_CONTABLE,D.CONTRIBUYENTE,D.NRO_DOCUMENTO,
	                    D.TIPO_DOCUMENTO,D.MONTO_TOTAL_LINEA,D.CONCEPTO_LINEA_VALE,D.DETALLE,
	                    D.FECHA_LINEA_VALE,D.TIPO_IMPUESTO,D.SUB_TOTAL_LINEA,D.IMPUESTO_IVA_LINEA,
	                    D.IMPUESTO_CONSUMO_LINEA,D.TIPO_AFECTACION,D.ACTIVIDAD_COMERCIAL_LINEA,
	                    D.ACTIVIDAD_D104_LINEA
                    FROM PORTAL.dbo.CARGADOR_VALES_CAB C
                    INNER JOIN PORTAL.dbo.CARGADOR_VALES_DET D ON C.ID=D.ID_CABECERA
                    WHERE UPPER(C.USUARIO)=UPPER(@PUsuarioCia) " >
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <br />
         
     <dx:ASPxGridView ID="GridRenta" runat="server" AutoGenerateColumns="False" DataSourceID="SQLConta" ClientInstanceName="grid" >
        <Columns>
            <dx:GridViewDataTextColumn FieldName="ID" LoadReadOnlyValueFromDataModel="True" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DEPARTAMENTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CAJA_CHICA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CONSECUTIVO_VALE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_EMISION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_LIQUIDACION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CONCEPTO_VALE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="BENEFICIARIO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_TOTAL_CAJA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_TOTAL_LOCAL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_TOTAL_DOLAR" LoadReadOnlyValueFromDataModel="True" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_CAMBIO_DOLAR" LoadReadOnlyValueFromDataModel="True" VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PRESUPUESTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LINEA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CENTRO_COSTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="14">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CUENTA_CONTABLE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CONTRIBUYENTE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="16">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NRO_DOCUMENTO" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="17">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_DOCUMENTO" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="18">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_TOTAL_LINEA" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="19">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CONCEPTO_LINEA_VALE" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="20">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DETALLE" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="21">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_LINEA_VALE" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="22">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_IMPUESTO" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="23">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="SUB_TOTAL_LINEA" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="24">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="IMPUESTO_IVA_LINEA" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="25">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="IMPUESTO_CONSUMO_LINEA" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="26">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_AFECTACION" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="27">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ACTIVIDAD_COMERCIAL_LINEA" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="28">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ACTIVIDAD_D104_LINEA" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="29">
            </dx:GridViewDataTextColumn>
        </Columns>
        <Styles GroupButtonWidth="28">
            <Header ImageSpacing="5px" SortingImageSpacing="5px">
            </Header>
            <LoadingPanel ImageSpacing="8px">
            </LoadingPanel>
        </Styles>

        <SettingsPopup>
            <HeaderFilter MinHeight="140px"></HeaderFilter>
        </SettingsPopup>
        <SettingsLoadingPanel ImagePosition="Top"></SettingsLoadingPanel>
        <Paddings Padding="1px" />
        <Images SpriteCssFilePath="~/App_Themes/SoftOrange/{0}/sprite.css">
            <LoadingPanelOnStatusBar Url="~/App_Themes/SoftOrange/GridView/gvLoadingOnStatusBar.gif">
            </LoadingPanelOnStatusBar>
            <LoadingPanel Url="~/App_Themes/SoftOrange/GridView/Loading.gif">
            </LoadingPanel>
        </Images>

        <Settings ShowFilterRow="True" ShowFilterBar="Visible"></Settings>

        <StylesEditors>
            <CalendarHeader Spacing="1px">
            </CalendarHeader>
        <ProgressBar Height="29px"></ProgressBar>
        </StylesEditors>

        <SettingsEditing Mode="Inline" />
        <SettingsBehavior ConfirmDelete="True" />
    </dx:ASPxGridView>
    
    <dx:ASPxGridViewExporter ID="Exportador" runat="server" FileName="CargarRenta" GridViewID="GFile">
    </dx:ASPxGridViewExporter>
             
    <table>
        <tr>
            <td>
                Seleccione el archivo excel a cargar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" 
                    CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine" 
                    NavigateUrl="~/Plantillas/Plantilla_Carga_Masiva_Caja_Chica.xlsx" 
                    Text="Formato de ejemplo para cargar masiva Caja Chica" />
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxUploadControl ID="Upload" runat="server" Height="120px" ShowProgressPanel="True"
                    ShowUploadButton="True" Width="578px" OnFileUploadComplete="Upload_FileUploadComplete">
                    <ClientSideEvents FileUploadComplete="function(s, e) {
	                     if( e.isValid)
                            { memo.SetText(e.callbackData);
                              grid.PerformCallback();
                            }

                    }" />
                </dx:ASPxUploadControl>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxMemo ID="Memo" runat="server" CssFilePath="~/App_Themes/Red Wine/{0}/styles.css"
                    CssPostfix="RedWine" Height="100px" ReadOnly="True" Width="480px" ClientInstanceName="memo" ForeColor="#FF3300" Font-Bold="True">
                    <ValidationSettings>
                        <ErrorImage Url="~/App_Themes/Red Wine/Editors/edtError.png" />
                        <ErrorFrameStyle ImageSpacing="4px">
                            <ErrorTextPaddings PaddingLeft="4px" />
                        </ErrorFrameStyle>
                    </ValidationSettings>
                </dx:ASPxMemo>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
    </table>

</asp:Content>
