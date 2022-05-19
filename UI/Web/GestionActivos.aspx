<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="GestionActivos.aspx.cs" Inherits="UI.Web.GestionActivos" %>

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

        function updateText2() {
            var selectedItems = checkListBox2.GetSelectedItems();
            checkComboBox2.SetText(getSelectedItemsText2(selectedItems));
        }

        function synchronizeListBoxValues(dropDown, args) {
            checkListBox.UnselectAll();
            var texts = dropDown.GetText().split(textSeparator);
            var values = getValuesByTexts(texts);
            checkListBox.SelectValues(values);
            updateText(); // for remove non-existing texts
        }

        function synchronizeListBoxValues2(dropDown2, args) {
            checkListBox2.UnselectAll();
            var texts = dropDown2.GetText().split(textSeparator);
            var values = getValuesByTexts2(texts);
            checkListBox2.SelectValues(values);
            updateText2(); // for remove non-existing texts
        }

        function getSelectedItemsText(items) {
            var texts = [];
            for (var i = 0; i < items.length; i++)
                texts.push(items[i].text);
            return texts.join(textSeparator);
        }

        function getSelectedItemsText2(items) {
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

        function getValuesByTexts2(texts) {
            var actualValues = [];
            var item;
            for (var i = 0; i < texts.length; i++) {
                item = checkListBox2.FindItemByText(texts[i]);
                if (item != null)
                    actualValues.push(item.value);
            }
            return actualValues;
        }

    </script>
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="Ver Activos"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="93px" Theme="SoftOrange" Width="60%">
        <Items>
            <dx:LayoutGroup ColCount="5" ColSpan="1" ColumnCount="6" Caption="Codigo Activo" RowSpan="2">
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

                    <dx:LayoutItem Caption="Departamento"  ColSpan="1" Name="Departamento" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                
                                <dx:ASPxDropDownEdit ClientInstanceName="checkComboBox2" ID="ASPxDropDownEdit2" Width="285px" runat="server" AnimationType="None" Theme="SoftOrange">
                                   <DropDownWindowStyle BackColor="#EDEDED" />
                                       <DropDownWindowTemplate>
                                            <dx:ASPxListBox Width="100%" ID="listBox2" ClientInstanceName="checkListBox2" SelectionMode="CheckColumn"
                                                    runat="server" Height="200" EnableSelectAll="true" DataSourceID="SQLDepartamento" TextField="NombreDepartamento" ValueField="Departamento">
                                                <FilteringSettings ShowSearchUI="true"/>
                                                <Border BorderStyle="None" />
                                                <BorderBottom BorderStyle="Solid" BorderWidth="1px" BorderColor="#DCDCDC" />
                                                <ClientSideEvents SelectedIndexChanged="updateText2" Init="updateText2" />
                                            </dx:ASPxListBox>
                                            <table style="width: 100%">
                                                <tr>
                                                    <td style="padding: 4px">
                                                        <dx:ASPxButton ID="ASPxButton2" AutoPostBack="False" runat="server" Text="Close" style="float: right">
                                                            <ClientSideEvents Click="function(s, e){ checkComboBox2.HideDropDown(); }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </DropDownWindowTemplate>
                                        <ClientSideEvents TextChanged="synchronizeListBoxValues2" DropDown="synchronizeListBoxValues2" />
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
                    <dx:LayoutItem Caption="" ColSpan="1" Width="32px" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnBuscarRandom" runat="server" Height="32px" ToolTip="Búsqueda 20 Random " Native="True"  Theme="SoftOrange" Width="32px" OnClick="btnBuscarRandom_Click">
                                 <BackgroundImage ImageUrl="~/Imagenes/search_random.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />                               

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
;Password=SAsoftladbqa$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_AF_GESTION_CLUSTER]" SelectCommandType="StoredProcedure" OnSelected="SQLResultados_Selected">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="0 0" Name="PCia" SessionField="ci_sciaCA" />
            <asp:SessionParameter DefaultValue="0" Name="PTipo" SessionField="ci_tipo" />
            <asp:SessionParameter DefaultValue="0 0" Name="PDepartamento" SessionField="ci_departamento" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridView ID="grid_data"  ClientInstanceName="MasterGrid" runat="server" Width="1324px" AutoGenerateColumns="False" KeyFieldName="ACTIVO_FIJO_KEY"
        DataSourceID="SQLResultados" Theme="SoftOrange" EnableRowsCache="False" OnCustomButtonCallback="grid_data_CustomButtonCallback">
        <ClientSideEvents CustomButtonClick="function(s, e) {  visibleIndex = MasterGrid.GetRowKey(e.visibleIndex);  if (e.buttonID == 'btdet1') {Popup.PerformCallback(visibleIndex); Popup.Show(); }  
          e.processOnServer = true;  }" />
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" />
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
            <dx:GridViewCommandColumn VisibleIndex="1" Visible="false" >
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnArea" Text="Area" />
                </CustomButtons>
            </dx:GridViewCommandColumn>
            <dx:GridViewCommandColumn VisibleIndex="2">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnEstado" Text="Estado" />
                </CustomButtons>
            </dx:GridViewCommandColumn>
            <dx:GridViewCommandColumn VisibleIndex="3">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnResponsable" Text="Responsable" />
                </CustomButtons>
            </dx:GridViewCommandColumn>
            <dx:GridViewCommandColumn VisibleIndex="4">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnDetalle" Text="Ver Detalle" />
                </CustomButtons>
            </dx:GridViewCommandColumn>
            <dx:GridViewCommandColumn VisibleIndex="5">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnAcciones" Text="Ver Historico" />
                </CustomButtons>
            </dx:GridViewCommandColumn>
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
            <dx:GridViewDataTextColumn FieldName="NOMBRE_MEJORA" VisibleIndex="11" ShowInCustomizationForm="True" Caption="Descripcion Mejora" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_ADQUISICION" VisibleIndex="12" ShowInCustomizationForm="True" Caption="Fecha Adquisicion">
                <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">  
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_ACTIVACION" VisibleIndex="13" ShowInCustomizationForm="True" Caption="Fecha Activacion">
                <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">  
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COSTO_LOCAL_FISCAL" VisibleIndex="14" ShowInCustomizationForm="True" Caption="Costo Local">
                <PropertiesTextEdit DisplayFormatString="{0:N2}" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COSTO_DOLAR_FISCAL" VisibleIndex="15" ShowInCustomizationForm="True" Caption="Costo Dolar">
                <PropertiesTextEdit DisplayFormatString="{0:N2}" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VALOR_LIBROS_LOCAL" VisibleIndex="16" ShowInCustomizationForm="True" Caption="Valor Libros Local">
                <PropertiesTextEdit DisplayFormatString="{0:N2}" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VALOR_LIBROS_DOLAR" VisibleIndex="17" ShowInCustomizationForm="True" Caption="Valor Libros Dolar">
                <PropertiesTextEdit DisplayFormatString="{0:N2}" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PLAZO_VIDA_UTIL_FISCAL" VisibleIndex="18" ShowInCustomizationForm="True" Caption="Vida Util(Meses)" >
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NUMERO_SERIE" VisibleIndex="19" ShowInCustomizationForm="True" Caption="Serie">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ESTADO_ACTIVO" VisibleIndex="20" ShowInCustomizationForm="True" Caption="Estado">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_RESPONSABLE" VisibleIndex="21" ShowInCustomizationForm="True" Caption="Responsable">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ULTIMO_INVENTARIO" VisibleIndex="22" ShowInCustomizationForm="True" Caption="Ultimo Inventario">
                <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">  
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="RESPONSABLE" VisibleIndex="23" ShowInCustomizationForm="True" Caption="Responsable" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_ULT_MANTENIMIENTO" VisibleIndex="24" ShowInCustomizationForm="True" Caption="Fecha Ultima Mantenimiento" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_PROX_MANTENIMIENTO" VisibleIndex="25" ShowInCustomizationForm="True" Caption="Fecha Proximo Mantenimiento" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CODIGO_BARRAS" VisibleIndex="26" ShowInCustomizationForm="True" Caption="Codigo Barras" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="UBICACION" VisibleIndex="27" ShowInCustomizationForm="True" Caption="Area" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_UBICACION" VisibleIndex="28" ShowInCustomizationForm="True" Caption="Nombre Area" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PROVEEDOR" VisibleIndex="29" ShowInCustomizationForm="True" Caption="Proveedor" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE_PROVEEDOR" VisibleIndex="30" ShowInCustomizationForm="True" Caption="Nombre Proveedor" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CLASIFICACION" VisibleIndex="31" ShowInCustomizationForm="True" Caption="Clasificacion" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_DEPRECIACION_FISCAL" VisibleIndex="32" ShowInCustomizationForm="True" Caption="Tipo Depreciacion Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VALOR_RESCATE_LOCAL_FISCAL" VisibleIndex="33" ShowInCustomizationForm="True" Caption="Valor Rescate Local Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VALOR_RESCATE_DOLAR_FISCAL" VisibleIndex="34" ShowInCustomizationForm="True" Caption="Valor Rescate Dolar Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ASIENTO_INGRESO_FISCAL" VisibleIndex="35" ShowInCustomizationForm="True" Caption="Asiento Ingreso Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ULTIMA_DEPRECIACION_FISCAL" VisibleIndex="36" ShowInCustomizationForm="True" Caption="Ultima Depreciacion Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ULTIMA_REVALUACION_FISCAL" VisibleIndex="37" ShowInCustomizationForm="True" Caption="Ultima Revaluacion Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_INDICE_PRECIO_FISCAL" VisibleIndex="38" ShowInCustomizationForm="True" Caption="Tipo Indice Precio Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_RETIRO_FISCAL" VisibleIndex="39" ShowInCustomizationForm="True" Caption="Fecha Retiro Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_RETIRO_FISCAL" VisibleIndex="40" ShowInCustomizationForm="True" Caption="Usuario Retiro Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ASIENTO_RETIRO_FISCAL" VisibleIndex="41" ShowInCustomizationForm="True" Caption="Asiento Retiro Fiscal" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_DEPRECIACION_FINANCIERA" VisibleIndex="42" ShowInCustomizationForm="True" Caption="Tipo Depreciacion Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VIDA_UTIL_FINANCIERA" VisibleIndex="43" ShowInCustomizationForm="True" Caption="Vida Util Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COSTO_LOCAL_FINANCIERA" VisibleIndex="44" ShowInCustomizationForm="True" Caption="Costo Local Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COSTO_DOLAR_FINANCIERA" VisibleIndex="45" ShowInCustomizationForm="True" Caption="Costo Dolar Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VALOR_RESCATE_LOCAL_FINANCIERA" VisibleIndex="46" ShowInCustomizationForm="True" Caption="Valor Rescate Local Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="VALOR_RESCATE_DOLAR_FINANCIERA" VisibleIndex="47" ShowInCustomizationForm="True" Caption="Valor Rescate Dolar Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ASIENTO_INGRESO_FINANCIERA" VisibleIndex="48" ShowInCustomizationForm="True" Caption="Asiento Ingreso Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ULTIMA_DEPRECIACION_FINANCIERA" VisibleIndex="49" ShowInCustomizationForm="True" Caption="Ultima Depreciacion Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ULTIMA_REVALUACION_FINANCIERA" VisibleIndex="50" ShowInCustomizationForm="True" Caption="Ultima Revaluacion Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_RETIRO_FINANCIERA" VisibleIndex="51" ShowInCustomizationForm="True" Caption="Usuario Retiro Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ASIENTO_RETIRO_FINANCIERA" VisibleIndex="52" ShowInCustomizationForm="True" Caption="Asiento Retiro Financiera" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FECHA_ULTIMA_MODIFICACION" VisibleIndex="53" ShowInCustomizationForm="True" Caption="Fecha Ultima Modificacion" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_ULTIMA_MODIFICACION" VisibleIndex="54" ShowInCustomizationForm="True" Caption="Usuario Ultima Modificacion" Visible="false">
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="SQLCompaniaAnterior" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=Pruebas;Persist Security Info=True;User ID=sa
                ;Password=SAsoftladbqa$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
                  FROM [Pruebas].[erpadmin].[PRIVILEGIO_EX] P, Pruebas.erpadmin.conjunto C
                  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
                order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=PRUEBAS;Persist Security Info=True;User ID=sa
                ;Password=SAsoftladbqa$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT C.CLUSTER_ID, CONCAT(C.CLUSTER_ID,' ' ,C.NOMBRE_CLUSTER) AS NOMBRE_CLUSTER FROM PORTAL.dbo.CLUSTER_AF C 
        INNER JOIN PORTAL.dbo.DETALLE_CLUSTER_AF D ON D.CLUSTER_ID=C.CLUSTER_ID
          INNER JOIN PORTAL.dbo.Departamento_Usuario_AF DU ON DU.Compania=D.CIA
          WHERE DU.NombreUsuario=@UsuarioSesion ORDER BY 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="UsuarioSesion" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLDepartamento" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=PRUEBAS;Persist Security Info=True;User ID=sa
                ;Password=SAsoftladbqa$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT DU.Departamento,CONCAT(DU.Departamento,' ',DU.NombreDepartamento) as NombreDepartamento FROM PORTAL.dbo.CLUSTER_AF C 
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

    <dx:ASPxPopupControl ID="Popup" runat="server" AllowDragging="True" ClientInstanceName="Popup" CloseAction="OuterMouseClick" HeaderText="Adjuntos Activo Fijo" Modal="true" OnWindowCallback="Popup_WindowCallback"  PopupAction="None" PopupElementID="grid" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="false" ScrollBars="Vertical" ShowPageScrollbarWhenModal="True" ShowViewportScrollbarWhenModal="True" Height="400px" Width="900px">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <table style="width: 100%;">
                    <tr>
                        <td>
                            <dx:ASPxFileManager ID="ASPxFileManager1" runat="server" DataSourceID="SQL_Data_AF_Doc_Adjuntos" Height="380px" Width="200px" OnFileDownloading="ASPxFileManager1_FileDownloading" ClientInstanceName="filemanager" OnCustomCallback="ASPxFileManager1_CustomCallback">
                                <SettingsDataSource />
                                <Settings ThumbnailFolder="~\Thumb\" />
                                  <SettingsFileList PageSize="100">
                                  </SettingsFileList>
                                <SettingsEditing AllowDownload="True" />
                                  <SettingsFolders ShowExpandButtons="False" Visible="False" />
                                  <SettingsToolbar ShowFilterBox="False" ShowPath="False">
                                  </SettingsToolbar>
                                <SettingsUpload Enabled="False">
                                </SettingsUpload>
                                <SettingsDataSource KeyFieldName="CONSECUTIVO" ParentKeyFieldName="PARENT_ID" NameFieldName="NOMBRE"
                                    IsFolderFieldName="ISFOLDER" FileBinaryContentFieldName="CONTENIDO"   LastWriteTimeFieldName="FECHA_CREACION"/>
                            </dx:ASPxFileManager>
                        </td>
                    </tr>
                </table>

                <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="UploadControl" Width="840px"
                    NullText="Select multiple files..." UploadMode="Advanced" ShowUploadButton="True" ShowProgressPanel="True"
                    OnFileUploadComplete="UploadControl_FileUploadComplete">
                    <AdvancedModeSettings EnableMultiSelect="True" EnableFileList="True" EnableDragAndDrop="True" />
                    <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".jpg,.jpeg,.gif,.png,.pdf,.xls,.xlsx,.docx,.rar,.txt,.zip">
                    </ValidationSettings>
                    <ClientSideEvents FileUploadComplete="function(s, e) {
	                     if( e.isValid)
                            { memo.SetText(e.callbackData);
                              grid.PerformCallback();
                            }

                    }" />
                </dx:ASPxUploadControl>
                <br />
                

                <asp:SqlDataSource ID="SQL_Data_AF_Doc_Adjuntos" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPruebas %>" ProviderName="<%$ ConnectionStrings:SQLConexionPruebas.ProviderName %>" SelectCommand="PORTAL.[dbo].[PORTAL_DOCUMENTOS_ADJUNTOS_AF]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="0" Name="PCia1" SessionField="CodigoCia" Type="String" />
                        <asp:SessionParameter DefaultValue="0" Name="PACTIVO_FIJO" SessionField="CodigoAF" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </dx:PopupControlContentControl>
         </ContentCollection>
     </dx:ASPxPopupControl>

</asp:Content>
