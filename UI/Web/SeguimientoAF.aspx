<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="SeguimientoAF.aspx.cs" Inherits="UI.Web.SeguimientoAF" %>


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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="Seguimiento Activos"></asp:Label>
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
                                <dx:ASPxButton ID="btnExportarPdf" runat="server" Height="32px"  Native="True" OnClick="btnExportarPdf_E3_ClickExc" Theme="SoftOrange" Width="32px">
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
            <asp:SessionParameter DefaultValue="100000 000" Name="PCia" SessionField="ci_sciaSE" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridView ID="grid_data"  ClientInstanceName="MasterGrid" runat="server" Width="1324px" AutoGenerateColumns="False" 
        DataSourceID="SQLResultados"  Theme="SoftOrange" EnableRowsCache="true" OnCustomButtonCallback="grid_data_CustomButtonCallback">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnArea" Text="Area" />
                </CustomButtons>
            </dx:GridViewCommandColumn>
            <dx:GridViewCommandColumn VisibleIndex="1">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnEstado" Text="Estado" />
                </CustomButtons>
            </dx:GridViewCommandColumn>
            <dx:GridViewCommandColumn VisibleIndex="2">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnResponsable" Text="Responsable" />
                </CustomButtons>
            </dx:GridViewCommandColumn>
            <dx:GridViewCommandColumn VisibleIndex="3">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnInventario" Text="Inventario" />
                </CustomButtons>
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="CIA" VisibleIndex="6" ShowInCustomizationForm="True" Caption="Cia">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_CIA" VisibleIndex="7" ShowInCustomizationForm="True" Caption="Nombre Cia" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ACTIVO_FIJO" VisibleIndex="8" ShowInCustomizationForm="True" Caption="Activo Fijo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DESCRIPCION" VisibleIndex="9" ShowInCustomizationForm="True" Caption="Descripcion">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_TIPO_ACTIVO" VisibleIndex="10" ShowInCustomizationForm="True" Caption="Tipo Activo">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_ACTIVO" VisibleIndex="10" ShowInCustomizationForm="True" Caption="Tipo Activo" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MEJORA" VisibleIndex="11" ShowInCustomizationForm="True" Caption="Mejora">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_MEJORA" VisibleIndex="12" ShowInCustomizationForm="True" Caption="Descripcion Mejora" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_ADQUISICION" VisibleIndex="13" ShowInCustomizationForm="True"  Caption="Fecha Adquisicion">
                <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">  
                </PropertiesTextEdit> 
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_ACTIVACION" VisibleIndex="14" ShowInCustomizationForm="True" Caption="Fecha Activacion">
                <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">  
                </PropertiesTextEdit> 
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COSTO_LOCAL_FISCAL" VisibleIndex="15" ShowInCustomizationForm="True" Caption="Costo Local Fiscal" Visible="false">
                <PropertiesTextEdit DisplayFormatString="{0:N2}" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COSTO_DOLAR_FISCAL" VisibleIndex="16" ShowInCustomizationForm="True" Caption="Costo Dolar Fiscal" Visible="false">
                <PropertiesTextEdit DisplayFormatString="{0:N2}" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VALOR_LIBROS_LOCAL" VisibleIndex="17" ShowInCustomizationForm="True" Caption="Valor Libros Local">
                <PropertiesTextEdit DisplayFormatString="{0:N2}" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VALOR_LIBROS_DOLAR" VisibleIndex="18" ShowInCustomizationForm="True" Caption="Valor Libros Dolar">
                <PropertiesTextEdit DisplayFormatString="{0:N2}" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PLAZO_VIDA_UTIL_FISCAL" VisibleIndex="19" ShowInCustomizationForm="True" Caption="Vida Util(Meses)">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NUMERO_SERIE" VisibleIndex="20" ShowInCustomizationForm="True" Caption="Numero Serie">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ESTADO_ACTIVO" VisibleIndex="21" ShowInCustomizationForm="True" Caption="Estado">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_RESPONSABLE" VisibleIndex="22" ShowInCustomizationForm="True" Caption="Responsable">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ULTIMO_INVENTARIO" VisibleIndex="23" ShowInCustomizationForm="True" Caption="Ultimo Inventario">
                <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">  
                </PropertiesTextEdit> 
            </dx:GridViewDataTextColumn>

        </Columns>
    </dx:ASPxGridView>


    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=PRUEBAS;Persist Security Info=True;User ID=sa
                ;Password=SAsoftladbqa$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT C.CLUSTER_ID, CONCAT(C.CLUSTER_ID,' ' ,C.NOMBRE_CLUSTER) AS NOMBRE_CLUSTER FROM PORTAL.dbo.CLUSTER_AF C WHERE C.ESTADO=1  ORDER BY 2">
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
