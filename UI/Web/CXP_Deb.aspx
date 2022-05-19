<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="CXP_Deb.aspx.cs" Inherits="UI.Web.CXP_Deb" %>
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
            var n = CBListaAbuelo.GetText().length;
             if (n > 1) {
                 tbnombreabuelo.SetText(CBListaAbuelo.GetText());
                 ASPxGridViewCre.PerformCallback(CBciatef.GetValue() + ";" + CBListaAbuelo.GetValue());
             } else {
                tbnombreabuelo.SetText("");
             }
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
                var n = CBListaMoneda.GetText().length;
                if (n > 1) {
                    CBCuentaBanco.PerformCallback(CBciatef.GetValue() + ";" + CBListaMoneda.GetText());
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              (Pruebas) Aplicación Documentos"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="900px">
        <Items>
            <dx:LayoutGroup ColCount="11" ColSpan="1" ColumnCount="11" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Seleccione compañias" ColSpan="1" Name="CiaOrigen" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                               <dx:ASPxDropDownEdit ClientInstanceName="checkComboBox" ID="ASPxDropDownEdit1" Width="285px" runat="server" AnimationType="None" Theme="SoftOrange">
                                   <DropDownWindowStyle BackColor="#EDEDED" />
                                       <DropDownWindowTemplate>
                                       <dx:ASPxListBox Width="100%" ID="listBox" ClientInstanceName="checkListBox" SelectionMode="CheckColumn"
                                           runat="server" Height="200" EnableSelectAll="true" DataSourceID="SQLCompania" TextField="nombre" ValueField="conjunto">
                                          <FilteringSettings ShowSearchUI="true"/>
                                          <Border BorderStyle="None" />
                                          <BorderBottom BorderStyle="Solid" BorderWidth="1px" BorderColor="#DCDCDC" />
                <ClientSideEvents SelectedIndexChanged="updateText" Init="updateText" />
            </dx:ASPxListBox>
            <table style="width: 100%">
                <tr>
                    <td style="padding: 4px">
                        <dx:ASPxButton ID="ASPxButton1" AutoPostBack="False" runat="server" Text="Close" style="float: right">
                            <ClientSideEvents Click="function(s, e){ checkComboBox.HideDropDown(); }" />
                        </dx:ASPxButton>
                    </td>
                </tr>
            </table>
        </DropDownWindowTemplate>
        <ClientSideEvents TextChanged="synchronizeListBoxValues" DropDown="synchronizeListBoxValues" />
    </dx:ASPxDropDownEdit>                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Fecha Inicial          " ColSpan="1" Name="FechaInicial" Width="60px">
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
                                <dx:ASPxButton ID="Lform_E2" runat="server" AutoPostBack="False" Height="32px" Width="32px" ToolTip="Lista de Campos">
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
                            <dx:EmptyLayoutItem ColSpan="1">
                    </dx:EmptyLayoutItem>
                    <dx:EmptyLayoutItem ColSpan="1">
                    </dx:EmptyLayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E7" runat="server" AutoPostBack="False" CommandName="bnewcentro" Height="32px" Width="32px">
                                    <ClientSideEvents Click="function(s, e) {
  Popuptef.Show();
}" />
                                    <BackgroundImage ImageUrl="~/Imagenes/AddFile_32x32.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLDocumentosCxP" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" SelectCommand="PORTAL.[dbo].[PORTAL_DOCUMENTOS_CPD]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="01/01/2020" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="02/03/2020" Name="Pfechafin" SessionField="ci_sfec2" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM [erpadmin].[PRIVILEGIO_EX] P, erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep
" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
        <dx:ASPxGridView ID="GridCompras" ClientInstanceName="MasterGrid"  runat="server" AutoGenerateColumns="False" DataSourceID="SQLDocumentosCxP" KeyFieldName ="KEYDOC">
                    <ClientSideEvents CustomButtonClick="function(s, e) {  visibleIndex = MasterGrid.GetRowKey(e.visibleIndex);  if (e.buttonID == 'btdet1') {Popup.PerformCallback(visibleIndex); Popup.Show(); }  
          if (e.buttonID == 'btdet2') {Popup2.PerformCallback(visibleIndex); Popup2.Show(); }  }" />
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />

