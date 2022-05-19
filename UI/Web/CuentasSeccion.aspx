<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="CuentasSeccion.aspx.cs" Inherits="UI.Web.CuentasSeccion" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .auto-style3 {
            width: 128px;
        }
        .auto-style4 {
            height: 157px;
        }
        </style>
       <script type="text/javascript">
             var command;
             var commandcbp;



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
             if (n > 4) {
                 tbnombreabuelo.SetText(CBListaAbuelo.GetText().substring(4));
             } else {
                 tbnombreabuelo.SetText("");
             }
             CBListaPadre.PerformCallback(CBListaAbuelo.GetValue());
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



        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <input runat="server" id="ColumnIndex" type="hidden" enableviewstate="true" />
    <input runat="server" id="RowIndex" type="hidden" enableviewstate="true" />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="             Actualización UDF Cuenta Contable"></asp:Label>
    &nbsp;<br />
    <br />
        <table style="width: 496px">
          <tr>
            <td class="auto-style4"> <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="829px" style="margin-top: 0px">
        <Items>
            <dx:LayoutGroup ColCount="5" ColSpan="1" ColumnCount="5" Caption="Defina Parametros" RowSpan="2">
                <Items>
                     <dx:LayoutItem Caption="Seleccione compañia" ColSpan="1" Name="CiaOrigen" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                               <dx:ASPxComboBox ID="CiaOri" runat="server" DataSourceID="SQLCompania" TextField="nombre" Theme="SoftOrange" ValueField="conjunto" Width="203px">
                                </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
          </LayoutItemNestedControlCollection>
                <CaptionSettings Location="Top" />
         </dx:LayoutItem>
                    <dx:LayoutItem Caption="Rango de Cuenta Inicial" ColSpan="1" Name="TXCuentaIni" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="Lform_E5" runat="server">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Rango de Cuenta Final" ColSpan="1"  Name="TXCuentaFin" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="Lform_E6" runat="server">
                                </dx:ASPxTextBox>
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
                                <dx:ASPxButton ID="Lform_E1" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_ClickExc" Theme="SoftOrange" Width="32px" ToolTip="Exportar Excel">
                                   <BackgroundImage ImageUrl="~/Imagenes/Excel.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout></td>
            <td class="auto-style4"> <dx:ASPxFormLayout ID="ASPxFormLayoutGuardar" runat="server" Height="91px" Theme="SoftOrange" Width="472px" style="margin-top: 0px">
            <Items>
                                     <dx:LayoutGroup Caption="Actualización de UDF por lotes" ColCount="4" ColSpan="1" ColumnCount="4">
                                         <Items>
                                             <dx:LayoutItem Caption="Seleccione UDF" ColSpan="1" name= "lista_udf">
                                                 <LayoutItemNestedControlCollection>
                                                     <dx:LayoutItemNestedControlContainer runat="server">
                                                         <dx:ASPxComboBox ID="Lform_E3" runat="server" DataSourceID="DS_LISTA_UDF" TextField="DESC_UDF" ValueField="COD_UDF">
                                                             <ClientSideEvents SelectedIndexChanged="function(s, e) {
       var id = s.GetSelectedItem().value;
       var substr = id.substring(0,1);
   var substr2 = id.substring(2,id.length);
  
	cb_lista_det.PerformCallback(substr2);
    if ((substr ==&nbsp;&quot;L&quot;)) {
            cb_lista_det.SetVisible(true);
            tx_data_udf.SetVisible(false);          }
    else {
            cb_lista_det.SetVisible(false);
            tx_data_udf.SetVisible(true);}
        
}" />
                                                         </dx:ASPxComboBox>
                                                     </dx:LayoutItemNestedControlContainer>
                                                 </LayoutItemNestedControlCollection>
                                                 <CaptionSettings Location="Top" />
                                             </dx:LayoutItem>
                                             <dx:LayoutItem Caption="  " ColSpan="1" HorizontalAlign="Right" Name="DataUdf">
                                               <ParentContainerStyle>
                                                  <Paddings PaddingLeft="0" PaddingRight="0" />
                                               </ParentContainerStyle>
                                                 <LayoutItemNestedControlCollection>
                                                     <dx:LayoutItemNestedControlContainer runat="server">
                                                         <dx:ASPxTextBox ID="Lform_E7" runat="server" ClientInstanceName="tx_data_udf" Paddings-Padding="0" ClientVisible="false" Height="18px" Name="tx_data_udf">
