<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="BuscarActivos.aspx.cs" Inherits="UI.Web.BuscarActivos" %>


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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="Buscar Activos"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="93px" Theme="SoftOrange" Width="60%">
        <Items>
            <dx:LayoutGroup ColCount="5" ColSpan="1" ColumnCount="6" Caption="Activo" RowSpan="2">
                <Items>

                    <dx:LayoutItem Caption="Cluster"  ColSpan="1" Name="Cia" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                
                                <dx:ASPxDropDownEdit ClientInstanceName="checkComboBox" ID="ASPxDropDownEdit1" Width="285px" runat="server" AnimationType="None" Theme="SoftOrange">
                                   <DropDownWindowStyle BackColor="#EDEDED" />
                                       <DropDownWindowTemplate>
                                            <dx:ASPxListBox Width="100%" ID="listBox" ClientInstanceName="checkListBox" SelectionMode="CheckColumn"
                                                    runat="server" Height="200" EnableSelectAll="true" DataSourceID="SQLCompania" TextField="NOMBRE_CLUSTER" ValueField="CLUSTER_ID">
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
                                </dx:ASPxDropDownEdit>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Width="32px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server" Height="32px" ToolTip="Búsqueda" Native="True" OnClick="ASPxFormLayout1_E3_Click"  Theme="SoftOrange" Width="32px">
                                 <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />                               

                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="32px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E1" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_ClickExc" Theme="SoftOrange" Width="32px">
                                      <BackgroundImage ImageUrl="~/Imagenes/Excel.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>
                    
                    <dx:LayoutItem Caption="" ColSpan="1" Name="PDF" Width="32px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnExportarPdf" runat="server" Height="32px" Native="True" OnClick="btnExportarPdf_E3_ClickExc" Theme="SoftOrange" Width="32px">
                                      <BackgroundImage ImageUrl="~/Imagenes/export_pdf.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

    <asp:SqlDataSource ID="SQLResultados" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=PRUEBAS;Persist Security Info=True;User ID=sa
