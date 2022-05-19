<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="CXP_Pagos.aspx.cs" Inherits="UI.Web.CXP_Pagos" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <script type="text/javascript">
             var command;
            var commandcbp;
        function onTextChanged(s, e) {
           
            //CBListaAbuelo.PerformCallback(CBListaAbuelo.GetText());
            //var n = CBListaAbuelo.GetText().length;
            //if (n > 4) {
            //    tbnombreabuelo.SetText(CBListaAbuelo.GetText().substring(4));
            //} else {
            //    tbnombreabuelo.SetText("");
           // }
        }

                 
        function onBeginCallback(s, e) {
            command = e.command;
        }

        function onEndCallback(s, e) {
            if (command == "") {
                s.SetText(s.cpText);
                s.cpText = null;
            }
        }

        function OnSelectedIndexChangedCallback(s, e) {
            //var n = CBListaAbuelo.GetText().length;
            // if (n > 1) {
                 tbnombreabuelo.SetText(CBListaAbuelo.GetText());
            // } else {
             //    tbnombreabuelo.SetText("");
             //}
             //CBListaPadre.PerformCallback(CBListaAbuelo.GetValue());
        }

            function onTextChangedcbp(s, e) {
               // CBListaPadre.PerformCallback(CBListaPadre.GetText());
            }

            function onBeginCallbackcbp(s, e) {
                commandcbp = e.command;
            }

            function onEndCallbackcbp(s, e) {
                if (commandcbp == "") {
                    s.SetText(s.cpTextcbp);
                    s.cpTextcbp = null;
                }
            }

            function OnSelectedIndexChangedCallbackcbp(s, e) {
                var n = CBListaPadre.GetText().length;
                if (n > 4) {
                    tbnombrepadre.SetText(CBListaPadre.GetText().substring(4));
                } else {
                    tbnombrepadre.SetText("");
                }

              }



         function OnClick(s, e, catCiaCtaID) {
             Popup.Show();
         }
         var textSeparator = ";";
         function updateText() {
             var selectedItems = checkListBox.GetSelectedItems();
             checkComboBox.SetText(getSelectedItemsText(selectedItems));
           //  checkListBoxcc.PerformCallback(getSelectedItemsText(selectedItems));
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
             //var selectedItems = checkListBoxcc.GetSelectedItems();
             //checkComboBoxcc.SetText(getSelectedItemsText(selectedItems));
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              (Pruebas) CXP Lotes Masivos"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="900px">
        <Items>
            <dx:LayoutGroup ColCount="11" ColSpan="1" ColumnCount="11" Caption="Defina Parametros" RowSpan="2">
                <Items>

                    <dx:LayoutItem Caption="Seleccione compañias" ColSpan="1" Name="CiaOrigen" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                               <dx:ASPxComboBox ID="ASPxComboBox1" runat="server" DataSourceID="SQLCompania" TextField="nombre" ValueField="conjunto">
                                    <ClientSideEvents SelectedIndexChanged="function(s, e) {
	                                              cb_cta_banc.PerformCallback(s.GetSelectedItem().value);
                                        }" />
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Cuenta Banco" ColSpan="1" Name="ctaban">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="cb_cta_banc" runat="server" DataSourceID="DS_CuentaBanco_CB" TextField="NOMBRE" ValueField="CUENTA_BANCO" ClientInstanceName="cb_cta_banc" OnCallback="cb_cta_banc_Callback">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Num Plan" ColSpan="1" Name="numplan">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="Lform_E4" runat="server" MaxLength="4">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Numero Envio" ColSpan="1" Name="numenvio">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="txtEnvio" runat="server" MaxLength="5">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Fecha Inicial" ColSpan="1" Name="FechaInicial" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="FechaInicial" runat="server"  Theme="SoftOrange" DisplayFormatString="dd/MM/yyyy" Width="90px">
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Fecha Final" ColSpan="1" Name="FechaFinal" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="FechaFinal" runat="server"  Theme="SoftOrange" DisplayFormatString="dd/MM/yyyy" Width="90px">
                                    <DateRangeSettings MaxLength="10" />
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>

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

                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E2" runat="server" AutoPostBack="False" Height="32px" Width="32px" ToolTip="Lista de Campos" Visible="False">
                                    <ClientSideEvents Click="function(s, e) {
	                                        PivotCompra.ChangeCustomizationFieldsVisibility(); return false; 
                                        }" />
                                    <BackgroundImage ImageUrl="~/Imagenes/Lista.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"/>
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Lista.png">
                        </TabImage>
                    </dx:LayoutItem>
                    
                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E7" runat="server" AutoPostBack="False" CommandName="bnewcentro" Height="32px" Width="32px" OnClick="Lform_E7_Click">
                                    <BackgroundImage ImageUrl="~/Imagenes/SaveAll_32x32.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>
        
        </Items>

    </dx:ASPxFormLayout>

    <asp:SqlDataSource ID="SQLDocumentosCxP" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" SelectCommand="PORTAL.[dbo].[PORTAL_DOCUMENTOS_CP_PAG_2]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="CBCia28" />
            <asp:SessionParameter DefaultValue="01/01/2020" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="02/03/2020" Name="Pfechafin" SessionField="ci_sfec2" />
            <asp:SessionParameter DefaultValue="1233333" Name="PCta_Banco" SessionField="CBctaban28" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_CUENTA_BANCO_LISTA2]" SelectCommandType="StoredProcedure" ID="DS_CuentaBanco_CB">
        <SelectParameters>
            <asp:SessionParameter SessionField="CBCia28" DefaultValue="CROMSA" Name="PCia1" Type="String"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" 
            SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
              FROM [erpadmin].[PRIVILEGIO_EX] P, erpadmin.conjunto C
              where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
            order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <dx:ASPxGridViewExporter ID="grid_data_exp" runat="server" FileName="Cuentas_Pagar_Sin_Aprobacion" GridViewID="GridCompras">
    </dx:ASPxGridViewExporter>

    <dx:ASPxGridView ID="GridCompras" ClientInstanceName="MasterGrid" EnableRowsCache="false"  runat="server" AutoGenerateColumns="False" DataSourceID="SQLDocumentosCxP" KeyFieldName ="KEYDOC">
        <ClientSideEvents CustomButtonClick="function(s, e) {  
                                        visibleIndex = MasterGrid.GetRowKey(e.visibleIndex);  
                                        if (e.buttonID == 'btdet1') {Popup.PerformCallback(visibleIndex); Popup.Show(); }  
                                        if (e.buttonID == 'btdet2') {Popup2.PerformCallback(visibleIndex); Popup2.Show(); }  }" />
        <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFooter="True" />
        
        <SettingsPopup>
            <HeaderFilter MinHeight="140px"></HeaderFilter>
        </SettingsPopup>

        <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ButtonRenderMode="Image" ButtonType="Image" VisibleIndex="0" SelectAllCheckboxMode="Page" ShowSelectCheckbox="True">
                    <CustomButtons>
                        <dx:GridViewCommandColumnCustomButton ID="btdet1" Text ="Detalle Cia1" Visibility="Invisible">
                            <Image IconID="richedit_editrangepermission_svg_16x16">
                            </Image>
                        </dx:GridViewCommandColumnCustomButton>
                    </CustomButtons>
                </dx:GridViewCommandColumn>
                
                <dx:GridViewDataTextColumn FieldName="CIA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PROVEEDOR" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NOMBRE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DOCUMENTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TIPO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="EMBARQUE_APROBADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="FECHA_DOCUMENTO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">  
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="FECHA" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True"  VisibleIndex="8">
                    <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">  
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CONDICION_PAGO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONEDA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="APLICACION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="10">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SALDO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="11">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONTO_LOCAL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="12">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SALDO_LOCAL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONTO_DOLAR" LoadReadOnlyValueFromDataModel="True" VisibleIndex="14">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SALDO_DOLAR" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CONTRARECIBO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SUBTIPO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TIPO_CAMBIO_MONEDA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="16">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TIPO_CAMBIO_DOLAR" LoadReadOnlyValueFromDataModel="True" VisibleIndex="17">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CHEQUE_IMPRESO" LoadReadOnlyValueFromDataModel="True" Visible="false" VisibleIndex="18">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="APROBADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="19" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SELECCIONADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="20" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CONGELADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="21" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONTO_PROV" LoadReadOnlyValueFromDataModel="True" VisibleIndex="22" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SALDO_PROV" LoadReadOnlyValueFromDataModel="True" VisibleIndex="23" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TIPO_CAMBIO_PROV" LoadReadOnlyValueFromDataModel="True" VisibleIndex="24" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SUBTOTAL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="25">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DESCUENTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="26">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IMPUESTO1" LoadReadOnlyValueFromDataModel="True" VisibleIndex="27">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IMPUESTO2" LoadReadOnlyValueFromDataModel="True" VisibleIndex="28">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RUBRO1" LoadReadOnlyValueFromDataModel="True" VisibleIndex="29">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RUBRO2" LoadReadOnlyValueFromDataModel="True" VisibleIndex="30">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="FECHA_ULT_MOD" LoadReadOnlyValueFromDataModel="True" VisibleIndex="31">
                    <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">  
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONTO_RETENCION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="32">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SALDO_RETENCION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="33">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DEPENDIENTE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="34" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ASIENTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="35">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ASIENTO_PENDIENTE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="36" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NOTAS" LoadReadOnlyValueFromDataModel="True" VisibleIndex="37">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TIPO_CAMB_ACT_LOC" LoadReadOnlyValueFromDataModel="True" VisibleIndex="38" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TIPO_CAMB_ACT_DOL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="39" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TIPO_CAMB_ACT_PROV" LoadReadOnlyValueFromDataModel="True" VisibleIndex="40" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DOCUMENTO_EMBARQUE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="41" Visible="false">
                </dx:GridViewDataTextColumn>
                
                <dx:GridViewDataTextColumn FieldName="CHEQUE_CUENTA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="44" Visible="false">
                </dx:GridViewDataTextColumn>
                
                <dx:GridViewDataTextColumn FieldName="FECHA_VENCE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="47">
                    <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">  
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="USUARIO_APROBACION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="48">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="FECHA_APROBACION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="49">
                    <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">  
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONTO_PAGO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="50">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="USUARIO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="51">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CUENTA_BANCO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="52">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CODIGO_IMPUESTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="53">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="BASE_IMPUESTO1" LoadReadOnlyValueFromDataModel="True" VisibleIndex="54">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="BASE_IMPUESTO2" LoadReadOnlyValueFromDataModel="True" VisibleIndex="55">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ACTIVIDAD_COMERCIAL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="56">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SUBTOTAL_BIENES" LoadReadOnlyValueFromDataModel="True" VisibleIndex="57" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SUBTOTAL_SERVICIOS" LoadReadOnlyValueFromDataModel="True" VisibleIndex="58" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONTO_REFERENCIA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="59" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="GENE_DOC_DETRAC" LoadReadOnlyValueFromDataModel="True" VisibleIndex="60" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PORC_DETRAC" LoadReadOnlyValueFromDataModel="True" VisibleIndex="61" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ESTADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="62" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="AD_VALOREM" LoadReadOnlyValueFromDataModel="True" VisibleIndex="63" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="VALOR_ADUANA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="64" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MONTO_NO_GRAVADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="65" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="KEYDOC" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" Visible="false" VisibleIndex="66">
                </dx:GridViewDataTextColumn>
            </Columns>
             
            <TotalSummary>
                <dx:ASPxSummaryItem DisplayFormat="#,###.00" FieldName="SALDO_DOLAR" ShowInColumn="SALDO_DOLAR" ShowInGroupFooterColumn="SALDO_DOLAR" SummaryType="Sum" ValueDisplayFormat="#,###.00" />
                <dx:ASPxSummaryItem DisplayFormat="#,###.00" FieldName="SALDO_LOCAL" ShowInColumn="SALDO_LOCAL" ShowInGroupFooterColumn="SALDO_LOCAL" SummaryType="Sum" ValueDisplayFormat="#,###.00" />
            </TotalSummary>
        </dx:ASPxGridView>
        
        <br />
        <br />
        <br />
        <br />

        <dx:ASPxPopupControl ID="Popup" runat="server" AllowDragging="True" ClientInstanceName="Popup" CloseAction="OuterMouseClick" HeaderText="Documentos Deb" Modal="true" OnWindowCallback="Popup_WindowCallback" PopupAction="None" PopupElementID="MasterGrid" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="false">
            <ContentCollection>
                <dx:PopupControlContentControl runat="server">

                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" ColCount="4" ColumnCount="4" DataSourceID="SQL_Data_CTA_Detalle1" AlignItemCaptionsInAllGroups="True" RightToLeft="False" EnableTheming="True" Theme="SoftOrange" Width="850px">
                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit">
                                </SettingsAdaptivity>
                                
                                <Items>
                                    <dx:LayoutGroup Caption="Documento Seleccionado" ColCount="4" ColSpan="4" ColumnCount="4" ColumnSpan="4" GroupBoxDecoration="HeadingLine" Width="100%">
                                        <Items>
                                            <dx:LayoutItem ColSpan="1" FieldName="CIA">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxTextBox ID="ASPxFormLayout1_E11" runat="server" Width="170px">
                                                        </dx:ASPxTextBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem ColSpan="1" FieldName="DOCUMENTO" Name ="DOCUMENTO">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxTextBox ID="ASPxFormLayout1_E12" runat="server" Width="170px" Font-Bold="True">
                                                        </dx:ASPxTextBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                    
                                            <dx:LayoutItem ColSpan="1" FieldName="FECHA">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxDateEdit ID="ASPxFormLayout1_E22" runat="server">
                                                        </dx:ASPxDateEdit>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutGroup Caption=" " ColCount="3" ColSpan="1" ColumnCount="3" GroupBoxDecoration="HeadingLine" UseDefaultPaddings="True" Width="185px">
                                                <Items>
                                                    <dx:EmptyLayoutItem ColSpan="1">
                                                    </dx:EmptyLayoutItem>
                                                    <dx:LayoutItem Caption="" ColSpan="1" Name="Aprobar" Width="16px"  HorizontalAlign ="Left">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton ID="ASPxFormLayout1_E4" runat="server" ToolTip="Aprobar Orden" AutoPostBack="False" >
                                                                    <ClientSideEvents Click="function(s, e) {
	                                                                    PDialogo.Show()}" />
                                                                    <Image Url="~/Imagenes/BOUser_16x16.png">
                                                                    </Image>
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:EmptyLayoutItem ColSpan="1">
                                                    </dx:EmptyLayoutItem>
                                                </Items>
                                            </dx:LayoutGroup>

                                            <dx:LayoutItem ColSpan="1" FieldName="PROVEEDOR">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxTextBox ID="ASPxFormLayout1_E14" runat="server" Width="170px">
                                                        </dx:ASPxTextBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem ColSpan="1" FieldName="NOMBRE">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxTextBox ID="ASPxFormLayout1_E15" runat="server" Width="170px" Font-Bold="True">
                                                        </dx:ASPxTextBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem ColSpan="1" FieldName="TIPO" Name ="TIPO">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxTextBox ID="ASPxFormLayout1_E17" runat="server" Width="70px">
                                                        </dx:ASPxTextBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem ColSpan="1" FieldName="MONEDA">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxTextBox ID="ASPxFormLayout1_E18" runat="server" Width="180px" Font-Bold="True">
                                                        </dx:ASPxTextBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem ColSpan="1" FieldName="MONTO">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxSpinEdit ID="ASPxFormLayout1_E33" runat="server" Number="0" DecimalPlaces="2" DisplayFormatString="#,###.00" HorizontalAlign="Right">
                                                        </dx:ASPxSpinEdit>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem ColSpan="1" FieldName="SALDO">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxSpinEdit ID="ASPxFormLayout1_E40" runat="server" Number="0" DisplayFormatString="#,###.00" HorizontalAlign="Right">
                                                        </dx:ASPxSpinEdit>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem ColSpan="2" ColumnSpan="2" FieldName="APLICACION">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxTextBox ID="ASPxFormLayout1_E51b" runat="server" Height="16px" Width="380px">
                                                        </dx:ASPxTextBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                        </Items>
                                        
                                        <SettingsItemCaptions Location="Top" />
                                    </dx:LayoutGroup>
                                </Items>
                                    <SettingsItemCaptions Location="Left" />
                                </dx:ASPxFormLayout>
                            </td>
                            
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                  
                    <dx:ASPxLabel ID="Pmensaje" runat="server" Font-Bold="True" Font-Size="12pt" ForeColor="Red">
                    </dx:ASPxLabel>

                    <br />
                    <div>
                        <br />
                    </div>
                    
                    <div>
                        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SQL_Data_CRE_Linea" Width="1068px" KeyFieldName ="KEYDOC">
                            <SettingsPager Mode="ShowAllRecords">
                            </SettingsPager>
                            <Settings VerticalScrollBarMode="Visible" />
                            <SettingsPopup>
                                <HeaderFilter MinHeight="140px"></HeaderFilter>
                            </SettingsPopup>
                            <Columns>
                                <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="CIA" ShowInCustomizationForm="True" VisibleIndex="1">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PROVEEDOR" ShowInCustomizationForm="True" VisibleIndex="2" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="NOMBRE" ShowInCustomizationForm="True" VisibleIndex="3" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="DOCUMENTO" ShowInCustomizationForm="True" VisibleIndex="5">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TIPO" ShowInCustomizationForm="True" VisibleIndex="6">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="FECHA" ShowInCustomizationForm="True" VisibleIndex="4">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="APLICACION" ShowInCustomizationForm="True" VisibleIndex="8">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="MONTO" ShowInCustomizationForm="True" VisibleIndex="9">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SALDO" ShowInCustomizationForm="True" VisibleIndex="10">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="MONTO_LOCAL" ShowInCustomizationForm="True" VisibleIndex="11">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SALDO_LOCAL" ShowInCustomizationForm="True" VisibleIndex="12">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="MONTO_DOLAR" ShowInCustomizationForm="True" VisibleIndex="13">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SALDO_DOLAR" ShowInCustomizationForm="True" VisibleIndex="14">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="KEYDOC" ShowInCustomizationForm="True" VisibleIndex="65" Visible="False" ReadOnly="True">
                                </dx:GridViewDataTextColumn>
                            </Columns>
                        </dx:ASPxGridView>
                    </div>
                    <div>
                        <asp:SqlDataSource ID="SQL_Data_CTA_Detalle1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" SelectCommand="PORTAL.[dbo].[PORTAL_DOCUMENTOS_CPD_Detalle]" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="cov2_cia" Type="String" />
                                <asp:SessionParameter DefaultValue="" Name="Pproveedor" SessionField="cxp12_proveedor" Type="String" />
                                <asp:SessionParameter Name="PDocumento" SessionField="cxp12_documento" Type="String" />
                                <asp:SessionParameter Name="Ptipo" SessionField="cxp12_tipo" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <dx:ASPxPivotGridExporter ID="ASPxPivotGridExp1" runat="server" ASPxPivotGridID="PivotDetalleCta1">
                        </dx:ASPxPivotGridExporter>

                        <asp:SqlDataSource ID="SQL_Data_CRE_Linea" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" SelectCommand="PORTAL.[dbo].[PORTAL_DOCUMENTOS_CPC_Detalle]" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="cov2_cia" Type="String" />
                                <asp:SessionParameter DefaultValue="" Name="Pproveedor" SessionField="cxp12_proveedor" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        <br />
                        <br />
                        <br />
                    </div>
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>

        <dx:ASPxPopupControl ID="PDialogo" runat="server" Height="130px" Width="363px" HeaderText="Confirmación"  ClientInstanceName="PDialogo" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
            <SettingsAdaptivity VerticalAlign="WindowCenter" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <table style="width:100%;">
                            <tr>
                                <td class="auto-style8">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style8"></td>
                                <td class="auto-style3" colspan="3">
                                    <dx:ASPxLabel ID="LabelMensaje" runat="server" Font-Bold="True" Text="Esta seguro que desea aplicar el documento?" style="margin-left: 7px" Width="300px">
                                        <DisabledStyle Font-Bold="True">
                                        </DisabledStyle>
                                    </dx:ASPxLabel>
                                </td>
                                <td class="auto-style3">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style8">&nbsp;</td>
                                <td class="auto-style3">&nbsp;
                                    <br />
                                    &nbsp;</td>
                                <td class="auto-style3"></td>
                                <td class="auto-style3"></td>
                                <td class="auto-style3"></td>
                            </tr>
                            <tr>
                                <td class="auto-style9">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
                                <td class="progress-xxlarge">
                                    <dx:ASPxButton ID="BTAceptar" runat="server" OnClick="BTAceptar_Click" Text="Aceptar" Width="80px">
                                        <ClientSideEvents Click="function(s, e) { PDialogo.Hide(); }" />
                                        <Image IconID="businessobjects_bo_validation_svg_16x16">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td class="progress-xxlarge"></td>
                                <td class="progress-xxlarge">
                                    <dx:ASPxButton ID="BTCancelar" runat="server" Text="Cancelar">
                                        <ClientSideEvents Click="function(s, e) { PDialogo.Hide(); }" />
                                        <Image Width="80px" IconID="iconbuilder_actions_delete_svg_16x16">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td class="progress-xxlarge"></td>
                            </tr>
                            <tr>
                                <td class="auto-style8">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>


            <dx:ASPxPopupControl ID="PDialogo2" runat="server" Height="130px" Width="363px" HeaderText="Confirmación"  ClientInstanceName="PDialogo2" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
                <SettingsAdaptivity VerticalAlign="WindowCenter" />
                    <ContentCollection>
                        <dx:PopupControlContentControl runat="server">
                            <table style="width:100%;">
                                <tr>
                                    <td class="auto-style10">&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style10"></td>
                                    <td class="auto-style3" colspan="3">
                                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Font-Bold="True" Text="Esta seguro que desea aprobar la orden de compra?" style="margin-left: 7px" Width="300px">
                                            <DisabledStyle Font-Bold="True">
                                            </DisabledStyle>
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="auto-style3">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style10"></td>
                                    <td class="auto-style3">&nbsp;
                                        <br />
                                        &nbsp;</td>
                                    <td class="auto-style3"></td>
                                    <td class="auto-style3"></td>
                                    <td class="auto-style3"></td>
                                </tr>
                                <tr>
                                    <td class="auto-style11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
                                    <td class="progress-xxlarge">
                                        <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Aceptar" Width="80px" OnClick="ASPxButton2_Click1">
                                            <ClientSideEvents Click="function(s, e) { PDialogo2.Hide(); }" />
                                            <Image IconID="businessobjects_bo_validation_svg_16x16">
                                            </Image>
                                        </dx:ASPxButton>
                                    </td>
                                    <td class="progress-xxlarge"></td>
                                    <td class="progress-xxlarge">
                                        <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Cancelar">
                                            <ClientSideEvents Click="function(s, e) { PDialogo2.Hide(); }" />
                                            <Image Width="80px" IconID="iconbuilder_actions_delete_svg_16x16">
                                            </Image>
                                        </dx:ASPxButton>
                                    </td>
                                    <td class="progress-xxlarge"></td>
                                </tr>
                                <tr>
                                    <td class="auto-style10">&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                            </table>
                        </dx:PopupControlContentControl>
                    </ContentCollection>
                </dx:ASPxPopupControl>


                <dx:ASPxPopupControl ID="ASPxPopupControl3" runat="server" Height="130px" Width="363px" HeaderText="Confirmación"  ClientInstanceName="PDialogo3" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
                        <SettingsAdaptivity VerticalAlign="WindowCenter" />
                        <ContentCollection>
                            <dx:PopupControlContentControl runat="server">
                                <table style="width:100%;">
                                    <tr>
                                        <td class="auto-style10">&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style10"></td>
                                        <td class="auto-style3" colspan="3">
                                            <dx:ASPxLabel ID="ASPxLabel3" runat="server" Font-Bold="True" Text="Esta seguro de reversar la orden de compra?" style="margin-left: 7px" Width="300px">
                                                <DisabledStyle Font-Bold="True">
                                                </DisabledStyle>
                                            </dx:ASPxLabel>
                                        </td>
                                        <td class="auto-style3">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style10"></td>
                                        <td class="auto-style3">&nbsp;
                                            <br />
                                            &nbsp;</td>
                                        <td class="auto-style3"></td>
                                        <td class="auto-style3"></td>
                                        <td class="auto-style3"></td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
                                        <td class="progress-xxlarge">
                                            <dx:ASPxButton ID="ASPxButton4" runat="server" Text="Aceptar" Width="80px" OnClick="ASPxButton4_Click">
                                                <ClientSideEvents Click="function(s, e) { PDialogo3.Hide(); }" />
                                                <Image IconID="businessobjects_bo_validation_svg_16x16">
                                                </Image>
                                            </dx:ASPxButton>
                                        </td>
                                        <td class="progress-xxlarge"></td>
                                        <td class="progress-xxlarge">
                                            <dx:ASPxButton ID="ASPxButton5" runat="server" Text="Cancelar">
                                                <ClientSideEvents Click="function(s, e) { PDialogo3.Hide(); }" />
                                                <Image Width="80px" IconID="iconbuilder_actions_delete_svg_16x16">
                                                </Image>
                                            </dx:ASPxButton>
                                        </td>
                                        <td class="progress-xxlarge"></td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style10">&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                </table>
                            </dx:PopupControlContentControl>
                        </ContentCollection>
                </dx:ASPxPopupControl>

                <dx:ASPxPopupControl ID="ASPxPopupControlTEF" runat="server" AllowDragging="True" ClientInstanceName="Popuptef" CloseAction="OuterMouseClick" HeaderText="Crear nuevo documento TEF" Modal="true" OnWindowCallback="Popup_WindowCallback" PopupAction="None" PopupElementID="MasterGrid" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="false" Width="621px">
                    <ContentCollection>
                        <dx:PopupControlContentControl runat="server">
                            <table style="width: 100%;">
                                <tr>
                                    <td class="auto-style2" colspan="3">Proveedor</td>
                                    <td class="auto-style1">Descripción</td>
                                </tr>
                                <tr>
                                    <td class="auto-style2" colspan="3">
                                        <dx:ASPxComboBox ID="CBListaAbuelo" runat="server" DataSourceID="DS_Proveedor" TextField="NOMBRE" ValueField="PROVEEDOR" OnCallback="CBListaAbuelo_Callback" ClientInstanceName="CBListaAbuelo"  DropDownStyle="DropDown">
                                            <ClientSideEvents TextChanged="onTextChanged" BeginCallback="onBeginCallback" EndCallback="onEndCallback" SelectedIndexChanged="OnSelectedIndexChangedCallback"/>
                                        </dx:ASPxComboBox>
                                    </td>
                                    <td class="auto-style1">
                                        <dx:ASPxTextBox ID="tbnombreabuelo" runat="server" Width="170px" ClientInstanceName="tbnombreabuelo">
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style3" colspan="3">Moneda</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style3" colspan="3">
                                        <dx:ASPxComboBox ID="CBListaPadre" runat="server" DataSourceID="DS_CentrosCostoLista2" TextField="DESC_CENTRO_COSTO" ValueField="CENTRO_COSTO" ClientInstanceName="CBListaPadre" OnCallback="CBListaPadre_Callback" DropDownStyle="DropDown">
                                            <ClientSideEvents TextChanged="onTextChangedcbp" BeginCallback="onBeginCallbackcbp" EndCallback="onEndCallbackcbp" SelectedIndexChanged="OnSelectedIndexChangedCallbackcbp"/>
                                        </dx:ASPxComboBox>
                                    </td>
                                    <td>
                                        <dx:ASPxTextBox ID="tbnombrepadre" runat="server" Width="170px" ClientInstanceName="tbnombrepadre">
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style3" colspan="3">Numero</td>
                                    <td>Aplicación</td>
                                </tr>
                                <tr>
                                    <td class="auto-style3" colspan="3">
                                        <dx:ASPxTextBox ID="tbcentrocostohijo" runat="server" Width="170px">
                                        </dx:ASPxTextBox>
                                    </td>
                                    <td>
                                        <dx:ASPxTextBox ID="tbnombrehijo" runat="server" Width="170px">
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2" colspan="3">Monto</td>
                                    <td class="auto-style1">Cuenta Bancaria del Debito</td>
                                </tr>
                                <tr>
                                    <td class="auto-style2" colspan="3">
                                        <dx:ASPxTextBox ID="tbcentrocostohijo0" runat="server" Width="170px">
                                        </dx:ASPxTextBox>
                                    </td>
                                    <td class="auto-style1">
                                        <dx:ASPxComboBox ID="CBCuentaBanco" runat="server" ClientInstanceName="CBListaAbuelo" DropDownStyle="DropDown" OnCallback="CBListaAbuelo_Callback" DataSourceID="DS_CuentaBanco" TextField="NOMBRE" ValueField="CUENTA_BANCO">
                                            <ClientSideEvents/>
                                        </dx:ASPxComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2" colspan="3">&nbsp;</td>
                                    <td class="auto-style1">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">&nbsp; </td>
                                    <td class="auto-style4">
                                        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Aceptar" AutoPostBack="False">
                                            <ClientSideEvents Click="function(s, e) { PDialogo2.Show(); }" />
                                        </dx:ASPxButton>
                                    </td>
                                    <td class="auto-style1">&nbsp;</td>
                                    <td class="auto-style1">
                                        <dx:ASPxButton ID="BotonCerrarCc" runat="server" Text="Cancelar" AutoPostBack="False" ClientInstanceName="botonCerrarCC">
                                            <ClientSideEvents Click="function(s, e) { Popup.Hide(); }" />
                                        </dx:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <div>
                                <dx:ASPxLabel ID="ASPxLabel2" runat="server">
                                </dx:ASPxLabel>
                                <br />
                            </div>
                            <div>

                                <asp:SqlDataSource ID="DS_Proveedor" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_PROVEEDOR_CB_LISTA1]" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCia24" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="DS_CentrosCostoLista2" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="System.Data.SqlClient" SelectCommand="portal.[dbo].[PORTAL_CENTROSCOSTOS_CB_LISTA2]" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCia24" Type="String" />
                                        <asp:SessionParameter DefaultValue="059" Name="PAbuelo" SessionField="PAbuelo24" Type="String" />
                                        <asp:SessionParameter DefaultValue="000" Name="PAdicional" SessionField="PAdicional242" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="DS_CuentaBanco" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_CUENTA_BANCO_LISTA1]" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCia24" Type="String" />
                                        <asp:SessionParameter DefaultValue="USD" Name="MONEDA" SessionField="PMoneda" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                            
                            <div>
                                <br />
                            </div>
                        </dx:PopupControlContentControl>
                    </ContentCollection>
                </dx:ASPxPopupControl>
    
    <dx:ASPxPopupControl ID="PValidacion" runat="server" Height="130px" Width="363px" HeaderText="Mensaje"  ClientInstanceName="PValidacion" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
        <SettingsAdaptivity VerticalAlign="WindowCenter" />
        <ContentCollection>
        <dx:PopupControlContentControl runat="server">
            <table style="width:100%;">
                <tr>
                    <td class="auto-style8">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8"></td>
                    <td class="auto-style3" colspan="3">
                        <dx:ASPxLabel ID="lblMensaje" runat="server" Font-Bold="True" Text="No se muestran resultados porque no se ha seleccionado Usuario o Departamento." style="margin-left: 7px" Width="300px">
                            <DisabledStyle Font-Bold="True">
                            </DisabledStyle>
                        </dx:ASPxLabel>
                    </td>
                    <td class="auto-style3">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                </tr>
                <tr>
                    <td class="auto-style9"></td>
                    <td class="progress-xxlarge">

                    </td>
                    <td class="progress-xxlarge"></td>
                    <td class="progress-xxlarge">
                        <dx:ASPxButton ID="ASPxButton6" runat="server" Text="Aceptar">
                            <ClientSideEvents Click="function(s, e) { PValidacion.Hide(); }" />
                            <Image Width="80px" IconID="iconbuilder_actions_delete_svg_16x16">
                            </Image>
                        </dx:ASPxButton>
                    </td>
                    <td class="progress-xxlarge"></td>
                </tr>
                <tr>    
                    <td class="auto-style8">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

</asp:Content>