<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>

            <SettingsSearchPanel Visible="True" />
                    <Columns>
                <dx:GridViewCommandColumn ButtonRenderMode="Image" ButtonType="Image" VisibleIndex="0">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btdet1" Text ="Detalle Cia1">
                        <Image IconID="richedit_editrangepermission_svg_16x16">
                        </Image>
                    </dx:GridViewCommandColumnCustomButton>
                </CustomButtons>
            </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="CIA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PROVEEDOR" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NOMBRE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DOCUMENTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TIPO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="EMBARQUE_APROBADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FECHA_DOCUMENTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataDateColumn FieldName="FECHA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="7">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="APLICACION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MONTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SALDO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="10">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MONTO_LOCAL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="11">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SALDO_LOCAL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="12">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MONTO_DOLAR" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SALDO_DOLAR" LoadReadOnlyValueFromDataModel="True" VisibleIndex="14">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TIPO_CAMBIO_MONEDA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TIPO_CAMBIO_DOLAR" LoadReadOnlyValueFromDataModel="True" VisibleIndex="16">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CHEQUE_IMPRESO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="17">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="APROBADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="18">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SELECCIONADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="19">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CONGELADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="20">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MONTO_PROV" LoadReadOnlyValueFromDataModel="True" VisibleIndex="21">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SALDO_PROV" LoadReadOnlyValueFromDataModel="True" VisibleIndex="22">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TIPO_CAMBIO_PROV" LoadReadOnlyValueFromDataModel="True" VisibleIndex="23">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SUBTOTAL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="24">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DESCUENTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IMPUESTO1" LoadReadOnlyValueFromDataModel="True" VisibleIndex="26">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IMPUESTO2" LoadReadOnlyValueFromDataModel="True" VisibleIndex="27">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="RUBRO1" LoadReadOnlyValueFromDataModel="True" VisibleIndex="28">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="RUBRO2" LoadReadOnlyValueFromDataModel="True" VisibleIndex="29">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FECHA_ULT_MOD" LoadReadOnlyValueFromDataModel="True" VisibleIndex="30">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="MONTO_RETENCION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="31">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SALDO_RETENCION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="32">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DEPENDIENTE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="33">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ASIENTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="34">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ASIENTO_PENDIENTE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="35">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NOTAS" LoadReadOnlyValueFromDataModel="True" VisibleIndex="36">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TIPO_CAMB_ACT_LOC" LoadReadOnlyValueFromDataModel="True" VisibleIndex="37">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TIPO_CAMB_ACT_DOL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="38">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TIPO_CAMB_ACT_PROV" LoadReadOnlyValueFromDataModel="True" VisibleIndex="39">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DOCUMENTO_EMBARQUE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="40">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CONDICION_PAGO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="41">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MONEDA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="42">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CHEQUE_CUENTA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="43">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CONTRARECIBO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="44">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SUBTIPO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="45">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FECHA_VENCE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="46">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="USUARIO_APROBACION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="47">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FECHA_APROBACION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="48">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="MONTO_PAGO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="49">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="USUARIO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="50">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CUENTA_BANCO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="51">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CODIGO_IMPUESTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="52">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="BASE_IMPUESTO1" LoadReadOnlyValueFromDataModel="True" VisibleIndex="53">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="BASE_IMPUESTO2" LoadReadOnlyValueFromDataModel="True" VisibleIndex="54">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ACTIVIDAD_COMERCIAL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="55">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SUBTOTAL_BIENES" LoadReadOnlyValueFromDataModel="True" VisibleIndex="56">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SUBTOTAL_SERVICIOS" LoadReadOnlyValueFromDataModel="True" VisibleIndex="57">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MONTO_REFERENCIA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="58">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="GENE_DOC_DETRAC" LoadReadOnlyValueFromDataModel="True" VisibleIndex="59">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PORC_DETRAC" LoadReadOnlyValueFromDataModel="True" VisibleIndex="60">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ESTADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="61">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="AD_VALOREM" LoadReadOnlyValueFromDataModel="True" VisibleIndex="62">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="VALOR_ADUANA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="63">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MONTO_NO_GRAVADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="64">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="KEYDOC" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="65">
                        </dx:GridViewDataTextColumn>
                    </Columns>
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
                            <td><dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" ColCount="4" ColumnCount="4" DataSourceID="SQL_Data_CTA_Detalle1" AlignItemCaptionsInAllGroups="True" RightToLeft="False" EnableTheming="True" Theme="SoftOrange" Width="850px">
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
                                                        <dx:ASPxButton ID="ASPxFormLayout1_E4" runat="server" ToolTip="Aplicación de documentos" AutoPostBack="False" >
                                                            <ClientSideEvents Click="function(s, e) {
	PDialogo.Show();
	
}" />
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
                                    <dx:LayoutItem ColSpan="1" Name ="PTIPO_CAMBIO" Caption ="TIPO CAMBIO APLICACIÓN" CaptionStyle-ForeColor="Black" Border-BorderColor="#3366FF" Border-BorderStyle="Solid">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxSpinEdit ID="ASPxSpinEdit1" runat="server" Number="0" DisplayFormatString="#,###.00" HorizontalAlign="Right">
                                                </dx:ASPxSpinEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>

