<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="PValor_PalancaValor.aspx.cs" Inherits="UI.Web.PValor_PalancaValor" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Palancas de valor"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="80px" Theme="SoftOrange" Width="411px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Defina Parametros" RowSpan="2">
                <Items>
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
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLRubros" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT RUBRO_CONTABLE, DESCRIPCION
  FROM [PORTAL].[Presupuesto].[RUBRO_CONTABLE]
  order by 1">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLTipoGasto" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT TIPO_GASTO, DESCRIPCION, ESTADO
  FROM [PORTAL].[Presupuesto].[TIPO_GASTO]
  order by 1">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLERP" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [ERP]
      ,[DESCRIPCION]
  FROM [PORTAL].[Presupuesto].[ERP]
  order by 1">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLCMI_Mapping" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CMI_MAPPING,[CMI_MAPPING] DESCRIPCION
  FROM [PORTAL].[Presupuesto].[CMI_MAPPING]
  order by 1">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLCuentaContable" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT 
	CONSECUTIVO
	, Periodo
	, Pais
	, CodigoTecnologia
	, CodigoSociedad
	, CodigoTema
	, OrigenEvento
	, CodigoTipoRiesgo
	, CodigoResponsable
	, EstatusActual
	, CodigoRecurrencia
	, Efecto
	, ImpactoUNAPeriodo
	, ImpactoCajaPeriodo
	, ImpactoUNALP
	, ImpactoCajaLP
	, ProbabilidadOcurrenciaRiesgoInherente
	, ImpactoRiesgoInherente
	, CriticidadRiesgoInherente
	, Mitigadores
	, ProbabilidadOcurrenciaRiesgoResidual
	, ImpactoRiesgoResidualUNA
	, ImpactoRiesgoResidualFlujo
	, CriticidadRiesgoResidual
	, PlazoResolucion
	, AccionesCursoEnergia
	, AccionesAltoNivel
	, Estado
FROM PORTAL.PValor.PalancasValor
ORDER BY Periodo, Pais" InsertCommand="INSERT INTO PORTAL.PValor.PALANCA_VALOR
(
	Periodo
	, Pais
	, CodigoTecnologia
	, CodigoSociedad
	, CodigoTema
	, OrigenEvento
	, CodigoTipoRiesgo
	, CodigoResponsable
	, EstatusActual
	, CodigoRecurrencia
	, Efecto
	, ImpactoUNAPeriodo
	, ImpactoCajaPeriodo
	, ImpactoUNALP
	, ImpactoCajaLP
	, ProbabilidadOcurrenciaRiesgoInherente
	, ImpactoRiesgoInherente
	, CriticidadRiesgoInherente
	, Mitigadores
	, ProbabilidadOcurrenciaRiesgoResidual
	, ImpactoRiesgoResidualUNA
	, ImpactoRiesgoResidualFlujo
	, CriticidadRiesgoResidual
	, PlazoResolucion
	, AccionesCursoEnergia
	, AccionesAltoNivel
	, Estado
)
VALUES
(
	@Periodo
	, @Pais
	, @CodigoTecnologia
	, @CodigoSociedad
	, @CodigoTema
	, @OrigenEvento
	, @CodigoTipoRiesgo
	, @CodigoResponsable
	, @EstatusActual
	, @CodigoRecurrencia
	, @Efecto
	, @ImpactoUNAPeriodo
	, @ImpactoCajaPeriodo
	, @ImpactoUNALP
	, @ImpactoCajaLP
	, @ProbabilidadOcurrenciaRiesgoInherente
	, @ImpactoRiesgoInherente
	, @CriticidadRiesgoInherente
	, @Mitigadores
	, @ProbabilidadOcurrenciaRiesgoResidual
	, @ImpactoRiesgoResidualUNA
	, @ImpactoRiesgoResidualFlujo
	, @CriticidadRiesgoResidual
	, @PlazoResolucion
	, @AccionesCursoEnergia
	, @AccionesAltoNivel
	, @Estado
)" UpdateCommand="UPDATE PORTAL.PValor.PALANCA_VALOR
SET 
	Periodo=@Periodo
	AND Pais=@Pais
	AND CodigoTecnologia=@CodigoTecnologia
	AND CodigoSociedad=@CodigoSociedad
	AND CodigoTema=@CodigoTema
	AND OrigenEvento=@OrigenEvento
	AND CodigoTipoRiesgo=@CodigoTipoRiesgo
	AND CodigoResponsable=@CodigoResponsable
	AND EstatusActual=@EstatusActual
	AND CodigoRecurrencia=@CodigoRecurrencia
	AND Efecto=@Efecto
	AND ImpactoUNAPeriodo=@ImpactoUNAPeriodo
	AND ImpactoCajaPeriodo=@ImpactoCajaPeriodo
	AND ImpactoUNALP=@ImpactoUNALP
	AND ImpactoCajaLP=@ImpactoCajaLP
	AND ProbabilidadOcurrenciaRiesgoInherente=@ProbabilidadOcurrenciaRiesgoInherente
	AND ImpactoRiesgoInherente=@ImpactoRiesgoInherente
	--AND CriticidadRiesgoInherente=@CriticidadRiesgoInherente
	AND Mitigadores=@Mitigadores
	AND ProbabilidadOcurrenciaRiesgoResidual=@ProbabilidadOcurrenciaRiesgoResidual
	AND ImpactoRiesgoResidualUNA=@ImpactoRiesgoResidualUNA
	AND ImpactoRiesgoResidualFlujo=@ImpactoRiesgoResidualFlujo
	AND CriticidadRiesgoResidual=@CriticidadRiesgoResidual
	AND PlazoResolucion=@PlazoResolucion
	AND AccionesCursoEnergia=@AccionesCursoEnergia
	AND AccionesAltoNivel=@AccionesAltoNivel
	AND Estado=@Estado
