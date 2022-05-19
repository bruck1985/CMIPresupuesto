<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Planillapv2.aspx.cs" Inherits="UI.Web.Planillapv2" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Planilla Conceptos"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="956px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Defina Parametros" RowSpan="2">
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
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLPlanilla" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.dbo.PORTAL_PLANILLA" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="IESA YYYYYYYYYYYY" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="01/01/2020" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="02/03/2020" Name="Pfechafin" SessionField="ci_sfec2" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxPivotGridExporter ID="ASPxPivExp1" runat="server" ASPxPivotGridID="PivotCompra">
        <OptionsPrint MergeColumnFieldValues="False" MergeRowFieldValues="False" PrintHorzLines="True" PrintVertLines="False" VerticalContentSplitting="Exact">
        </OptionsPrint>
    </dx:ASPxPivotGridExporter>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM [ME].[erpadmin].[PRIVILEGIO_EX] P, me.erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep
" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxPivotGrid ID="PivotCompra" runat="server" ClientIDMode="AutoID" DataSourceID="SQLPlanilla" Theme="Office365" ClientInstanceName="PivotCompra" OnAfterPerformCallback="ASPxPivotGrid1_AfterPerformCallback">
        <Fields>
            <dx:PivotGridField ID="fieldTOTAL" Area="DataArea" AreaIndex="1" FieldName="TOTAL" Name="fieldTOTAL" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCANTIDAD" Area="DataArea" AreaIndex="0" FieldName="CANTIDAD" Name="fieldCANTIDAD" CellFormat-FormatString="#,###" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###" ValueFormat-FormatString="#,###">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCIA" Area="RowArea" AreaIndex="1" FieldName="CIA" Name="fieldCIA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPAISCIA" Area="RowArea" AreaIndex="0" FieldName="PAIS_CIA" Name="fieldPAISCIA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCENTROCOSTO" Area="RowArea" AreaIndex="3" FieldName="CENTRO_COSTO" Name="fieldCENTROCOSTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCCENTROCOSTO" Area="RowArea" AreaIndex="4" FieldName="DESC_CENTRO_COSTO" Name="fieldDESCCENTROCOSTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCONCEPTO" Area="RowArea" AreaIndex="5" FieldName="CONCEPTO" Name="fieldCONCEPTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCCONCEPTO" Area="RowArea" AreaIndex="6" FieldName="DESC_CONCEPTO" Name="fieldDESCCONCEPTO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNOMINA" Area="RowArea" AreaIndex="7" FieldName="NOMINA" Name="fieldNOMINA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPERIODOFECHA" Area="RowArea" AreaIndex="2" FieldName="PERIODO_FECHA" Name="fieldPERIODOFECHA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPERIODO" Area="ColumnArea" AreaIndex="0" FieldName="PERIODO" Name="fieldPERIODO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDEPARTAMENTO" FieldName="DEPARTAMENTO" Name="fieldDEPARTAMENTO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCDEPARTAMENTO" FieldName="DESC_DEPARTAMENTO" Name="fieldDESCDEPARTAMENTO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldEMPLEADO" FieldName="EMPLEADO" Name="fieldEMPLEADO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNOMBRE" FieldName="NOMBRE" Name="fieldNOMBRE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFORMAAPLICACION" FieldName="FORMA_APLICACION" Name="fieldFORMAAPLICACION" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPOCONCEPTO" FieldName="TIPO_CONCEPTO" Name="fieldTIPOCONCEPTO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNUMERONOMINA" FieldName="NUMERO_NOMINA" Name="fieldNUMERONOMINA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCOSTO_VACACIONES" Area="DataArea" AreaIndex="2" FieldName="COSTO_VACACIONES" Name="fieldCOSTO_VACACIONES" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>

            <dx:PivotGridField ID="fieldVACSPENDIENTES" FieldName="VACS_PENDIENTES" Name="fieldVACSPENDIENTES" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldVACSULTCALCULO" FieldName="VACS_ULT_CALCULO" Name="fieldVACSULTCALCULO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSALARIOREFERENCIA" FieldName="SALARIO_REFERENCIA" Name="fieldSALARIOREFERENCIA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPOSALARIO" FieldName="TIPO_SALARIO" Name="fieldTIPOSALARIO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPONIVELEDUCATIVO" FieldName="TIPO_NIVEL_EDUCATIVO" Name="fieldTIPONIVELEDUCATIVO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSEXO" FieldName="SEXO" Name="fieldSEXO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPOSANGRE" FieldName="TIPO_SANGRE" Name="fieldTIPOSANGRE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTIPONIVELEDUCATIVO1" FieldName="TIPO_NIVEL_EDUCATIVO" Name="fieldTIPONIVELEDUCATIVO1" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldIDENTIFICACION" FieldName="IDENTIFICACION" Name="fieldIDENTIFICACION" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHAINGRESO" FieldName="FECHA_INGRESO" Name="fieldFECHAINGRESO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHASALIDA" FieldName="FECHA_SALIDA" Name="fieldFECHASALIDA" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldFECHANACIMIENTO" FieldName="FECHA_NACIMIENTO" Name="fieldFECHANACIMIENTO" Visible="False">
            </dx:PivotGridField>

        </Fields>
        <ClientSideEvents Init="onInit" EndCallback="onEndCallback" />
    </dx:ASPxPivotGrid>
     <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
     

             </asp:Content>