<Border BorderColor="#3366FF" BorderStyle="Solid"></Border>

<CaptionStyle ForeColor="Black"></CaptionStyle>
                                    </dx:LayoutItem>

                                    <dx:LayoutItem ColSpan="1" ColumnSpan="1" FieldName="APLICACION">
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
                    </dx:ASPxFormLayout></td>
                            <td>    &nbsp;</td>
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
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SALDO" ShowInCustomizationForm="True" VisibleIndex="10">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="MONTO_LOCAL" ShowInCustomizationForm="True" VisibleIndex="11">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SALDO_LOCAL" ShowInCustomizationForm="True" VisibleIndex="12">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="MONTO_DOLAR" ShowInCustomizationForm="True" VisibleIndex="13">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SALDO_DOLAR" ShowInCustomizationForm="True" VisibleIndex="14">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
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
                    <ClientSideEvents Click="function(s, e) {
	PDialogo.Hide();
}" />
                    <Image IconID="businessobjects_bo_validation_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="BTCancelar" runat="server" Text="Cancelar">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo.Hide();
}" />
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
                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Font-Bold="True" Text="Esta seguro que desea generar el documento TEF?" style="margin-left: 7px" Width="300px">
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
                    <ClientSideEvents Click="function(s, e) {
	PDialogo2.Hide();
}" />
                    <Image IconID="businessobjects_bo_validation_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Cancelar">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo2.Hide();
}" />
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
                    <ClientSideEvents Click="function(s, e) {
	PDialogo3.Hide();
}" />
                    <Image IconID="businessobjects_bo_validation_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="ASPxButton5" runat="server" Text="Cancelar">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo3.Hide();
}" />
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
                            <td class="auto-style2" colspan="3">
                                

                                Compañia</td>
                            <td class="auto-style1">  


                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style2" colspan="4">
                                <dx:ASPxComboBox ID="CBCia_TEF" runat="server" ClientInstanceName="CBciatef" DataSourceID="SQLCompania_TEF" DropDownStyle="DropDown" OnCallback="CBListaAbuelo_Callback" TextField="nombre" ValueField="conjunto" Width="400px">
                                    <ClientSideEvents SelectedIndexChanged="function(s, e) {
  CBListaAbuelo.PerformCallback(CBciatef.GetValue());

}" />
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2" colspan="3">Proveedor</td>
                            <td class="auto-style1">Descripción</td>
                        </tr>
                        <tr>
                            <td class="auto-style2" colspan="3">
                                <dx:ASPxComboBox ID="CBListaAbuelo" runat="server" DataSourceID="DS_Proveedor" TextField="NOMBRE" ValueField="PROVEEDOR" OnCallback="CBListaAbuelo_Callback" ClientInstanceName="CBListaAbuelo"  DropDownStyle="DropDown">
                                    <ClientSideEvents SelectedIndexChanged="OnSelectedIndexChangedCallback"/>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="auto-style1">
                                <dx:ASPxTextBox ID="tbnombreabuelo" runat="server" Width="300px" ClientInstanceName="tbnombreabuelo">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style3" colspan="3">Moneda</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style3" colspan="3">
                                <dx:ASPxComboBox ID="CBListaMoneda" runat="server" DataSourceID="DS_Monedas" TextField="MONEDA" ValueField="MONEDA" ClientInstanceName="CBListaMoneda" OnCallback="CBListaPadre_Callback" DropDownStyle="DropDown">
                                    <ClientSideEvents SelectedIndexChanged="OnSelectedIndexChangedCallbackcbp"/>
                                </dx:ASPxComboBox>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style3" colspan="3">Numero</td>
                            <td>Aplicación</td>
                        </tr>
                        <tr>
                            <td class="auto-style3" colspan="3">
                                <dx:ASPxTextBox ID="tbnumero" runat="server" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="tbaplicacion" runat="server" Width="300px">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2" colspan="3">Monto</td>
                            <td class="auto-style1">Cuenta Bancaria del Debito</td>
                        </tr>
                        <tr>
                            <td class="auto-style2" colspan="3">
                                <dx:ASPxTextBox ID="tbmonto" runat="server" Width="170px">
                                    <MaskSettings Mask="&lt;0..10000000&gt;" />
                                </dx:ASPxTextBox>
                            </td>
                            <td class="auto-style1">
                                <dx:ASPxComboBox ID="CBCuentaBanco" runat="server" ClientInstanceName="CBCuentaBanco" DropDownStyle="DropDown" OnCallback="CBCuentaBanco_Callback" DataSourceID="DS_CuentaBanco" TextField="NOMBRE" ValueField="CUENTA_BANCO" Width="300px">
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
                                    <ClientSideEvents Click="function(s, e) {
	PDialogo2.Show();
}" />
                                </dx:ASPxButton>
                            </td>
                            <td class="auto-style1">&nbsp;</td>
                            <td class="auto-style1">
                                <dx:ASPxButton ID="BotonCerrarCc" runat="server" Text="Cancelar" AutoPostBack="False" ClientInstanceName="botonCerrarCC">
                                    <ClientSideEvents Click="function(s, e) {
	Popuptef.Hide();
}" />
                                </dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
    <br />
                    <div>
                        <dx:ASPxLabel ID="ASPxLabel2" runat="server">
                        </dx:ASPxLabel>
                        &nbsp;<dx:ASPxLabel ID="PmensajeTEF" runat="server" Font-Bold="True" Font-Size="12pt" ForeColor="Red">
                        </dx:ASPxLabel>
                        <br />

                     </div>
                    <div>

                        <asp:SqlDataSource ID="DS_Proveedor" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_PROVEEDOR_CB_LISTA1]" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCiatef" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="DS_Monedas" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebasPortal %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebasPortal.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_MONEDAS]" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCiatef" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:SqlDataSource ID="DS_CuentaBanco" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_CUENTA_BANCO_LISTA1]" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCiatef" Type="String" />
                                <asp:SessionParameter DefaultValue="USD" Name="MONEDA" SessionField="PMoneda" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:SqlDataSource ID="SQLCompania_TEF" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM [erpadmin].[PRIVILEGIO_EX] P, erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="PortalRep
" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <br />
                        <asp:SqlDataSource ID="SQL_Data_CRE_Linea_2" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" SelectCommand="PORTAL.[dbo].[PORTAL_DOCUMENTOS_CPC_Detalle]" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCiatef" Type="String" />
                                <asp:SessionParameter DefaultValue="" Name="Pproveedor" SessionField="cxp12_proveedord" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <dx:ASPxGridView ID="ASPxGridViewCre" runat="server" AutoGenerateColumns="False" ClientInstanceName="ASPxGridViewCre" DataSourceID="SQL_Data_CRE_Linea_2" KeyFieldName="KEYDOC" OnCustomCallback="ASPxGridViewCre_CustomCallback" Width="1068px">
                            <SettingsPager Mode="ShowAllRecords">
                            </SettingsPager>
                            <Settings VerticalScrollBarMode="Visible" />
                            <SettingsPopup>
                                <HeaderFilter MinHeight="140px">
                                </HeaderFilter>
                            </SettingsPopup>
                            <Columns>
                                <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="CIA" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="1">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PROVEEDOR" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="2">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="NOMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="3">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="DOCUMENTO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="5">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TIPO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="6">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="FECHA" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="4">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="APLICACION" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="8">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="MONTO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="9">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SALDO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="10">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="MONTO_LOCAL" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="11">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SALDO_LOCAL" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="12">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="MONTO_DOLAR" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="13">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SALDO_DOLAR" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="14">
                                  <PropertiesTextEdit DisplayFormatString="#,###.00">
                                  </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="KEYDOC" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="65">
                                </dx:GridViewDataTextColumn>
                            </Columns>
                            <TotalSummary>
                                <dx:ASPxSummaryItem DisplayFormat="#,###.00" FieldName="MONTO_DOLAR" ShowInColumn="MONTO_DOLAR" SummaryType="Sum" ValueDisplayFormat="#,###.00" />
                                <dx:ASPxSummaryItem DisplayFormat="#,###.00" FieldName="MONTO_LOCAL" ShowInColumn="MONTO_LOCAL" SummaryType="Sum" ValueDisplayFormat="#,###.00" />
                            </TotalSummary>
                        </dx:ASPxGridView>
                        <br />
                        <br />

                    </div>
                    <div>
                        <br />
                    </div>
                </dx:PopupControlContentControl>


</ContentCollection>
                </dx:ASPxPopupControl>



             </asp:Content>
