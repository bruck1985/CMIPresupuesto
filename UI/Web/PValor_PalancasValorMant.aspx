<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="PValor_PalancasValorMant.aspx.cs" Inherits="UI.Web.PValor_PalancasValorMant" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Palancas Valor"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="900px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption=" " ColSpan="1" Name="CiaOrigen" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                               <dx:ASPxDropDownEdit ClientInstanceName="checkComboBox" ID="ASPxDropDownEdit1" Width="285px" runat="server" AnimationType="None" Theme="SoftOrange" Visible="False">
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
                                <dx:ASPxButton ID="Lform_E2" runat="server" AutoPostBack="False" Height="32px" Width="32px" ToolTip="Lista de Campos" Visible="False">
                                    <ClientSideEvents Click="function(s, e) {
	PivotVenta.ChangeCustomizationFieldsVisibility(); return false; 
}" />
                                    <BackgroundImage ImageUrl="~/Imagenes/Lista.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"/>

                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Lista.png">
                        </TabImage>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLPalancas" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="Portal.PValor.SPTraePalancasValor" SelectCommandType="StoredProcedure" DeleteCommand="Portal.PValor.spBorraPalancasValor" DeleteCommandType="StoredProcedure" InsertCommand="Portal.PValor.spRegistraPalancasValorMant" InsertCommandType="StoredProcedure" UpdateCommand="Portal.PValor.spRegistraPalancasValorMant" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:SessionParameter Name="PUsuarioCia" SessionField="nombreUsuario" Size="25" Type="String" />
            <asp:Parameter Name="CONSECUTIVO" Type="Int64" />
            <asp:Parameter Direction="InputOutput" Name="CodigoError" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="MensajeError" Size="500" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:SessionParameter Name="PUsuarioCia" SessionField="nombreUsuario" Size="25" Type="String" />
            <asp:Parameter Name="CONSECUTIVO" Type="Int64" />
            <asp:Parameter Name="CodigoPais" Type="String" />
            <asp:Parameter Name="CodigoTecnologia" Type="Int32" />
            <asp:Parameter Name="CodigoSociedad" Type="Int32" />
            <asp:Parameter Name="CodigoTema" Type="Int32" />
            <asp:Parameter Name="OrigenEvento" Type="String" />
            <asp:Parameter Name="CodigoTipoRiesgo" Type="Int32" />
            <asp:Parameter Name="CodigoRecurrencia" Type="Int32" />
            <asp:Parameter Name="CodigoEfecto" Type="Int32" />
            <asp:Parameter Name="MontoImpactoUNAPeriodo" Type="Int32" />
            <asp:Parameter Name="MontoImpactoCajaPeriodo" Type="Int32" />
            <asp:Parameter Name="MontoImpactoUNALP" Type="Int32" />
            <asp:Parameter Name="MontoImpactoCajaLP" Type="Int32" />
            <asp:Parameter Name="CodigoProbabilidadOcurrenciaRiesgoInherente" Type="Int32" />
            <asp:Parameter Name="MontoImpactoRiesgoInherente" Type="Int32" />
            <asp:Parameter Name="Mitigadores" Type="String" />
            <asp:Parameter Name="CodigoProbabilidadOcurrenciaRiesgoResidual" Type="Int32" />
            <asp:Parameter Name="MontoImpactoRiesgoResidualUNA" Type="Int32" />
            <asp:Parameter Name="MontoImpactoRiesgoResidualFlujo" Type="Int32" />
            <asp:Parameter DbType="Date" Name="PlazoResolucion" />
            <asp:Parameter Name="AccionesCursoEnergia" Type="String" />
            <asp:Parameter Name="AccionesAltoNivel" Type="String" />
            <asp:Parameter DefaultValue="1" Name="CodigoTipoProceso" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="CodigoError" Type="Int32" />
            <asp:Parameter DefaultValue="" Direction="InputOutput" Name="MensajeError" Size="500" Type="String" />
            <asp:Parameter Name="CodigoEstadoPalanca" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Type="String" />
            <asp:SessionParameter DefaultValue="01/09/2021" Name="Pfechaini" SessionField="ci_sfec1" Type="String" />
            <asp:SessionParameter DefaultValue="01/12/2021" Name="Pfechafin" SessionField="ci_sfec2" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:SessionParameter Name="PUsuarioCia" SessionField="nombreUsuario" Size="25" Type="String" />
            <asp:Parameter Name="CONSECUTIVO" Type="Int64" />
            <asp:Parameter Name="CodigoPais" Type="String" />
            <asp:Parameter Name="CodigoTecnologia" Type="Int32" />
            <asp:Parameter Name="CodigoSociedad" Type="Int32" />
            <asp:Parameter Name="CodigoTema" Type="Int32" />
            <asp:Parameter Name="OrigenEvento" Type="String" />
            <asp:Parameter Name="CodigoTipoRiesgo" Type="Int32" />
            <asp:Parameter Name="CodigoRecurrencia" Type="Int32" />
            <asp:Parameter Name="CodigoEfecto" Type="Int32" />
            <asp:Parameter Name="MontoImpactoUNAPeriodo" Type="Int32" />
            <asp:Parameter Name="MontoImpactoCajaPeriodo" Type="Int32" />
            <asp:Parameter Name="MontoImpactoUNALP" Type="Int32" />
            <asp:Parameter Name="MontoImpactoCajaLP" Type="Int32" />
            <asp:Parameter Name="CodigoProbabilidadOcurrenciaRiesgoInherente" Type="Int32" />
            <asp:Parameter Name="MontoImpactoRiesgoInherente" Type="Int32" />
            <asp:Parameter Name="Mitigadores" Type="String" />
            <asp:Parameter Name="CodigoProbabilidadOcurrenciaRiesgoResidual" Type="Int32" />
            <asp:Parameter Name="MontoImpactoRiesgoResidualUNA" Type="Int32" />
            <asp:Parameter Name="MontoImpactoRiesgoResidualFlujo" Type="Int32" />
            <asp:Parameter DbType="Date" Name="PlazoResolucion" />
            <asp:Parameter Name="AccionesCursoEnergia" Type="String" />
            <asp:Parameter Name="AccionesAltoNivel" Type="String" />
            <asp:Parameter DefaultValue="2" Name="CodigoTipoProceso" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="CodigoError" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="MensajeError" Size="500" Type="String" />
            <asp:Parameter Name="CodigoEstadoPalanca" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <dx:ASPxPivotGridExporter ID="ASPxPivExp1" runat="server" ASPxPivotGridID="PivotVenta">
        <OptionsPrint MergeColumnFieldValues="False" MergeRowFieldValues="False" PrintHorzLines="True" PrintVertLines="False" VerticalContentSplitting="Exact">
        </OptionsPrint>
    </dx:ASPxPivotGridExporter>
    <asp:SqlDataSource ID="SQLConfiguracionCampos" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT 	(CodigoMenu + '-' + CAST(CodigoEmpresa AS NVARCHAR) + '-' + NombreCampo) AS CONSECUTIVO
	, CodigoMenu
	, CodigoEmpresa
	, NombreCampo
	, VisibleLectura
	, VisibleEscritura