<Paddings Padding="0px"></Paddings>
                                                         </dx:ASPxTextBox>
                                                         <dx:ASPxComboBox ID="Lform_E8" runat="server" ClientInstanceName="cb_lista_det" Paddings-Padding="0" DataSourceID="DS_LISTA_UDF_DET" OnCallback="Lform_E8_Callback" TextField="DESC_UDF" ValueField="CODIGO" ClientVisible="false" Height="18px"  Name="cb_lista_det">
<Paddings Padding="0px"></Paddings>
                                                         </dx:ASPxComboBox>
                                                     </dx:LayoutItemNestedControlContainer>
                                                 </LayoutItemNestedControlCollection>
                                                 <CaptionSettings Location="Top" />
                                             </dx:LayoutItem>

                                            <dx:LayoutItem Caption="" ColSpan="1" Name="Aprobar" Width="16px"  HorizontalAlign ="Left">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton ID="ASPxFormLayout1_E4" runat="server" ToolTip="Actualizar UDF en Batch" AutoPostBack="False" >
                                                            <ClientSideEvents Click="function(s, e) {
	PDialogo.Show();
	
}" />
                                                            <Image Url="~/Imagenes/BOUser_16x16.png">
                                                            </Image>
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                         </Items>
                                     </dx:LayoutGroup>

            </Items>
        </dx:ASPxFormLayout></td>
          </tr>
        </table>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM [erpadmin].[PRIVILEGIO_EX] P, erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

                <asp:SqlDataSource ID="DS_AGRUP_EEFF" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_CUENTA_CONTABLE_UDF]" SelectCommandType="StoredProcedure" UpdateCommand="PORTAL.[dbo].[PORTAL_CUENTACONTABLE_UPDATE]" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCiaSec" Type="String" />
                        <asp:Parameter DefaultValue="AGRUP_EEFF" Name="PUDF" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                        <asp:Parameter Name="CIA_CUENTA" Type="String" />
                        <asp:Parameter Name="SECCION" Type="String" />
                        <asp:Parameter Name="VALIDA_PRESUP_CR" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="DS_AGRUP_NOM_CTA" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_CUENTA_CONTABLE_UDF]" SelectCommandType="StoredProcedure" UpdateCommand="PORTAL.[dbo].[PORTAL_CUENTACONTABLE_UPDATE]" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCiaSec" Type="String" />
                        <asp:Parameter DefaultValue="AGRUP_NOM_CTA" Name="PUDF" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                        <asp:Parameter Name="CIA_CUENTA" Type="String" />
                        <asp:Parameter Name="SECCION" Type="String" />
                        <asp:Parameter Name="VALIDA_PRESUP_CR" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="DS_CODCASHFLOW" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_CUENTA_CONTABLE_UDF]" SelectCommandType="StoredProcedure" UpdateCommand="PORTAL.[dbo].[PORTAL_CUENTACONTABLE_UPDATE]" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCiaSec" Type="String" />
                        <asp:Parameter DefaultValue="CODCASHFLOW" Name="PUDF" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                        <asp:Parameter Name="CIA_CUENTA" Type="String" />
                        <asp:Parameter Name="SECCION" Type="String" />
                        <asp:Parameter Name="VALIDA_PRESUP_CR" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="DS_ORDEN_EEFF" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_CUENTA_CONTABLE_UDF]" SelectCommandType="StoredProcedure" UpdateCommand="PORTAL.[dbo].[PORTAL_CUENTACONTABLE_UPDATE]" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCiaSec" Type="String" />
                        <asp:Parameter DefaultValue="ORDEN_EEFF" Name="PUDF" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                        <asp:Parameter Name="CIA_CUENTA" Type="String" />
                        <asp:Parameter Name="SECCION" Type="String" />
                        <asp:Parameter Name="VALIDA_PRESUP_CR" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="DS_LISTA_UDF" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_CUENTA_CONTABLE_LISTA_UDF]" SelectCommandType="StoredProcedure" UpdateCommand="PORTAL.[dbo].[PORTAL_CUENTACONTABLE_UPDATE]" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCiaSec" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                        <asp:Parameter Name="CIA_CUENTA" Type="String" />
                        <asp:Parameter Name="SECCION" Type="String" />
                        <asp:Parameter Name="VALIDA_PRESUP_CR" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="DS_LISTA_UDF_DET" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_CUENTA_CONTABLE_UDF]" SelectCommandType="StoredProcedure" UpdateCommand="PORTAL.[dbo].[PORTAL_CUENTACONTABLE_UPDATE]" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCiaSec" Type="String" />
                        <asp:SessionParameter DefaultValue="ORDEN_EEFF" Name="PUDF" SessionField="UDF_SELECCIONADO" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                        <asp:Parameter Name="CIA_CUENTA" Type="String" />
                        <asp:Parameter Name="SECCION" Type="String" />
                        <asp:Parameter Name="VALIDA_PRESUP_CR" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="DS_AGRUP_TIPO" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_CUENTA_CONTABLE_UDF]" SelectCommandType="StoredProcedure" UpdateCommand="PORTAL.[dbo].[PORTAL_CUENTACONTABLE_UPDATE]" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCiaSec" Type="String" />
                        <asp:Parameter DefaultValue="AGRUP_TIPO" Name="PUDF" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                        <asp:Parameter Name="CIA_CUENTA" Type="String" />
                        <asp:Parameter Name="SECCION" Type="String" />
                        <asp:Parameter Name="VALIDA_PRESUP_CR" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="DS_TIPO_CONCILIACION" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_CUENTA_CONTABLE_UDF]" SelectCommandType="StoredProcedure" UpdateCommand="PORTAL.[dbo].[PORTAL_CUENTACONTABLE_UPDATE]" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCiaSec" Type="String" />
                        <asp:Parameter DefaultValue="TIPO_CONCILIACION" Name="PUDF" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                        <asp:Parameter Name="CIA_CUENTA" Type="String" />
                        <asp:Parameter Name="SECCION" Type="String" />
                        <asp:Parameter Name="VALIDA_PRESUP_CR" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>

            </td>
            <td>
                &nbsp;</td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                Modifique las Secciones en el siguiente cuadro: &nbsp;&nbsp;&nbsp;
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxGridView ID="GPermisos" runat="server" AutoGenerateColumns="False" DataSourceID="DS_Cuentas" KeyFieldName="CIA_CUENTA" 
                    Width="376px" ClientInstanceName="grid" EnableRowsCache="False" Theme="SoftOrange" OnCellEditorInitialize="GPermisos_CellEditorInitialize">
                    <SettingsPager NumericButtonCount="30" PageSize="30">
                    </SettingsPager>
                    <SettingsEditing Mode="Batch">
                    </SettingsEditing>
                    <Settings ShowFilterRow="True" />