WHERE CONSECUTIVO=@CONSECUTIVO">
        <InsertParameters>
            <asp:Parameter Name="Periodo" />
            <asp:Parameter Name="Pais" />
            <asp:Parameter Name="CodigoTecnologia" />
            <asp:Parameter Name="CodigoSociedad" />
            <asp:Parameter Name="CodigoTema" />
            <asp:Parameter Name="OrigenEvento" />
            <asp:Parameter Name="CodigoTipoRiesgo" />
            <asp:Parameter Name="CodigoResponsable" />
            <asp:Parameter Name="EstatusActual" />
            <asp:Parameter Name="CodigoRecurrencia" />
            <asp:Parameter Name="Efecto" />
            <asp:Parameter Name="ImpactoUNAPeriodo" />
            <asp:Parameter Name="ImpactoCajaPeriodo" />
            <asp:Parameter Name="ImpactoUNALP" />
            <asp:Parameter Name="ImpactoCajaLP" />
            <asp:Parameter Name="ProbabilidadOcurrenciaRiesgoInherente" />
            <asp:Parameter Name="ImpactoRiesgoInherente" />
            <asp:Parameter Name="CriticidadRiesgoInherente" />
            <asp:Parameter Name="Mitigadores" />
            <asp:Parameter Name="ProbabilidadOcurrenciaRiesgoResidual" />
            <asp:Parameter Name="ImpactoRiesgoResidualUNA" />
            <asp:Parameter Name="ImpactoRiesgoResidualFlujo" />
            <asp:Parameter Name="CriticidadRiesgoResidual" />
            <asp:Parameter Name="PlazoResolucion" />
            <asp:Parameter Name="AccionesCursoEnergia" />
            <asp:Parameter Name="AccionesAltoNivel" />
            <asp:Parameter Name="Estado" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Periodo" />
            <asp:Parameter Name="Pais" />
            <asp:Parameter Name="CodigoTecnologia" />
            <asp:Parameter Name="CodigoSociedad" />
            <asp:Parameter Name="CodigoTema" />
            <asp:Parameter Name="OrigenEvento" />
            <asp:Parameter Name="CodigoTipoRiesgo" />
            <asp:Parameter Name="CodigoResponsable" />
            <asp:Parameter Name="EstatusActual" />
            <asp:Parameter Name="CodigoRecurrencia" />
            <asp:Parameter Name="Efecto" />
            <asp:Parameter Name="ImpactoUNAPeriodo" />
            <asp:Parameter Name="ImpactoCajaPeriodo" />
            <asp:Parameter Name="ImpactoUNALP" />
            <asp:Parameter Name="ImpactoCajaLP" />
            <asp:Parameter Name="ProbabilidadOcurrenciaRiesgoInherente" />
            <asp:Parameter Name="ImpactoRiesgoInherente" />
            <asp:Parameter Name="CriticidadRiesgoInherente" />
            <asp:Parameter Name="Mitigadores" />
            <asp:Parameter Name="ProbabilidadOcurrenciaRiesgoResidual" />
            <asp:Parameter Name="ImpactoRiesgoResidualUNA" />
            <asp:Parameter Name="ImpactoRiesgoResidualFlujo" />
            <asp:Parameter Name="CriticidadRiesgoResidual" />
            <asp:Parameter Name="PlazoResolucion" />
            <asp:Parameter Name="AccionesCursoEnergia" />
            <asp:Parameter Name="AccionesAltoNivel" />
            <asp:Parameter Name="Estado" />
            <asp:Parameter Name="CONSECUTIVO" />
        </UpdateParameters>
    </asp:SqlDataSource>

                <dx:ASPxGridViewExporter runat="server" GridViewID="ASPxGridView1" FileName="Cuenta Contable" ExportedRowType="All" ID="ASPxGridViewExporter1"></dx:ASPxGridViewExporter>

    <br />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SQLCuentaContable" KeyFieldName="CONSECUTIVO" Theme="SoftOrange" Width="427px">
        <Settings ShowFilterRow="True" />