FROM Portal.dbo.Campos
WHERE VisibleDB=1
	AND CodigoMenu='10.1'
	AND CodigoEmpresa=1
	AND (VisibleLectura=0 OR VisibleEscritura=0)
ORDER BY 
	CodigoMenu
	, CodigoEmpresa
	, NombreCampo">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="Portal.dbo.SPTraeCompanias" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep
" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter DefaultValue="1" Name="PModulo" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLPeriodos" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="  SELECT PeriodoFormato AS Periodo
  FROM PORTAL.General.AllFechas
  GROUP BY PeriodoFormato
  ORDER BY 1">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLPaises" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Cod_Pais
      , Pais
FROM Portal.Presupuesto.Pais">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLTecnologias" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CodigoTecnologia
	, Tecnologia
FROM Portal.PValor.Tecnologias
WHERE Activo=1">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLSociedades" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CodigoSociedad
	, Sociedad
FROM Portal.PValor.Sociedades
WHERE Activo=1">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLTemas" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CodigoTema
	, Tema
FROM Portal.PValor.Temas
WHERE CodigoEstadoPalanca=0">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLTiposRiesgo" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CodigoTipoRiesgo
	, TipoRiesgo
FROM Portal.PValor.TiposRiesgo
WHERE Activo=1">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLResponsables" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT 
	Resp.CodigoResponsable
	, (Resp.Usuario + ' ' + Usu.Nombre) AS Responsable
