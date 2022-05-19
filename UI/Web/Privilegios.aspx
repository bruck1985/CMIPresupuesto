<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Privilegios.aspx.cs" Inherits="UI.Web.Privilegios" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Privilegios por Usuario"></asp:Label>
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
                    <dx:LayoutItem Caption="Seleccione Modulo" ColSpan="1" Name="CBModulo" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="CBModulos" runat="server" DataSourceID="DS_Modulos" EnableTheming="True" TextField="nombreaccion" Theme="SoftOrange" ValueField="Accion" Width="250px" OnSelectedIndexChanged="Lform_E4_SelectedIndexChanged">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Seleccione Usuario" ColSpan="1" Name="CBUsuario" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E4" runat="server" DataSourceID="DS_Usuarios" EnableTheming="True" TextField="NOMBRE" Theme="SoftOrange" ValueField="USUARIO" Width="250px" OnSelectedIndexChanged="Lform_E4_SelectedIndexChanged">
                                </dx:ASPxComboBox>
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
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLPrivilegios" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="PORTAL.[dbo].[PORTAL_PRIVILEGIOS_SHOW]" SelectCommandType="StoredProcedure" OnSelecting="SQLCompras_Selecting">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="CROMSA YYYY" Name="PCia1" SessionField="lista_ci_scia1" />
            <asp:SessionParameter DefaultValue="JMZ" Name="PUsuario" SessionField="CBUsuario_priv" Type="String" />
            <asp:SessionParameter DefaultValue="-1" Name="PModulo" SessionField="CBModulo_priv" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxPivotGridExporter ID="ASPxPivExp1" runat="server" ASPxPivotGridID="PivotCompra">
        <OptionsPrint MergeColumnFieldValues="False" MergeRowFieldValues="False" PrintHorzLines="True" PrintVertLines="False" VerticalContentSplitting="Exact" PrintFilterHeaders="False">
        </OptionsPrint>
    </dx:ASPxPivotGridExporter>
                <asp:SqlDataSource ID="DS_Usuarios" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand='SELECT &#039;%&#039; USUARIO
      , &#039; Todos&#039; NOMBRE
union all
SELECT USUARIO
      ,USUARIO + &#039; &#039; + NOMBRE NOMBRE
  FROM [ME].[erpadmin].[USUARIO]
  where activo = &#039;S&#039;
order by 2'>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="DS_Modulos" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand='Select -1 Accion, &#039; Todos&#039; nombreaccion
union all
select Accion, nombreaccion from erpadmin.accion where esmodulo = &#039;S&#039; order by 1'>
                </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + ' ' + c.nombre nombre
  FROM [erpadmin].[PRIVILEGIO_EX] P, erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or ('PortalRep' = REPLACE(@PUsuarioCia, CHAR(10), ''))) and P.[ACTIVO] = 'S' and P.conjunto = c.conjunto
order by 2">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="nombreUsuario" Size="200" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <dx:ASPxPivotGrid ID="PivotCompra" runat="server" ClientIDMode="AutoID" DataSourceID="SQLPrivilegios" Theme="Office365" ClientInstanceName="PivotCompra">
        <Fields>
            <dx:PivotGridField ID="fieldCIA" Area="RowArea" AreaIndex="0" FieldName="CIA" Name="fieldCIA">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldMODULO" Area="RowArea" AreaIndex="1" FieldName="MODULO" Name="fieldMODULO">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCIA1" Area="DataArea" AreaIndex="0" FieldName="CIA" Name="fieldCIA1">
            </dx:PivotGridField>
<dx:PivotGridField FieldName="ACCION0" Name="fieldACCION0" ID="fieldACCION0" AreaIndex="1"></dx:PivotGridField>
<dx:PivotGridField FieldName="ACCION1" Name="fieldACCION1" ID="fieldACCION1" AreaIndex="2"></dx:PivotGridField>
            <dx:PivotGridField ID="fieldACCION2" AreaIndex="3" FieldName="ACCION2" Name="fieldACCION2">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldACCION3" AreaIndex="4" FieldName="ACCION3" Name="fieldACCION3">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldACCION4" AreaIndex="5" FieldName="ACCION4" Name="fieldACCION4">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldACCION5" AreaIndex="6" FieldName="ACCION5" Name="fieldACCION5">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldACCION6" AreaIndex="7" FieldName="ACCION6" Name="fieldACCION6">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCACCION1" Area="RowArea" AreaIndex="2" FieldName="DESC_ACCION1" Name="fieldDESCACCION1">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCACCION2" Area="RowArea" AreaIndex="3" FieldName="DESC_ACCION2" Name="fieldDESCACCION2">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCACCION3" Area="RowArea" AreaIndex="4" FieldName="DESC_ACCION3" Name="fieldDESCACCION3">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCACCION4" Area="RowArea" AreaIndex="5" FieldName="DESC_ACCION4" Name="fieldDESCACCION4">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCACCION5" Area="RowArea" AreaIndex="6" FieldName="DESC_ACCION5" Name="fieldDESCACCION5">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldDESCACCION6" Area="RowArea" AreaIndex="7" FieldName="DESC_ACCION6" Name="fieldDESCACCION6">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldUSUARIO1" FieldName="USUARIO" Name="fieldUSUARIO1" Area="RowArea" AreaIndex="8">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNOMBRE1" FieldName="NOMBRE" Name="fieldNOMBRE1" AreaIndex="0">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldID" FieldName="ID" Name="fieldID" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldPARENTID" FieldName="PARENT_ID" Name="fieldPARENTID" Visible="False">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldNIVEL" FieldName="NIVEL" Name="fieldNIVEL" Visible="False">
            </dx:PivotGridField>
        </Fields>
        <OptionsPager ColumnsPerPage="20" NumericButtonCount="20" RowsPerPage="20">
        </OptionsPager>
    </dx:ASPxPivotGrid>

      
             </asp:Content>
