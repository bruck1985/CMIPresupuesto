<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Conciliacion_Intercompany.aspx.cs" Inherits="UI.Web.Conciliacion_Intercompany" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
         function OnClick(s, e, catCiaCtaID) {
             Popup.Show();
        }
    </script>
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Conciliacion Intercompany"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="93px" Theme="SoftOrange" Width="60%">
        <Items>
            <dx:LayoutGroup ColCount="5" ColSpan="1" ColumnCount="5" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Fecha Inicial          " ColSpan="1" Name="FechaInicial" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="FechaInicial" runat="server" Date="2020-03-17" Theme="SoftOrange" Width="90px" DisplayFormatString="dd/MM/yyyy">
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Fecha Final" ColSpan="1" Name="FechaFinal" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="FechaFinal" runat="server" Date="2020-03-17" Theme="SoftOrange" DisplayFormatString="dd/MM/yyyy" Width="90px">
                                    <DateRangeSettings MaxLength="10" />
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="CB_Tipo_Reporte">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="tiporep" runat="server" SelectedIndex="0" Theme="SoftOrange" Width="70px">
                                    <Items>
                                        <dx:ListEditItem Selected="True" Text="CC-CP" Value="C" />
                                        <dx:ListEditItem Text="INVER-PATRI" Value="I" />
                                        <dx:ListEditItem Text="GASTOS-INGRESOS" Value="G" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Width="32px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_Click" Theme="SoftOrange" Width="32px">
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
                    <dx:LayoutItem Caption="Cia Origen" ColSpan="1" Name="CiaOrigen" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="CiaOri" runat="server" DataSourceID="SQLCompania" TextField="nombre" Theme="SoftOrange" ValueField="conjunto" Width="203px">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Cia Conciliar" ColSpan="1" Name="CiaDestino" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="CiaDes" runat="server" DataSourceID="SQLCompania" TextField="nombre" Theme="SoftOrange" ValueField="conjunto" Width="203px">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLComparacion" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_CONCILIACION_INTERCOMPANY]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="ci_scia1" />
            <asp:SessionParameter DefaultValue="%" Name="PCia2" SessionField="ci_scia2" />
            <asp:SessionParameter DefaultValue="20200201" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="20200330" Name="Pfechafin" SessionField="ci_sfec2" />
            <asp:SessionParameter DefaultValue="C"  Name="Ptipo_reporte"  SessionField="ci_stipo"/>
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridView ID="grid_data"  ClientInstanceName="MasterGrid" runat="server" Width="1324px" AutoGenerateColumns="False" DataSourceID="SQLComparacion" Theme="SoftOrange" KeyFieldName="cuentakey" >
        <ClientSideEvents CustomButtonClick="function(s, e) {  visibleIndex = MasterGrid.GetRowKey(e.visibleIndex);  if (e.buttonID == 'btdet1') {Popup.PerformCallback(visibleIndex); Popup.Show(); }  
          if (e.buttonID == 'btdet2') {Popup2.PerformCallback(visibleIndex); Popup2.Show(); }  }" />
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="CIA" VisibleIndex="1" ShowInCustomizationForm="True" Caption="Cia Origen">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Cuenta_Contable" VisibleIndex="2" ShowInCustomizationForm="True" Caption="Cta Origen">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Descripcion" VisibleIndex="3" ShowInCustomizationForm="True" Caption="Desc Cia Ori">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Saldo_Final" VisibleIndex="4" ShowInCustomizationForm="True" Caption="Saldo Origen">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CIA2" VisibleIndex="5" ShowInCustomizationForm="True" Caption="Cia Destino">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Cuenta_Contable2" VisibleIndex="6" ShowInCustomizationForm="True" Caption="Cta Destino">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Descripcion2" VisibleIndex="7" ShowInCustomizationForm="True" Caption="Desc Cta Dest">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Saldo_Final2" VisibleIndex="8" ShowInCustomizationForm="True" Caption="Saldo Destino">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Diferencia" VisibleIndex="9" ShowInCustomizationForm="True" Caption="Diferencia">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Cambio_Neto1" VisibleIndex="10" ShowInCustomizationForm="True" Caption="Cambio_Neto1">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Cambio_Neto2" VisibleIndex="11" ShowInCustomizationForm="True" Caption="Cambio_Neto2">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Diferencia_Neta" VisibleIndex="12" ShowInCustomizationForm="True" Caption="Diferencia_Neta">
                <PropertiesTextEdit DisplayFormatString="###.00">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="cuentakey" ShowInCustomizationForm="False" Visible="False" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewCommandColumn ButtonRenderMode="Image" ButtonType="Image" VisibleIndex="13">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btdet1" Text ="Detalle Cia1">
                        <Image IconID="spreadsheet_whitegreencolorscale_svg_16x16">
                        </Image>
                    </dx:GridViewCommandColumnCustomButton>
                    <dx:GridViewCommandColumnCustomButton ID="btdet2" Text ="Detalle Cia2">
                        <Image IconID="spreadsheet_whiteredcolorscale_svg_16x16">
                        </Image>
                    </dx:GridViewCommandColumnCustomButton>
                </CustomButtons>
            </dx:GridViewCommandColumn>
        </Columns>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="select '%' conjunto, ' Todas' nombre