FROM Portal.PValor.Responsables AS Resp
INNER JOIN ME.erpadmin.USUARIO AS Usu
ON Resp.Usuario=Usu.Usuario
WHERE Resp.Activo=1">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLRecurrencias" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CodigoRecurrencia
	, Recurrencia
FROM Portal.PValor.Recurrencias
WHERE Activo=1">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLEfectos" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand=" SELECT CodigoEfecto
	, Efecto
FROM Portal.PValor.Efectos
WHERE Activo=1">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLImpactos" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CodigoImpacto
	, (CAST(PesoImpacto AS VARCHAR(2)) + '-' + Impacto) AS Impacto
	, PesoImpacto
FROM Portal.PValor.Impactos
WHERE Activo=1
ORDER BY PesoImpacto ASC">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLProbabilidades" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CodigoProbabilidad
	, (CAST(PesoProbabilidad AS VARCHAR(2)) + '-' + Probabilidad) AS Probabilidad
	, PesoProbabilidad
FROM Portal.PValor.Probabilidades
WHERE Activo=1
ORDER BY PesoProbabilidad DESC">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLCriticidades" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CodigoCriticidad
	, (CAST(CodigoCriticidad AS NVARCHAR) + ' - ' + Criticidad) AS Criticidad
FROM Portal.PValor.Criticidades
WHERE Activo=1
ORDER BY CodigoCriticidad DESC">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLEstadosPalanca" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CodigoEstadoPalanca
	, EstadoPalanca
FROM Portal.PValor.EstadosPalanca
WHERE Activo=1">
    </asp:SqlDataSource>
    <br />
    <br />
    <br />
    <br />
    <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Small" Text="              Palancas"></asp:Label>
    <br />
     <dx:ASPxGridView ID="GridPalancas" runat="server" AutoGenerateColumns="False" DataSourceID="SQLPalancas"  KeyFieldName="CONSECUTIVO" Theme="SoftOrange" OnBeforeGetCallbackResult="GridPalancas_BeforeGetCallbackResult" OnLoad="GridPalancas_Load">
         <SettingsEditing EditFormColumnCount="1" Mode="PopupEditForm">
         </SettingsEditing>
        <Settings ShowFilterRow="True" />
         <SettingsResizing ColumnResizeMode="Control" />
<SettingsPopup>
    <EditForm HorizontalAlign="LeftSides" ShowMaximizeButton="True" Width="1000px">
    </EditForm>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>


            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0" Width="80px">
            </dx:GridViewCommandColumn>