<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>

                    <SettingsLoadingPanel ImagePosition="Top" />
        <SettingsSearchPanel Visible="True" />
        <Toolbars>
            <dx:GridViewToolbar>
                <Items>
                    <dx:GridViewToolbarItem Command="Edit" />
                    <dx:GridViewToolbarItem Command="Update" DisplayMode="ImageWithText" Text ="Guardar">
                        <Image Url="~/Imagenes/SaveAll.png">
                        </Image>
                        <ItemStyle>
                        <BackgroundImage ImageUrl="SaveAll.png" />
                        </ItemStyle>
                    </dx:GridViewToolbarItem>
                </Items>
            </dx:GridViewToolbar>
        </Toolbars>

                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="CIA_CUENTA" FixedStyle="Left" ReadOnly="True" Visible="false"
                            VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CIA" FixedStyle="Left" ReadOnly="True"
                            VisibleIndex="1">
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn FieldName="CUENTA_CONTABLE" FixedStyle="Left" ReadOnly="True"
                            VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DESCRIPCION" FixedStyle="Left" VisibleIndex="3"  ReadOnly="True"
                            Width="100%">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SECCION" FixedStyle="Left" VisibleIndex="4"
                            Width="100%">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataCheckColumn FieldName="VALIDA_PRESUP_CR" FixedStyle="Left" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5" Width="100%">
                            <PropertiesCheckEdit ValueChecked="S" ValueType="System.String" ValueUnchecked="N">
                            </PropertiesCheckEdit>
                        </dx:GridViewDataCheckColumn>

                        <dx:GridViewDataTextColumn FieldName="U_C_ARESEP" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9" >
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_CIA_INTERCOM" LoadReadOnlyValueFromDataModel="True" VisibleIndex="10" >
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_CMI_MAPPING" LoadReadOnlyValueFromDataModel="True" VisibleIndex="11" >
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_CTA_INTERCOM" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13" >
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_ENTITY" LoadReadOnlyValueFromDataModel="True" VisibleIndex="14" >
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_INTERCO_NON_INTECO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15" >
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_LEDGER" LoadReadOnlyValueFromDataModel="True" VisibleIndex="16" >
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_MONEDA_GRUPO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="17" >
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_MONEDA_LOCAL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="18" >
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_PAIS" LoadReadOnlyValueFromDataModel="True" VisibleIndex="20" >
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_SOCASO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="21" >
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_SOCIEDAD_GL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="22" >
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_TIPOVALOR" LoadReadOnlyValueFromDataModel="True" VisibleIndex="23" >
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_MONEDA_TRANSACCION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="25" >
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="U_AGRUP_EEFF" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6">
                            <PropertiesComboBox DataSourceID="DS_AGRUP_EEFF" TextField="DESC_UDF" ValueField="CODIGO">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="U_AGRUP_NOM_CTA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="7">
                            <PropertiesComboBox DataSourceID="DS_AGRUP_NOM_CTA" ValueField="CODIGO" TextField="DESC_UDF">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="U_AGRUP_TIPO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8">
                            <PropertiesComboBox DataSourceID="DS_AGRUP_TIPO" TextField="DESC_UDF" ValueField="CODIGO">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="U_CODCASHFLOW" LoadReadOnlyValueFromDataModel="True" VisibleIndex="12">
                            <PropertiesComboBox DataSourceID="DS_CODCASHFLOW" TextField="DESC_UDF" ValueField="CODIGO">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="U_ORDEN_EEFF" LoadReadOnlyValueFromDataModel="True" VisibleIndex="19">
                            <PropertiesComboBox DataSourceID="DS_ORDEN_EEFF" TextField="DESC_UDF" ValueField="CODIGO">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="U_TIPO_CONCILIACION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="24">
                            <PropertiesComboBox DataSourceID="DS_TIPO_CONCILIACION" TextField="DESC_UDF" ValueField="CODIGO">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>

                    </Columns>
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
                <asp:SqlDataSource ID="DS_Cuentas" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="portal.[dbo].[PORTAL_CUENTACONTABLE_CB5]" SelectCommandType="StoredProcedure" UpdateCommand="PORTAL.[dbo].[PORTAL_CUENTACONTABLE_UPDATE2]" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCia24" Type="String" />
                        <asp:SessionParameter DefaultValue="" Name="PCuentaini" SessionField="PCuentaini24" Type="String" />
                        <asp:SessionParameter DefaultValue="" Name="PCuentafin" SessionField="PCuentafin24" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="CIA_CUENTA" Type="String" />
                        <asp:Parameter Name="SECCION" Type="String" />
                        <asp:Parameter Name="VALIDA_PRESUP_CR" Type="String" />
                        <asp:Parameter Name="U_CMI_MAPPING" Type="String" />
                        <asp:Parameter Name="U_ENTITY" Type="String" />
                        <asp:Parameter Name="U_SOCIEDAD_GL" Type="String" />
                        <asp:Parameter Name="U_LEDGER" Type="String" />
                        <asp:Parameter Name="U_TIPOVALOR" Type="String" />
                        <asp:Parameter Name="U_PAIS" Type="String" />
                        <asp:Parameter Name="U_MONEDA_LOCAL" Type="String" />
                        <asp:Parameter Name="U_MONEDA_GRUPO" Type="String" />
                        <asp:Parameter Name="U_ORDEN_EEFF" Type="String" />
                        <asp:Parameter Name="GRUPO_ORDEN_ER" Type="String" />
                        <asp:Parameter Name="U_INTERCO_NON_INTECO" Type="String" />
                        <asp:Parameter Name="U_SOCASO" Type="String" />
                        <asp:Parameter Name="U_CIA_INTERCOM" Type="String" />
                        <asp:Parameter Name="U_CTA_INTERCOM" Type="String" />
                        <asp:Parameter Name="U_AGRUP_EEFF" Type="String" />
                        <asp:Parameter Name="U_AGRUP_TIPO" Type="String" />
                        <asp:Parameter Name="U_AGRUP_NOM_CTA" Type="String" />
                        <asp:Parameter Name="U_CODCASHFLOW" Type="String" />
                        <asp:Parameter Name="U_C_ARESEP" Type="String" />
                        <asp:Parameter Name="U_TIPO_CONCILIACION" Type="String" />
                        <asp:Parameter Name="U_MONEDA_TRANSACCION" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <dx:ASPxGridViewExporter ID="Exportador" runat="server" PrintSelectCheckBox="True">
                </dx:ASPxGridViewExporter>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
    </table>


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
                <dx:ASPxLabel ID="LabelMensaje" runat="server" Font-Bold="True" Text="Esta seguro que desea actualizar en batch el UDF seleccionado?" style="margin-left: 7px" Width="300px">
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


    </asp:Content>