<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="CONSECUTIVO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="1" ReadOnly="True">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Periodo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pais" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CodigoTecnologia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CodigoSociedad" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CodigoTema" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="OrigenEvento" LoadReadOnlyValueFromDataModel="True" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CodigoTipoRiesgo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CodigoResponsable" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="EstatusActual" LoadReadOnlyValueFromDataModel="True" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CodigoRecurrencia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Efecto" LoadReadOnlyValueFromDataModel="True" VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ImpactoUNAPeriodo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ImpactoCajaPeriodo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="14">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ImpactoUNALP" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ImpactoCajaLP" LoadReadOnlyValueFromDataModel="True" VisibleIndex="16">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ProbabilidadOcurrenciaRiesgoInherente" LoadReadOnlyValueFromDataModel="True" VisibleIndex="17">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ImpactoRiesgoInherente" LoadReadOnlyValueFromDataModel="True" VisibleIndex="18">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CriticidadRiesgoInherente" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="19">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Mitigadores" LoadReadOnlyValueFromDataModel="True" VisibleIndex="20">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ProbabilidadOcurrenciaRiesgoResidual" LoadReadOnlyValueFromDataModel="True" VisibleIndex="21">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ImpactoRiesgoResidualUNA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="22">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ImpactoRiesgoResidualFlujo" LoadReadOnlyValueFromDataModel="True" VisibleIndex="23">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CriticidadRiesgoResidual" LoadReadOnlyValueFromDataModel="True" VisibleIndex="24">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="PlazoResolucion" LoadReadOnlyValueFromDataModel="True" VisibleIndex="25">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="AccionesCursoEnergia" LoadReadOnlyValueFromDataModel="True" VisibleIndex="26">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="AccionesAltoNivel" LoadReadOnlyValueFromDataModel="True" VisibleIndex="27">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Estado" LoadReadOnlyValueFromDataModel="True" VisibleIndex="28">
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>
    <br />
        

             </asp:Content>