<%--            <dx:GridViewDataTextColumn FieldName="CONSECUTIVO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1" ReadOnly="True">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>--%>

           <dx:GridViewDataComboBoxColumn FieldName="Periodo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2" Width="70px">
                <PropertiesComboBox DataSourceID="SQLPeriodos" TextField="Periodo" ValueField="Periodo">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
                <ExportCellStyle HorizontalAlign="Center">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoPais" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3" Caption="Pais" Width="100px">
                <PropertiesComboBox DataSourceID="SQLPaises" TextField="Pais" ValueField="Cod_Pais">
                </PropertiesComboBox>
                <ExportCellStyle HorizontalAlign="Center">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoTecnologia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4" Caption="Tecnologia" Width="100px">
                <PropertiesComboBox DataSourceID="SQLTecnologias" TextField="Tecnologia" ValueField="CodigoTecnologia">
                </PropertiesComboBox>
                <ExportCellStyle HorizontalAlign="Center">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoSociedad" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5" Caption="Sociedades" Width="100px">
                <PropertiesComboBox DataSourceID="SQLSociedades" TextField="Sociedad" ValueField="CodigoSociedad">
                </PropertiesComboBox>
                <ExportCellStyle HorizontalAlign="Center">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoTema" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6" Caption="Temas" Width="100px">
                <PropertiesComboBox DataSourceID="SQLTemas" TextField="Tema" ValueField="CodigoTema">
                </PropertiesComboBox>
                <ExportCellStyle HorizontalAlign="Center">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>
                    <dx:GridViewDataMemoColumn FieldName="OrigenEvento" VisibleIndex="7" Width="100px" Caption="Origen / Estatus">
                        <PropertiesMemoEdit Height="80px" MaxLength="500" Width="800px">
                            <Style Wrap="True">
                            </Style>
                        </PropertiesMemoEdit>
                        <Settings AllowEllipsisInText="True" />
                        <HeaderStyle Wrap="True" />
                        <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                        </ExportCellStyle>
                    </dx:GridViewDataMemoColumn>

            <dx:GridViewDataComboBoxColumn FieldName="CodigoTipoRiesgo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8" Caption="Tipo Riesgo" Width="100px">
                <PropertiesComboBox DataSourceID="SQLTiposRiesgo" TextField="TipoRiesgo" ValueField="CodigoTipoRiesgo">
                </PropertiesComboBox>
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoResponsable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9" Caption="Responsable" Width="140px">
                <PropertiesComboBox DataSourceID="SQLResponsables" TextField="Responsable" ValueField="CodigoResponsable">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
                <ExportCellStyle HorizontalAlign="Center">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="CodigoRecurrencia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="10" Caption="Recurrencia" Width="100px">
                <PropertiesComboBox DataSourceID="SQLRecurrencias" TextField="Recurrencia" ValueField="CodigoRecurrencia">
                </PropertiesComboBox>
                <ExportCellStyle HorizontalAlign="Center">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>
            
            <dx:GridViewDataComboBoxColumn FieldName="CodigoEfecto" LoadReadOnlyValueFromDataModel="True" VisibleIndex="11" Caption="Efecto" Width="120px">
                <PropertiesComboBox DataSourceID="SQLEfectos" TextField="Efecto" ValueField="CodigoEfecto">
                </PropertiesComboBox>
                <ExportCellStyle HorizontalAlign="Center">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn FieldName="MontoImpactoUNAPeriodo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="12" Caption="Monto Impacto UNA Periodo (miles)" Width="100px">
                <HeaderStyle Wrap="True" />
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataTextColumn>
<%--            <dx:GridViewDataTextColumn FieldName="CodigoImpactoUNAPeriodo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13" ReadOnly="True">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>--%>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoImpactoUNAPeriodo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13" Caption="Impacto UNA Periodo" Width="110px">
                <PropertiesComboBox DataSourceID="SQLImpactos" TextField="Impacto" ValueField="CodigoImpacto">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>  

            <dx:GridViewDataTextColumn FieldName="MontoImpactoCajaPeriodo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="14" Caption="Monto Impacto Caja Periodo (miles)" Width="100px">
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataTextColumn>
            
<%--            <dx:GridViewDataTextColumn FieldName="CodigoImpactoCajaPeriodo" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="15">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>--%>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoImpactoCajaPeriodo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15" Caption="Impacto Caja Periodo" Width="110px">
                <PropertiesComboBox DataSourceID="SQLImpactos" TextField="Impacto" ValueField="CodigoImpacto">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn FieldName="MontoImpactoUNALP" LoadReadOnlyValueFromDataModel="True" VisibleIndex="16" Caption="Monto Impacto UNA LP (miles)" Width="100px">
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataTextColumn>
<%--            <dx:GridViewDataTextColumn FieldName="CodigoImpactoUNALP" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="17">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>--%>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoImpactoUNALP" LoadReadOnlyValueFromDataModel="True" VisibleIndex="17" Caption="Impacto UNA LP" Width="110px">
                <PropertiesComboBox DataSourceID="SQLImpactos" TextField="Impacto" ValueField="CodigoImpacto">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn FieldName="MontoImpactoCajaLP" LoadReadOnlyValueFromDataModel="True" VisibleIndex="18" Caption="Monto Impacto Caja LP (miles)" Width="100px">
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataTextColumn>
<%--            <dx:GridViewDataTextColumn FieldName="CodigoImpactoCajaLP" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="19">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>--%>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoImpactoCajaLP" LoadReadOnlyValueFromDataModel="True" VisibleIndex="19" Caption="Impacto Caja LP" Width="110px">
                <PropertiesComboBox DataSourceID="SQLImpactos" TextField="Impacto" ValueField="CodigoImpacto">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>