;Password=SAsoftladbqa$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_BUSCAR_AF]" SelectCommandType="StoredProcedure" OnSelected="SQLResultados_Selected">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia" SessionField="ci_sciaB" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridView ID="grid_data"  ClientInstanceName="MasterGrid" runat="server" Width="1324px" AutoGenerateColumns="False" 
        DataSourceID="SQLResultados" Theme="SoftOrange" EnableRowsCache="False" >
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            
            <dx:GridViewDataTextColumn FieldName="CIA" VisibleIndex="7" ShowInCustomizationForm="True" Caption="Cia">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_CIA" VisibleIndex="8" ShowInCustomizationForm="True" Caption="Nombre Cia" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ACTIVO_FIJO" VisibleIndex="9" ShowInCustomizationForm="True" Caption="Activo Fijo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DESCRIPCION" VisibleIndex="10" ShowInCustomizationForm="True" Caption="Descripcion">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_TIPO_ACTIVO" VisibleIndex="11" ShowInCustomizationForm="True" Caption="Tipo Activo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_ACTIVO" VisibleIndex="11" ShowInCustomizationForm="True" Caption="Tipo Activo" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MEJORA" VisibleIndex="11" ShowInCustomizationForm="True" Caption="Mejora">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_MEJORA" VisibleIndex="12" ShowInCustomizationForm="True" Caption="Descripcion Mejora">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_RESPONSABLE" VisibleIndex="13" ShowInCustomizationForm="True" Caption="Responsable">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_UBICACION" VisibleIndex="14" ShowInCustomizationForm="True" Caption="Ubicacion">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="FECHA_ADQUISICION" VisibleIndex="15" ShowInCustomizationForm="True" Caption="Fecha Adquisicion" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_ACTIVACION" VisibleIndex="16" ShowInCustomizationForm="True" Caption="Fecha Activacion" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_ULT_MANTENIMIENTO" VisibleIndex="17" ShowInCustomizationForm="True" Caption="Fecha Ultima Mantenimiento" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_PROX_MANTENIMIENTO" VisibleIndex="18" ShowInCustomizationForm="True" Caption="Fecha Proximo Mantenimiento" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CODIGO_BARRAS" VisibleIndex="19" ShowInCustomizationForm="True" Caption="Codigo Barras" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RESPONSABLE" VisibleIndex="20" ShowInCustomizationForm="True" Caption="Responsable" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NUMERO_SERIE" VisibleIndex="21" ShowInCustomizationForm="True" Caption="Numero Serie" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="UBICACION" VisibleIndex="22" ShowInCustomizationForm="True" Caption="Area" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PROVEEDOR" VisibleIndex="23" ShowInCustomizationForm="True" Caption="Proveedor" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_PROVEEDOR" VisibleIndex="24" ShowInCustomizationForm="True" Caption="Nombre Proveedor" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CLASIFICACION" VisibleIndex="25" ShowInCustomizationForm="True" Caption="Clasificacion" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_DEPRECIACION_FISCAL" VisibleIndex="26" ShowInCustomizationForm="True" Caption="Tipo Depreciacion Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PLAZO_VIDA_UTIL_FISCAL" VisibleIndex="27" ShowInCustomizationForm="True" Caption="Plazo Vida Util Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COSTO_LOCAL_FISCAL" VisibleIndex="28" ShowInCustomizationForm="True" Caption="Costo Local Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COSTO_DOLAR_FISCAL" VisibleIndex="29" ShowInCustomizationForm="True" Caption="Costo Dolar Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VALOR_RESCATE_LOCAL_FISCAL" VisibleIndex="30" ShowInCustomizationForm="True" Caption="Valor Rescate Local Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VALOR_RESCATE_DOLAR_FISCAL" VisibleIndex="31" ShowInCustomizationForm="True" Caption="Valor Rescate Dolar Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ASIENTO_INGRESO_FISCAL" VisibleIndex="32" ShowInCustomizationForm="True" Caption="Asiento Ingreso Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ULTIMA_DEPRECIACION_FISCAL" VisibleIndex="33" ShowInCustomizationForm="True" Caption="Ultima Depreciacion Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ULTIMA_REVALUACION_FISCAL" VisibleIndex="34" ShowInCustomizationForm="True" Caption="Ultima Revaluacion Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_INDICE_PRECIO_FISCAL" VisibleIndex="35" ShowInCustomizationForm="True" Caption="Tipo Indice Precio Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_RETIRO_FISCAL" VisibleIndex="36" ShowInCustomizationForm="True" Caption="Fecha Retiro Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_RETIRO_FISCAL" VisibleIndex="37" ShowInCustomizationForm="True" Caption="Usuario Retiro Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ASIENTO_RETIRO_FISCAL" VisibleIndex="38" ShowInCustomizationForm="True" Caption="Asiento Retiro Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_DEPRECIACION_FINANCIERA" VisibleIndex="39" ShowInCustomizationForm="True" Caption="Tipo Depreciacion Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VIDA_UTIL_FINANCIERA" VisibleIndex="40" ShowInCustomizationForm="True" Caption="Vida Util Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COSTO_LOCAL_FINANCIERA" VisibleIndex="41" ShowInCustomizationForm="True" Caption="Costo Local Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COSTO_DOLAR_FINANCIERA" VisibleIndex="42" ShowInCustomizationForm="True" Caption="Costo Dolar Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VALOR_RESCATE_LOCAL_FINANCIERA" VisibleIndex="43" ShowInCustomizationForm="True" Caption="Valor Rescate Local Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VALOR_RESCATE_DOLAR_FINANCIERA" VisibleIndex="44" ShowInCustomizationForm="True" Caption="Valor Rescate Dolar Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ASIENTO_INGRESO_FINANCIERA" VisibleIndex="45" ShowInCustomizationForm="True" Caption="Asiento Ingreso Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ULTIMA_DEPRECIACION_FINANCIERA" VisibleIndex="46" ShowInCustomizationForm="True" Caption="Ultima Depreciacion Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ULTIMA_REVALUACION_FINANCIERA" VisibleIndex="47" ShowInCustomizationForm="True" Caption="Ultima Revaluacion Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_RETIRO_FINANCIERA" VisibleIndex="48" ShowInCustomizationForm="True" Caption="Usuario Retiro Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ASIENTO_RETIRO_FINANCIERA" VisibleIndex="49" ShowInCustomizationForm="True" Caption="Asiento Retiro Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_ULTIMA_MODIFICACION" VisibleIndex="50" ShowInCustomizationForm="True" Caption="Fecha Ultima Modificacion" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_ULTIMA_MODIFICACION" VisibleIndex="51" ShowInCustomizationForm="True" Caption="Usuario Ultima Modificacion" Visible="false">
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=PRUEBAS;Persist Security Info=True;User ID=sa
                ;Password=SAsoftladbqa$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT C.CLUSTER_ID, CONCAT(C.CLUSTER_ID,' ' ,C.NOMBRE_CLUSTER) AS NOMBRE_CLUSTER FROM PORTAL.dbo.CLUSTER_AF C 
        INNER JOIN PORTAL.dbo.DETALLE_CLUSTER_AF D ON D.CLUSTER_ID=C.CLUSTER_ID
          INNER JOIN PORTAL.dbo.Departamento_Usuario_AF DU ON DU.Compania=D.CIA
          WHERE DU.NombreUsuario=@UsuarioSesion ORDER BY 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="UsuarioSesion" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <dx:ASPxGridViewExporter ID="grid_data_exp" runat="server" FileName="Activos" GridViewID="grid_data">
    </dx:ASPxGridViewExporter>

    <dx:ASPxPopupControl ID="PError" runat="server" Height="130px" Width="363px" HeaderText="Error"  ClientInstanceName="PError" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
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
                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Font-Bold="True" Text="El usuario no cuenta con permiso de aprobación en alguna de las compañías seleccionadas." style="margin-left: 7px" Width="300px">
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
                        <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Aceptar">
                            <ClientSideEvents Click="function(s, e) { PError.Hide(); }" />
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

    <dx:ASPxPopupControl ID="PAdvertencia" runat="server" Height="130px" Width="363px" HeaderText="Mensaje"  ClientInstanceName="PAdvertencia" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
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
                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Font-Bold="True" Text="Proceso de Aprobación finalizada con éxito." style="margin-left: 7px" Width="300px">
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
                        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Aceptar">
                            <ClientSideEvents Click="function(s, e) { PAdvertencia.Hide(); }" />
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
                        <dx:ASPxLabel ID="lblValidacion" runat="server" Font-Bold="True" Text="No se muestran resultados porque no se ha seleccionado Usuario o Departamento." style="margin-left: 7px" Width="300px">
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
                        <dx:ASPxButton ID="ASPxButton4" runat="server" Text="Aceptar">
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
