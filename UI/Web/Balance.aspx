<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Balance.aspx.cs" Inherits="UI.Web.Balance" %>
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
             var selectedItems = checkListBoxcc.GetSelectedItems();
             checkComboBoxcc.SetText(getSelectedItemsText(selectedItems));
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
    <input runat="server" id="ColumnIndex" type="hidden" enableviewstate="true" />
    <input runat="server" id="RowIndex" type="hidden" enableviewstate="true" />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Balance General"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="1050px" style="margin-top: 0px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Seleccione compañia" ColSpan="1" Name="CiaOrigen" Width="60px">
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
                                  <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E1EXCEL" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_ClickExc" Theme="SoftOrange" Width="32px" ToolTip="Exportar Excel">
                                   <BackgroundImage ImageUrl="~/Imagenes/Excel.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E2" runat="server" AutoPostBack="False" Height="32px" Width="32px" ToolTip="Lista de Campos">
                                    <ClientSideEvents Click="function(s, e) {
	PivotCompra.ChangeCustomizationFieldsVisibility(); return false; 
}" />
                                   <BackgroundImage ImageUrl="~/Imagenes/Lista.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Lista.png">
                        </TabImage>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E3" runat="server" Height="28px" Text="Generar Reporte">
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLConta" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$;connect timeout=0;" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_CONTA_UDF]" SelectCommandType="StoredProcedure" OnSelecting="SQLCompras_Selecting">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="01/01/2020" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="02/03/2020" Name="Pfechafin" SessionField="ci_sfec2" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLConta2" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$;connect timeout=0;" ProviderName="System.Data.SqlClient" SelectCommand="/****** Script para el comando SelectTopNRows de SSMS  ******/
SELECT 'CROMSA' CIA, D.[U_ORDEN_EEFF]
      ,D.[ORDEN_DATA1]
      ,D.[ORDEN_DATA1_TIT]
      ,D.[ORDEN_DATA2]
      ,D.[ORDEN_DATA2_TIT]
      ,D.[ORDEN_DATA3]
      ,D.[ORDEN_DATA3_TIT]
      ,D.[PERIODO]
      ,C.CUENTA_CONTABLE, C.DESCRIPCION, 
      ISNULL(
      (SELECT SUM( DEBITO_FISC_DOLAR-CREDITO_FISC_DOLAR) SALDO_DOLAR FROM ME.CROMSA.SALDO S WHERE S.CUENTA_CONTABLE = C.CUENTA_CONTABLE AND CONVERT(CHAR(6),S.FECHA,112) &lt;= CAST(D.PERIODO AS VARCHAR(6)))
      ,0) SALDO_DOLAR,
      ISNULL(
      (SELECT SUM(DEBITO_FISC_LOCAL-CREDITO_FISC_LOCAL) SALDO_LOCAL FROM ME.CROMSA.SALDO S WHERE S.CUENTA_CONTABLE = C.CUENTA_CONTABLE AND CONVERT(CHAR(6),S.FECHA,112) &lt;= CAST(D.PERIODO AS VARCHAR(6)))
      ,0) SALDO_LOCAL, 0 SALDO_DOLAR_ANT, 0 SALDO_LOCAL_ANT
  FROM [PORTAL].[dbo].[BALANCE_DEF] D LEFT JOIN 
        ME.CROMSA.CUENTA_CONTABLE C ON D.[U_ORDEN_EEFF] = C.[U_ORDEN_EEFF]
  Where periodo = 2019        