<%--            <dx:GridViewDataTextColumn FieldName="CodigoProbabilidadOcurrenciaRiesgoInherente" LoadReadOnlyValueFromDataModel="True" VisibleIndex="20">
            </dx:GridViewDataTextColumn>--%>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoProbabilidadOcurrenciaRiesgoInherente" LoadReadOnlyValueFromDataModel="True" VisibleIndex="20" Caption="Probabilidad Ocurrencia Riesgo Inherente" Width="120px">
                <PropertiesComboBox DataSourceID="SQLProbabilidades" TextField="Probabilidad" ValueField="CodigoProbabilidad">
                </PropertiesComboBox>
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn FieldName="MontoImpactoRiesgoInherente" LoadReadOnlyValueFromDataModel="True" VisibleIndex="21" Caption="Monto Impacto Riesgo Inherente (miles)" Width="100px">
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataTextColumn>
<%--            <dx:GridViewDataTextColumn FieldName="CodigoImpactoRiesgoInherente" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="22">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>--%>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoImpactoRiesgoInherente" LoadReadOnlyValueFromDataModel="True" VisibleIndex="22" Caption="Impacto Riesgo Inherente" Width="110px">
                <PropertiesComboBox DataSourceID="SQLImpactos" TextField="Impacto" ValueField="CodigoImpacto">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>

<%--            <dx:GridViewDataTextColumn FieldName="CodigoCriticidadRiesgoInherente01" LoadReadOnlyValueFromDataModel="True" VisibleIndex="23">
            </dx:GridViewDataTextColumn>--%>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoCriticidadRiesgoInherente01" ReadOnly="True" LoadReadOnlyValueFromDataModel="True" VisibleIndex="23" Caption="Indice Criticidad Riesgo Inherente" Width="170px">
                <PropertiesComboBox DataSourceID="SQLCriticidades" TextField="Criticidad" ValueField="CodigoCriticidad">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn FieldName="CodigoCriticidadRiesgoInherente02" LoadReadOnlyValueFromDataModel="True" VisibleIndex="24" Caption="Criticidad Riesgo Inherente" Width="80px">
                <EditFormSettings Visible="False" />
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataTextColumn>
<%--            <dx:GridViewDataComboBoxColumn FieldName="CodigoCriticidadRiesgoInherente02" ReadOnly="True" LoadReadOnlyValueFromDataModel="True" VisibleIndex="24" Caption="CriticidadRiesgoInherente" Width="140px">
                <PropertiesComboBox DataSourceID="SQLCriticidades" TextField="Criticidad" ValueField="CodigoCriticidad">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataComboBoxColumn>--%>

<%--            <dx:GridViewDataTextColumn FieldName="Mitigadores" LoadReadOnlyValueFromDataModel="True" VisibleIndex="25">
            </dx:GridViewDataTextColumn>--%>
                    <dx:GridViewDataMemoColumn FieldName="Mitigadores" VisibleIndex="25" Width="100px">
                        <PropertiesMemoEdit Height="80px" MaxLength="500">
                            <Style Wrap="True">
                            </Style>
                        </PropertiesMemoEdit>
                        <Settings AllowEllipsisInText="True" />
                        <ExportCellStyle HorizontalAlign="Center">
                        </ExportCellStyle>
                    </dx:GridViewDataMemoColumn>

<%--            <dx:GridViewDataTextColumn FieldName="CodigoProbabilidadOcurrenciaRiesgoResidual" LoadReadOnlyValueFromDataModel="True" VisibleIndex="26">
            </dx:GridViewDataTextColumn>--%>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoProbabilidadOcurrenciaRiesgoResidual" LoadReadOnlyValueFromDataModel="True" VisibleIndex="26" Caption="Probabilidad Ocurrencia Riesgo Residual" Width="100px">
                <PropertiesComboBox DataSourceID="SQLProbabilidades" TextField="Probabilidad" ValueField="CodigoProbabilidad">
                </PropertiesComboBox>
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn FieldName="MontoImpactoRiesgoResidualUNA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="27" Caption="Monto Impacto Riesgo Residual UNA (miles)" Width="100px">
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataTextColumn>
<%--            <dx:GridViewDataTextColumn FieldName="CodigoImpactoRiesgoResidualUNA" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="28">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>--%>
            
            <dx:GridViewDataComboBoxColumn FieldName="CodigoImpactoRiesgoResidualUNA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="28" Caption="Impacto Riesgo Residual UNA" Width="100px">
                <PropertiesComboBox DataSourceID="SQLImpactos" TextField="Impacto" ValueField="CodigoImpacto">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn FieldName="MontoImpactoRiesgoResidualFlujo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="29" Caption="Monto Impacto Riesgo Residual Flujo (miles)" Width="100px">
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataTextColumn>
<%--            <dx:GridViewDataTextColumn FieldName="CodigoImpactoRiesgoResidualFlujo" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="30">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>--%>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoImpactoRiesgoResidualFlujo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="30" Caption="Impacto Riesgo Residual Flujo" Width="100px">
                <PropertiesComboBox DataSourceID="SQLImpactos" TextField="Impacto" ValueField="CodigoImpacto">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>