union all
Select conjunto, nombre from erpadmin.conjunto Where conjunto not in ('Install','ERPADMIN','XPRUEBAS')"></asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="grid_data_exp" runat="server" FileName="Conciliacion_intercompany" GridViewID="grid_data">
    </dx:ASPxGridViewExporter>
    <dx:ASPxPopupControl ID="Popup" ClientInstanceName="Popup" runat="server" ShowCloseButton="false" CloseAction="OuterMouseClick"
                OnWindowCallback="Popup_WindowCallback" Modal="true" PopupAction="None" PopupElementID="MasterGrid" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle" AllowDragging="True" HeaderText="Detalle de la Cia 1">
        <ContentCollection>
   <dx:PopupControlContentControl runat="server">
       <dx:ASPxButton ID="ExportExcel1" runat="server" OnClick="ExportExcel1_Click" Text="Export Excel">
           <Image Url="~/Imagenes/Excel.jpg">
           </Image>
       </dx:ASPxButton>
    <br />
    <div> 
    <dx:ASPxPivotGrid ID="PivotDetalleCta1" runat="server" ClientIDMode="AutoID" DataSourceID="SQL_Data_CTA_Detalle1" OnInit="DetailGrid_Init">
        <Fields>
            <dx:PivotGridField ID="fielddebitodolar" Area="DataArea" AreaIndex="0" FieldName="debito_dolar" Name="fielddebitodolar" CellFormat-FormatString="###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="###.00" TotalValueFormat-FormatType="Numeric">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldcreditodolar" Area="DataArea" AreaIndex="1" FieldName="credito_dolar" Name="fieldcreditodolar" CellFormat-FormatString="###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="###.00" TotalValueFormat-FormatType="Numeric">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFecha" Area="RowArea" AreaIndex="1" FieldName="Fecha" Name="fieldFecha" CellFormat-FormatString="d" CellFormat-FormatType="DateTime" ValueFormat-FormatString="d" ValueFormat-FormatType="DateTime">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldAsiento" Area="RowArea" AreaIndex="2" FieldName="Asiento" Name="fieldAsiento">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCIA" Area="RowArea" AreaIndex="0" FieldName="CIA" Name="fieldCIA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldfuente" Area="RowArea" AreaIndex="3" FieldName="fuente" Name="fieldfuente">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCentrocosto" AreaIndex="0" FieldName="Centro_costo" Name="fieldCentrocosto">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldreferencia" AreaIndex="1" FieldName="referencia" Name="fieldreferencia">
            </dx:PivotGridField>
        </Fields>
    </dx:ASPxPivotGrid>
        </div>
    <div>
        <asp:SqlDataSource ID="SQL_Data_CTA_Detalle1" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="portal.[dbo].[PORTAL_CONCILIACION_INTERCOMPANY_DET]"  SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="AER" Name="PCia1" SessionField="CI_Det_Cia1" />
                <asp:SessionParameter DefaultValue="103-04-02-01-07" Name="PCta" SessionField="CI_Det_Cta1" />
                <asp:SessionParameter DefaultValue="01/01/2019" Name="Pfechaini" SessionField="ci_sfec1" />
                <asp:SessionParameter DefaultValue="01/05/2020" Name="Pfechafin" SessionField="ci_sfec2" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxPivotGridExporter ID="ASPxPivotGridExp1" runat="server" ASPxPivotGridID="PivotDetalleCta1">
        </dx:ASPxPivotGridExporter>
        </div>
            </dx:PopupControlContentControl>
     </ContentCollection>
    </dx:ASPxPopupControl>

        <dx:ASPxPopupControl ID="ASPxPopupControl2" ClientInstanceName="Popup2" runat="server" ShowCloseButton="false" CloseAction="OuterMouseClick"
                OnWindowCallback="Popup_WindowCallback2" Modal="true" PopupAction="None" PopupElementID="MasterGrid" PopupHorizontalAlign="OutsideRight" PopupVerticalAlign="Middle" AllowDragging="True" HeaderText="Detalle de la Cia 2">
        <ContentCollection>
     <dx:PopupControlContentControl runat="server">
         <dx:ASPxButton ID="ExportExcel2" runat="server" OnClick="ExportExcel2_Click" Text="Export Excel">
             <Image Url="~/Imagenes/Excel.jpg">
             </Image>
         </dx:ASPxButton>
    <br />
    <div> 
  <dx:ASPxPivotGrid ID="PivotDetalleCta2" runat="server" ClientIDMode="AutoID" DataSourceID="SQL_Data_CTA_Detalle2" OnInit="DetailGrid_Init2">
        <Fields>
            <dx:PivotGridField ID="fielddebitodolar2" Area="DataArea" AreaIndex="0" FieldName="debito_dolar" Name="fielddebitodolar" CellFormat-FormatString="###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="###.00" TotalValueFormat-FormatType="Numeric">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldcreditodolar2" Area="DataArea" AreaIndex="1" FieldName="credito_dolar" Name="fieldcreditodolar" CellFormat-FormatString="###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="###.00" TotalValueFormat-FormatType="Numeric">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFecha2" Area="RowArea" AreaIndex="1" FieldName="Fecha" Name="fieldFecha">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldAsiento2" Area="RowArea" AreaIndex="2" FieldName="Asiento" Name="fieldAsiento">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCIA2" Area="RowArea" AreaIndex="0" FieldName="CIA" Name="fieldCIA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldfuente2" Area="RowArea" AreaIndex="3" FieldName="fuente" Name="fieldfuente">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCentrocosto2" AreaIndex="0" FieldName="Centro_costo" Name="fieldCentrocosto">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldreferencia2" AreaIndex="1" FieldName="referencia" Name="fieldreferencia">
            </dx:PivotGridField>
        </Fields>
    </dx:ASPxPivotGrid>
        </div>
    <div>
        <asp:SqlDataSource ID="SQL_Data_CTA_Detalle2" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="portal.[dbo].[PORTAL_CONCILIACION_INTERCOMPANY_DET]"  SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="AER" Name="PCia1" SessionField="CI_Det_Cia2" />
                <asp:SessionParameter DefaultValue="103-04-02-01-07" Name="PCta" SessionField="CI_Det_Cta2" />
                <asp:SessionParameter DefaultValue="01/01/2019" Name="Pfechaini" SessionField="ci_sfec1" />
                <asp:SessionParameter DefaultValue="01/05/2020" Name="Pfechafin" SessionField="ci_sfec2" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxPivotGridExporter ID="ASPxPivotGridExp2" runat="server" ASPxPivotGridID="PivotDetalleCta2">
        </dx:ASPxPivotGridExporter>
        </div>
            </dx:PopupControlContentControl>
     </ContentCollection>
    </dx:ASPxPopupControl>



             </asp:Content>