UNION ALL
SELECT 'CROMSA' CIA, D.[U_ORDEN_EEFF]
      ,D.[ORDEN_DATA1]
      ,D.[ORDEN_DATA1_TIT]
      ,D.[ORDEN_DATA2]
      ,D.[ORDEN_DATA2_TIT]
      ,D.[ORDEN_DATA3]
      ,D.[ORDEN_DATA3_TIT]
      ,D.[PERIODO]
      ,C.CUENTA_CONTABLE, C.DESCRIPCION, 
      0 SALDO_DOLAR, 0 SALDO_LOCAL,
      ISNULL(
      (SELECT SUM(DEBITO_FISC_DOLAR-CREDITO_FISC_DOLAR) SALDO_DOLAR FROM ME.CROMSA.SALDO S WHERE S.CUENTA_CONTABLE = C.CUENTA_CONTABLE AND CONVERT(CHAR(6),S.FECHA,112) &lt;= CAST(D.PERIODO AS VARCHAR(6)))
      ,0) SALDO_DOLAR_ANT,
      ISNULL(
      (SELECT SUM(DEBITO_FISC_LOCAL-CREDITO_FISC_LOCAL) SALDO_LOCAL FROM ME.CROMSA.SALDO S WHERE S.CUENTA_CONTABLE = C.CUENTA_CONTABLE AND CONVERT(CHAR(6),S.FECHA,112) &lt;= CAST(D.PERIODO AS VARCHAR(6)))
      ,0) SALDO_LOCAL_ANT
  FROM [PORTAL].[dbo].[BALANCE_DEF] D LEFT JOIN 
        ME.CROMSA.CUENTA_CONTABLE C ON D.[U_ORDEN_EEFF] = C.[U_ORDEN_EEFF]
  Where periodo = 2018" OnSelecting="SQLCompras_Selecting">
    </asp:SqlDataSource>
    <dx:ASPxPivotGridExporter ID="ASPxPivExp1" runat="server" ASPxPivotGridID="PivotCompra">
        <OptionsPrint MergeColumnFieldValues="False" MergeRowFieldValues="False" PrintHorzLines="True" PrintVertLines="False" VerticalContentSplitting="Exact" PrintFilterHeaders="False">
        </OptionsPrint>
    </dx:ASPxPivotGridExporter>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM [erpadmin].[PRIVILEGIO_EX] P, erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <dx:ASPxPivotGrid ID="PivotCompra" runat="server" ClientIDMode="AutoID" DataSourceID="SQLConta2" Theme="Office365" ClientInstanceName="PivotCompra">
        <Fields>
            <dx:PivotGridField ID="fieldCIA" Area="RowArea" AreaIndex="0" FieldName="CIA" Name="fieldCIA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldORDENDATA1" Area="RowArea" AreaIndex="1" FieldName="ORDEN_DATA1" Name="fieldORDENDATA1">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldORDENDATA1TIT" Area="RowArea" AreaIndex="2" FieldName="ORDEN_DATA1_TIT" Name="fieldORDENDATA1TIT">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldORDENDATA2" Area="RowArea" AreaIndex="3" FieldName="ORDEN_DATA2" Name="fieldORDENDATA2">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldORDENDATA2TIT" Area="RowArea" AreaIndex="4" FieldName="ORDEN_DATA2_TIT" Name="fieldORDENDATA2TIT">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldORDENDATA3" Area="RowArea" AreaIndex="5" FieldName="ORDEN_DATA3" Name="fieldORDENDATA3">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldORDENDATA3TIT" Area="RowArea" AreaIndex="6" FieldName="ORDEN_DATA3_TIT" Name="fieldORDENDATA3TIT">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSALDODOLARANT" Area="DataArea" AreaIndex="0" FieldName="SALDO_DOLAR_ANT" Name="fieldSALDODOLARANT" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSALDODOLAR" Area="DataArea" AreaIndex="1" FieldName="SALDO_DOLAR" Name="fieldSALDODOLAR" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCUENTACONTABLE" FieldName="CUENTA_CONTABLE" Name="fieldCUENTACONTABLE" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCRIPCION" FieldName="DESCRIPCION" Name="fieldDESCRIPCION" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPERIODO" FieldName="PERIODO" Name="fieldPERIODO" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSALDOLOCAL" FieldName="SALDO_LOCAL" Name="fieldSALDOLOCAL" Visible="False" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldSALDOLOCALANT" FieldName="SALDO_LOCAL_ANT" Name="fieldSALDOLOCALANT" Visible="False" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUORDENEEFF" FieldName="U_ORDEN_EEFF" Name="fieldUORDENEEFF" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="VAR" Area="DataArea" AreaIndex="2" Name="VAR" UnboundExpression="[SALDO_DOLAR] - [SALDO_DOLAR_ANT]" UnboundFieldName="VAR" UnboundType="Decimal" CellFormat-FormatString="#,###.00" CellFormat-FormatType="Numeric" GrandTotalCellFormat-FormatString="#,###.00" GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="#,###.00" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="#,###.00" ValueFormat-FormatString="#,###.00">
            </dx:PivotGridField>
        </Fields>
        <OptionsPager ColumnsPerPage="20" NumericButtonCount="20" RowsPerPage="20">
        </OptionsPager>
    </dx:ASPxPivotGrid>

      
             </asp:Content>