<%--            <dx:GridViewDataTextColumn FieldName="CodigoCriticidadRiesgoResidual01" LoadReadOnlyValueFromDataModel="True" VisibleIndex="31">
            </dx:GridViewDataTextColumn>--%>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoCriticidadRiesgoResidual01" ReadOnly="True" LoadReadOnlyValueFromDataModel="True" VisibleIndex="31" Caption="Indice Criticidad Riesgo Residual" Width="170px">
                <PropertiesComboBox DataSourceID="SQLCriticidades" TextField="Criticidad" ValueField="CodigoCriticidad">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn FieldName="CodigoCriticidadRiesgoResidual02" LoadReadOnlyValueFromDataModel="True" VisibleIndex="32" Caption="Criticidad Riesgo Residual" Width="80px" ReadOnly="True">
                <EditFormSettings Visible="False" />
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataTextColumn>
<%--            <dx:GridViewDataComboBoxColumn FieldName="CodigoCriticidadRiesgoResidual02" ReadOnly="True" LoadReadOnlyValueFromDataModel="True" VisibleIndex="32" Caption="CriticidadRiesgoResidual" Width="120px">
                <PropertiesComboBox DataSourceID="SQLCriticidades" TextField="Criticidad" ValueField="CodigoCriticidad">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataComboBoxColumn>--%>


            
            <dx:GridViewDataDateColumn FieldName="PlazoResolucion" LoadReadOnlyValueFromDataModel="True" VisibleIndex="33" Width="100px" Caption="Plazo Resolucion">
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataDateColumn>
<%--                    <dx:GridViewDataTextColumn FieldName="AccionesCursoEnergia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="34">
            </dx:GridViewDataTextColumn>--%>
                    <dx:GridViewDataMemoColumn FieldName="AccionesCursoEnergia" VisibleIndex="34" Width="100px" Caption="Acciones Curso Energia">
                        <PropertiesMemoEdit Height="80px" MaxLength="500">
                        </PropertiesMemoEdit>
                        <Settings AllowEllipsisInText="True" />
                        <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                        </ExportCellStyle>
                    </dx:GridViewDataMemoColumn>

<%--            <dx:GridViewDataTextColumn FieldName="AccionesAltoNivel" LoadReadOnlyValueFromDataModel="True" VisibleIndex="35">
            </dx:GridViewDataTextColumn>--%>
                    <dx:GridViewDataMemoColumn FieldName="AccionesAltoNivel" VisibleIndex="35" Width="100px" Caption="Acciones Alto Nivel">
                        <PropertiesMemoEdit Height="80px" MaxLength="500">
                            <Style Wrap="True">
                            </Style>
                        </PropertiesMemoEdit>
                        <Settings AllowEllipsisInText="True" />
                        <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                        </ExportCellStyle>
                    </dx:GridViewDataMemoColumn>

<%--            <dx:GridViewDataTextColumn FieldName="CodigoEstadoPalanca" LoadReadOnlyValueFromDataModel="True" VisibleIndex="36">
            </dx:GridViewDataTextColumn>--%>
            <dx:GridViewDataComboBoxColumn FieldName="CodigoEstadoPalanca" LoadReadOnlyValueFromDataModel="True" VisibleIndex="36" Caption="Estado Palanca">
                <PropertiesComboBox DataSourceID="SQLEstadosPalanca" TextField="EstadoPalanca" ValueField="CodigoEstadoPalanca">
                </PropertiesComboBox>
                <ExportCellStyle HorizontalAlign="Center" Wrap="True">
                </ExportCellStyle>
            </dx:GridViewDataComboBoxColumn>

        </Columns>
    </dx:ASPxGridView>


             <br />
    <br />
    <br />
    <br />


             </asp:Content>
